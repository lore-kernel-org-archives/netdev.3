Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C00376A04
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006761; cv=none; b=AmGHBkRyqW2cZNBdJlfIWKJsZ7irlG/8aST7UW+i3n+tctmE42+RXTwRnneWs3VeEfGb+jj+aHXRu2yEpNGTxOaLw8tXxPJ2eUwPKENIuDvdFfkJAZ1YKnSv/FDPkv7BCS8Qi9FNklXfbOiDW+o8Z/MFu/a949sc/TTj8aIC878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006761; c=relaxed/simple;
	bh=tSqEaRM2ebFk2nKl+gKUP1h1uQs0qRbsnPfzQv4EBAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0J/rkNe/uUMIMP4Ma6LZbBuKpU48FoSLrv1f7fPBKTVVrvB68Bz/RQV+hkMx4aKce14R6thaXgLSkXQNhKbhd8WpR7nR0N5TOHQV/4H2+GqR+k8VmYA6l+zf8OH3u3bjL/n1fFDtKBUEG9l8us9bsR35E0qiQcC3JM6jNLDKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClFggOA5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClFggOA5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso18866095e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786006758; x=1786611558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hz7p/0R4cazLeloER7BY4ptZVwcivZ0VzPNuNCtZ/qY=;
        b=ClFggOA5VeV+wJ0KDDuSHBfqMzOMX13n9J2PD9XsXFDDifKmgsyWcaa3shROWdkMv2
         igbivjHGU3gPxsVa1WoCGZJmj7Bez3w9yD7b9Ri0OUddhbdI2sHW+SxQ21zj8jAnnalk
         OpPuvKUeWEFSVvnww/xfFFU6T770xWMMxY6B0a7lRB8KJ3NFb3/bDZHIj7jVK8bNVifN
         4ooX5otxzH4Rums/yznOZEnAywZ0Y3Ivqex/4JdI9ohiB/B8FjKoDgcjRai5o/+34Htk
         alKcrvAtLvo4RqCAUkVuhc6A4y4Bw7iFowjqBBKQ3VzXnzDyAVptXkEccdIZYTyCbSgQ
         mSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006758; x=1786611558;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hz7p/0R4cazLeloER7BY4ptZVwcivZ0VzPNuNCtZ/qY=;
        b=tPQWtDgJ+nYf4ts2Y7j/H+7vOX8EtXBdjnA+7dQODC6Fz0CwIM88r86Xo0JqId+9Bk
         p4ivj4MYKyrcdppSfq+Kgm+fua/x5hp+SEZuEjH3PzrsS9blOIVW4mKYYux5DZEVV5pL
         1rPGybTBUXQI+PTIYWlso8o5rPUEujndWVlFldy2aLfRKQXBNmwCIBStcWWEALI1WggN
         S+nnIWX3JnYMg3GpRDpdowV1zCfrGX24GuzUTKc/L8Goqogaq/ofHIHtRYW+pf36zR17
         zthjTT+AZhwpq3r3i8RGWT99wJUf/yh3rAOQWeqtyT3Y7uP/hsmsvNJtqrb3grYf3zbF
         KZSw==
X-Forwarded-Encrypted: i=1; AHgh+RrlEAULQRaqtPkQ9lHZu18NFc8YWSro6e37IMaIgRI05lyyNEJ25VBuqmj8Vh2CRtJH/A9mxr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuitGn4jP/tnCbh3upnPU9VkRgfdw2rjC1nq1PRhhG+z0u6Izb
	EXrHictENxJ6WlHgY9rq7+6T4qV4kOpGLPLE3jKSi436qxmU6EtQpWbi
