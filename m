Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48855364953
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277793; cv=none; b=rAW2gX6QaaI8zoM/buqvxeblCbydkvJBxKkYhLV7LYBaoVuKYN38hPd7TlBcYpV1/4M/I17H6dZqTmfK+fmPDo5JO1ENM56r8wy45CyrADGDiMqsStNQ2tk6bXfNVv8Y0BzZcl9uMkX1Gqq8g9vfQ0ERKOcU62h/tcKzvnY3A/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277793; c=relaxed/simple;
	bh=3OywWkQvCdXZkccPggfvQ7fg1qs90jrTr/WblNgHqAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUi53e2nmOWNQ1LJDoh8zt6EaUIqxKhuSnWe6p+RnaAXZET8PSeOFROB429xdhmbO26RlRpOCktW+kZUoIXq21HVmXK9JneolFS0dY7Vj0FfdOHR88OeTVkMwwM7HqSVFEcpciIkOnDq6bDRJwU483ApN/JGa1vbMAp/raRT+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lmhbv6e/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZ/HZNcL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lmhbv6e/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZ/HZNcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784277790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3kYnxuI0Oaaz8pcPi4SLxe28ToVB1PIWo3oiYOjmBw=;
	b=Lmhbv6e/xSOr3ySOrXOF3wvaKPXlPvqn+C/Av5TwY1INTqdgh2lCWw+eYYbMvxT1rx/wRk
	50l7GB6CjT+7TKf0pyuIro2vIyBtS03VTdBEk8UkpQTe8c6lbxOf5c00SK7tMCjnj6bQAC
	3BOPM9KL9ry+qYu1N3dRDoVTXfsR3UU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-315BWkWjMz-0Mv8qtAvEVA-1; Fri, 17 Jul 2026 04:43:08 -0400
X-MC-Unique: 315BWkWjMz-0Mv8qtAvEVA-1
X-Mimecast-MFC-AGG-ID: 315BWkWjMz-0Mv8qtAvEVA_1784277787
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4731a357b0aso4026270f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784277787; x=1784882587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3kYnxuI0Oaaz8pcPi4SLxe28ToVB1PIWo3oiYOjmBw=;
        b=FZ/HZNcLJs33jACCiOfDJ8oOPwo3syW0vsDjEKRtPB7yFY2wYczs2e7CuJOFlOcHMk
         JKg3tJxB9McPrP55HLTGhq6+wEh7yGcfpseO67RIdXjdBxX8+UCiEeHLjjMWCbBlaq9F
         gcXIBzcZ6+8QVilHRw7gXOzbeBX7SYnuejcDAQK0z4i/TGbWu5NvB6ZMExKVAFOsJSIg
         OPpMadMgTVFNyS3IozeCT/aZoKQ14O6kdQWfQOL2VDHz+KIqKkGmzyCD4v8vWgbY+/8R
         XzDm0EgviYyO7kGj0unt0Tk/v9NiUgWIJ+QIAT8wyYh55mzsnDaOnzIBa9RDXV7TqBfM
         5Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784277787; x=1784882587;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3kYnxuI0Oaaz8pcPi4SLxe28ToVB1PIWo3oiYOjmBw=;
        b=nZQKwJMMFgYxUm3gCqXQu/BfQrwu9ttwQcH3D3YAWHd8INXRVyC/tKDwud01vNP6NF
         KADYCgLMdiXoYlpmCQkoykGs7qZe1pF3NT2C7Bzyp4dvOqErkgSwRSM7hzbW2GAYekJb
         fHeKMx6DE54R5ybP1ffKIm5AEA4obS2aKw2pJN23P51b9JIf/rF6IffxGh9wcnAbmY/y
         iDGgxEerPurLGeycc6CvtcH7S0aaN1BukPv9KspEF+fbe4GRU3vzfdFjG9DEuw710MdU
         4w1k3uXdjiRMD3e7ocwup/x4BfUODZu/laL3q2i0VQMUlMwaNSMYUS2/pCCgfrWJ3Sgz
         KY7g==
X-Forwarded-Encrypted: i=1; AHgh+RoK2g5Jt/3bj6iihtw4y35DVBRUNBvxGkMUvV5v+xVUunBoqz1uhrs5p8ag0GUb8129MLppdA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6rnWRlo9r6CQFWIewNinR3L0GdQ9NetISVW0dgJCXr5M9TV1
	+R04TGxhPAuKT+48598xlXaoLaWjIL0XyZz6rYe4xONT7WkRfIK+9uI2CMEtinpYj3E4BLNE6q2
	TuKsSAIsMJmDz6kv9rZipkd9WOrPPPoLsv3UjdhqdAikVt0vPlz16qtEUXg==
