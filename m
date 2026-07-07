Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71754330675
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415511; cv=none; b=hJ01+ed6owDxy0qx6cuMPk/WqmVVD4t7TEajh6dBZeSV8+A0f8Z3x5tf3ku45KhEfx5m9Ad1zS3Cgzr9t7p/yXVy7tZMzVCOQE2rkjyVg+7HinV+PNCE4KaNUZGoFkHd+z0HXT02a/yAjKKvISiBM+fTIS8eqqxbxCUR21U7cS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415511; c=relaxed/simple;
	bh=5f6GIDZMQrqFo+6gJIgZVFJCjUOoumzFzJERSA/umEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dx+KN5BAmgFvD4VIY6dg186qpArRVa72E7MOKGfB1dM+5pkF77aFgMjKDG9zJ3hJMyujX/UJdV6A+3PGVxVR89ifBKNxeIf3W2XaCop1cemIFHUMSn42jSmX9tSmk33KnTY6N/m+UYjWzhAGfMbpIUJquiTLr4/m3/cPQ6a/qO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gzY7nslo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gzY7nslo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 05F304E40CC9;
	Tue,  7 Jul 2026 09:11:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC71C601A3;
	Tue,  7 Jul 2026 09:11:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6EE511BC1165;
	Tue,  7 Jul 2026 11:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783415506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4aiFVPWk7NAYVKW9uB8OzYhAIo5EOwzD2w2pJLKQ5fQ=;
	b=gzY7nslondsKNUqkWe+5CudiAGehplbtGDU7t1nUKgS4SwOgk1WCNvrrKIg1Iec1drudT5
	6itqVQiujEd+9aD+6JbqeILOWmYIXK4o49E8D4+ZrCU1cus1GhCSWFBOWnqbc6j0Q/XEMN
	OvKNAPxNmFDOxkNhyFvvkO7kuhuRrahqmS5phjEl5iZU3KlWmDQm3sHovgRkBwCLEoluce
	5NpRtB0Rz0EUGkDMDBmbfa9SJP5Lgrv6pB7r8udDvEpjyKoLcW38wABzCVRRQtzGpnzIwW
	ePpOSMpVM+rhze0G3AvSCz1de3DqOc4zmSp3173TTCLro0iB6kqnS9zgTJW3mg==
Message-ID: <2a421449-01eb-4066-8c19-d554ff8e4f6e@bootlin.com>
Date: Tue, 7 Jul 2026 11:11:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: stmmac: mediatek: add support for TX
 deallocation adjustment feature
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Biao Huang <biao.huang@mediatek.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: rmk+kernel@armlinux.org.uk, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
 <20260707-dwmac-mediatek-mt8189-v1-5-17f345eaaca3@collabora.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-5-17f345eaaca3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/7/26 10:21, Louis-Alexis Eyraud wrote:
> The MT8189 SoC has in the Ethernet control 0 register from the
> peripheral configuration (pericfg) additional bits to adjust the TX
> deallocation.
> 
> In preparation of MT8189 SoC support, add its definition, use in the
> set_delay_v2 callback, and a support flag in the platform data.

Can you elaborate a bit on this ? I don't quite get what you mean by
"tx deallocation", this seems to have to do with RGMII timings from
the register access pattern, but the local boolean flag for the feature
is named "use_stage_fine", I'm failing to connect all the dots here
with the different terminology in use :(

> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 25 ++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index bcc0baef3f71..6b0a42b5839f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -37,7 +37,8 @@
>  #define ETH_FINE_DLY_RXC	BIT(0)
>  
>  /* Peri Configuration register for mt8189 */
> -#define MT8189_CTRL0_TXC_OUT_OP		BIT(20)
> +#define MT8189_CTRL0_TXC_OUT_OP			BIT(20)

Extra whitespace inserted here :)

Thanks,

Maxime
