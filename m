Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34042EEE67
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452079; cv=none; b=g8sblAzdIG4VTtpHcHJ4HxAYHYRKzlaFG2+9irdjEYhMCgxxxAQmlaiJ9Pf3jQgDzYDgUwF2f7erQbEd7Rbu+lP2y+zywdpHDa1ylXvhgaoEROpiy6tMrsLeeV5hjFIec9eHmeX7VQ8CIffTtKF/EiuyLchkBwU3V841fnKwVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452079; c=relaxed/simple;
	bh=+R25Kq4vOwxOSXT2QysxGbcz+cLNKHnIq+ZdszX6sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdKUKX5QR2cmugCWDjX0WpqR+Tt0xT4gMJTApcKGQMwTqESroQvwe+XM76JnKTf4MWbEf2+Ye6xRZXxLI06YsH4R07GrGhR+jRLQNUhdQjvpRAu4xuEZrCgEa4crSIKebhUME+5iCcBf7A9FTlqJ6ELMzgAcTLy0+T3xgE+U8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ffCfIX+y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ffCfIX+y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3057226b3a.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786452077; x=1787056877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g63xNZ3Zwl+FVKt8jElgdMcBtusg/4WgARvVl/fpntM=;
        b=ffCfIX+yK/Pyypvq5DydS68vFVCcjtIdJZStP6MTzLwYDUKKRXqrXHrAtXQ0Kf4itY
         xWebHVOHeKK6PPga1map852qjY6sAt/hpzQmrKr5e8PVEUS8xOSZAaiR+zNMxhbdbf5N
         gz38S2tpNRT+Y9vhuu4fN9DRhAgyIVWbMaXVaJrlK2+iaBJLaaQ53/+wa7bSYS0S0dX/
         491HSRJ48mFiv5kf48V6AAwONZb0OTP2kfd1x45Tmgz95CdZHI8l122NsyNoxNi4Hk+k
         Wi1JsKkdG3fOLKtuZ31RamlD0i05vUzKF53asFH8sJ4w3W6r9EErenQKkJellrOGVmDS
         gQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452077; x=1787056877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g63xNZ3Zwl+FVKt8jElgdMcBtusg/4WgARvVl/fpntM=;
        b=cojNfyn+bNySL850qoCtS00GcqJLGCAEEZWsbWk4M98reGc35QpcWBUQ7r8Usg6yVh
         dZYdJl9w1JUyREeB1EC0pFCUeV+HbY/RFTMQQM6eWd7bcJn2x3JsYGfGWz9QGXXmhRoS
         O/FsyNme0U+6WX8375TdTXZqrj5EUEftTst78jWsjxelpMNaczfmhqUMXqitzLQi+beA
         Rjjs8Ao0Pz1sRr9yjB/03zzKH2EQriXp6qy41wkKg/+8cDSHz6p0zRNFpVVV0McEka5D
         /bB3pZ4Z2pffm9aW+rHfPe94SUQx03N7aRQLde50e2rayo+uCAH4NxRyTxq7xkfUv+3P
         rIXw==
X-Gm-Message-State: AOJu0YzMkDSqeWefljSiBOQKULwpp7ZMnyVfEtSxgVIuRWHowYxg67MC
	lpUzOACe6UAFJXsD8qP6vOxcwZ/LhezDjF0D7JZmtqRtOFVQhCbTvFWZS+WRpZ7QuyEAeVhXYeg
	C1BWue0kQ
