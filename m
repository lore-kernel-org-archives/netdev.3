Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546342;
	b=0E1FhAOcY2IAJp0NirI3iiotxl2MouM4+rWv2A4bT40LhauXIsxR3XcHBAJlEF+daxRS
	 H4IxrE8MIdSJAqoadAoSPqlL0fDgrAPaGbl9xOueJFgcWLPwQCsGKDRiok6lNYvr/WLhA
	 yj2VbjQbbgXEsj3Iy8Dvm7E8InC14wFWvvxEyzFKMkTWeR33coXCfhPCOMaxIBOTupWzC
	 hCKAqzjuJxuMn2UyEpfXDUAA+plyuBcBawwPUnWLCD2pfwPyRDIEtbliHApp5qcN9sM5N
	 1F7Zq06sWCf0UcYRn+wDxhmhdhkZ9nUHbCr3ShmkgbgNzTN8SwrNaEGglhD56b5bZ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546342;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bE0yULH2/ZfxCs7e+7R9sMvGS9wp+yEHw8YDYWZQPHA=;
	b=PvSg3sFPfmHjawyTcy3q9ES28ITvN2rPfGUWqiALME3w9PoWFimDsxinLdzpvlwsvZ6M
	 A52cLZSZqfCCGpEhApFOohubFgkGtXYZJ+Js1zbw+8m2RQW4levqfkH8hHx1/n7kQ4CrJ
	 irOxVZvglU6K9xT2QOWZNk65oPrNIZ+MkdnFwDaRT8sCcoCN84zjZK1s7C/WwLkbvbfPv
	 CamETQ+tcXVatWBQOXXN7LukdYYFXmD6LO8J27Ztc1qUc7UV9moLB/SCnQPpAE9ecl4Kl
	 V09RhHZvw6j8pm/mV7CBV8fyE8ZsDML/5THf7aHMemYogRpUDJ77d1s4zBAU3LkPa9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVOP4g9e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F766606A31F;
	Wed, 21 Oct 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVOP4g9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA281F000C9;
	Wed, 21 Oct 2026 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792546342;
	bh=bE0yULH2/ZfxCs7e+7R9sMvGS9wp+yEHw8YDYWZQPHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oVOP4g9eCl6RV3TbIj4WgZRjLCBrmrVYV/p06kWV7PN833Lma0l8igk0qAHycQQTw
	 vGqLlvSzkhoQrTIElVANPysv1krbkYQsOqhROWli0TjdqpDU964devUalBSNLw8Ak0
	 FtIRcJf7JLolM71vnfSIZ8RcZHol0Ew+Vdl2K3vRWD99aFEURDOZOF2dnMqic5JCep
	 WhPcTZbON1Xx3YIQps/QUDtWHU0hcDH+DA6wPqMIrJDsMfH1S9+0qcto1OzLVwWTYn
	 p1lYXnnLLa3J/asBxPVvL7u6qKogtzpX1uBzCs8OAsGiu73yY0Awwz1yNXFy9sY1CJ
	 A+GrV9xj31DsQ==
Date: Tue, 20 Oct 2026 18:32:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 1/5] dt-bindings: net: maxlinear: add
 MxL86211C VDDP supply
Message-ID: <20261020183221.3fb74bf7@kernel.org>
In-Reply-To: <20261020093655.344585-1-robert.marko@sartura.hr>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 11:35:34 +0200 Robert Marko wrote:
> Describe the optional VDDP supply used by the MxL86211C PHY. Its
> voltage determines whether the MDIO, MDC, and MDINT pads use 1.8 V or
> 3.3 V.

Please note that net-next is now closed.
