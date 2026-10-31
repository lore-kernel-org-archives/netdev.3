Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793464292;
	b=UDu/LuJwq6oALy04+nhpM+rh8O7yS9jbWEtBUBL+KuRW18lP3V0qAiS1PI5w5WKKtbA4
	 yEOrbAd7gnZW4ygQJjTpPU9Bb7Fxyc30p/JISU0r4Wr4akGie9EFI4EZGh61nIB5c8iQ3
	 e0b2UGk307oSy+ojP3NXg0g+PLwjY9sVoIKKSVwBjVP6mxJhHEM25O8uERbB/bf7iVNd2
	 7Tz7nE68UVrXqYfrLdpICel5Kpv0MN6xRcoiBy7i1myZlBfPPzsfsE0CR6dg/iwxTLaGk
	 wkjHWwH88BUoJdOOGp7mPKUtzM+oPns2JJNsVT0vfI3IzmS2NNutaqOTQzJW3vYXFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SCL+ExvyxTDNNteFin+VBl38Uc6A50cRx/B+LfB0KAg=;
	b=Wvs8P0IvsRvkpQ+E/ggmjYKHo82fJAid5ZuqcWh01wSsvUqDKgSK+EvPmNQbXCv65Qtw
	 anB5zuqNpRnILJ97RsBxXDNGxcFptdczUl2JUFZl8oZh11ETbNrJdB07hKSLW06CV9MV8
	 pWOyHm4VwRr1XPMRoi/JfmT0VPNzMfg/rT5dtVJzTJaPRMLuIb2hSuCy0vTJ4l25yUsyr
	 T89BMZXAMzpfrSUzY7t3veN9jAcwDxPZOX06bkoPxDTBMHScztpkJaM77dgqV284q/52y
	 9OT5TZe42cqhNNI5JfuWes1AhBKpdsFpNDPFQkq1uRnyBUms5G0DoWzTH8ipV523v2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDQP3B5Z;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DC606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 16:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F28DC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDQP3B5Z
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so1324551e0c.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793464291; x=1794069091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SCL+ExvyxTDNNteFin+VBl38Uc6A50cRx/B+LfB0KAg=;
        b=kDQP3B5ZdkHbVHc6cJ2piQiKyFLHblfXj7KSJqwC8YL8J4kky6PeLNg3dynltGF/Zs
         FS4/iKuJZKgS8G0ZLy6KTasm84VTyVVn1p0tZ5yoC91ymmxTSBREnUhJpggntd7zRLZJ
         GQ9XTfoXJQhHy5O1eSFd6/tu5nIVlvZ9UgUJbHxUG+xbFn/6hIuB2m/nfw7R8gsGoMvn
         pF/N9+p1asVVP1vPdUU+osZPvseBPu2Gi41wQOtcZKfEzLyFRroXV5bXdFSUs3dGTYPp
         R0so57YAFz/ULjy9IYIGWuPOlPjpw41WwX9QDuxE2D7wTmK2URUMXmw+/W0hYmq1Chlb
         ms7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793464291; x=1794069091;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCL+ExvyxTDNNteFin+VBl38Uc6A50cRx/B+LfB0KAg=;
        b=KM8t+L5qRRB/PWb8QVGXt+fHBwjKsGCyCFlVvSWe8V3K/ZL41KEYp2J+3AOw/jkN8s
         V1LgiM0/6LWUbbz4Ki6pELcQjGZCaZ5eXu6DlP6I+hx9Adn4aWf1KE8qVI+z+OqJjUrK
         OF93nQfK+5nAktyS1Vc2aDJgpUh1M4tz+nMy80aEqcwiX3nstcpx23R6YlIj9K8rVUbU
         qQd4l7o11CXUYtInoGLC1HoaoUU34tlOy2F+Z0vmncBTxuv8O2wBcwFynF8sYTr/s6oL
         jCJNx4Suv+cApVkVSmCNFIQbjQVUUDo8c4IJRaW/p+54NG8i3xwZ6ESo4SD1mR9rFRvr
         XFqA==
X-Forwarded-Encrypted: i=1; AKwUvBwD2O4LPG+p+Xr7WWGo39Ks7+aHN3dTe8x3uWSdDSxy9MtMnpsqOxx27LKk3X8iRUXxUzEj7ug=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs01L/7QIHPMCe9w1aaUJRqT56YfIMdUP0nZgXUA41KGEk4fLb
	5/KZGJSkBzPECKDe8GNji5bNc4CrAeePWLfd9rLLSN1GaHEDas/VW3m8
