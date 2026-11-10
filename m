Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327636;
	b=SnvmE1paQ37Uct4Pk0W+68VhbUEHTUPQXZwsvTnUhbwe7XsMY1iSAJvvd49BtekXJuWM
	 7+7eTkPRlIGsIBiBxsu7ohjRWPUnwnXzezSH6RxwlHtsR1/6P+GKWX2UlFcpdXHwwWkom
	 cuZFORKH9u0CmgSbcNDiHY6n+unIOh+z4ug4lWAK3W5gm/WIT1FJY5X981S4sdT+CiBo0
	 OxqdMg2LFjXx40kLrGwlSwW/ZRke0DlC7N6rA53/C4KHd5bjaiVllHMIRWiMUnTdoTMcS
	 CAUj2E433s8AB/pzue8mNacKs3tPZFbPHDAJ+rHPj5oUoBDAJp/zlVon5uZCfoLO9tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327636;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wn9pl2dWY0mvsidzC7ZDrdvAm0x6tULK0E6nQnzg3QE=;
	b=FQye6FDuJqdy11uGAQIVMokzXc3JKhV/ZZOKJc84ebm8Qy121zEZMwelNy7exXp2GFqN
	 uUJAvn/VqNtS/Qq27csmz2bpGT8TcnLHlvSQVsVUR41DRWrtBUG0c3kpNHl71O0Mx8HMF
	 Txn/s09h26YulR2FaCLgTZOF9E437jDy5f9/Y53Xxl+T99Wwsjzhim49kbY9tAXaWDwEE
	 W+/8BasP0cnAAsaeLNbOn8pQhtwk9pQHrgUj8uC2mLfcTpZhBOLdTbpqv10kuU8XsUcAq
	 C0bDFEm46SBOUTzGyi/eAg8JOXdgiS90NTHXk2yiyk6+XPKu0vYwYlUoRtvr3rX/nkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=oMYGPlhN;
	arc=none smtp.remote-ip=209.85.219.104
Received: from mail-qv1-f104.google.com (mail-qv1-f104.google.com [209.85.219.104])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB8606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAB8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=oMYGPlhN
Received: by mail-qv1-f104.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso21911866d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327634; x=1794932434;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wn9pl2dWY0mvsidzC7ZDrdvAm0x6tULK0E6nQnzg3QE=;
        b=sOvNOgelNq4CHpxSOznk46SDTUa9ga9dC+iOz+vR1IKBVa9w2RFLXt/Kz6tv2mSGY9
         ku70SYsuSK8ZMMjcvR608B18QQvdl5pQaYr18WpO2mry1awsCu0SfhofCq+PY8giO/AS
         Ci/BrLSKW83pYOzuBrxBqcU0IP7IZdWPzuGQ7pAohCKHIxGe95XPDg2xUBz8TFI3oqgZ
         HI6tdLAPpOBDRm2etfu3Znx8nrhTXUUeA+3EycwEQq4ZJMQUr7SNhKVt9jQjBfp3SJAD
         wAmtu1f7thdOfL0auZaRDEoRoMmpRTH+rTVW5/eySo3K8fXPDQxB53sXY/HcAfy6u/7z
         RaTA==
X-Forwarded-Encrypted: i=1; AL+hErH0qaYiWNJTJOzPX0HBXnfjnNfE4BwQO+WMLMlfE6vzHhmmkPzqS7JDiuHvMrH2C271Eu+A/LI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SzeWdR0maeKC8fMmi+KXuPa0MWomkezCNV4Zzyq2bDu/5jlxZ
	G8Jn5NKjAT4LkR+hCNFKpFwg2BC2OYUFjObEOCwAU3M+lNXTjocgGYdmdXwRaaJejNE7RyPXBRO
	A6eivAChO4Y+ntPOar/jGAbxy1JhqC4vQecGHqhw=
X-Gm-Gg: AYBFou2aNmbuoh22PvgRw+2qa0okOZAYjGDnaIMhZEk/5PeNQq3tOnfNGo9PurwV8En
	hX9QmX/HvOGEqYTsoJJxGxskGtXY4tROqWyUvAsJ/pQUVOzABzn1GFKaqDSwPvI74CJs4SPaesT
	DO19M+renD5dFiCVNlWjoNbHzkzg2or6f1nJdZEyypAI52OEpOSW/5XeqQ+ABBxZElDnVjM/Lo7
	Ls30d1hXcGOK0Z9/eiLJYvnO+m/x8OX+YKx4gCs8bwLvSYcruyptztAKn2MfmcqTygL6dj//Z8Z
	z62KVKfrr0eijVByyQ5IpVtIfH1GogQp3Po3UOsdZrgeVuxjXE3O8GN6NtPpRLCNr//w+gjyQOy
	cmg==
X-Received: by 2002:a05:620a:26a1:b0:93f:1e3c:4a31 with SMTP id af79cd13be357-9479f337933mr473994085a.61.1794327634556;
        Tue, 10 Nov 2026 08:20:34 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479efb239csm35618885a.10.2026.11.10.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:20:34 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794327631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn9pl2dWY0mvsidzC7ZDrdvAm0x6tULK0E6nQnzg3QE=;
	b=oMYGPlhN+9g4AeBDfpCGTBZvu9Avf73LXYnRU6qvPzJzuBsQ3shkH5vxk/jmMg8gWGzwbl
	iRS9Y/grD05nLAnzDqY6ePcGBUuSJekQMzyZ7RF8Z1y6YzzHA0AyatbgR2FGsdiWhRAshw
	xeD1NXhYrsxQ+z6vA0sPv74b16eUe6U=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id cd041934 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:20:31 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:20:28 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+de9701a2cad597c14d34@syzkaller.appspotmail.com
Subject: Re: [PATCH net] wireguard: mark racy persistent_keepalive_interval
 accesses
Message-ID: <avNETK_9e7sr-JSB@zx2c4.com>
References: <20261011102322.355167-1-ngocthang2710.1999@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261011102322.355167-1-ngocthang2710.1999@gmail.com>

On Sun, Oct 11, 2026 at 05:23:22PM +0700, Nguyen Ngoc Thang wrote:
> wg_set_device_doit() updates peer->persistent_keepalive_interval under
> device_update_lock, while the RX/TX paths read it locklessly in
> wg_timers_any_authenticated_packet_traversal() and in the persistent
> keepalive timer. KCSAN reports the race:
> 
>   BUG: KCSAN: data-race in set_peer / wg_timers_any_authenticated_packet_traversal
> 
>   write to ... by task 3648 on cpu 1:
>    set_peer+0x...  drivers/net/wireguard/netlink.c:457
>    wg_set_device_doit+0x...
>   read to ... by task 3652 on cpu 0:
>    wg_timers_any_authenticated_packet_traversal+0x...  timers.c:217
>    wg_packet_consume_data_done+0x...
>    wg_packet_rx_poll+0x...
> 
> The race is benign, but the reader also loads the field twice, so the
> zero check and the timer expiry computation can see different values.
> Load it once with READ_ONCE() and mark the writer and the other
> lockless reader accordingly.
 
Applied, thank you!
