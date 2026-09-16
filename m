Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46A3C98B7;
	Wed, 16 Sep 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584177; cv=none; b=C0KbE1TsbJBC104fHG0rYGeFOKRiXOoDAW6u7EYo1AuqzbCW04AG9bJmjdWVG/vPSlSIu8uzeVZA2DhmBNeorODv0D5Fxk+mh89jqmBMIkiLBFlHVytF0/qVS9Fn+I8K3ARtHhmQeyif6XYwNcp68HcC+JCWtHdAaZjPRUpBIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584177; c=relaxed/simple;
	bh=3HgUrnuP2erBOiA7BMhybyEvvemvNmOfPooyKMYn6SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+7cNQAFyxbi60Q7+n3olfWqLThOlD/jFzCHIo/21GFqNi/Z0vSIWy0CWoCKcBqq1AbuC2H1UQJOteg0sTfPm+t+mfPn1HnyYHAz4Y5nPL3qqV5wzbBI5qP76lgiOQVDmT90KEvf0bCkBqZ7o3FCEfph/n+WWooqQSVjzWgfptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QNuNs+kc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QNuNs+kc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z1m//Ei1DrFTZchg2mhwA/m56pbXWePDZZpDBz+TEPU=; b=QNuNs+kc5fTybDDlE8iRT1oXch
	13nffS1GpVi8WbRJo8C2OSgksybHXqqIozh+n9Cw/GLQIFR64z4Ln/A4Mgmv4PqZKZRHgiW9IeRrY
	kwUTyBhtttYu7ONTnrYT0GrEzE2faTWTbetgnRQZZy+VDZJdN3uooBNXGL9ITQIhHHco=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6uaS-005X7C-BW; Wed, 16 Sep 2026 20:42:28 +0200
Date: Wed, 16 Sep 2026 20:42:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
Message-ID: <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>

On Wed, Sep 16, 2026 at 12:24:44PM -0300, Matheus Alves de Almeida wrote:
> After an rtl_fw_write_firmware() failure, r8169_apply_firmware() does
> not release the firmware. A TODO notes that it should be released
> in this case.
> 
> Release the firmware on failure and remove the TODO.
> 
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3c37c5a6c..c54423cd2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2596,12 +2596,14 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
>  {
>  	int val;
>  
> -	/* TODO: release firmware if rtl_fw_write_firmware signals failure. */
>  	if (tp->rtl_fw) {
> -		rtl_fw_write_firmware(tp, tp->rtl_fw);
> +		int rc = rtl_fw_write_firmware(tp, tp->rtl_fw);
>  		/* At least one firmware doesn't reset tp->ocp_base. */
>  		tp->ocp_base = OCP_STD_PHY_BASE;
>  
> +		if (rc < 0)
> +			rtl_release_firmware(tp);
> +
>  		/* PHY soft reset may still be in progress */
>  		if (tp->phydev)
>  			phy_read_poll_timeout(tp->phydev, MII_BMCR, val,

If the firmware cannot be written, is the device dead? Should this
return an error, so the caller can abort the probe?

       Andrew
