Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B54336883;
	Sun, 16 Aug 2026 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878262; cv=none; b=Nvi3xFcuTzCy3JWQAkygvqUAm3mrrEwVsPmZliXiW8bNmKLQ/XGmIMlcQ+mxhKJlan9k1egG3FdXZNf50+1LdqNk4HIXUlqHN6fcoKId/1KH0lerJ3AP5lzMsIYqZY1v9UachH7RkliVsGbgTKigNoxopSEiMbBUnMamtC9n0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878262; c=relaxed/simple;
	bh=WqeY2uljvl7E/0XHXqt3z/3e9iWfCPHg2Xs4N15MJnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcV777vMybVpQIdi+2ffmQ5ZsXQBXlSP7Yhf1PVcf3ZAwpBpjj7lCq9DGrf1IYSE09OejQURaenxfobJPWXUzRqHkFW7b+BFJuwoYgG0op/ZZ2JZ2rwR/tfatL6Wm0MFO5Cz/pB+rQe+q53gG3Dk3xi8rEDHI/nStfNosUyibMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=rbqut+02; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="rbqut+02"
Received: from L30177.local (unknown [78.240.72.98])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id BCA44B00548;
	Sun, 16 Aug 2026 13:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1786878251;
	bh=WqeY2uljvl7E/0XHXqt3z/3e9iWfCPHg2Xs4N15MJnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbqut+02sc4pYVvTFJHc0gGxzGS8IC5WyDfyTmCs/CqbGqQjwyWRmtzyK/MKnpIta
	 6TTW/Or3jEllDzEo7dxa195ZHfoj4pnS/1D35S07J+ekVIzjSAPFoQLwH7cl8V5WH3
	 hOow4UaXKmZqun3lOqJNeTrWb5WyIjPHNtT6bcGm9A9jod7kpBluJGfarRiPAIe2DI
	 fwTiHJP2O22qTfEZuMR/2xWdQbfEoyBOcVNQhI4/SIhp/ON6iWFq2SI2jLQ1HmwgBk
	 X07gLOLCc+wK8KomCIpaJ7fisw6uRl4SLSy74qB3HxmN12GRRKwfdAJPpO6DVqiZlb
	 pF1/JO6ntW+jw==
Date: Sun, 16 Aug 2026 13:04:01 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] dpll: zl3073x: add chip-specific minimum input
 reference frequency
Message-ID: <aoGZIYuA7NHTX0x7@L30177.local>
References: <20260814153253.900280-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814153253.900280-1-ivecera@redhat.com>

Hi Ivan,

Thanks for leading it. Below some few minor comments.

> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 5b2d77f2c2288e..c0b3b0d579d524 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -20,29 +20,30 @@
>  #include "dpll.h"
>  #include "regs.h"
>  
> -#define ZL_CHIP_INFO(_id, _nchannels, _flags)				\
> -	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags) }
> +#define ZL_CHIP_INFO(_id, _nchannels, _flags, _min_freq)		\
> +	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags),	\
> +	  .min_ref_freq = (_min_freq) }

Do we really need this C macro ? Everytime we'll add something, it leads to a
wide numbder of line changes for zl3073x_chip_ids[]. What's about using directly the named
fields below and leaving 0/nothing for default cases such as the min_ref_freq ( something like
min_ref_freq ?: 1; ) ? 
 ... return zldev->info->min_ref_freq ?: 1; ...

If you prefer to keep the C macro, then let's use a variadic, something like:
#define ZL_CHIP_INFO(_id, _nchannels, _flags, ...)			\
	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags),\
	  ##__VA_ARGS__ }

then only the ZL30643 entry needs to be touched:
	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32,
		     .min_ref_freq = 1000),

>  
>  static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
> -	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
 ...
> -	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP),
> +	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32, 1000),
> +	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
 ...
> +	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP, 1),

That's a wide set of changes just to add/update 1 line. Since an update is needed, I feel the macro
should be avoided so only
	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32, 1000),
is needed.

Then, the init code could set to 1 if the value of .min_ref_freq is 0.

> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -281,7 +281,8 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>  		sync_freq = zl3073x_ref_freq_get(sync_ref);
>  
>  		/* Sync signal must be 8 kHz or less and clock reference
> -		 * must be 1 kHz or more and higher than the sync signal.
> +		 * must meet the chip's minimum frequency requirement and be
> +		 * higher than the sync signal.
>  		 */
>  		if (sync_freq > 8000) {
>  			NL_SET_ERR_MSG(extack,
> @@ -289,9 +290,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>  			rc = -EINVAL;
>  			goto unlock;
>  		}
> -		if (ref_freq < 1000) {
> -			NL_SET_ERR_MSG(extack,
> -				       "clock frequency must be 1 kHz or more");
> +		if (ref_freq < zldev->info->min_ref_freq) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "clock frequency must be %u Hz or more",
> +					   zldev->info->min_ref_freq);
>  			rc = -EINVAL;
>  			goto unlock;
>  		}

TBC: to be considered if 0 means 1 (à la zldev->info->min_ref_freq ?: 1)

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978ef..cdceddcf353e46 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -20,9 +20,9 @@
>   * @freq: frequency to check
>   *
>   * The function checks the given frequency is valid for the device. For input
> - * pins it checks that the frequency can be factorized using supported base
> - * frequencies. For output pins it checks that the frequency divides connected
> - * synth frequency without remainder.
> + * pins it checks that the frequency is above the chip's minimum and can be
> + * factorized using supported base frequencies. For output pins it checks that
> + * the frequency divides connected synth frequency without remainder.
>   *
>   * Return: true if the frequency is valid, false if not.
>   */
> @@ -36,6 +36,10 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>  	if (dir == DPLL_PIN_DIRECTION_INPUT) {
>  		int rc;
>  
> +		/* Check minimum frequency */

This comment is not needed, the code tells us.

> +		if (freq < zldev->info->min_ref_freq)
> +			goto err_inv_freq;
> +
>  		/* Check if the frequency can be factorized */
>  		rc = zl3073x_ref_freq_factorize(freq, NULL, NULL);
>  		if (rc)
> 

Best regards,
  Vincent
