Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329263;
	b=LeQRTwIfi2KKknP05g9MjQhPQcgZHpBBsjXxYMpeXvBssHOC8ALx4ChtUWSLR8vRrTHy
	 cbSuEfConrS3sLlDM2MNfZ0yApZWyp/6aLULhPQqgNqow2q1lEFw6WzuupURnLuR4dDaR
	 lELYX0G4oIi7DLW6SsHa6lyektq1i0dcU/C42cc9LIlhStujMyHe7qZ4pr+lAwtMlUpsV
	 1ejcBY4eW7QTYA2cS/UBa5jwGLMEXENKTAn1IYj4QxuMIQzhwpOkTLsH3p3pImQ483dtM
	 9DP1kY+GEsuWORDsdTHRP7eZhXRIBEM/M3H7q330Hxr4xLLBM3vsiIiDopYqZwVL07A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329263;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nG9stXQkwLVFlp/SM6Lzv9KwcbHb+1wfgq3qgejLqIQ=;
	b=CLp3Yz5K3vFn8P5Th66h4Q6SqvyXNqXkdR0FJFjMTKKeWlMF9liHbJYe3H5hH2FB2Rxt
	 RNL1ytmCiQh8oT4brJ3zr3O1YCo2a9sEsqv09+3CyI6Fctu4+Z+E4utv9X+erHFSIRGDl
	 9OWQt1VFEjjz6hFMbxCY1TBaslU/5susRiMuiUQMpdrTXLXSTVdrQwc9SxuG+bR9goqFQ
	 aa9jLkVfEs0tWAZPOeMstA6dkTp25IgazXrNzD4GYY78SRGgofJFJO9ZPSpeYOomzOtkm
	 w9Ud6eoz37sWcfiBtDoejQ5ZEgk40SWHxahyHFaYrBxTTCRCeVZ6h7HKcYlGQfIIiLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b="IoRLkDg/";
	arc=none smtp.remote-ip=209.85.216.103
