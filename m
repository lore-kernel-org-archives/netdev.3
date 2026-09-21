Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9733B05BC;
	Mon, 21 Sep 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019855; cv=none; b=pTRIA8pmmj9hzx1Qn6RsZYKWrmGzaxoNPwlNfEYgLj//Othf1DNA/F4WGBdG1iWyNpkkKC+ukwial8IM7pxhY5wNhay4dmoWhqj+cp5TmXBUn1m8l7q3bF3USOASt+mlQykojkTqDTAKDsldv6h4U5d3k4idmJpMOC1XYt7f5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019855; c=relaxed/simple;
	bh=tfuuwZkv0OiIbeoynFvgSL9aGg2B0yUwcYIegLL71gU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hi9kfLDtIyp7QeYhLaBMMT1G67/RL9P74nbP9Ssr11NSQDyVCnrrxxcAAv4aKwfaLpdxyifgdir5JZawWG6CeYAZc2STndNOLKM5GksU/A8ZbM3mZoMizc3Ocpc+/HzoNOop1ibWzJs8IVRVY2vpm5JkPfCdj0jz8MqaUR0bkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRQGkjwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRQGkjwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D8D1F00898;
	Mon, 21 Sep 2026 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790019853;
	bh=sHkHOApxnjtxj7zKYj/CzHNgDiUNNQfctQnU2J5DLsI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iRQGkjwAKnAlS42FWELPf95QfMv6ABMFQwL0Ez/+AoygFAGVtxYGSwjaRFpA6QQZS
	 ckP2eTWK1SiXFPS6LBTLmluM76z4IKwYOys1QO2X6oMFo5byrvXlc6OIC/j9fnnZxL
	 LqYR8LdpA1AtclL6thoVZebW2mk+TZPKiOzqEi3lT+r2JaGfeW+a+F4CuHAQBP11F/
	 oNjynJ64tdhn5CfCP19t5ZelqL3KOKKk0F0+lrAXU6uYj617l4rl3ThxkU+Biwrp6Z
	 mAuJN2bVczQhWqUxpzhtiHkv9YmO/hnS4HLHbYvow5l4r/h+3BQhyAZDxwS5qYmY1J
	 VxFg8hUuaSUgQ==
Subject:
 Re: [PATCH net-next v3 5/8] net: dsa: motorcomm: Introduce yt921x_speed
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 19:44:12 +0000
Message-ID: <179001985288.2160803.4254571626134705483@kernel.org>
In-Reply-To: <20260917185010.3189199-6-mmyangfl@gmail.com>
References: <20260917185010.3189199-6-mmyangfl@gmail.com>
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

- [Low] The new `enum yt921x_speed` in drivers/net/dsa/motorcomm/chip.h
  (lines 116-123) has no explicit enumerator values and no comment, yet…
- [Low] The new driver-private helper added in
  drivers/net/dsa/motorcomm/chip.h is named `ethtool_speed_to_yt921x()`,…

--

net: dsa: motorcomm: Introduce yt921x_speed

