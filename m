Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCCC37267A;
	Wed, 20 May 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290243; cv=none; b=SfYPQ1A+rCR9fEAvZZUyKQS5afg77fxkI170VXzIhGzHSCMBCjd06G3QRgPMIyg5jblG3NWguAaMtSIsgOS72SRgURdTdPJf2shfC24klDB3HQ4WYntBt8E3jTJMXy4kLFmysuMVPHAbffcobbKGzgqRKikwaoTI1qFdegJgGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290243; c=relaxed/simple;
	bh=LVgcf9QcMEjJ9Tm6zTRsuGIFftxmSVAn8erg3o4ykuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntfig/0KLRQHFDWwBfwWU8yVNd/uIBbhO19YfuiwDT/8r+1pv5+eZQg1H7mDh3T5fZc+QNpdzqUCXoU/r8FtXHSEf5MF5CDq3Zdy37SOJd3ddxJwAJsuPBQeUSNhleXyZvGmX+sz3OdeUN+85HXhd6eL2919fi244vu+BtRMrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fhvox5ri; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fhvox5ri"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T57j/RjWbNfSgvM8NQpxyNYnlgIY8I5zNwVPohjLObg=; b=Fhvox5ricsEAyar19CUX7LcrXx
	qPOySv8bi0rUnWUWHvCyhrBe3HfD3UVtpbnh6+EnG4Zj83xcWn0rG/LjnrcZ5x+74bANdqkh4Tk/1
	uuieqwXdZ1N9tgUzPw9RrJaUEyg0AskFBWB6mSCbfP5KcAkXou6T6iLEMaMN6SmORcc0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPifT-003qxS-68; Wed, 20 May 2026 17:17:07 +0200
Date: Wed, 20 May 2026 17:17:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
Message-ID: <c7314c0e-fcb6-4484-9144-57e44a42f270@lunn.ch>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
 <20260520101310.128969-3-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101310.128969-3-minda.chen@starfivetech.com>

On Wed, May 20, 2026 at 06:13:09PM +0800, Minda Chen wrote:
> Set RXD and RX CLK pin drive strength while in YT8531s connect
> with RGMII. Need to check 8531s PHY ID because 8521 and 8531s
> pin drive strength is different, 8521 can not call
> yt8531_set_ds().
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/net/phy/motorcomm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 688679457ef9..3977ec5e45f7 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1697,6 +1697,11 @@ static int yt8521_config_init(struct phy_device *phydev)
>  		if (ret < 0)
>  			goto err_restore_page;
>  	}
> +
> +	if (phy_interface_is_rgmii(phydev) &&
> +	    (phydev->drv->phy_id == PHY_ID_YT8531S))

phydev_id_compare() is probably better, since it takes into account
the mask of how many bits are the version. The PHY_ID_YT8531S has 0
bits, but i did not know that until i looked it up to see if this
actually works. phydev_id_compare() i would be more likely to just
trust is correct.

	Andrew
