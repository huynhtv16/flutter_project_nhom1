<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('user_progress', function (Blueprint $table) {
            if (!Schema::hasColumn('user_progress', 'claimed_rewards')) {
                $table->json('claimed_rewards')->nullable()->after('favorites');
            }
        });
    }

    public function down(): void
    {
        Schema::table('user_progress', function (Blueprint $table) {
            if (Schema::hasColumn('user_progress', 'claimed_rewards')) {
                $table->dropColumn('claimed_rewards');
            }
        });
    }
};
