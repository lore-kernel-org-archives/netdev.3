Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786583;
	b=i1Mq+9um04WrlEIsenu2sfazFCIv3vjfIxyqOX+aSbg3xpIB2Ai3DQJnYG3H8/VlPMf5
	 Q2VPLUxY/nJbfsxJoyG9rnei0JFEN6BuDlEBtVzZsaR3nNqq0KbL+x4IcmJRiwZxS0UBW
	 yS70cG4QDm+0/zNgiM2iWhspuh/vyWLvRqFyp0nTI8jIgKgYwd5BnvuUXppqfjTU8eoaa
	 SHySA8DRLkcqdDz7yk1arW12FA5aTDa3DTzPT3QWNI78rc4q/f9m7CkoIcPkwtMNi9WtW
	 XTjIEyYbJ3MKVeLHG5TcjjjJ1Wl5D0BH6dC991TufAezXGRukT7evv1qt36075f5kXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786583;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=4CtePqmfE3IlljY9sCYmE7WsQB53bpyDId8jwWKXqo0=;
	b=qjxcVuFa2l7+aBH1tg4kf5qmVKM1hz/suyDHYriseoIT0Ajv769E/pHgzvzcm5bII8WU
	 xiByuWmFdWFurPWDcUJd/PcPD+gzdIeGqHHiI3Uly+PxvZU0Re2vCkGOZyFbpyDv1eadT
	 vKZdUWO/iS5W5iipv2u85DC5rDQjQdvi3Gni9RTGPAG4kXDkxwpGEF6UMKpic56hjO3Ny
	 k6Y3xV7LSpK4c9X5Nb5cFR++vTLccpZz5zL+mID8kXtH/YBzUgWhGkvF9EIBO8YqzHLdz
	 afBFh9tGkjVmBrT4jV9Ja+Be0NN23E3RPMyKOuR5ziwznwtVoNMhGmp1nSi1RQd1ExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mO8a8Fbh;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15A606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 10:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE15A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mO8a8Fbh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 11A1CC8F46C;
	Wed,  4 Nov 2026 10:04:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A11960770;
	Wed,  4 Nov 2026 10:03:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E78AD103291CE;
	Wed,  4 Nov 2026 11:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4CtePqmfE3IlljY9sCYmE7WsQB53bpyDId8jwWKXqo0=;
	b=mO8a8FbhChgY9+A9MFsGx1oFfSUYuboW3QbtxaqRpk4jxCModb687LEwITwPTEcQbBKlBi
	iNATC9wLlool7m2Mr7aPn2MV3Iut4K5krpaQ0Erj3dGLT2VGCoXNcCJnmah06l5T79GVWk
	7yer7VHIqORa4stCfEBgAZ9ZiWAv8Tdc8nUq3rbbt5OLsWiz271TwVGkB4Bse6F03+1Llm
	Tmv1VIqn6Na/4hrlKky21PjHNguuzvRgMCtEyxxHIiP4rj0sg6ykJ+Pc+KifQ/SJunNNs1
	NS82kUmoR3tPG1fH6t3GemNwJ3azIRseearlxFadmu0rVutJU3aFXGz8VofH4g==
Message-ID: <c0af13a8-5ea6-47d3-9c6c-2935f8cd8ce0@bootlin.com>
Date: Wed, 4 Nov 2026 11:02:50 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next 1/4] net: pse-pd: realtek-pse-mcu: ensure MCU
 does dynamic power management
To: Jonas Jelonek <jonas@jonasjelonek.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Sander Vanheule <sander@svanheule.net>,
 Russell Senior <russell@personaltelco.net>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
 <20261103220312.860629-2-jonas@jonasjelonek.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261103220312.860629-2-jonas@jonasjelonek.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/3/26 23:03, Jonas Jelonek wrote:
