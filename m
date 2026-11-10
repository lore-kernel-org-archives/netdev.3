Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329617;
	b=nRUuRaHETealeoBMjUWHLt1/nzDWUqu841nDUN3XSX55Q+aChni/PFn57Pz0DSeT7m14
	 mWdLTbLrueyU44LUnp5egGmuDPkv0fRLphBhUWMQCDnjvc48JNaV5fP4HK8StP1pTrSrE
	 oEnuz5bOF8UOUJdRtzw9o86JJem8U/byrg3jeIyAcUdc8TBtF9AOib1mm8tGaPXV7FvFA
	 mgBITlypyVpx11DwRA4pJk5JBqBJUbjQPFlVz4oQ1HkYhDmt5c3YwHW1yvPGA9fCIKyXC
	 ocH6orexjiN1F7Dav1t+NG7UPBNmwYDr4hoDNDvcHn2/48kdC2eZ82BDS1HhhCgMc7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329617;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=eh4ouN2tdsA/32FCavXUDpw7u+paA+vif/rN6ioVniY=;
	b=Mo5u9M+AJNBhQtdqurHV16diUtANToasedBWjthAuUdO+ICzgBoVRCv8Vq1qfAgY/EN4
	 bp88EFPsNGg7EWeurN3Anfs1K0+XC+yEfylqZcwlvrv2X3geZVzshB9Y3mf9qg8SaMtxp
	 4/fGqP+SzGxKz9sCPIJuFcEuGznPS0QPhzfm/qpahkRhu3hGKkq/yb/kqyJBC6cgZWEsp
	 hnKQ53xLbcMrcJiO/FwVLvkAwVFZjxR7Ayy0tvTdYgRtJPtF/RDfYsk4q/hqNKp0NerGJ
	 wz1NN9bYVNnvD1y3yA1vFxeg7KGlvcNHUruwf+qzxbup0g8aQwvrWvtvDn4rEKC4+tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=e7pdiOi4;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26E60A5BD1;
	Tue, 10 Nov 2026 16:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE26E60A5BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=e7pdiOi4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eh4ouN2tdsA/32FCavXUDpw7u+paA+vif/rN6ioVniY=; b=e7pdiOi4wOuaYfmneIq2bC6hfM
	sWl1U5BNQUIKAOB/D0Hpkp5vufnR/aSpvy/h/9WTYLFvYXkQuyYdI9LKOPjXZDyucU5bn6Kt9khz+
	pUlvUWck/YtRCawoQoYl8vTiyNe2HFb+QquNSXtWO0tzzk3kt1eN5Y94ppPl10rJ6oAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQp5y-00FXGW-2Q; Tue, 10 Nov 2026 17:53:18 +0100
Date: Tue, 10 Nov 2026 17:53:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Frank <Frank.Sae@motor-comm.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: motorcomm: add led_brightness_set for
 YT8521
Message-ID: <598009be-95f3-4091-b3bc-98815c65216e@lunn.ch>
References: <20261110100001.1873309-1-amadeus@jmu.edu.cn>
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
In-Reply-To: <20261110100001.1873309-1-amadeus@jmu.edu.cn>

On Tue, Nov 10, 2026 at 06:00:00PM +0800, Chukun Pan wrote:
> Add support for manual brightness setting on YT8521/YT8531 PHY.

Has this been tested on real hardware? Have you had it blinking the
heartbeat? Shift-lock etc.

> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -258,6 +258,10 @@
>  #define YTPHY_WCR_INTR_SEL			BIT(6)
>  #define YTPHY_WCR_ENABLE			BIT(3)
>  
> +#define YTPHY_LED_GENERAL_CFG_REG		0xA00B
> +#define YTPHY_LED_FORCE_MODE(x)			BIT((x) * 3)
> +#define YTPHY_LED_FORCE_EN(x)			BIT((x) * 3 + 2)
> +
>  /* 2b00 84ms
>   * 2b01 168ms  *default*
>   * 2b10 336ms

I _think_ this is the wrong place to insert these. 2b00 84ms refers to
YTPHY_WCR_PULSE_WIDTH_MASK which is used with YTPHY_WOL_CONFIG_REG? So
you insert these in the middle of WOL bits.

The sorting of registers is a bit messed up in this driver, but i
think you need to insert before:

#define YTPHY_PAD_DRIVE_STRENGTH_REG		0xA010

    Andrew

---
pw-bot: cr
