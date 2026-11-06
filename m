Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966072;
	b=pY+bcWY6/OcjIbLmxcJkk69ugGikWc0C4XqDLb4u7EaNpSDzcv3v+f05U3tbeiNiNez4
	 ji6dDQZ2hKVew0prDdF3TzdYnPI9J4rVszdktaMOGDIKix3IASaD7TUn80bYiW1G+ZWA2
	 G/iF1iMVbxfhGs95EQ56WWlJ34VfuHXevU/kpX38lBQL4pmXwTf54j/dUurvgZ8+tcHfP
	 2oqVXHva1UkNe+F9gAjFqbXK9vt0gFm62bHKNddG0QBfDGDZRJUsWIZSyXc/3CfUcyT52
	 /q13HuWhgbnFNJ/XcIMmX9uSLsYwbTEdKoJHwHem5KyTgkIdQlPIz6fa0UJfQT7bL+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966072;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=pB0iZgKEny2fvSR6eS1A0tzFJUrMX/Uyf3/srhOTE2A=;
	b=mnWvUPuGmRXhW3zXs4WE6phJAYjN6UKWnLrIOls8L69EtHXX36eHHtSGbiroi1efiIx0
	 ilY6/INJ5xJSqz4o1SzJ1PYrmRNgP9JJkoTFrId+9V4Y7r0yWr/ZM9iBT2S38JPcGExvh
	 taAIKrdsWjk0gH4DBXXH3IrFAkYG+VMYSdXK7Jo/1uC/1yMUFv2bFAppgrBBhwUjk6J2E
	 0RATCLB3JeaHhG9B9DQM3/inFsZRTareza8Dbsiz246f2DcrWZ/FXwkoVTCWcpCixE+Fs
	 nEbEQbN7Eu68nPGk0tt3Y4bHk6iFPBc/NAhCLUpWWG33Zncu+pRW8ATsCUT8WivF4LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="WLxq2Wd/";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66325606A32D;
	Fri,  6 Nov 2026 11:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66325606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=WLxq2Wd/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pB0iZgKEny2fvSR6eS1A0tzFJUrMX/Uyf3/srhOTE2A=; b=WLxq2Wd/hptJdFC/EzGqrSGlvq
	yIsyA3/bgqiOO7kXsrqke/n5XlMt/7rMp5rvXYbotyo3YWNAx4jWx5ZyUKaDhyzaHA8TGjvkQnoC4
	b+rPKv93sD7Q3rDWIRvszfrCcPo1ljWrB2BEiRjk4sf67HZKIKvePdGc4LKqsq8GmuJWx70+yIVvK
	KGjgOKsduh09JDUqgNgCZbOVPeDyn3J3pdbuKCHA+QJcYPDueKIiP3ZwFnfCT4PwFXKu3ncEQYe5m
	47Q8IKHNhMeeqo3oM51IHdG3WdcJg30YMCtu/3tjuvktCpGmXHsqDXJ42Rp3oPveLqIh9fGGIhtDF
	gl/MdH6A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPIWS-009GUp-0P;
	Fri, 06 Nov 2026 11:54:20 +0000
Date: Fri, 6 Nov 2026 03:54:14 -0800
From: Breno Leitao <leitao@debian.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Ali Tariq <alitariq45892@gmail.com>, netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@kernel.org>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Chukun Pan <amadeus@jmu.edu.cn>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Tomas Hlavacek <tmshlvck@gmail.com>, 
	Muhammad Bilal <meatuni001@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
Message-ID: <au2_yS85zJYqOaYm@gmail.com>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <auyG7hGJtMzV0Gbi@gmail.com>
 <6c36ec6d-5bc8-4ac3-8ad0-79eac7873b67@linux.dev>
 <DMO12HWY5N64.2IJ5XMUKM8WWR@linux.spacemit.com>
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
In-Reply-To: <DMO12HWY5N64.2IJ5XMUKM8WWR@linux.spacemit.com>
X-Debian-User: leitao

On Fri, Nov 06, 2026 at 09:41:31AM +0000, Troy Mitchell wrote:
> On Thu, 5 Nov 2026 23:28:31 +0100, Vadim Fedorenko wrote:
> > > This would work, but I am wondering if it would be possible to call
> > > rtnl inside the _open function, when dealing with the PHY? in other
> > > words, shrink the time rtnl is held.
> >
> > +1, especially in emac_open() rtnl is needed only in error path case
> 
> emac_open() and emac_stop() are also the driver's .ndo_open and
> .ndo_stop, which the core already calls with RTNL held, see
> Documentation/networking/netdevices.rst +214. Taking rtnl_lock()
> inside them would deadlock on every open and close, so the lock has to
> stay in the PM callbacks.

That makes sense to me.

Reviewed-by: Breno Leitao <leitao@debian.org>
