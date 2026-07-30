Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065E38E8A7;
	Thu, 30 Jul 2026 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401429; cv=none; b=Javfq6hGp+lCUtVhQ8flB/J44e/Qu7KjnbzbF1uxIMQVd2GnCfA7OJHRUfAuqZCHLrbKmYyX9tr51kWWckYoVYRGlof4xf2E1SgxZr+CruFiebbT2AH5x3KI+DNZ++EpkSXu7ZBUwfG+YAGvAqNWt3Z/duV8JkP8bqYmKARiW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401429; c=relaxed/simple;
	bh=oEibYLItc0P3D+cT7bmkq5jHGKwWhT9E/4eLUqY8fWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deYlmxxc/getHNl9AnTNZYoPXSz6KHvwHA0NckVHsEfdfKHdBFMwe54y+BlGFCQXoPFrotx6xSs98bM4YsrHwrwIKgEW6XNEbERHPExQVMsRUPh+Si5JkyG175rzgVCk+5/WCpVNQ3jkeb8nUhSgZCC0FFzRafDGnzdw0XtTsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn3OIAyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn3OIAyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19C71F000E9;
	Thu, 30 Jul 2026 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785401425;
	bh=mQFnIsqbOSxpl/5x7T8s+yBi+Df2pGyO1bskEhvSkUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jn3OIAyOHh+tN9z0W1urk5DFbxOB4D6ZwwZCu0jgVU4e62ZuAGd99Ds6ZIc7FUtjD
	 p7nksZJzGZuQzO3DIdqnadrF0Qbrmkumpv59pz0PKncsQildBjUdKPecTv74XdeN56
	 SYPbv3/0ROixPCvrRLvRB8zrJTPsscA1s2KSAXp/8WVnemW7SWJLitRDd3elc7V0Vn
	 vB3hg47lJqUBYzomjRBM51HheHlE9ADycjShhWU0ZIxd2NuKTW7ELJ7Pr1dPhDDg0T
	 RyPTrwDmxz0EYF+Y7X0evJwmH6Fu2QS9ysBkarTkrdEzOoY3PACkTw9Y8iqaSZSF4k
	 Zs32WVunCX3eQ==
Date: Thu, 30 Jul 2026 10:50:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add soce
Message-ID: <20260730-aquamarine-worm-of-contentment-bfbb9d@quoll>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-1-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-1-be569dae1b20@linutronix.de>

On Wed, Jul 29, 2026 at 06:36:54PM +0200, Vasilij Strassheim wrote:
> Add the soce vendor prefix for System-On-Chip Engineering, S.L.
> 
> This prefix is used by the new SoC-e Ethernet switch DT bindings.

Drop, implied. You explain here things which are not obvious. You can
also look at git history to see how this is done.

Best regards,
Krzysztof

