Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82143EC830
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906749; cv=none; b=dbNuvkL0QNg3ijGW99AtK7jPJiP9WhPXnCv+btk6P06tlx59TZu5CZNFgj+NgMiIjbS2xkV+aEL7GuU/u1UZ9BdDiiFOPKH+Bz6FPqG5br/0sxZ2ye6wVQOKcbmzc9CBf+XMh9LoaZfIg3sqAt7gzNd6keHIL2BjEwX29IPCqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906749; c=relaxed/simple;
	bh=SWxiKUvemoaXLtkGQUzu2Zlxcf3wrD3kHvd6mX6PUoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g4q8kQnwZ1KIUhmBd0+fmPRC30SXQ7vj4S/I0dbOSooSKtDvZp/jzd+6qBk+6m+QmslBuP0Dr63xQ5OD0cimU24ghob3qeJeAVCuCVfTuScGtJTslWmJSZ73SthdnSuAOtVS5AzJGLOkFCujr5R1smUygZtlMgHmig48R4AlN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqDGa+7H; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqDGa+7H"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8eec6acbe21so16770766d6.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906746; x=1788511546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYHofbdl/jBrAUQGBv0NFrgAyPWaOtqINCFSiXv6QmI=;
        b=GqDGa+7H1JEBlEhpQiyKYyG5mmco/3ubpW/F0L05uIlwmGIOxgeai1dcU57aXG0rkH
         vsh0qYwt2gFRmimr4Ir6RFnTZIs6vVVpTzmGbA0uUJjxbBOk+9GPuIqfYpNg2emwiB3X
         5fqnrrJCZmHqIWHhVPEJl0Es4oyiFRZKbTfJ+OpDR08hDnSaUoV2hhKh1zHJjHUK1D1W
         x9QYNQMoEHwvRSEOX45fZ5TmD360wOp/hpSAjjVNY0eXlrFxs18E3xPwG37cJiLrPLLr
         UIlI5S16BF26Of/a0VY6bafaIgzmxNL6Xqtozm0iDrD0V4qPwUOcnE3k2kIdxl53vAkP
         JQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906746; x=1788511546;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GYHofbdl/jBrAUQGBv0NFrgAyPWaOtqINCFSiXv6QmI=;
        b=H86jj7LlF5AwkE168G3DydfVapp4cKh4XXppcJS08oziSnAy0c85iE136jEU6jRH4T
         GXierUqkebWdOmmKO11mjiXNsKd/SlujJhEF/05H2oiOzc5T6SuNpCQK295nVYHyojqV
         uUlXaF3pEHX53fzM2bn3H3KAXqQ4DIqqtRP8KBS06s3EAQRQjOS3+xz6GdlMowHwlo6v
         rcULxh6FXeDVmStI8BRPQWmmvEeWNZuwcJJHRPLL+YgfaGmPefh31GA3HJdy5nG56/YU
         cyvtzpiY08yxhaBLer5UniR/452Qm7HLuqjKym/JH4qgjbCjFy0GPtMX5F3nyKftXDtK
         eFBA==
X-Forwarded-Encrypted: i=1; AHgh+RpHdH1ESs11S/tzjhTnTHpjMp2z+CE7WA8H6yTAIjUtJchuK7Q4ASHdan0I1P/6ezeqq+NvhHc=@vger.kernel.org
X-Gm-Message-State: AFuF++kg6N670jDsVRy2Sajuvzh7S6LNuxuQ72pMXTy1xpnzex2F5b9A
	nK6MfCIPVdTpUfqlHIakrL2hEwGvFrpwKVO/JJi3w3cQ/A2VJSiV1LdDZ6SG5NxdQTGD2JY3W8S
	V67WF06MWe9r8VQ==
X-Received: from qknus20.prod.google.com ([2002:a05:620a:6b14:b0:938:774c:6b96])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f01:b0:936:6911:38ed with SMTP id af79cd13be357-9391351e8f3mr497334485a.0.1787906746271;
 Fri, 28 Aug 2026 01:45:46 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:45:31 +0000
In-Reply-To: <20260828084531.1826790-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828084531.1826790-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828084531.1826790-6-edumazet@google.com>
Subject: [PATCH v2 net 5/5] ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
index 2290457eb8d3dd7a8d19fa9bf19f97160b7d2492..ecef55f261890c3de11c874d623d268dcb11670f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -3029,7 +3029,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 	struct ifmcaddr6 *im = (struct ifmcaddr6 *)v;
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
 	unsigned int mca_flags = READ_ONCE(im->mca_flags);
-	unsigned long expires = READ_ONCE(im->mca_work.timer.expires);
+	long delta = READ_ONCE(im->mca_work.timer.expires) - jiffies;
 
 	seq_printf(seq,
 		   "%-4d %-15s %pi6 %5d %08X %ld\n",
@@ -3037,7 +3037,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 		   &im->mca_addr,
 		   READ_ONCE(im->mca_users), mca_flags,
 		   (mca_flags & MAF_TIMER_RUNNING) ?
-		   jiffies_to_clock_t(expires - jiffies) : 0);
+		   jiffies_delta_to_clock_t(delta) : 0);
 	return 0;
 }
 
-- 
2.55.0.897.gb25b4bd76c-goog

