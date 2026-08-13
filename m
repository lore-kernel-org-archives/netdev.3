Received: from mta1.migadu.com (out-248.mta1.migadu.com [95.215.58.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84810443E39
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656135; cv=none; b=es0aad8TOreiP03xcR5KlhL6YY6we4ifebkB5t807la1XsEkb8FBnhcRncPbwMyVF1QkPoIQXIUtzh4mNZTAxz11rl5NxnIBnd1GfIs5QhS2R2KIHJOG6lMQ2tkeIMpNMUNalrPrT+hzV0Hs01OuXp6zpbl7pgjCpQ7GgkJMy8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656135; c=relaxed/simple;
	bh=ItWFzxV4XvwvnuvE0xfB+o8XfGydReax69cRxpasOvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1LjwDZExoQ7mucliAfIE4zQI9eD9SwTy+hHeHUVrrBb/RnlNAHJ9aWoHKzLjD28z6fIIgtqn8IaQBd8ihA0AY/H3HiC0oog8/MLJ46khWUivVtKDA64TDQNXWBfsCGJhksIhRwLf/BbulaH3wPj9/j9ThLzBVwJu8VN2UUtVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K/9ojfYh; arc=none smtp.client-ip=95.215.58.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K/9ojfYh"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ItWFzxV4XvwvnuvE0xfB+o8XfGydReax69cRxpasOvU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786656127; v=1; x=1787260927;
 b=K/9ojfYhPgLd1TXTdy/R5i5TqeXQuasgL9YbduZnYXsUogU2FCzbuxOOi9zeCF+xxoeKLlmp
 fwJTv9NdwsUne+iORbQA0yB2g3FV4e4R4Ffwos+S3dF6dH04YRcE04wltc0d6YO95pz6dfW26Tk
 tZ0GmnejeBlGu5ialsl+490Y=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (64.43.42.247)
	by smtp.migadu.com with ESMTPS id cf8d6393399d12c1;
	Thu, 13 Aug 2026 21:21:57 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <dfbb7647-8c39-4620-9eb6-74d84b066f19@linux.dev>
Date: Thu, 13 Aug 2026 22:21:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-3-ivecera@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260811134700.1211010-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 14:46, Ivan Vecera wrote:

[...]

> + * zl3073x_chan_tod_adjust - atomic ToD read-modify-write with rollover guard
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @delta: time adjustment to apply
> + *
> + * Reads the next-Hz ToD and current ToD, then checks whether enough time
> + * remains before the next 1 Hz rollover to safely complete the write.
> + * Re-reads if the 1 Hz tick crossed between the two reads or if less
> + * than 20 ms remains before the next rollover. Applies @delta and writes
> + * the result back.

you keep 20ms threshold based on the avg read/write transaction time (I
assume), but it may happen, that this call will be preempted in between
reads and write, and 20ms will not be enough before 1Hz rollover. Have
you though about such option?

> + *
> + * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
> +			    struct timespec64 delta)
> +{
> +#define ZL_TOD_MAX_RETRIES	20
> +	static const long threshold_ns = 20 * NSEC_PER_MSEC;
> +	struct timespec64 ts_next, ts_cur, diff;
> +	int rc, i;
> +
> +	for (i = 0; i < ZL_TOD_MAX_RETRIES; i++) {
> +		rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
> +		if (rc)
> +			return rc;
> +
> +		rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
> +		if (rc)
> +			return rc;
> +
> +		/* Ensure the 1 Hz tick did not cross between the two reads
> +		 * and that enough margin remains to complete the write.
> +		 */
> +		diff = timespec64_sub(ts_next, ts_cur);
> +		if (diff.tv_sec > 0 ||
> +		    (!diff.tv_sec && diff.tv_nsec >= threshold_ns))
> +			break;
> +	}
> +	if (i == ZL_TOD_MAX_RETRIES) {
> +		dev_warn(zldev->dev,
> +			 "DPLL%u ToD adjust failed to get stable margin\n",
> +			 ch);
> +		return -EBUSY;
> +	}
> +
> +	/* Apply delta to the next-Hz ToD */
> +	ts_next = timespec64_add(ts_next, delta);
> +	if (!timespec64_valid(&ts_next))

maybe timespec64_valid_settod() will be better as the code is about
modifying ToD?

> +		return -EINVAL;
> +
> +	return zl3073x_chan_tod_write(zldev, ch, ts_next);
> +#undef ZL_TOD_MAX_RETRIES
> +}

