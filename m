Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701746985B;
	Wed, 29 Jul 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344189; cv=none; b=qY3VEHYn9r2rWyAdR5lyvZHdkrvtD8nJxT0WEONPPyxrEeJdWz9iDh3w+FCzUCgk6+zJm9K6Y12qi+kE3F9H4m3O8Vv3oPVxrMPyFfQUnHFwZhaP1otzAnqMgYilTOFqmoYAh9BfG3wSUkR38a6Foc3NOVcPVzFe6ra4s2o9srI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344189; c=relaxed/simple;
	bh=EvIZlS/X9k/aJHdW31bssxznAqqKvHE2OWj2/CSJo9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlUvTYAWcfT9XyCMxXCOLNzwMkcRRv8GOZdRbOBQMl3e8N9UGVYSC2HA+g7MOcv8cnvTzl3an362up2cqjjLiaAfIn5ag66SBbT+QmgGSbuHdxxxD0TXV8UvCUKw7wU1lfRANCyaELqjRXZq+YCqndJzFFj7ZzuBEFoMlOvlf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cAqbwmEj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cAqbwmEj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KuZxx1WZrrngvNbUUsGlaD83DIL6+43ktEZ96++C5r8=; b=cAqbwmEj2EaI0/hjHjJU7ERPP2
	7CKZYfRXYM5ui68DlitGl9qHaSxQx7cnXTeKDilsz1h79dzn2LqVm4HXRXhweLUQWhdGbvsh7pxgS
	EwLiiSOI0AON/nzULmN+2j6xGtdiJfLwB1QEaGUykINDZcLsg4Eh3gEYICu4aHpI0kjM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp7Zp-00Eqpk-P9; Wed, 29 Jul 2026 18:56:17 +0200
Date: Wed, 29 Jul 2026 18:56:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 0/4] net: dsa: Add SoC-e DSA driver
Message-ID: <50e4f195-f810-470b-b05a-97f622e6efc4@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>

On Wed, Jul 29, 2026 at 06:36:53PM +0200, Vasilij Strassheim wrote:
> Add initial support for the DSA driver for SoC-e FPGA-based (IP core)
> Ethernet switches.

Let me start with a dumb question. Is this a true soft core switch,
which is synthesised and running in the FPGA? Or is it hardware at the
edge of the FPGA SoC?

If it is synthesised, do we have to deal with different synthesis
options? Are there registers which indicate what these options are?

Where as if it is fixed hardware in the SoC we don't need to worry so
much about variations, it is fixed at the SoC level.

> There are different variants of the SoC-e switch IP, which can be
> additionally configured at runtime with proprietary userspace software.

What sort of configuration?

     Andrew