X-Gm-Gg: AfdE7ckjuFjU/9GuiyHHgl+Y2D4aTjuB2BbLzazPf1rNQgKDALJXdUYJi2rSvXQ5Z4d
	ni+6MTzQxF+R16PZJ4Jt6xxqgLSWERVkPty1vSOPjB5tD0LdJx4R04nnN5tDbMdRanRAGpiXezT
	ccL3ZM2wCFsrb0bS2nVuv8Mlm4Du1ERBLv1qTRfoMAkb3xXcdc+cq+QY6ORYwVN0YYwJAahd3Qx
	/+Vyg9VYwXd8cp553zi/tGBBHio0ifMRsuvxIAiMWXv7uOnOsXx0tgnPytXm0ZKsoj5vJ3fMGwT
	6vugMI3J1dGI408IZ9v2l6Vk24vmS9mqL5MwJvQ48Hgz6yPvQwPGImyyuCNboBFmaJF0cK2WZAI
	=
X-Received: by 2002:a05:600c:1d1b:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-4954a3db7dbmr18082015e9.15.1784277786702;
        Fri, 17 Jul 2026 01:43:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1b:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-4954a3db7dbmr18081525e9.15.1784277786083;
        Fri, 17 Jul 2026 01:43:06 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2f210csm33351205e9.15.2026.07.17.01.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 01:43:04 -0700 (PDT)
Message-ID: <b25c379a-7146-432e-ab7a-12d9a4de6650@redhat.com>
Date: Fri, 17 Jul 2026 10:43:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add PTP clock support
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260713103739.1553284-1-ivecera@redhat.com>
 <20260713103739.1553284-3-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260713103739.1553284-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/13/26 12:37, Ivan Vecera wrote:
