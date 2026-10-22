Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792654456;
	b=AOGNCXvHV75+8wtRbgxDhKfQwS6l6yncXhEbXClzfJ33OtxdyP7ZKuqkUvAVGb+KYfQx
	 GmxjU6spfovqFkUYS8jOapfUxc/eFS1fiapbdi7vaNup5q1mIFaoFrE69tq3/OwJeUPGA
	 FIIz6TD7TOxllqvA3rXP3JYlegtjyBqkEP++wP+KN9il+RR1aWWPLxzTGsC4FJS26gwOU
	 2MWuoac0sKBKDw7SklOxdAsnz/N27UOmAJDxqqEKCda3VviguXnPbZ4Sm5t0N92+hiIHl
	 nriS/mjgEZyqpnll0x+A+UEAioEyLxjvdLJKjOjbBOfli3Pe5gSEPBNR9gpwuxjNhDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=xROOygMrC7yI0A+nFF4ZYUpCmGBkajWRjJ/AHQXTEQ4=;
	b=JwsB/wP4dcpE9Hmfwoplp2PZq5HO083qFxR+GDleth7CZfB5D5lacybO773CbyK6Gy6l
	 exBx1JUK9yne2BN1s/zZ9jQkDHPLbs70pJDdUlT38I+wV8v0JNHxIvr3Yc1F23RB0/pUr
	 10Zg9JXO368PUqs0wNcXH8r8SxKEDtjzXMShILnnxSGpJ1v0lPfwsa65J0uy34BXgJDri
	 v3asMOEEebpRgnWnJCUUdawzDNm8MNzWecSSxTNb5zfKP7YwlxedZ/jtSkVYHFidqcl/F
	 5zgxM5TpoK/+10WpjgPbFLzwZIm8h9NHOnxt1+Gs3RkAEaxdKFrTqlER6u8MqFEVIBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Gdj024Nn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FB606A319;
	Thu, 22 Oct 2026 07:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3FB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Gdj024Nn
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E1A60200208;
	Thu, 22 Oct 2026 09:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792654451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xROOygMrC7yI0A+nFF4ZYUpCmGBkajWRjJ/AHQXTEQ4=;
	b=Gdj024NnjPJEMCrSkozLYT9/WBzs9FO1ppOoT49t0QpZLCA0xTLzxP1EEZLbcOYavI/BMV
	YR/dlWITmq6Hjzp0AUBN6laD4H41EDyDFzkYWR1r87C6FyU8vKJcvhhNcXtVIQ89g6CVj4
	kpB8RgcOsiU82kgg71M1fAlmHZ+DqCGglsvf+Dj4kacIc81bkOOy2v5+dzcDFh23L6TM1b
	K8nTJ9xPTsHHq2hcTxiylI/5v1FDelwuRKfS2c3jeDRGsox486yu+AiMykmTcUOzbJ8q4A
	4m13khCmaUgfi1sn9G/o92UxQX7On5YVHjXndBwhnH5SLoI1cT8Mou5cgUZL8g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792654451; a=rsa-sha256;
	cv=none;
	b=K6tDTmGVqttjIvUA0277WHeDrW3c+DgDD27uydGhNehJBcJ8Gxv0S3C7d6OwD/qofX91Vn
	u8vVR53KchcdYnKixAgG9wHVSymtWBQSm2WcFw81eilE6g/MvSlu26bWJNv4Uxf7o6vnJ8
	skxSl5hmyaLt3ViGImyI6+M158H5948PNRZB+Twfl2ZF1AQcZPdaqBmWR11CtuRoTveLab
	hF3zX26qmlJGP6h2ny+ofR9lZblP1J4ggYdkGtGOMm2Pp7SmCAWFVhHis4BgQECOYWJ+VA
	OHCRpTKC8ZZE1IwV/qTv3NrzwkBWJ+kDNURLt6c05N0PwzrBS278tFFcYUGpsg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792654451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xROOygMrC7yI0A+nFF4ZYUpCmGBkajWRjJ/AHQXTEQ4=;
	b=MfEaOCMl7VqKc0pwv8/hpBfooUhVlnIPhn5l0aiCUHmHZ7kSWZ0A6PWlWzni8oB1wa98PE
	RnGd4kqB0nNCK0vwXdVwcoNi55TDTv/FdeS6DNfrw0OX0oL8RW1H4xzf5Z2P2dHH2iPzCN
	K1M2r13Ru1bl7pLr7MQxyRuZje1Fr8CndEHvPLMjAJbhYxqQ+/3uOCrIsXTD9bsB3TyMw4
	3N8OHflOeO22sAdmawTbjsw++AI0vlxnNxzYguzHJ6JZZ1AziGUiPViLoE4+373lSrLseT
	WEhjUqwXU8qm2Q4ARRAF/Q3NJWYnH2lu+TrowA945riRiNigqQ6Yk9RkWx0Vxg==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJnJT-000fgG-2h;
	Thu, 22 Oct 2026 09:34:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJnJT-00000009QzU-2zGy;
	Thu, 22 Oct 2026 09:34:11 +0200