X-Gm-Gg: AR+sD1014vO6SPHHTX1hkbh5lDTKEWnGyeVB3bTCLL5uKoSnqnJ6M1YBsFZOM4e5D9H
	qFiUyybl1ugtikFo51cNzJ2qNkjZtTNMi0c1wnwM1RZXiYDY9ydTcUrK923S7pqEUnj7Smtz73b
	1A2b/81KQ7hx92sF0ae5RQTR3kfnJYXJk/35CoT4KtMrMuqL4r0f0Flc81WOsnHcRInedodaYX7
	vjt6Q248T09nC3IDk1SUisn+ckrLjQZ3jOtA2H37mr/12PsURAO7M2R/rlVtuFmPtaIgZYRqedF
	rmZtGiGQQWnBoXzc6/rLpD4WiILAB4X4UTykz5DDGob8K/GYoDdqvZ428XhbYA+BwJL7IPJpG//
	BIh2bmBzyH7fTQ2vaOEYHlKI9oMA/PDaUObPjatw6zKWi5U2G8teD9npUjoXC6B3LmJbMG5bTJq
	+9KC/yITd13z9QXCBQkKmZ6w9il0tDFQIqeSw9/JvBTiC5IvdGbZfg7Tz4dmsq3uOqdo/sZyFis
	T7KGSc3xqUjLiBxDa3uGXWphD8qazE8DVPoLusdXfPpt9kJCsNY/FyEhukyonU=
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4994e7112a3mr155421725e9.4.1786006757817;
        Thu, 06 Aug 2026 01:59:17 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f131:1d01:8da1:260c:d732:9394? ([2001:9e8:f131:1d01:8da1:260c:d732:9394])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b525dsm57140085e9.0.2026.08.06.01.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:59:17 -0700 (PDT)
Message-ID: <32bed9c5-3ee9-4e95-9f6f-a0b2c36a9354@gmail.com>
Date: Thu, 6 Aug 2026 10:59:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/4] net: pse-pd: realtek-pse-mcu: add UART
 transport
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net
References: <20260802100114.720594-5-jelonek.jonas@gmail.com>
 <20260806011113.1855680-1-kuba@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260806011113.1855680-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.08.26 03:11, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: pse-pd: realtek-pse-mcu: add UART transport
