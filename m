Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6B34752F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781574; cv=none; b=h/SaQQ93T/UinWgSbMtrM1kIQxZm2fIk9uVqg/4rwODlFzIi6Urj4eu7cbHD7aNaUI1cdJOtcyvieLB/a+ZdU5lysgJexhOTNVMYSQcaxOtS4kP8JhF480QerFU7Auq6JhQabhCFZhfeICirSDUiqTOC04gm/iTWW7aSBV951VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781574; c=relaxed/simple;
	bh=gGTQagrz1xD+gCq+3RMCSJe5Z2VNXteFECPa1dN/qjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URr77zlUx/vLQHRdg/EcEAm4KubI0SzbsB4JXBLkjKj+L7Yx9TiQ/WvW88n3jCZr0JHHRDlGHde0Hu761qCqizyrn/T6nk5B9E7ABVPOSB4vyTiGh9ASWydhxT118eqhVW/PVq9Jt4TZshuUg7HdzpIjeWd3E/YbwPxP/rR0OL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M2+lfUYQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M2+lfUYQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6DF611A1A30;
	Mon,  7 Sep 2026 11:46:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40D4E60383;
	Mon,  7 Sep 2026 11:46:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B15A11C79C68;
	Mon,  7 Sep 2026 13:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788781566; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xyGVHRE2Lj8Q06pn5MxlowgRlFrHPBGoWeD1pOntCVk=;
	b=M2+lfUYQI41WktDF9HcR2BwikwvYg6/iHy6KkNmZBdChPMMKWJbwyE2qWT1R9L50uSBR98
	/oMe/VGO0pKjGt1bLRpfb6gQsoXIwj0MpGv45HpVQF9cy8s2iVw2fLB7ier/RGpmFEne7U
	Q8UURb0OnfbfdkvCNnoFgHu0aufWzn1e2EMOV74Pye2Zj7K8vPVlnHqbn9Mu3gZ4FoQHA1
	I8erHIC6WviSkmqWFo7iq5cKlNCISiue9yGrmazgzZ+6uzj2+gKWFuTYHWI+m4sOmJQxYs
	Xmipw9mJq1CdNOuvIgZwph5fh1Fz2EFXpGO2gA6kEmvp6LuGVubOTtLGgbcmyg==
Message-ID: <79175f89-a513-4fd3-81a7-52c019039897@bootlin.com>
Date: Mon, 7 Sep 2026 13:45:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] net: stmmac: sophgo: Use common RGMII
 delay handling
To: Jia Wang <wangjia@ultrarisc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Chen Wang <chen.wang@linux.dev>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, sophgo@lists.linux.dev
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
 <20260907-dwmac-ultrarisc-v2-2-9a39bf8db313@ultrarisc.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-2-9a39bf8db313@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 09:46, Jia Wang wrote:
> Describe the SG2042 internal RX delay through the common stmmac
> platform data and let stmmac_pltfr_probe() adjust the PHY interface
> mode.
> 
> This removes the duplicated mode conversion without changing the
> hardware behavior.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Ah good :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

