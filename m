Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31F41837D;
	Thu,  1 Oct 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857265; cv=none; b=E+CziRL6IFOC5Pv3L+Dgkio5cS9wzmwV0pUhFv26JX/n/PC+N1ExURsKtw8CYnE7my1u3VU6OyxMe9q9E3Ft/LMjKD1GZ+txSyf/TobdQpibD84dOp42No3l/1ADuRbtNDulzCaX2TGJqeJ1YFazw6GLP738OxcuUrkYwSBE5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857265; c=relaxed/simple;
	bh=yj9saCJhtK1e2Ovkw/v1tf4+M2E/RC4gER6+0Fxhkqw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZNLKMLlfi0USc+kQE+0z7HCPZzlD8l4CKu/3M4zYyqVxwgwA0kCB0jK3QOJAql4WVSgOxBDjZrB8SXkk2IYbc7pfzZ8knsjKUkgj21comNGIUh6RZZUHMzXNcCSMOe2J8M3NdvqzuMob7rDcTsb08ILwbE33lKPj+oNlfHZ5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKPq+FeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKPq+FeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33831F000FF;
	Thu,  1 Oct 2026 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790857263;
	bh=oAW9yhIqz+GzzqxSQL3/AimWVIPwnoUGBGX02Gy9QqE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hKPq+FeLVRe6l+vSuRSS/QKJUins4smgtnS0QGrZdpTS/EJNtI8grIX7SGF6fOSps
	 dXRAOe0CLV5L2pB5/uQbX8MgAPUnSWzkBoDFBzA2Qp7TEd+QbVJIZz6c4kFIhj4s5o
	 ri/AYoV/iIoSsIvmTbRak3b1GRZ2cFr/YaBt78HRQfzzoKKlaCVUnGRQveRFbVXbB6
	 ZMkFfrZ/yDFadVoLLeH7SBMSse7VPNQ4MR/xauJh/quQrltHigYMBqMfAgrzEp+iRs
	 aKMvYW7uw1I3Yyt5jyRCgLxwLZ+0oqX578PQnYiKnQYnfU9n5WGT0CuEGEaLMJyL5Y
	 4eZATeKYT71uA==
Subject: Re: [PATCH net-next v2 3/3] net: pcs: rzn1-miic: Validate dtb
 configuration values
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 12:21:02 +0000
Message-ID: <179085726249.434549.2964258291206401936@kernel.org>
In-Reply-To:
 <20260928-miic-validate-dtb-v2-3-1ee3d33748e9@reliablecontrols.com>
References:
 <20260928-miic-validate-dtb-v2-3-1ee3d33748e9@reliablecontrols.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit fixes a memory-safety bug but has no Fixes: tag.
- [Low] The new error message in miic_parse_dt() prints `conf`, declared
  `u32 conf;`, with `%d`: `dev_err(miic->dev, "Port %d configuration out…

--

net: pcs: rzn1-miic: Validate dtb configuration values

This commit adds range checks in miic_parse_dt() for the per-port "reg"
and "renesas,miic-input" device tree values. If either value is out of
range for the SoC, the probe fails with -EINVAL.

> Bad configuration values from the dtb could result in out of bounds array
> access. Verify parsed values are within range for the SoC and fail the
> probe if invalid.

[Severity: Low]
Should this have a Fixes: tag?

Before this patch, an unchecked "reg" value in miic_parse_dt() could
write past the end of the kmalloc'ed dt_val[] buffer. That buffer is only
conf_conv_count bytes:

	dt_val[port + !miic->of_data->miic_port_start] = conf;

The unchecked index seems to date back to the original driver. There,
dt_val[] was a stack array indexed directly by the DT "reg" value.
Would this trailer be appropriate?

Fixes: 7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver")

Two earlier patches in this series already carry Fixes: tags: "net: pcs:
rzn1-miic: Fix port numbering on RZ/T2H" and "net: pcs: rzn1-miic: Fix
miic register initialization loop".

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index 9e830932ce49c..9a4c6d3b7d424 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -697,9 +697,25 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>  		if (of_property_read_u32(conv, "reg", &port))
>  			continue;
>  

[ ... ]

>  		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
>  			continue;
>  
> +		if (conf >= miic->of_data->conf_to_string_count) {

[Severity: High]
This checks "renesas,miic-input", but what about the parent node's
"renesas,miic-switch-portin" value earlier in miic_parse_dt()? It is
still stored with no range check:

	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
		dt_val[0] = conf;

The u32 is truncated into an s8. An out-of-range value will not match
any entry in the match table. miic_match_dt_conf() then falls through to
miic_dump_conf(), which does:

	conf_name = of_data->conf_to_string[conf[i]];

Can this read a pointer from past the end of conf_to_string[] and then
pass it to dev_err() as a %s argument? Values from 128 to 254 become
negative s8 values, so for those the read would land before the start
of the array.

The binding allows only 1 or 2 on RZ/N1 and only 0 on RZ/T2H/N2H. A
value of 255 truncates to -1 (MIIC_MODCTRL_CONF_NONE) and is silently
treated as absent.

Could the same conf_to_string_count check, or the stricter per-SoC
binding values, be applied to switch-portin before it is stored in
dt_val[0]?

> +			dev_err(miic->dev, "Port %d configuration out of range: %d\n",
> +				port, conf);

[Severity: Low]
This isn't a bug, but conf is declared u32, so should this be %u? Any DT
value of 0x80000000 or above prints as negative. 0xffffffff prints as -1,
which looks like the MIIC_MODCTRL_CONF_NONE sentinel.

> +			of_node_put(conv);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-miic-validate-dtb-v2-0-1ee3d33748e9%40reliablecontrols.com
