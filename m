Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22D4499A4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344370; cv=none; b=V6W5T+gne2+zOxJ5mU1PBbmB/tpxAYeCSl+YD61pMc0MzQGBvxi8b/l/Qx0veh/oWTXuHvOpy0Ubv6WLYh0I154BjeHMIlpsaJKDcQIq4nIWS7E7he8YgiWvx0Svngp6xfhNPq1oOQiEonQawbDBgNKJCzt+oyZB6/pbEwnH8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344370; c=relaxed/simple;
	bh=8QVK/nMxrqCW2sBHW+NZzwbuVpYtyVRH3iDYjUCT38Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEc+y0nJattd8sqn47WLD0NNuOOSLGUlYKmQ2R1iUZXNJoFzoWRecBQga9TnY9s5sEJRh5gPhpmipp0bFBtz/ox+TvlS029PsFFGgattHoVR2LF5C+Pq2VP8DuTS0sGu1VGURJFRgMQB6c5psdDO8Y+mpdMKOQxDj1z9OD9KrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnpLqnF2; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnpLqnF2"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0050a554so192597785a.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790344368; x=1790949168; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mx+/4IX/SkYH3xRHrzv5rqSiNbUsf7M4YrhG+ar2tio=;
        b=rnpLqnF2MpWHWFy04SPpJ8bnRdaXwE+uMpPkyZq3t1WvFcxn1E1hmA+qexnwDnAt2V
         thMgRsKY+ZIl8nvwamP6eH5gmbuLnQg2+mjzyg+Td7fPEbFBcBrFrno2SxUcr/Z37yNE
         Jr0yvJPG3rOjXHuQvN33utcMEPErtmFsMPJZNmgcu6cTiIzftfcIDn0ef2vleiVOAPun
         s28sIM+polLH3Mmj6v1Ts2UPugF2clH73rk+vAnGuWSp4+66/2ce3mRYxS9CBwimksB3
         UfLC/YpTLTwsfnToNruu34kbq90v3Yxp7/Gp0sJ4wVxiAk98qc/wFGiEDaw3y1co/kE4
         DTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790344368; x=1790949168;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mx+/4IX/SkYH3xRHrzv5rqSiNbUsf7M4YrhG+ar2tio=;
        b=1Nt57kaAHzhx00YHDuRZezhtk6fbRYQFE/D0TpZQXLFctdVvSZt97Bx75vl2ze+Bdm
         gZ5PlyOkf3IWXo/cdPAgd6Khb7xSMKVDr9JTh2tes2p5T0nsY8DFCQrCqcEosxRzH1Wc
         GHLFoPS6VsYGISCdvTg82cq0mdz3UY7nzIl6YmTygMtlSyJBMncj5NGxFeSnZV+RpvFr
         t7x8fuNITNVTirA312TJKPKl3mGSpEHLnNtdG6zgmzqkZzzaXE2pnqLvtcxxFtQ8qI+2
         LHIXTnrId2ZOWHyTWgpyWS0rzbG1sQ9mgUabBR5yl6hvxPblN+B0tPSOW5xo1FzXWokD
         KGbg==
X-Forwarded-Encrypted: i=1; AKwUvBwJ+qcLtcZTjfCRen9EnGhXE4R2cXVtn/0b51pRBhY5ZqEieidsW/xGbJbc4yHqxk9/5tLtFfs=@vger.kernel.org
X-Gm-Message-State: AFuF++kEDgvLFijlfPGmVSRwvtu4OMcmQcr2GCJPe/M6S5EUM8c50QWg
	sXtzKejdW8U7du0Nw+NpiNcnhxLwAoGBJJRORvKuf26fjSurrMRdN6KCGUlBGG68rKUNoI049eX
	+UYsGHJPfVzDPxg==
X-Received: from qkoa14.prod.google.com ([2002:a05:620a:2ee:b0:93c:3e99:b018])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6498:b0:93c:1710:78cb with SMTP id af79cd13be357-93c43be0c74mr405251285a.24.1790344367793;
 Fri, 25 Sep 2026 06:52:47 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:52:43 +0000
In-Reply-To: <20260925135244.3715196-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925135244.3715196-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925135244.3715196-2-edumazet@google.com>
Subject: [PATCH v2 net 1/2] net: restrict SO_RESERVE_MEM to TCP sockets and
 cap max value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weiwan@google.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM") and
commit d00c8ee31729 ("net: fix possible NULL deref in sock_reserve_memory")
only checked sk_has_account(sk), which is true for both TCP and UDP
sockets.

However, SO_RESERVE_MEM and sk_unused_reserved_mem() are currently only
supported by TCP:
- On UDP sockets, sk->sk_forward_alloc is protected by
  sk->sk_receive_queue.lock, whereas sock_reserve_memory() and
  sock_release_reserved_memory() only acquire lock_sock(sk). Concurrent
  UDP packet reception/release and setsockopt(SO_RESERVE_MEM) corrupt
  sk_forward_alloc and memcg accounting.
- udp_rmem_release() reclaims excess sk_forward_alloc without
  accounting for sk_unused_reserved_mem(sk).

Restrict sock_reserve_memory() to TCP sockets (sk_is_tcp(sk)) for now.
Supporting SO_RESERVE_MEM for UDP (acquiring sk_receive_queue.lock and
honoring sk_unused_reserved_mem() in udp_rmem_release()) can be done in
a future net-next series if needed.

In addition, reject val > SZ_1G with -EINVAL in
sk_setsockopt(SO_RESERVE_MEM). Without an upper bound, values near
INT_MAX cause sk_mem_pages(delta) and (pages << PAGE_SHIFT) to overflow
32-bit signed int, corrupting sk->sk_forward_alloc and
sk->sk_reserved_mem. Using a page-aligned cap (SZ_1G) ensures that the
page-rounded sk->sk_reserved_mem reported by getsockopt(SO_RESERVE_MEM)
can always be passed back to setsockopt(SO_RESERVE_MEM).

Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
Reported-by: Cai Xinchen <caixinchen1@huawei.com>
Closes: https://lore.kernel.org/netdev/5a88421d-10ef-4fca-9acb-85a27a3c1173@huawei.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d23333bb4f3fafa19f58095522ef10d918d92496..e8551df8330ff4b1d662b0d0133e20d1f74eb728 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1034,7 +1034,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	bool charged;
 	int pages;
 
-	if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
+	if (!mem_cgroup_sk_enabled(sk) || !sk_is_tcp(sk))
 		return -EOPNOTSUPP;
 
 	if (!bytes)
@@ -1661,7 +1661,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	{
 		int delta;
 
-		if (val < 0) {
+		if (val < 0 || val > SZ_1G) {
 			ret = -EINVAL;
 			break;
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

