Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B93C3792
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740639; cv=none; b=CI21fUubizA7+fJsAvrNImiN0+EfcyCz8kZyu2pAorh3lVNhe4swU4FbXnWLqZnFRGOqytmgEYZtumhnCyV94Nty5g1zcAU8c09CSLeUQ+5UR7NalpmjIWSYZ7QC/d0W6EQ8HSX8q5mkd8Fz+mCr4RJZwk4YrH3KpYr7EUlhIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740639; c=relaxed/simple;
	bh=+a0XK35pBE/l2wSkzkjoF97JdNJyVI7oDioVnoRqTKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gD6qJ8sRoruKv/kgkQY1fuCJ+oyCx1FjUEerbpvhymy3XZiIybaP5SHHL8x4xhGPB1cuEQ4y9J1c6D1B9koRGEH8L0LLfR6adub7qX7V2unuirGqY5jmQMDbo39f1alkMY3IzLFmUKYm5NlHIdt4oYz2+dW9lILoW7pBSxAJ4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umOlSUdh; arc=none smtp.client-ip=74.125.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umOlSUdh"
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66c767e23f6so1874918d50.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787740637; x=1788345437; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zldGY/S9CqZwzd0Ge770JLEJO/BPxXWBviFH3qGjE2I=;
        b=umOlSUdhJ6+tOEf/mkZ/63fbYLyEkhTuGiXj5DluV/eRa5VXwQqiWO6FVJCbCvsNaU
         2ZjIHE7aBHjID7Cyzv/3UkBxxLG7UxxUoALZj5L8c1eGb7ttdIR33YjnL0hwoYdm39xv
         da+YCVEv/8aYkXQFMvoBWKZwvs7P6nnC8tP21M6c+VJbeSMPcSkx/mvL2OWDx/YV0Xq6
         kEx1HHeAmap/vz6fK/jJWwAG/wp79kyZKqwUEyNtAnqsxcQKpuW3nDJ1AW6ps80mSXjs
         ygSL8L4jJ294c2quPQdxJZEmW8KScm6NQ6OU40NUiZKC/eJYmu4sC+LPSGiLOGGC/2RE
         epag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740637; x=1788345437;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zldGY/S9CqZwzd0Ge770JLEJO/BPxXWBviFH3qGjE2I=;
        b=KE7xUBbajCJ9t/8ax8U1i9iSvwUzFRt9g9l8dj0lLf3tuwgLUWKdrbifhiBJJvzVmp
         DdkVX1Cp3CNYM8dIHoWZlAOSk8YJtwH2fejqifI316adIkoEtIO3pKdhPbWoFoXbhhQ5
         LHmA8TaOFJHLCaOoqbxSUVfRyiZrfL80O9/8ViFDOaKEL3YG/pr++IZD+rwueBYASGXz
         d7yqMGla+5sBHG5T3Gulbm5XWjN5b73FZPCcWiEr+8ce35N8io2M/PERLI6FRx0lbMRE
         9DEYCpum39HeC7tAvsrufUfuld3cqrZVZxVixuLihCFBYKoJ/asFMXbZfIeiZRHgNV8n
         NjfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWd8ZLyiDOHnBsCyEmfbcPO1IzEBwsAi6RpCCB1YGBvSlD7CuFW/WtlVkZgc4U5DljtBL1QmM=@vger.kernel.org
X-Gm-Message-State: AFuF++mW03ZMphA1OH5lY54VUS7l0NJA+aK21NdAg06WLh+WiG0JpUTN
	zS6flYBnl3m1oH4wGaHkfFDzM7yCfh7djmM7NIxdH3eidHEIVNkZAhq+CvBzj7XCCoIDAJlkbLh
	k4p7iNaD22Fs5dA==
X-Received: from ywbks6.prod.google.com ([2002:a05:690c:4426:b0:855:de2d:ac24])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:804:10b0:668:9a36:b22a with SMTP id 956f58d0204a3-66d257f0030mr1371626d50.47.1787740637062;
 Wed, 26 Aug 2026 03:37:17 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:37:09 +0000
In-Reply-To: <20260826103711.3302915-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826103711.3302915-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826103711.3302915-4-edumazet@google.com>
Subject: [PATCH net 3/5] ipv6: mcast: fix delay calculation in igmp6_join_group()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When joining a multicast group, if a report timer is already running
(e.g. scheduled by a query or a previous join), igmp6_join_group()
cancels the delayed work and recalculates the delay:

	if (cancel_delayed_work(&ma->mca_work)) {
		refcount_dec(&ma->mca_refcnt);
		delay = ma->mca_work.timer.expires - jiffies;
	}

Unlike igmp6_group_queried(), igmp6_join_group() did not check
if delay >= interval. This leads to two issues:

1. If the timer has already expired (timer.expires <= jiffies),
   ma->mca_work.timer.expires - jiffies underflows to a very large
   unsigned long value (~ULONG_MAX), causing mod_delayed_work() to
   schedule the report weeks/months into the future.
2. If the timer was armed by a query with a large maximum response
   delay, delay could exceed unsolicited_report_interval(ma->idev).

Fix this by initializing delay to unsolicited_report_interval(ma->idev)
and clamping delay with get_random_u32_below(interval) when
delay >= interval, mirroring the logic in igmp6_group_queried().

Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
---
 net/ipv6/mcast.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 40e996f36c37325adee9165ce9842559da039c04..44fdde940dcdcd16a7642b2be60c6866c574ce92 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2640,7 +2640,7 @@ static void ip6_mc_clear_src(struct ifmcaddr6 *pmc)
 
 static void igmp6_join_group(struct ifmcaddr6 *ma)
 {
-	unsigned long delay;
+	unsigned long delay, interval;
 
 	mc_assert_locked(ma->idev);
 
@@ -2649,13 +2649,17 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 
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
2.55.0.860.g4b6b3295ed-goog

