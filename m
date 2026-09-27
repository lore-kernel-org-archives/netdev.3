Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC7175A92;
	Sun, 27 Sep 2026 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790481241; cv=none; b=nPje3KFr8D1qfH/CN3iMbImPQOXbb0s1ZBcW1qZ6DS6nUH6kXuIjlr4CXvHmuJbJz9mqiK/hBf8unl5WNX/aDdRt/k5pToWYLFdoJm8vMt1LSi63esb13qqPiSovb65EqjVxKWnLgyLDp5hd8afXPR+4WgIU/pA7e/O2riLxNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790481241; c=relaxed/simple;
	bh=72jOmKJsKtZbMfexR6DU2MSAN3lb/BvgsBkTbYP0Jow=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKgmkkDOS2ot4fiir6l5AFwNN4Cy3kCWOdS5jVG1j07ZZU1QvueFytgVE3a27lMfexN4KLbaj1n6hR0gnge7nqo3wDkdZxZwuuRczPtpIj4hfDdYbQlRGLICDsTJkkpI0V8bU5FFpuweN245sYoHkhvYacCkNHXWJfEmPLbenzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BUuAj1lg; arc=none smtp.client-ip=79.135.106.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BUuAj1lg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790480887; x=1790740087;
	bh=2n7v/f900ujYlkPeMFvncKXsx01rexWG+WoC8pk4+js=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BUuAj1lgFGUnkpYeDBk0B5qaCypJk7m+iRRthctsXUPOhcEx20nFxompc4oPawyR0
	 4I7PIiNFMHGpPKt/6cMwCRntk28dxo1zxdw9hTmfpjAa8TDaH0RwdKzyv1I3ciJj9P
	 7wxRvOZ4Z8AxEGWwAi3/fZa+3Wq5I/Wp35f7BrXhYHAfIp/jyvhIfIRcTNban+zq8Z
	 qYVd0ZI04ykGpbOsp6WqrUcYalse+aoXK04NUd5MgKrVdWJ63MDy3BpBBWLq0+w4pl
	 XfZJieSOtkpeE9moC3vZc+3Yj04v5VHk/puYbey/OHGVyYP7Kafl9JxKsG5PYFkgeU
	 HiR1JCNyFD9+w==
Date: Sun, 27 Sep 2026 03:48:01 +0000
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: David Heidelberg <david@ixit.cz>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH v5 6/6] arm64: dts: qcom: milos-fairphone-fp6: Add NFC
Message-ID: <AA1gQ_nENEVHK1oebVbNS1EUMIkabrgIPTl649QGQZvq_1LAMw5msh-2bmJt1DbB6K09JX1xc_VN0retl7XFImBTbpm81ucumJM_nzVKfYI=@pm.me>
In-Reply-To: <20260811220135.472380-7-jorijnvdgraaf@catcrafts.net>
References: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net> <20260811220135.472380-7-jorijnvdgraaf@catcrafts.net>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: f3ec71461e33f107fcfa8c1f6b9d2d515788ab04
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, August 11th, 2026 at 6:04 PM, Jorijn van der Graaf <jorijnvdgra=
af@catcrafts.net> wrote:

> +=09nfc@27 {
> +=09=09compatible =3D "samsung,s3nrn4v";
> +=09=09reg =3D <0x27>;
> +
> +=09=09interrupts-extended =3D <&tlmm 31 IRQ_TYPE_EDGE_RISING>;
> +=09=09en-gpios =3D <&tlmm 56 GPIO_ACTIVE_HIGH>;
> +=09=09wake-gpios =3D <&tlmm 7 GPIO_ACTIVE_HIGH>;
> +=09=09clocks =3D <&rpmhcc RPMH_LN_BB_CLK2>;
> +
> +=09=09pvdd-supply =3D <&vreg_l20b>;

Looking at schematic, think this should be L7B? L20B is used for SIMVDD1_EX=
T.

> +
> +=09=09pinctrl-0 =3D <&nfc_default>;
> +=09=09pinctrl-names =3D "default";
> +=09};
>  };
>=20

Thanks,
Alex