> Add PTP clock support for the ZL3073x DPLL driver. A PTP clock device
> is registered for each DPLL channel regardless of the initial channel
> state, providing gettimex64, settime64, adjtime, adjfine, adjphase,
> getmaxphase and perout callbacks.
>
> Callback availability depends on the current channel state:
> - adjfine: when NCO pin is connected (returns -EOPNOTSUPP otherwise)
> - adjphase: available when tracking a reference, uses TIE write
> - adjtime: always available and uses
>    * phase step for sub-second deltas when NCO pin is connected
>    * TIE write when tracking a reference
>    * plain ToD read-modify-write otherwise
> - gettime/settime: always available
>
> The adjtime callback splits multi-second adjustments into a ToD
> read-modify-write for the seconds part and a sub-second mechanism
> (phase step or TIE write) for the remainder. On partial failure
> where seconds were already committed, success is returned to
> prevent the PTP servo from retrying and applying seconds again.
>
> Output pins eligible for periodic output (single-ended, marked in
> output_step_time_mask, supporting 1 Hz) are registered as PTP perout
> channels. Enabling perout sets the output frequency to 1 Hz via the
> existing DPLL frequency_set path.
>
> All PTP callbacks are serialized by the existing per-DPLL zldpll->lock
> mutex, which is also used by DPLL pin and device callbacks.
>
> Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/Kconfig |   6 +-
>   drivers/dpll/zl3073x/dpll.c  | 575 +++++++++++++++++++++++++++++++++--
>   drivers/dpll/zl3073x/dpll.h  |   6 +
>   3 files changed, 551 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
> index 5bbca14005813..d0574ad571d3f 100644
> --- a/drivers/dpll/zl3073x/Kconfig
> +++ b/drivers/dpll/zl3073x/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config ZL3073X
>   	tristate "Microchip Azurite DPLL/PTP/SyncE devices" if COMPILE_TEST
> -	depends on NET
> +	depends on NET && PTP_1588_CLOCK_OPTIONAL
>   	select DPLL
>   	select NET_DEVLINK
>   	select REGMAP
> @@ -16,7 +16,7 @@ config ZL3073X
>   
>   config ZL3073X_I2C
>   	tristate "I2C bus implementation for Microchip Azurite devices"
> -	depends on I2C && NET
> +	depends on I2C && NET && PTP_1588_CLOCK_OPTIONAL
>   	select REGMAP_I2C
>   	select ZL3073X
>   	help
> @@ -28,7 +28,7 @@ config ZL3073X_I2C
>   
>   config ZL3073X_SPI
>   	tristate "SPI bus implementation for Microchip Azurite devices"
> -	depends on NET && SPI
> +	depends on NET && SPI && PTP_1588_CLOCK_OPTIONAL
>   	select REGMAP_SPI
>   	select ZL3073X
>   	help
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index d91f52b58eae3..7c11de35821ae 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -2,6 +2,7 @@
>   
>   #include <linux/bits.h>
>   #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>   #include <linux/bug.h>
>   #include <linux/container_of.h>
>   #include <linux/dev_printk.h>
> @@ -14,6 +15,7 @@
>   #include <linux/netlink.h>
>   #include <linux/platform_device.h>
>   #include <linux/property.h>
> +#include <linux/ptp_clock_kernel.h>
>   #include <linux/slab.h>
>   #include <linux/sprintf.h>
>   
> @@ -42,6 +44,7 @@
>    * @phase_offset: last saved pin phase offset
>    * @freq_offset: last saved fractional frequency offset
>    * @measured_freq: last saved measured frequency
> + * @perout_idx: PTP perout channel index, or -1 if not perout-eligible
>    */
>   struct zl3073x_dpll_pin {
>   	struct list_head	list;
> @@ -59,6 +62,7 @@ struct zl3073x_dpll_pin {
>   	s64			phase_offset;
>   	s64			freq_offset;
>   	u32			measured_freq;
> +	s8			perout_idx;
>   };
>   
>   /*
> @@ -936,21 +940,17 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
>   }
>   
>   static int
> -zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
> -				      void *pin_priv,
> -				      const struct dpll_device *dpll,
> -				      void *dpll_priv, u64 frequency,
> -				      struct netlink_ext_ack *extack)
> +__zl3073x_dpll_output_pin_frequency_set(struct zl3073x_dpll *zldpll,
> +					struct zl3073x_dpll_pin *pin,
> +					u64 frequency)
>   {
> -	struct zl3073x_dpll *zldpll = dpll_priv;
>   	struct zl3073x_dev *zldev = zldpll->dev;
> -	struct zl3073x_dpll_pin *pin = pin_priv;
>   	const struct zl3073x_synth *synth;
>   	u32 new_div, synth_freq;
>   	struct zl3073x_out out;
>   	u8 out_id;
>   
> -	guard(mutex)(&zldpll->lock);
> +	lockdep_assert_held(&zldpll->lock);
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = *zl3073x_out_state_get(zldev, out_id);
> @@ -1011,6 +1011,21 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   	return zl3073x_out_state_set(zldev, out_id, &out);
>   }
>   
> +static int
> +zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
> +				      void *pin_priv,
> +				      const struct dpll_device *dpll,
> +				      void *dpll_priv, u64 frequency,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +
> +	guard(mutex)(&zldpll->lock);
> +
> +	return __zl3073x_dpll_output_pin_frequency_set(zldpll, pin_priv,
> +						       frequency);
> +}
> +
>   static int
>   zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
>   					 void *pin_priv,
> @@ -1608,6 +1623,7 @@ zl3073x_dpll_pin_alloc(struct zl3073x_dpll *zldpll, enum dpll_pin_direction dir,
>   	pin->dpll = zldpll;
>   	pin->dir = dir;
>   	pin->id = id;
> +	pin->perout_idx = -1;
>   
>   	return pin;
>   }
> @@ -1626,6 +1642,44 @@ zl3073x_dpll_pin_free(struct zl3073x_dpll_pin *pin)
>   	kfree(pin);
>   }
>   
> +/**
> + * zl3073x_dpll_pin_is_perout - check if output pin is perout-eligible
> + * @pin: DPLL pin to check
> + * @props: pin properties (already fetched by caller)
> + *
> + * An output pin is eligible for PTP periodic output if it is single-ended
> + * (not differential) and supports 1 Hz in its frequency list.
> + *
> + * Return: true if eligible, false otherwise
> + */
> +static bool
> +zl3073x_dpll_pin_is_perout(struct zl3073x_dpll_pin *pin,
> +			   const struct zl3073x_pin_props *props)
> +{
> +	struct zl3073x_dpll *zldpll = pin->dpll;
> +	const struct zl3073x_chan *chan;
> +	u8 out_id;
> +	int i;
> +
> +	if (zl3073x_dpll_is_input_pin(pin))
> +		return false;
> +
> +	out_id = zl3073x_output_pin_out_get(pin->id);
> +	if (zl3073x_dev_out_is_diff(zldpll->dev, out_id))
> +		return false;
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	if (!zl3073x_chan_is_out_stepped(chan, out_id))
> +		return false;
> +
> +	for (i = 0; i < props->dpll_props.freq_supported_num; i++) {
> +		if (props->dpll_props.freq_supported[i].min == 1)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   /**
>    * zl3073x_dpll_pin_register - register DPLL pin
>    * @pin: pointer to DPLL pin
> @@ -1667,6 +1721,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
>   		if (pin->prio == ZL_DPLL_REF_PRIO_NONE)
>   			/* Clamp prio to max value */
>   			pin->prio = ZL_DPLL_REF_PRIO_MAX;
> +	} else if (zl3073x_dpll_pin_is_perout(pin, props)) {
> +		pin->perout_idx = zldpll->ptp_info.n_per_out++;
>   	}
>   
>   	/* Create or get existing DPLL pin */
> @@ -1897,6 +1953,8 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>   	u8 id, index;
>   	int rc;
>   
> +	zldpll->ptp_info.n_per_out = 0;
> +
>   	/* Process input pins */
>   	for (index = 0; index < ZL3073X_NUM_PINS; index++) {
>   		/* First input pins and then output pins */
> @@ -2280,45 +2338,447 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)
>   	return rc;
>   }
>   
> +/* Maximum frequency adjustment: +-1% of nominal in ppb */
> +#define ZL3073X_DPLL_PTP_MAX_ADJ	10000000
> +
>   /**
> - * zl3073x_dpll_alloc - allocate DPLL device
> - * @zldev: pointer to zl3073x device
> - * @ch: DPLL channel number
> + * zl3073x_dpll_ptp_gettimex64 - read current time from ToD counters
> + * @info: PTP clock info
> + * @ts: timespec to store current time
> + * @sts: optional system timestamp pair for cross-timestamping
>    *
> - * Allocates DPLL device structure for given DPLL channel.
> + * Return: 0 on success, <0 on error
> + */
> +static int zl3073x_dpll_ptp_gettimex64(struct ptp_clock_info *info,
> +				       struct timespec64 *ts,
> +				       struct ptp_system_timestamp *sts)
> +{
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
> +
> +	guard(mutex)(&zldpll->lock);
> +
> +	return zl3073x_chan_tod_read(zldpll->dev, zldpll->id, false, ts, sts);
> +}
> +
> +/**
> + * zl3073x_dpll_ptp_settime64 - set ToD counters to given time
> + * @info: PTP clock info
> + * @ts: timespec with time to set
>    *
> - * Return: pointer to DPLL device on success, error pointer on error
> + * Return: 0 on success, <0 on error
>    */
> -struct zl3073x_dpll *
> -zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
> +static int zl3073x_dpll_ptp_settime64(struct ptp_clock_info *info,
> +				      const struct timespec64 *ts)
>   {
> -	struct zl3073x_dpll *zldpll;
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
>   
> -	zldpll = kzalloc_obj(*zldpll);
> -	if (!zldpll)
> -		return ERR_PTR(-ENOMEM);
> +	guard(mutex)(&zldpll->lock);
>   
> -	zldpll->dev = zldev;
> -	zldpll->id = ch;
> -	mutex_init(&zldpll->lock);
> -	INIT_LIST_HEAD(&zldpll->pins);
> +	return zl3073x_chan_tod_write(zldpll->dev, zldpll->id, *ts);
> +}
>   
> -	return zldpll;
> +/**
> + * zl3073x_dpll_ptp_adjtime_phase_step - adjust sub-second time via phase step
> + * @zldpll: DPLL channel
> + * @delta: time adjustment in nanoseconds (must be within (-NSEC_PER_SEC,
> + *         NSEC_PER_SEC))
> + *
> + * Uses the output phase step mechanism with tod_step=1 to adjust both
> + * the output clock phase and the ToD counter simultaneously. This keeps
> + * outputs and ToD coherent. Only valid for NCO.
> + *
> + * Outputs are grouped by synthesizer since the phase step value is in
> + * synthesizer clock cycles. The first synth group with enabled outputs
> + * uses tod_step to adjust both outputs and the ToD counter. Remaining
> + * groups step outputs only. If no synth has enabled outputs, the ToD
> + * counter is stepped alone using an empty output mask (the FW uses the
> + * lowest-ID synth's period for the conversion).
> + *
> + * Return: 0 on success, -EOPNOTSUPP if no synths available, <0 on error
> + */
> +static int zl3073x_dpll_ptp_adjtime_phase_step(struct zl3073x_dpll *zldpll,
> +					       s64 delta)
> +{
> +	u16 synth_mask[ZL3073X_NUM_SYNTHS] = {};
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	const struct zl3073x_synth *synth;
> +	const struct zl3073x_chan *chan;
> +	struct zl3073x_dpll_pin *pin;
> +	u32 first_synth_freq = 0;
> +	bool tod_stepped = false;
> +	s32 step_cycles;
> +	u32 synth_freq;
> +	int rc;
> +	u8 i;
> +
> +	chan = zl3073x_chan_state_get(zldev, zldpll->id);
> +
> +	/* Build per-synth output masks from registered output pins */
> +	list_for_each_entry(pin, &zldpll->pins, list) {
> +		u8 out_id, synth_id;
> +
> +		if (zl3073x_dpll_is_input_pin(pin))
> +			continue;
> +
> +		out_id = zl3073x_output_pin_out_get(pin->id);
> +
> +		if (!zl3073x_chan_is_out_stepped(chan, out_id))
> +			continue;
> +
> +		synth_id = zl3073x_dev_out_synth_get(zldev, out_id);
> +		if (synth_id >= ZL3073X_NUM_SYNTHS) {
> +			dev_warn(zldev->dev, "Unexpected synth id for OUT%u\n",
> +				 out_id);
> +			continue;
> +		}
> +		synth_mask[synth_id] |= BIT(out_id);
> +	}
> +
> +	/* Process each synth group */
> +	for (i = 0; i < ZL3073X_NUM_SYNTHS; i++) {
> +		synth = zl3073x_synth_state_get(zldev, i);
> +		if (!zl3073x_synth_is_enabled(synth) ||
> +		    zl3073x_synth_dpll_get(synth) != zldpll->id)
> +			continue;
> +
> +		synth_freq = zl3073x_synth_freq_get(synth);
> +
> +		/* Remember lowest-ID synth freq for ToD-only fallback */
> +		if (!first_synth_freq)
> +			first_synth_freq = synth_freq;
> +
> +		if (!synth_mask[i])
> +			continue;
> +
> +		/* Safe for s32: max synth freq is 750 MHz */
> +		step_cycles = div_s64(delta * synth_freq, NSEC_PER_SEC);
> +
> +		rc = zl3073x_chan_phase_step(zldev, zldpll->id,
> +					     synth_mask[i], step_cycles,
> +					     !tod_stepped);
> +		if (rc) {
> +			if (tod_stepped) {
> +				dev_warn(zldev->dev,
> +					 "Partial phase step failure\n");
> +				return 0;
> +			}
> +			return rc;
> +		}
> +		tod_stepped = true;
> +	}
> +
> +	if (!first_synth_freq)
> +		return -EOPNOTSUPP;
> +
> +	/* No enabled outputs found; step ToD counter only using the
> +	 * lowest-ID synth's period (empty output mask).
> +	 */
> +	if (!tod_stepped) {
> +		step_cycles = div_s64(delta * first_synth_freq, NSEC_PER_SEC);
> +		return zl3073x_chan_phase_step(zldev, zldpll->id, 0,
> +					       step_cycles, true);
> +	}
> +
> +	return 0;
>   }
>   
>   /**
> - * zl3073x_dpll_free - free DPLL device
> - * @zldpll: pointer to zl3073x_dpll structure
> + * zl3073x_dpll_ptp_adjtime - adjust PTP clock time
> + * @info: PTP clock info
> + * @delta: time adjustment in nanoseconds
>    *
> - * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
> + * For NCO, large deltas (>= 1 second) are split into a ToD
> + * read-modify-write for the seconds part and an output phase step for
> + * the sub-second remainder. Sub-second deltas use phase step directly,
> + * falling back to ToD read-modify-write if phase step is unavailable.
> + * In AUTO/REFLOCK modes, large deltas are split into ToD
> + * read-modify-write for seconds and TIE write for the sub-second
> + * remainder. Sub-second deltas use TIE write directly.
> + *
> + * Return: 0 on success, <0 on error
>    */
> -void
> -zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
> +static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
>   {
> -	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	const struct zl3073x_chan *chan;
> +	bool sec_adjusted = false;
> +	struct timespec64 ts;
> +	int rc;
>   
> -	mutex_destroy(&zldpll->lock);
> -	kfree(zldpll);
> +	if (!delta)
> +		return 0;
> +
> +	guard(mutex)(&zldpll->lock);
> +
> +	/* Modes without phase step or TIE use plain ToD adjust */
> +	chan = zl3073x_chan_state_get(zldev, zldpll->id);
> +	if (!zl3073x_chan_mode_is_nco(chan) &&
> +	    !zl3073x_chan_mode_supports_tie(chan))
> +		return zl3073x_chan_tod_adjust(zldev, zldpll->id,
> +					       ns_to_timespec64(delta));
> +
> +	/* Split off seconds via ToD read-modify-write so the sub-second
> +	 * remainder can be applied through the output-coherent mechanism
> +	 * (phase step or TIE write).
> +	 */
> +	if (abs(delta) >= NSEC_PER_SEC) {
> +		s32 remainder;
> +
> +		ts.tv_sec = div_s64_rem(delta, NSEC_PER_SEC, &remainder);
> +		ts.tv_nsec = 0;
> +		delta = remainder;
> +
> +		rc = zl3073x_chan_tod_adjust(zldev, zldpll->id, ts);
> +		if (rc)
> +			return rc;
> +
> +		sec_adjusted = true;
> +
> +		/* No sub-second remainder, done */
> +		if (!delta)
> +			return 0;
> +	}
> +
> +	/* Apply sub-second delta via phase step (NCO) or TIE write */
> +	if (zl3073x_chan_mode_is_nco(chan)) {
> +		rc = zl3073x_dpll_ptp_adjtime_phase_step(zldpll, delta);
> +		if (!rc)
> +			return 0;
> +	} else {
> +		rc = zl3073x_chan_tie_write(zldev, zldpll->id, delta);
> +		if (!rc)
> +			return 0;
> +	}
> +
> +	/* Phase step or TIE write failed, fall back to ToD adjust */
> +	rc = zl3073x_chan_tod_adjust(zldev, zldpll->id,
> +				     ns_to_timespec64(delta));
> +
> +	/* In the unlikely event that both phase step/TIE write and fallback
> +	 * ToD adjust fail after seconds were already committed, return
> +	 * success to prevent the PTP servo from retrying the full delta and
> +	 * applying seconds again. The sub-second residual will self-correct
> +	 * in the next servo cycle.
> +	 */
> +	if (rc && sec_adjusted) {
> +		dev_warn(zldev->dev,
> +			 "Sub-second adjustment failed after seconds applied\n");
> +		return 0;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_dpll_ptp_adjfine - adjust PTP clock frequency
> + * @info: PTP clock info
> + * @scaled_ppm: frequency adjustment in scaled ppm (ppm * 2^16)
> + *
> + * Only supported for NCO. Writes the delta frequency offset register.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if NCO pin is not connected, <0 on error
> + */
> +static int
> +zl3073x_dpll_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
> +	const struct zl3073x_chan *chan;
> +	s64 offset;
> +
> +	/* Convert scaled_ppm to df_offset in 2^-48 steps:
> +	 *   df_offset = -(scaled_ppm * 2^32) / 10^6
> +	 *
> +	 * Simplify to avoid overflow:
> +	 *   df_offset = -(scaled_ppm * 2^26) / 5^6
> +	 *   df_offset = -(scaled_ppm * 67108864) / 15625
> +	 */
> +	offset = -div_s64((s64)scaled_ppm * 67108864LL, 15625);
> +
> +	guard(mutex)(&zldpll->lock);
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	if (!zl3073x_chan_mode_is_nco(chan))
> +		return scaled_ppm ? -EOPNOTSUPP : 0;
> +	if (offset == chan->df_offset)
> +		return 0;
> +
> +	return zl3073x_chan_df_offset_set(zldpll->dev, zldpll->id, offset);
> +}
> +
> +/**
> + * zl3073x_dpll_ptp_adjphase - adjust PTP clock phase
> + * @info: PTP clock info
> + * @delta: phase adjustment in nanoseconds
> + *
> + * Only supported in AUTO and REFLOCK modes. Uses TIE write for
> + * nanosecond resolution phase adjustment.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if mode doesn't support TIE, <0 on error
> + */
> +static int zl3073x_dpll_ptp_adjphase(struct ptp_clock_info *info, s32 delta)
> +{
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	const struct zl3073x_chan *chan;
> +
> +	if (!delta)
> +		return 0;
> +
> +	guard(mutex)(&zldpll->lock);
> +
> +	chan = zl3073x_chan_state_get(zldev, zldpll->id);
> +
> +	if (!zl3073x_chan_mode_supports_tie(chan))
> +		return -EOPNOTSUPP;
> +
> +	return zl3073x_chan_tie_write(zldev, zldpll->id, delta);
> +}
> +
> +static s32
> +zl3073x_dpll_ptp_getmaxphase(struct ptp_clock_info *info __always_unused)
> +{
> +	/* HW limits TIE write to +-1 second. Return the constant HW
> +	 * limit and let adjphase handle mode-specific checks.
> +	 */
> +	return NSEC_PER_SEC - 1;
> +}
> +
> +/**
> + * zl3073x_dpll_ptp_perout_find_pin - find pin by perout channel index
> + * @zldpll: DPLL channel
> + * @idx: perout channel index to find
> + *
> + * Return: pointer to the pin, or NULL if not found
> + */
> +static struct zl3073x_dpll_pin *
> +zl3073x_dpll_ptp_perout_find_pin(struct zl3073x_dpll *zldpll, int idx)
> +{
> +	struct zl3073x_dpll_pin *pin;
> +
> +	list_for_each_entry(pin, &zldpll->pins, list) {
> +		if (pin->perout_idx == idx)
> +			return pin;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * zl3073x_dpll_ptp_enable - enable/disable PTP clock functions
> + * @info: PTP clock info
> + * @rq: the requested clock function and parameters
> + * @on: true to enable, false to disable
> + *
> + * Handles PTP_CLK_REQ_PEROUT requests. Only 1PPS (period = 1s) is supported.
> + * On enable, configures the output divider for 1 Hz. On disable, does nothing
> + * as the signal is not disabled.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int zl3073x_dpll_ptp_enable(struct ptp_clock_info *info,
> +				   struct ptp_clock_request *rq, int on)
> +{
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
> +	struct zl3073x_dpll_pin *pin;
> +	unsigned int idx;
> +	int rc;
> +
> +	if (rq->type != PTP_CLK_REQ_PEROUT)
> +		return -EOPNOTSUPP;
> +
> +	idx = rq->perout.index;
> +	if (idx >= info->n_per_out)
> +		return -EINVAL;
> +
> +	/* Toggling output pins can produce runt pulses, so disable
> +	 * is a no-op.
> +	 */
> +	if (!on)
> +		return 0;
> +
> +	/* Only accept exactly 1PPS (period.sec == 1, nsec == 0) */
> +	if (rq->perout.period.sec != 1 || rq->perout.period.nsec != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&zldpll->lock);
> +
> +	pin = zl3073x_dpll_ptp_perout_find_pin(zldpll, idx);
> +	if (!pin) {
> +		mutex_unlock(&zldpll->lock);
> +		return -EINVAL;
> +	}
> +
> +	/* Already at 1 Hz, nothing to do */
> +	if (zl3073x_dev_output_pin_freq_get(zldpll->dev, pin->id) == 1) {
> +		mutex_unlock(&zldpll->lock);
> +		return 0;
> +	}
> +
> +	rc = __zl3073x_dpll_output_pin_frequency_set(zldpll, pin, 1);
> +
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (!rc)
> +		dpll_pin_change_ntf(pin->dpll_pin);
> +
> +	return rc;
> +}
> +
> +static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
> +	.owner		= THIS_MODULE,
> +	.max_adj	= ZL3073X_DPLL_PTP_MAX_ADJ,
> +	.gettimex64	= zl3073x_dpll_ptp_gettimex64,
> +	.settime64	= zl3073x_dpll_ptp_settime64,
> +	.adjtime	= zl3073x_dpll_ptp_adjtime,
> +	.adjfine	= zl3073x_dpll_ptp_adjfine,
> +	.adjphase	= zl3073x_dpll_ptp_adjphase,
> +	.getmaxphase	= zl3073x_dpll_ptp_getmaxphase,
> +	.enable		= zl3073x_dpll_ptp_enable,
> +};
> +
> +/**
> + * zl3073x_dpll_ptp_register - register PTP clock for a DPLL channel
> + * @zldpll: DPLL channel to register PTP clock for
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int zl3073x_dpll_ptp_register(struct zl3073x_dpll *zldpll)
> +{
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	struct ptp_clock *ptp_clock;
> +
> +	snprintf(zldpll->ptp_info.name, sizeof(zldpll->ptp_info.name),
> +		 "zl3073x-dpll%u", zldpll->id);
> +
> +	ptp_clock = ptp_clock_register(&zldpll->ptp_info, zldev->dev);
> +	if (IS_ERR(ptp_clock)) {
> +		dev_err(zldev->dev, "Failed to register PTP clock for DPLL%u\n",
> +			zldpll->id);
> +		return PTR_ERR(ptp_clock);
> +	}
> +
> +	zldpll->ptp_clock = ptp_clock;
> +
> +	return 0;
> +}
> +
> +/**
> + * zl3073x_dpll_ptp_unregister - unregister PTP clock for a DPLL channel
> + * @zldpll: DPLL channel to unregister PTP clock for
> + */
> +static void zl3073x_dpll_ptp_unregister(struct zl3073x_dpll *zldpll)
> +{
> +	if (!IS_ERR_OR_NULL(zldpll->ptp_clock)) {
> +		ptp_clock_unregister(zldpll->ptp_clock);
> +		zldpll->ptp_clock = NULL;
> +	}
>   }
>   
>   /**
> @@ -2403,6 +2863,48 @@ zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll)
>   	return 0;
>   }
>   
> +/**
> + * zl3073x_dpll_alloc - allocate DPLL device
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel number
> + *
> + * Allocates DPLL device structure for given DPLL channel.
> + *
> + * Return: pointer to DPLL device on success, error pointer on error
> + */
> +struct zl3073x_dpll *
> +zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
> +{
> +	struct zl3073x_dpll *zldpll;
> +
> +	zldpll = kzalloc_obj(*zldpll);
> +	if (!zldpll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	zldpll->dev = zldev;
> +	zldpll->id = ch;
> +	zldpll->ptp_info = zl3073x_dpll_ptp_clock_info;
> +	mutex_init(&zldpll->lock);
> +	INIT_LIST_HEAD(&zldpll->pins);
> +
> +	return zldpll;
> +}
> +
> +/**
> + * zl3073x_dpll_free - free DPLL device
> + * @zldpll: pointer to zl3073x_dpll structure
> + *
> + * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
> + */
> +void
> +zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
> +{
> +	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
> +
> +	mutex_destroy(&zldpll->lock);
> +	kfree(zldpll);
> +}
> +
>   /**
>    * zl3073x_dpll_register - register DPLL device and all its pins
>    * @zldpll: pointer to zl3073x_dpll structure
> @@ -2433,6 +2935,13 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
>   		return rc;
>   	}
>   
> +	rc = zl3073x_dpll_ptp_register(zldpll);
> +	if (rc) {
> +		zl3073x_dpll_pins_unregister(zldpll);
> +		zl3073x_dpll_device_unregister(zldpll);
> +		return rc;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -2446,7 +2955,7 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
>   void
>   zl3073x_dpll_unregister(struct zl3073x_dpll *zldpll)
>   {
> -	/* Unregister all pins and dpll */
> +	zl3073x_dpll_ptp_unregister(zldpll);
>   	zl3073x_dpll_pins_unregister(zldpll);
>   	zl3073x_dpll_device_unregister(zldpll);
>   }
> diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
> index faebc402ba1b7..9b5f72c33849c 100644
> --- a/drivers/dpll/zl3073x/dpll.h
> +++ b/drivers/dpll/zl3073x/dpll.h
> @@ -5,6 +5,8 @@
>   
>   #include <linux/dpll.h>
>   #include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/ptp_clock_kernel.h>
>   
>   #include "core.h"
>   
> @@ -22,6 +24,8 @@
>    * @type: DPLL type (PPS or EEC)
>    * @lock_status: last saved DPLL lock status
>    * @pins: list of pins
> + * @ptp_info: PTP clock info
> + * @ptp_clock: registered PTP clock (or NULL)
>    */
>   struct zl3073x_dpll {
>   	struct list_head		list;
> @@ -36,6 +40,8 @@ struct zl3073x_dpll {
>   	enum dpll_type			type;
>   	enum dpll_lock_status		lock_status;
>   	struct list_head		pins;
> +	struct ptp_clock_info		ptp_info;
> +	struct ptp_clock		*ptp_clock;
>   };
>   
>   struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
lgtm,

Reviewed-by: Petr Oros <poros@redhat.com>

