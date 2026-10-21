Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792559946;
	b=Smab6/GqDW31MG008jSDAe+pM+IeSkT4VYP67i/yk5nrvR0JHJ4VPlGFzJok0ipH/ewW
	 D6r5LOey8BElnLONZ51ezAdZI3mHdn0/QhpZGqCv/yukqbs5bDB5qZwBzBwwHl2nfdMb8
	 0WUwRIkjHuoJj73QickLAMTfDNeL7c5uIoGKMi2U3kNXBuCv20AyhWCr25rEIzBzQfEh0
	 EUBaLvL1iFewI1dBjjIkdJKNQcOWrnybNA1xWXwnE4h4OY3EAQhX4OlXL5BJdqViI5KqJ
	 hsafSCFqBZ1sHitvyG+0CIJmW0VMwNeYmtNaG4O4aXDmiNGLzNiuNPvf+FA3GkYAPvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=fjNBLOC8/lFhsuRpyAvpKZg7iYi9YIo1rRFHD3mht9Y=;
	b=euZtoRW0OYhDFgW/WRyuOAgWK/oqVsuVsX+pbmxdXrtRt2mTxAxKeclI1zSrdID9jaQw
	 rv0xu4QDT2RneWrXzthS/SXjWJfY2W8GEJhJVttxxFwFs/1vcjIntVRz0aPTasu2tQuyj
	 bvILcMgETh8OoYzNqPx2WMtKmotK3YlbJIRqcUMGNuFx9KVLjsxiQcX2LvW40Z51HHnci
	 qf8h33XvfwEM8hTKC7UU2xaN9EW88MK4mWPsO91b520S+kkHn61uf7zesE/lVTDY1iX09
	 kfO0sDNR3GEwM4XsQHXghqpbtBzm812el1K/etsxvYX5mMsL91Sg/l5iVB7Q9DxG3GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="SmfYwEN/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64761606A31B;
	Wed, 21 Oct 2026 05:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64761606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SmfYwEN/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2AE3B200F60;
	Wed, 21 Oct 2026 07:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792559943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjNBLOC8/lFhsuRpyAvpKZg7iYi9YIo1rRFHD3mht9Y=;
	b=SmfYwEN/VxYU6Q8Xi3TDsHcZGdbyv+StCgQu+mtfsg5V2Shq+Mac/pdN7/3I2zgKQjjWAy
	fzJ78E5Ir9ENF35OV650gCjautFQiktrJa/zmQmBh+dQOwizNw6R2D0/v9qQA+GrCjK9vB
	aD284dxX6jB+zE0Br4NCRoFY/l4iil3KA/EA3mjhiK1W5XR1QSH+hZVjTE3S0S8vsZJXJI
	x0aTdzrB2vjyOtJAV9E8sdzGKOBPFANzJx5L9461xxz5CPse7iTGqvXCnLBdqaefrZzt37
	dBedSaOxR/sJ+Uy6LM98LhvNf9v9C7X6+et6FovQ6R1RSJaYzvBzsGnLZby24w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792559943; a=rsa-sha256;
	cv=none;
	b=A9cj0P1xcieRqeK8w82fpYWM+f5xYmLQ1YaSpg9gQplWmwzdnOK4m5UmxMtI9QXj6IhwQJ
	LLfSlxi3J4tJq0F23DOCe0Amq6K2cE8zCgSx0jK/XuSRyR8oonXACQ2JrZz3KgRAv+0o2N
	tztPX5gwHhprtcskllJfa+lmuU2BMirJdONvjDnwLA7NulBLx44/7QNq+v08O2f2OT7yn1
	Iol4uHbCieRn2ePpexKv5Me2qGe9QiAAo8/GMiBRfUWNpvmjeJPm/ly1XX7JuIFpy3MNkV
	kg2PhRM4ArrPiTzRuh/tDjm7E7+VtOczzQEWi3WEsbfhAJkmoa6vURYqb97pGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792559943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjNBLOC8/lFhsuRpyAvpKZg7iYi9YIo1rRFHD3mht9Y=;
	b=ZiP6hK7hJEQNIOH1wZkUxh6Tn0MnaIEyzXrllU/8iAIo8ZaNc6GooGeurKLZ+WchKlUUNo
	bbS0KhHDZsIHkw8Hz2ap194FJGmBKUnJbRe/bVnrQ7kOO3N5d6V3+fZ8g3rrxGIG5z9FZa
	E1UjIjMtZiDR0NicNZoRZ7OoqFeuh2W+/Xq6tSEahvwUaSPegChH9nvQbPb8jjQBQZv1/W
	2V4RqZOf/PBIGKnKqZYhDUAPfPB/hrYPReow5VISGJoTqGX/TBv600xB6EmndM8ExDiyXP
	3LExE/lw/o8i3SA9QHE9VQf9J0QymQFrx1o0jp61VazK9dNE467jxhzrE5jiWg==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOj9-000Vlr-0H;
	Wed, 21 Oct 2026 07:19:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOj8-00000006d1B-42iN;
	Wed, 21 Oct 2026 07:19:02 +0200
Date: Wed, 21 Oct 2026 07:19:02 +0200
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
Subject: Re: [PATCH net v2 02/14] net: pse-pd: remove dead
 pi_get_admin_state() checks
Message-ID: <athLRgaOp0gy5II2@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-3-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-3-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:37PM +0200, Carlo Szelinsky wrote:
> pse_controller_register() already fails when a driver has no
> pi_get_admin_state() callback. So the checks for it in
> pse_pi_is_enabled() and pse_control_get_internal() are never true.
> Remove them.
> 
> No functional change. It makes the next patch, which fixes an error
> path in pse_control_get_internal(), smaller.
> 
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