> From: Russell Senior <russell@personaltelco.net>
> 
> The MCU may have any power management mode configuration by default
> but the driver should ensure that the MCU performs dynamic power
> management with priorities as advertised. On certain devices, the
> default MCU configuration ships with another default, possibly
> preventing any power delivery.
> 
> Select the mode before deasserting the hardware port gate, so a failure
> to establish the management policy does not ungate the ports.
> 
> Signed-off-by: Russell Senior <russell@personaltelco.net>
> [jonas@jonasjelonek.de: adjust commit message, macro naming and comment;
>   change error handling and select the mode before ungating ports]
> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
> ---
>   drivers/net/pse-pd/realtek-pse-mcu-core.c | 32 +++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-pd/realtek-pse-mcu-core.c
> index c70b09ca2012..f3fc67fe29d3 100644
> --- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
> +++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
> @@ -68,10 +68,14 @@
>   /* Nominal PSE rail; 802.3at/bt operating range. */
>   #define RTPSE_MCU_PSE_VOLTAGE_UV		54000000
>   
> +/* RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE values */
> +#define RTPSE_MCU_POWER_MGMT_DYNAMIC_PRIO	0x02	/* dynamic, with port priority */
> +
>   enum rtpse_mcu_cmd {
>   	RTPSE_MCU_CMD_SET_GLOBAL_STATE,
>   	RTPSE_MCU_CMD_GET_SYSTEM_INFO,
>   	RTPSE_MCU_CMD_GET_EXT_CONFIG,
> +	RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE,
>   
>   	RTPSE_MCU_CMD_PORT_ENABLE,
>   	RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE,
> @@ -369,6 +373,26 @@ static int rtpse_mcu_set_global_state(struct rtpse_mcu_ctrl *pse, bool enable)
>   	return (resp.payload[0] == 0x0) ? 0 : -EIO;
>   }
>   
> +static int rtpse_mcu_set_power_management_mode(struct rtpse_mcu_ctrl *pse, u8 value)
> +{
> +	struct rtpse_mcu_msg req, resp;
> +	const struct rtpse_mcu_opcode *opc;
> +	int ret;
> +
> +	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE];
> +	if (!opc->valid)
> +		return -EOPNOTSUPP;
> +
> +	rtpse_mcu_msg_init(&req, opc->op);
> +	req.payload[0] = value;
> +
> +	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
> +	if (ret)
> +		return ret;
> +
> +	return (resp.payload[0] == 0x0) ? 0 : -EIO;
> +}
> +
>   /* Port operations */
>   
>   static int rtpse_mcu_port_get_status(struct rtpse_mcu_ctrl *pse, unsigned int port,
> @@ -826,6 +850,12 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
>   	if (ret)
>   		return ret;
>   
> +	/* ensure the MCU does dynamic power management with priorities */
> +	ret = rtpse_mcu_set_power_management_mode(pse, RTPSE_MCU_POWER_MGMT_DYNAMIC_PRIO);

Why do you pass RTPSE_MCU_POWER_MGMT_DYNAMIC_PRIO as parameter?
You are calling this function only once in the whole series so you can 
directly use it in the function.

pw-bot: cr

> +	if (ret)
> +		return dev_err_probe(pse->dev, ret,
> +				     "failed to set power management mode\n");
> +
>   	/*
>   	 * Some boards gate all ports through a hardware line; deassert it only
>   	 * after the MCU is confirmed, so a discover failure never ungates the
> @@ -944,6 +974,7 @@ static const struct rtpse_mcu_dialect rtpse_mcu_dialect_gen2 = {
>   		[RTPSE_MCU_CMD_SET_GLOBAL_STATE]	= RTPSE_MCU_OP(0x00),
>   		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		= RTPSE_MCU_OP(0x40),
>   		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		= RTPSE_MCU_OP(0x4a),
> +		[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE] = RTPSE_MCU_OP(0x10),
>   
>   		[RTPSE_MCU_CMD_PORT_ENABLE]		= RTPSE_MCU_OP(0x01),
>   		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] = RTPSE_MCU_OP(0x12),
> @@ -964,6 +995,7 @@ static const struct rtpse_mcu_dialect rtpse_mcu_dialect_gen1 = {
>   	.opcode = {
>   		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		= RTPSE_MCU_OP(0x20),
>   		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		= RTPSE_MCU_OP(0x2b),
> +		[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE] = RTPSE_MCU_OP(0x17),
>   
>   		[RTPSE_MCU_CMD_PORT_ENABLE]		= RTPSE_MCU_OP(0x00),
>   		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] = RTPSE_MCU_OP(0x15),

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

