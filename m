Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306AE3ADB8D;
	Thu,  6 Aug 2026 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978675; cv=none; b=jtTbfMMRQyeOxxgJx3ancg/3lsHb552ghw0fe5OxqkHOHE8OMzfE6/l+clct8+0ZN+T26hQc+6NzPT4RFtCc/DoJcB3SwaZlviucLBXbiuE4f7purWmjMfDNyCcGOdRUm4Jnj3WBryocm+ijaKfjUhP3YgRgRgZFMck9decKjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978675; c=relaxed/simple;
	bh=WcFWC+2xZp1HWe7xL+ytlY3vrwrn1vucMosVgSn1MDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibLvxJi2IMZyWU89qmAYTEwhhlm2DG8H8wMi5Un8TDy7gD/N33vdEQxdXuCg2Ps67Vot5vFwaa6apCz08T4MycrNk0U0X8M43lD3JTbT1Cda119Kgigh5/Vu+cL5a+byffDC6uaoZUN/tgWOmDjh/WkiDEw7BrsyKB44cT94x9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9D6U3H5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9D6U3H5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD011F000E9;
	Thu,  6 Aug 2026 01:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978673;
	bh=dGtdH5CJ8Wb8ZKt9aPoVOvjd1I6TqJYcKa/hisn+e6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A9D6U3H5paBs+TI9Jzet6xbQ6Ir4Vrpj50qKUaD4PVaYvWSrwcpzSyDRS3hB1F0nE
	 IqStq6xwGafWlA7IHKE91denxpCux6//obCMyr0CmplUeCUFPWOcgTtQFFXwSQ3n4l
	 owyt6F0G9ukNie1trpUrIB1fXc+mnQ3QUTcTRVKgLi5WfwDiXaHqxhT/+TqhI0O0CZ
	 F5cnmDURGV38hx2Gsg7IHe4na6jyy1azATu349xPmIKmc4WxuESMo6NCwlZhkxBPK3
	 qsJ2ykqhYwZGX95xNYdDdm2NaC/slpKZ8FJ9G39rika+JVdfVzrXs47TDBLGtrsTbv
	 GWgwSBDlpUxzQ==
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
Subject: Re: [PATCH net-next v11 3/4] net: pse-pd: realtek-pse-mcu: add I2C transport
Date: Wed,  5 Aug 2026 18:11:12 -0700
Message-ID: <20260806011112.1855541-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802100114.720594-4-jelonek.jonas@gmail.com>
References: <20260802100114.720594-4-jelonek.jonas@gmail.com>
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
net: pse-pd: realtek-pse-mcu: add I2C transport

This adds the I2C/SMBus transport for the Realtek PSE MCU core, providing
the send/recv callbacks used to exchange the 12-byte MCU frames. Two
framings are supported and selected by the compatible: SMBus block
transfers by default, and raw I2C when the match data sets native_i2c.

> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-i2c.c b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
> new file mode 100644
> index 0000000000000..e10f8c633b68e
> --- /dev/null
> +++ b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
> @@ -0,0 +1,170 @@

[ ... ]

