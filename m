Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713317;
	b=xXWmTCgdQPKFNkdNcslzozrVlCyOlDjCw55XxQIuwMiFTf9vVOx9ZALzO4fTd7E2L2mG
	 QffFZ8BQ5KanpQv9RTrrYs6wVq/7n0Pz9ZZ1yXBS0QIW2JsjRURU4Ak2coPiIe9MSsIrd
	 W2bLmELCtaeblcVaJVHaiCbJsXGa20SckKeqJXE4Qy9GZxifhrQz7TmRoMV7+rmNvS4Ri
	 TzmoRoOBFGpNQnCxpEadIsuW/eK4DILa24Oxuf6cs0nMu1+OVUKdUFV43rnGHCSCfmJNf
	 F2t9fAmxzI14m+FtpDjr0BQvJoTB9F5CG1gldZZVAkYZGuRlFDSpB/khGL1DNzkX9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713317;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AednhgQJnjavLPaTDw85fSfXEn6q/KrQAf7U+CZwFaY=;
	b=CfuB+I9+sx37zRqtKQvhz60YpuHNpYCco5QU2UD4mCR2TudFWBmGZLkVw+y4ec9bFQF1
	 s9JtY3BBtLi0fXKSjEu5xFx/yiDaRdE7MlYYroGXYzE997Hz3LJQlBE1znhKa+IWYQH1L
	 AEeOWTBsEf+PLVi/8R/RO0E3M11zpVQYObMKfGhNDc5/mZ32WLedJPSj//BWFgrVN3rtc
	 RCvxuuzFJIgws5hF9BA5X+0w3iLWNopf0Y758Y5+K7nDviXNB+Fun383M9zuIGU2Snp7t
	 uAIVKlH69Q0qcGN/IWA33fbJoFPXsuc2t5GxDl9eEPSAbdkUUBu3Z4yKY+yKgLnUHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LyZ6HfBY;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AA606A324;
	Tue,  3 Nov 2026 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5AA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LyZ6HfBY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AednhgQJnjavLPaTDw85fSfXEn6q/KrQAf7U+CZwFaY=; b=LyZ6HfBYpyTcLCrFvCBrJjgU2H
	HpD+e1kSfGIQF2C45rRgLMbRwZywqiv7PmGA3mN9ko8wL7RWg/souxRV4X/ndDgMgums0GENXrBKJ
	Oh2FtR2DKNoywkAQPtJAhaaRL6zv2DssikKLdYAxCYsFEPxH3g3+ZgcAtO6V63VsIVNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEll-00E4CV-1i; Tue, 03 Nov 2026 14:41:45 +0100
Date: Tue, 3 Nov 2026 14:41:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: me@marleb.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: register hwmon thermal zones
Message-ID: <587f01e2-a7b0-4355-9bc1-cbe73b2331f4@lunn.ch>
References: <20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org>
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
In-Reply-To: <20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org>

On Tue, Nov 03, 2026 at 12:21:28PM +0100, Hleb Shauchenka via B4 Relay wrote:
> From: Hleb Shauchenka <me@marleb.org>
> 
> The Realtek PHY hwmon device exposes the PHY temperature, but its
> channel info lacks HWMON_C_REGISTER_TZ, so the hwmon core does not
> register the sensor with the thermal framework and device-tree
> thermal zones that reference the PHY cannot bind.
> 
> Set the flag, as the Aquantia PHY driver does. This lets the RTL8261N
> sensors on the Zyxel XGS1250-12 B1 drive the chassis fan through
> thermal cooling maps.
> 
> Tested on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55: the
> three PHY thermal zones register, and an emulated 85 C reading on one
> of them (CONFIG_THERMAL_EMULATION) switches the fan on through the
> existing 80 C trip and off again once cleared.
> 
> This patch was prepared with AI assistance (Claude Opus 5.5 and Sol
> 6.1), which also helped investigate the problem and run the tests on
> my switch.
> 
> Signed-off-by: Hleb Shauchenka <me@marleb.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
