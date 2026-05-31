Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1C3264EF
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209682; cv=none; b=DDUXcisT2aIqHzWMfAFdLlY9mCmazAMjUczsDqFDJ5B1dHCqFHMLMXV1fsrPNBYpJYS7b3a37Ism/L7lcrHudNs9Jjz36RXoGQfTUub7BIf0j3q2doJRK4SIm3A7tatmbOdhfhr9kRgXogKUrKlxNb/9jMHIR/FBdOtPFtdvkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209682; c=relaxed/simple;
	bh=E5gEPLQx9cpzN5W7ONfIcPen2Dt7/8tHReoBLt3UnNk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=RD5NxuX4ZYdhxwdZXVL5GPvXMt9FHIYAWXKBVLk2xMBmKFx08Pmq3S4gNr6XYDJddBYsX+C6ER8OzXzljJlgsL9b0Tf572lMOJG+rHwrJlt1Zqvnb5HYvLEXaR2mZXrLlayPWrLaCkTVchnuUOTn6aa/HxZUsH1VJFKJ8uYv68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dygoANOQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dygoANOQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B8E984E42DAE;
	Sun, 31 May 2026 06:41:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6DFE7604EC;
	Sun, 31 May 2026 06:41:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF26410888CC7;
	Sun, 31 May 2026 08:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780209676; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LbNGZ6gelR5q59MxL+rc95UdK7UypoRRgCJoC1fvkS8=;
	b=dygoANOQ5Kn+eGI0j+s5C3hI3IivIyUmp8XJuA1Y3lzaCaNl5ynrQupwG4RrZX/u13yahj
	SXICmEIMYWEOysXPNP4ZU0TF4aThO3ilqpysXaYsoQzDcqDbMf6kjfAq5XQvxLY4qZcumb
	N3rg294kP18zE0A8kRuIjfLHZb29jpNnC7GLB784k8BJ7VEhCUO9wQfqF6phHIY1/+2Gnc
	JaMc6MQwXUeNvDq//37YRARRtR5GcRG8VasBwy5wjGgM9l6dsjnT1ay13Lu6HSmuv75YkI
	bW+EcomEgqCxyP4qCg/+rqqdKxnJal0+MJ5NX46MjMTxFu2hCUuhAHQHxCRwKQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 08:41:13 +0200
Message-Id: <DIWNNTPN8ZRN.2HYJUO6WIETTD@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: fix ignored return value of
 clk_prepare_enable() in runtime resume
Cc: <conor.dooley@microchip.com>, <davem@davemloft.net>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>,
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260531051841.55311-1-kaneko.dev@pm.me>
In-Reply-To: <20260531051841.55311-1-kaneko.dev@pm.me>
X-Last-TLS-Session-Version: TLSv1.3

Hello Gustavo,

Your CC list is laking some net maintainers, how did you get who to send
this email to?

   ./scripts/get_maintainer.pl -f drivers/net/ethernet/cadence/macb_main.c

On Sun May 31, 2026 at 7:18 AM CEST, Gustavo Kenji Mendon=C3=A7a Kaneko wro=
te:
> macb_runtime_resume() calls clk_prepare_enable() five times without
> checking the return value. If any clock fails to enable, the driver
> silently continues with potentially unclocked hardware, which can
> cause undefined behavior or system instability on resume from runtime
> suspend.

Could you point out if this was figured out to address a bug or if it is
only a theoretical defense?

> The existing macb_clks_disable() already uses clk_bulk_disable_unprepare(=
)
> for the symmetric disable path. Align the enable path by using
> clk_bulk_prepare_enable(), which atomically enables all clocks and
> automatically rolls back any successfully enabled clocks on failure.

"atomically" usually refers to some locking mechanism, is that the
signification you had in mind here? Because I see none.

> Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

