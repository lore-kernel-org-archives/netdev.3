Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE933B6F4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004131; cv=none; b=J0MR//lFhfhqjVaHT6m8uuHyhiHXYJkodC+/kxy1fUjm0EAnV/AdRuvL+urIvxlkPazT4n7HZrfvCBCWbLfmQ48qT/qlkSOr7NxV9sdNyr8NeqlD1nILaszUKxPGxcbkLxDkx0u7qesO7PloFQLnSpIYSkmz+jz1RIVXJvthIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004131; c=relaxed/simple;
	bh=lSicgOWfFyFX904RBP0Ahnm628nd/WIlp22f4h4sCeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDGQKIz8mWBqz/ZnTXt5/zWcDyQ9T0w42jBQd+x37ALmQDtbt81SBT6rzvD1o58JZgIwdAFan0cdNGDO7xiH62T3wvFdzXd1FeQbOsVPLpiJKrPQvtZe3hLvci8lBQfuQg8W9e6+JeENaxzSiIVDCwWrLMB27/yJTv58jvARt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMXS2pJO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMXS2pJO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso3565615e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786004126; x=1786608926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gM9IN2/npqCkPX/AjXxyRJsM409ZJAwxp/k8ZTKIPEQ=;
        b=iMXS2pJOe5e1Wk/sdyTaPUuDf3GbLlKiJA1AcFomHtqdRgE1uxulItQA20KpePQzuR
         h88gXsOKCwqQdUBX7SIglAOvtpw68BzpfHXGT64I34NkCxIdQVK1Wh+pPGGImFMEGb5K
         +0iNXI9Qdk4yvMxQp89nFhxh9536g2/AGX8SoFxhKCMNPJvURJHRBJ+NpKLPJsfeCJa2
         MKLZ0VUhHONLoKMgXEA51EnjwFNWyMziyO5yll88Vg0SBwA/o5zNiLuVyA2IG880xjZ2
         WqvxHR0SYZ2n7tEBfyiSDWdj4G/F+ycKNP1yIs5flC/5gWtaDDsp7XeBGPvphfIYWt8M
         NiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004126; x=1786608926;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gM9IN2/npqCkPX/AjXxyRJsM409ZJAwxp/k8ZTKIPEQ=;
        b=srCXZlGkTXLEbZSY/t9kf9fZRLs2iYDxriULlht5KyRq5OAuMQpiBh7h3S4F64i43Y
         HMISs+YCNO4Ho4cNg8m/FkS5l8/tD8E5sIWc0jTjR4NRV+k089Tb5yov9ATStYqdxelQ
         W3Yvl58s2ipiwI79kY7aFqlcoxm79A9hucAfGujfZAQY81F7zjJlXYjdmALX21gBBHt3
         5Iox6Re3A7kjpSVVnGU2XEssulQQrXEEYVEB7f3Tq8Dmo4HqqxKeis4coQ8w1v3v5eyx
         tzOHwLsTe3IeViWXP4RkLXHssPfvclfGPISOJWOhsLDS+sHU9bGhShbHCgZfddtrO92r
         RgBQ==
X-Forwarded-Encrypted: i=1; AHgh+Ropr1ZEc2QuEFkoCOliXeMeQF+DYXj5CF/y+663sbgEM0guP9yS864bGJjy2DcrHVQOmzmFops=@vger.kernel.org
X-Gm-Message-State: AOJu0YyghdXb9Yz2W8OB/YaD3DKU8hhahZtp2dEvwGgR59BDD/gIlvFk
	n+uFyB9XZCXVMMGzV6AoAEAH5f6F9zRNBr+Qb0Eow13CR/4YXKiPDOk0
X-Gm-Gg: AR+sD13g8vB8UWBjAWd+sAVhFWJ6zRjYosagdjRaQFCCPCqATINqQmLayt9HR2ubZEt
	NwILPr9XJZoXs3iAAXH7x4mxcAgZaDuq6VMdMbxo9YtM/M3NghoeofhyGXe4ZnlWmHDlBq+EjSr
	VPD/UA6LADGQ2mZxTwiCn59R6HrOoO5uzWHVgH9b+gHFFPKV9mMalOkpKmx2mBTwdsouT1ZI7l0
	Ffd3b7tE4awTy/TvBXV9gCTyGkKRikHLDN1vTVzX1VWSYo52yVQ8b24PUtiYi3eGa3fKo97Xgpr
	OFouTyxsTDoqKY/9UYPlc0ei/Q17oV9KdR+6VqBIpLQQiRXzCepApgWHbMSnYpfheKFNu06ZvPY
	3mwvVG18dKUwGZMORaz1scO4edVdiQIAmCdw/23c/tt6eEM+ZHFyelzLnIcoz7y8mKZRL9X3Yk7
	RBb6pH8/qgy/c2nbzEc/NjV5R3FV0YoqZbjmQ6SRZHXDrUIYDom8WS66Qq6qWbElp47BLQCaTLv
	Z2hHzqrwJVH5B1YqgYATecwtqIKzo+zcUoQpoyc0UnPsMg8/gpFpPG5FGJBpAQ=
