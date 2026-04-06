Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97289288517
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775470958; cv=none; b=gzg6rTXOYINt0xYEnUSepgaX50snBG9ur0vnwtNogw0gMZ8eF4Lu44LWBK0BQwq8gcLcoyhwrmn2bpTGgkTPRtZXoRKDqt5ttdJskNknFfIaPrKocLM6i56b8e1KWRzf2JDXNejGmFIF8wUfwMv72JgSWUT2yU4+QA9yjHM1SBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775470958; c=relaxed/simple;
	bh=4okhKjhiW8BMKJvuKtPBBQTFqcI/IxoVNzhe2b6PToM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my4QxGsMNFXRIaOwlMz+Qw8VT1szvMSNshAggAsKzUsu7U3VC+ddA828D3NTI9upj7QWkytnF270z3L7dk0ehlUyS2TLRJSrOmboQBtuSyd+8yb9jSZw91tpx2U2PqCgJqdySXqe76Mh7wpcoYNXLBZEco1nD7lM5DNQewhdL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w9h67-00048b-GV; Mon, 06 Apr 2026 12:22:23 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w9h66-003zx2-1l;
	Mon, 06 Apr 2026 12:22:22 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w9h66-0000000Azek-1lbr;
	Mon, 06 Apr 2026 12:22:22 +0200
Date: Mon, 6 Apr 2026 12:22:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: pse-pd: prevent regulator cleanup
 from disabling unclaimed PSE PIs
Message-ID: <adOJXuyO1RT8hgxt@pengutronix.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
 <20260330132952.2950531-1-github@szelinsky.de>
 <20260330132952.2950531-2-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330132952.2950531-2-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Mar 30, 2026 at 03:29:50PM +0200, Carlo Szelinsky wrote:
> When a PSE controller driver is loaded as a module, its PI regulators
> are registered before any consumer (PHY) acquires the corresponding PSE
> control via of_pse_control_get(). The regulator framework's
> regulator_late_cleanup then calls pse_pi_is_enabled(), which queries
> hardware and sees the PI is enabled. Since no consumer holds it
> (use_count == 0), regulator_late_cleanup disables it, killing PoE.

Let's address the deferred probing issues first. The system shuts the
current for the ports, because ports are not tracked. And ports are not
tracked/claimed, because the first patch breaks it. Which introduces
additional safety, diagnostic and power budget allocation issues.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
