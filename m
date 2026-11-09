Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214363;
	b=1xu37ga9ThC35Iayvm0A+LMU/gc8bX78ozC3qzN7lT9795MusAJjHJfiiXdaF5Zi+bRO
	 tplGJLsmE6117w08Y7T6eAt9QElEmqHRwTm5iCw+plKN7hjEomlCmXzjODQMV03gwQG1O
	 9byX0NW47IgutJdcstlK7kKJA6f5Wc9iJwMpeIwE1D8+0dubpRnvxs521rAzyw2eFE+ja
	 AL/GMPByZ531l8ZfYa2SrxTVFyK9tf5e7j8H+bQDQEGhgn/XDUnxNtI1xG0fc3DFpuFwa
	 mqXVvRRo+RbLISbx81Ipy0f4RwMERt4wvzpABOTQE8adtdzYaMLLDWH+8JlfWQsMQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214363;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZuCgV3iftQOi1pVHVUGM411m1BUew2QCPAkKHcu4o5c=;
	b=5aX1QvB4SxDlBZS0E7bKZsOoeBJMWpz8IJvwntNHGlDIlhQlaDgMnJrhGyfL0DlfDabq
	 RxBXiufHQ1nTbPKHXrKtwrKMNmYg0irAEexIdM6gCnwYOypRvWxxP+ItBrITj2FS9JKMK
	 NwlYVjB6bxqOpLX6ECzvnyeHt1/hu9x+Nw4J9XGNMqqYcGU4WE4G+6bc+qeyZVrc0+7Aj
	 F3gCbDk54d+YxUsPOkjE7Lboghupj19x+IdSAi5r06qKYKNEMxug4tJbhNHxIK/IvAVBs
	 BodEDbWsH2u94bdD5GdmWHHEe4zR9YjgBcVj6jzwoyIGJIES7uL7yiKSFdBNGdjXYoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Stqcbqzs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B5606EEBD;
	Mon,  9 Nov 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Stqcbqzs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6701F00A13;
	Mon,  9 Nov 2026 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214363;
	bh=ZuCgV3iftQOi1pVHVUGM411m1BUew2QCPAkKHcu4o5c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Stqcbqzsq3zeSJ0lFxWZBujSq3Qk7mRVWuPmty4UptM+wm6dE+e8BOcNOISzoccOx
	 qdW89OVQ8HaPtOSWJl4uSRNz4J63LgtjagoPZzWFOnmH2JpCa8ZjW4NzPXY3yZLmBn
	 /kfR/zc5CfbcK5cPFXpuqUcUP6vj+f+0tMTxrsJzuYzc3EL5CYaBlxvZ5nwmKg2yz6
	 yPKJuvqv5GIg+DbkZcKdjUwaoTSiXIoFpTe7mPn4zr5uvNf0IF8Spsg/bjo6c45BQp
	 yZyH1mskd9jGHLrHHRrVrsnHkAhvaIYWRhnSD2cVPCyev/lxKwYTm7iltBDCvJzxZk
	 7FHk7Epxtl6qA==
Subject: Re: [PATCH net-next v9 02/11] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
Date: Mon, 09 Nov 2026 08:52:41 +0000
Message-ID: <179421436161.994134.8843393412347553629@kernel.org>
In-Reply-To: <310bca10-e082-4d0a-a645-42fd4e58d2a6@yahoo.com>
References: <310bca10-e082-4d0a-a645-42fd4e58d2a6@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch leaves a stale comment in rtl8365mb_switch_init()
  (drivers/net/dsa/realtek/rtl8365mb_main.c).

--

net: dsa: realtek: rtl8365mb: add chip family infrastructure

This commit adds enum rtl8365mb_family and struct rtl8365mb_family_info.
The family id, port count and init jam table now live in the family
info, which struct rtl8365mb_chip_info points to, and all existing chips
use the RTL8365MB_FAMILY_C instance. rtl8365mb_detect() now takes
num_ports from the family info.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index da06f952a053d..b500c8404c24b 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -702,14 +705,20 @@ struct rtl8365mb_extint {
>  	unsigned int supported_interfaces;
>  };
>  
> +static const struct rtl8365mb_family_info rtl8365mb_family_c = {
> +	.family = RTL8365MB_FAMILY_C,
> +	.num_ports = RTL8365MB_C_MAX_NUM_PORTS,
> +	.jam_table = rtl8365mb_init_jam_8365mb_vc,
> +	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
> +};
> +
>  /**
>   * struct rtl8365mb_chip_info - static chip-specific info
>   * @name: human-readable chip name
>   * @chip_id: chip identifier
>   * @chip_ver: chip silicon revision
> + * @family_info: data shared by all chips of the same family
>   * @extints: available external interfaces
> - * @jam_table: chip-specific initialization jam table
> - * @jam_size: size of the chip's jam table

[ ... ]

> @@ -3036,17 +3048,17 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
>  static int rtl8365mb_switch_init(struct realtek_priv *priv)
>  {
>  	struct rtl8365mb *mb = priv->chip_data;
> -	const struct rtl8365mb_chip_info *ci;
> +	const struct rtl8365mb_family_info *fi;
>  	int ret;
>  	int i;
>  
> -	ci = mb->chip_info;
> +	fi = mb->chip_info->family_info;
>  
>  	/* Do any chip-specific init jam before getting to the common stuff */
> -	if (ci->jam_table) {
> -		for (i = 0; i < ci->jam_size; i++) {
> -			ret = regmap_write(priv->map, ci->jam_table[i].reg,
> -					   ci->jam_table[i].val);
> +	if (fi->jam_table) {
> +		for (i = 0; i < fi->jam_size; i++) {
> +			ret = regmap_write(priv->map, fi->jam_table[i].reg,
> +					   fi->jam_table[i].val);

[Severity: Low]
This isn't a bug, but should this comment in rtl8365mb_switch_init() be
updated?

The jam table no longer comes from struct rtl8365mb_chip_info. It now
comes from mb->chip_info->family_info, and the new kernel-doc describes
@family_info as "data shared by all chips of the same family".

The comment still says "chip-specific init jam", though. No later patch in
the series changes it. At the end of the series both rtl8365mb_family_c
and rtl8365mb_family_d point to the same rtl8365mb_init_jam_8365mb_vc
table.

Would something like "family-specific init jam" fit better?

>  			if (ret)
>  				return ret;
>  		}

[ ... ]

<br>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/9b73858d-fc09-4988-8bab-fd7b88db9412%40yahoo.com
