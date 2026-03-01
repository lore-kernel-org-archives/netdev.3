Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947E2F7ADE;
	Sun,  1 Mar 2026 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330018; cv=none; b=Xsn3UDo7pMZQM4ogoVUeLR4IZSILxPXNWI0jDHImsEilyaT9bEf2G7LoRMoSl9/5FWfTIYPvGxTFBOOgFzlT/nOXHUS9v95YlarYS4818bEPI1sV+KhiQCJLva7MdG64KPxoD/jKe06I7tnU5h57ziB6ACxyDfbpjyvRw9p7J14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330018; c=relaxed/simple;
	bh=PciDdKfLXuQkAHYWA1nMm6Sh5dpuTfADm5btrykWs7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odS9quYdY9wMXP6fP405b+txIk+kVMokkTSRb9q3R774CBsmRV3hwAchRuiiRtq0mDAEPI4O/bCJP/AloEF5/DdWl8y0no3tMuhwV4p67JwsoDrbLnBuHJplIF0Tzunp15791dtGi64Uvsv99flE59xwfaH2TBYDYuMHNsQ09K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxjM9uW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxjM9uW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259CDC19421;
	Sun,  1 Mar 2026 01:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330017;
	bh=PciDdKfLXuQkAHYWA1nMm6Sh5dpuTfADm5btrykWs7s=;
	h=From:To:Cc:Subject:Date:From;
	b=uxjM9uW4ygvKGkUt11Hc9iQuRWN9pBbJvuHv8zhP+bFM/9pG26maC910TQrYtB08A
	 UBojxIpsOhKPMkNENzYAAhFtP3V865m1hxqd6wJic6dryqrLs8fGDG4z9HL+X6+6RQ
	 KNIWxxUfQM53YvAmN39OGX4dnbwPoo7JegpZEzTgiy6cU4hNmb+UfBmBU23Hdn0qtU
	 6m8+q7Un4eEvTZ8VnKV0fjcLaHI2flGAEnRaQwnkwdolDxUVWxZ2JyBf6fO++Qbg8v
	 7K8rnDP1+udmjrK6qOT4TENUrsXlIzqmcaROF6Xf1Vdq950JvHHB5biFcAqW1mG8v1
	 i9dF+7VrvdEEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hodgesd@meta.com
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: FAILED: Patch "tipc: fix RCU dereference race in tipc_aead_users_dec()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:35 -0500
Message-ID: <20260301015336.1720415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a65c0cb0ff20b3cbc5f1c87b37dd22cdde14a1c Mon Sep 17 00:00:00 2001
From: Daniel Hodges <hodgesd@meta.com>
Date: Tue, 3 Feb 2026 09:56:21 -0500
Subject: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()

tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
in 'tmp' for the NULL check, and again inside the atomic_add_unless()
call.

Use the already-dereferenced 'tmp' pointer consistently, matching the
correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
Link: https://patch.msgid.link/20260203145621.17399-1-git@danielhodges.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tipc/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 970db62bd029b..a3f9ca28c3d53 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -460,7 +460,7 @@ static void tipc_aead_users_dec(struct tipc_aead __rcu *aead, int lim)
 	rcu_read_lock();
 	tmp = rcu_dereference(aead);
 	if (tmp)
-		atomic_add_unless(&rcu_dereference(aead)->users, -1, lim);
+		atomic_add_unless(&tmp->users, -1, lim);
 	rcu_read_unlock();
 }
 
-- 
2.51.0




