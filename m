Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873654788;
	Tue,  4 Aug 2026 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826006; cv=none; b=ipFianbH2bzclpH5kr5QnqzP4no6N819e+nIZ0/BRkoD14+RGaroMPKozPPealpA1m5VqRlTtejOAb/8nEtMMUU2fEl0Z1pwgNj6j/vi4qQ+sRHlWP3mfz6djK3Vn3n4lkHOIBSOtDHKIitWPNvJjkQH8+0LOkiCLMvZ46m+eE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826006; c=relaxed/simple;
	bh=sLH5QEG+sLwHlLyTdsI4P13jPzGxmPkMYNrKnY2oSbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeuW8xw3R/gBmxB2WNXhzXU9/t0on4smsxSCL3R/86OhDa++OtBMYAt0XMh5YxrxPMb1BtoyxVKtWvKa5vT5ijgiFYmP+hOYGnGBh9a4Hiq3Q0snfmWF+QNFCjztW8GIf8x2icrWDa8qfriNJxy63ArUoRJpJcLvc9Zm77J2pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvxQjuMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvxQjuMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2970C1F000E9;
	Tue,  4 Aug 2026 06:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826005;
	bh=EFAzAYFInHBohrPtBRpyU/YAKCKeZ6peC5FhiMy7mY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SvxQjuMuf7wiMeXgmEJQZBL1+5uxmOs4h/k+npQvzH/FG4tHLOsSz2+xIN9TQYPjC
	 KMLLhvxsDTJFutAhD04uUWPhnUP+km1wwIxZL//HwU1dx8eDTpPEIfrGWSOC8lSyE3
	 6bRZeUdZNhX/dVYAClA3Lw5xy+40y6r7vee/S28IIP2LD5F94mZg98v6PmKuNGhe0N
	 Y6hLbclsHMeDK/OzPxncr2/ngHEkwWD5PdCJ3Ru38EKTBqIK2/mLmBJNz/axjkhSKD
	 hUjz2TmEgicI6GTy8gMCOu4dd9PzjRXdk3ps4NZvxAUkIeeeuiDbNImpktoKF35thS
	 Mk8zwFZ77Bg9Q==
Date: Tue, 4 Aug 2026 08:46:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/3] dt-bindings: vendor-prefixes: add
 Guangdong Dapu Telecom Co., Ltd.
Message-ID: <20260804-affable-warthog-of-contentment-b3f09b@quoll>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <20260803101734.270821-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803101734.270821-2-a.shimko.dev@gmail.com>

On Mon, Aug 03, 2026 at 01:17:32PM +0300, Artem Shimko wrote:
> Add vendor prefix for Guangdong Dapu Telecom Co., Ltd. [1], a manufacturer
> of Ethernet PHYs, networking and other equipment.  The prefix will be
> used in the DAP8211R(I) Gigabit Ethernet PHY binding.
> 
> [1] https://www.dptel.com/

So the prefix should be dptel, not dapu.

Best regards,
Krzysztof

