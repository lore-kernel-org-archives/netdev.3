Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B143769F0
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140605; cv=none; b=c0DiBfmUJ36XOBl4/FuaJKl+GqD/vgJ1MHTu4fPzPBrjIEY+9VByLbunitRBAiTVniewFkoRkE9ZxJJ1Hqus5pbKmBhth8KIvTrEbsQuvDMgfT6M7VbGiHPMb7BCz77SSBhuoMNfNL52xwogV+DYHBEiK0sY+oyb77ygzjo12A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140605; c=relaxed/simple;
	bh=CQ0TJV76SJ2KPI5ciMPcbnLGoTcO+cp+4gM4DKuYxP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqNxu0759Yapy++BZiQDjZGQ5kplnFbNxunVXI6lqInb+gL3KGLdfqyxCJNzgZl1Bjb8ERQs5yJi/2HURcznYUlBONVGk/m2GqtoBPRpUWh/jAdeWKrC+l1vFSGmRhF/4xP4jYG9D3ym8yWvFNWAX6BBrkEB+g7Hi7AumRaHOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z4kt1Otd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="z4kt1Otd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D93B34E40F92;
	Mon, 27 Jul 2026 08:23:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD451601BE;
	Mon, 27 Jul 2026 08:23:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7270C11C12267;
	Mon, 27 Jul 2026 10:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785140597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Zh+8qUVvssq+SHvztM6nQdaXig7PmSRyTTTYa9BlJ3k=;
	b=z4kt1OtdzIogUuPvXpecO3/rTeEdmMbydEJ5UAuHTPl3MQN7vgRaL8fJc3vHXkIpnuvG4x
	ZBAJ1b04LqhBSeidb4JFshxSOt2eLQtWcLbAwe4dDu7euv6mGvE3B64byob6omsA+EQg9y
	ee0X8oSoCsDB9SiHBi+vRlXC25SuYzcDor47Cbav/dioWLIlBxKCOdBiOvan0R84b67O8V
	ZAwFoAJ/bli0oSPBGTJtt7kQagIEj4gR3wKEx0fIArVnMQmhA9AHswDEA/2GRfiA6wtC+d
	lpKZK3h4RAZEKiII/uYuYr1BuduLQaUcYm6RqOxciCVIW4Diu1+/DlVlY/cueQ==
Message-ID: <8e9563ce-e103-4fda-80e7-5dffaca2a03a@bootlin.com>
Date: Mon, 27 Jul 2026 10:23:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: enable MAC rx/tx after DMA start
To: Abid Ali <dev.taqnialabs@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/27/26 08:14, Abid Ali wrote:
> When the MAC receiver is enabled before the DMA channels are started,
> incoming frames fill the MTL FIFO with no DMA engine to drain it.
> If the PHY/Switch is already up at this point, and there is inflow
> of packets towards EMAC, the per-queue FIFO overflows within this window.
> 
> Once the FIFO is full, the MTL read controller goes idle and never
> retries delivery even if the DMA comes alive later on.
> This behaviour happens due to enabling the MAC RX path before
> the DMA setup is ready, and any delay between these events increases
> the chances of blocking the rx path permanently.
> 
> The EMAC should only accept packets after the DMAs are enabled.
> Similarly, the teardown should ensure the MAC rx/tx is stopped before
> DMA engine is stopped.
> 
> Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>

Ah great ! This matches the programming model for the few ref manuals I
have, e.g. cycloneV manual does state that the MAC must be enabled after the
DMA has been configured.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

