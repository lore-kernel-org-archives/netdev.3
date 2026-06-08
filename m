Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0630C629;
	Mon,  8 Jun 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905186; cv=none; b=pLHlgdRiyBdSvoZDxXJKc/3wsg/cGr2/CgTifwnAkrLR7tiTGfytn32OMm/sse/2vmyez5IEGuGReYk8bIbn0K12F9S13mFfoz8tfm3+Qdgm6dVFUd6pwh11N2/AunilAG3EpTJbD7gwJe3rMRF0/pqCEJeQldQgKWuI0YEKjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905186; c=relaxed/simple;
	bh=xDqUmosu9bm9fo+RWAw/TRQttLRRtnRIaEteULDwtFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhB2puK6+rQUTZwNwgyOw3oLqMCm9xm3awtBAR5Y/6nvBR8IESHo4EyvPwXOe7KcXZIh9Er368nhPYcAecPBwILvcSlwf5v3ImCdvoh17MvlUpZZfUrVXB1ja6NifPnVhiWkW5BP+s/7GRU7AhSwK3wP2GGdQsgOCMPJavwYkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzhrtqVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzhrtqVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB8E1F00893;
	Mon,  8 Jun 2026 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780905184;
	bh=WJFQ/eLSZ9ZBMeT1AmRntICsA1hijhCQck/8ePq58YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RzhrtqVI9UAWhhgYirzsJcVjkBxa++IFG414nhMt2IVhZ59WqE6RFJojWO0vhbdoT
	 0BrdHFT0HZ/PgcYv6EOZoJuEcVbTRPtmemjHxNZxQfd1z7M8o+rv1q9s7jBfneBqjI
	 Yo5NCoHTZrur9nAXrSDHBXQTkBJuNVN+tq2+jY3HJLmzBWtDGt9+7qvOAJ1beiZG+Q
	 dexDgH4uQ7kw2f8JVtL4dDc7s1kFsSsSqAugGyOd/TZNqfvDs0iZvHQa1G7sCOWMhy
	 fxbdjvxnMz3Hq2GzcZVLSxChwNHGF7vCttFn4qZ+2l7089OpSpMWvTbsKH7JsI5fy7
	 P3psG3PRd2/iQ==
Date: Mon, 8 Jun 2026 09:53:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v4 15/16] dt-bindings: net: add onsemi's S2500
Message-ID: <20260608-nifty-garnet-pillbug-2be5da@quoll>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-15-de0fbc13c6d8@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605-s2500-mac-phy-support-v4-15-de0fbc13c6d8@onsemi.com>

On Fri, Jun 05, 2026 at 10:42:46PM -0700, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg
> compliant Ethernet transceiver device.
> 
> We use IRQF_TRIGGER_FALLING, though OPEN Alliance 10BASE-T1x
> Serial Interface specification calls for IRQF_TRIGGER_LOW.

Ah, and keep correct order of patches.

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Best regards,
Krzysztof

