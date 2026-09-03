Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176B4A92CF
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439496; cv=none; b=fyu1YUHQI3ts4IJoJUyES2dCJCj11hX8ap/qGJymkYKL0+VsEQn7C4+ZbXqADTsbdOu6cqohu4vruhKEbmzhgNjShSXRPRMVIDNSedU3JPc3thlkkWcWnBJSlJfMX8dgxi+6IaHTIwMzks3oiYfQFwlo3t+iPKj0/hwC6wYLJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439496; c=relaxed/simple;
	bh=R3AxlCLvufhVnZyKjIEjkm2xl4Pg+K1CR4it9a9I7hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jwomlbsll/IjIpkhcEGG0Z3Zjck6SpOaqlmcHxjUzGxV0TDlSyS/Jovr/QE0MQoX5O1V3tIn+fauRhl+Bv64o4tHUux93KwzzBY8rCc1gR/6vn6Izaw3EbjcuK2FCpN1T8eCbWvGWJmEm38ZrG3K6hlUNIXtCVt6RmesQU7hxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W4NVJEgb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W4NVJEgb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B29841A197C;
	Thu,  3 Sep 2026 12:44:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83C27602B8;
	Thu,  3 Sep 2026 12:44:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1AD111C79654;
	Thu,  3 Sep 2026 14:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788439486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JsblEvBQ1teS31XosrNUPF2KwZplvL3VPUA9AIDMstw=;
	b=W4NVJEgbFGjeDFu7RoTcpKjUbUAWeP1o+z8s0YMDe+2pydERf+Pkt49pYHtl/wq89nRVLE
	bQPKuPcxg/DsN3ODX+psM+Z5xkfbSAWSlGNxjxF8aQteGI/2Jb/qA07zQ6xZPUW4WiSfvr
	luuSWs+JNbXi+zMWU6fJaFtwhkQ/jRH8D0AJ2sQmY6n+BiN3IVktLB6RYPhxQIPRxE5gmq
	pEN5s5mpe6C7o+5vetEfSSf0az9z7aIDZsL2IGc2Y0r0rWp+v9DhCHQBUvvItdEM2mJ2kR
	Kft9SumbBXuzvf6laM/JMqxxth/P+J/slmmi+bxglw+CSnwmvJXaw3FTjUe1pQ==
Message-ID: <ed0618a6-b7c2-4ff4-b3d9-465f6b882cf7@bootlin.com>
Date: Thu, 3 Sep 2026 14:44:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: clear dma_conf on MTU change failure
To: ZhaoJinming <zhaojinming@uniontech.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260903-fix-stmmac-mtu-change-use-after-free-v1-1-c81dc7d6d18a@uniontech.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260903-fix-stmmac-mtu-change-use-after-free-v1-1-c81dc7d6d18a@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/3/26 12:50, ZhaoJinming wrote:
> stmmac_change_mtu() releases the current DMA configuration and then
> reopens the interface with a freshly allocated dma_conf.  __stmmac_open()
> copies that dma_conf into priv->dma_conf via memcpy() before it can fail
> (e.g. in stmmac_request_irq()).  When it does fail, the error path frees
> the dma_conf descriptor resources and the struct itself, but priv->dma_conf
> still holds pointers to those freed resources.

Following that logic, it seems that the problem is rather that __stmmac_open()
should clear its priv->dma_conf in the error path. It would undo what was done,
leaving the state consistent.

Maxime