X-Gm-Gg: AYBFou3XHz3nWhj1g2LEKljltRAqRI+WeQhCp7u0r54Aat9LqfKfvu3Ckwu6ZVqfsDV
	6tAF3UdTchOxeLoXoduc/yXJWAntA0p4qcObF5bIFyMRr501BIgjHwHAbZUqsDMQhWEsFQD64ZQ
	BgRe9y9daCmwbMSx7wKAlonmTuzvZXW1Hed/HiK3RYWuSQv/qOPBXcSQlPwDC58tAPq1YIknrl/
	0VwAyT0NOK1A6mjqJ3n31Y9cQOOPzkZ6md45p3Pw2eDBJMdb9RMgc3glr0uXCtLLGcN/JXUg3sU
	kZG+oZdlzSXWC0+Yl++r9g4cdkFiXWJu1J0BjCoAsPBhAodTU8eoXtfDWEBQx1SKfTF5mgJxeam
	xM/ZK2KZ2mbKOmDPoj3nI232ov3n4aGiwl3dnm3nPhgECMw6NUSkGwZtEVtV1qCfCpAUq0qa012
	6w4ZHnB2aaBmIjj6SqbnxIwgzmkzr1j/NC9X6Vz+9A25+lPW4BoVo4qGvaHuciP4XuzyhQZbfDz
	JBiEtzWTO+R9+vST3XE23gklPklL9HwEVInQJS9boAnJm8iXn2cBkd6gkPl1umVzRwJ2jSAT1t9
	+95uzZHa+gF0jzopeK2se3vG8dIA+LmAf6XhpM47KVd4nHQwEDaN8swfmMzA+Fi76kSQgTxp07Q
	w+fPdzc0d5FKtN6dyI0SmLUXnqZ1S/YVTwnJlDmJlVc1bsEgl4rQowXBPQf/Xz8vY8V7U
X-Received: by 2002:a05:6102:3706:b0:7bb:c382:2ff4 with SMTP id ada2fe7eead31-7d0726ca2femr2413661137.20.1793464290850;
        Sat, 31 Oct 2026 09:31:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee41f108sm7037066241.7.2026.10.31.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:31:29 -0700 (PDT)
Date: Sat, 31 Oct 2026 12:31:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.54d115047658@gmail.com>
In-Reply-To: <20261030081704.251652-3-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
 <20261030081704.251652-3-jingxuanxie@deeproute.ai>
Subject: Re: [RFC net v2 2/2] af_packet: retire TPACKET_V3 blocks without
 waiting for copiers
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jingxuan Xie wrote:
> From: jingxuanxie <jingxuanxie@deeproute.ai>
> 
> TPACKET_V3 waits for a ring-wide read lock while holding the receive
> queue lock before retiring a block. On PREEMPT_RT a preempted copier
> can delay another packet path or the retirement timer until it runs
> again. This was investigated after an approximately 355 ms retirement
> wait in a PREEMPT_RT deployment.
> 
> Keep copy accounting in each block's existing private pgv descriptor.
> Seal a full or expired block and advance to the next block without
> waiting. Retain the original descriptor across copying and release its
> copy reference after all packet data and headers have been written.
> Publish sealed blocks in order when an acquire read observes no copies.
> 
> Publication runs under the existing receive queue lock in packet
> allocation and timer paths. Completion does not reacquire that lock.
> No worker or publication budget is needed. When traffic stops, completed
> blocks may remain unpublished until the next timer callback; this does
> not promise a hard capture delivery deadline. Ring exhaustion can still
> drop capture copies.
> 
> Use each retired block's saved last packet and its own cache-flush range,
> and exclude sealed blocks from allocation and fanout space checks. Poll
> uses the publication cursor instead of the producer cursor. Widen the
> producer index to cover the same block count as the publication index.
> Allow an exactly fitting record so a maximum-size first record cannot
> cause an empty block to be reopened instead of advancing publication.
> 
> Reproduction uses a QEMU ARM64 SMP PREEMPT_RT kernel with validation-only
> instrumentation delaying an outgoing copier after frame reservation.
> The instrumentation is excluded from these patches.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Assisted-by: LLM
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
> ---
>  net/packet/af_packet.c | 140 ++++++++++++++++++++---------------------
>  net/packet/internal.h  |   9 ++-
>  2 files changed, 76 insertions(+), 73 deletions(-)

This is still a very large change across many chunks, for a fairly
small well defined problem.

Let's try to a find a smaller solution to this problem.

For instance, switch to a non-blocking write_trylock for block
retirement. If it fails, it will retry in 8ms.

Or, if spillover to the next block is really needed (explain why),
at least simplify. Do not allow running N blocks ahead.

There are also bugs introduced in this patch, which is to be expected
given its complexity. Instead of focusing on those, let's try to move
to a much simpler fix.
