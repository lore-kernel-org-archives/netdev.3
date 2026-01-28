Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092A369223
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613779; cv=none; b=cUZ7UJ3D++/9RrwPO+NJS+L8KsP/M2m0OyNa90gN+aAbog9qWKVpFlCJBfnU9Vd3SjNeTwpslgsdZaogwiS6lunYKg+Ea96kwgE2kKjKyVZsrg/rk0URavUWJzAlz1DyZXYy5j7SEYW+b1Lxz1d36EfV3/Ka4jaHx4TldCCjnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613779; c=relaxed/simple;
	bh=oDGZAzxpT8+c+W10giNoSo5eRIcv7WVHULBRFvPt0X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDj4ZfjAvXfIysI+0tzIWI/Dja318EGEubD9Vi4SqHIpeCZsCWZi2GLckFWPRlfrdC31+6zKLg/GrPMRQ6Olm5DW6RAKDM1dEe5yE7AoDgkuqvaenbfvrm9aQZS0FLEBkNnqaS2FngbsHqjEcwtt7HSRKfqvmG/Qe0ipmwG+2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ykB7DvF4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ykB7DvF4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PPY3upBqg5MalFXO6RLn/LnGpdfwG/fgbwSurd8Xego=; b=ykB7DvF4uBNZ4QLpk5GhwEU0Jl
	67r0d9OMNJbCQPpxU4u29+GLj97BcG7Ir4Uml/9thVUQuG4hJ6uXt2McR3NcFjmmNF1F4hK5aFe6J
	RyMZGvRGSvIQpAkO4f0XsDxqi6oSE/fvLDFkDPbvSlHcS0b9U+etK4bZLWT2XpkukVwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl7Nc-005DI2-DO; Wed, 28 Jan 2026 16:22:52 +0100
Date: Wed, 28 Jan 2026 16:22:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heinrich =?iso-8859-1?Q?T=F6ws_=28TWx=29?= <ht@twx-software.de>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
Message-ID: <18c6696a-7874-454d-8032-ca5130e41665@lunn.ch>
References: <20260128133842.1173406-1-ht@twx-software.de>
 <20260128133842.1173406-2-ht@twx-software.de>
 <6871816c-2732-4c5f-9f10-1f9773d5f23d@lunn.ch>
 <9090d12e-e85e-4827-9dc3-5bbece12c50d@twx-software.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9090d12e-e85e-4827-9dc3-5bbece12c50d@twx-software.de>

> There is no "Manual Mode" or "GPIO Mode" for these pins. They are driven by
> a fixed internal state machine. Since we cannot control the pins' brightness
> or trigger events independently from the PHY's hardcoded logic, the netdev
> trigger or the LED class cannot be used to emulate this behavior.

Thanks for checking.

> > Is there a dual LED mode? Triple LED mode? What happens if this
> > property is not found?
> 
> If the property is not found, the switch remains in its default "Tri-Color
> Dual-LED Mode".

Is that really true? Generally, what actually happens is the
configuration is left alone. So if the boot loader, for example, has
set the configuration, that configuration is left unchanged. So it
could actually be in single LED mode, not tri-colour.

      Andrew
