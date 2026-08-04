Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775123932F7
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884857; cv=none; b=Y5tU9QM3H8XdMdDS7AqUF/+QuzzKlqv4D94x4GIVxXseaE/Oy+1aGylgnicE2GtODyH5e0vH1UumXZRU8f1gyF9KTQhNCJb2HF/lkmTK//QJlg2ecNcI1S036BwRIUvjzrmeuK7SK7ei1XsLTjlwR0mdgm4N2cIvK81JAzebdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884857; c=relaxed/simple;
	bh=1hDIff361753XBYUL6NRGP33azA76JKU74y8cWRiAuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NONu9aQ1dXpra/QJkgH4GYzEfJLGZZ7aCAEVGWbAby3jNDBjPsXqIqL8yTSgJfw+I+xk1AwNj5Z8+3SBjC6hJyJb67FPX9JIq/+BL+cBmjIs76A0CBAQ4gy+5/sQ2b/mK6Vem8zwPMxPC4XS/qmvRHvwUnZLYnBpGago5olkPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Djc2GsZO; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Djc2GsZO"
Message-ID: <bc5060c8-7709-4354-aa48-7f64b857c00c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785884843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trDSFRPvj2GCWVyUH5CMYnL2x3JtdfnWGWy7m3/e5iI=;
	b=Djc2GsZOdr6i9TZisgz3SWPTj0vNpJ5HpdShb/cju9/OXbppSkLMesf0Ih+ZlB4KU9Kirl
	7zUZozneUYcjTMmS0tKRjhLL1/9MTAJX6VMO7/q0PILZ3NXOh0+In/YILdmUCpL1VgHbaC
	k+857HJWGx1SwpqE+ehLJLMbRdgD2Bo=
Date: Wed, 5 Aug 2026 00:07:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/2] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260803140637.102339-1-ivecera@redhat.com>
 <20260803140637.102339-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260803140637.102339-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/08/2026 15:06, Ivan Vecera wrote:
> Add low-level DPLL channel operations for ToD read/write/adjust,
> output phase step, delta frequency offset write and TIE (Time
> Interval Error) write. These serve as building blocks for the PTP
> clock callbacks added in the next patch.
> 
> ToD operations use a wait-before-write pattern to avoid blocking
> after each operation.
> 
> The tod_ready_wait helper selects the poll timeout based on the
> current ToD command - write operations use a longer timeout (1000 ms)
> than reads (30 ms).
> 
> The ToD read captures system timestamps (ptp_system_timestamp) around
> the HW command and completion poll to support cross-timestamping.
> 
> The TIE write operation provides sub-picosecond resolution phase
> adjustment for modes where the DPLL is tracking a reference
> (AUTO and REFLOCK).
> 
> Add output step-time mask to struct zl3073x_dev and
> zl3073x_dev_out_is_stepped() helper to check if an output
> participates in step-time operations.
> 
> Reviewed-by: Petr Oros <poros@redhat.com>
> Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.c | 310 +++++++++++++++++++++++++++++++++++-
>   drivers/dpll/zl3073x/chan.h |  32 ++++
>   drivers/dpll/zl3073x/core.c |  13 ++
>   drivers/dpll/zl3073x/core.h |  23 +++
>   drivers/dpll/zl3073x/regs.h |  52 ++++++
>   5 files changed, 428 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 4ec2cf53dad468..79874a9fdb4962 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
> @@ -3,6 +3,7 @@
>   #include <linux/cleanup.h>
>   #include <linux/delay.h>
>   #include <linux/dev_printk.h>
> +#include <linux/ptp_clock_kernel.h>
>   #include <linux/string.h>
>   #include <linux/types.h>
>   
> @@ -162,8 +163,8 @@ int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index)
>    * @zldev: pointer to zl3073x_dev structure
>    * @index: DPLL channel index to fetch state for
>    *
> - * Reads the mode_refsel register and reference priority registers for
> - * the given DPLL channel and stores the raw values for later use.
> + * Reads the mode_refsel, status and reference priority registers for
> + * the given DPLL channel and stores the values for later use.
>    *
>    * Return: 0 on success, <0 on error
>    */
> @@ -234,6 +235,311 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
>   	return &zldev->chan[index];
>   }
>   
> +/**
> + * zl3073x_chan_tod_ready_wait - wait for ToD semaphore to clear
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + *
> + * Polls the ToD control register until the semaphore bit is cleared,
> + * indicating the device has completed the previous ToD operation.
> + *
> + * Return: 0 on success, -EBUSY if semaphore not cleared, <0 on error
> + */
> +int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch)
> +{
> +	unsigned int timeout;
> +	u8 tod_ctrl;
> +	int rc;
> +
> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch), &tod_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	switch (FIELD_GET(ZL_DPLL_TOD_CTRL_CMD, tod_ctrl)) {
> +	case ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ:
> +		timeout = ZL_POLL_TOD_WR_TIMEOUT_US;
> +		break;
> +	default:
> +		timeout = ZL_POLL_TOD_RD_TIMEOUT_US;
> +		break;
> +	}

there are 3 cmds defined, but FIELD_GET(ZL_DPLL_TOD_CTRL_CMD) can return
up to 16 possible values. I would explicitly put defined commands in
cases and make default to ENOTSUPP..

> +
> +	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
> +				  ZL_DPLL_TOD_CTRL_SEM, timeout);
> +
> +	return rc == -ETIMEDOUT ? -EBUSY : rc;
> +}

[...]

> +#define ZL_DPLL_TOD_CTRL_SEM			BIT(4)
> +#define ZL_DPLL_TOD_CTRL_CMD			GENMASK(3, 0)
> +#define ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ	1
> +#define ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT		8
> +#define ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ	9
