Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3947F78F;
	Mon, 19 Oct 2026 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389215; cv=pass; b=okKXjTvgc6QM2y1yp69l3kD2GmyjKfm5bcMC4s+RY9e1/qn6K/2s8fyoHXtjniUCs4nma4LReLpOc5BaAd2MNwa9hdIz0Nza/AmSLkmjuiq9niV5jL/h6Rw9a+EgFZ6MTfyYPJZM9lxrvC2tJ86t4OfimPsR9MmjGdckHcYiLJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389215; c=relaxed/simple;
	bh=PEVAiiwxbn64bCGwrkzWZXhGh+bZwgJonf474xj6Sz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMb5zGMr2qpASr985mjSPIjck9hBdyxJHkwAxRQOPvRsjL6zuNk+1OFZWwv9hZ+mSsiQKMW+EwgRJnvTOjqy80sy0Q5oPLDW8Jq1WlXaySuqC5LC9DE/+kbxGJe2BKcRgC6iyDB4JZTFF1Vld7FNePXf8YJcWzD6Qrl75ejrHdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=V47h9XI7; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="V47h9XI7"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3CD23200758;
	Mon, 19 Oct 2026 07:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792389095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KxzChtRN5f+75q8xgEai93ccVRDGMJi1KmFSQaORlA=;
	b=V47h9XI7Ca8JO+prlGQKBjjqJgnk5xA1iUzkQf8P8DL9g4u6i7yhOur3AamQFlWXSU/iBM
	MDVi3dwepyfIPWvpVgtfszFBwJdz4igh8nX9m4JOT1Lmw/XKnNjIUThv4kpIScRfOQdK48
	ISmh4DvytVARKtbFGAc5vLnEveylZ5uQ/De0h7RV/tMXkcxinbCJztfUuC/bXoMfvmruya
	Cm3ixIH10QlS+ZnVPltdMNFFINgowdrx26CMpipots98XMkN/8KG34HjtuKxM+J6xkNeJL
	b7so8IyqD/jBoPu4sFCf4LenUYHN+MvSjuk1PU6YJRvtGYb0TLaj8aY1sgzniw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792389095; a=rsa-sha256;
	cv=none;
	b=U1EBufISv2NUiC/2CHGTxlTGpmL3hI+dYlix2XyJZ9tE9vkiEFue4wcadzNI+TmKAdgffg
	YpxWMeLuEHdfOWxHzZUHz/kODxJvRhE+DN5lc92OiBhDfSA6AUrXrrTMEO1ZTbGK1jlaAj
	GNRHm4hUXbd4WxYElqVmaS6dl/yXRaIGsYN3061DK3le9TTw+mXtXFM0jW0rVrxYtmGDKF
	ypXZKyfcvbrKMU2A3tv6AEnWDCast21ubMhYUR7czNS0KYoHW/kKh6XJpY9oUAZCqaQPPE
	hOAtzXjE5n+ZIamNPOx+mA+kpcAuVNfj45GVNmGSnvvMROdLRiRJwIp6l6SZow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792389095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KxzChtRN5f+75q8xgEai93ccVRDGMJi1KmFSQaORlA=;
	b=IA7utFdsytBOUcFQ93xmEicmER7WfpsAaIdfxzX/Y8pvTIIZlkAAONBzykdlDW8H6F1v0W
	st9nFcEHgc7ybcuUA4bf5Is/XbwpW0IOidr39zsOMVAgEh62yCpQNHdrz0p8eOhFVx5aWe
	XsqNFVxisiCuFm1D2OY2/HG5eyphLn3IbgKvEoJ0MXqAb/wX+39H8XjLXqiSKe1KkgTczI
	JoUkHuhaGt8Tf8y3kuYzjQIwRfh2mxjGAtAZPvghgU8WW92MV/Cp0Hl23VUipbhGrQiqni
	yplM7Cf8XDgCE7b+rO1ETvvn2cmpPHnx338UXVrmb2ipxZsuaDkPcuLpm4WH0A==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xIgHX-000BBP-0V;
	Mon, 19 Oct 2026 07:51:35 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xIgHX-00000000vQS-0BBq;
	Mon, 19 Oct 2026 07:51:35 +0200
Date: Mon, 19 Oct 2026 07:51:35 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sander Vanheule <sander@svanheule.net>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pse-pd: realtek-pse-mcu: add gen1 I2C
 transport
Message-ID: <atWv5zeLO0puqrQW@pengutronix.de>
References: <20261018161248.376205-1-sander@svanheule.net>
 <20261018161248.376205-3-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018161248.376205-3-sander@svanheule.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Sun, Oct 18, 2026 at 06:12:48PM +0200, Sander Vanheule wrote:
> Provide the required data for the gen1 raw I2C binding, which like for
> gen2 is simply the gen1 protocol data with the native_i2c flag set.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
