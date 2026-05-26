Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8433FE36E;
	Tue, 26 May 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804539; cv=none; b=Ct7OQw+EmMU7TXU1BEVLcRkzObdxM+nP50gjIqmYKDCmrpRb9J1sYEGHeLCY4PhcXVd5yEgr+Yutv7DuZohHWNpqCAOxI+UP2mqAtFPVl5yJu3bhONrIFwW2wJxjGO1veTnfs9RR15KUknl5SNqoV7JWeQU8ZWu9ZQBeeuJVp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804539; c=relaxed/simple;
	bh=drZNbivCi2A038pOUJFPa3TBsMVcWQnN7UKzLfONLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXGbkHCXLJ9hs77ZgkCbMbW/Iy+Gi0SNrWEQIbVIlqQRQxagf+a3BoH0G6WML+FkKF8rcgttDmR/SMzZnD5B0Rzuro3UOi3xtu48blPcMWvqNreZt4BCSew+HYjxDcOvxZbJuYgCrESBnmz8ITW4T6m09fmlh5gozt43mvAR0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zdY34fYX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zdY34fYX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gi1BDbh4UmeuiwuUW6TVcxqnSQf4WY53/P3UBwkJOU4=; b=zdY34fYXBm6exGHIEF01vzLXFU
	2898yu1gaIojOjvq6x6pr6a5aNtgPWoutgyX7K7oBHPHa80e/Za6InlpemggTJg5A3ltOCUv/COED
	4d2AhzXTy6Kjz9IboLluM0cdIcTCSSRWGM3OoKcM697J6rAcCc5qmrw7suXQDGnkdenA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRsSL-004aig-F9; Tue, 26 May 2026 16:08:29 +0200
Date: Tue, 26 May 2026 16:08:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no,
	ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
	lucien.jheng@airoha.com, albert-al.lee@airoha.com
Subject: Re: [PATCH v6] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
Message-ID: <a0d3143d-df3d-4324-bde3-44846482370d@lunn.ch>
References: <20260524063915.47961-1-lucienzx159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524063915.47961-1-lucienzx159@gmail.com>

On Sun, May 24, 2026 at 02:39:15PM +0800, Lucien.Jheng wrote:
> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
> Assert the MCU (hold it in reset) and immediately deassert (release)
> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
> through a registered mdio_device at PHY-addr+8.
> 
> Add __air_pbus_reg_write() as a low-level helper taking a struct
> mdio_device *, create and register the PBUS mdio_device in
> an8811hb_probe() and store it in priv->pbusdev, then implement
> an8811hb_mcu_assert() / _deassert() on top of it. Add
> an8811hb_remove() to unregister the PBUS device on teardown. Wire
> both calls into an8811hb_load_firmware() and en8811h_restart_mcu()
> so every firmware load or MCU restart on AN8811HB correctly sequences
> the reset control registers.
> 
> Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
> Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
