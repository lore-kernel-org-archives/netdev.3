Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E852FFDCB;
	Thu, 16 Jul 2026 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187052; cv=none; b=NcrdfCiPZ/R+JGEVUJ+WqXH4ZQ4rpOT2SALGvOI/zKx2CqAYIuvblNmut6kotAY90JYnBYEM+pXAXF1restVK1MBHbUPIaIHcnP7acG9FHJ9DKO3Rc+z1nPfrNR6zHQ7cxMG+XROqjeDceAT416rq8k4MODJSo5SRJ0TZmqfk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187052; c=relaxed/simple;
	bh=5yFZbpNkdbIBERBx195OmdpFrMz9jVJZtpoBD48VsDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRIt1NEqzMAJbnRyszh0Ph5D/ajv0yPc9VaTqmDd0+Ma4jMwZc7jtIJNGPqeVOe3bKrOdo5k25oDn2aYuhFFyIwXOs8XIp7pbAtAkyPxYdOsdkpWYgE5ljQNgj7FBPeskelNQeDd+QxThD0Z9FsBuCCsUULTPb5X4LfL90tqGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pcyisqzj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pcyisqzj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1588E4E40DFF;
	Thu, 16 Jul 2026 07:30:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDAA2602B8;
	Thu, 16 Jul 2026 07:30:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08DB311BD057C;
	Thu, 16 Jul 2026 09:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784187044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GCrqmH9b1H/YVE63PUByvlMfO6u776WKzGDBctjFpRU=;
	b=pcyisqzjUShEU8xVfu/cSx/J1/B5EedBEBPC6x2l3O0Agw/mDY3UrHEkRQy2aCxE0zFqMn
	f1cybtCjaxz+DEUvEhn7AFNdLCztSNagzHWalHFlsZViRWhpCrNZsG4IWlf8/DTCjGEBp6
	43uLpyhowiDx6ouf/1/Q0b9bSs2PKw7Hl3n9zJ4OVfWPT0UwrN3mLVc5qDtKeOKeJdIjCn
	jUTro2i0AfG4bAgYMm4p+bicBjQxgKdihNmGgMQb+wQKyx31kCj8w33KEs5/iEie0IPsDW
	mWJnxJR9nXTb9ag1gZYCLEWp1949HjUBDp796k17o381cP2HTj33u4+JxBt46A==
Message-ID: <a1e6cf0a-a243-4739-8563-be385add37b2@bootlin.com>
Date: Thu, 16 Jul 2026 09:30:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac-rk: enable the reference
 clock for output mode
To: Jiaxing Hu <gahing@gahingwoo.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, heiko@sntech.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
References: <02ef3409-4078-4c3a-8c17-cb1a7f1f07e4@smtp-relay.sendinblue.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <02ef3409-4078-4c3a-8c17-cb1a7f1f07e4@smtp-relay.sendinblue.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/16/26 08:56, Jiaxing Hu wrote:
> 
> rk_gmac_clk_init() only requests the refout clock group for RMII. The
> ArmSoM CM5 has an on-module YT8531 RGMII PHY with no crystal that needs
> the SoC 25 MHz reference (clk_mac_refout), so in RGMII the clock was
> never enabled and the PHY did not respond on MDIO.
> 
> Request the group whenever the SoC drives the clock (clock_in_out =
> "output"), not just for RMII. The clocks are optional, so other boards
> are unaffected.

DT binding for rockchip-dwmac says :

clock_in_out:
    description:
      For RGMII, it must be "input", means main clock(125MHz)
      is not sourced from SoC's PLL, but input from PHY.
      For RMII, "input" means PHY provides the reference clock(50MHz),
      "output" means GMAC provides the reference clock.

So the statement "For RGMII, it must be input [...]" is now incorrect :
 - it can be output for RGMII
 - it will be 25Hz if set to output, from what I get from the commit log.

Can you update it ?

Maxime

