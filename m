Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B33E717A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004948; cv=none; b=oEAHcYqdsIQwcRNEIJ6BLV1csdzsz+JVu2AI3iUrR8iSSfzt4fBezbPpAJ46OM2RBoJ4cO7Gck1NYAJqfoFLTKW6LjFVTPdhCCfhbOaQLJgWGJ3BDSi/1vTEfZrgNmOQbzkYZuWYHYya96yOZ+raNogqn4LEQtZadFmoI4JyZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004948; c=relaxed/simple;
	bh=QvfRtk7iTMkzOtjozh8twBiWiHdPU8W709dyQm0V1rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDFTElMmvUmyJWe8iFRa4CrZkrT7HmCr5XX5p6Y4xsJr8MlJO+dC/fuS7HMGbVFTsN/x9WPYgW87NxCVWZauN7JCnSBFNWF+thco6DE3s+kEcDjCWkR7sQSmOHJJphWSgFmZs0ha/3fDw5vP1vV0FcZS3FyEoW/BJR1Z5G68n48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvp6kWpm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvp6kWpm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954aff6088so19042675e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786004945; x=1786609745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oNzdd3ks5EfcRNkKIAlrqhz+l0zWLMF0+Ux/V0Mjszc=;
        b=Nvp6kWpmbXafhcF8hJHCJOrXDGTIsF2L/Luf4nQ6lyfAxEXbu6n3Sxa3D4GuedDAK5
         UdEEtq8AtxpRuM2Ow5otdeEfY3bIxI3hU7awo/88e7VW3S7Ircon6RzGrAzefCXIenZj
         UxmuTBE9T/Eh4i5wGDYI5NkVYALX1UCkTozdY6iSRwjNcq6wGJ55X+ZH4RGbjG5EtuD6
         nfSP9NUhL/a/rbOFLIjb9A6W9KvA4q6rzR9HvRM/u5V5yzyemE5YjlzeECvnZsetH83l
         zzag8GTW6GepxnQc3BildiyzU3GOYacb3jetNdWavpLbSGKnwMBJk/R1ag3FUKmD+Cch
         +vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004945; x=1786609745;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNzdd3ks5EfcRNkKIAlrqhz+l0zWLMF0+Ux/V0Mjszc=;
        b=Rcl1/DQjK66c9uvmXhFdUQF4kaeblKLApw8494hdSbUf+76y8Hzty4c50nKZKjNqnZ
         tb7YE5EMzgG0vk3SplZevJqx3omaLPVSUupSKW2WJz6wR4QBZVzkIwKrs3NeYk47TMzd
         rRB60MWMMAFJeobucKZ+mg1eIMI9sgKmNL+w7xVVnbVxNNRCD68Jeo3yhWqv5jmvjRDm
         PhnMFT+r3uQz4H9xI+Jr4b8fqwgfz57ZyGow/A0KBSIs5sC4ZEguiQ/CMMMLxpsiNybL
         VhaJBQh/VVj83roMKWrK5c6vPOI8yNzyQBVBzXF7RANgnOeqg/qu7mV0aT3D7vRILODu
         5SEA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr01Au+5Y2JJf0nqw9YUmVyuDQn8/iN5RWrhHH+gEjDXFcBsjjy+YxXq1yMOrSDGt7AulHXZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0n+7UXbDJ7Ym04zOxcLXlSl+tjlhnR3iHAC7dYDb5Ybgs/fDj
	ivPaLSgcMC/Y6ruq7mt3kbN8YCpUilVqvQjwxWXKG+wu9JgQIFoZqD3z
