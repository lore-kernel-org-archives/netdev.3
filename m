Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219638C42F;
	Wed, 30 Sep 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794188; cv=none; b=YzunLvwWHplzNYQAb/t52GFp8dTGyhkDb8GP3OtJqaP5gjczvOSYLSpaX3HZdG34aKRyK8TWsWB0LYdEFgE1fMPCB0TpEQeG8PmWqAGz7sS/pdmldlqkUFWAk0t2CnRMEszrXMd4cM8QOpuebvHXhLjNpjjP1MiP1VjpjjOVSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794188; c=relaxed/simple;
	bh=KRe7+fhRP84ouwswgo5X97CmeFHtJt1AxGXOuOzKDjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfatfDbMBcvBJFoON51YKxlbUkDCtR6v4JIt/I50UzL9Iz4Ko+UdNgC59roNSTpsWxM2cK8mx9l598foD3tFEEIF81HIOcubr52AktXtKVY73l9tGynTaa3s7agaB8PCIRrMQ6w5Ri5GxNFCK/1SziApz8dQS+5ZDvyxAOz1lQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5tYtJ7d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4E0+KL1q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5tYtJ7d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4E0+KL1q"
Message-ID: <dc94b677646eae4b125427aeaf7aeb9828b72e61.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790794184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRe7+fhRP84ouwswgo5X97CmeFHtJt1AxGXOuOzKDjc=;
	b=S5tYtJ7dXLXxGM+FKGZrGLla4p8TtbdK/RqdypNf/1DoUkrk26ycbH8qClHYEQUZlTQVLK
	Gb8cNq0IgsuiwH1C7AjSrXmkdLfRqAukSJDtjXtGiT+EUNpX6JcIYfnLFqEOIEdUqtTm1j
	IQjuX25Ni5AZjqxMDNyBmaTt3RVbf56QsTXlqckmtbi2X8qnulnoCgcMkeSVJiY+3yoZ8o
	r1DL3Q8reEVgqomXfKvTwqPdOXGgSfz1CN7qNA4fNm8MUOTPaBMwWX2IgCLxFJUAs0eFki
	xuffXf/scKd3SmO3yGbCsulqJJPRm1l7pADinnCEAs82m7lsF11yI12NWoLYsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790794184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRe7+fhRP84ouwswgo5X97CmeFHtJt1AxGXOuOzKDjc=;
	b=4E0+KL1qnaG7iDemfwfrFfxrVZrir+6akAGMneYnaew00phRjRyigSr31OTmB+TFQmRMBM
	ov1PEZ8f0YNjiIDA==
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
Date: Wed, 30 Sep 2026 20:49:43 +0200
In-Reply-To: <32624256-8462-490d-aa37-36ee2453362b@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
	 <716486ec-6253-41dd-83ac-b816c845fafe@lunn.ch>
	 <4fe59faffa0bb322e68c9c4d43f0bc240a519eba.camel@linutronix.de>
	 <32624256-8462-490d-aa37-36ee2453362b@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 20:29 +0200, Andrew Lunn wrote:
> > > Once all the setup is finished, what is the state of the switch?
> > >=20
> > > What we want is that the user ports are isolated from each other, and
> > > can only exchange frames with the CPU. That makes the hardware
> > > basically a port expander, and you do bridging in software. Later
> > > patches can then add offload of bridging, and whatever else the
> > > hardware can do, which Linux can also do in software.
> >=20
> > That is exactly the state I want to achieve after the setup.
>=20
> Great. Just looking at the code, this is not obvious. Most switches
> tend to default to all ports can talk to all ports, and you need to
> tell it which port is the CPU port, and block everything else. So i
> look for such code, and did not see anything here.

The CPU port is set during synthesis of the jellyware. The driver must
therefore assume that it will be configured correctly in the DT.
There is only one read-only register that I could use to determine
which port has been configured as the CPU port. Until now, I thought it
wasn't worth checking.
I will take a closer look at that, maybe it is worth to reduce any
assumptions.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew

Thanks,
Vasilij
