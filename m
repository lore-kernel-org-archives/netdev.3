Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C4367B9B;
	Mon, 19 Oct 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402448; cv=none; b=GkdsxQZsUcrxtiCctXd9cDneOHIkSJhVSysBe8PdcYuJ35fwSFDt/Ffi4M8R6eCvV89zPF3mauzvoy2Vdf3SmsT2tsOBUoU7U8bvYTEGqf3KFagbDXP9zL4xVfnkQro6s+jHc0i/Co1bpGZyLrbX/nhsR8/AA+prLTCSVHXuZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402448; c=relaxed/simple;
	bh=qDkD2xbz5JG6OM6D2+bwCztqcbCXRkklUC3KNYDjQvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7g4QmRjlPwyH2JDqw1DdaXb86iTmwixXdClSG/5ECZBDHdQEjpYFwCNPPfo5U0x2JFpy43w2Z7SuFUI1Cq1PfL3NK2IrwwlT0xhXt0tMhzLoqkcwJn2+FOGsRdS76HL9C1u5pQb/qFHyahq3HIJnPp3IH/mfoP8v7t0QSNZbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TKCn15rW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TKCn15rW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 75EA61A1271;
	Mon, 19 Oct 2026 09:34:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46D4260582;
	Mon, 19 Oct 2026 09:34:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D721F10328429;
	Mon, 19 Oct 2026 11:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792402444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pRrg5/fp6p+lUqJFcCXXTnkupFlZ/vWdb0belyXUCZ0=;
	b=TKCn15rWlW9xEHDt9zPqzSEYDg2g6QhDhkfrbPj+kjDXtdvwgY01ez5n87wceCon8i6oOp
	84b+jwoIxCmvWZTptaeHX/tcROniyQ8hmAMVfdvGgVlFLUuGF8zpXWqHlD4e/YhyknI/vr
	wdqaNdwFa2a5dF395oZQaQdEqAW4KuNukVZSWBBiQRadkZcGO3v7TMgtfQqYmguxDBwhSv
	nY6HLO8yYRlYFaYb4H+23l6z2OlvmZqCJqmJ1oPKx3ey1ttjsNPc7eRac2sYOuYKJQH3kf
	W1nzhk8/paZ7v0IWybomagsTYqYp7aEb7W+0N9mNo9GPJw9ZV1r0w2IPgPENXw==
Message-ID: <c4149750-e337-48fc-a9c1-71b168f144c7@bootlin.com>
Date: Mon, 19 Oct 2026 11:33:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 03/10] net: pse-pd: do not keep a failed IRQ in
 pcdev->irq
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
 Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>,
 Kyle Swenson <kyle.swenson@est.tech>, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261018082314.48950-1-github@szelinsky.de>
 <20261018082314.48950-4-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-4-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> devm_pse_irq_helper() keeps the IRQ number in pcdev->irq even when the
> IRQ request failed. The failed probe then runs
> pse_controller_unregister(), which calls disable_irq() on that line. If
> another device owns it, that device stops getting interrupts.
> 
> Clear pcdev->irq when the request fails. It is now set before the
> request, because pse_isr() can run as soon as the IRQ is enabled and
> pse_pw_d_is_sw_pw_control() reads it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