This replaces the three per-register speed switch statements in
yt921x_port_up() with a single conversion helper and a new enum, since
FIELD_PREP() results cannot be used as case labels.  The old
YT921X_{PORT,SERDES,MDIO_POLLING}_SPEED_* constants are dropped in favour
of feeding the enum value into the corresponding FIELD_PREP() wrappers.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 5049f4be8aa6b..c99be2044fa20 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -3771,29 +3771,15 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  {
>  	const struct yt921x_info *info = priv->info;
>  	struct yt921x_port *pp = &priv->ports[port];
> +	int ps = ethtool_speed_to_yt921x(speed);

[Severity: Low]
This isn't a bug, but should this helper carry the driver prefix?  Every
other symbol reachable from chip.h uses yt921x_/YT921X_, while this new
static inline takes a name in the core ethtool_ namespace, so the call
site here reads as if the DSA driver is calling core ethtool API.

Would something like yt921x_speed_from_ethtool() be preferable, both here
and at the definition in chip.h?  It would also avoid a collision should a
generic ethtool_speed_to_* helper or macro ever appear in
include/linux/ethtool.h.

>  	u32 mask;
>  	u32 ctrl;
>  	int res;
>  
> -	switch (speed) {
> -	case SPEED_10:
> -		ctrl = YT921X_PORT_SPEED_10;
> -		break;
> -	case SPEED_100:
> -		ctrl = YT921X_PORT_SPEED_100;
> -		break;
> -	case SPEED_1000:
> -		ctrl = YT921X_PORT_SPEED_1000;
> -		break;
> -	case SPEED_2500:
> -		ctrl = YT921X_PORT_SPEED_2500;
> -		break;
> -	case SPEED_10000:
> -		ctrl = YT921X_PORT_SPEED_10000;
> -		break;
> -	default:
> +	if (ps == YT921X_SPEED_NUM)
>  		return -EINVAL;
> -	}
> +
> +	ctrl = YT921X_PORT_SPEED(ps);

[ ... ]

> @@ -3810,25 +3796,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  
>  	if (pp->serdes) {
>  		mask = YT921X_SERDES_SPEED_M;
> -		switch (speed) {
[ ... ]
> -		}
> +		ctrl = YT921X_SERDES_SPEED(ps);

[ ... ]

> @@ -3850,25 +3818,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  		if (res)
>  			return res;
>  
> -		switch (speed) {
[ ... ]
> -		}
> +		ctrl = YT921X_MDIO_POLLING_SPEED(ps);

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 3fb0c6a69dd8c..b3670f1e14276 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -89,11 +89,6 @@
>  #define  YT921X_SERDES_DUPLEX_FULL		BIT(3)
>  #define  YT921X_SERDES_SPEED_M			GENMASK(2, 0)
>  #define   YT921X_SERDES_SPEED(x)			FIELD_PREP(YT921X_SERDES_SPEED_M, (x))
> -#define   YT921X_SERDES_SPEED_10			YT921X_SERDES_SPEED(0)
> -#define   YT921X_SERDES_SPEED_100			YT921X_SERDES_SPEED(1)
> -#define   YT921X_SERDES_SPEED_1000			YT921X_SERDES_SPEED(2)
> -#define   YT921X_SERDES_SPEED_10000			YT921X_SERDES_SPEED(3)
> -#define   YT921X_SERDES_SPEED_2500			YT921X_SERDES_SPEED(4)

[ ... ]

> @@ -107,11 +102,6 @@
>  #define  YT921X_PORT_SPEED_M			GENMASK(2, 0)
>  #define   YT921X_PORT_SPEED(x)				FIELD_PREP(YT921X_PORT_SPEED_M, (x))
> -#define   YT921X_PORT_SPEED_10				YT921X_PORT_SPEED(0)
> -#define   YT921X_PORT_SPEED_100				YT921X_PORT_SPEED(1)
> -#define   YT921X_PORT_SPEED_1000			YT921X_PORT_SPEED(2)
> -#define   YT921X_PORT_SPEED_10000			YT921X_PORT_SPEED(3)
> -#define   YT921X_PORT_SPEED_2500			YT921X_PORT_SPEED(4)

[ ... ]

> @@ -122,11 +112,16 @@
>  #define  YT921X_MDIO_POLLING_SPEED_M		GENMASK(2, 0)
>  #define   YT921X_MDIO_POLLING_SPEED(x)			FIELD_PREP(YT921X_MDIO_POLLING_SPEED_M, (x))
> -#define   YT921X_MDIO_POLLING_SPEED_10			YT921X_MDIO_POLLING_SPEED(0)
> -#define   YT921X_MDIO_POLLING_SPEED_100			YT921X_MDIO_POLLING_SPEED(1)
> -#define   YT921X_MDIO_POLLING_SPEED_1000		YT921X_MDIO_POLLING_SPEED(2)
> -#define   YT921X_MDIO_POLLING_SPEED_10000		YT921X_MDIO_POLLING_SPEED(3)
> -#define   YT921X_MDIO_POLLING_SPEED_2500		YT921X_MDIO_POLLING_SPEED(4)
> +
> +enum yt921x_speed {
> +	YT921X_SPEED_10,
> +	YT921X_SPEED_100,
> +	YT921X_SPEED_1000,
> +	YT921X_SPEED_10000,
> +	YT921X_SPEED_2500,
> +	YT921X_SPEED_NUM
> +};

[Severity: Low]
Should these enumerators carry explicit values?  The ordinals here are the
raw hardware field encodings, which yt921x_port_up() writes straight into
three register fields:

	ctrl = YT921X_PORT_SPEED(ps);
	...
	ctrl = YT921X_SERDES_SPEED(ps);
	...
	ctrl = YT921X_MDIO_POLLING_SPEED(ps);

The encoding is not monotonic in speed (10G is 3, 2.5G is 4).  Before this
patch that was visible in the constants being removed above:

	#define   YT921X_PORT_SPEED_10000	YT921X_PORT_SPEED(3)
	#define   YT921X_PORT_SPEED_2500	YT921X_PORT_SPEED(4)

Afterwards the only record of it is the textual order of the enumerators.

Would a later "sort these by speed" cleanup then silently program 2.5G as 3
and 10G as 4, with no compile-time or runtime diagnostic?  Assigning
YT921X_SPEED_10000 = 3 and YT921X_SPEED_2500 = 4 explicitly, and/or noting
in a comment that these are hardware field encodings, would keep that
intact.

The values themselves are unchanged by this patch (10 -> 0, 100 -> 1,
1000 -> 2, 10000 -> 3, 2500 -> 4 all match the removed macros), and the
enum still has no explicit values at the end of the series.

[ ... ]

> @@ -1004,4 +999,22 @@ struct yt921x_priv {
>  	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
>  };
>  
> +static inline int ethtool_speed_to_yt921x(int speed)
     ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
This is the definition referred to above; renaming it to something like
yt921x_speed_from_ethtool() would keep the driver's namespace consistent.

> +{
> +	switch (speed) {
> +	case SPEED_10:
> +		return YT921X_SPEED_10;
[ ... ]
> +	default:
> +		return YT921X_SPEED_NUM;
> +	}
> +}
> +
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917185010.3189199-1-mmyangfl%40gmail.com