Received: from mail-pj1-f103.google.com (mail-pj1-f103.google.com [209.85.216.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A8606A323
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=IoRLkDg/
Received: by mail-pj1-f103.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so1405836a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329262; x=1794934062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nG9stXQkwLVFlp/SM6Lzv9KwcbHb+1wfgq3qgejLqIQ=;
        b=k8BXJcTmgkJoLFF6q0QZK7xAOiqBUb3wD7gqGkGTlypUzKxeqycJP3qcy1MQh164Sq
         EA7ZmQLie6sCA6lPJ2fl9EhyT77DXdBDpqSe51oCOQy6ISexcCPIvlh7rM5Y5+DWZOir
         nH5VrWe+y3hbz6GCac5seEPz6twsZuZksV0EkWsyWl/5b7O2nQQK/xbZFgX2ROtRvVsr
         RSJEh/e3tLy64VjgyKEjMsXiw4K4Bn6dqiXPWCe/q1w3zgAI8p+CsbO/AkVaxPMhs5vj
         /BrAAZiwaWEIDJpPh2Mk87DFu6Qe52Kah44OU5Cc7RMddy2ZLBlevuKY+JsPPb9Fs2wy
         5MPw==
X-Forwarded-Encrypted: i=1; AL+hErF1/KwbfJAqDERmxgLQ7+alWURcElVMwhdH4FxBMH3UbGhRXc8OZxPQh1NRksuFyyoiJ2/g/gE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wv6RV8mIwRZVQAx3TAFBbSR+m+D0H8U00eFdox6IdMzNkRsgj
	cpXcUeInkVQX6O7O+VATLGHE8sROp3HLYn9sDuyRNP41naUwkr2QN/YIRKQX0YA0p5RlCWnCEfM
	aGokpvavTO+d6hwfJyUKQWjd9IR5oWBro/f0wc60=
X-Gm-Gg: AYBFou0CzjRsOTcQ6JNIT4eK3BPnTXYHkPPTaExd6s/brZwSVmaM0TV/b4WFkXXNlip
	Kug1mJ68dTzRtqbgAPWjwatx4XFlC3H7eNju1/nIgEiaTuaosNe91yQz0Q72copT3TsVOQWbxLL
	QY7UN+MbGWYDDKXAQ/QHfeiZx59RGITtFqA1rObo72MNY5jWAPIIWGYqaHDSX/eNQaXW0nI/UFl
	axwjJeT1F/qZ5SkSmRZF0b34iBD5jVPntrahWOasJ9P9WpshReiJfFpTmMcFL5f/WCTHHovVTA5
	D5ead3uzrRfoNgi9hmq/kPSSPIISTdh7+aAOsVq0A8YqjkzzPBui9zbylUZP56lSydIWpDJL8jQ
	gmw==
X-Received: by 2002:a17:90b:2707:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b166cf6979mr3264778a91.35.1794329262291;
        Tue, 10 Nov 2026 08:47:42 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1690d291dsm990689a91.4.2026.11.10.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:47:42 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794329258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG9stXQkwLVFlp/SM6Lzv9KwcbHb+1wfgq3qgejLqIQ=;
	b=IoRLkDg/XdQGCsYApczobF0xNyOZOVRsSpJaAeYcx8Z4QeSgHjqeionaAzNoKZGOOgM+oL
	LUN63e/LMgVxBdYJN+e5T0DV8vpyjFnXnv5/I8AeILJ1A8QyF5AC0xmKpQ2laIA3oeKy2D
	2Wj2oRk0lyawSr8TLpuq0OlohsoH0do=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 6530d039 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:47:37 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:47:35 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH wireguard] wireguard: device: allow userspace to enable
 IPv6 link-local addresses
Message-ID: <avNKp7OVA7d1X3fL@zx2c4.com>
References: <20261022110039.270335-1-roma55592@yandex.ru>
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
In-Reply-To: <20261022110039.270335-1-roma55592@yandex.ru>

On Thu, Oct 22, 2026 at 01:00:39PM +0200, Roman Khromenok wrote:
> WireGuard interfaces do not get an IPv6 link-local address by default,
> which wg_open() achieves by setting addr_gen_mode to
> IN6_ADDR_GEN_MODE_NONE on every ndo_open. A side effect is that any mode
> chosen by userspace, via sysctl or IFLA_INET6_ADDR_GEN_MODE, is silently
> reset on the next down/up cycle. Users running routing protocols over
> WireGuard, such as Babel or OSPFv3, need fe80::/64 addresses and today
> have to set the mode again after every ifup, which network managers do
> not expect to have to do. For example, systemd-networkd cannot honor
> LinkLocalAddressing=ipv6 on WireGuard interfaces because of this.
> 
> Instead, set the default once, when the inet6_dev is created. That
> happens on NETDEV_REGISTER, both when the device is created and every
> time it is moved to another network namespace, since addrconf tears down
> the inet6_dev on NETDEV_UNREGISTER. So register a netdevice notifier
> with a priority just below addrconf's, so that it runs after the
> inet6_dev exists. The default behavior is unchanged, but userspace can
> now opt in and the setting persists across down/up.
> 
> An alternative approach using IFF_NO_ADDRCONF was proposed in [1], but
> it removes the ability to have link-local addresses altogether, and it
> was reverted because it broke the selftests.
> 
> Add a selftest checking that link-local addresses are off by default,
> that they can be enabled and survive down/up, and that the default is
> restored after moving the device to another namespace.

This is an old decision, but one I think I'm inclined to stick with. You
can't use WireGuard with LL generated addresses, because AllowedIPs
requires explicitly binding to public keys. So you wind up having to do
coordination between the chosen IP address and the distribution of keys.
The solution for Babel and the like is to add explicitly WireGuard
support and use the neat mesh qualities of Babel for key distribution
too. There has been some talk about implementing this for a long time.
That's the direction I'd like this to go in, not breaking the whole
allowedips model, which is what this moves toward. I hope that's
understandable.

Jason
