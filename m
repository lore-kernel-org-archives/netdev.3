Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB53495028
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816547; cv=none; b=MooNNjPUWsxH9sa+wjmisYutaqijWxiadzim5sYJ5IWIYRKRtImf5l+R2Z8/nIpUu4FhA5MMrfhNIybnhavH4cyhhwr0ByzeGBhnzMuBiPoXdbuOKFNKIgEDOucvZC0JrvlpHDsuRE2qR/VOclRlZvPamfzP2kV3xaoRDoqByfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816547; c=relaxed/simple;
	bh=k/DfgNxHeLeRjushtJ02R5xOy6sIudNCqKdMU88UXTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoZIFsP66NqpqsgYC0A4gu1usliRkXdH40r3pouzkBa2mgGg9ZTVVvYgr2vqCLeP5z8z/6h6emIdftqDzaFXFPgCX1Hu7IVLsjdiKoE/zaMu9iBeApFnkzovr7SRJTBbP+OsFi1S4pNHOSBvW/tH3uTYt7pF9KuOgW1Qkiz7O7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rv5TGFKM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hfX9ML1a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rv5TGFKM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfX9ML1a"
Date: Mon, 12 Oct 2026 16:49:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791816544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtN19BT7h7/cVMeeClkGxbfGL90QfBwNXYZoOKbhXtU=;
	b=Rv5TGFKMxEe0Js+IJSccaR1vr8wt8jxoiRkmH7t8fu6y68m84a+Selwy2dgsvGPxq59bgm
	tvSOEbgdZeQMnzAU25kty9aUAIut+eakcSuw9BYD7FEON3BSndQjZjEOFpbG1rdnpr08tD
	snZdii7Miwp2/koEdD9KnznMMAokvHy9mPenp3l8lroFKw+aHQopK/ko/75PBoKiiOftxx
	d8jYRlPEvwEofTfAes9UmrrfYqHBL2wsFSTnmQtybX4BOq24mZuSo6wfr9Hi+0IfVDGmOV
	o3aA+DpKkhlY7KfVNyGS22yPe4+tsPnH1M9v7C85SlFWjp++ld+IYYvAu3PhKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791816544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtN19BT7h7/cVMeeClkGxbfGL90QfBwNXYZoOKbhXtU=;
	b=hfX9ML1aiuantVP4zni3I7nxuXOKpPwPuLdCiZHy4J3GB5i3AYLsF8r9/Vsau7MrP+DS5k
	6XF1PK8NGCcjgGCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 4/8] hsr: Drop received PTP packets
Message-ID: <20261012144903.EysNyyNj@linutronix.de>
References: <20261002-hsr_ptp-v8-4-60dabc07e554@linutronix.de>
 <179129707723.434549.4053379151333278960@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <179129707723.434549.4053379151333278960@kernel.org>

On 2026-10-06 14:31:17 [+0000], netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> The commit message says:
>=20
>     Drop all received PTP packets.
>=20
> Do these checks catch PTP carried over UDP? Both branches only match
> ETH_P_1588, which is the Layer 2 mapping.
>=20
> PTP over UDP/IPv4 or IPv6 (ports 319/320) has ETH_P_IP or ETH_P_IPV6 in
=E2=80=A6
> UDP PTP behaves the same as it did before this patch, and the IEC 62439-3
> PTP profile for HSR/PRP uses the L2 mapping. Still, the commit message
> names only VLAN-tagged packets as out of scope. The new comment also
> states the policy for PTP in general.
>=20
> Should the commit message and the comment say that only L2 (ETH_P_1588)
> PTP is dropped? Or should the UDP case be handled as well?

The HSR/PRP specification mentions only L2 therefore the checks focus
here on L2. Using HSR and PTP with L3 transport such as UDPv4 is outside
the specification (or PTP profile). I don't think it makes sense to
mention this or check for this case.

Sebastian
