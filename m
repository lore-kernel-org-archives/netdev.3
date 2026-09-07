Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177B448B93;
	Mon,  7 Sep 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772447; cv=none; b=V3nZqVnX2fRAkvgagAAWrEuPSzGmoO18wSv7zCDesbtazmN5AaHtFGPa0H+DP0YH/E17KuD7X6cR2p7sAi5BPZ2O9fjyNXrOyrlyr/3ElVmPgt6bEcVAUYy03MrM9QHNfJXnIboHnkwkDhHYVssO7kfxI8PyPex3NA9krtyUYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772447; c=relaxed/simple;
	bh=M7lrh72WBldL7IR+woYjHiS82BYGU6gyBU7lXx4XiDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOQxiviDum8y7kvRhRxRNHmntaa88pLLkw95vQnWfuIJ/f/+Dj5qt7YXoLJrqLnwAEVMdHkmGKzOLkLHMGBYtAmkHASLDaCN4XvBTyPRZtkPOkotGNQZVnR7DDdErgZOT5TKP+FMer2dgnF1kxNK3XhW/JWv01Yha+c+wzc5oI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjnODmGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjnODmGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB21F00A3D;
	Mon,  7 Sep 2026 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788772445;
	bh=92S6a0o4SCOGgg77JenRODeNS6f6fFk6zfyz3/qTRkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VjnODmGvWXZ2wHE3rjrXt4+9Ef3tzmEe0X7zaLtlhU6CU0lMnnoKqWQgj8yiVLZG7
	 9yC6Aq6L8f2gZ3aCpVrqaLitfIZ0sV24VOa1WOU8Hm7+X6ow0K9Ew12FCqI4uH/Ase
	 ix4Gb2l/5ByWYCPKmBWI/elF/FKOFPoOZM5Yr0yDt/3Oh4ybqzKU03avq3BfBfTupo
	 KVeZ8hBzaBzAMnOB9dnhCJuM+Jypsh6KcCQ35MfiPmE1C7jww6FU1kDIQGUyMoQ+RQ
	 fb5nJr+SzZ4cv+HJqx2X5vSwLOEKibkIqns2GbfqitlQfHq5+Fuxp9IHhBMcEdayB0
	 65N54SiZi/LQg==
Date: Mon, 7 Sep 2026 11:14:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: vendor-prefixes: Add soce
Message-ID: <20260907-airborne-delicate-chipmunk-d1a5c5@quoll>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-1-fb0587cb466b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-1-fb0587cb466b@linutronix.de>

On Thu, Sep 03, 2026 at 08:10:58PM +0200, Vasilij Strassheim wrote:
> Document binding for System-On-Chip Engineering, S.L.
> 
> Link: https://soc-e.com/
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