>
> This adds a serdev (UART) transport for the Realtek PSE MCU core, with
> send/recv callbacks that exchange the 12-byte frames and an asynchronous
> receive_buf callback. The baud rate defaults to 19200 and can be overridden
> with the "current-speed" property.
>
>> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-uart.c b/drivers/net/pse-pd/realtek-pse-mcu-uart.c
>> new file mode 100644
>> index 0000000000000..9baa17d8d31fa
>> --- /dev/null
>> +++ b/drivers/net/pse-pd/realtek-pse-mcu-uart.c
>> @@ -0,0 +1,164 @@
> [ ... ]
>
>> +/*
>> + * No framing is done here: a glitched frame costs one transaction, then
>> + * the next _send re-frames from rx_len 0. Resync works by returning count
>> + * (not take), dropping any overflow so serdev keeps no leftover to bleed
>> + * into the next frame.
>> + */
>> +static size_t rtpse_mcu_uart_receive(struct serdev_device *serdev,
>> +				     const u8 *buf, size_t count)
>> +{
>> +	struct rtpse_mcu_uart *ctx = serdev_device_get_drvdata(serdev);
>> +	size_t take;
>> +
>> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
>> +		take = min(count, sizeof(ctx->rx_buf) - ctx->rx_len);
>> +		if (take) {
>> +			memcpy(ctx->rx_buf + ctx->rx_len, buf, take);
>> +			ctx->rx_len += take;
>> +			if (ctx->rx_len == sizeof(ctx->rx_buf))
>> +				complete(&ctx->rx_done);
>> +		}
>> +	}
>> +
>> +	/* consume all to avoid desync/misalignment */
>> +	return count;
>> +}
> [ ... ]
>
>> +static int rtpse_mcu_uart_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
>> +{
>> +	struct rtpse_mcu_uart *ctx = to_rtpse_mcu_uart(pse);
>> +	int written;
>> +
>> +	/* clear any leftover rx state before transmitting */
>> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
>> +		reinit_completion(&ctx->rx_done);
>> +		ctx->rx_len = 0;
>> +	}
> [ ... ]
>
>> +static int rtpse_mcu_uart_recv(struct rtpse_mcu_ctrl *pse,
>> +			       const struct rtpse_mcu_msg *req,
>> +			       struct rtpse_mcu_msg *resp)
>> +{
>> +	struct rtpse_mcu_uart *ctx = to_rtpse_mcu_uart(pse);
>> +
>> +	if (!wait_for_completion_timeout(&ctx->rx_done, RTPSE_MCU_UART_RX_TIMEOUT))
>> +		return -ETIMEDOUT;
>> +
>> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
>> +		if (ctx->rx_len != sizeof(*resp))
>> +			return -EIO;
>> +
>> +		memcpy(resp, ctx->rx_buf, sizeof(*resp));
>> +	}
>> +	return 0;
>> +}
> [Severity: Medium]
> Should rtpse_mcu_uart_recv() apply rtpse_mcu_resp_is_final() before
> accepting a frame?  The req argument is unused here, so the first complete
> 12-byte frame becomes the transaction result no matter what it contains.
>
> realtek-pse-mcu.h describes one of those frames as transient:
>
>   /*
>    * MCU status opcodes (seen on the Gen1 dialect; Gen2 never emits them).
>    * INCOMPLETE/BAD_CSUM are terminal; NOT_READY is transient.
>    */
>   #define RTPSE_MCU_OPCODE_NOT_READY		0xff	/* -EAGAIN  */
>
> and the I2C transport keeps polling until the acceptance predicate holds,
> so a NOT_READY frame never escapes the transaction:
>
>   drivers/net/pse-pd/realtek-pse-mcu-i2c.c:rtpse_mcu_i2c_smbus_recv() {
> 	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
> 		...
> 		if (ret == RTPSE_MCU_MSG_SIZE && rtpse_mcu_resp_is_final(req, resp))
> 			return 0;
> 	}
> 	return -ETIMEDOUT;
>   }
>
> With the UART transport, a NOT_READY frame is copied into resp and
> rtpse_mcu_do_xfer() turns it into an error for the caller:
>
>   drivers/net/pse-pd/realtek-pse-mcu-core.c:rtpse_mcu_do_xfer() {
> 	case RTPSE_MCU_OPCODE_NOT_READY:
> 		return -EAGAIN;
>   }
>
> Is any runtime caller prepared for that?  The only place -EAGAIN is retried
> is the probe-time boot loop in rtpse_mcu_discover(); the pse_controller_ops
> paths propagate it, so an ethtool PSE get/set would fail.
>
> Note that "realtek,pse-mcu-gen1" is in rtpse_mcu_uart_of_match[], which is
> the dialect documented as emitting these status opcodes.
>
> Can the real reply also be lost in that case?  Once rx_len is 12 the
> receive callback computes take == 0 and drops the following bytes; if they
> instead arrive after the next rtpse_mcu_uart_send() has reset rx_len to 0
> (the core only sleeps RTPSE_MCU_RESPONSE_MS = 25 ms between send and recv),
> they are consumed as the next transaction's response and rejected by:
>
>   if (resp->opcode != req->opcode ||
>       resp->seq_num != req->seq_num ||
>       resp->checksum != rtpse_mcu_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
> 	return -EBADMSG;
>
> failing a second consecutive operation.
>
> Would it make sense to loop on wait_for_completion_timeout() against a
> remaining-time budget until rtpse_mcu_resp_is_final(req, resp) holds?  As
> written only the first frame is waited for, leaving most of the
> RTPSE_MCU_RESPONSE_MAX_MS (1000 ms) receive budget unused.

Fixed in next version - uart_recv() now loops wait_for_completion_timeout()
against the remaining budget until resp_is_final(req, resp) holds, dropping
non-final frames (transient NOT_READY, or a stale frame from a prior
timeout), so it uses the full RESPONSE_MAX_MS and no longer surfaces a
transient frame as the transaction result.

Regards,
Jonas
