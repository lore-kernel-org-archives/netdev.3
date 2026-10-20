Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454916;
	b=S8/rUWFjnzVBJwr1twD5zsd0LHClIa5GPkj0he/RjksSdFjM0GC8F3BoHs1QSdpBUoFi
	 EQQmc6h6WUmc/9W+SQopkzlGQX/V2tFnyETGHmguneRdSeAo7725TYtDUdCiKekKGK89n
	 s8DhGoQlj7mBH4kzKxbIaD/H0V8NhuS2jnlziOc71dRNL3eEmeE7Ssl9vQkDRwxd3ckLF
	 7BycIeYKS4mkjP4zr9Fis6V2gSndyy3qDlAWgCF+K4bWY3uh3k7G/Y8kAORExSOJxnuaf
	 51lKJ6y6w0iDCHVwXdOVpVTv/1hXILFhESU+oBMRknG1Zi54RG+bS71AOi7sptZdpmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454916;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=XrES0nnZmNQvejovFCK6JN6ubaAdWpRVm1jqxh9GRiI=;
	b=WE5zeCl+4UWgP6A2gW8bREWra9Xi+w0Oa3hwke5HaLUNt06Kzi5Q6lq9s6FGvH/vwRe/
	 AU0bBV20GDQDLW0UxzpeU1+A30Gi9B7UqKRPVoKiosoIiPkHD0c7ZEwxGPZ/REwXoMBR8
	 GW9kpgEJg52IkPKIgw9AM6XG2Qulr2MJfAuO7i8sntJA6S/PrQbx2+thTz5LHivTn+a3P
	 xRMhWksnqgDuxnov54eTY+nWY/Uli4vneNRE6RzVh4j+q4zQdzWzB2jXXZ8P9ZTfYwwA5
	 fE9SD9i56G22McXbgd4106DOPdlCu43M3UAEBXfgl5900efLOiR9Xj8pYlMsDu25RvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mne+8Gu1;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3357606A319;
	Tue, 20 Oct 2026 00:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3357606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mne+8Gu1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XrES0nnZmNQvejovFCK6JN6ubaAdWpRVm1jqxh9GRiI=; b=mne+8Gu1M+8AB66REq8iZBT4YP
	zrl+irFzqgNryUw6SF+SYEW3PxXq5RXhW/rN5NqstXNhzXpp6FMso12kR3nVhA7DNgwTKljmqJnGa
	da5tMMiGQ2S7NFktUc8tKuPCQJJckvrSsOLXp9BeE51YwoCFjZOcET4BYAwd/vhD4EVw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIxOv-00Bj3d-8x; Tue, 20 Oct 2026 02:08:21 +0200
Date: Tue, 20 Oct 2026 02:08:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Alex Elder <elder@riscstar.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
Message-ID: <2bd6d040-6e28-4323-b02e-c8cf11635b24@lunn.ch>
References: <20261014223100.304486-1-elder@riscstar.com>
 <20261014223100.304486-3-elder@riscstar.com>
 <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>
 <atI1IK6blP-vumLQ@aspen.lan>
 <fe13016b-ebd6-4a2f-a07b-324f46b456d3@lunn.ch>
 <atZJBaHU2QQGwcnG@aspen.lan>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atZJBaHU2QQGwcnG@aspen.lan>

> I have spotted a very obvious flaw in my reasoning above: the special
> case logic for FBNIC that suppresses the initial XPCS reset.
> Unfortunately the version history doesn't mention what bad thing we
> can avoid by suppressing the reset (perhaps a reset can clobber values
> such as PCS_TYPE_SEL that are injected by the firmware).

At a guess, they want to avoid disconnecting the BMC, which is sharing
the link. The firmware is probably doing an initial configuration of
the PCS, so that the BMC gets link, before the host boots. A reset
would upset that.

But just a guess.

We need a better story for links shared by BMCs. phylink should be
told, so it can tell the PCS to be extra special careful not to upset
the settings if they are already good. It can also reuse some of the
WoL code to not actually down the PCS, PHY, SFP etc when
phylink_stop() is called etc. But so far nobody has stepped up to do
that.

	Andrew
