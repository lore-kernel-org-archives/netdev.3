Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792655234;
	b=fUZwCdQbb0H0JPnOpFiJmtcsYyBFGCVVoLrdiQ1gSHoaLf4sAtQO1k6KCWymWrs/yCjH
	 2pnUfirtM9nKMq2l+jdTuHUTcG54iyW5kq/e4+XcAeowClCyFUYXkf3cOPDsZkv1LiTuN
	 DCUZpyjVWIUIhbSuXWigXgwJhkOvOLUohbD2EPiDWXkM2zEe9Z9J+MnydZlNw7la1IT9J
	 5b57vtQPyAXLs7dU0CHr6EH9DtNlrA7Ypz2I+9WjUVqXLEfl6lDjqwtfcIsdlmeQzsaeX
	 IZ/z3sHFGqtdAo5x1Jxws4JKwed1++PxlbH87AiP3YTpw2yzMSBwHiXEzTymTY6P15Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655234;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=+BbNV4BqiEr/2H0FdCmiPOL6zTitlHPpnUkXuLtKcHQ=;
	b=JYtI/tAaKOV2HsS2nGgCZ2IN82SZ7sUhB1F0UZdC50IJCexdFpSc6QXBREtMnnAuT86N
	 jz5N/XW+q1c2p8Q2RL/rm/19wsblJW3iRtCDwp2FElr5TnylB8wlAL4rH18QmOdAADmiH
	 JXGCekfHWyjAAWzcQHIUCQZx2cOehrGghCZOPsVVHm/pJfhojP0ukgiNySPoybFef9Kz3
	 JTdjWYZNOSyxE+ETkEGUL64l1z0yw8mqNDToiebwooeVkQm2R9kKRts2ersCQuscrK5Ky
	 e5aP/BZ68bLPp68IBFMBNU5kmchZJsXXKOJhjpTFO0Cl4ZeJp9fHIDP5PToVTLwqO6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RbasnzTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A543606A319;
	Thu, 22 Oct 2026 07:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A543606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RbasnzTA
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 39CE22006AF;
	Thu, 22 Oct 2026 09:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792655230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BbNV4BqiEr/2H0FdCmiPOL6zTitlHPpnUkXuLtKcHQ=;
	b=RbasnzTAioGLXfOudxCDWKQjx3YOhZ7PiBZPLB0sSAge2zcxil8dwivFr7OjmYPHO18zr5
	5zqd02ZFPK7jtMG+vD6xcfmB3MyDla92th/63xNEenI3OCJStk5mjOhMNo+daycnKJ8C8P
	h7N9dFFldkb4cDz0RdR0TyzpXGw+lzDaPUCmFvhb9MwZRjxfBgTltr6UB1T97DJ5CZuvxF
	VprA7t4t8TGJWrGFu7LlbzCvy5X+bzuOQA5UY2o9XvSDlL8b1LqkfrkETozyOvZ4AbbAfB
	s89hE0WXs/5mFzpOT6IXintVQ7FgJPTQ8tuXN3gzwBRf2T+q4V4rK3xFVheiBQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792655230; a=rsa-sha256;
	cv=none;
	b=RvslJXTj5OwoPxxXIB3UIKjerXmDXWgqppWCjeRXCJBVUL8u9Aj6XZetEixVwoT16och37
	+uTEDI73oLH+2zyl74V5LYotN7DPscFJcrdhQHMbLEpdKdnOosIhsV4iZo9bRwOMkWQnKr
	yr9H14QP7mN3W0ci0uTDU6mhARpsC1Scyr6gojghZNq5nVZLZak9ytQ+iypGM9NcHHAobA
	fzTyFwpzK4g6zLQNHL6VfoU+HJWsKqaqZJcuH7SHKpZ/SH1vf7m4yCcXslvChlm3xjSlzr
	Yp8Ao4Jo7wW64qH80yB/Zp0P8fCbnzXsIAJrAJq/T3Y6hdUq/Qqd8EjHmftHVw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792655230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BbNV4BqiEr/2H0FdCmiPOL6zTitlHPpnUkXuLtKcHQ=;
	b=AsKAdeP55X19IAgcz6MkuUpCumkEwO5NYbY58xG9j0aMKhSuD+zCyfOJbTQSpZFwGuxOua
	6ZuHts2V4j7Uxd+uQFYlqfJqzJXlaVwg02eHchkvagVALtYEyzlMNoq4OcMtEIn7n0mgxW
	V99esmFZ1+aqYHwsBtgMUE+5efIjQqM6xiE/cuP8r3FV8B8Pel2d3pcRfTkFq1bWakuVOZ
	9tOjjdkc1YZY+GiMKCa8RjZavt+Z4FYAZlCdlCrvRhtd34E3+NW73hT+qWYoPoBMsqhPtq
	fgm4Dt8BQwY7l4aGe2AoAmfeCqd5ZDK9nG0qAqfS7paTgjIlvUUY65knFiZoLA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJnW2-000fl2-0U;
	Thu, 22 Oct 2026 09:47:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJnW2-00000009R2D-07hj;
	Thu, 22 Oct 2026 09:47:10 +0200
Date: Thu, 22 Oct 2026 09:47:10 +0200
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
Message-ID: <atm_fvCOBwH1S0Ry@pengutronix.de>
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

pw-bot: cr
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
