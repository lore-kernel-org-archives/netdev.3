Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A3472061;
	Fri, 25 Sep 2026 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334680; cv=none; b=gWV2J6NqA+LreD8GHEU0BOg2f9c4jhenC6VFWWdEekV7HdUrn4pwPvjYgAa9YzlbodRrym2mjyv7tVC1IAh4/92sDmm3tLYixN1fMlS5hdb2mdSP1dP3ZlKwK7jT6O7RzakTxonJM26W+4ln49PNENlFiWnlN1je5ebCcmzT+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334680; c=relaxed/simple;
	bh=vSeCZ9O5eG/K7p1MJHuO7HvlzV5gbYx/iOgQvOdeWME=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=d/wWjfYg1XwpWtTvOMvJABVDe3d4kLPWOENAyz6pVSZEVQBHL/GyRR8DA2D4DpJf4gQdMwOrXsEdGxLKiRxjfmzmGdSMny1/m0jWQUXf8cep7lsep+CZPg2LGT2qjXCZiC/0rfzNx91OPSkF8UviTu2aVaMX2VX8+lJn13L6Zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jnOdvrpF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jnOdvrpF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E430A4A45;
	Fri, 25 Sep 2026 13:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790334674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/ceWdbC+JyNTlmv5IbRzDryAGPP8an2udxzophTzdys=;
	b=jnOdvrpFN5idBDIme4XeN/9oQN0KX0hnyKgEy/ng07IddvVotOduzI3ckMocjBNh/d2t5F
	+xrcvsEtD6ItiuFXbklM01F7GtXooUWCstfKuwwcXJEgHJU6eRq1pnH9KIeGDv8G0n17K8
	teGhB1J7kxcUtWgyQGX997SYkwP/fJV86ZMLFcAqS/04aO+/wynsCZaLTb3n6x2RZHpD7Y
	IPQsLSzOUut9pS5JylAxIXOGQErpkRIu7oiwk3jScrrfzpCXlTEU9F/KPEV146r/yt3/TT
	gzsoPn7yzktDQ5V0iOuKkSCIFh4kELOszDHfYU0FakPlx2BZu6QDX1XwyxyNlw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 13:11:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/6] net: bcmasp: fix OF node reference leak for
 phy_dn
In-Reply-To: <20260922221630.3864427-5-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
 <20260922221630.3864427-5-florian.fainelli@broadcom.com>
Message-ID: <b41bceee7f0a221d52feca688ca95d65@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.9.2026 00:16, Florian Fainelli wrote:
> In bcmasp_interface_create(), intf->phy_dn is obtained via
> of_parse_phandle() or assigned ndev_dn. of_parse_phandle() returns a
> node reference with its refcount incremented, but of_node_put() was
> never called on intf->phy_dn in bcmasp_interface_destroy() or the
> error unwind path in bcmasp_interface_create().
> 
> Acquire a reference on ndev_dn for the fixed-link case as well so that
> intf->phy_dn consistently holds a reference, and release it with
> of_node_put() on teardown and error.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet 
> controller")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c 
> b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index 2ad8a7eac888..7a63a592f158 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> @@ -1298,7 +1298,7 @@ struct bcmasp_intf 
> *bcmasp_interface_create(struct bcmasp_priv *priv,
>  				 ndev_dn->name);
>  			goto err_free_netdev;
>  		}
> -		intf->phy_dn = ndev_dn;
> +		intf->phy_dn = of_node_get(ndev_dn);
>  	}
> 
>  	/* Map resource */
> @@ -1338,6 +1338,7 @@ struct bcmasp_intf 
> *bcmasp_interface_create(struct bcmasp_priv *priv,
>  err_deregister_fixed_link:
>  	if (of_phy_is_fixed_link(ndev_dn))
>  		of_phy_deregister_fixed_link(ndev_dn);
> +	of_node_put(intf->phy_dn);
>  err_free_netdev:
>  	free_netdev(ndev);
>  err:
> @@ -1350,6 +1351,7 @@ void bcmasp_interface_destroy(struct bcmasp_intf 
> *intf)
>  		unregister_netdev(intf->ndev);
>  	if (of_phy_is_fixed_link(intf->ndev_dn))
>  		of_phy_deregister_fixed_link(intf->ndev_dn);
> +	of_node_put(intf->phy_dn);
>  	free_netdev(intf->ndev);
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
