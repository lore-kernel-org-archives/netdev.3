Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143C305693
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342642; cv=none; b=SI7///fiMBGIny5wmRc93mCpHQNkLjN8rS9+rct+0pOTEDSsoLdDL5VtR0WshEwSEeqvje7I+TDm3OccGzNpZEYdQXoUOIDT1Z+XCeMLdaa6dWiko6dGqtjfE+77M9BPaF1XuPrQJ8zeTBVv+R2InnUW2x+NX02OyirpSc+zDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342642; c=relaxed/simple;
	bh=KlSPdG0axhMwXwHO3+Qv2C+0G7of9gj9TLRZCgi06OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rnp8rOWVLzG5CGI4398LG832Mzh8xbqICjRfIWbm9vdfwOL5+LCnO32d//aaZKgWeQu8IdgORX2kqrx7hQiDYkOLyNqiVkksAXclhjmM6lE8G8hOBqBYdfzsekS0Cu6v4rYnaZQLeY6RBRhuf1TLU0JA36KEbRZ7TWBhiPS3YcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cWzAYMLp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cWzAYMLp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64D9D1A1932;
	Wed,  2 Sep 2026 09:50:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 363296053C;
	Wed,  2 Sep 2026 09:50:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E071911C792F3;
	Wed,  2 Sep 2026 11:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788342635; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SlG586REaqGCwTe3f44TG7HZev5qlllhYufaSDUddpM=;
	b=cWzAYMLpmucLaUQi6Pjy0yGWfJDQ4mBMCRPCtX9c1WEwiDpfiPIwT5Z2w89NRDl8J79nu7
	hP0SAeyQuLwwlr6She1sm7n45TnlMKbIOjb8bFbBA7MXJ3lBYBtuj/lLS87XyHdppwhg8E
	nYVtfOB3L3dMzPUi+NxH9whEJ+oeiKB7yoLn3ATYQi1ytxTfEQVjgWe5AjgF4cdUC8bX5q
	VFchLkozwdVKdohVQ2kSFF62nqaE/rE3Uu4wuPBbchiZtzGJVhOpUK69AxIhct+FJWaYwI
	Nk5MlJk6zdowhZaAvDP0CIAYT6LA0CMAtNdwHZL/MXMWcein0vElgZ55dBQ++g==
Message-ID: <3450830c-1766-4bd5-a777-4bfbfc4c25c7@bootlin.com>
Date: Wed, 2 Sep 2026 11:50:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net: dsa: mt7530: populate lpi_interfaces to
 fix EEE support
To: Aleksei Sviridkin <f@lex.la>, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, andrew@lunn.ch, olteanv@gmail.com, nbd@nbd.name,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, dqfext@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260902080519.2211373-1-f@lex.la>
 <20260902080519.2211373-2-f@lex.la>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260902080519.2211373-2-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Aleksei,

On 9/2/26 10:05, Aleksei Sviridkin wrote:
> phylink_create() decides once and for all that a MAC supports managed
> EEE, and it requires the tx_lpi ops plus non-empty lpi_capabilities and
> lpi_interfaces. mt753x_phylink_get_caps() leaves lpi_interfaces empty.
> 
> So ever since the conversion to phylink managed EEE, ethtool has
> answered "Not supported" on every mt753x port, and phy_disable_eee()
> has locked userspace out of turning EEE on. That undoes what
> commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
> switch on all boards") arranged: EEE off by default, but reachable
> with ethtool.
> 
> Leave the speeds above 1 Gbps out of both bitmaps. PMCR folds
> SPEED_2500 and SPEED_10000 onto PMCR_FORCE_SPEED_1000, so
> PMCR_FORCE_EEE1G would govern LPI on such a link, and that is
> unvalidated rather than known unsupported: MediaTek's SDK driver sets
> the EEE force bits for 100 Mbps and 1 Gbps only, and the unit of the
> wakeup timers is undocumented with the port clock at 2.5 times the
> rate.
> 
> LPI stays off until userspace enables it, but the EEE advertisement of
> a PHY that advertises it out of reset comes back, since phylink stops
> force-clearing it.
> 
> Fixes: 9cf21773f535 ("net: dsa: mt7530: convert to phylink managed EEE")
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> Ports that support neither 100 Mbps nor 1 Gbps are skipped because on
> MT7988, EN7581 and AN7583 port 6 is 10 Gbps only and shares
> PHY_INTERFACE_MODE_INTERNAL with the user ports, so the interface mask
> alone cannot tell them apart. MT7531's internal PHYs keep the
> advertisement mt7531_setup() zeroed and EN7528 keeps both bitmaps
> empty, so EEE stays fully off there.
> 
> Two pre-existing things this patch makes live, neither addressed here:
> 
> - The unit of LPI_THRESH is still unspecified, as the comment above
>   lpi_timer_default says. Before the phylink conversion
>   mt753x_set_mac_eee() wrote tx_lpi_timer into the field directly, so
>   the raw unit has always been what ethtool showed on these ports.
> 
> - mt753x_phylink_mac_enable_tx_lpi() sets the PMCR force-EEE bits
>   without checking the resolved speed or interface, relying entirely on
>   phylink never calling it above 1 Gbps. A check there would make the
>   driver robust independently of lpi_interfaces being right.
> 
> v2, with the full argument for leaving the higher speeds out:
> https://lore.kernel.org/netdev/20260824024117.46154-2-f@lex.la/
> 
> v4: lpi_capabilities is mac_capabilities masked to the two speeds
> instead of both asserted. Every port that reaches the guard today has
> both speeds, so nothing changes; it only stops the bitmap from claiming
> a speed a port cannot link at.
> 
>  drivers/net/dsa/mt7530.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 2b7be091c056..a188a391b650 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -3172,23 +3172,38 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
>  
>  	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
>  
> +	priv->info->mac_port_get_caps(ds, port, config);
> +
>  	/* The EN7528 GPHYs report EEE capability, but negotiating EEE with
>  	 * common link partners (e.g. Realtek GbE NICs) results in an unstable
>  	 * link with dropped frames. Leave the LPI capabilities empty so that
>  	 * phylink disables EEE on these PHYs and refuses to enable it from
> -	 * userspace.
> +	 * userspace. Ports that run at neither 100 Mbps nor 1 Gbps are left
> +	 * empty too, since LPI above 1 Gbps is unvalidated.
>  	 */
> -	if (priv->id != ID_EN7528) {
> +	if (priv->id != ID_EN7528 &&
> +	    config->mac_capabilities & (MAC_100FD | MAC_1000FD)) {
>  		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
>  
> -		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
> +		/* PMCR folds SPEED_2500 and SPEED_10000 onto
> +		 * PMCR_FORCE_SPEED_1000, so LPI above 1 Gbps would be
> +		 * governed by PMCR_FORCE_EEE1G and is unvalidated rather than
> +		 * unsupported. Leave it out of both bitmaps: lpi_capabilities
> +		 * gates on the media speed a rate matching PHY reports, not
> +		 * on the speed the MAC runs at.
> +		 */

This is still too verbose IMO... 2500Mbps LPI isn't uspported, that's all we
need to know :)

It's very common that 2500 uses the same settings as 1000 with just a random
register somewhere switching the speed to 2.5x, and also very common that lots
of features break when using 2500, so no need for the verbosity here. Same
goes for the next patch as well.

Sorry for nitpicking on this, but comment verbosity overall has been rising-up lately,
LLMs may have something to do with it, and it doesn't necessarily make things more
readable :(

The code itself looks fine though,

Maxime


