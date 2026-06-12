Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884F37F8A4;
	Fri, 12 Jun 2026 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253862; cv=none; b=LDwFRPbV7V6/CSH8SEHCbUSrMqouiqydjiav5edMGxdtr5nwGKIcLd6ljw7es3jR3TXHDb/wh3oy3pSTGw1hWd+ijfVGjYplCPFJcxN31hdyxrmWDqKS4e6R7yg+qq2dOthKOBPiI1n+QR9VehEFgueo/Mcz0h5Ssm3L61alrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253862; c=relaxed/simple;
	bh=opNULbMsLFO7G0iKg0MW34aWlrvrchHIe3SdZYnnk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqXf4JCARlZXoUhkRncYjAF3h6ztTAopQnuyISG43uRCIRmANNVgjz5KIHTckur7QUPahF2YApI2cS2gxiFj/JcpuM87BxoiflIb7/IcjvJK47nkCJzQOvGyUTFbE/5iy1Xbr/AuqTeqpXVy96J7dprC5l9A7GZ9Lvi4YZ63VTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbFHET31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbFHET31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327F71F000E9;
	Fri, 12 Jun 2026 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253857;
	bh=CnyWSURZdvG7Ai86hnxk/cu/zFJQx0+8PaYVIH2aDoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SbFHET31Qk9YXEEOHwzuAoyb4t4AuSQe1pzSppz5xqB5PDKfIegG69Yp/ThE+WuYS
	 KwU43YpOz3mp8LmDVn0t1zWptN5RCeIeV1ygPQV0TRxA1leN84q5TmSpzw/Nlpf/MD
	 YAPazfmjPUEHF7UbRb3Sfc//wEBHSag6bW2RnxLTmUjd+6L/Fro7a6kvXVsnGf2CY+
	 /dcR2EoGwXr4Hjh/hyOMLX/iiKlta6IE2jeCppIrJptugOTcD4i0X9EO9crUlu+9un
	 UetTX5cqa2Dy8BmSyaf98ne1uAhssSOiB/wojsDN3Fk3b/llu5/DGsQDgPJZiEOA6B
	 Otl/hyxzfQG+g==
Date: Fri, 12 Jun 2026 10:44:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net v5 4/4] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260612-tangible-supportive-eagle-0dbff6@quoll>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-4-4533a9e85ce2@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-level-trigger-v5-4-4533a9e85ce2@onsemi.com>

On Thu, Jun 11, 2026 at 02:55:41PM -0700, Selvamani Rajagopal wrote:
> According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> specification, interrupt type is active low, level triggered interrupt.
> 
> Specification calls for when interrupt level will be asserted and what
> condition it is de-asserted. By using edge triggered interrupt, there is a
> potential chance to miss it, particularly if it is asserted when interrupt
> is disabled.
> 
> Level triggered interrupt can't be missed as it gets de-asserted only on
> interrupt handler taking actions on interrupting conditions.
> 
> Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

