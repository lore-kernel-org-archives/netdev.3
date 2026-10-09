Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C573431F8;
	Fri,  9 Oct 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555992; cv=none; b=GI5zDOGh26gBStgxRpmyl44fWK0bjIHuupmKZbagDnD5URQS1UWoNHVq+E+aQPU45aU59ONz9kQdWDuzSSMavvtvvmLtg7oYZLQ1948veVaw+rtFWOp5ZfU831DhYDyp4CBqGRLrfNaw+n05o3/Z3ttN+enNzS3hq9ILGBnFZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555992; c=relaxed/simple;
	bh=jsgXyspX+A1abRVIuSI4vKkw0YZqKn+DWQ6nHxC+fjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND5QIjtmEsO5HuNO+xEXJ6kGjGFyFdg6lBrNMsx6FCfVU0PLWU8T/I2e5jaWvQiyBUheOPARdx0y8bg40Y8mn148m+XcCC0BDS6+HGl+ZowIKlFWaaqGzlpQlvTq92WompEbidhfE45YyFLxrjsetxhjtcFnPEzNDMUNwS9GPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+rQK5js; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+rQK5js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7410E1F00893;
	Fri,  9 Oct 2026 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555991;
	bh=pM5q2YWqVU6exVxt+Fkb1ukGHEwP5IPEUe1WbHW/XFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D+rQK5jsExPJqhyjzg0n2LyXmgwKcz7HRkEYRChcdrjzmD/z19VcVaCfbu7I1am3F
	 4KtOPuUvOO8JXz1hRWnCSEQo6QLt4nhMDl234gkNGzFR2K6flUXfKU2ymU4KF353Lt
	 j3AU4T3twEKAva07aZONUU/L48rU1viaD633VuZSwdazl8OU9hI8tX3PwBKnUoi1kY
	 oM+anowbAvGvPEiBS2mmZLoKDi1XIZVmkzgHXXeQYDBfQwytQ19eVC9GXLVHi0HckT
	 ROz7J5iegBtpbtq4gip5kKNRkQGGqZdIEYUzg4100j+skmPB/WCwZvhbIYYURBqjHk
	 kTtm9FWrF3BMw==
Date: Fri, 9 Oct 2026 15:26:26 +0100
From: Simon Horman <horms@kernel.org>
To: Kyle Hendry <khendry@reliablecontrols.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
Message-ID: <20261009142626.GE83879@horms.kernel.org>
References: <20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com>
 <20261006-miic-validate-dtb-v3-v3-2-68617b3dca5c@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-miic-validate-dtb-v3-v3-2-68617b3dca5c@reliablecontrols.com>

On Tue, Oct 06, 2026 at 09:48:12AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Bad configuration values from the dtb could result in out of bounds array
> access. Verify parsed values are within range for the SoC and fail the
> probe if invalid.
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index 31716241b58f..10622eb654d2 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -693,16 +693,40 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>  	memset(dt_val, MIIC_MODCTRL_CONF_NONE,
>  	       sizeof(*dt_val) * miic->of_data->conf_conv_count);
>  
> -	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
> -		dt_val[0] = conf;
> +	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0) {
> +		if (conf >= miic->of_data->conf_to_string_count) {
> +			dev_err(miic->dev, "Port input configuration out of range: %d\n",
> +				conf);
> +			ret = -EINVAL;
> +			goto err;
> +		} else {
> +			dt_val[0] = conf;
> +		}
> +	}

Hi Kyle,

Please drop the else arm here, it is unnecessary.

Doing so will move the code into the preferred style
of handling errors conditionally while keeping
the main thread of execution outside (extra) conditions.

(Completely untested, but I mean like this.)

	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0) {
		if (conf >= miic->of_data->conf_to_string_count) {
			dev_err(miic->dev, "Port input configuration out of range: %d\n",
				conf);
			ret = -EINVAL;
			goto err;
		}
		dt_val[0] = conf;
	}

With that change, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested
