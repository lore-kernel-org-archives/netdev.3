Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24B3D9680
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516385; cv=none; b=DRWTmrmVnVsfdXUUuFrr52DPqBzazx/y+G0/YzWQaBfF6IoVt+E4pFi/GnS3CHLkw/SMHByw/9WQshOb/20SQTwONlutyVR5nBQMcXSgCJBbyaP0JAPkQIH4eV09NYu3/aYLTRzqb5cYhDXwG2duyDxNlkNkEIRce8jlSaYHADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516385; c=relaxed/simple;
	bh=x75oxlQn2awWT9/NZxh+u45lCUQYq+UJ7N/Fuf4rw4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbthsr5Z9uYLoDZHyLtYE/wvtZg+DOnJts7/qFRm3iW3pPdmgJlvCUnZMectAG3xRjzSRDV102nczZfCO/CDX8Ht1fNJfJumku5Hpx34ddrs7o0eicrPyF3F4owK20OYNjbF9o9o1hq9RbNwz35yLCCGmg8j+XmzEyFwdw2Omvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wZ3mx-0008GM-Ey; Mon, 15 Jun 2026 11:39:27 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wZ3mu-002qHT-2Z;
	Mon, 15 Jun 2026 11:39:24 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wZ3mu-00000006HGh-2mTL;
	Mon, 15 Jun 2026 11:39:24 +0200
Date: Mon, 15 Jun 2026 11:39:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: jelonek.jonas@gmail.com, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, bjorn@mork.no
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE
 MCU driver
Message-ID: <ai_ITHd_xxt7an4q@pengutronix.de>
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
 <20260615090733.739423-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615090733.739423-2-horms@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jonas,

On Mon, Jun 15, 2026 at 10:07:33AM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

It probably sounds scary, but sashiko finds not all issues in one time.
Bigger patches and more different included frameworks - increase findings
probability a lot. With other words, it may more rounds than expected.

You may optimize it if you have access to some free or payed tokes,
by using sashik-cli with LLM of you choice as backend.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
