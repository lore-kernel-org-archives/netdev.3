Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F213DB31E;
	Mon, 14 Sep 2026 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395233; cv=none; b=UwDwrg1kUSpgyB+NuL9tDWUUETtxv/SVrp5TgJ0WcfibRcev0oyTVy+IgjMFXUI6HQ8/BisQUU5Ng3CcEnlEXpdxaAsA0Q77XRBjXa3GGuVgdFaiyKAVADDmuB+qvLHs6FHSUzlhPKl19VLZ2kBhXk2xbBRhQk6cCRr1zh1jOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395233; c=relaxed/simple;
	bh=1futjmMsI2expPcdmklc+okjFKr5WkKAu1DPD8298/E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o+wz7s4UI6QqLlyY+xtdWO8vMQev9brDeU0aOnG/KQC9qOXj0LDxocbWl0lsLOOR4MZ0tDiyJyBMDh8JZzE57Ked04XscbbZ5U3MXk0wP8DZP0KM49XZO7N/gOZtKPfyJtL9RUM+KRf1n3QfkKEepZ1xuAXXBA+2eS3u0Qhkn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=NGygbXnz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="NGygbXnz"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 847FBA91DB;
	Mon, 14 Sep 2026 16:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zL4GN9j+qEpgfvb48xvHGDZ/IXO1UfAIcbN4YfVYcF4=;
	b=NGygbXnzDa5TYHXrmirWH3Et13SdpI/+lpWq1QgOSLRxOVrMYrzUFc70D/SRGBq1lkmL1w
	M0syy5Qwj4mn4cao4eALD0CGvMPQKg/NIPTujt7HosMV7dmsZK4Wbe/oJ48E2byw7OX39S
	MdzRXrJjBFi3sVrGgFG/ZOA5JgV+JoheJ5TlkZFTSQEzQ1zWeXuOm7uJw5mpX9GEbA0JDa
	7qaAzrCIgCj9q/vGt2MAx9IFaazMK4NeuRApIQ3KBm6MtFq9QAyKq+913QAH5jQtq4J2i0
	WJ2MaucRv/VHqREuTehguIvl/y6f67uTa2j6Op+70HQ1IzoDReunGwMHnxW8ng==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:13:46 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 01/15] phylink: Add phylink_mac_interrupt
In-Reply-To: <20260914-ax88179a-v11-1-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-1-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <d5a8a1b794b3b02e0fdaf26a8b412ad5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.9.2026 14:46, Birger Koblitz wrote:
> Add the phylink_mac_interrupt() function to phylink, which
> passes a link-change interrupt received by the MAC to phylib.
> This function can be used by drivers which want to avoid
> polling the PHY and instead rely on an interrupt received by
> the MAC when a link-change happens.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/phylink.c | 16 ++++++++++++++++
>  include/linux/phylink.h   |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 
> 3ec3bb43910953f3d57a4601633d0c3be65e959d..96ed13458e9f399fa911a145613d213b1c4433c8 
> 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1612,6 +1612,22 @@ static bool phylink_link_is_up(struct phylink 
> *pl)
>  	return pl->netdev ? netif_carrier_ok(pl->netdev) : 
> pl->old_link_state;
>  }
> 
> +/**
> + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * Passes a link-change interrupt received by the MAC to phylib.
> + */
> +void phylink_mac_interrupt(struct phylink *pl)
> +{
> +	struct phy_device *phy;
> +
> +	phy = pl->phydev;
> +	if (phy)
> +		phy_mac_interrupt(phy);
> +}
> +EXPORT_SYMBOL_GPL(phylink_mac_interrupt);
> +
>  static void phylink_resolve(struct work_struct *w)
>  {
>  	struct phylink *pl = container_of(w, struct phylink, resolve);
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 
> 1dda5c7ed5f146930d1acc6f06072e6755167af6..f6c1db837fb5062c6d42ffc6489ec06ae84e535b 
> 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -768,6 +768,7 @@ int phylink_ethtool_set_eee(struct phylink *link, 
> struct ethtool_keee *eee);
>  int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
>  int phylink_speed_down(struct phylink *pl, bool sync);
>  int phylink_speed_up(struct phylink *pl);
> +void phylink_mac_interrupt(struct phylink *pl);
> 
>  #define phylink_zero(bm) \
>  	bitmap_zero(bm, __ETHTOOL_LINK_MODE_MASK_NBITS)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
