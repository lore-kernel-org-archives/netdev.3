Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAC51FCC4;
	Wed, 30 Sep 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789183; cv=none; b=sjVdNEg/QTPXhvtjWy6zCsbj0A6lmpVuj0N1hWhQcIF30QjVAJtk48UlRlHqeU6t5AJeNNaJ5h8OjKZk5hC+Vh09yNOjYpRWoUn0VdAxCUDuVgKibDcPnWl+kLvecQ01pyqxZmmtvwWq8Ank9lcpjcO9uew9obEAMZvhqZt5jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789183; c=relaxed/simple;
	bh=kM6JA5RsuihcZxAUFE4mCjzjy4ZvkYVwr9L940JZlhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+R1arhrk7tut8zHfp3VFHqaM9LFpyX5TtYEoosIlKNsXf/8Oh4Q6eF8rchcNKiELPXhLMc7oCG2++w7P1jsTyKJXCtuh3KiMf7Jore+jYZV+9QcgrLs6qmcXco8oGijBNC/PCBOWYG/0EJz1oxqXFK1X6YqohedEAYhARiPn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2UhsyxA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eUoAO5df; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2UhsyxA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eUoAO5df"
Message-ID: <affd433db23905f57d48c25ad88707ba62c925a0.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790789179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZPYnuHiuNlq0agEleU5Vw3QXOfTKWBzAxaseohITEo=;
	b=r2UhsyxAZMOPEViQ3ahoY8GpSwZQ/5/yoyoq2Qi6X6DV421ocdBYJi9bAImBVyRKEnkAG2
	TsJmgeHT3l7trOnEOC7yaUrKi04DYsHoSo6kr4l4dqMGppEin0w3Qir1nr9384N3ODOfYA
	cUI+ROvsXVdg9jDInM8KCZ769X7hRTM/Mm50oB9zoGN46CXfdXuh1PDpJXvAhbnaol2p6M
	+F5Zqqop+riUD7uh8z2+xdfOnSO9DlI5VuNXu2bfjl3tHPhtrTQxI2epyDwlRn6D0fP0a1
	JkhmrrRikU7hY0ViH+ptsG1Q+ItFxvU9pX7W3JVx0VZocORWX+PGyuCbFDN0/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790789179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZPYnuHiuNlq0agEleU5Vw3QXOfTKWBzAxaseohITEo=;
	b=eUoAO5dfE+Zrfu6jxLoQco+gdDx8TLZQQLimRc0c11Hd0K0gb/qla/fyHOEXGYwRQkvP4l
	N/izlOFVCU/0IECg==
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 19:26:18 +0200
In-Reply-To: <6c75787b-f06c-4d85-8fc4-5bd7b2a30716@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
	 <6c75787b-f06c-4d85-8fc4-5bd7b2a30716@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 01:17 +0200, Andrew Lunn wrote:
> > +static void soce_sw_read_core_version(struct soce_dsa_local *local,
> > +				      u8 *version, u8 *subversion,
> > +				      u16 *revision)
> > +{
> > +	u32 regval;
> > +
> > +	regval =3D readl(local->base_addr + SOCE_CORE_VERSION_OFFSET);
> > +	*version =3D (u8)(regval >> SOCE_CORE_VERSION_VERSION_SHIFT);
> > +	*subversion =3D (u8)(regval >> SOCE_CORE_VERSION_SUBVERSION_SHIFT);
> > +	*revision =3D (u16)regval;
>=20
> FIELD_GET() would make this more readable.=20

Yes, I will fix it.

> > +static int soce_sw_detect_features(struct soce_dsa_local *local,
> > +				   u32 *numports)
> > +{
> > +	void __iomem *base =3D local->base_addr;
> > +	u32 implemented_numports;
> > +	u32 licensed_numports;
> > +	u32 regval;
> > +
> > +	regval =3D readl(base + SOCE_LIC_FEATURES_OFFSET);
> > +	licensed_numports =3D FIELD_GET(SOCE_LIC_FEATURES_NUM_PORTS_MASK, reg=
val);
> > +	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
> > +		return -EINVAL;
> > +
> > +	regval =3D readl(base + SOCE_IMPL_FEATURES0_OFFSET);
> > +	if (!(regval & SOCE_IMPL_FEATURES0_DSA))
> > +		return -ENODEV;
> > +
> > +	implemented_numports =3D
> > +		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
> > +	if (implemented_numports < SOCE_MIN_NUM_PORTS ||
> > +	    implemented_numports > licensed_numports)
> > +		return -EINVAL;
>=20
> Maybe add dev_err() here for all these error cases. It will help
> somebody debug why there switch fails to probe.

Sure, I will add them.

>=20
> 	 Andrew

Thanks,
Vasilij