X-Gm-Gg: AR+sD127y7qbzGM0to+HHbPJJy7ObmKMbbV6kZUXD9Y9iQeNW0bxCjn3mWuVRie3f9r
	CpaNPkxyaYw19KAhFJ5oUwQnl3xwJ0qyWvr/o1ksgr0jUpIMk4gda9hWdDYeMyTo1bcUUn0tWK/
	I6QIovZM4r0I6K3TYZXZWZvGKI/TrX2jfTwxNtvnrI4FHe8Fb6dmiOSJkUsa8prc9b/rFP83MKH
	h/SEkCeP5U3XSfcwaEYBdMOFKrgMRA2qGV6QaYI/ZWyai2BPIZ325CEyQo9RsEC4cstW6k88KW3
	7vCP8MPv3AYqf8+kf/ROZfhe9rDl63tI9uoWxB4MZmk9XBwH7oA0W9SxTQSoNSVTOnQJDeociYE
	JFQvDwdzHq3ZazlnonlZDBD16/NzJOD2nZipQeDIaSt6aRHjmSAS8owHxSuxnll0vO+e3cMxB6R
	ytSPjj9eXvIVMPfW7NyL5i3cAI8NxQFKD3PPyyJ7sBhU32nhhwQAKQ5CQd6hkK4cKynsj+5QH7v
	MMCTf+H55tvMiXzbd0J5IXtIBD+1E+kZwmcrKAtF+pHxGiv45GIcokBT0l3XvvTF0zHRo4SDcM=
X-Received: by 2002:a05:600c:4f4d:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4994e7cb0e8mr172103335e9.14.1786004944521;
        Thu, 06 Aug 2026 01:29:04 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f131:1d01:8da1:260c:d732:9394? ([2001:9e8:f131:1d01:8da1:260c:d732:9394])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421fee8sm40915395e9.7.2026.08.06.01.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:29:04 -0700 (PDT)
Message-ID: <f7c3c062-94f9-40d8-8b20-9f03af79456e@gmail.com>
Date: Thu, 6 Aug 2026 10:29:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/4] net: pse-pd: realtek-pse-mcu: add I2C
 transport
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net
References: <20260802100114.720594-4-jelonek.jonas@gmail.com>
 <20260806011112.1855541-1-kuba@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260806011112.1855541-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.08.26 03:11, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: pse-pd: realtek-pse-mcu: add I2C transport
