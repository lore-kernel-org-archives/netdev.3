Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E04343FA
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614192; cv=none; b=bNoMOPp7BRksI8YmamednCOHGybCHUWjQUh2HkWjbE537ACoZZFNHrBzWH4e50npR5zvzWGxOaAIaMAZPIGtCoo4ANGBdzdMkAilsq6zRyd6rzk7e/R2fO1BOhI6y1gxvKIP4efiwDUqVC5gGoPnw1LFA32rlvYE1a5uowXdoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614192; c=relaxed/simple;
	bh=AO1uuYrOhsHTQYNgP/lQBuUFWvrW5PwbhmtC6sGMJbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+c/II8k4PzYrBWTcA17AZPsMQI4b1e1PSoGVpm7TagD2vdjx+c4m150u+Qur1Le578Y4z2Kr7eAAl4rjcyRH3xZa66cu9e5yS2KcKxIoYb8anxCze+pYRcIFSvuj884DCeV1ygMYd7k7Fqa20L+JYpPt9izi+bT7O1pwXN5F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX/PFe17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX/PFe17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED6B1F000E9;
	Thu,  9 Jul 2026 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614185;
	bh=xY8F16dOVGVz/HPOHeaPOgh5zFeAeHxadmKlUSBpORM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GX/PFe17eJ6JOxK0t8hkX4Wtk2KqMkbigvXkRxAvvQa7oBFnwfaOYZM9WrZ8AmhoU
	 kZN+TkFYtBBWUthuwN2qBxxtjcW8VGeDyUYDp3p+lgnHE/Jf6U5sAuZPwHazq+YqIA
	 r296KRh9Nk9ac519CtcIUq/AaKjaJuAsmuCQixkSJJh806f6C3sHf8NPsBLx0E9vtg
	 ooCZr2W1q07Z7UJEC+VP4h5XKYx1ilPVVh5KeUcD43m2VAa1Jxxc09g0neLzRrtbgN
	 Az1eATCam5wSD5cbc+TaYI/hCkUuLromifKM2tjMdgvymguc2LPm77B8wMlubbLM88
	 JkdwlSNn2FLLQ==
Date: Thu, 9 Jul 2026 17:23:01 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: add preliminary support to
 configure tx hw QoS queue during flowtable offloading
Message-ID: <20260709162301.GS1364329@horms.kernel.org>
References: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>

On Fri, Jul 03, 2026 at 01:02:17PM +0200, Lorenzo Bianconi wrote:
> Add the plumbing to program the AIROHA_FOE_QID field in the PPE FOE
> entry with a per-flow priority value during flowtable offload. This
> allows the hardware to steer offloaded flows to a specific QoS queue
> on the egress QDMA block for traffic forwarded between two interfaces
> via hardware acceleration, bypassing the kernel forwarding path.
> The priority parameter is currently always zero because netfilter does
> not yet provide a mechanism to pass the skb priority field to the
> flowtable offload driver. Once that support is added in the netfilter
> subsystem, the driver will be able to extract the priority from the
> flow rule and map it to the appropriate hardware queue.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

