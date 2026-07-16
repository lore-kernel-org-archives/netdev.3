Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AE4302F0;
	Thu, 16 Jul 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212029; cv=none; b=GOvTJzDLhTpi8w5LrbGjmPZK755qVNkhnm6FOA25ybkBNJsdXR5Jecq6wLn2CiqZRGoxT/qZmAdupyvT4PQtlUpcQ4mlcoAEWQl4SJzFx0UNYjqKk+3zCIkUDpoNmRDs8kVya457pderLZbB+bgwWSmeim3yIjsWGpLD7ZSQSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212029; c=relaxed/simple;
	bh=5tSh1mkOxy+3MKugWdIP5dBxYtDHPklNW0EhFbwcLKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GdNeNXLlytFICpQ6wqAceiDAxby7qOsQRT3mlWyBOIoko7Kp5C43b5TqtfXEy/Tww3A0ScMJBJqEM6FlmJY0pABl+Ctrkvfkr6EQPC0hOgtnWTqd/5r4WoqN6ISHZDmlM8rzsefMs0goN5P2cY+PPye5o0u1t7g/+1bCgWcdFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rlgdDHzQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rlgdDHzQ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6763F40E56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1784212025; bh=5tSh1mkOxy+3MKugWdIP5dBxYtDHPklNW0EhFbwcLKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rlgdDHzQ5wZv7v1f11WBXJjA3sIS0SGRaunTjEgYrRtPv30f99Ue5+r0Uq+0OROe0
	 U8SkD8q80pFJY7UGpOtmc7pN7BeWqAUAzrhn93436rpjilsQNFMQpRoW4iwHrR4jR/
	 V5PXU7+6x5TnR6FzeTSCNXAo5XsgNqcZkfYCeKUcTQ97F3yVdKIqhhAZkJ+h7S/alc
	 tzMQe+ve9gM9lyNTkGHmVtahXYcVvvCnBFfTYp1JcFnILbpHSQ2QREZ3KNmeW3CZYq
	 +6QTOhcwGHRD+AAiH0WGc3tAjHywhezjdOs4F9S91hLvJqMMnKprMl5EPSRrEXl/bh
	 22hTgw2866GsQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6763F40E56;
	Thu, 16 Jul 2026 14:27:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Markus Elfring <Markus.Elfring@web.de>, Dan Carpenter
 <error27@gmail.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>, Michael Grzeschik
 <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
In-Reply-To: <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aliA1EIIrX82jGR-@stanley.mountain>
 <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de>
Date: Thu, 16 Jul 2026 08:27:04 -0600
Message-ID: <877bmv9fif.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Elfring <Markus.Elfring@web.de> writes:

> Does your understanding of programming language details differ from the view
> by Jonathan Corbet?

I'm not sure why you keep dragging me into this - I have not opined on
this particular situation, which is definitely *not* a dereference.

jon
