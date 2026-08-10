Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7342586A;
	Mon, 10 Aug 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379501; cv=none; b=ij83VpA38nGuFrjtHcPNGNHOu2TKD0lh2yD2JjB3vdSpfWW0+DqY0AhXO5h86ukBYm185zFrkZ2tQgNysXUj+ykSzn45DmdGevSoH14KTD7mqXV/YX88mBsAshQfIRKrZJ5AARtzOty+xNlAcAZ6iKDtGs5s3cw4pdnf7ME4rRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379501; c=relaxed/simple;
	bh=UUybkPttml7/P+rTcSQNCHyLXC2rGbrY48tFam0EteY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyvXUKI1EwcfAgVgGd/3J7OsR9oXQVNwM/fYZ0tSJDNlfwZ9JYkG7UmjipvZMI6aTiEPDGdrdBP81qS4+FhJw4PAVBT+CENI9tNZxgdX7tlUHYqdQEM3U3m7nyfofCjKLPsDEi9MrAxSCGBjZ3Zd3t+gv+srsHU44yas7qzHUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dulaZwJd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dulaZwJd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a03sD61gz0cND8RfVQQZFPA4HhLVyS/O1QRWlfEqk4Y=; b=dulaZwJdQfNI0osM59GwS+YM8i
	yddMKsbeiM12zrLLmi7ZM6UnTGiusvWfC6MQtrfuxGG0Do/rRp/Qd8zuogGqspMPW2a+E+PlWCk2F
	RG1VDotZQt/scKoOpZhDi6gVOdVIteyjfzVG/pWqOoXOUNws8Ngi7wQM45mGDgoBtMLyR9oqeE7y4
	vVampryx4GCWrckOtDK9HKApl9hFUZGQNp3Q50UD9DVeIG/JpHLY810TC6HgffVUU/WllolPGda/d
	90Y9A+HZA7WAB2yQJj3BA6MAn+iPOgGFwQvH/+r0I6BCJVuH3Xq4lK5dZqYeH6344adoH6pDBFFkn
	fj1NSL+w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtSuQ-002uot-29;
	Mon, 10 Aug 2026 16:31:30 +0000
Date: Mon, 10 Aug 2026 09:31:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH 1/1] net: stmmac: Fix manage error case during
 stmmac_dvr_probe
Message-ID: <ann8fwpUBYhr6aAf@gmail.com>
References: <20260810150749.458682-1-christophe.roullier@foss.st.com>
 <20260810150749.458682-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810150749.458682-2-christophe.roullier@foss.st.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:07:49PM +0200, Christophe Roullier wrote:
> In case of error during stmmac_mdio_register, pm_runtime is not
> cleaning before exit probe.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Fixes: 5ec55823438e ("net: stmmac: add clocks management for gmac driver")
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3c..37d06fc6dba47 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8080,6 +8080,8 @@ static int __stmmac_dvr_probe(struct device *device,
>  error_pcs_setup:
>  	stmmac_mdio_unregister(ndev);
>  error_mdio_register:
> +	pm_runtime_put_sync(device);
> +	pm_runtime_disable(device);

Confirmed that pm_runtime_get_noresume() and pm_runtime_enabled() are
called  before stmmac_mdio_register()
