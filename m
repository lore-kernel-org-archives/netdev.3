Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2432E743
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511371; cv=none; b=kpJdhX0l/H2fVerClIGAou6bplwXrXcZDEkSTg2K/ThByHjW5iCTID2rgoxOsBkvThabN7nK1cmFx3+8egrlJOsPelA5zcZKCjAZ1AUnDjQ4EheKvnrJ+H/4ONgaS9v7ETixe2GZorFhHL6y+shWmxRPWY/pPtgfGLWw+Hlyg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511371; c=relaxed/simple;
	bh=2TSxO3dBxPDDS0TMU0ynhbj7RzjvstwfjFCorkhdimw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9LPVwmPz2I5hDMC9D9sp+w5JCnPuWlu5qgQKGNZSXIT9j41tlIfjoFOcYly6q1jPBsv81UTu2pL/tE8vV9KVwnh0yuHX7H57YEJLjsLtFLwLSqU6RUkjl7ySpSxN5Ej+7S8kxeo1Ezi4caY8Dnua24fSXLJNf4WSypHf1db2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O4LfPlA6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O4LfPlA6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CA3651A2FF5;
	Thu, 26 Mar 2026 07:49:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9716F5FDEB;
	Thu, 26 Mar 2026 07:49:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE847104507C8;
	Thu, 26 Mar 2026 08:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774511366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6vCpUNBSiAnYzq38lMljTJz/wGpcaU+8Km5eWOGP29M=;
	b=O4LfPlA6DXdQvXswgXOIiIqA0zoyzh65smdruT1D4cZH0LIUieaE/NMYMxT79/ea3Lrlgg
	z+5xD0lSFdrKgWiB92T+DEVmk5Kxila/MxT+9yZ3ozHOsFYYW0XQoAI42vXoMGBCh9KG6b
	uSnavCLBGDt8DrmYRt4eZFRN8lIR52gsLgSbJOEiZ44S4CUr93s4X95s1MsHvPjBayyvyz
	NEIM4Z+9QnvY9qVXTWedfHXrOM1sahBC9X3IqD6+0FRZThSVIIPrC23nRpucKD5vSfpvaW
	z96VqNoA7sZEaXwCvqKWI5Bq8SFwwAYl8NCSsS/YMPoLJfd0nIGjkH4GBi1IQQ==
Message-ID: <abb1c779-b306-42f8-b2b1-aa56bfcebe1b@bootlin.com>
Date: Thu, 26 Mar 2026 08:49:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
To: Michal Piekos <michal.piekos@mmpsystems.pl>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 21/03/2026 06:38, Michal Piekos wrote:
> stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> "Failed to restore VLANs" error even when no VLAN filtering is in use.
> 
> Check presence of VLAN HW FILTER flags before stmmac_vlan_update().
> 
> Tested on Orange Pi Zero 3.
> 
> Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> ---
> This patch fixes a noisy "Failed to restore VLANs" message on platforms
> where stmmac VLAN hash ops are not implemented.
> stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> VLAN hash ops presence which results in -EINVAL. 

I've been seeing the same message on socfpga. My two cents on that is
that this error messages doesn't bring anything to the table anyways.

As Russell explains, it's either triggered when the vlan op isn't
implemented (the stmmac callback macro stuff turns that into a -EINVAL),
or when some capabilities arent present. All in all, it's always stuff
that users can't really do anything about, as it's HW limitations, I
think we can simply discard this message.

Also, nothing actually checks what stmmac_vlan_restore() returns, so we
might as well return void ?

Maxime

> ---
> Changes in v2:
> - Replace check for hash ops with check for HW FILTER flags
> - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6827c99bde8c..cfc0ce9cec9c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6863,7 +6863,8 @@ static int stmmac_vlan_restore(struct stmmac_priv *priv)
>  {
>  	int ret;
>  
> -	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
> +	if (!(priv->dev->features &
> +	      (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)))
>  		return 0;
>  
>  	if (priv->hw->num_vlan)
> 
> ---
> base-commit: 42bddab0563fe67882b2722620a66dd98c8dbf33
> change-id: 20260314-vlan-restore-error-f8b3a1c7f50a
> 
> Best regards,

