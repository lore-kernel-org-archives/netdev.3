Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F733ECBF9
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537266; cv=none; b=KKTATkBRpqToWH+gOUQ96sHN/be6QVc1K+CXlaK9zrH/ulzvhJuQIXmHc7LYEdjB0G1CowxJOCrdZtt/aUfgBFtIQy1Y7vsj95G3zcrELWn20CFnluAJDfSi4GxAQsUH5fzCP/DZNGhh5tWjy9nx72l0BOVmv/Gy299VKue9YZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537266; c=relaxed/simple;
	bh=vAhr08sAZq25h3ux8xK7W3b13QDodhVQrVp4e1pOurw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pLzSN83P/3de4sviVkPU2oMkdz4L4C49O6VOkwzG7ijXjCxGPG+1DB6CS76KzKtbkts0yH0cOiFL+A4RxSxo02PERx1ir7aSSzKcBIBdUMo+sGDI5jNR/ue+p35jCkl1s8gZ55ejD1DJN99QOOxZ9H8dT4Oko1tfTyec/1+QLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eJqkbjRI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eJqkbjRI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6C6454E42F00;
	Mon, 15 Jun 2026 15:27:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 378B460015;
	Mon, 15 Jun 2026 15:27:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75110106C8297;
	Mon, 15 Jun 2026 17:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537262; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=93S5IJn8Nm38fDgXmSpC8QemVzQ1sjDUuJR7xlPUztY=;
	b=eJqkbjRIok7cjg54WjqMc6fe6G3dz/a0LkNOep2ilTQerWzkrRIgxxZMEeXuBNJq5web0h
	A2M4yefSKsLwn1t9M3LWHFWS342nrWp1I/I+le6oqzVXZwbLxbRWljpwWhXkZt3z9dbbp3
	Y4ID0x3rhrNyTGd8RV+HSFmrEOqKHB7EXbFyyR/3Nm/hV/LQeaufsrgpRp1NVpapIFdIJN
	4ptnQyWdKWKmvviISPPROC4tzfvLfVr1jxsz2p0q+lyMLhAHnUJvWiPmbXknRKRv0pojOg
	3qd6uC0pIgFR1T1Z2qqNnVNoqRsGL4vTTrumHZUfX5YXpUpINApAtumDwT/5bA==
Message-ID: <53f0eca8-05ef-4432-87c7-25bad6252585@bootlin.com>
Date: Mon, 15 Jun 2026 17:27:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix supported_interface
 set after phylink_create
To: Christian Marangi <ansuelsmth@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260615151106.15438-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260615151106.15438-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/15/26 17:11, Christian Marangi wrote:
> Everything configured in phylink_config it's assumed to be set before
> calling phylink_create() to permit correct parsing of all the different
> modes and capabilities.
> 
> Commit 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988
> internal 2.5G PHY") while introducing support for 2.5G phy for MT7988,
> probably due to an auto-rebase, placed the configuration of the INTERNAL
> interface mode for the supported_interfaces for phylink_config right after
> phylink_create() introducing a possible problem with supported interfaces
> parsing.
> 
> While this doesn't currently create any problem/bug, move setting this bit
> before phylink_create() to prevent any possible regression in future code
> change in phylink core.

Agreed

> 
> Fixes: 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

