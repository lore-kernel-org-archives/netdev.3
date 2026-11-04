Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805592;
	b=Hz3367k+KQU3hwg4GIbTMLyJyaIglCMYklrRG42bjTin2iRcZNnWjAMgkEzvvIHkGr1U
	 eBA8pestW9CNoWv4CbsmDjNN0Nk4Dew7GL5IacUrJUjfKrdTSZR9R0lTzIaiVkadDwpIQ
	 6jvMXoLPM9ySPYs6W9Ihw2lOZ3oGNiCcD6t5LLY7JQk8+Xm6iV41j+EpFW95FGQxgdI0p
	 o9I1uuLQSiNJX0vjxu5nvY2Yp6QvDNPWqYOrMgps89XfGpa1qkuC2fHyBbM5CybCQYqFu
	 Mb+csPWVZKQWUqWpzQW/+GV7b783I+AN+cSq2PpsN/MaKS3OBtCulQE2uoudk3kmjfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805592;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=uihtsJmBzcUKPYH3NXKHjIRc9b1zQVK9CeOkn92FZaI=;
	b=iA33VZI2q1FM6ffR0fOX5YVqnZa9psinVlR33gmWE/PCEHgxQ4QYprcH3nGAkd1IK479
	 0cL/65XIi+b4JfN1INxev6FfWtgt8K5wSpAOGyiRrnAEi+fApT9nGxADVD3dtD5vzt6o4
	 77BsToe+MUpFiSQ0GzUQJzZ7G0dqaQS0yZo9Hxv6gDZAoyoYW/MDR5FhK9FDGvIMFwdBZ
	 AdFjBawiANEqURoJVmIkUMoYECqhX2cgfnXFmDow+hkuVb10JqyVTF5XC+OAsQwoV0T6k
	 KtLDIoG5l63NEVfCGhwM/EDpqnlKXbyiNlsEtEg5V3u1lQDPufwWn05E9VoF4rq+KQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WpVgtqPX;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DE606A31B;
	Wed,  4 Nov 2026 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 260DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WpVgtqPX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B4E464E41404;
	Wed,  4 Nov 2026 15:19:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 890B760770;
	Wed,  4 Nov 2026 15:19:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EBB5103291F6;
	Wed,  4 Nov 2026 16:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805588; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uihtsJmBzcUKPYH3NXKHjIRc9b1zQVK9CeOkn92FZaI=;
	b=WpVgtqPXld3uu/IzYAPJTGaju4b84u/BoAaijRhnv/N4ys+CnXMUWGX5AfbxFMvDP9XUfZ
	JighGjsstm5qMgV6zY7Jv0dz3TvhvEvbddfwP7KMTgUc45rdjTCb9zzBWLtbZvqQyM6AW0
	Ia+n9yiEhdVWQTRzFUPgO5jxMRt4eFOJ1jv//GOcCE8Htj2XiA2tqFIQAGVHLL6umCy1K1
	WXvYsxpk/Lmkzcv1nojS20jDk+oeXPZl6zwlGaPjH+aq4Mgftso8KVX5EAvQ4T3C0dD2Kh
	LjrnN4GyNvnJv6PIisGhJOL7elCLyPf0IT0Tay4MQG+zndk0G85AZbOLNbIHhg==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 02/14] net: pse-pd: remove dead
 pi_get_admin_state() checks
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>, 
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103220217.1131971-3-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-3-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557477.1333589.4339353994429689678.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 23:02:05 +0100, Carlo Szelinsky <github@szelinsky.de> wrote:
> pse_controller_register() already fails when a driver has no
> pi_get_admin_state() callback. So the checks for it in
> pse_pi_is_enabled() and pse_control_get_internal() are never true.
> Remove them.
> 
> No functional change. It makes the next patch, which fixes an error
> path in pse_control_get_internal(), smaller.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

