Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269147;
	b=IOIlliy62jIlIAi8fRdgKX1w3kw406VqnYAbwZV8lVWJXVgeUWatwlSYYWEy1Xv0Gb8N
	 1tkBsLAQqno7MSzN6pJKjMFAl1EDlxyQ81mVQoI/qkdLhSqK9NboaIAWs0NdaWLynofeH
	 f4RcbOO/4pXQX2NUcrrkmTBWwS7acCyrUaddTchfMMJC4RF0lfqfeOYGj49IBDfoTuME+
	 qOuHkd2xQFBP6PCyDZ8OM8WsWzg8tXrJPRwGtQjUE2XyLyF6sYnDIdBiVyEPDmTMFfpRH
	 q3/J/3bPMIHndCu3QWrgxCX5SjzN9Sfb6ZcKU8w0FxAWy2CQMoq0lcEEC/sOOmKCo7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vc0r3JbZbwBvUVapNGhL09kDmaTErdcaYY3i2MzSoa4=;
	b=tV374DMqoPEGxt/xUG1jrl4RUHPmljAXK6r8GjoE+JSjGsKxvU+wjUzIZuvetqpxDO7k
	 BzNtIisK/2vWz7khhbun87dfJh6W/01YHxlwhvB8r3Y6A53UwqjXy0MXoe180vrsKVA7h
	 qMQYkOXt1W88GkmkuYJs7kHAlcdOwIU/2Z1vRlWJvplw6Ma+AqSZ1xKLUZ6pIczLK06oB
	 L85eQAsG6TqTjfmb+ZZnS6xEE9j5in0dTJtsb+srUCmIw5jMYSnmojaNV/V88BnRHd/T1
	 uPS4v2jWxLxetH/WziljN/FYL30wiOHOBRT/axxOWfMWF7GieDdBpLnDDchpbHegOWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zH9z4kbb;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A85606A320
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A85606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zH9z4kbb
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so21237625e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269145; x=1793873945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vc0r3JbZbwBvUVapNGhL09kDmaTErdcaYY3i2MzSoa4=;
        b=zH9z4kbbMg0lkkb/HqgCLaFR9vONpMS7UnrW2ezQXaMot4yuVlvx8b5AsRhSxwcAbi
         Q4V4plM0s/t0NDmjNPggc0m3ZhTaJqh16rAqpGi9MHj+RiOCp8gednbCJjh+al/OBh3J
         k7dr5f93QI3uvgi5N70JgAPgUqm5BbmDSTg4+7OuWMyvYgfA37I5zYTduwmKcfRgttzJ
         kjcY4e0V4EKRJbYh1+4WRLNTrxvUqyF0Wh6n+2CKqJa9D29js7cu4+6Z8dPMKadEGaoD
         kMgHq+0nvRzb+a+PbaN9D/ZrUsU0nRFfB6YPncLGLwQk91Qn1/Z4TSQbNgEhroKs+9x9
         ox+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269145; x=1793873945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vc0r3JbZbwBvUVapNGhL09kDmaTErdcaYY3i2MzSoa4=;
        b=oI/4hSSlL761haZHtnfa3j7xGhR2sHTbv3IaoshS4lzGdbo8SIz425D2Gq26pXg8Xw
         sZdHu4xC/xm7asE1tRAhZoZ48qsWQga1mYh9vljyMTkGjGTKMEgXYG7N7KmkFUOQ4J0B
         IlLJmN8hqXEI5J8paqKLtnZu+Y3lsIatU9nfOrv++hd2MPVcXnE85aMIvYFDJA+s5qSe
         QHM+C9riaaSn/jHLPglTeUIxdCp2PASWmzSoC/e6DZAAn877QelchzOJJe3XcplsjJCD
         B2yEsJP7cInPJbdhK2+Ha+ZlpPhpPCSdKdzI3Aocrcm45RcIbxTR7daK69pO9vpzWiLi
         DlNA==
