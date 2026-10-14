Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DC38655A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004352; cv=none; b=qlzSYiY9keuhgFtGJR/uDN8lelaObXGNHnXs0WhLFC5DCwOQ4ebJr/EyfQjJ3ALBsfnwQqpDSJM9r4eaHf6WXuLEqhES/WqlISp1G8IdhMmVaFho0N5O00JA6E17hgSSLiPp5vQNWoe0SD1Se+WA2h6t7bxw5VInKKBiCY498sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004352; c=relaxed/simple;
	bh=Rk54IAaE6VVUUw2LLHOVHkQVqBe3J7+3RvRWEEH/U2c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gNY+fq2i1SQ2Zl3AChM7LZBtslcVt3dnax0De7+cnWfpe6rRXTl2udpT8DOmJy0J448eJ/CH/SeJR4Pdd5H8AUrdmlufWT5wIWNaOEbtA0I7AClLvRB6ZHHgpyZCdgMWBVu+5ObsP5b7rofyQIZK0S0aEAgfmZSJFNRvuNVCE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACUdX9uh; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACUdX9uh"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5e9405fbc33so1912437e0c.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792004350; x=1792609150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LubmNDov+kRdJeSgDmNkTIoCyYOuN6AaFESo8XksX+A=;
        b=ACUdX9uhrjCQKOJNqny++2sBR8t9Y6CrMAgUBfktaL/EF9F1nnfYH5IMEf/GDjjFGt
         QA5VTDoOGMvg3vJybBlg56rMVFd5NkHgVijKVbD8i51daSkxfMwtLEjgQy0lpF5UBdmI
         VMlVOXW8oEgddav0TP9GZT5Mr3ycKRToI9WhY7BOSbApSNCS10G+etk+v6HUFcau5Kqf
         2nGjWFB/i6zxDoQGqUMD7BNaif120D1yDDUzvaV3PB40SglQZnkaMYWi6BTkEGxNSU6E
         yIsb2stFBpB747PFuJRhoV3q60H20gP6xU1cMrAXEMbJ4vqMcX3+8UofL5iE4FiAiqtz
         2uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004350; x=1792609150;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LubmNDov+kRdJeSgDmNkTIoCyYOuN6AaFESo8XksX+A=;
        b=oBQ6aFGKoyHA7uTOobwUSxcSpQFm1DWehFK7o49DUCWPKsgv1BQReu3xFnlyOVCHrZ
         TToTLmrhINnltQRp8OQ/ALn+45e01wJLapDDxWTZks4na5cVEnthKi4pR2B99/UGqIaR
         ldLuYMfbhsFzW+4tQwju782NqotUedlddzK8ygJcou8lzHr5ibwsmpyuJqJY4oFcCeVA
         mJhaSbIId0lUeZsFUDi2SSZrFQd4Qf7vAF8NstUKeDfnK/UcqHTkLPdM7FIrP+eK5bS+
         w7GyjDPF0oppvQYyaB1NvoQjRd59XgeEuKxG0c4lD+K4v1iOXJeJoQMaa9pjGWzS8wQQ
         z0kA==
X-Gm-Message-State: AFq9FYLPb/KsVGM0rjp4DhReg1H/3rAoMyzh382OP81xWPRfS5o7obVZ
	zVDGw0zU0Zd7Y20YN45TWs/Lw8UD+0V8B47DPLHuou6aZN8Vvp+E9RZO
X-Gm-Gg: AYBFou1qf8yCN+eBF2tfOLW27I0qVzusfnwC+bRHXSER3Iom5514+ElVf8GDi5JeI0L
	Yv+Q+Ps+BdGppe3KFRGyONJAYHwYZVVLuf8N+UqHANVs8jjWErFTvwBOiCqj/Xc6OTfZiACMY3V
	xNkpAD3vrQDqJfNOKSVqukLeH+vF7Dwnroxw+f5soNkUG3TiNTBC9BiAx4weVUYMi6WwWHYZOhG
	3e4omYsB0+qqOYAqhNaZnaFbw55kq4uNuii6QUV7o9KNsFrTKI/0ecAmnpcc6wF/8NyBkpQLA1w
	QAGARs3UR2/SQSocKcXKRwFFeKfw3VccvBuFnpApQ3j6A3mJ+EUNQaJRkhNlFzpmBIg7xLawPqP
	cbpGHjNoWvh3/jl5wGGyjabsb0w4S2RdRSAuqV0cWuySi7LV4mFwqEsj0E4n5yBU8TRcG4t9jF0
	JSeskwMLVc5V1uwFzBb4fRB5FKo6mERtANc2hcUn5ORyqxEZWLygkgcX6X0Otx+j9/6hvkGMS9r
	167UqyPtrUiDqz0KIMSDssk2ixisP+kqrEJapPVj3UyrZXEP3IuzJc42pJzUX3IATFZxH0e4E1v
	mBDvH623qNujk5xIvW5/8K/v98EwrUOx5ALdPg==
X-Received: by 2002:a05:6122:4f9d:b0:5e1:c1c8:9ff9 with SMTP id 71dfb90a1353d-5e91f28cd89mr6035507e0c.2.1792004350298;
        Wed, 14 Oct 2026 11:59:10 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cc14668sm11985603e0c.16.2026.10.14.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:59:09 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:59:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.1725d296e3ac6@gmail.com>
In-Reply-To: <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
Subject: Re: [PATCH net-next 0/9] net: skbuff: convert most BUG_ON()s to
 WARN_ON_ONCE() and an error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Josef Bacik wrote:
> > I'm going through and reducing BUG_ON() usage in areas that have created
> > the most problems for us.  89 commits in the tree quote "kernel BUG at
> > net/core/skbuff.c", 31 of them since 2024, and some of those could be
> > triggered from inside a user namespace.
> > 
> > The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
> > in a buffer headed for the wire when it hits unreadable frags.  The
> > BUG_ON() conversion of the same function needs the same handling, so
> > it's here rather than sent separately.
> > 
> > The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
> > Each one becomes
> > 
> > 	if (WARN_ON_ONCE(cond))
> > 		<error path>;
> 
> Good idea. I was thinking of doing exactly this sweep after addressing
> one case recently in commit ee1972def665 ("net: downgrade BUG_ON
> EIOCBQUEUED in sock_sendmsg_nosec")
> 
> Instead of WARN_ON_ONCE, which still triggers a panic on systems with
> panic_on_warn, DEBUG_NET_WARN_ON_ONCE?

Just to understand: do you plan to resubmit with this change?