X-Received: by 2002:a05:600c:12c8:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4994e7baae6mr113674705e9.10.1786004125903;
        Thu, 06 Aug 2026 01:15:25 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f131:1d01:8da1:260c:d732:9394? ([2001:9e8:f131:1d01:8da1:260c:d732:9394])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d72sm64914395e9.1.2026.08.06.01.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:15:25 -0700 (PDT)
Message-ID: <a8b34a1d-9aef-4e9b-8c29-a03c7c675c9f@gmail.com>
Date: Thu, 6 Aug 2026 10:15:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/4] net: pse-pd: add Realtek PSE MCU core
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net
References: <20260802100114.720594-3-jelonek.jonas@gmail.com>
 <20260806011110.1855449-1-kuba@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260806011110.1855449-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.08.26 03:11, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: pse-pd: add Realtek PSE MCU core
>
> This adds the shared core for the Realtek PSE MCU driver: the 12-byte
> request/response protocol with sum-mod-256 checksum, the per-dialect opcode
> tables and response parser hooks for the two protocol generations, and the
> pse_controller_ops glue plus a registration helper for the transport modules.
>
>> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-pd/realtek-pse-mcu-core.c
>> new file mode 100644
>> index 0000000000000..ed3b743470dbf
>> --- /dev/null
>> +++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
>> @@ -0,0 +1,988 @@
> [ ... ]
>
>> +	/*
>> +	 * Explicit MCU error opcodes (observed on the Gen1 dialect; harmless
>> +	 * to check for Gen2 too). Catch these before the generic opcode/CRC
>> +	 * mismatch path so callers see a meaningful errno.
>> +	 */
>> +	switch (resp->opcode) {
>> +	case RTPSE_MCU_OPCODE_INCOMPLETE:
>> +		return -EBADE;
>> +	case RTPSE_MCU_OPCODE_BAD_CSUM:
>> +		return -EBADMSG;
>> +	case RTPSE_MCU_OPCODE_NOT_READY:
>> +		return -EAGAIN;
>> +	}
>> +
>> +	if (resp->opcode != req->opcode ||
>> +	    resp->seq_num != req->seq_num ||
>> +	    resp->checksum != rtpse_mcu_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
>> +		return -EBADMSG;
>> +
>> +	return 0;
>> +}
> [Severity: Low]
> Does this validation in rtpse_mcu_do_xfer() accept an all-zero frame as a
> valid reply?
>
> For a request with opcode 0x00 and seq_num 0x00, an all-zero 12-byte
> response satisfies every term:
>
>   resp->opcode  == 0 == req->opcode
>   resp->seq_num == 0 == req->seq_num
>   rtpse_mcu_checksum() over eleven 0x00 bytes == 0 == resp->checksum
>
> Both dialects use 0x00 for a real command:
>
>   rtpse_mcu_dialect_gen1: [RTPSE_MCU_CMD_PORT_ENABLE]      = RTPSE_MCU_OP(0x00)
>   rtpse_mcu_dialect_gen2: [RTPSE_MCU_CMD_SET_GLOBAL_STATE] = RTPSE_MCU_OP(0x00)
>
> and seq_num wraps back to 0x00 every 256 transactions since pse->seq is a u8
> incremented unconditionally in rtpse_mcu_do_xfer():
>
>   req->seq_num = pse->seq++;
>
> Would it be worth adding a discriminator here, for instance rejecting a frame
> whose bytes are all zero, or reserving seq_num 0?

done in next version.

