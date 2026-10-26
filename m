Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030058;
	b=WmTql3dcyV/uMg78mP/sQ9/PzqWx5ij+SFmh/eDmhYpGWhbP8X4gsW43ybUWG3C2ioe0
	 UflpLjuzGta4sf8zhU/kUxjkgOc6yMuYrcwc7lzcpL6Bh4g8JdLTvPzeXDktJ9aEgijGS
	 +L40uyt6Jqa/rk9Ky6t+WCcF9xbJ2jz5scQlX+fPXI/U3Nmb77j4NUwOn8ddXSd3WGTq5
	 dyN9umecsASC4onFkyan/RRwqm6IVXKxfHsKDykApwZggUiY8BeP6Y7qjJyTHIqsuCIsW
	 K+vSSKPqkgh3AzKjKQES7BcCuMDqAVgcjEypgG8TMvg251whtQedRy5QG0uQ2h7BTYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030058;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=IycnxiQMyYhEU/DNF4Q4FZyvZF7nP2Xpy62Lwx6Dm54=;
	b=YFBCBqFFWQ0xmUROSbtYr+Fu5NZ4r4CGhfgB3O/PIXuuz4MjngE7h2CKpWr1nsLwHV1p
	 h83sDllYo6mOQyd/xSgXkKZO+P3U/6hjISHfTjurcRL6lSl9oGcyc8H0Umv9Q2H1HN9ly
	 bJ4jxqQwLjbZXZhdTmIYUnHBfQ1g6ZCA/chr9/vC32feGUC3rnyJlr9e5WAwX2K7ExOnF
	 UOEx92m/N8JBvWTUMNZCH7j8uELd5vDAPq3y6+nMb5YZ2ICahdl+mbT/NHDxa9uymSdYq
	 2Bn9cJjpeMiprS4/rVO0TmqWJNvmAhlLP6wyp/LcV1IBfSlZqUq8njZfLinHpGxtzMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XD6CRy0K;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893A606A31B;
	Mon, 26 Oct 2026 15:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5893A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XD6CRy0K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IycnxiQMyYhEU/DNF4Q4FZyvZF7nP2Xpy62Lwx6Dm54=; b=XD6CRy0KgZ3oboyZNamATYZ2sp
	1cXgChb/oXTKNp+QPWblXjEzQMfrCpKd8EQwbPA0G7byVXZnEaEerFBnWCa9dd4mVe9SBki2j2peH
	9LHqCFnfBCYziRYGXusbcqN6xdcI8p16fs3kB4fnvMsmV27bKNULA/V9rBrKBzx8tBNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLN1T-00CofL-KR; Mon, 26 Oct 2026 16:54:07 +0100
Date: Mon, 26 Oct 2026 16:54:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Ostertag <martin.ostertag@gmx.de>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for ZYXEL PMG3000-D20B
Message-ID: <929faa64-3e28-4754-8491-25e3753fa13b@lunn.ch>
References: <20261026135757.100139-1-martin.ostertag@gmx.de>
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
In-Reply-To: <20261026135757.100139-1-martin.ostertag@gmx.de>

On Mon, Oct 26, 2026 at 02:57:57PM +0100, Martin Ostertag wrote:
> The ZYXEL PMG3000-D20B GPON SFP module reports LOS and TX_FAULT in a
> way that prevents the SFP state machine from initialising it. Its
> EEPROM also advertises autonegotiation support although the module does
> not implement it, and the module needs about 60 seconds before it is
> ready.
> 
> Ignore LOS and TX_FAULT, disable the advertised autonegotiation and use
> T_START_UP_BAD_GPON as the wait time before the module is assumed to be
> initialised.
> 
> Tested with a ZYXEL PMG3000-D20B in an SFP cage.
> 
> Signed-off-by: Martin Ostertag <martin.ostertag@gmx.de>
> ---
>  drivers/net/phy/sfp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 85e57a1..578d4d8 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -472,6 +472,18 @@ static void sfp_fixup_potron(struct sfp *sfp)
>  	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
>  }
>  
> +static void sfp_fixup_zyxel(struct sfp *sfp)
> +{
> +	/*
> +	 * The LOS and TX_FAULT signals are not usable on this module, so
> +	 * ignore them. It also needs about 60s to become ready. Use
> +	 * module_t_wait, as module_t_start_up is not evaluated when
> +	 * TX_FAULT is ignored.
> +	 */
> +	sfp_fixup_ignore_tx_fault_and_los(sfp);
> +	sfp->module_t_wait = T_START_UP_BAD_GPON;

The other quirks call sfp_fixup_long_startup(), rather than directly
setting sfp->module_t_start_up. Please add a similar one line
function, and add the comment about why module_t_start_up is not used
there.

    Andrew

---
pw-bot: cr
