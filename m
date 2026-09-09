Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70961492E3E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956394; cv=none; b=NpcGHE21Dz6BncutspMq/9Zqg1p6xExFIK2FaBZdMkv6tnBnbsL0wSoS1fidrlnBAGdtbd4dkvhIiaPxCdmr5m9BxZKE1GW27V3uaC8GOISGbKvHzywOVI2VCqjQ5dE1/Xavxl4y3d37ZAIZKLfcXCC1YN9cLRK0F8+anL8eGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956394; c=relaxed/simple;
	bh=Amcp0JHkmJvc2xJKVVzxpRxuRVoOcIM3e7UcZPQ6dEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXo+zFcQbzOKN2Xr7GnUelXJ507LOM3yWrKc+DwLLcikev0wiJWXIatS72CXlIKCpHkfK2Gzw25175AWOLrUkwVzlWpajSbbkyw4fC98JHf7B5a8L+R0sNuvRQFMIawLYqWHaqCRQt467hIBX1ga+gRro8UDzqM6rKkK5xLTor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=orGhtBEA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="orGhtBEA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C0E991A1A77;
	Wed,  9 Sep 2026 12:19:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 828B160448;
	Wed,  9 Sep 2026 12:19:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21EC811C7AF5C;
	Wed,  9 Sep 2026 14:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788956387; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CZKHpTpkIb5ab/FqGCbdk8T88vV78aDTTt5HNIZwdSE=;
	b=orGhtBEA4MogYGzZ9vleTPQyNNGCH4TjHqck98Qof7Lof2INnwBgJ3LsHd2oQPf07ga1i1
	mIMhia/hz20IIV2TUhDHp6bmJMOABC8cm6o0Qkni39VagkyhfcFNRUC5JF8LylsUM7NaGC
	gUMH3JQQde/9+5unreDv/Q0DXN/MSWq/AW5IPvfhNb5qoRo645X5g+ZYtXOKKaWUL54tMR
	FgFP407Qas6aFGghpmbFj/dzmcv8DmLbXslTK5pU0f9AtcTBQLf9YYq7sCRqa0s6dV5ToC
	1M0pJff3GvPt+3EhIow4SzJJYeYcZe5O3LX/DcvcwRzbMWa8Cs+O1UnF+QO2EA==
Message-ID: <7a3fea5d-c705-43e4-b799-eff9d1580a8b@bootlin.com>
Date: Wed, 9 Sep 2026 14:19:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 5/7] net: stmmac: Disable S-Tag processing on
 dwmac4
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, recv.jo@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, shuah@kernel.org, joabreu@synopsys.com,
 yi.fang.gan@intel.com, jun.ann.lai@intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20260908164309.59282-1-ovidiu.panait.rb@renesas.com>
 <20260908164309.59282-6-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260908164309.59282-6-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/8/26 18:43, Ovidiu Panait wrote:
> Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
> hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
> than using the actual protocol from the packet. Because of this, packets
> that contain a 802.1ad outer tag are incorrectly passed up the stack as
> having an 802.1Q tag. This causes QinQ ping between two hosts to fail.
> 
> vlan_rx_hw() is shared by dwxgmac2 and dwmac4: on dwxgmac2 the tag type
> is available in the RDES3 write-back descriptor (the ET_LT field), so the
> outer tag type can be determined based on that info. However, dwmac4
> doesn't seem to provide the tag type. The Length/Type field in RDES3 only
> indicates whether the packet is single or double-tagged, not which tag
> type was stripped.
> 
> Since dwmac4 cannot report the stripped tag type, it cannot support
> hardware S-Tag stripping correctly. Therefore, restrict the
> NETIF_F_HW_VLAN_STAG_RX and NETIF_F_HW_VLAN_STAG_FILTER advertisement
> to dwxgmac2 only.
> 
> With this, 802.1ad tags are left in place and handled by the software
> VLAN path.
> 
> Fixes: 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN stripping")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


