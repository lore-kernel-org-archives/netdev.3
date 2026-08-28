Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D63EC80D
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906747; cv=none; b=DEY9vkQ9ZRxHSF4SRI6WbTiytDY+sXGqaHhUz2KtlZKdFGYVCdHAllIJceKk4Q/mRkLnPfFNCu5fe6dG6CezY5a9lj0jYAUfeJgtL+kdPJorDBxCMSfuRNQtDVm7asuULODromgcCdBSqH+8QVN8cxcdOBXcIlLyi4ONElKTa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906747; c=relaxed/simple;
	bh=YGL+8Ca4jZUObe1okovXlElB9inL2PP2Hl29vDu5III=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i9rt1/KMEVogsyrMcfjVEEyb9JMCqEh0A7h3uHXsf3VchSNn+mwx868NRCUCyjD1vxXNkPP6N7KUeEOyaOWx5FMz1wn/1if5uuvOZLyN5rki9hTnZRZEo3uH33Oztd+M+zv3wlfVQKASg/WUv+kSlauTWPBysquYkBNHYy1Gez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNMaiVsh; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNMaiVsh"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e38fbc5so68697985a.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906743; x=1788511543; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viywTkSRIcigYeB9qBwDmmT+rt0pzoc2K5Tui7iRFMw=;
        b=UNMaiVshPJomdxV3KekNtFtOZHjFpg6biziABN/iOV+1+w69XlgQ1sqTxx6debzB/u
         qrZniJ+lmQtjpGedZ4TKuat5ZbfERwqofw1W8z7dksR0NLH8b4c/J25JRKFgI8S9I8jL
         qQCYjUOPChScQCLXkWHbtU8FjAkGn3VlCnOUIZ3v1HM85E78U4FzACzbKTq088G+iv3m
         R0x5x1Qyg7T7VKZZTT/n4r32MHMG7QV71WaFYHWlqdm7X7PTDr+Tp7qVpUUbecTRZ1it
         RdChtx9QRt3D5iMhiRY83SKdKRoST7PUH82Kngk7b/ybpDhmqekJ6ig6PC7MKUmKfPve
         kSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906743; x=1788511543;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=viywTkSRIcigYeB9qBwDmmT+rt0pzoc2K5Tui7iRFMw=;
        b=pNvJKc+vyK6ccIpUwGuP5/WhWhkGQ/iRDjs21QlcZKpshIQNaRd1sIhFNMJZNH3Gyh
         fif4r3U/NZnt9dmETuET2BlD0uJGX/QOnZXpl5p1kwIeKtHC2o5nbmsbmly9r2vzbfme
         MsX4NQO+fTuDEL4DUE49w11oTO72In/v2DNVepVmxIosZklrwMIIeJ9gH3j6IcyFJbf5
         wM/6AfU+EcIrXq/1e0pzRfJrYJkoZJj1P94j7+zt4l7b15OH6HYCmQPSQgGKb00B2I2o
         jT9CzEI2i3r7ZFOyUQQ8MQ0BX5YGhv6iTYIyFoDkAEvEngX8lYXRMJ3S7XsT2yMcWFoq
         7RTA==
X-Forwarded-Encrypted: i=1; AHgh+Rqi9k6a4HMZkDHSpacfEtwAvT0uwUAooyP1epKrpY5BmoNdrs7+ZD1VB5HMvPvsPr8p3e6hnEk=@vger.kernel.org
X-Gm-Message-State: AFuF++myB/oDzlTM1qmT9Eiut9glxJ45mZ47EB5MzfXL3mLnII8qH072
	7FG4gjWFum4XwtFUKXekz0ednU1L6ghN4SQBWJbGLh1HTmA1rVHUGlk/yF65NHB4uVqkJDfg0fq
	PbQdOGXX9oEVr1Q==
X-Received: from qkcax15-n2.prod.google.com ([2002:a05:620a:6e4f:20b0:92e:535f:a6b1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:27d4:b0:930:adac:1e99 with SMTP id af79cd13be357-93913988103mr557075385a.38.1787906743280;
 Fri, 28 Aug 2026 01:45:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:45:29 +0000
In-Reply-To: <20260828084531.1826790-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828084531.1826790-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828084531.1826790-4-edumazet@google.com>
Subject: [PATCH v2 net 3/5] ipv6: mcast: fix delay calculation in igmp6_join_group()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When joining a multicast group, if a report work is already pending
(e.g. scheduled by a query or a previous join), igmp6_join_group()
cancels the delayed work and recalculates the delay:

	if (cancel_delayed_work(&ma->mca_work)) {
		refcount_dec(&ma->mca_refcnt);
		delay = ma->mca_work.timer.expires - jiffies;
	}

Unlike igmp6_group_queried(), igmp6_join_group() did not check
if delay >= interval. This leads to two issues:

1. If the timer has already expired (timer.expires <= jiffies), the
   stale expiry is reused by mod_delayed_work(), causing the second
   unsolicited report to fire on the very next tick without a
   randomized delay.
2. If the timer was originally armed by a query with a large
   maximum response delay, delay could exceed
   unsolicited_report_interval(ma->idev).

Fix this by initializing delay to unsolicited_report_interval(ma->idev)
and re-randomizing it with get_random_u32_below(interval) when
delay >= interval, mirroring the logic in igmp6_group_queried().

Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
---
v2: refined the changelog

 net/ipv6/mcast.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 66f5858e5fea68e27da1f857b5596808632618a3..4423b90dc9abffff9661da22caa4b9e2f618def7 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2639,7 +2639,7 @@ static void ip6_mc_clear_src(struct ifmcaddr6 *pmc)
 
 static void igmp6_join_group(struct ifmcaddr6 *ma)
 {
-	unsigned long delay;
+	unsigned long delay, interval;
 
 	mc_assert_locked(ma->idev);
 
@@ -2648,13 +2648,17 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 
 	igmp6_send(&ma->mca_addr, ma->idev->dev, ICMPV6_MGM_REPORT);
 
-	delay = get_random_u32_below(unsolicited_report_interval(ma->idev));
+	interval = unsolicited_report_interval(ma->idev);
+	delay = interval;
 
 	if (cancel_delayed_work(&ma->mca_work)) {
 		refcount_dec(&ma->mca_refcnt);
 		delay = ma->mca_work.timer.expires - jiffies;
 	}
 
+	if (delay >= interval)
+		delay = get_random_u32_below(interval);
+
 	if (!mod_delayed_work(mld_wq, &ma->mca_work, delay))
 		refcount_inc(&ma->mca_refcnt);
 	WRITE_ONCE(ma->mca_flags, ma->mca_flags |
-- 
2.55.0.897.gb25b4bd76c-goog

