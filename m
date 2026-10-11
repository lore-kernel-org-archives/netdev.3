Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAA45DF47;
	Sun, 11 Oct 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748286; cv=none; b=e6kPVT/MdTaXSbk7Ou57Kfwmbhx7RfC3CgetIIDktl7iAIBnLSe/z7pJkfzxpVepNMAOcnB7cHfFYroSif3P1pUvrWyuMgtHgHfIz85+q3UFKI7s+YnmyL+YkUQLrau/1kF+i1JUkTOu8lDXvVPHvz+5Pdylu8C7ikv14TxMvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748286; c=relaxed/simple;
	bh=ltjvSlIZvpHbEWDpeGHTQjUP9B1qiDlLlTMr7aeKuJM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azqO/Gr4cPqwZvVwNj9+W4gBaSzuQ+08qHb1m1xY8bl/Io7IcGY5wROyqLMDefpvCt/K7sZzAgG4JLGDypdx2JlObl1jrkwPtZYXW4vx8/irpTsZKmigXSNSpqZtsKz3qCMe9FlP3gFgzK5uT0Dg3duuLLBoKlKKq1QYAgNZL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhd92cc0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhd92cc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A02D1F0089C;
	Sun, 11 Oct 2026 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748283;
	bh=Pjwebu0taw7+Pf1g8RYb3XqdPugV66LNzKHIwwXtLlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nhd92cc0oIqgRKqh7v9YNPrm1X47+PMPCrt6lxn6T+gOcr8B92yVmHpokPVOwoM+L
	 wmOg/cWDtdHyHj5ZEE4X4XBoFwMjEOT8BsD7a0JAqj0EoqvU7eglb0oWw9erkR1ugj
	 P59RhC+r1AdB7SRQFc4/eR+j2nKKKuLFHYKhd8B01jEVaOjQvafcaN2XCpmVCkK1XZ
	 EwsTYMzgnv8tko6VQq7Sl3SCsKj0efyywhnAFe4norIlicZQuZpZ10Ch+Bfs3YhKow
	 WU7+tOE541lG4Msk6GP8ByoUgef4TYOyODIQttAb/QLwTfO0eFWDcMTeDMsi6UGkn9
	 /JT9bzyuqpU2w==
Subject: Re: [PATCH net-next v3 3/9] net: dsa: realtek: rtl8365mb: set speed
 for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:22 +0000
Message-ID: <179174828259.434549.11978481481032139705@kernel.org>
In-Reply-To: <d9773155-5e61-4b6e-b892-73668ca61fc8@yahoo.com>
References: <d9773155-5e61-4b6e-b892-73668ca61fc8@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not describe what the patch changes for
  family D.
- [Low] Concern: no rtl8365mb_chip_infos[] entry sets .family =
  RTL8365MB_FAMILY_D, so the new family D branch in…

--

net: dsa: realtek: rtl8365mb: set speed for family D

This adds family D handling to rtl8365mb_ext_config_forcemode(). Family D
gets a dedicated 2500M speed value (5), and the third speed bit goes into
a new FORCE_SPEED2 field. Family D also programs a per-port force register
and a matching per-port enable register instead of the per-extint force
register.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 840db5ad32efe..8f3295c232362 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1692,20 +1717,44 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
>  		r_duplex = 0;
>  	}
>  
> -	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK, 1) |
> -	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
> +	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
>  			 r_tx_pause) |
>  	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK,
>  			 r_rx_pause) |
>  	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK, r_link) |
>  	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK,
>  			 r_duplex) |
> -	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK, r_speed);
> -	ret = regmap_write(priv->map,
> -			   RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
> -			   val);
> -	if (ret)
> -		return ret;
> +	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK,
> +			 r_speed &
> +			 RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK);
> +
> +	if (is_d) {
> +		/* Speed is 3 bits on family D: bits[1:0] go into FORCE_SPEED,
> +		 * bit[2] goes into FORCE_SPEED2 (bit 12); only 2500M sets it,
> +		 * bit 13 of the field is unused.
> +		 */
> +		val |= FIELD_PREP(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK,
> +				  r_speed >>
> +				  RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH);
> +		ret = regmap_write(priv->map,
> +				   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(port),
> +				   val);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(priv->map,
> +				   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(port),
> +				   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK);
> +		if (ret)
> +			return ret;

[Severity: Low]
This isn't a bug, but the subject and commit message only cover the new
3-bit speed encoding. For family D, rtl8365mb_ext_config_forcemode() also
changes these things:

  - All forced-mode programming moves from
    RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id) to the per-port
    register at 0x12c0 + port. That covers link, duplex, pause and every
    speed, plus the link down path from mac_link_down.

  - FORCE_EN (BIT(12)) is no longer set, because on family D that bit is
    FORCE_SPEED2.

  - Every call, including link down, writes 0xFFFF to a second per-port
    register at 0x12c8 + port.

Could the commit message, or a comment here, explain what the 16 bits in
RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN() select, and why setting all
of them is correct?

If those bits choose which fields of the force register are forced, then
0xFFFF also forces fields this code writes as zero (bit 7, bits 8-11 and
bits 14-15).

It might also help to say that the family C bit positions for TXPAUSE,
RXPAUSE, LINK, DUPLEX and SPEED are reused for the register at the new
address.

This looks like it follows the vendor RTL8367D sequence. The later patches
in the series leave this code as it is and don't add an explanation.

> +	} else {
> +		val |= FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK, 1);
> +		ret = regmap_write(priv->map,
> +				   RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
> +				   val);
> +		if (ret)
> +			return ret;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com
