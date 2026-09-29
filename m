Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6F4D09FE;
	Tue, 29 Sep 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695666; cv=none; b=nM3sVOYbXMwDgtRsQPr/nU1k16vxmkuNzltzx3ZbwC6XTUdPPTIyAppuKl+DHdsmkTg4kJqsViX/AvMhY+QSrGO9zDA1u1X7GYo5owLjOO7NUHUSdLWqouyvum63kTrZ6xZT+wFvAji3sZ7dK/FlFlpUgvSimeQaxk7YbE/qnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695666; c=relaxed/simple;
	bh=eX9lfVVJR2BVhzV/tYGwXGSNKNujiiugoM7nlHQ/m7Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8PGmKhhxQ51DupafKYZ+1DoFS0LptC5r1fiuqgqI3SK+T6eiQ4JbztncdaJnOv6j5fqi+hJ8tuQDKYOjolhd3+v3r5qBUkQalS28FHow2bxmMuu2ajZOMk6PJA0snQbT8zOn/Avfx7ZoZvEa1NNVxQvvzHj9DaKnx3u5vT2/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4woDOZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4woDOZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D61F00893;
	Tue, 29 Sep 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695661;
	bh=2Nzo6EeAYcXqhCvISVz53NpYjzT3ifyMIXr6KdWohrQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f4woDOZMMxIysvAwiUELij/Dp9emEiuHRk48Juj6mXQ1vo1M/QQkzx0neid5RFc0i
	 TRFLwz3Dcg5gZRMTKDJQ8NY/BgQ/r10NQXDN9Caga1KPp6eLi4VISsPcgx8YYWYHrz
	 E2uGOn3LJfxJpQNy4Y71qEQi2f3Kqo3MyTfQhOmmEhKEw17rsHCX+2kbw9Xyz1+bTW
	 Gy92eRPDbijMPYO6iTJ95vGgO6oHxFsErBqawbCkxI1hupCa+1lPB+6DQneFHL1wYD
	 RymDRGr+lkNrZYzTHub66yGZVQvSziiUOblhcsdMOa3Ez00UL+evN2wFsBEgVz1ZjS
	 uY3sNokTbo2NA==
Subject: Re: [PATCH net-next 2/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 15:27:40 +0000
Message-ID: <179069566060.434549.16590048574814647850@kernel.org>
In-Reply-To:
 <20260925-miic-validate-dtb-v1-2-3a6db9bb75ec@reliablecontrols.com>
References:
 <20260925-miic-validate-dtb-v1-2-3a6db9bb75ec@reliablecontrols.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The patch fixes a real memory-safety bug but has no Fixes: tag.
- [Low] Coding style in the new code in miic_parse_dt().

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the kernel-doc
  for struct modctrl_match.conv says that for RZ/T2H/RZ/N2H 'the first…

--

net: pcs: rzn1-miic: Validate dtb configuration values

This patch adds range checks in miic_parse_dt() for the "reg" and
"renesas,miic-input" values read from child nodes. If either value is
out of range for the SoC, the probe fails with -EINVAL.

> Bad configuration values from the dtb could result in out of bounds array
> access. Verify that parsed values are within range for the SoC and fail the
> probe if they are invalid.
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

[Severity: Low]
Should this have a Fixes: tag?

Before this patch, miic_parse_dt() used an unchecked DT "reg" value here:

	dt_val[port + !miic->of_data->miic_port_start] = conf;

That could write outside the conf_conv_count byte buffer. The buffer was
originally a fixed on-stack array. This unchecked write and the
conf_to_string[conf[i]] lookup both appear to date back to commit
7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver").

The earlier commit daf677c2c644 ("net: pcs: rzn1-miic: Fix config array
initialization") has a Fixes: tag. Would something like this work here?

Fixes: 7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver")

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index 62daaf76e0525..30ac2d4070052 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -695,9 +695,24 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)

[ ... ]

>  		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
>  			continue;
>  
> +		if (conf >= miic->of_data->conf_to_string_count) {
> +			dev_err(miic->dev, "Port configuration out of range: %d\n", conf);
> +			of_node_put(conv);
> +			ret = -EINVAL;
> +			goto err;
> +			}

[Severity: High]
The commit message says the patch will "Verify that parsed values are
within range for the SoC". Is the renesas,miic-switch-portin value still
unchecked? Earlier in miic_parse_dt() it is stored directly:

	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
		dt_val[0] = conf;

Take an out-of-range value, such as 20 on RZ/N1 (where conf_to_string[]
has 14 entries) or 9 or more on RZ/T2H. No modctrl_match entry will
match it, so the error path uses it as an index:

miic_parse_dt()
  miic_match_dt_conf()
    miic_dump_conf()
      conf_name = of_data->conf_to_string[conf[i]];

Can this read past the end of conf_to_string[] and then pass the pointer
it finds to dev_err() as a %s string?

dt_val is also s8, so the u32 is truncated with no check:

- 128 to 254 become negative indexes.
- 255 becomes MIIC_MODCTRL_CONF_NONE, so the property is silently
  ignored.
- 258 wraps to 2 and is accepted as a valid value.

The binding limits this property to enum [0, 1, 2], but that is only
checked by dt_binding_check, not at runtime.

Could the same range check be applied to the u32 value before it is
stored in dt_val[0]? Checking it against the PORTIN values the SoC
allows would be stricter still.

[Severity: Low]
This isn't a bug, but the closing brace of this new block is indented one
tab too far.

Also, conf is a u32. Should the dev_err() use %u instead of %d?

> +
>  		/* Adjust for 0 based index */
>  		dt_val[port + !miic->of_data->miic_port_start] = conf;

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
kernel-doc for struct modctrl_match describes RZ/T2H and RZ/N2H like
this:

 * @conv: Configuration of ethernet port muxes. First index is SWITCH_PORTIN,
 *	  then index 1 - 5 are CONV1 - CONV5 for RZ/N1 SoCs. In case
 *	  of RZ/T2H and RZ/N2H SoCs, the first index is SWITCH_PORTIN then
 *	  index 0 - 3 are CONV0 - CONV3.

Index 0 is already SWITCH_PORTIN. This line stores RZ/T2H converter p at
dt_val[p + 1], which matches rzt2h_index_to_string[] being
{"SWITCH_PORTIN", "CONV0", ..., "CONV3"}.

Should the comment say that index 1 - 4 are CONV0 - CONV3?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-miic-validate-dtb-v1-0-3a6db9bb75ec%40reliablecontrols.com