Date: Thu, 22 Oct 2026 09:34:11 +0200
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
Subject: Re: [PATCH net v2 10/14] net: pse-pd: keep the PI data until the PI
 regulators are gone
Message-ID: <atm8c3oJomYY3RH6@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-11-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-11-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:45PM +0200, Carlo Szelinsky wrote:
> pse_controller_unregister() frees the PI array, but the PI regulators
> are only unregistered after it, by devres. Until then their ops still
> run, for example on a read of the regulator's sysfs "state" or when a
> consumer enables or disables the PI, and they read the freed array.
> 
> Free the PI array from a devm action that is added before the PI
> regulators, so devres frees it after them. This also frees it when
> registration fails, where it was leaked before.
> 
> While the controller goes away, the PSE core must not power a PI.
> pse_controller_unregister() now first sets pcdev->unregistering under
> pcdev->lock. After that, enabling a PI fails with -ENODEV, and so does
> _pse_pi_delivery_power_sw_pw_ctrl(), which pse_isr(), a priority change
> and the retry after a disable use to power a PI. Disabling a PI still
> switches it off and frees its budget.
> 
> pse_flush_pw_ds() also switches off each PI that holds budget and gives
> the budget back before it drops the power domain. Nothing controls such
> a PI once its controller is gone, and before, its budget stayed
> reserved on the supply. If a PI cannot be switched off, its budget
> stays reserved, as the PI may still draw it.
> 
> Triggered in QEMU (arm64, KASAN) with a test-only PSE controller:
> reading the PI regulators' sysfs "state" while the controller unbinds
> gives
> 
>   BUG: KASAN: slab-use-after-free in pse_pi_is_enabled+0x294/0x2d4
> 
> and unbinding it with budget reserved leaves that budget on the
> supply. With this patch both are gone, the PIs are off after the
> unbind, and a priority change during the unbind no longer powers a PI.
> pse_isr() is not covered by the test, as the test controller has no
> IRQ.
> 
> Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Freeing the PI array from devres after the PI regulators, and refusing
to power a PI once unregistering has started, look good to me.

Please drop pse_pi_power_off() from this patch, and the text about it
in the commit message and the cover letter.

The PI regulators follow the regulator model. A regulator that goes
away does not switch its output off; the consumer has to disable it
before it calls regulator_put(). For a PI the consumer is the PSE core
itself, on pcdev->dev. So on unbind every enabled PI should go off
through the normal disable path, before pse_flush_pw_ds() clears
pi->pw_d. The disable path also gives the budget back.

pse_pi_power_off() switches off only the PIs that hold budget. That is
not enough: a PI under hardware control, or under software control
without pi_get_pw_req(), can deliver power with no budget allocated.

Switching the PIs off on unbind belongs to the fix for a pse_control
outliving its controller, not to this patch. Patch 11 calls
pse_pi_power_off() from pse_pi_take_pw_d(), so patch 11 needs to drop
that call, and the comment above it, too.

Here "off" means what IEEE 802.3 calls mr_pse_enable = disable: no
power and no detection, as if there was no PSE. pi_disable() does not
do this on every driver today. tps23881 turns detection and
classification back on after power off, and the core relies on
detection staying on, since it also uses pi_disable() to power off a
PI that stays admin enabled. Fixing tps23881 is not part of this
series.

pw-bot: cr

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
