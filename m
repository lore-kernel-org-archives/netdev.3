Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2317745
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833080; cv=none; b=neCzii4+xK0fXudhrXU+IG56Saal4ZSxkHgaRVpYHn1zCiv+EyS8dTELKHmYIFpecmugPHRHchCWMlEovWzKb5GJdD1MuMHOXfpfFpKAR0Cr03AlPNn1RzxJvWvxQS84beYOZIASTLJIWqKIYp4lhzUUAZyk6S/HZxxxYp1fuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833080; c=relaxed/simple;
	bh=ochZGMB79pJEEOlm9p+rcI9rCFcFOhWT4zN1qBoAHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxhRQszN88D4CyjbxmsaG7TAxOPNVjKVaYmLlh/99Iz17pg0q/N8B88YHqyh+8j26lQUG2K26aduD6jxERT2/chSw3WmIaU7knYiIiEV7/Bv2uzG3gii0Y10G7fF0llMs/ZrOjSN3ZAyAnp3zsp9lEGs7LNpjSK1zCkPRNmUlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bx0nlTjL; arc=none smtp.client-ip=91.218.175.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bx0nlTjL"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ochZGMB79pJEEOlm9p+rcI9rCFcFOhWT4zN1qBoAHJ8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786833076; v=1; x=1787437876;
 b=Bx0nlTjLnuJ4DzVOHerifj1o2Gl3pS/mkZLpCkOwzjH5Qm415Gtch7zdTNWajvboBq6QPene
 8xWA/s9LMRHHsacRgAXrsG0VM7XHUFi3GYtZ1kxJJP9XhSl19OoIw7nkr0Yh653CHPgNABNrYxY
 dPx3XIxI4joyvR2bKwFTevLg=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (78.152.211.167)
	by smtp.migadu.com with ESMTPS id d3d0aed047fec7dc;
	Sat, 15 Aug 2026 22:31:05 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e1243e9c-2f8d-4e80-aa35-b6b9b5341bc7@linux.dev>
Date: Sat, 15 Aug 2026 23:31:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: zl3073x: add chip-specific minimum input
 reference frequency
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vincent Jardin <vjardin@free.fr>, Min Li <min.li@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, open list <linux-kernel@vger.kernel.org>
References: <20260814153253.900280-1-ivecera@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260814153253.900280-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2026 16:32, Ivan Vecera wrote:
> Commit 24e4aff8983fe6 ("dpll: zl3073x: recognize the ZL30643 chip ID
> (0x0E3B)") added support for the ZL30643, a ZL3064x line-card variant
> that is register-compatible with ZL3073x. However, ZL3064x chips
> require a minimum input reference frequency of 1 kHz, not 1 Hz like
> other ZL3073x parts.
> 
> Add a min_ref_freq field to zl3073x_chip_info and validate it in both
> the DT property parser and the ref-sync pair configuration to prevent
> configuring unsupported frequencies on ZL3064x parts.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/core.c | 43 +++++++++++++++++++------------------
>   drivers/dpll/zl3073x/core.h |  2 ++
>   drivers/dpll/zl3073x/dpll.c | 10 +++++----
>   drivers/dpll/zl3073x/prop.c | 10 ++++++---
>   4 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 5b2d77f2c2288e..c0b3b0d579d524 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -20,29 +20,30 @@
>   #include "dpll.h"
>   #include "regs.h"
>   
> -#define ZL_CHIP_INFO(_id, _nchannels, _flags)				\
> -	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags) }
> +#define ZL_CHIP_INFO(_id, _nchannels, _flags, _min_freq)		\
> +	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags),	\
> +	  .min_ref_freq = (_min_freq) }
>   
>   static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
> -	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E94, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
> -	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP),
> -	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP),
> +	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32, 1000),
> +	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x0E94, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
> +	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP, 1),
> +	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP, 1),
>   };
>   
>   #define ZL_RANGE_OFFSET		0x80
> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
> index 78dc208f3eea2a..51014463377356 100644
> --- a/drivers/dpll/zl3073x/core.h
> +++ b/drivers/dpll/zl3073x/core.h
> @@ -42,11 +42,13 @@ enum zl3073x_flags {
>    * @id: chip ID
>    * @num_channels: number of DPLL channels supported by this variant
>    * @flags: chip variant flags
> + * @min_ref_freq: minimum input reference frequency in Hz
>    */
>   struct zl3073x_chip_info {
>   	u16		id;
>   	u8		num_channels;
>   	unsigned long	flags;
> +	u32		min_ref_freq;
>   };
>   
>   /**
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 83bd3027dbaa1e..ee077c3e68da83 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -281,7 +281,8 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   		sync_freq = zl3073x_ref_freq_get(sync_ref);
>   
>   		/* Sync signal must be 8 kHz or less and clock reference
> -		 * must be 1 kHz or more and higher than the sync signal.
> +		 * must meet the chip's minimum frequency requirement and be
> +		 * higher than the sync signal.
>   		 */
>   		if (sync_freq > 8000) {
>   			NL_SET_ERR_MSG(extack,
> @@ -289,9 +290,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   			rc = -EINVAL;
>   			goto unlock;
>   		}
> -		if (ref_freq < 1000) {
> -			NL_SET_ERR_MSG(extack,
> -				       "clock frequency must be 1 kHz or more");
> +		if (ref_freq < zldev->info->min_ref_freq) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "clock frequency must be %u Hz or more",
> +					   zldev->info->min_ref_freq);
>   			rc = -EINVAL;
>   			goto unlock;
>   		}
> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978ef..cdceddcf353e46 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -20,9 +20,9 @@
>    * @freq: frequency to check
>    *
>    * The function checks the given frequency is valid for the device. For input
> - * pins it checks that the frequency can be factorized using supported base
> - * frequencies. For output pins it checks that the frequency divides connected
> - * synth frequency without remainder.
> + * pins it checks that the frequency is above the chip's minimum and can be
> + * factorized using supported base frequencies. For output pins it checks that
> + * the frequency divides connected synth frequency without remainder.
>    *
>    * Return: true if the frequency is valid, false if not.
>    */
> @@ -36,6 +36,10 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>   	if (dir == DPLL_PIN_DIRECTION_INPUT) {
>   		int rc;
>   
> +		/* Check minimum frequency */
> +		if (freq < zldev->info->min_ref_freq)
> +			goto err_inv_freq;
> +
>   		/* Check if the frequency can be factorized */
>   		rc = zl3073x_ref_freq_factorize(freq, NULL, NULL);
>   		if (rc)
> 
> base-commit: 4f93b12cf7b25fbf8e73d222722805b049f0a6d3

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
