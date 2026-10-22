Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657265;
	b=0Il4ntSTv476+2Y3cnKHL/8YrOYrxuoZDD0jwxHv01yWjVDBfHLm0EOKWeK4HOg+xf4+
	 U3y13I0TEiUmIt9nZ+QRUrbx/5XcOAvvGZQCPXJm70yRRhjktN73IWc3ocQeq2JCgT8oQ
	 C7pFwceJ3cG5xxOk58lqziOLnm9co7IA2iaGgkxZG7e++HZbn7l3dJKQ/+HuV1PVqnkJD
	 0+ZQVlfoH+h/xlUJu+r/RtoVsY1padZlOdTIAaENH7SBw5cpsMO9GCaQrSmHKeWaYiC4u
	 wzPdw3JT4E33laIWMuvxBXNFj2xuJHD7f9d5MbSOfA4n3/h3mT9NraBUP1TEO8glqPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=vQw780fnK2+GGA3/S3RVInPZ/5Hnzu3X3H2xLsK6ygo=;
	b=Ss2c4YTZbLQwbPN6KUfjsJakCYOF3NlFSw7horzNZC2ydthr2/abZkDo0OniEn3cfGky
	 1thlciV3YluYmLf1GGC4JpOHksORnWDULwPj7zZHODcke1bHWVrK9GyywJhnOkQ1NjF6W
	 ewXJg0rgZBGE/gIOoMqO+MqSRezWP9EccuUPvZg22tawdwDhvEGfmoEV6VOWn0AqgOjuk
	 IkdtKlhufw7IIflxtD2LBHDGD4rQf4Sgjb6psptQG87o5kmgIMrD3mf5/wjLFCDwjWDTV
	 CQQxdzg861cOiInSeL26e6ndegmBw4MiL1aQjfFDSa2yv5ixjgjnl/qfD6bxpX7uFMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SMdzTta+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF2606A31B;
	Thu, 22 Oct 2026 08:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SMdzTta+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 398C72004FF;
	Thu, 22 Oct 2026 10:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792657262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQw780fnK2+GGA3/S3RVInPZ/5Hnzu3X3H2xLsK6ygo=;
	b=SMdzTta+XYflBlw900ldTuFfUPZjqA/sk77hkzKwMLOJfZ5OkxxXD8uqBnOE0s8BXTtGng
	OrKcqIWz5HUr+ZD1+8YeSbbWqFET03pGqiwwhdzdnvzK7r3FTbYGydC0UxJcZ96m8sbQ1u
	Ap4OyikoziCVKNHXSK/Wzt8Tly/aDb0V6sM4C2BRNXzLwJdnNSCKfIoV2nkQgD7ITgNup3
	xtseRF8KkK2hV6HlTgB4WnempN3KxtrsFztEzQZkx4dJZ+AksCYyUbRR8weKyHlxO5X/+Q
	vt+QTit7nD8V+GK1g2nywEmwW7OLikZNnV/2A38t27GSOqo2Bd8YatRwAu+qFA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792657262; a=rsa-sha256;
	cv=none;
	b=Ieoe7gMUTG5cOQtwXJP2D8TpH6eXIHu3GuxhJgEBtf98BwTMFNM6dK9t5IHSPF+M5qpiIn
	45tmzNAExc66jbto/O3t5z475XtwSjyF31Qh1Ipbd9wzi6Bj2O818d8dxGlvqIR5KW5l74
	wiJhUAQC3kpeYrTA7ufd7YHjV2zA9A4lWhJ48DXq+C2FYzzNdlaMJy4nZ3W27s7k2p/Nu/
	sIVmFyBskHe18LBBDy49vGLH3n7Il0zio8IkDIf7nWOtyR3XY5gxqWTGtvU+hipIkpvxp8
	XC/xVYBsfcuDdNDbRHoexI/oJXivmewFh0R69qdm33OUFpV/Zd9w3pGVScO2bg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792657262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQw780fnK2+GGA3/S3RVInPZ/5Hnzu3X3H2xLsK6ygo=;
	b=e/2KoHJC0/jeMPmUeOwajwbnQjsLMwMFCfaSy9RwajuHUMO7N/qr2lvituyqqDKvaWxfVM
	WNT5FkDT+Uujyy4dkqhN1knQ0TpNnxHAKH1gkv93vrAwBSuXaDti73nUSdUMtfv9NZZPBS
	pu/txVwcFlZuaeUKo1qKjIGFjGOX+50AiW80M+a+qzlMY3xl59obNToeWzBNvxLp7CqdM2
	S/G/NYHlQcjgTv85mpOwdElH1V0EDfmCCeisBLQ7UyD8QHtCEg5g3qR12zlnjMucC4ceSO
	u/KbX0CVnV+ZUOjgrZCP9htFghr3S7CdcJmDlM0KfdIwPf647MMCYRd7yyQ+GA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJo2o-000g29-0U;
	Thu, 22 Oct 2026 10:21:02 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJo2o-00000009RM4-08DS;
	Thu, 22 Oct 2026 10:21:02 +0200
Date: Thu, 22 Oct 2026 10:21:02 +0200
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
Subject: Re: [PATCH net v2 11/14] net: pse-pd: unwind allocations when
 controller registration fails
Message-ID: <atnHbhdUejaCw1AH@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-12-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-12-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:46PM +0200, Carlo Szelinsky wrote:
> When pse_controller_register() fails, it does not free the
> notification kfifo. Worse, if pse_register_pw_ds() fails part way, the
> power domains it already set up stay in the global map. Their supply
> handle belongs to a PI regulator that devres then frees, so the next
> user of the map reads freed memory.
> 
> Free the kfifo on every error path, and let pse_register_pw_ds() undo
> its own power domains while it still holds pse_pw_d_mutex, so no other
> controller can pick one up first. The PI array is already freed by
> devres.
> 
> Found by code inspection and AI review. Triggered in QEMU (arm64,
> KASAN) with a test-only PSE controller and an injected failure in
> pse_register_pw_ds() at the third PI: reading the regulator summary in
> debugfs then gives
> 
>   BUG: KASAN: slab-use-after-free in regulator_summary_show_subtree+0x770/0x9c4
> 
> With this patch the failure is undone, and kmemleak reports nothing.
> 
> Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Besides the pse_pi_power_off() call (see my reply to patch 10), two
small things for the next version.

Helpers that expect pse_pw_d_mutex to be held should check it with
lockdep_assert_held(), not only say so in a comment: please add it to
pse_pw_d_release_locked() here, and to pse_pw_d_leave() in patch 12.

Once patch 12 removes __pse_pw_d_release(), only one release function
is left, so the _locked suffix has nothing to tell apart. Please
rename pse_pw_d_release_locked() to pse_pw_d_release() in patch 12 and
keep the assert.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
