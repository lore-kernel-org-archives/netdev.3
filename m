Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BE2641C6;
	Sun,  9 Aug 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786294379; cv=none; b=ROgjGsRb2jBhzY50zVUO4hW4CuOSMC/sP1iy8va2OXIRNtPt3/TT2pBeIptRZaoJlkE2fSYi0V6w5JxSvWwB18iS+GlMSq9f5xsLvQ0mFSvyHDYIUBneeNUpGXXUIsWyccb9gIwLXjanXPUFp+Y2VVGZbcW3ZtSCE4zg8Xi6q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786294379; c=relaxed/simple;
	bh=dhsass6tzLiaGr/Fr73ry+DjjCDxzWspWbx1JVYLrW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gun3qQLcgTmYaEux79Ch1DIwKEGwtem/0Raug4KJk9I61u++VHaQ6GBdp/kFnlIa2dDEfZr2lQz2H8FqkOtDmCik3BM0GJ0LoLTJXuW+BerRPhulChzvcmn/ifILm1Vj/E9e6abYGLnIKDnKKEU41P5F9bH1F7Jfjr2itg/e924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1QcTaIto; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1QcTaIto"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X5ViyVzH3GymeSSIV1nCFP2sbUlifZNgrhgPgKvEPvE=; b=1QcTaItoKbIoQsbQhh1UV6l7UL
	I3OAUzGBcITFFXRX7Mz2qWydfdxT6ZKCcNzIrJVzmDpe1MvIOVJAEPK/TrJtKA0sx5VWzgNblNYKZ
	YDaTRYGGh2mIRGjEzOak/EkZNCxdRROjuw/X5Bq9iplVrvH+waMiqa4FiApMM+IOLT6w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt6lO-00GpXf-64; Sun, 09 Aug 2026 18:52:42 +0200
Date: Sun, 9 Aug 2026 18:52:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <cce12342-8352-4e59-a646-1a1cd1054f7d@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
 <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
 <20260805153220.3860b262@mitra>
 <9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
 <20260805162705.1a3467ea@mitra>
 <b47e0589-a3a2-4f88-ba90-72d176efccd3@lunn.ch>
 <20260806172541.009f1295@mitra>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806172541.009f1295@mitra>

> > Does any of this surrounding logic need software?
> In our case: No.

Great, you have a nice simple integration.

But stmmac shows us, integrators do often put additional things around
the stmmac core. So you should keep in mind that others will add extra
things around this device. Is that going to cause an issue? Can they
do that without breaking your device? Spend a little bit of time
thinking about this.

	 Andrew
