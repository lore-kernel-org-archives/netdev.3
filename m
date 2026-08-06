Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EF3B101D;
	Thu,  6 Aug 2026 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978676; cv=none; b=Mn4PPc12ttA458TihWZxjPYL+kLFH4nvV2uD56mfOmLnMSPKSqxeOh4WOgVaXzdpARBpLJh7/Fb5/6TMFEI85Xua+GKH7CTdGsD1TuhmuVdx7zTgwv6JvorP0ceuaMtf6ZzWEbjH/o9An6YwvDkBp/wgy8L2trwdhGvhmnC1OPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978676; c=relaxed/simple;
	bh=oRV13ajJMybdu1gFOPJqV+43C361lx0ENCeC4lK+y+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzcsoIFjOwBDOoLC6XlzLTlo6Q2Hu6RplGPeecNI5UPYFh6JY3dm/zatSlxZ2PkEJJxj5vMuIwKe/Z8uLmzuumh7dJuZHXwjMwXK6ujGJxr/nVYF24Few68BmNjbUV6BmOV0oKMsYxLLFAZjId46UtR+O4ssnZwTFPV/0R3/2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IguMuiAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IguMuiAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF6F1F00A3A;
	Thu,  6 Aug 2026 01:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978675;
	bh=ebcYUBcFLfg9nDkh4dHoaZmcNdoWLmFjyaOtz0zXD5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IguMuiAyhG8IOo2R/UFDnVXjFj3LrMcZa6RltFLpoo9I07bW5WaR03yFHvgmxhZPz
	 ByMr5REITTXklZRgE2UyVWJPOc6s1cyr3oDl8iyS4lSOTOBdNAhok0kpPdau4RoTLl
	 +htpcSkc6k8iMO3dvkrTRdsPckRdCTVB8AKJsn+KMnfFvpUCE81NpYHdQCGuCoNjwV
	 8sNrxDLsuJ9//q9aiLOZH2hIkel31yw/QK4Rp5br22AneRmog6j+nXj+nFAxJn/Fkj
	 F8RR+4bvgrdqxJIpjZ4VHQC+ke1q5t+xMEHRD/qLqfYEPRkR9hCSRhP/zbQTaCLjO2
	 vZzd0xXcuCyIw==
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
Subject: Re: [PATCH net-next v11 4/4] net: pse-pd: realtek-pse-mcu: add UART transport
Date: Wed,  5 Aug 2026 18:11:13 -0700
Message-ID: <20260806011113.1855680-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802100114.720594-5-jelonek.jonas@gmail.com>
References: <20260802100114.720594-5-jelonek.jonas@gmail.com>
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
net: pse-pd: realtek-pse-mcu: add UART transport

This adds a serdev (UART) transport for the Realtek PSE MCU core, with
send/recv callbacks that exchange the 12-byte frames and an asynchronous
receive_buf callback. The baud rate defaults to 19200 and can be overridden
with the "current-speed" property.

> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-uart.c b/drivers/net/pse-pd/realtek-pse-mcu-uart.c
> new file mode 100644
> index 0000000000000..9baa17d8d31fa
> --- /dev/null
> +++ b/drivers/net/pse-pd/realtek-pse-mcu-uart.c
> @@ -0,0 +1,164 @@

[ ... ]

> +/*
> + * No framing is done here: a glitched frame costs one transaction, then
> + * the next _send re-frames from rx_len 0. Resync works by returning count
> + * (not take), dropping any overflow so serdev keeps no leftover to bleed
> + * into the next frame.
> + */
> +static size_t rtpse_mcu_uart_receive(struct serdev_device *serdev,
> +				     const u8 *buf, size_t count)
> +{
> +	struct rtpse_mcu_uart *ctx = serdev_device_get_drvdata(serdev);
> +	size_t take;
> +
> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
> +		take = min(count, sizeof(ctx->rx_buf) - ctx->rx_len);
> +		if (take) {
> +			memcpy(ctx->rx_buf + ctx->rx_len, buf, take);
> +			ctx->rx_len += take;
> +			if (ctx->rx_len == sizeof(ctx->rx_buf))
> +				complete(&ctx->rx_done);
> +		}
> +	}
> +
> +	/* consume all to avoid desync/misalignment */
> +	return count;
> +}

