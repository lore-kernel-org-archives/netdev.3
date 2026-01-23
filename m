Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE919992C
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202287; cv=none; b=oniMZskxBW21B921yI5lk2Rk2kerhO/WIGmM6XhFIj3Eznda1i26Qn9zfCY7kr+rTWlQebtcoc3OklZH+6FRLyeAcwfdYc3h3VCKy0oCb5tj2uUPhzbDGh6WBplIfZOHhyL55tNcUGwYSVpnybPnTibaJQE0d4G62Ytn9jOsqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202287; c=relaxed/simple;
	bh=uOw/tGhA18La+/CoA/KQTT87PQaemnKL4J5kioOYfjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6hJIj7U3LGlU1uYU5Kb46Ua8VL5Sq42JtVwY2Cr4HPl8ReyUKT8IjVOOj2DnWTwxRXHs7jWf0pkgxOqhAvJ/7CfpYmvIU9oCf/3cQhOgKlXy6+60Qz03MbBfeHRx2c9PrU16w9s+0I95ThwUaWchANWK99NuTpZ1Qz330+3Kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjOKh-0005To-2t; Fri, 23 Jan 2026 22:04:43 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjOKe-0029YU-0e;
	Fri, 23 Jan 2026 22:04:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjOKd-00B7BO-1B;
	Fri, 23 Jan 2026 22:04:39 +0100
Date: Fri, 23 Jan 2026 22:04:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch, andrew@lunn.ch, chuck.lever@oracle.com,
	davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
	gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
	jacob.e.keller@intel.com, kernel-team@meta.com,
	kory.maincent@bootlin.com, lee@trager.us, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Message-ID: <aXPiZ8H-usRn1pcD@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <aXNAjOjkCqOESf5y@pengutronix.de>
 <aXNbTVF5KNz1yV-1@pengutronix.de>
 <20260123104031.16d914e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123104031.16d914e4@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jan 23, 2026 at 10:40:31AM -0800, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 12:28:13 +0100 Oleksij Rempel wrote:
> > Here is a TL;DR summary of my questions regarding the pause storm logic
> > :)
> 
> Eh, did you get AI to help write the full version? :) So much text :)

Yes, to reduce the text! Sorry, sometimes I have word diarrhea :D

> > - Should we standardize an "RX Watchdog" mechanism in the core instead of
> >   or in addition to driver-specific stats?
> 
> Our primary use case is machine is hard-wedged. Either Linux crash, or
> kexec died, or UEFI issue. So it must be the device that implements the
> logic.
> 
> Florian was proposing a hook to auto-disable pause from the crash
> notifier. It sounds like your use case is closer to that?

It is valid use case - it will be nice to have it too.

In my tests, I was able to trigger an Rx stall and a pause storm (if
flow control is enabled), for example by partially disrupting the USB
connection. Since this controller is used in medical devices, it will
be good to detect these anomalies and attempt recovery.

Sorry, here I want to hijack this discussion for my purpose :)

Since a pause storm is only a symptom of an Rx stall, should we have a
common method to detect it? Is it even reasonably possible? In my cases,
I tried to detect it by monitoring the level of the Rx queue, Rx HW
counters, and Rx SW counters. But maybe I just have a blind spot and
this is a naive way to detect things.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
