Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F51F63D9
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627598; cv=none; b=ONXPXVxzzS035pNKNzBh4sMSv7S4FrmCBeSczLLJzea/wznTqIBZyrl4JU3KL1+yl/E8eVkGYnkE/wEB0CZho9fE0jXx21YapjPJn1uk01OPBM9hhbbIzTg92F5FpTMOzgX8zEGB3z/SOQ0iKZz3k6lE3XwhBsAw1GDmthjv4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627598; c=relaxed/simple;
	bh=YIVhdtanfoG7q1HePw2+YiABT2b17z337g/4wnGX8ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR5OhBTx87kd/2pWWXg9gF1lzdOhWdp9c3vkCXtpejljXyddQHrbf0KbXCFqiNh8F2RC5HaAD3TmqilBVLGFWQhatrnBI+xJ9DdF3gR717t9F+tyX4iP3Ud3PfVkIE4iBbnl1Ga/BBtJEf/N98rMXulAYD8707kNK1Vcbc4UoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epV4iXjc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epV4iXjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F691F00893;
	Fri,  5 Jun 2026 02:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627590;
	bh=YIVhdtanfoG7q1HePw2+YiABT2b17z337g/4wnGX8ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=epV4iXjczXGYHrE9DNUki4BJ/7TV8yV5EBtfP3kQNuhzzqpXEMe9ZoY/3k1kAvWxh
	 ZRirA3w2SNMuFZBZDq3LHSXWh0lnKHRNFOWquBMdhc7Rjkxa42H+THAbobnIIfX5Lq
	 RPsQyCMLVAm8isW6iVjCtL+z+ORsPuc2tYY+wipyQgOKeiB7TdKOg7vXPtMdtFEKgq
	 xdVN4/+i+5myEoN+rfDhyfQihSpWwHQdHfflxnaJwiJWL/8Zir6OJl4AZGwLd0ZSb2
	 6IkUJd/9dEKAxTD56+Vzt8DPHZ7CPBw0ZIIafmUiRZB3+voekIEe1wxUhDKtuSIIxJ
	 mL/lIH/9dUHZQ==
Date: Thu, 4 Jun 2026 19:46:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net] ethtool: Set histogram ranges to NULL before
 querying FEC data
Message-ID: <20260604194629.45a3ef03@kernel.org>
In-Reply-To: <20260604225440.11083-1-eric.joyner@amd.com>
References: <20260604225440.11083-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 15:54:40 -0700 Eric Joyner wrote:
> If this field isn't set to NULL, then drivers that set the non-histogram
> FEC statistics and don't support/modify the histogram fields will
> trigger a WARN_ON() in fec_put_hist(). Drivers shouldn't be forced to
> set this field to NULL if they don't have a need to touch FEC histogram
> reporting, so set this field before the driver gets the data structure.

&data should be zero-initialized, how is this patch not a nop?

Are you sure this can trigger unless the driver is buggy and sets
ranges without reporting any values?