>
> This adds the I2C/SMBus transport for the Realtek PSE MCU core, providing
> the send/recv callbacks used to exchange the 12-byte MCU frames. Two
> framings are supported and selected by the compatible: SMBus block
> transfers by default, and raw I2C when the match data sets native_i2c.
>
>> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-i2c.c b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
>> new file mode 100644
>> index 0000000000000..e10f8c633b68e
>> --- /dev/null
>> +++ b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
>> @@ -0,0 +1,170 @@
> [ ... ]
>
>> +static int rtpse_mcu_i2c_smbus_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
>> +{
>> +	struct i2c_client *client = to_i2c_client(pse->dev);
>> +
>> +	/* Send opcode as SMBus command byte; remaining 11 bytes as block data */
>> +	return i2c_smbus_write_i2c_block_data(client, req->opcode, RTPSE_MCU_MSG_SIZE - 1,
>> +					      (u8 *)req + 1);
>> +}
>> +
>> +static int rtpse_mcu_i2c_smbus_recv(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
>> +				    struct rtpse_mcu_msg *resp)
>> +{
>> +	struct i2c_client *client = to_i2c_client(pse->dev);
>> +	int tries, ret;
>> +
>> +	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
>> +		if (tries > 0)
>> +			msleep(RTPSE_MCU_I2C_RETRY_MS);
>> +
>> +		/* MCU needs 0x00 as command byte for read */
>> +		ret = i2c_smbus_read_i2c_block_data(client, 0x00,
>> +						    RTPSE_MCU_MSG_SIZE,
>> +						    (u8 *)resp);
> [ ... ]
>
>> +static int rtpse_mcu_i2c_native_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
>> +{
>> +	struct i2c_client *client = to_i2c_client(pse->dev);
>> +	void *buf;
>> +	int ret;
>> +
>> +	/* i2c_master_send() may DMA, so the buffer must not be on the stack. */
>> +	buf = kmemdup(req, RTPSE_MCU_MSG_SIZE, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	ret = i2c_master_send(client, buf, RTPSE_MCU_MSG_SIZE);
>> +	kfree(buf);
> [Severity: Low]
> Is the premise in this comment correct?  i2c_master_send() and
> i2c_master_recv() both go through i2c_transfer_buffer_flags(), which
> builds the message as:
>
> drivers/i2c/i2c-core-base.c:i2c_transfer_buffer_flags() {
> 	struct i2c_msg msg = {
> 		.addr = client->addr,
> 		.flags = flags | (client->flags & I2C_M_TEN),
> 		.len = count,
> 		.buf = buf,
> 	};
> 	...
> }
>
> I2C_M_DMA_SAFE is never set there, so an adapter that wants to DMA has to
> obtain its buffer from i2c_get_dma_safe_msg_buf(), which bounces again
> exactly because the flag is absent:
>
> drivers/i2c/i2c-core-base.c:i2c_get_dma_safe_msg_buf() {
> 	...
> 	if (msg->flags & I2C_M_DMA_SAFE)
> 		return msg->buf;
> 	...
> 	if (msg->flags & I2C_M_RD)
> 		return kzalloc(msg->len, GFP_KERNEL);
> 	else
> 		return kmemdup(msg->buf, msg->len, GFP_KERNEL);
> }
>
> So does the kmemdup() here actually achieve anything?  On a DMA-capable
> adapter the 12-byte frame is copied a second time by the core, and the
> core's on-stack struct rtpse_mcu_msg was already legal for these APIs
> (Documentation/i2c/dma-considerations.rst: "it is *not* mandatory that the
> buffer of an I2C message is DMA safe").
>
> The SMBus path in the same file already passes the caller-supplied stack
> req/resp straight into i2c_smbus_write_i2c_block_data() and
> i2c_smbus_read_i2c_block_data(), which seems to contradict the rationale
> used for the raw-I2C path.
>
> The same question applies to rtpse_mcu_i2c_native_recv() below, where the
> kmalloc() plus the memcpy(resp, buf, RTPSE_MCU_MSG_SIZE) duplicate what
> i2c_get_dma_safe_msg_buf()/i2c_put_dma_safe_msg_buf() already do for a
> non-DMA-safe read buffer.  It also adds an -ENOMEM abort to a PSE control
> transaction that the bus core could otherwise always complete.
>
> If skipping the core's bounce is really the goal, should these buffers be
> handed to i2c_master_send_dmasafe()/i2c_master_recv_dmasafe(), or to an
> explicit i2c_msg with I2C_M_DMA_SAFE?  Otherwise, could the allocations
> and both comments simply be dropped?
>
> The commit message carries the same statement:
>
>   "Because i2c_master_send()/i2c_master_recv() may DMA, the raw-I2C path
>   bounces each frame through a heap buffer rather than the core's stack
>   buffers; the SMBus path is unaffected."
>
> Could this be reworded so it does not document a DMA rule that the I2C
> core does not impose?

I'll drop the DMA stuff again, apparently the other AI bot suggesting this
fooled me.

>> +	if (ret < 0)
>> +		return ret;
>> +	return ret == RTPSE_MCU_MSG_SIZE ? 0 : -EIO;
>> +}
>> +
>> +static int rtpse_mcu_i2c_native_recv(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
>> +				     struct rtpse_mcu_msg *resp)
>> +{
>> +	struct i2c_client *client = to_i2c_client(pse->dev);
>> +	int tries, ret;
>> +	u8 *buf;
>> +
>> +	/* i2c_master_recv() may DMA, so read into an off-stack buffer. */
>> +	buf = kmalloc(RTPSE_MCU_MSG_SIZE, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
>> +		if (tries > 0)
>> +			msleep(RTPSE_MCU_I2C_RETRY_MS);
>> +
>> +		ret = i2c_master_recv(client, buf, RTPSE_MCU_MSG_SIZE);
>> +		if (ret < 0)
>> +			goto out;
>> +		if (ret == RTPSE_MCU_MSG_SIZE) {
>> +			memcpy(resp, buf, RTPSE_MCU_MSG_SIZE);
> [ ... ]


Regards,
Jonas