X-Gm-Gg: AR+sD119J3kTUhfYkwVIov9ekUGAWAWPG3kPQte/BAFfLEXF9l6w4BWwQhAKGzC2Jp2
	qVYKhaathjANTv+74V8PW/l116dVX3dj9c+dCjrMtx9elUJG6J6L6ADtjbzd50hF2fQJGiHqYSj
	xhMZ0FotDSMsWbcSAh1Ck57DHtv+7tdW0DY7BqTDFVfatpUwD3O9+qGS0jJrATmx7ghxvY1raZD
	0u7Jpay5khKwQbrKL9GEtnhq0rL938hVvpOO8/oAwsDdSYBo6jMIXYGpvq+QnvrkJWNblLKmrpy
	BDgwfzCVFcDH9iQlVrG9qESnUULvcrhmnDhYl2Syu0zkz8B4zwB7LrskOYZD+ovCsVVEGj7jgBk
	fx9+0GhWHHDRtkxt0wPkk1NJ6j75yHKxkHipj7/Iw0QlN5s3FE+VE0LnbVbNwrIfreg8GDJs+bJ
	KcugV5fWopE6Bm2WVxO/TTMNC9JEoswMpeibR+ltTqM1nAfc0sYWNcwykNYbsMbVIfsS9B8rF+s
	oVJ
X-Received: by 2002:a05:6a00:180d:b0:847:926c:582c with SMTP id d2e1a72fcca58-84fa8842a46mr2885913b3a.29.1786452076750;
        Tue, 11 Aug 2026 05:41:16 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9195531sm715681b3a.3.2026.08.11.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:41:15 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] ipv6: flowlabel: cap duplicate leases per socket
Date: Tue, 11 Aug 2026 20:40:53 +0800
Message-ID: <528bc30d301bcf32aca37cda1933b617d2d295f4.1786447968.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786447968.git.zhilinz@nebusec.ai>
References: <cover.1786447968.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
successful GET. The recheck path for a compatible existing flowlabel
links another lease without applying any lease admission check. Repeated
GET requests for one shareable label can therefore grow a socket's lease
list without bound.

Count matching leases during the existing socket-list lookup and reject
a new unprivileged lease once that count reaches FL_MAX_PER_SOCK. The
IPv6 sockopt lock serializes the count with fl_link() and PUT, so no
global ip6_fl_lock is needed. New-label admission remains under the
existing mem_check() policy. CAP_NET_ADMIN callers remain unrestricted
and stop after the first matching lease.

Do the check before updating linger and expires. A GET that cannot add
its lease returns an error without refreshing the shared label, matching
the existing socket-list allocation failure path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Count only leases of the flowlabel being reused.
- Fold the count into the existing socket-list lookup.
- Keep new-label admission under the existing mem_check() policy.
- Stop after the first matching lease for CAP_NET_ADMIN callers.
- Explain why a rejected GET does not refresh linger or expires.
- Correct the reuse-path explanation and trim the Fixes hash.
- v1 Link: https://lore.kernel.org/all/cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai/

 net/ipv6/ip6_flowlabel.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24f..55cc5ec485c59 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -617,6 +617,8 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
 	struct ip6_flowlabel *fl, *fl1 = NULL;
 	struct net *net = sock_net(sk);
+	bool cap_net_admin = false;
+	int dup_count = 0;
 	int err;
 
 	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
@@ -652,10 +654,14 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 					rcu_read_unlock();
 					goto done;
 				}
-				fl1 = sfl->fl;
-				if (!atomic_inc_not_zero(&fl1->users))
-					fl1 = NULL;
-				break;
+				if (!fl1) {
+					fl1 = sfl->fl;
+					if (!atomic_inc_not_zero(&fl1->users))
+						fl1 = NULL;
+					cap_net_admin = capable(CAP_NET_ADMIN);
+				}
+				if (++dup_count >= FL_MAX_PER_SOCK || cap_net_admin)
+					break;
 			}
 		}
 		rcu_read_unlock();
@@ -679,6 +685,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
+			/* sockopt_lock_sock() serializes the count and fl_link(). */
+			err = -ENOBUFS;
+			if (dup_count >= FL_MAX_PER_SOCK && !cap_net_admin)
+				goto release;
 			if (fl->linger > fl1->linger)
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
-- 
2.43.0