X-Forwarded-Encrypted: i=1; AKwUvBwUdZvSc66QjEIUvnPncMjOMA9iVeiiaCcVMWK9mkvII4VogEmQ8j8827i07gOxAX0DhGVDBsA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvMZj6WllhjMSaE6vs18n6c9EKriaNIyzV/aiGjNkuHLpXNOxJ
	hRX2WrN8d529A90vDvopWzArBDO+4ig1w3Axk++ESMPVTnGv7WNbuCSO
X-Gm-Gg: AYBFou2J6gYHow2Oh4F07c4QHdkr9HIdhAZzyN33lhY213Vry3w4bWfQLBZXfCLsI85
	e1tkyBxzYmKN1NYWRUAMJ1Fhy+n2HdrULxL69IATQ6qa7ldeuWD7cOoSQZDB2XKASuC4CqDXI5H
	fnx1T/5Qrf4FgrkPRX82fayDmpnOvhjoTY6A9JDsxjAWO+j2v/sPiA0Nnov/W1gU9B0P5gfNO9L
	k72VHm1N5qSbEwZzlImEnFB5LgqIVLaHFIAeeNzEICLmHd7Eh0Fu3ki1OpqY+H5lt6Ek/5lnpua
	nenGpQk1romXEFPFKATvxKyF67o0bsnyB8dE+EDaq5CyWYZqyH01VEZc+8V8dmaDIOKOaWWdBYW
	MDAcTqk42mCLyb3wCN4XQ6w6sgQSW7cxAtjcCZQ925bC1UQVqb6jgqhz9Z6zejOmgvSDHJCT8lt
	oOoAtk2biapQgFRKHYJxA4uoljzdSGwA+Bl6j7UwA6DmKwnrOyR7Xi863ChPpaYgphdKajWSQwq
	0qua6uVvojZJoLSt6CZs3A5v9oS9ZxOS+vJb+mSuRRTScYOgIFB8ELEeWCg34sXZoUoBMevNMMT
	ql1SFk477hGm5CIWIDbTTc1VokhYJPNEpUzgk4ryzIRMopmxIw+mSIgQsP8MtGJmcA==
X-Received: by 2002:a05:600c:6088:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a9677ca203mr118445565e9.27.1793269145060;
        Thu, 29 Oct 2026 03:19:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm31946023f8f.43.2026.10.29.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:19:04 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:18:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org>
Cc: echoowall@gmail.com, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
Message-ID: <20261029101859.6893f1a0@pumpkin>
In-Reply-To: <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
	<20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 15:23:09 +0800
Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org> wrote:

> From: Esko Mobius <echoowall@gmail.com>
> 
> This reverts commit 2640e6419594 ("net: advertise TCP MSS from the
> configured MTU, not the learned PMTU").
> 
> That commit stopped the learned PMTU from lowering the MSS we advertise
> in SYN and SYN-ACK. For symmetric paths it argued that "the peer runs
> its own PMTU discovery and usually already knows the real path MTU".
> That only holds if ICMP "fragmentation needed" can reach the peer. When
> the peer sits behind a firewall that drops inbound ICMP, its PMTU
> discovery is a black hole (RFC 2923, section 2.1), and the smaller MSS
> we advertised was the only thing keeping its full-size segments off the
> narrow hop.
> 
> Inbound ICMP filtering is very common in enterprise and carrier
> networks, and it is pervasive in mainland China. We hit this in
> production after the commit was backported to 6.12.111: TCP connections
> that reach a server through a relay with a smaller-MTU hop complete the
> handshake, then stall as soon as the client sends full-size segments.
> Clients on networks that let ICMP through, and connections that bypass
> the relay, are unaffected, which made it hard to trace back to the
> kernel.

If it isn't a silly question, how to connections in the other direction
work?

I'd have thought they'd need that ICMP message to get through.

David
