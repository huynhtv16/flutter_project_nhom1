<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Reward;
use App\Models\UserProgress;
use Illuminate\Http\Request;

class RewardClaimController extends Controller
{
    public function claim(Request $request, $id)
    {
        $user = $request->user();
        $reward = Reward::findOrFail($id);

        $progress = $user->progress;
        if (!$progress) {
            $progress = UserProgress::create(['user_id' => $user->id]);
        }

        $claimed = $progress->claimed_rewards ?? [];
        if (in_array($reward->id, $claimed)) {
            return response()->json(['message' => 'Already claimed'], 400);
        }

        // Add reward points
        $progress->total_score = ($progress->total_score ?? 0) + $reward->points;

        $claimed[] = $reward->id;
        $progress->claimed_rewards = $claimed;
        $progress->save();

        return response()->json(['message' => 'Reward claimed', 'total_score' => $progress->total_score]);
    }
}
