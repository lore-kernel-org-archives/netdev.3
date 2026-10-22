Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792646033;
	b=G3hXnxz713reaoLxaumZHfXHFcHaCE+U56qXILF+GrNRVtvqCuV2e8nT5MlJM1Vd419s
	 H9e5npgfh+KAAvPBCUuR0Nbw4tVX5Mwej8kkCGuu2U024PxrC7sejRRviS0Rg1TeogIZH
	 RNMvhbgr5wzA5JWmqBT6tWKD5gqMMgmcYPQW2XF8N/sXsxVkpF9Zpg1600ov74fG/ecZJ
	 qCt7AnTxw1ZarNQnWoKk/mlwTFzSx+rGetsQy32oAKruguHVa8ouImP7PbTH7kcPkc5iP
	 meOdii/gdtzo1kCfiqrrqrwzyo7ONs3r28Y3WTL/oSOYPKqh6IHErU5mHVOltdEe4mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646033;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=kM5hLomAlXMbgEq6K/ztPMcKepXPs6JaIWjAwYMbfC4=;
	b=4YhMcRSJcnSLwp5LqKICs6sBJ4qyp6iiqCAXwERkJaKEKsM984Cv3bWf3a42hsqEQKAl
	 QqtwNUIRKVHe2V90GaMR51jTWUI7d+LxoBodthGXGOTYviwmXub5ojvEzzf5/fKlOAfgS
	 wX5hQEAe8DCVD2XvV1rtETg9dTFMu49hWVR9xRejaeP7j8ptYRgULcAf+HEilJVvkeZ01
	 87YjuPw/iqNtyP9IM41Nelygx4W/o8295EErlX7w9PDSQAEHLACa6vOw7ObcF4ExytFwm
	 XF41LRzDDgHooD6MP567pgUGu/tFyyrjHEqcX7R3MB1I0MtiAv7MUf2H87ap8mFc2+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="D61QvE1/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B20606A319;
	Thu, 22 Oct 2026 05:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B20606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=D61QvE1/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88BD52017C1;
	Thu, 22 Oct 2026 07:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792646029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kM5hLomAlXMbgEq6K/ztPMcKepXPs6JaIWjAwYMbfC4=;
	b=D61QvE1/2baMZeCOTG3Yj6l/GK7mVx8vcZxvh5LXR4MNIliAK9UWejIi1uLbNnk65VBDPJ
	GgM0sRCYTXe8eJUBzq7SSYFPUPRLHWCm+lrFjcKuN6432B5ufNBHkUmrj6N7Cx9JOY+mce
	miZj4KhVrdnJGSrKRZtY9wAGw9t0K1Pu/CoFW6rp+ytnEhX/1gYI6U66dm3QWE7cMHxGgX
	RDDNIefRxqieVIvQMK11GWNvAwkY9qhMcoCILb14GtSRyFSaEmuKj2QgKVmccZXD8Du7j6
	PYRmOzngXDb2YibfuOgVYZ38ryHeVztAW9m521o3qc8RGJrEMwLzc9jH8VXyBQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792646029; a=rsa-sha256;
	cv=none;
	b=T/BFzQKKbcgRnY0Ocj2D5MQHFl/3FKeHyaXs4gEI70Efxw25sxBlGzTi7B41xnfkh2BQNp
	aGyLtBizXcCHH5NLf1aUHu5zOxyQca4Q7pg4sWPA2aaD9bEl0HGoGHZ3SVkw1dzMpm0KNY
	tfEti5szpVDIMUyPGCp/vaXql/P9XrKXepOcKv4jSYeC7TT9isH+/qAYRVlfpBcGphB1TN
	Q41AC/7R+2nR8LLx3PstJce6jNZFxfVlQ6wlT3bqc0kmfwhomzsTy3hKmDC/SMo0YlC8lu
	MpPyQAKnUr4RvI7KF8/3ZuK/riY+eTpYVuY1oqzKXtUbZud/Nf//O3enD7ufNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792646029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kM5hLomAlXMbgEq6K/ztPMcKepXPs6JaIWjAwYMbfC4=;
	b=evwTAmbpYPgM4AOHW8FbmU0N4P7jpI+4+GxuJTbPWzAfJTAo0YChTyEvWLzfhuEWNpgkIm
	2ZfdZSH5nnmexxa62N3mkEVG8Dd7q6qKEc/NqctmoLqUgyE4XzxQQUXxXSrEJKaGXAgsTH
	HGMz6pam9YLg2MXSxTXDfTwcOgz5fOvi/JF+zY0Nl3ZzghiZTGw8Ncv/9xFfvuneor40OR
	GeqKEdEMBdm/Gm6kM7CkrUtFkOVDjdfNbZxTuo8hKpLsV3Zkw48DvuVrYbBNKaz3FMAKLc
	K4a+uefUZAsaWzHyxXOmjS7H46iDp1IeDldCWcybdokMYhWodCaN8wx6cr/iOw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJl7d-000ew1-1S;
	Thu, 22 Oct 2026 07:13:49 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJl7d-00000009Poi-1Pcf;
	Thu, 22 Oct 2026 07:13:49 +0200
Date: Thu, 22 Oct 2026 07:13:49 +0200
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
Subject: Re: [PATCH net v2 07/14] net: pse-pd: do not tie a shared power
 domain to its creator's devres
Message-ID: <atmbjbxVUCXRq-3m@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-8-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-8-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:42PM +0200, Carlo Szelinsky wrote:
> A power domain is shared by all controllers on the same supply and
> counted with a kref, but it is devm memory of the controller that
> created it. When that controller unbinds while another one still uses
> the domain, devres frees it anyway, and the other controller and the
> global map keep pointing at freed memory. The same happens when
> pse_register_pw_ds() fails part way.
> 
> Allocate the domain with kzalloc() and free it on its last kref_put().
> A domain left over from a failed pse_register_pw_ds() is now leaked
> instead of freed while still in the map.
> 
> Because the domain can now be freed at the put, pse_flush_pw_ds() clears
> pi[].pw_d under pcdev->lock before the put, and pse_ethtool_set_prio()
> checks it under that lock. The PI regulator ops and pse_isr() use it
> under the same lock.
> 
> Triggered in QEMU (arm64, KASAN) with two test-only PSE controllers
> on one supply: after the one that created the domain unbinds, binding
> it again gives
> 
>   BUG: KASAN: slab-use-after-free in pse_controller_register+0xb98/0x1274
> 
> With this patch it is gone.
> 
> Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

The power domain lifetime changes in 7 and 10-12 build on each
other; if there is another round, folding them into fewer patches
would make them easier to review.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
