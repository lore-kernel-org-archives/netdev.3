Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0248A2DF
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352660; cv=none; b=evTFRu2vJtXdHfV0HROKMpticxP6nO0R11h9ai8wLy0WFcVQZj2brCAROwvRiQmx94/txspQI10dHj4IqO019KjRohEkj5vXw0f83A/0wKWvTEcmAnf5rGMt98JuEtQQAobKUQ/NJdMOwZWytwYOkYceA95txNXKqXeF03c4bH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352660; c=relaxed/simple;
	bh=/fNEhStUrfNS7Jp/iVs9IDKTY22PttxfS1sUfr0lqcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaS3JBPTI+SxOxEfpEvOQTvCNuXL9wI+j9v7DAkMh0GgnAeAgLr/8V7h9uagP5rCGIqz4hluueglfov6xY8ZGqltXMVqOoTB65/sBpaPuJGsqfIGz06ZukFeK3a5l+6KkU72CvNR5s5DosjBHC8KysLTEsVOyhI7s3zFYsT2gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MFJ7yO3a; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MFJ7yO3a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 603E84E414CE;
	Wed,  2 Sep 2026 12:37:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 317706053C;
	Wed,  2 Sep 2026 12:37:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 751E911C79293;
	Wed,  2 Sep 2026 14:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788352654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/fNEhStUrfNS7Jp/iVs9IDKTY22PttxfS1sUfr0lqcU=;
	b=MFJ7yO3aZwqgTUJJCwP0uqVRmFD5d6DSyUeDPt8Muxq183aUIUVVDC0pjDXn4AP78vRjsb
	8TlYiJ2vB4Ly8ePpdtOXSwkDSPr5i4s7xVD6OAlu3CXvuTRnwkFfCcbhI3Kd+s6Vcb39pn
	RFBEl0OY8STYxBtXsuNtAsEx7/DEM41cyj3/WZeeT5qqAkNRXuEZRKzqpmMAnxQ2x4O4Yb
	tWB1pC6XrNJ2O1DtyoDk4qGszIcdHXbAAkQJXz99eJ6pDFAJHe/MNWGipPo5zvoWwcabS/
	FACQYkw5QG6kwcS1m+hx93+JksA6J6U3V/Bfi6LYDRvCDvj8a/HrjouVjGtCAg==
Message-ID: <7140f146-643d-42d5-abca-88fc8697bba5@bootlin.com>
Date: Wed, 2 Sep 2026 14:37:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: stmmac: remove software VLAN tag stripping
To: he.peilin@zte.com.cn, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 vbridgers2013@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn
References: <20260902173506784mJX3FrsAcjhcYqtGuZuxE@zte.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260902173506784mJX3FrsAcjhcYqtGuZuxE@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

> -
> - if ((vlan_proto == htons(ETH_P_8021Q) &&
> - dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> - (vlan_proto == htons(ETH_P_8021AD) &&
> - dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> - /* pop the vlan tag */
> - vlanid = ntohs(veth->h_vlan_TCI);
> - memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> - skb_pull(skb, VLAN_HLEN);
> - __vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> - }
The patch is all mangled and doesn't apply, something went wrong
when generating/sending it :/

Maxime
