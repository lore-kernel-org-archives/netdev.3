Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D063019C3
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100699; cv=none; b=EMfZMR/fMISPHbkn9WI3EuiCWXyRKgkjwQSJil1Pp8/wDvHaOjdY0laA29cqpQ71TLvCV3pWpxMMxEI7IJMsNWJV/WabHl8R301m8WgVJCpRAsGW8zok2KuHjiMUpoaK6cxHJsDDRerEjaw9MRCAXgaGldMyKxaBO9KWWmW/LxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100699; c=relaxed/simple;
	bh=NkZnIY0ZJuD3kKkIQpTpSf9zNSsMF2kyntzkO6gNTb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mizxXgo+8Lqa5Vl+ZamENT1f/kYUDS2+o6JtcnG8Bc7jAL/3fODit3r8/NUzdSHnp6qEVTTlGZXM/nLyCxTGvTk93oiob4qUWCDQW1F/tu08TFNIWnovpUXR+7yVYwBO2b+G7PEm1rg3QBEjTaNKJFlVUhxU+cT7WjJXGg73wBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xCZht4U0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xCZht4U0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 23358C2B9C3;
	Wed, 15 Jul 2026 07:31:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B90B6035C;
	Wed, 15 Jul 2026 07:31:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5BFB11BD3BAD;
	Wed, 15 Jul 2026 09:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784100693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cXCHgsII61RG+BUBR7dsv7oD4lN1OAQX9QZyrYgHcvA=;
	b=xCZht4U04fO/TOsAkFDrKLYpZe1uko0+yNhTkhKLYV0ZEv+3eqD4UtcWXskfavCsrolDcR
	NFxZ3wQdjcKFa+RY6/xRQDnO1bE0wu4Jh1lfp2lUchK8hLun1idHajZmvE1bpN6ubuCgon
	otdq3TlljGiyQPUJxFWAOpqs8gTm33txPz0cTwKtS0rMQoW3lKe1gQ8r/lRTfmVuXno+aO
	G4mB2VF6oh3dgaWwkO7FkmHqTk06eL+7WQv3927/CHT768lK30Fpjds4I/4x1ftOCqpsc0
	DOGMvje48XYFUqfRj7bcusaxmbaW+ktUD4PPjCy9Eq1wzmCGryTs6PE1uE5deQ==
Message-ID: <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com>
Date: Wed, 15 Jul 2026 09:31:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] net: stmmac: move XPCS lifetime management to
 platform drivers
To: Coia Prant <coiaprant@gmail.com>, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de
Cc: netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, Christian Marangi <ansuelsmth@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-2-coiaprant@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714191341.690906-2-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

+Christian

On 7/14/26 21:08, Coia Prant wrote:
> The current XPCS creation logic in stmmac_pcs_setup() is problematic
> for several reasons.
> 
> First, if a device tree specifies a "pcs-handle" but no select_pcs()
> callback is provided by the platform driver, the created XPCS is never
> used. The phylink framework requires select_pcs() to actually return
> the PCS to the core, so the pcs-handle property becomes effectively
> useless without the matching callback. This is confusing for developers
> who expect that specifying a pcs-handle in their device tree should be
> sufficient to enable the PCS.

I think Christian's work on fwnode PCS would help a lot with that PCS
handling in stmmac:

https://lore.kernel.org/netdev/20260618125752.1223-1-ansuelsmth@gmail.com/

I don't know when Christian plans to iterate, it could be worth using
that new fwnode mechanism here ?

Maxime
