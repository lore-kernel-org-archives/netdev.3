Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376B1EBFE0;
	Wed,  5 Aug 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933206; cv=none; b=q+G/XqbDYhBnEJ4/jUk1/MyoHX2dyuu3OB5Zg4O4zvf3+Xvs6E5Mpeplsj2vW7hj+WK2C973IE99YcsFO2TJqCnSP0mgoF1qW7qSExMtAlbaCj2+b0uBDgULOYDn1Awzbx3SRbNpqyW9wxT5kFae8yA4umXkeA5XaxCJcsDvEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933206; c=relaxed/simple;
	bh=H20TEOr8WCIL2ThNrmGj7PNLUvjXBcsVP6l+E5+N+oE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wza6KH/MoIEf7FN0AVrx2K/jaDu2MNtDSEYm+7T9a+WT8w4Pwv/lD92DkRlseW8PGWzflAbFV8ul4XyUGy0DzRYa1wRjFWu4eRpSOKFSivRykm3eSqsj+b0R8vHfHr6aS8B5no4l/h+NvPAgnyvKDFXKYkx/5yQlY1NKRWWs0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmvKfrIs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/qrb+Blv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmvKfrIs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/qrb+Blv"
Message-ID: <55070c3f0b462f35e63b55fdd0e7576da8bc28a2.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785933202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDQ1YQA2fBCCU7uNqL+Ag6rcDt5K/CUxZluHvSxZ9XA=;
	b=qmvKfrIs8c8PLsqGMeeh4P/33hOwAext5cdKYkyGDxq8aZ4hhWfZbJFFDi6Xx91GR/lyDh
	Zf1i6KC2194632tCb2UXPRzSIRKGuQOiXkWJAVQB6C10Wf3h7p3mhW/mV4ehP/KInt/xu9
	fbFVWk2jA510GGz8tyOA9OxzH/jtki2rUIfqWAULDMN7kVtu7ZI1+F/uMQlHwqEGjVXKA6
	OaSoImspuXXXtZN52eX1j7rPF8grvjP589pl3EKK51uMI8kg7lCIDLWa5GtxBXkUDUM62H
	s94wwlQVBRyvLlvsEmkfhyfJ2lBdgeWamS+t4mHLjRnZxdsfgz18rTcbEajK9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785933202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDQ1YQA2fBCCU7uNqL+Ag6rcDt5K/CUxZluHvSxZ9XA=;
	b=/qrb+Blv2qzuJ5F2QY3mlxupqOsw843SOsQBJA7wrePpnm+YWMPulHuCfTIEsGlol/H3NZ
	nHhNAZeeNgvR6VDg==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Wed, 05 Aug 2026 14:33:21 +0200
In-Reply-To: <604ff3d4-2a66-4086-80d3-ce838773b9ed@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <879a1366-872d-4bad-8bec-fa8a7ee82dab@lunn.ch>
	 <cc7b7a56557d30be86097640a26f455d7262ff4b.camel@linutronix.de>
	 <604ff3d4-2a66-4086-80d3-ce838773b9ed@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 18:35 +0200, Andrew Lunn wrote:
> > There are synthesis options for various management interfaces. MDIO and
> > MMIO are two of them. I only have one variant for the memory-mapped
> > version. For v2, I'll discard everything else and update the
> > documentation accordingly.
>=20
> Please take a look at the DSA drivers which support multiple
> interfaces.

Thank you for the tip. I think hellcreek and lantiq can serve as
examples. Both are also synthesized switches. Like hellcreek, I will
keep only one interface in the next version.

> You probably want a MMIO driver which creates a regmap, and passes it
> to the core driver. A future MDIO driver can create a regmap and pass
> it to the core driver.
>=20
> The DT binding should be similarly structured, a .yaml file for the
> core, and a .yaml for the MMIO wrapper.

I think that once I have implemented all the suggestions made so far, a
single DT binding with a .yaml file should be enough. Just like in the
two examples mentioned.

>=20
> 	Andrew

Thanks,
Vasilij
