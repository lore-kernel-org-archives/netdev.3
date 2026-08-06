Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E443AB47E;
	Thu,  6 Aug 2026 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978674; cv=none; b=NhYCrhL9ydpoexyZhV9gkbW1U6aaULkoczg/jn9TN//Adq7qT2aqNp+V4aCf/g1LWiusRoFB2pNrRH/RqE2ZsW5A9nT3d7Pih7uGPPoSjBRrPc4PM4zIrwykVlLYb2I9kjXBRekESgFgbmY4tU95CIgaQXkdmHxi4S7H+o8fKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978674; c=relaxed/simple;
	bh=Wf1yw1hWjSMofGh9B//EgqznVrQjqhDsc8TpurI3z2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcBh/S7vDsgTx+ueZGGr8X+pjhgBhOs9FX4JPzzYgbOcbkyJeVB537e4hVsER+ao0TcCr8EtrrNjn3uTsL7+p1R3xERmXkBILDTKtpCHSAXYbs5347glXRRdGT7CXMO+jLw0z+1n07KwFo6aIdO+ISsYXYmeQAzqePeF/UCihTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNO6w4Au; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNO6w4Au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F741F00A3A;
	Thu,  6 Aug 2026 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978672;
	bh=qi/Ms2YIxVRuhPcVy9jiUsWczluue6n82mTxeGgXWcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNO6w4Auow/SjV2ZOp+nyYCqqeRUfF9kqUXJVzB4dyOw5VnOuH0x+qTb9/T7cBsc+
	 yBCDADtJohRnTU5UAxFyErOOBEno4Vg+2hvHDImCnNHHOy6k9ukUu5nP1HxWCmGfHi
	 Ejd8YUqAM7yK6sWyxUwRInBX4PesCrlhy0RPIvPOFgzV2eHLTwHgG7PZcl70+uefKN
	 9GziLps0C10zfiF/femEmreqm5ixvBuqw3uXvHz1RGu4HSvs+PjluIt+YgGYv911mU
	 FqpuuvoOjSYY7P1fDfVkgTYqlmxmR1ocwd4KFsyoWK/sJXLYUVj1NMKNs4s2/5tg6X
	 HKtQH/shV0ujQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jelonek.jonas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@makrotopia.org,
	bjorn@mork.no,
	sander@svanheule.net
Subject: Re: [PATCH net-next v11 2/4] net: pse-pd: add Realtek PSE MCU core
Date: Wed,  5 Aug 2026 18:11:10 -0700
Message-ID: <20260806011110.1855449-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802100114.720594-3-jelonek.jonas@gmail.com>
References: <20260802100114.720594-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: pse-pd: add Realtek PSE MCU core

This adds the shared core for the Realtek PSE MCU driver: the 12-byte
request/response protocol with sum-mod-256 checksum, the per-dialect opcode
tables and response parser hooks for the two protocol generations, and the
pse_controller_ops glue plus a registration helper for the transport modules.

> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-pd/realtek-pse-mcu-core.c
> new file mode 100644
> index 0000000000000..ed3b743470dbf
> --- /dev/null
> +++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
> @@ -0,0 +1,988 @@

[ ... ]

> +	/*
> +	 * Explicit MCU error opcodes (observed on the Gen1 dialect; harmless
> +	 * to check for Gen2 too). Catch these before the generic opcode/CRC
> +	 * mismatch path so callers see a meaningful errno.
> +	 */
> +	switch (resp->opcode) {
> +	case RTPSE_MCU_OPCODE_INCOMPLETE:
> +		return -EBADE;
> +	case RTPSE_MCU_OPCODE_BAD_CSUM:
> +		return -EBADMSG;
> +	case RTPSE_MCU_OPCODE_NOT_READY:
> +		return -EAGAIN;
> +	}
> +
> +	if (resp->opcode != req->opcode ||
> +	    resp->seq_num != req->seq_num ||
> +	    resp->checksum != rtpse_mcu_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
> +		return -EBADMSG;
> +
> +	return 0;
> +}

[Severity: Low]
Does this validation in rtpse_mcu_do_xfer() accept an all-zero frame as a
valid reply?

For a request with opcode 0x00 and seq_num 0x00, an all-zero 12-byte
response satisfies every term:

  resp->opcode  == 0 == req->opcode
  resp->seq_num == 0 == req->seq_num
  rtpse_mcu_checksum() over eleven 0x00 bytes == 0 == resp->checksum

Both dialects use 0x00 for a real command:

  rtpse_mcu_dialect_gen1: [RTPSE_MCU_CMD_PORT_ENABLE]      = RTPSE_MCU_OP(0x00)
  rtpse_mcu_dialect_gen2: [RTPSE_MCU_CMD_SET_GLOBAL_STATE] = RTPSE_MCU_OP(0x00)

and seq_num wraps back to 0x00 every 256 transactions since pse->seq is a u8
incremented unconditionally in rtpse_mcu_do_xfer():

  req->seq_num = pse->seq++;

Would it be worth adding a discriminator here, for instance rejecting a frame
whose bytes are all zero, or reserving seq_num 0?

> +static int rtpse_mcu_port_cmd(struct rtpse_mcu_ctrl *pse, unsigned int port, u8 opcode, u8 arg)
> +{
> +	struct rtpse_mcu_msg req, resp;
> +	int ret;
> +
> +	rtpse_mcu_msg_init(&req, opcode);
> +	req.payload[0] = port;
> +	req.payload[1] = arg;
> +
> +	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
> +	if (ret)
> +		return ret;
> +
> +	if (resp.payload[0] != port || resp.payload[1] != 0)
> +		return -EIO;
> +
> +	return 0;
> +}

