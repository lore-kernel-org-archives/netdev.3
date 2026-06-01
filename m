Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFA34AB19;
	Mon,  1 Jun 2026 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355500; cv=none; b=Y4d02kVZ3teFN/KrFwxXg+Y+1Gfck5kTmN81efMmWJfeKgc9AFq+vzwoCilpkw8j4++k3w+JiDmV29nZ99jqHODVW3tFycvIFDh3IntA807x3LA+zrkKX1AtYFXyRGBaiKMUq1MdbAtSNfR7yS/AqUqGDcUqbLOvIhMNbbJ3pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355500; c=relaxed/simple;
	bh=tZ/FyU6BTe1l76oQLhf/QPSnjO6j3Wt4thVE357l+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpgEF8iHk+plltUAfBnaYl563A3PXCbxl8tcd0Yq4btdJktZOcy12HACzPbJqbOiVeidrYTZ3NTh341REsGhD1HS7y6B28q7RgKNLOM7aDg+JdnCivW+0IcZpHelrgS/XiDeRABym2r5pHvUzH2dW7e6mzW2I+eRZ1iFUDHlwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGL4zNAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGL4zNAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D61F00893;
	Mon,  1 Jun 2026 23:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780355498;
	bh=u0uVl58P/+LhtePaVxc1OfDLsvpS/SYXpeqwBFFbzSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGL4zNAtKMHnY544PXECwX2aMFMp24rQEYuUfQs+q21l93HzpIoRz52ZpUN9uwl/c
	 QoiugUZR1nUBv6FmnjvfYpNQH+WM0id3NatUQeZS7gmM77UqWgWCnDgloXPPUM+q6b
	 EqvWD8Iwdz2ig7V078bAd9ClTS2Rwhnq0K/E82D/kLa8WxO3WtTvzDE3hW7/NV4hn3
	 0fwhsepFhBiUJjLnTbY2PoJcanlPDjS33wSP7UO3Kkfl9U+T2Qre7WgeccSvtYofEa
	 d1hYkbXkCDdi9kkFX4q+1PJfxHkP0OohnKITG8PZ8cu5VfqakCLak+bmY4a6imtF52
	 ZQ5pS14t8q1/A==
Date: Mon, 1 Jun 2026 18:11:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v8 01/10] dt-bindings: net: airoha: Add GDM port
 ethernet child node
Message-ID: <178035548342.162634.13411632527297449694.robh@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
 <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>


On Tue, 19 May 2026 10:57:44 +0200, Lorenzo Bianconi wrote:
> EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> As a result multiple net_devices can connect to the same GDM{3,4} port
> and there is a theoretical "1:n" relation between GDM ports and
> net_devices.
> Introduce the ethernet node child of a specific GDM port in order to model
> a given net_device that is connected via the external arbiter to the
> GDM{3,4} port. This new ethernet node is defined by the "airoha,eth-port"
> compatible string. Please note GDM1 and GDM2 does not support the
> connection with the external arbiter and they are represented by an
> ethernet node defined by the "airoha,eth-mac" compatible string.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml | 56 +++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

