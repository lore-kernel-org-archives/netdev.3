Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717393;
	b=n9HDrBv9i93Sh0hyqJEtH4aNo267Or7IWqu9aqvHwwXYpjasC3lEeMOf85zWlKBtubxP
	 EAheidneKi0qEKoBonXConvZkByT53YXyIr9/3GYdVWEXbqxsE6V7PRGVy/vwIUpAmd76
	 qJxPHrzoD1xUt7GF2rIV55Wgap1cBn0Eb6IZcybsCjIFCTZSs/XXxQkN7pNYALb232WZ3
	 XinXAXUiyLAJ2PKcnTsB6dbxhO8UZL2IIhBVTF/Er1oWVWghoKgt/pbejlW2CM9irjxwT
	 xqu51XpGYc1vzHyWYk47jEbyBCIQQMoQ8J/qXzjZuk4xqBaVPgyFP6cT0ZI5Kj2JfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717393;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=27qD6Pz/Glh9kkpJIUr3/I4AZLpTM9yA9jtQ1ZwO82Y=;
	b=WXbCBGuqhCjgBPH+FpdCY6ZQ6IfpD9C57sz8/cvcBqY0UKsZU3YmxSbI5QeDmF6tHnpZ
	 Nd4/u3oGr2TO1qrq0ctBQWrecR3Ex+Hk0dD72ybZywLUAkTAtoWcmCvPXdGbnjsul9eOf
	 FK3r7drYoW0BHkJZdN0SqleD8m44aPaCtfo1YTuXPODqfxSLIf+J8X2/DQN2HT3AT79Z8
	 MQpCZq2/UrTbZlhRtujVBsJ0Ex9jIT0CW2k6/u4fv5pd5ZpZ+vH92B2QR6ANe3dI2hme+
	 7Djb3cyJdfMV2+LOxp6f0ceEZGmneoVUkq02FY3XKPUg5x+klJR9GJAuNzPjwHSjqKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIGpP7aR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D716083602
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIGpP7aR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289AA1F00919
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717393;
	bh=27qD6Pz/Glh9kkpJIUr3/I4AZLpTM9yA9jtQ1ZwO82Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kIGpP7aR1scUpNqCFWVyvqhbrG/s9k0ZdkJR1J8ckr4werPo8N7S+1tPRuPNdQFUD
	 S2mnA5AqFPe1HAd+zP2JYrtXwIUwCn9gjRuBBVMJJDvA4Gzox/Mww6czHdYdFh1hCd
	 XLHRgRYM993qy1/tGMyVR3tvKgGZ6DNU5nXVziqSkJF0SWCUdrFtl0r2nGu6rnGQH7
	 Ir6Wdei4nXB8Ce9rCSQjcQTaO5UUFWOWkAOheJ9QFY2fULmkdYYj2zTmRVoIoPIKeu
	 tcKp5zfJAUZoqF6kKbNWNHONOU06KmjLwsJTd5xXnfzATKI3WDldEJzkaCFYuE3iUn
	 NwrQP67uMQPuw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4f488ba6e90so1574082b6e.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:49:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwtXWJfQswG1yOZtpxWAEPe4LHXE1UC/B1MlHWDY8eAzB7R7+5mtPqid3LnebWuDS5ueTe3/OM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Eo0LCPNpfcXEzK1OaqZ9vwOb9aK7rgNFgm8QWC77pN09lR+a2
	bUot8BpyjoxZoHArTG89TixCRmq3c+lpSOZHGCwpYfvVqAvSVt/4XextKiSdApSoccHDfr3lqY2
	OKFaR5Nq0RxkJecUGX+hKdeMHtCSo2tY=
X-Received: by 2002:a05:6808:11c7:b0:539:dfe8:9960 with SMTP id
 5614622812f47-5640de0f2bamr8850934b6e.56.1793717392538; Tue, 03 Nov 2026
 06:49:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029214219.1035176-1-imv4bel@gmail.com> <20261029214219.1035176-3-imv4bel@gmail.com>
In-Reply-To: <20261029214219.1035176-3-imv4bel@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 15:49:40 +0100
X-Gmail-Original-Message-ID: <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
X-Gm-Features: AclHuK8zhh9M8Ej8AYQXAAw1VHdM8fimcEAeuD8qgg1yWG-Nxe-lIMO_Y4uRs9Y
Message-ID: <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 22:42, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9=
crit :
>
> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementation=
s
> of refcount_t"), default builds implemented refcount_inc_not_zero() using
> atomic_add_unless(), which provided full memory ordering on success. The
> commit removed that ordering on weakly ordered architectures, allowing
> accesses after a successful reference acquisition to be reordered before
> it.
>
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> lookups and in inet_twsk_purge(), where the socket is validated again
> after taking a reference.
>
> bpf_sk_assign() can receive a socket pointer obtained through BTF
> without a reference. Use acquire ordering when it takes its own reference
> for a refcounted socket.
>
> Use refcount_set_release() when setting refcounts in the SYN cookie,
> TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> TIME_WAIT smp_wmb(), which separately orders the refcount store before
> ehash publication.
>
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of re=
fcount_t")
> Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_=
ID_SOCK_COMMON")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---

Lack of links to prior versions is rather annoying.
