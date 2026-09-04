Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AD3C09EE
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492968; cv=none; b=beFYUtvzd3FXjnN9JLbD0anvbHToNbfpdV1Tp76uEwylkK+g6w45GnZCAnCHoH0wHxOkQVS9vc3fW9CcbtRVTIQoqS8LQfnzMgYlP0+5YCLg8Ej8QMobLjA44ywLeRGxDru5zRtrGWTffUYNDK4vgHVHOj9CubqaYxOycmyVvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492968; c=relaxed/simple;
	bh=3SqmX7XNaZ5FErJERS+kTaeRFmtmKUNealMfC87vCnI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NQIOFfTeKmKpOaa8jSU1s6oU8ZxLHWHZwHSht46h9+kkEyhc4IM1T8ZEEawwQH6xgJLhEHoXkmZyTH9honAF4Nu12cXZSpk77Vfyh6iXTuE3TnoDtOfVxA31UbZJRQAvwTFGEwkrJCDTXaUCzhfGRuv673IIxXrgWC+JJ3neg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vmim2OCi; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vmim2OCi"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-854f274dd69so329939b3a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788492962; x=1789097762; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abvw4gogYXZMCLNfl4j5lDas6XkGs6+mPHvbnPAfjZM=;
        b=Vmim2OCi4oHlBD5noF+kWExbp9ZdsZExmC64jBBkTn/eWRb45vfILt//URGbL3X8Ei
         4tPpDDgPkENQAJ7YvuYSGUGN26TUeK8MdfekSGKPsJzn7mDhi0XDd//1iOJy01VWz9rZ
         4gcstrpNGKw5kuv8/5108LFfk2V23sr4LiM8GF5rjUiidy4cSZRJ3S3OJ4FaV03vF4I8
         Gr9EitpiRZ4BDgFLLoiu8SPW8d9Os0UFRqzkXkswxePW2TW27VDaA0pjWNHUkXxB7LQJ
         DFKEuCe/7TVmPzdSioquhvsTy2y+84eq8xhess43I89JRmdaVTQ2G1h/fBzL0YCznmxV
         5jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492962; x=1789097762;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abvw4gogYXZMCLNfl4j5lDas6XkGs6+mPHvbnPAfjZM=;
        b=Fcr3sWRjr6CznlL/eiLr/cxOUCucXFlZgupPu0WbS29eVVfpJjUqC/2cDcRkzWyQuP
         W/PU+nV/M6gry2wQIu+8FJY3CZCVP7P1ctGoIPcQDDe0xVgDRNx6IPDS1a/3usPwCas3
         QTvQRHRJ10HwAHa9yasVTlLUeGRAunXWMxVZl2NEFvUkc1v/nYmbABT/rWtGZbGPsKR/
         CMOhmLHWetFfNNXswOpPnxAwrjX1qhrylRPM1J0edN62QRhk3+fr0l1gF3oW28Ko1uqL
         KzMwBFVmY0fEGtjAyVK1KRwHvu1FFWnRGJUp8VEo99hh1QYGETTwc6+mWo+0qorrKiLE
         z2Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxPaD1GCeVLLe+jZZdExo4CBWJMGUY01hI+x2MSAqrmD+qm2o8oPev9EyWJrYJF0S8Ujsz45fg=@vger.kernel.org
X-Gm-Message-State: AFuF++kFOwaVDxTAobqVXsSqI31IP3eLwpW++PW+oc8rpTEjUw6Zr17U
	uMftxwk1n6wEDIn6ccZnWY62cyCrBYw40L4QcPufW8+TVlPxI5XWeeajQ61NUSa8GBljjSzmV1o
	WFCga+w==
X-Received: from pfbkq12.prod.google.com ([2002:a05:6a00:4b0c:b0:847:a85b:6c23])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc5:b0:857:727c:a1f5
 with SMTP id d2e1a72fcca58-8616977b73bmr4410271b3a.23.1788492961792; Thu, 03
 Sep 2026 20:36:01 -0700 (PDT)
Date: Fri,  4 Sep 2026 03:35:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904033543.2635540-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and IPV6_ADDRFORM.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The following operations have recently received a lot of AI-driven
bug reports:

  * listen() + shutdown() + connect()
  * connect() + connect(AF_UNSPEC) + listen()

  * setsockopt(IPV6_ADDRFORM)

They are not worth fixing by churning the fast path, so this series
disallows the transitions and removes IPV6_ADDRFORM.

  https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com/
  https://lore.kernel.org/netdev/5832ba17-c096-4f07-aa73-2e2bb6f79856@redhat.com/

I did not add Fixes tags, but if we want to backport, the tag
would be:

  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")


Kuniyuki Iwashima (2):
  tcp: Do not allow buggy transitions between ehash and lhash2.
  ipv6: Remove IPV6_ADDRFORM.

 include/linux/net.h                |  2 +-
 include/net/inet_connection_sock.h |  1 +
 net/core/sock.c                    |  4 +-
 net/ipv4/af_inet.c                 |  3 --
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 ++++
 net/ipv6/af_inet6.c                |  4 --
 net/ipv6/ipv6_sockglue.c           | 87 ------------------------------
 8 files changed, 15 insertions(+), 98 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

