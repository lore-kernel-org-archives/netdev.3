Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792646928;
	b=nV/C5TGHFo7nAjegU8E3wtkQreGqnsw2OX2nV01otZz5Y10KF5KgxCakb2yPH+ewZ4bo
	 Qu3EYlP1Mt7UewaqKHixO34GR9OM2X/IC6qvsJI0PnUXk0JpKXf2KzS8vQOscIR05EfL7
	 3fTx9cyt1jyC+qejk2fk54bloqZ8IA0o4zmVMxlNDKQwnASXUZJUIgryfHQfJ8YSPnF0g
	 EddayLBrja2TB6vy5GwUM12YCpNpO4E7W22uJ1SchF2+3jdX677TW/Fhdu5IAJL1iJEmx
	 Wx1EYY9RboJifaWlIba42JhH5P9MFBjxtI9TOFW1poeWvSH22IuNJ95Q2qMhaiJi93A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646928;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=nrZ90vxW5F0O0qymJ+TK7fg60kgFlpMGsZONq7pZ5CE=;
	b=BW1vVTh2N0O3gtFW40U4Ul6RPSsjM9lKEYcxL8FcDOVhXV+nnZdvjls9idgTg/CV95TG
	 h9hkfLXn6Ap7I06RPJNymEnrSOtbQhgT5B6dsU9m6C1ZPMrW40HAw6EE2fuo2hr1EVcxk
	 qXtrumHzNilMcScJtK7PlN1etUThSIOlEUiHU5GB/yvWKR4vUoXmJYJdTiS8VlbJz9/Ek
	 jcOk9pUPQ+shJ57fOezGoLGK+A5GqzyZU8GHehYvF/LmAeZ8qHvKRzjn/6bRqBuMux1Im
	 G1d3odEMMqrP969U0sfsC9OvS+hQYBBIJILakSCrUPlCviIhBGATTbzK95iDuUwf9rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Z8hRfSWR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8127606A319;
	Thu, 22 Oct 2026 05:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8127606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Z8hRfSWR
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BBFB62009B1;
	Thu, 22 Oct 2026 07:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792646923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrZ90vxW5F0O0qymJ+TK7fg60kgFlpMGsZONq7pZ5CE=;
	b=Z8hRfSWRqyKEG2BpmZ4mOchFCkURjjophHm/2DrSpIUd0MLRTqod8gT+M1Ag1VS0DOkehE
	RJ3jyVsPkbogE3wzyj5dVuKsnelGFu7JPWmwVj9iJuMQF27iYug6hNkg7Dn/pA4TG1lb5s
	jqzX6y5lj35cbyc3LcCIjfDvIl/6IEcNkSs7YSRy2wl/hPOZf/o8mlQciEMG6z0et45dLM
	NZqBhU0KQYNdFPyn5Ulyqju24NTPc38wDcIAqcFCxOsKlZcMB1wkQ5Aiw/DEzgPlUKMw7v
	FLcQTDR0aXs/mv1U7VuPGpxhnzJOgvtpb1PK/B6KCPo6ju1SLLeWSzRPmzHClQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792646923; a=rsa-sha256;
	cv=none;
	b=FdkAsQ/tHah4m1UwMFmzClIo8bAr+WbAICReatEwfHIA+NFB4xO8f268OlxhMKT7YaW7d3
	BNMR2vA3b5PWlshazHTTmlhtewXa5m8kUvXhOO4bw5XwP4pGUefBvRisMMlQNQheCZcJb2
	F+HQxUprRPKZXT2ITG7kMmcyUpGeaU3SH2Y0iss3jD6+woS+z6oeB+SYy8/ETN4N4g7WNg
	fSejQkdZs+W7eRHU2127Bh05Tat1MfUZBfgNIoyZHchIMTa0j6pzOmqJ//KSfZfdsyDRW6
	KfxqFWAdkglOcpHvCLSbv4Dz5Rd11HPFXpULFqxB3MxOw45vVIQoz2kSC6tO3w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792646923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrZ90vxW5F0O0qymJ+TK7fg60kgFlpMGsZONq7pZ5CE=;
	b=FKUzo1oyhvEOGbstDK+XSY+f6Z6oXTR/kW86kwYhVFkzgjMNWPKYk1dwkxz58wDQEyfXWj
	5WGgAuC65dMrC4sEs9ukpP8A++kYeoj22jzFPGOCoPAgBsN2GZgRLiWQYAnq149oADPEml
	izQ/TkL8O7MPcLzUvlKSNv/WJvBHQHn3ml/4jbhCpn+Rfy1dzimNym1U5hFrLnotgHwT68
	ZgNNzFDiq3R2BYQShlHRqPg0roIeVSCXBMNOvarfs/I1wjDYH36zPVpGbrW7rV1ygJEW61
	BKRzVjMPtwUACqVTRz8BUeAxlHHad8UaL6N4V/vREzT0LVn73usQea7+kD2XrA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJlM3-000ewZ-27;
	Thu, 22 Oct 2026 07:28:43 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJlM3-00000009PzD-2FYv;
	Thu, 22 Oct 2026 07:28:43 +0200
Date: Thu, 22 Oct 2026 07:28:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 09/14] net: pse-pd: unregister from the controller
 list before freeing PI data
Message-ID: <atmfC4HmHr6RoIvm@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-10-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020171249.853085-10-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:44PM +0200, Carlo Szelinsky wrote:
> pse_controller_unregister() frees the PI array while the controller is
> still on pse_controller_list, and only removes it from the list
> afterwards. of_pse_control_get() walks that list under pse_list_mutex
> and reads pcdev->pi[i].np in of_pse_match_pi(). A consumer that probes
> at that moment can read the freed PI array.
> 
> Remove the controller from the list first, before the worker is
> drained, the power domains are flushed and the PI array is freed. Both
> sides take pse_list_mutex, so once the controller is off the list, no
> new lookup can find it, and a lookup that is already running finishes
> before the PI array is freed.
> 
> Found by code inspection. Not reproduced.
> 
> Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
