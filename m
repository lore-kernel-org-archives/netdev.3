Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EF3AEB35
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477653; cv=none; b=sbTT/PM/rF+RAyCzDQCf0UhSMJhQ+E0nALI5JfoXpMUChoSwPI1UCg0DqpI/KofGOSZg/sC6QtX22woDfSMvHrOnyr6e6CUEw2r9qXH6LyOF+AfSnV50uwYzNHdH6/fArtbREXkLRAGcAHIz/NrbE17UyzDBpBd1pGBAIbff3+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477653; c=relaxed/simple;
	bh=imWuqE76DrVJWZgCKyCFc7MWU5CZeZEyrJt3Q6oHClQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djJ1oSSJlC0Td0ecCAEF2Pno/7A7MJgBcwauGKRMYCjwq9O1/o6PNP44ESNmPFMLmSYLagcbl8Nt6HGPAhqnEkvXdVjKECVC2apl56tuaCFYBB0M70Ss/h2hKyjXoVKGpbVsNLNPnF61epX3sICBpSGKhQboO/HjFoayg+I4S6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+CYnki3; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+CYnki3"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so1403901fac.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791477650; x=1792082450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HXq065e6nI28MxLdaLNxE40ltfZ0a3n1jeYu75IbvbU=;
        b=K+CYnki3ljfXAE3w7bhJEn7+yVxxIJgBa/NrLODm4Fs9gBhHngPjEkPCoRRNL3GzYn
         Vkb6dSVIjQF9gu0GRky5QNjkoxu3Qy3wl35CTm4INWra1fET4e45I/99XIoT/nO3v9G/
         NTLvR6CUsayYkNzzrIW7Mid7vXHbtkGE67J8OhSAg9QHf8h39kqJtJZmy3kfAIIKSxm6
         48KgYM/2beDck1BkkXfPRneMA6rhjZUkdXFVVkbuvozVpELS/4bA7h7UEoP9VKrHYORZ
         RFYx1DoqrgJLn8M33tYKAmA6rkuP2Qjg+5Lk9p7MfXIpKN4eOEWDYDcBn8S3xC4qWuOX
         qUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791477650; x=1792082450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HXq065e6nI28MxLdaLNxE40ltfZ0a3n1jeYu75IbvbU=;
        b=A5WDYiEJiGe2LPbQtjCgg5lX6ZTyAKe+rx5KRSAeaaxdfktjjC2zjQog/5MVe+PXoi
         g2tLWsnrrnMqtU+xj+pCI2Ml3pE+O9lwGlHAd7rb/yCk3aiuOBLEwxoOOgB2R6St1qf4
         Lq+M8HMhxc/xgE5p0udzP7PpnZKuWzDDPkpu4en9PAY+CncT9jam1HuYR0chVGSqfYOx
         FnZ5OGD1LWcEmV2JFnYr8ZKqDM94l++3/Y070YWD0DYPNPDW3B+oHCbwxt4r39aIjg6R
         Xy6HH3Fjr6mZA3j0/z0BOqW05JN76gDeFxd5N6t5oweL4SVz0o9vRTXUEZXwH9LfTQJL
         tjTA==
X-Gm-Message-State: AFuF++lg5GAPZI4OmJjN+EBEW7yY5WrecPktBmHaLSwm8e82WV7J7reC
	jLtdnQPiMpx3FVcyFCkDB8mvxzSPH2mmrCKBgyz0mv5WhQuniicY+QLM
X-Gm-Gg: AYBFou0+LUh1FBGNThaje4BObPNMDwOts6GIQkTO78PyX0PLRRXdlTUqzsZDsBIPaNV
	6IoIN5xAoGsbK3LmRUL7RHeyVEbZrV9XpUJsNyil+Vevpx8Si7p98uhL4oigofdWwEAKAH6eHHO
	PxM2S0NR+TeUVjSw7hInM9SPQXPCJ6NGnoebfP4eeV0gR0XqIqLNG0iIw2lteU5GHMGJb7yH09y
	CgqOY+5QFSyKcq/FOHfgqIXXw9ASgeIA5rU8paTNfInW5gIsVBAOcg9bQbGICMHiVYaKeZ3KkEd
	cjztLp9VNBej50LRYeH4Pidd1TOOgQUldLGAiYkx7j3GJo13pqrDeZoWlr2ATtc0dMAP2m7txmU
	xoF21hxcVSMS2wkCsxaxc6648KpNXh8Jg17HKeaKUpHk9pj8zXXEYK3BQ9kGcWXpSeQ4fFEM9F4
	LVFUxtglKplc2WkKFQG1sEBHDG3WTtZZ4IJ9Ha0ub8uOlOUs/055DFJt8sZsW896UpBilpTfNLE
	QTyRyxh38tAXm35VORdTiEp6mvvr5Z4xMX4uw==
X-Received: by 2002:a05:6870:568b:b0:475:e0a7:9f2f with SMTP id 586e51a60fabf-4a2595b8b6cmr5129058fac.29.1791477650369;
        Thu, 08 Oct 2026 09:40:50 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a274ca5a26sm3560744fac.17.2026.10.08.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:40:48 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rds: fix out-of-bounds conn_path walk in peer gen update
Date: Fri,  9 Oct 2026 00:40:41 +0800
Message-ID: <20261008164041.961961-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A connection on the IB transport (t_mp_capable unset) is allocated
with exactly one rds_conn_path slot, yet the peer's genetic number
update routine is hardcoded to walk RDS_MPATH_WORKERS entries whenever
the peer announces a non-zero gen number that differs from the one we
cached.  Everything past the first entry lands on whatever happens to
follow the single-slot array in the same slab slot group, and the loop
then reads and modifies struct fields there (lock acquired,
cp_next_tx_seq cleared, retransmit list inspected).  A malicious peer
can therefore force consecutive out-of-bounds writes into neighbouring
kmalloc-512 objects (KASAN: "Write of size 4 in
_raw_spin_lock_irqsave").

The allocation and the walk now agree on the same expression
(trans->t_mp_capable ? RDS_MPATH_WORKERS : 1), so the loop can never
outlive the array regardless of what the peer reports.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: ba3d1f480c7a ("net/rds: size a connection's path set by the transport it ends up with")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rds/recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -144,7 +144,8 @@
 	if (peer_gen_num != 0) {
 		if (conn->c_peer_gen_num != 0 &&
 		    peer_gen_num != conn->c_peer_gen_num) {
-			for (i = 0; i < RDS_MPATH_WORKERS; i++) {
+			for (i = 0; i < (conn->c_trans->t_mp_capable ?
+			     RDS_MPATH_WORKERS : 1); i++) {
 				struct rds_conn_path *cp;

 				cp = &conn->c_path[i];
--
2.43.7
