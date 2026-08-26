Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F33C1F4F
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740643; cv=none; b=N7O+aSyzVI2hd00/RORBn1GWE/qgOLjcI+pgcIXKpFxVxtfPxMdot5Aei+gaFpUwA11PxnMgoRCS3YDQBoxhTEm29acbEh4oQnV68H7H+G09gCSvPvm60Z4tMOcJR8/Y/PRZnktL1jzNdtJQwDTI0GO7q4VCSUbOevr9US1sBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740643; c=relaxed/simple;
	bh=nLxhBC9K7s/UffumWKJM/pKPfxqAqqVnORnz+enGKDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L9gKbBKC0VmYvhHRanMwFZ+hxUit1c+IcDYDNdLwPQpehSD6lg1zcxqR51DDCi2gi6vMEvahNjVO4RLILUcQ3zdc5VPUTe4rK7NHymHAlCkZ0kEUq7r6s07QtaZF4/yomK7ZcrGyFUtzfsPMDR1JevMtFpYHQa01w2PEZvB5vMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GmzKPKor; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmzKPKor"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so54258185a.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787740640; x=1788345440; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9j15vXKARyqnoKvb5UG9DRLRPjYLuKnJcBrpUafkVI=;
        b=GmzKPKorXzolXfbD7Eyh9CZ7BdY834l8y+bCegSlK3pssIahZ+oM2mI7INgDNxELqX
         HdG86heuVZt3hXS9y9R6DNLW0ZuIQmZ3BbUO0ZQNTKvWEKQorw6CfH9/tCAIuwZ9pGOL
         aL+XO/pRW416iBtiLW0Nm0qX4lfGT70nRTFewcoA1HxRURf+mpbX0sGuuPCKo61vNBc2
         SfmsEERl76paQutIQ1LMgbl2rFimZB3CetAdxuKSUKByTw2ntfa8SGDbxQVvew7S+FdC
         NKsCHyReQttPEP7wj6uAAvIWzREtVQw0dGw9mQrSqimX5UW0dKjQeU/I8jdXeluek1WO
         BZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740640; x=1788345440;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9j15vXKARyqnoKvb5UG9DRLRPjYLuKnJcBrpUafkVI=;
        b=n/qnz6PwDiGsMeJLPcVNtyniRCd4dQn+Hn9lkpyHVmAFdL+N1p+BbVNBCzjQTPes1Q
         sInA7z5k/E0vjJOgng/SIeiydhzho7cyVoA6k4b0xk6WGhvcFJ8CpXBnEjL1uCc2AbYG
         keWhW3z5stef8IYVSZ03WWJPQk5Qhod2CbWCfMtDyXiNCIEU87FXTKsVjhGs8pdLRQCl
         Q+IXUiWIS+1OTKKxmFOyLK3/22IinTbjFYKBBrvnXN25MsPh1dBFR6usTP00FJQWwMXa
         leVERnF1lu8WCW9CjlBTQfE/T55gHsRT9kFs+Ygma4HhJlXl+2sscwW4y56PbOWZuFyP
         kPbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ckzFPKm+eHvZePGffIzm4XqOaniEvssE2eG1aPxNOWoxdYp60L1CRBMD4wbmbRYPHj+NgNc=@vger.kernel.org
X-Gm-Message-State: AFuF++mn+nsW1jcBLxHTsq1TBaQxaoi0dvIcrr3v82uJYD+YK4PgE6sI
	hglJgaKvHMWEXHUbph0LAHpwMko3cNDprZi5XgoGGNBSLE2rtunUs8fhawZAec8s5tlsTGL0cfV
	S5krKZCVf3qt0YA==
X-Received: from qknwm5.prod.google.com ([2002:a05:620a:5805:b0:936:bc64:2e00])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b84:b0:937:6772:d8d with SMTP id af79cd13be357-93780162998mr528378785a.20.1787740640160;
 Wed, 26 Aug 2026 03:37:20 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:37:11 +0000
In-Reply-To: <20260826103711.3302915-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826103711.3302915-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826103711.3302915-6-edumazet@google.com>
Subject: [PATCH net 5/5] ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If a multicast group timer has expired but the delayed work has
not yet run to clear MAF_TIMER_RUNNING, expires - jiffies produces
a negative value.

Because unsigned arithmetic was used with jiffies_to_clock_t(),
expires - jiffies underflows to a huge value and reports invalid
timer durations in /proc/net/igmp6.

Use jiffies_delta_to_clock_t() with a signed long delta to properly
cap expired deltas to 0, matching IPv4 igmp_mc_seq_show() and commit
a399a8053164 ("time: jiffies_delta_to_clock_t() helper to the rescue").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index a90dddba719726f36e0d5176c5e0574d1a488d5e..65916dc3a3146ccb7edba2984042b093ae1cd4f8 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -3030,7 +3030,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 	struct ifmcaddr6 *im = (struct ifmcaddr6 *)v;
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
 	unsigned int mca_flags = READ_ONCE(im->mca_flags);
-	unsigned long expires = READ_ONCE(im->mca_work.timer.expires);
+	long delta = READ_ONCE(im->mca_work.timer.expires) - jiffies;
 
 	seq_printf(seq,
 		   "%-4d %-15s %pi6 %5d %08X %ld\n",
@@ -3038,7 +3038,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 		   &im->mca_addr,
 		   READ_ONCE(im->mca_users), mca_flags,
 		   (mca_flags & MAF_TIMER_RUNNING) ?
-		   jiffies_to_clock_t(expires - jiffies) : 0);
+		   jiffies_delta_to_clock_t(delta) : 0);
 	return 0;
 }
 
-- 
2.55.0.860.g4b6b3295ed-goog

