Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361B257827;
	Tue, 30 Jun 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800973; cv=none; b=RrG803u8792Ov1BPske29PbPBqJOggh3+m0DhMSI0xwCSS/zGkgwPizs2+1qhcJfCSMqcROh6dxkoDBE8DyVQeD6Sz04FaiRhN/m7EtWsxOuRRTTvnhcSX7GhFyhWLBJwROR/k3eBaEKqLm9xX7LYR8VIcFLdhoJjbT7HRV2D7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800973; c=relaxed/simple;
	bh=xx05GJO2blYEosxfNzQZ7F/MRFjRiTrWU+OnO8HLSpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqhjsqHmdLed2f/pc6U5KmmatfaN+GsFRqFn9Ia5rMyjYsAxd4FxVcKl7kl+NAohj0qnDLPCeDe9TyTngIh8zdN1Smk8Vqhcql1wXNtB5fABQEuavVF+T/TzYmUQpwL86Cv9nEsgSveENgL1LIrXpdOJkr6n2cte/aIHEg7C2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzOwEau2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzOwEau2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CE71F000E9;
	Tue, 30 Jun 2026 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782800972;
	bh=xx05GJO2blYEosxfNzQZ7F/MRFjRiTrWU+OnO8HLSpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzOwEau2Bl6p0XLHz1D3eJadtj9eiV8o0ZY6FheoUvGmbu/gdk2URuPW5lIskGQe8
	 e3wQ3CwPGYNv5ZW2XZFGL1e68V2Y8S22HitqV8bFj+KTjk3veELn7w/pW3duQv6ADs
	 /QwUW8TFsM9dW4gSEdaB9IJnk6O+x2WY+ro3WGzfqHZZe6jhMXFM0TblQLftY1dZMx
	 Dd4ZlELkZLdMI7Ir+u3JOPuGUnO3Zg3CapKcW8WC50FP/Fgac0yeT5vgRv1Fq6a6rg
	 u7hcaI84IFh0+rUvPg8pY1YD2BW9NsrbtjGzdnFHHn4yK5JGkC223SOkOMSHMEN/pt
	 iEnkcZFoagy4g==
Date: Tue, 30 Jun 2026 08:29:28 +0200
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
Subject: Re: [PATCH net-next v6 14/15] dt-bindings: net: add onsemi's S2500
Message-ID: <20260630-beryl-mongrel-of-exercise-abf63a@quoll>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-14-18ce79500371@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629-s2500-mac-phy-support-v6-14-18ce79500371@onsemi.com>

On Mon, Jun 29, 2026 at 10:23:44AM -0700, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg

No improvements.

So not only you ignored review comment but you also ignored actual
review tag.

Don't worry, we can ignore your patches as well.

Best regards,
Krzysztof

