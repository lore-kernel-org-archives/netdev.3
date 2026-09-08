Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDA599A47;
	Tue,  8 Sep 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890633; cv=none; b=dC9Bs+WHZaLBs/KCCqlzu25Zf/J+MRWapmexg6bGM3iYRmgzfEHyZWdONnm56RxTTFck2dO9zFlz/GL26tHZ9cOvqKDIR1O6V3N4a14Bp55vQtKVjyzER+BZnDZPB4iIL2eW8RDBg58quK4oaRwMSTAGIAwiS28/M5F4LFfmRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890633; c=relaxed/simple;
	bh=TOMufkdtmrJxpd4ItFlw6YDH5DvzVizOLsElUWIjAUg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grS0yfxgSxtWAIDlP/1BkMZRiIQb5FzauVoDCezMc+yyJyZSKMHukjsftCHMSYDaSW0jWSdonGppYttVWXvqYRmxfjbWaGIg/+FXxUo4TpvZJxuyE7VpKf1sojV+KTqu5AoWfq9HILCYDuPYyyWU4go/Svp1VlJ55xjjwxqudKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKlDrJWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKlDrJWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5400C1F00A3A;
	Tue,  8 Sep 2026 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890631;
	bh=dxvOHKZRZGE3aDp2WcN/4SOPvDteTqq1b/AiMnxcnHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YKlDrJWESKGLjSmvBtt8S8O2ZIqNZ4QfOWhUlM0SyqJdd0hYd4FgcY1CXZsEgI/1q
	 IfglWKz6/RYWhvBiBHQpFnxM0uMt5qgxMYiuC0jmSu8qoL0cAWZ59RuWBN8StvH12O
	 cdlAUhOBEfbKwKsXlx7Zd6htoxxeYr6xixGLA0o/juRNHY7lYlzNtqGSxLqTYZFNTa
	 Rl5666C+I6T2ld2UisLNQKbLSCppm8cFB3AjcybRuXTe6xcjJ9BUAg5HRBmJmZAPrC
	 bgnWQB3HGqkcbjrwGzzX6Yorno+lup+qRqLkSzaSIsbX8ouOF6xo20AUobpfQl8RN4
	 zOOurf+e0EFDw==
Subject: Re: [PATCH net-next v5] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
From: netdev-bot+sashiko@kernel.org
To: tapio.reijonen@vaisala.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com, nb@tipi-net.de,
 Jerry.Ray@microchip.com
Date: Tue, 08 Sep 2026 18:03:49 +0000
Message-ID: <178889062985.219967.7973739052218623583@kernel.org>
In-Reply-To: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
References: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Public interface defect: `KSZ9897S_CHIP_ID` (0x00989701) is
  added to `enum ksz_chip_id` in include/linux/platform_data/microchip-…

--

net: dsa: microchip: enable the SGMII port of the KSZ9897S

This adds a KSZ9897S chip_data entry with .sgmii_port = 7 and selects it in
ksz_switch_register() by reading the read-only bit 7 of the port 7 XMII
control 0 register, while leaving dev->chip_id at the shared KSZ9897 value.
A new KSZ9897S_CHIP_ID is added to enum ksz_chip_id to tag that entry.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a0232..81798a9fa671d 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1486,6 +1486,41 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.gbit_capable	= {true, true, true, true, true, true, true},
>  	},
>  
> +	[KSZ9897S] = {
> +		.chip_id = KSZ9897S_CHIP_ID,
> +		.dev_name = "KSZ9897S",

[ ... ]

> +		.gbit_capable	= {true, true, true, true, true, true, true},
> +		.sgmii_port = 7,
> +	},
> +
>  	[KSZ9893] = {
>  		.chip_id = KSZ9893_CHIP_ID,
>  		.dev_name = "KSZ9893",

[ ... ]

> @@ -3933,7 +3969,30 @@ int ksz_switch_register(struct ksz_device *dev)
>  	if (ret)
>  		return ret;
>  
> -	info = ksz_lookup_info(dev->chip_id);
> +	lookup_chip_id = dev->chip_id;
> +

[ ... ]

> +	 * Only the chip_data entry differs, so dev->chip_id keeps the shared
> +	 * chip ID and nothing else has to know about the variant.
> +	 */
> +	if (dev->chip_id == KSZ9897_CHIP_ID) {
> +		u8 val;
> +
> +		ret = ksz_read8(dev, KSZ9897_REG_PORT7_XMII_CTRL_0, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val & KSZ9897_PORT7_SGMII_SEL)
> +			lookup_chip_id = KSZ9897S_CHIP_ID;
> +	}
> +
> +	info = ksz_lookup_info(lookup_chip_id);
>  	if (!info)
>  		return -ENODEV;
>  

> diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
> index 028781ad40593..fe8df1774289c 100644
> --- a/include/linux/platform_data/microchip-ksz.h
> +++ b/include/linux/platform_data/microchip-ksz.h
> @@ -34,6 +34,7 @@ enum ksz_chip_id {
>  	KSZ9477_CHIP_ID = 0x00947700,
>  	KSZ9896_CHIP_ID = 0x00989600,
>  	KSZ9897_CHIP_ID = 0x00989700,
> +	KSZ9897S_CHIP_ID = 0x00989701,
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Is enum ksz_chip_id in include/linux/platform_data/microchip-ksz.h the right
place for this value, given that no code path can ever set dev->chip_id to
0x00989701?

ksz_switch_detect() masks off the revision byte and stores only the fixed
IDs, so a KSZ9897S always ends up with dev->chip_id == KSZ9897_CHIP_ID,
which the commit message describes as intentional:

    dev->chip_id keeps the KSZ9897 chip ID that both parts report

Because enum ksz_chip_id is the platform-data selection interface, a board
that sets ksz_platform_data.chip_id = KSZ9897S_CHIP_ID now reaches
ksz_check_device_id() with an expected ID that resolves through
ksz_lookup_info() but never matches the detected one:

drivers/net/dsa/microchip/ksz_common.c:ksz_check_device_id() {
	if (dev->pdata) {
		expected_chip_id = dev->pdata->chip_id;
		expected_chip_data = ksz_lookup_info(expected_chip_id);
		if (WARN_ON(!expected_chip_data))
			return -ENODEV;
	...
	if (expected_chip_id != dev->chip_id) {
		dev_err(dev->dev,
			"Device tree specifies chip %s but found %s, please fix it!\n",
			expected_chip_data->dev_name, dev->info->dev_name);
		return -ENODEV;
	}
}

Would such a board fail to probe with the confusing message "Device tree
specifies chip KSZ9897S but found KSZ9897, please fix it!"?

There is also the invariant question: every other entry in
ksz_switch_chips[] has a .chip_id equal to an ID the hardware can actually
report, and that value is consumed as a real chip ID elsewhere, for example
via dev->info->chip_id in lan937x_main.c. The new entry uses .chip_id purely
as a lookup key for ksz_lookup_info(lookup_chip_id) in
ksz_switch_register().

Would a private enum ksz_model index, or a bool in struct ksz_chip_data,
express the S/R variant without publishing an ID in the shared platform-data
header that no caller can use?

>  	KSZ9893_CHIP_ID = 0x00989300,
>  	KSZ9563_CHIP_ID = 0x00956300,
>  	KSZ8567_CHIP_ID = 0x00856700,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8%40vaisala.com
