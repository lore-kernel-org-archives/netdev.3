Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1194779BB
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184022; cv=none; b=ZSxTTLNRwYfhnnHqgAyqVpoP5bicPyFiR3Egd0giuvD+KrzgT+41ZhHHf78YHyRQZc+idl3vPtLId44zNHue8nZQyMTHZxiceCqv6mmgVsitbKD5MAHCpH7eFA2L9UDxFOiojwXoIP0mOEM2jzpjTCZhU3tbROskSQNKJ2P8S8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184022; c=relaxed/simple;
	bh=F8kTF1D2OoAq6tQua9BrBBUgOLLriwTpFSv7Q3WjqzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeHb3yGyaJwXVJzL/l2BX/n+U5Ok0rQLhJe9uS09dxw4409kutIHRvBx29K85QX/z4N6Lsf/gNecn1oo4oYB1/DaGTC6a/3vZQadamdoT4p1Mg6Vb+1ruZgkNNOpnCKCh53tqqUUZ8Hp8AXwiX84loL0rH4XBPA5IFBTGsXIbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wPH2C-0005rH-LI; Tue, 19 May 2026 11:46:44 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wPH29-000jyf-1A;
	Tue, 19 May 2026 11:46:41 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wPH29-0000000HDDn-3Rdz;
	Tue, 19 May 2026 11:46:41 +0200
Date: Tue, 19 May 2026 11:46:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: ag71xx: check error for platform_get_irq
Message-ID: <agwxgUG5R6CxnlMC@pengutronix.de>
References: <20260516212616.11758-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516212616.11758-1-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, May 16, 2026 at 02:26:16PM -0700, Rosen Penev wrote:
> Complete error handling for a failed platform_get_irq() call
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

LGTM,

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
