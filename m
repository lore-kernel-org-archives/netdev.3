Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC84B95BA;
	Tue, 13 Oct 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885661; cv=none; b=r+YN/k+bFfLqpjarzSl3kxKiUVSiBh9alsPGtcVAWqaFymW3Fio9n1eqtr5iNd3nEAZFLMlgrkTRQhbtLxiOpKgynNXxHBEdR/ems1ZZQ9dqMlr2ZnbeAMUMh3F3SpjtCdanhoj958jNvFf5+6m0+GvYjEjvuBz0h0g9kyas74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885661; c=relaxed/simple;
	bh=34PV9aRPL8++UvZiKLlB0IHp9ROPzllhaljnTIs2kZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arGDTVCdSMqT9WOwFvnUvpy54vqd3rZoxXueb2rguQh0K1Rh9KMlgW1Yo7P8nM/hj5D0c5a5yUNdRsit72eQjhiL25cA34s7fdeTcSPoOV0wobRbNl/2hdStQHz49iLxlBWsc2Nktdzpfaq62jYof5hVR0IwzMW/ywqVx/mXmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x6xAKjC0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x6xAKjC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791885660; x=1823421660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=34PV9aRPL8++UvZiKLlB0IHp9ROPzllhaljnTIs2kZA=;
  b=x6xAKjC0kI1kUB9Cn/1219uHHX0Zvq9jl/aOIHgHK4YikpQZIWTg1FTB
   gWOjRO7wTRqB+svASvVXK4HltyBfORG9q2lc4ARS9UL+KQim7koyjHZS0
   kB0pm59REMTMROwtS50AqR7TIDSIPGdU2FnBs/IiR/KZT1UvSFHMDAwOD
   q1wUvKhjJahchN+hdSYOlbfdZKDnNIlEAncrwVAaL971stvApuk/Wb6Bp
   UyP6f/1ULtrY/8I4O7FZb/drOwK9FllPHi+xPzuwEsUyNmYJQ1xhCVqHj
   oKlZusEW8kMcD2J5ybY4/i7V6PKNIVrFeFnNEaghYMxopDlbG4ikRnCCw
   g==;
X-CSE-ConnectionGUID: v4vybxodQ5mvXZ+oKXGkhQ==
X-CSE-MsgGUID: maPyYGMyR/mAth8O89wZcQ==
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="64951986"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 03:00:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 03:00:58 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 03:00:56 -0700
Date: Tue, 13 Oct 2026 12:00:55 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: David Yang <mmyangfl@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Jacob Keller <jacob.e.keller@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 07/10] net: ethoc: move setting of netops to fix crash
Message-ID: <20261013100055.nof4qy3ssjgprtd4@DEN-DL-M70577.microsemi.net>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-8-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008022656.3592191-8-mmyangfl@gmail.com>

> ethoc_probe() calls ethoc_mdio_probe(), which connects the PHY,
> before netdev->netdev_ops is assigned. phy_attach_direct() ->
> phy_link_topo_add_phy() reads dev->netdev_ops through
> netdev_need_ops_lock() since the commit in question, so probing crashes
> with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.
> 
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