[Severity: Low]
Related to the above: does this echo check catch the all-zero frame for port
0? An all-zero payload gives payload[0] == 0 == port and payload[1] == 0, so
a Gen1 port-0 enable/disable would be reported as successful even though the
frame carried no MCU data. rtpse_mcu_set_global_state() has the same shape,
it only requires resp.payload[0] == 0x0.

The same hole also shortens the poll in the I2C transport, since
rtpse_mcu_resp_is_final() declares an all-zero read final for opcode 0x00 /
seq_num 0x00 and the loop stops instead of waiting for the genuine reply.

[ ... ]

> +	/*
> +	 * Release the MCU from reset before the first transaction; the
> +	 * boot-retry loop in discover() waits for it to answer.
> +	 */
> +	gpiod = devm_gpiod_get_optional(pse->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(pse->dev, PTR_ERR(gpiod),
> +				     "failed to get reset gpio\n");
> +
> +	ret = rtpse_mcu_discover(pse, &info);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Some boards gate all ports through a hardware line; deassert it only
> +	 * once the MCU is confirmed present, so a failed probe leaves the ports
> +	 * gated. From here the MCU protocol governs per-port admin state.
> +	 */
> +	gpiod = devm_gpiod_get_optional(pse->dev, "disable-ports", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(pse->dev, PTR_ERR(gpiod),
> +				     "failed to get disable-ports gpio\n");

[Severity: Medium]
Does the comment's promise hold for failures after this point?

rtpse_mcu_register() drives disable-ports low here, but nothing re-asserts it
on the error paths that follow. The devres unwind only releases the
descriptor; gpiod_free_commit() in drivers/gpio/gpiolib.c clears descriptor
flags, drops the label and optionally calls gc->free(), it does not change the
driven output level:

  if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
          if (guard.gc->free)
                  guard.gc->free(guard.gc, gpiod_hwgpio(desc));
          clear_bit(GPIOD_FLAG_ACTIVE_LOW, &flags);

So if devm_add_action_or_reset() or devm_pse_controller_register() below fails
(the latter propagates -EINVAL/-ENODEV from of_load_pse_pis() for a
missing or mismatched pse-pis node, and -ENOMEM from the kfifo/devres
allocations), the board is left with all ports ungated and no driver bound.
The same applies on unbind or module unload.

Since the level also persists past the descriptor's lifetime, doesn't a
subsequent probe attempt start with the gate already open? That is exactly the
case the comment guards against: if rtpse_mcu_discover() then fails on a
re-probe, the ports are ungated while the MCU is unresponsive and unmanaged.

Would a devm action that re-asserts the line (and the reset line) fit here?

> +	if (!info.system_enable) {
> +		ret = rtpse_mcu_set_global_state(pse, true);
> +		/* Dialects without a global-state concept (e.g. Gen1) return
> +		 * -EOPNOTSUPP; treat that as "no separate enable required".
> +		 */
> +		if (ret && ret != -EOPNOTSUPP)
> +			return dev_err_probe(pse->dev, ret,
> +					     "failed to enable PSE system\n");
> +		if (!ret) {
> +			ret = devm_add_action_or_reset(pse->dev,
> +						       rtpse_mcu_global_disable, pse);
> +			if (ret)
> +				return ret;
> +		}
> +	}

[Severity: Medium]
Is there any compensating teardown for the Gen1 case? rtpse_mcu_dialect_gen1
has no RTPSE_MCU_CMD_SET_GLOBAL_STATE entry, so
rtpse_mcu_set_global_state() returns -EOPNOTSUPP and no devm action is
registered at all. The same happens on boards that already report
info.system_enable, where the whole block is skipped. For those boards
nothing disables power or re-gates the ports on a later probe failure or on
unbind.

[ ... ]

> diff --git a/drivers/net/pse-pd/realtek-pse-mcu.h b/drivers/net/pse-pd/realtek-pse-mcu.h
> new file mode 100644
> index 0000000000000..52f9442d7117c
> --- /dev/null
> +++ b/drivers/net/pse-pd/realtek-pse-mcu.h
> @@ -0,0 +1,93 @@

[ ... ]

> +/*
> + * A polling transport can stop here: the reply to this request (opcode and
> + * seq_num), or a terminal error. The seq_num rejects a stale reply left by an
> + * abandoned transaction, instead of desyncing by one frame.
> + */
> +static inline bool rtpse_mcu_resp_is_final(const struct rtpse_mcu_msg *req,
> +					   const struct rtpse_mcu_msg *resp)
> +{
> +	return (resp->opcode == req->opcode && resp->seq_num == req->seq_num) ||
> +	       resp->opcode == RTPSE_MCU_OPCODE_INCOMPLETE ||
> +	       resp->opcode == RTPSE_MCU_OPCODE_BAD_CSUM;
> +}

[Severity: Low]
This is the transport-side half of the same question: for a request with
opcode 0x00 and seq_num 0x00, an all-zero read is declared final here, so
rtpse_mcu_i2c_smbus_recv() / rtpse_mcu_i2c_native_recv() stop polling rather
than retrying for the real frame. Should this helper also reject a frame that
is entirely zero?