>> +static int rtpse_mcu_port_cmd(struct rtpse_mcu_ctrl *pse, unsigned int port, u8 opcode, u8 arg)
>> +{
>> +	struct rtpse_mcu_msg req, resp;
>> +	int ret;
>> +
>> +	rtpse_mcu_msg_init(&req, opcode);
>> +	req.payload[0] = port;
>> +	req.payload[1] = arg;
>> +
>> +	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (resp.payload[0] != port || resp.payload[1] != 0)
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
> [Severity: Low]
> Related to the above: does this echo check catch the all-zero frame for port
> 0? An all-zero payload gives payload[0] == 0 == port and payload[1] == 0, so
> a Gen1 port-0 enable/disable would be reported as successful even though the
> frame carried no MCU data. rtpse_mcu_set_global_state() has the same shape,
> it only requires resp.payload[0] == 0x0.
>
> The same hole also shortens the poll in the I2C transport, since
> rtpse_mcu_resp_is_final() declares an all-zero read final for opcode 0x00 /
> seq_num 0x00 and the loop stops instead of waiting for the genuine reply.

done in next version.

> [ ... ]
>
>> +	/*
>> +	 * Release the MCU from reset before the first transaction; the
>> +	 * boot-retry loop in discover() waits for it to answer.
>> +	 */
>> +	gpiod = devm_gpiod_get_optional(pse->dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(gpiod))
>> +		return dev_err_probe(pse->dev, PTR_ERR(gpiod),
>> +				     "failed to get reset gpio\n");
>> +
>> +	ret = rtpse_mcu_discover(pse, &info);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Some boards gate all ports through a hardware line; deassert it only
>> +	 * once the MCU is confirmed present, so a failed probe leaves the ports
>> +	 * gated. From here the MCU protocol governs per-port admin state.
>> +	 */
>> +	gpiod = devm_gpiod_get_optional(pse->dev, "disable-ports", GPIOD_OUT_LOW);
>> +	if (IS_ERR(gpiod))
>> +		return dev_err_probe(pse->dev, PTR_ERR(gpiod),
>> +				     "failed to get disable-ports gpio\n");
> [Severity: Medium]
> Does the comment's promise hold for failures after this point?
>
> rtpse_mcu_register() drives disable-ports low here, but nothing re-asserts it
> on the error paths that follow. The devres unwind only releases the
> descriptor; gpiod_free_commit() in drivers/gpio/gpiolib.c clears descriptor
> flags, drops the label and optionally calls gc->free(), it does not change the
> driven output level:
>
>   if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
>           if (guard.gc->free)
>                   guard.gc->free(guard.gc, gpiod_hwgpio(desc));
>           clear_bit(GPIOD_FLAG_ACTIVE_LOW, &flags);
>
> So if devm_add_action_or_reset() or devm_pse_controller_register() below fails
> (the latter propagates -EINVAL/-ENODEV from of_load_pse_pis() for a
> missing or mismatched pse-pis node, and -ENOMEM from the kfifo/devres
> allocations), the board is left with all ports ungated and no driver bound.
> The same applies on unbind or module unload.
>
> Since the level also persists past the descriptor's lifetime, doesn't a
> subsequent probe attempt start with the gate already open? That is exactly the
> case the comment guards against: if rtpse_mcu_discover() then fails on a
> re-probe, the ports are ungated while the MCU is unresponsive and unmanaged.
>
> Would a devm action that re-asserts the line (and the reset line) fit here?

Not added, possible failure here is seen less critical then having kill all PoE ports
in case anything in the probe might get wrong. This would even be the case if the
GPIO is asserted by default after reset, outside of the driver, and asserting this
would make PoE non-functional though the probe failure might not be critical.

>> +	if (!info.system_enable) {
>> +		ret = rtpse_mcu_set_global_state(pse, true);
>> +		/* Dialects without a global-state concept (e.g. Gen1) return
>> +		 * -EOPNOTSUPP; treat that as "no separate enable required".
>> +		 */
>> +		if (ret && ret != -EOPNOTSUPP)
>> +			return dev_err_probe(pse->dev, ret,
>> +					     "failed to enable PSE system\n");
>> +		if (!ret) {
>> +			ret = devm_add_action_or_reset(pse->dev,
>> +						       rtpse_mcu_global_disable, pse);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
> [Severity: Medium]
> Is there any compensating teardown for the Gen1 case? rtpse_mcu_dialect_gen1
> has no RTPSE_MCU_CMD_SET_GLOBAL_STATE entry, so
> rtpse_mcu_set_global_state() returns -EOPNOTSUPP and no devm action is
> registered at all. The same happens on boards that already report
> info.system_enable, where the whole block is skipped. For those boards
> nothing disables power or re-gates the ports on a later probe failure or on
> unbind.

IMO the driver shouldn't mess with what it hasn't touched before, so no teardown
if nothing has been activated/enabled before.

> [ ... ]
>
>> diff --git a/drivers/net/pse-pd/realtek-pse-mcu.h b/drivers/net/pse-pd/realtek-pse-mcu.h
>> new file mode 100644
>> index 0000000000000..52f9442d7117c
>> --- /dev/null
>> +++ b/drivers/net/pse-pd/realtek-pse-mcu.h
>> @@ -0,0 +1,93 @@
> [ ... ]
>
>> +/*
>> + * A polling transport can stop here: the reply to this request (opcode and
>> + * seq_num), or a terminal error. The seq_num rejects a stale reply left by an
>> + * abandoned transaction, instead of desyncing by one frame.
>> + */
>> +static inline bool rtpse_mcu_resp_is_final(const struct rtpse_mcu_msg *req,
>> +					   const struct rtpse_mcu_msg *resp)
>> +{
>> +	return (resp->opcode == req->opcode && resp->seq_num == req->seq_num) ||
>> +	       resp->opcode == RTPSE_MCU_OPCODE_INCOMPLETE ||
>> +	       resp->opcode == RTPSE_MCU_OPCODE_BAD_CSUM;
>> +}
> [Severity: Low]
> This is the transport-side half of the same question: for a request with
> opcode 0x00 and seq_num 0x00, an all-zero read is declared final here, so
> rtpse_mcu_i2c_smbus_recv() / rtpse_mcu_i2c_native_recv() stop polling rather
> than retrying for the real frame. Should this helper also reject a frame that
> is entirely zero?

Covered by the fix not allowing seq_num to be 0.


Regards,
Jonas
