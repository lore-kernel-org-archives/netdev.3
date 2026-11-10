Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329852;
	b=mnhnGR37E5D0KNZQXxZXZMB9+JUF7aSkzkRVedcVGm35b1GYtns0SaWOJ3PycH87OXQv
	 LdqFgldpVTKDmHRxJuHYkZxd2eAmGw0WAs+gi1Vlbr+WAw5rp3M0/joRPs4gSJHUrTAsw
	 dTPUXINJk8O39duKAKv0wWBtGQyK5K1wpXsvl88Rg0cIOQsXp2geelFLdFIoM9C/1IZIX
	 tFe9TAjsKgohwhA9jR2Of3Ki8Q25Oe39xRX1TTzr/EPCg0/QP5LhSHP4d5q3GuH1dRVLH
	 KbsNNsLf5EJLw5SaADrNNoKPmdo6DzHn1VN9Nm8FdyaTi8bOmEOZmVQPRRYiP4bMdpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329852;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FSVjfbOy+6Li8/mrEmgfTAZk9pjE0e6I6pX2kMrymD0=;
	b=akoLaDfeAv+R0WssGszygDDUEHnjOo9M+Y8ia2nwv0zg3+lSGJ+SZCTdVF8c6PaFuZXu
	 JLSMxe3TTwiQ+F0ccNiCEZQzxT0P7iyMnxMrZxYahx1skwl9iT8tikkFX9GgkN05lL7h1
	 U7b0jYAW1PQF/LtCcSMWbihB8w1ZrjEQsS82Q+v/1/kQTCvuI1Rn6ZdcgDiq/3vZ9DzlD
	 sdhThfBBdi0R3j6N4VDqfr6DxU57bpljgpcTCCenGXK44wfdBVdW8OteDEP3GTnuGNpq7
	 Hd92Wbjy1nR5cnJhTga4tYxSnwptYdxQc7A/hPAagGPiq2BZM6e1DEVj1jU7BzZprnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=igskeO0d;
	arc=none smtp.remote-ip=74.125.82.231
Received: from mail-dy1-f231.google.com (mail-dy1-f231.google.com [74.125.82.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E73606A332
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E73606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=igskeO0d
Received: by mail-dy1-f231.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so4437800eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329851; x=1794934651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FSVjfbOy+6Li8/mrEmgfTAZk9pjE0e6I6pX2kMrymD0=;
        b=adcPGSn/ipWarKWumeWbCBFlywnNnjXPl7CXHgEY8Adi8QGStXPzJbrIJcMN4ma0IX
         nOSAd+8sdEquGAgyizaFbMmHt9EnjBiLumX1Tb9j2mdDh/eUF5nq8Kr161lbHwg6h6bn
         Pwx2GwrbGnCYEAawjAQ8J0jVovRXsPUZl9qxdF+luq6+h7aClyY5rp3bVwR5CBcYSqiT
         Km1giqxCEC5EuPgooCOUQSMAi4OQluZmOa/UaMv9opi+sN/0bMAZSud6pdkEctlESFjf
         3vBqYGBLfwpNlZ8QWk1cfH2TML2qNHoJ/+JUtM7koN3jSwVsGjiBHfIK+EdpT1s+ov9r
         D1Sw==
X-Forwarded-Encrypted: i=1; AL+hErEmn3K/7bpsi3cKBDz0WnbPVq6CI9kmcuTW/r3oz9BedJ8Fyqs4Xa4xigoXDElNWlI1JmQA11w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sNhqEpWS3uppCWknPtmD4BUxZjWvCCQjha6j6UUCzw/T6Uzap
	npm1Dzp/Zv4ckZhfsOapIfhJnAs8mriVzpmFLehqhuyapqfUOPz4DeAuDjsBJu4YkMShiZFIu4U
	f8h0jvyxsn79jK/1sWM/tKd8TCV+7gD0rPP4Vdxn38+SCl5xIhA==
X-Gm-Gg: AYBFou1gKCkHlwUl6qxNBYt7nexeEJL62A+mxi1soYf8j4S3tdF0kwD9S1x0oTjVy6V
	iBkVH3T4dBNwbqgo+PP2Rho/8KNSUqQWjVM2Ewfq4zNJyrtC1TPDMPgxhFjX9x4yn1jJo1wW1Al
	IhYLGcAELo3xujuX5Wm5N8TUyhoKDzzpqyLxczrWDm4ZT/oXMCV8L+Uu9fLaeUtTUh8sT375nL+
	hBD9NVSToBydIpSDXqQ15cdIPEaNkPGIAhvshaXJuCJQjerX4h6MEmA3hNT3kvPPvEv5EVbOVBF
	WsLcPvhXPHnAQuSKXhQijik28LXajrM8FXh5JCqqsfUtdillj/gJWI6hh01wLFigXPFiH98XAzn
	BIQ==
X-Received: by 2002:a05:693c:8357:b0:36e:c07a:426f with SMTP id 5a478bee46e88-37520218a2dmr3752045eec.39.1794329851138;
        Tue, 10 Nov 2026 08:57:31 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3751fc3a433sm26539eec.9.2026.11.10.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:57:31 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794329848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSVjfbOy+6Li8/mrEmgfTAZk9pjE0e6I6pX2kMrymD0=;
	b=igskeO0dU3czlXFLU3ba5Ctyixi/3mpmhqAyoR0afH1i5cZtn9wxirqKTypweqxdarSCf0
	nm+3JYM7Npe+xc+vRZSGXIqiuK/nnDRDiONzihYmVdv+yteq6kdi3HIfWWkoB2UwyhP5tR
	ek4m/meE/BlTy3JjB9lznpSNB9RYcpU=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 919b48b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:57:28 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:57:25 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Ildiyarov <alex@badcode.im>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
Message-ID: <avNM9dfdW1uULJUf@zx2c4.com>
References: <20261105141006.95083-1-alex@badcode.im>
 <20261105141006.95083-2-alex@badcode.im>
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
In-Reply-To: <20261105141006.95083-2-alex@badcode.im>

On Thu, Nov 05, 2026 at 05:10:05PM +0300, Alexander Ildiyarov wrote:
> Peers, allowed IP trie nodes, the per-peer dst_cache and the per-device
> hashtables are all allocated in the context of the process that
> configures the device over netlink, but none of these allocations are
> charged to that process's memory cgroup: the wg_peer and allowedips_node
> caches are created without SLAB_ACCOUNT, and the hashtables and
> dst_cache use plain GFP_KERNEL.
> 
> The amount of memory is bounded only by MAX_PEERS_PER_DEVICE (2^20) per
> device, with no limit on the number of devices or on the number of
> allowed IPs per peer. Since WG_CMD_SET_DEVICE uses GENL_UNS_ADMIN_PERM,
> any user who can create a user and network namespace can do this, and
> thereby escape the memory limits of the cgroup it runs in.
> 
> For example, a process in a cgroup with memory.max=64M that adds 100000
> peers with 20 /128 allowed IPs each grows Slab by ~790 MiB, yet the
> cgroup's memory.current stays below 1 MiB and its memory limit is never
> hit.
> 
> Fix this by creating the two caches with SLAB_ACCOUNT and using
> GFP_KERNEL_ACCOUNT for the hashtables and the dst_cache. The keypair
> allocations are left alone, as they happen from the handshake worker and
> are bounded to three per peer.
 
I wasn't aware of this trick, I think mostly because most drivers don't
use this. Does any other part of the networking stack do this? Is this a
normal thing?
