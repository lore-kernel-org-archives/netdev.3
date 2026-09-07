Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE135CB95;
	Mon,  7 Sep 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781612; cv=none; b=DrCq8unlMMnO1s17NfCu9BtyeKcDhPAI4o8evOT4TETP9y03guso3EUctFioWVEnDzabLdjX9z21Lcw2vcMbui4s1cjelARvBuMyM2qRUU26F7a1ONAaBfX9hMu3vgYjwZ9/2O1HLYfCRaDqKAiF7nYG+ij7nhuxBUu96iXeWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781612; c=relaxed/simple;
	bh=7ZLTjDEEtC6zkMgDu91plBy4nX8z3Tjj1H5vamyi2mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXlhgxN+DxZrRUbOgyaoUSn8vyBZGllhib1ypCMRuUlrPOF/oIjt4ulU/Ba5ftjE3r8dxVye0qm4VAJ0FC/XcRFR2fFKTbFONfOxmVhryT/263ZVO/fNM9S0qdACqhXjST7w9jG+RIBtl0t5EgpD9JOUBQmI9jTFJLIpAcFByKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qi35WIgG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qi35WIgG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 439314E41565;
	Mon,  7 Sep 2026 11:46:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17AA460383;
	Mon,  7 Sep 2026 11:46:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5D0411C79C68;
	Mon,  7 Sep 2026 13:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788781608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=G/2HjxRQLVx4ZIzd+9uQPx/YxtgBjjNF2hoUfh2eYWI=;
	b=Qi35WIgGFkYfNOA1MoQiPmFgq1xHgqBj4Xo7MGjEOC8AdWELyANs5M6LXLU02RKnc1XIe0
	+g7n+yJjb4FsZsTnTf0rXyRNqGtWgL+UPYPePBSfB40pE+i7q9E2XIdd2LE0IFhcxVHh7e
	NQXv3egZ1ofjN4N9DlhiEN0H1g5bKd1RFQdTrwWf8SOoiQhVIuwiHvIU93gwNxcL+q+7nD
	UHWlaUdk1xTqL1n27Vf27w+BwmMaeWXpiZVq3hwv77z45b3b5o9VTgT86masdCH0dUcMvF
	p6y7cOm9kBosqi2AvOd6RumrkqZM1fjQazpEmGsyxAUfcC3vyqbwwGBcAUgWNg==
Message-ID: <ed05c706-8370-43cc-ae04-b479a28de9d1@bootlin.com>
Date: Mon, 7 Sep 2026 13:46:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: stmmac: eic7700: Use common RGMII
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
 <20260907-dwmac-ultrarisc-v2-3-9a39bf8db313@ultrarisc.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-3-9a39bf8db313@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 09:46, Jia Wang wrote:
> Describe the EIC7700 inherent TX delay through the common stmmac
> platform data and let stmmac_pltfr_probe() adjust the PHY interface
> mode.
> 
> Keep the existing programmable TX and RX delay configuration in the
> EIC7700 glue driver.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

