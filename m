Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061619992C;
	Sat, 13 Jun 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376777; cv=none; b=DQ6sQgdI7w9GqBVLX2hjfyKVV8ZSn3xnjev53XZF7VjTRe4RhLF+4VRVasPegFKfoFNl/6dtIIgEGARCLlrrk5GaDNVOUG1Bv9PtRBMOWgh98XiKJhvW3EOgYnhwsD7AOjbN7lz0ac7W+0f7Qk6Kj+EUO9DwVxSevkc9jkp2Zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376777; c=relaxed/simple;
	bh=1vURP6x8ko+SoVAdvDeW2alY1GjCKrlk5rZ34TfQ+Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHLUhRSl98ztepyxJ7NqidDKjZcd/z/+qL6Fnx281BBWNUQiMbIcrCDFmZ8O9gJgm6Y433665d3uwcgoZIXYrygv5HP5zM5jvOtQkrg7dg9MwPH5VVPJN1V0xLmcD/Wc1Y3OD9UUOYW1u5iQNUKoNKtFsNWvxwq47E3NQ2/aqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYTTR-000000002Y0-2HuE;
	Sat, 13 Jun 2026 18:52:53 +0000
Date: Sat, 13 Jun 2026 19:52:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next v5 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <ai2nAmi2fVFraRbK@makrotopia.org>
References: <20260613181845.111877-1-joey@tinyisr.com>
 <20260613181845.111877-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613181845.111877-5-joey@tinyisr.com>

On Sat, Jun 13, 2026 at 09:18:45PM +0300, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch.
> 
> The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
> port that is internally attached to the SoCs CPU MAC and serves as the
> CPU port.
> 
> The switch hardware has a very limited 16 entry VLAN table. Configuring
> VLANs is the only way to control switch forwarding. Currently 6 entries
> are used by tag_8021q to isolate the ports. Double tag feature is
> enabled to force the switch to append the VLAN tag even if the incoming
> packet is already tagged, this simulates VLAN-unaware functionality and
> simplifies the tagger implementation.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> [...]
> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> new file mode 100644
> index 000000000000..cedf063ad749
> --- /dev/null
> +++ b/drivers/net/dsa/mt7628.c
> [...]
> +
> +static const struct regmap_config mt7628_esw_regmap_cfg = {
> +	.name = "mt7628-esw",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +struct mt7628_vlan {
> +	bool active;
> +	u8 members;
> +	u8 untag;
> +	u16 vid;
> +};
> +
> +struct mt7628_esw {
> +	void __iomem *base;

Why even keep *base here if actual access all happens via the
regmap created for it?

Other than that lgtm

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
