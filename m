Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7862367DF;
	Tue,  4 Aug 2026 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848472; cv=none; b=cnxZuFRVJd/WCpdr8Zec65q9/aXMxAjbWQjbs/zZWVOtEwmGESPek29T042bj6Ypq++SIOfI48GIpMUAnUARrPTWzgbgYRNVR70rw1QnuuHNhZ9kTmGu4oVPPprEnEsEQHgJvWq6tI1+B1QbrxAYEC73wVml0WRjGdQQqXdr2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848472; c=relaxed/simple;
	bh=GghmK73lGDhJPo+ZGVrMVuOGucOVnfFHdols4fzazhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXMMvAPVbVdIzEtC1NpgKWMjohjGcUHQkignxQd08n3nRuUgBc/m2j41JB76RMbhmqcs3Obyz3ko5RM/qZ8Sy9yFCWztD5IE+uWBOn/Qz8kz/QG1ZLN8OTbojzyxSUGRt7dgvadOcQNSv+vewKhrXMeBoEDLUeHEe0VPRUtCcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zkhk2nuE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zkhk2nuE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RHqOtFViWLom0UOkJ7evWITdjcrMvUN59L7Fwdq263g=; b=zkhk2nuENDPn5x95KTAqfD262P
	hntbLHyspiSQ9VCoSovjkU+mVq0X72P+V7u5HjQ8wB34FT1ewu442YEUzA2Izx/OhByY3RaZWw9zT
	j8zJMhLn8cO8WW+Ih6hPSbeST+xBOGwWAISWeb39CbRdxtRoR/WmchrZ638yLXC0mbUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrElL-00FzOx-6C; Tue, 04 Aug 2026 15:00:55 +0200
Date: Tue, 4 Aug 2026 15:00:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mediatek: add EcoNet EN7528 PHY
 support
Message-ID: <f176e285-bd19-4a17-8b79-d19c76ba9f81@lunn.ch>
References: <20260804103321.3331802-1-naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804103321.3331802-1-naseefkm@gmail.com>

On Tue, Aug 04, 2026 at 02:33:21PM +0400, Ahmed Naseef wrote:
> The EcoNet EN7528 MIPS SoC embeds four Gigabit Ethernet PHYs (PHY ID
> 0x03a29491) behind its built-in MT7530 switch. They use the same LED
> register layout as the other SoC PHYs handled by this driver, but their
> LED controller powers up with its external control disabled, so the LED
> pins stay dark regardless of what is programmed into the LED control
> registers.
> 
> Add a phy_driver entry for it, modelled on the Airoha AN7583 one. Its
> config_init callback enables the LED controller through the LED basic
> control register, which this driver does not program for its other
> PHYs, but which the air_en8811h driver already handles as
> AIR_PHY_LED_BCR. LED behaviour is then controlled through the phylib
> LED operations shared with the other PHYs of this driver.
> 
> The LED block is shared by the four PHYs of the EN7528: the LED
> configuration programmed through any one of them applies to all four,
> while each PHY still drives its own LED pin from its own link state.
> 
> The EN7528 PHYs need no efuse calibration data, so relax the
> MEDIATEK_GE_SOC_PHY dependencies to allow building the driver on the
> ECONET platform.
> 
> Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