[ ... ]

> +static int rtpse_mcu_uart_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
> +{
> +	struct rtpse_mcu_uart *ctx = to_rtpse_mcu_uart(pse);
> +	int written;
> +
> +	/* clear any leftover rx state before transmitting */
> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
> +		reinit_completion(&ctx->rx_done);
> +		ctx->rx_len = 0;
> +	}

[ ... ]

> +static int rtpse_mcu_uart_recv(struct rtpse_mcu_ctrl *pse,
> +			       const struct rtpse_mcu_msg *req,
> +			       struct rtpse_mcu_msg *resp)
> +{
> +	struct rtpse_mcu_uart *ctx = to_rtpse_mcu_uart(pse);
> +
> +	if (!wait_for_completion_timeout(&ctx->rx_done, RTPSE_MCU_UART_RX_TIMEOUT))
> +		return -ETIMEDOUT;
> +
> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
> +		if (ctx->rx_len != sizeof(*resp))
> +			return -EIO;
> +
> +		memcpy(resp, ctx->rx_buf, sizeof(*resp));
> +	}
> +	return 0;
> +}

[Severity: Medium]
Should rtpse_mcu_uart_recv() apply rtpse_mcu_resp_is_final() before
accepting a frame?  The req argument is unused here, so the first complete
12-byte frame becomes the transaction result no matter what it contains.

realtek-pse-mcu.h describes one of those frames as transient:

  /*
   * MCU status opcodes (seen on the Gen1 dialect; Gen2 never emits them).
   * INCOMPLETE/BAD_CSUM are terminal; NOT_READY is transient.
   */
  #define RTPSE_MCU_OPCODE_NOT_READY		0xff	/* -EAGAIN  */

and the I2C transport keeps polling until the acceptance predicate holds,
so a NOT_READY frame never escapes the transaction:

  drivers/net/pse-pd/realtek-pse-mcu-i2c.c:rtpse_mcu_i2c_smbus_recv() {
	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
		...
		if (ret == RTPSE_MCU_MSG_SIZE && rtpse_mcu_resp_is_final(req, resp))
			return 0;
	}
	return -ETIMEDOUT;
  }

With the UART transport, a NOT_READY frame is copied into resp and
rtpse_mcu_do_xfer() turns it into an error for the caller:

  drivers/net/pse-pd/realtek-pse-mcu-core.c:rtpse_mcu_do_xfer() {
	case RTPSE_MCU_OPCODE_NOT_READY:
		return -EAGAIN;
  }

Is any runtime caller prepared for that?  The only place -EAGAIN is retried
is the probe-time boot loop in rtpse_mcu_discover(); the pse_controller_ops
paths propagate it, so an ethtool PSE get/set would fail.

Note that "realtek,pse-mcu-gen1" is in rtpse_mcu_uart_of_match[], which is
the dialect documented as emitting these status opcodes.

Can the real reply also be lost in that case?  Once rx_len is 12 the
receive callback computes take == 0 and drops the following bytes; if they
instead arrive after the next rtpse_mcu_uart_send() has reset rx_len to 0
(the core only sleeps RTPSE_MCU_RESPONSE_MS = 25 ms between send and recv),
they are consumed as the next transaction's response and rejected by:

  if (resp->opcode != req->opcode ||
      resp->seq_num != req->seq_num ||
      resp->checksum != rtpse_mcu_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
	return -EBADMSG;

failing a second consecutive operation.

Would it make sense to loop on wait_for_completion_timeout() against a
remaining-time budget until rtpse_mcu_resp_is_final(req, resp) holds?  As
written only the first frame is waited for, leaving most of the
RTPSE_MCU_RESPONSE_MAX_MS (1000 ms) receive budget unused.
