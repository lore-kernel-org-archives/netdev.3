Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354E27A91D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414465; cv=none; b=QZ6firhFQGAIgVElolALfGp7hwtSRqb5myXLLx3zHCUj1wSXjmXI7fS8hZKyt/h3RffKYeLAFZ4NRu9gcvDpGHjckEAqfvPSbmaS9xezaBqhtv3pkLq5PUhQrBlNiAD53G4em6LerlfmatHv4niXJzVJlI4SzuQ63Qr2faUBVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414465; c=relaxed/simple;
	bh=B2GUgzPTNy54clbuUCxzaz25RpkwwSruTJY121Tw9Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTKPYuFIfsmadQ8/UCt+uUpt8+FWWl+AVxI/1J/di6MAak/KLdqG5yzCAHH/FtLCo5PfQ9gcbbOaXcWX28qC1t0goYMMT3lZ3MnWYQtLLem7+KTqYncDvhzXmzEy7xe5GLeIqsBwDYZP4Tw4hro0nOBsy04qXC793HPsIaEa/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cj1wAzUE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cj1wAzUE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AD58CC5CD5B;
	Mon, 19 Oct 2026 12:55:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95CA760582;
	Mon, 19 Oct 2026 12:54:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08C3A10328D3A;
	Mon, 19 Oct 2026 14:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792414456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JlDxtsRTfq1hqwotbLBzp6DUMYkjTm9QlpaKvxmGYws=;
	b=cj1wAzUEc24ReVXM8RAGb65d1VZbtT9YmMe9l1TkqN0+LQq55mw1VGu1NfaxOhTDhsJp/5
	SIMFIPHpNySGOSgfyTqFvxOmEBhrmAyGy9VmQcMVqafnpo2lOn9++vNDqlCjAeEb5ZvxqI
	NOfNqRmoWufsEGptHLbRrfp1d7NF+F85KoqM7RC2jZzKgLHmKI1RkyxsVGfFZIo0nyF/bS
	Wv8COQWQ5E8NjU5F3p0lhZ1n3HKkmiZIekYB5j3D0gU/jiE1gYel64APSz+4FOGsijyFJ+
	BsvGnZ386lla8OCubJMzymqXNkYD0AZ8e70xIXxAotBL7KkBf+2Zshg0c7G0NA==
Message-ID: <c652ce20-a3c7-432b-8bd1-dac902f04149@bootlin.com>
Date: Mon, 19 Oct 2026 14:54:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next 0/4] net: pse-pd: core fixes ahead of the
 controller notifier
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Corey Leavitt <corey@leavitt.info>, Kyle Swenson <kyle.swenson@est.tech>,
 Simon Horman <horms@kernel.org>, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261018081853.47484-1-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:18, Carlo Szelinsky wrote:
> These four PSE core fixes were part of the "decouple controller lookup
> from MDIO probe" series [1]; Oleksij asked to split them out. They do
> not need phylib, and each one fixes a problem on its own:
> 
>   1. Unregister frees the PI data while the controller can still be
>      found. Take it off the list and stop the IRQ and the worker first.
>   2. A failed registration leaks memory, and can leave freed power
>      domains in the global map. Clean up on the error paths.
>   3. si3474: use dev_err_probe(), so the deferral from 4 is not logged
>      as an error.
>   4. Defer the PSE driver's probe until every PI's vpwr supply is there.
> 
> Patch 1 conflicts with the pending net series [2]; keep the order from
> patch 1. Patch 2 conflicts with two of the net fixes posted alongside
> [3]; the note below its --- explains how to merge them.
> 
> Tested in QEMU on arm64 with KASAN, lockdep and kmemleak: controllers
> whose supply never appears defer, and an injected pse_register_pw_ds()
> failure is cleaned up and retried. The only KASAN reports are the known
> stale-handle bug at MDIO bus unbind, the same without this series; the
> decouple series fixes it. This series, the decouple series and the net
> fixes together also run on a Hasivo S600WP (hs104), with 200 controller
> unbind/bind cycles and no warnings or leaks. Every patch builds with
> W=1, and PHYLIB=m, PHYLIB=n and PSE_CONTROLLER=n link.

These are fixes, please send them to net instead.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

