Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0D39EF12;
	Fri, 16 Oct 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139043; cv=none; b=qwjEIP1Cuur9vw49bBY3vahnVvIyHUdpmXKN3kFKXplpS/ivu4Fvj48K3FxsQ/Yf4zj+NaPdxiUgWPRLocknsK+fISceyhVR+5c4f6RmdpHik7ElSAwGn3GxGFA3XVwY23T3pjWIurTIuNJBpK7yPmJGbg5riQBaFRRmZSTUBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139043; c=relaxed/simple;
	bh=JGthiHlF+uKYtSqB0X+3uNc87vfCss66ZqninbLpsm4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gClDAIKIwgJjUytKh8W74o0ajPt5SiXNf1p7iZAYCT2DQg7zuul9vt6FBMZanGOzfS4SvLHUgBWBrmOVFnb7gOchOMTsL9Tb/MB8PZbid/r9G16TYx+0XjgozA17roph0SDcw70n+A6Jd+CrPNzyQ4B2ryUObxUpgIxJ3qliK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lA/LBoA5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lA/LBoA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792139042; x=1823675042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JGthiHlF+uKYtSqB0X+3uNc87vfCss66ZqninbLpsm4=;
  b=lA/LBoA55EWPQVmBceR3wZRTTluo2gyIKrb1GRcvEZ+Ndi8V2bo9tfVq
   E5szSMJipySB4FApLprdNxCSvDr40G/SqMwAzhnyycyVeUOYrsWsoSZ1h
   AwBHhYSecHSQfnVyD7eKv62g/+YJmr8zempx7kDof+LnBI92tkaZGbVQq
   tcCWVskeMOh5H3cl6voI1SBlZzN+LyX2VnAeP9r8ZI5cDT5sXOTFtBlpl
   2f9K4ZCl4+ua9tx5GSRGaPP6s2/ZxH9g7cAUuKAuOOP+Iucj4ni8veEjg
   GH44X+5ERdRB/yP3gMYxeL+17tq1BuwWHhuSlNrc6w62sNC5TgPRevEeF
   g==;
X-CSE-ConnectionGUID: TOrw4rY4S5yeXNdGFZyfUQ==
X-CSE-MsgGUID: 41Noxe9iRK2Vg81zQjlvMQ==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="296552624"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 01:23:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 01:23:55 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 01:23:53 -0700
Date: Fri, 16 Oct 2026 10:23:51 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: Iyappan Subramanian <iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] drivers: net: xgene: Fix dma_unmap_single()
 size
Message-ID: <20261016082351.5uxepcrqu24qj27o@DEN-DL-M70577.microsemi.net>
References: <20261015124547.29996-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015124547.29996-2-fourier.thomas@gmail.com>

> In xgene_enet_refill_bufpool(), the skb->data is dma-mapped with length
> len which is set to XGENE_ENET_STD_MTU which equals 1536. However, in
> xgene_enet_delete_bufpool(), the same buffer is unmapped with length
> XGENE_ENET_MAX_MTU which is 9600. This may erroneously unmap other
> DMA buffers or cause other issues.
> 
> Change unmap length to XGENE_ENET_STD_MTU.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
