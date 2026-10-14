Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E281547074;
	Wed, 14 Oct 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982276; cv=pass; b=BdZCO4c8feBHSgVxPUMc+V065GVnIEUWrhWI6VgI0HTVqK978cn/1AXlBRhAGop8FZg7fykQa3fVIZoVMr25XSArv0+JpSSlYTOZYoQUZuFOiY+r0kqGTgaW28cAhHVZfeYM30zezoXEYFrSxfS7kp3DeDV6cJDwVzz9jMi2am0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982276; c=relaxed/simple;
	bh=H/2d4K7/Lf56hDtWv9roCWIcbiOjibyU/THoWkqIkAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmSNoq+lzaIjpsV5x6iUKiRD/4UZqzsQ9rxLEw6EESQTqbq/hrrT2igqCBcw9e3vd+LFrUU6pfp0D5pAVAHbWrrTp/tu04eX3LHofJRdhZEmw0/2BKt0xj3HY/mnpOqv7eVSg8yBusjgEEFSOWJccBfH46RLnDdcRQU/9FmLjW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=cjqHWt3R; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="cjqHWt3R"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1835A2007F9;
	Wed, 14 Oct 2026 14:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791982217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MP2JeH09b8yfeOJ2wb8tJCWkLEoHvIyf00IlBonB74=;
	b=cjqHWt3R5TNnxrdIzHfyijTlHdZyJ72bZu0CcXsdF1TsDCd0meAdE0VrnLmOGuFjP3BAdO
	dh0/4fi/bZHdu3DRpsiGxEINwpLkvzoQvkGm3cqd7ni45xldEQL+Ql/q9OOK5O8l/xXncn
	AbTNXweJpZVm8d8UC2yGZEOiDjE5XciMcXFxj+V/ttVSpEyX9XdSo81JouBpLtD5d/X2BN
	9940afo6zhV72b4j8rcn0pZghdu91PWYWGf7YXP1GtoNS9mCX7OhVsiugcsYmxdBBQNCeB
	7NpE4jCYYyPXE4n34W6hpujCPJvNIeQdrHa2rp7OxbI9vyX5QGh+cmwmQb8+4w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791982217; a=rsa-sha256;
	cv=none;
	b=YWNE/P00g3kZew9+GiEUyQ3qmKDyTY/zPGtpgqoqALoaaWviXZjMotMf8KBHni7pk83GmL
	B91mHdCZpiTAFBy0bzVh0sejxHdjF8e0wsQ/g7rBHhg9owDy9B7OI39YQUl2o966IfPRTz
	F8E4PXu3wQbhnEja8+tCsS1sVkw3K6yCXXf0qxcyhhEe8Rm6Q5ziLL/fB6LVxMAsIEPUgL
	7oogevU/yBeRXAUNJW43aKhWs9mF6eLZwijcNVuMC8bZvocyYr+dymBXlvqZKP0blV/8kR
	3QrfbRni5eMGDX8f8nqvhAJl74kw+VUjPtXvBJe/zaS55/PtO98HsqSG45Txag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791982217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MP2JeH09b8yfeOJ2wb8tJCWkLEoHvIyf00IlBonB74=;
	b=BZBMTgBAK9RvTQBlzbYnQ7wUGKYOhJcc062TFeDDjkOU9QA/Xqc7c8bN7Dx7x+DX0SuuI4
	r/rAspt5PuxW3iWMuvDCySd0aqr+MWk/ZQSRMI7V0OvI8WVB7HYny6ArUUD427bzWW/F27
	7O+Yr05FTkhsLylqY/xnFXb+aqa8QcfuxCxlfM/O4ycSAvMBSjOhrsqai7ABveIoNYE9r8
	8sMHMPFDkzsy1+GEaVL+EQbA4Mi0sLLNpcEJEivA2pSIvima8LldlSMs/GcySj8ey8MUmV
	Sb2z9WEvR8J6c8VjgcrLhn7r0AgqfCGnrY8D3v2AKIOn1lWXTbgDRxSrXYtKOw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xGyQy-005rCm-3B;
	Wed, 14 Oct 2026 14:50:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xGyQy-00000004j2H-3e7z;
	Wed, 14 Oct 2026 14:50:16 +0200
Date: Wed, 14 Oct 2026 14:50:16 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linusw@kernel.org, luizluca@gmail.com,
	linux-kernel@vger.kernel.org, edumazet@kernel.org,
	kernel@pengutronix.de, kuba@kernel.org, olteanv@gmail.com,
	alvin.sipraga@analog.com, davem@davemloft.net
Subject: Re: [PATCH net-next v1 8/8] net: dsa: realtek: rtl8365mb: offload
 DCB DSCP-to-priority
Message-ID: <as96iN9Rw_FI49Ey@pengutronix.de>
References: <20261002115850.962676-9-o.rempel@pengutronix.de>
 <179129420724.434549.17466133665783916588@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179129420724.434549.17466133665783916588@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 06, 2026 at 01:43:27PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] rtl8365mb_port_del_dscp_prio()
>   (drivers/net/dsa/realtek/rtl8365mb_dcb.c:410-434) decides whether to…

Ack.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but setting
>   ds->dscp_prio_mapping_is_global in rtl8365mb_setup() makes it…

This issues is for separate series.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