> +static int rtpse_mcu_i2c_smbus_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
> +{
> +	struct i2c_client *client = to_i2c_client(pse->dev);
> +
> +	/* Send opcode as SMBus command byte; remaining 11 bytes as block data */
> +	return i2c_smbus_write_i2c_block_data(client, req->opcode, RTPSE_MCU_MSG_SIZE - 1,
> +					      (u8 *)req + 1);
> +}
> +
> +static int rtpse_mcu_i2c_smbus_recv(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
> +				    struct rtpse_mcu_msg *resp)
> +{
> +	struct i2c_client *client = to_i2c_client(pse->dev);
> +	int tries, ret;
> +
> +	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
> +		if (tries > 0)
> +			msleep(RTPSE_MCU_I2C_RETRY_MS);
> +
> +		/* MCU needs 0x00 as command byte for read */
> +		ret = i2c_smbus_read_i2c_block_data(client, 0x00,
> +						    RTPSE_MCU_MSG_SIZE,
> +						    (u8 *)resp);

[ ... ]

> +static int rtpse_mcu_i2c_native_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
> +{
> +	struct i2c_client *client = to_i2c_client(pse->dev);
> +	void *buf;
> +	int ret;
> +
> +	/* i2c_master_send() may DMA, so the buffer must not be on the stack. */
> +	buf = kmemdup(req, RTPSE_MCU_MSG_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = i2c_master_send(client, buf, RTPSE_MCU_MSG_SIZE);
> +	kfree(buf);

[Severity: Low]
Is the premise in this comment correct?  i2c_master_send() and
i2c_master_recv() both go through i2c_transfer_buffer_flags(), which
builds the message as:

drivers/i2c/i2c-core-base.c:i2c_transfer_buffer_flags() {
	struct i2c_msg msg = {
		.addr = client->addr,
		.flags = flags | (client->flags & I2C_M_TEN),
		.len = count,
		.buf = buf,
	};
	...
}

I2C_M_DMA_SAFE is never set there, so an adapter that wants to DMA has to
obtain its buffer from i2c_get_dma_safe_msg_buf(), which bounces again
exactly because the flag is absent:

drivers/i2c/i2c-core-base.c:i2c_get_dma_safe_msg_buf() {
	...
	if (msg->flags & I2C_M_DMA_SAFE)
		return msg->buf;
	...
	if (msg->flags & I2C_M_RD)
		return kzalloc(msg->len, GFP_KERNEL);
	else
		return kmemdup(msg->buf, msg->len, GFP_KERNEL);
}

So does the kmemdup() here actually achieve anything?  On a DMA-capable
adapter the 12-byte frame is copied a second time by the core, and the
core's on-stack struct rtpse_mcu_msg was already legal for these APIs
(Documentation/i2c/dma-considerations.rst: "it is *not* mandatory that the
buffer of an I2C message is DMA safe").

The SMBus path in the same file already passes the caller-supplied stack
req/resp straight into i2c_smbus_write_i2c_block_data() and
i2c_smbus_read_i2c_block_data(), which seems to contradict the rationale
used for the raw-I2C path.

The same question applies to rtpse_mcu_i2c_native_recv() below, where the
kmalloc() plus the memcpy(resp, buf, RTPSE_MCU_MSG_SIZE) duplicate what
i2c_get_dma_safe_msg_buf()/i2c_put_dma_safe_msg_buf() already do for a
non-DMA-safe read buffer.  It also adds an -ENOMEM abort to a PSE control
transaction that the bus core could otherwise always complete.

If skipping the core's bounce is really the goal, should these buffers be
handed to i2c_master_send_dmasafe()/i2c_master_recv_dmasafe(), or to an
explicit i2c_msg with I2C_M_DMA_SAFE?  Otherwise, could the allocations
and both comments simply be dropped?

The commit message carries the same statement:

  "Because i2c_master_send()/i2c_master_recv() may DMA, the raw-I2C path
  bounces each frame through a heap buffer rather than the core's stack
  buffers; the SMBus path is unaffected."

Could this be reworded so it does not document a DMA rule that the I2C
core does not impose?

> +	if (ret < 0)
> +		return ret;
> +	return ret == RTPSE_MCU_MSG_SIZE ? 0 : -EIO;
> +}
> +
> +static int rtpse_mcu_i2c_native_recv(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
> +				     struct rtpse_mcu_msg *resp)
> +{
> +	struct i2c_client *client = to_i2c_client(pse->dev);
> +	int tries, ret;
> +	u8 *buf;
> +
> +	/* i2c_master_recv() may DMA, so read into an off-stack buffer. */
> +	buf = kmalloc(RTPSE_MCU_MSG_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
> +		if (tries > 0)
> +			msleep(RTPSE_MCU_I2C_RETRY_MS);
> +
> +		ret = i2c_master_recv(client, buf, RTPSE_MCU_MSG_SIZE);
> +		if (ret < 0)
> +			goto out;
> +		if (ret == RTPSE_MCU_MSG_SIZE) {
> +			memcpy(resp, buf, RTPSE_MCU_MSG_SIZE);

[ ... ]
