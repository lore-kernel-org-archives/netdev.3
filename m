Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C943D904C;
	Wed, 24 Jun 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313605; cv=none; b=mLMIMNgjRbd3wZEWFHByLelz3/+NfgSfhl7O1HjJpauHA4oe+YPTD6Y1UFcfGfNISilfWGSFFv8D0kcD2jak/s1QJDLFvPHhZ57JYSRIBKIZRD6qynv6GyKoDjPodojFWrXNrKyovMb2CZo0a7WK+0F044B5caMhBlIna5Yd/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313605; c=relaxed/simple;
	bh=af6WJzIVd586R6XkT7yRH10qMQFGseYAs742oBJgF84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJCFYOOp2QlDFB3MPGyB86Bd4nBRbLlp97lbdHbEnMthGV56QYL5mAHrxjM79JPSfCgTJn4jzeDfGdyOmYrZNCcXgHzvaHenAfkJA+H8pKXaZBZcuWi0FrOm6d8Yn2VmnI8t/PWQVF8jsmn16yUdKINeb3df9Cub6PMRDKtABxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UToh5Ibk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UToh5Ibk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C21F000E9;
	Wed, 24 Jun 2026 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313603;
	bh=00Z79zZoGaKHbY5XnwVZGDnR2xoExRHmlMJRULFj9ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UToh5IbklrZDG4b5Ewdcc8fkp7Rf+1dI+h6skVkRb83RENMGe2qcIMOemHFpI0SsE
	 nQVzUR/PVjBmZ1v1PNAX3qMW43RXW/+m2Vvd/dVft8qcPbKdqudlRxQXcu08ATOqPz
	 UWa/73q4ldZvepEemy1rOZd3sVjTHtYAoZhuvOKMERX60zDvpA0YHuExsbwkSO1wD1
	 CJSE9bM6218Z5ia3XqAruhA0JF2SLQPaEAlWsks1VIKZcxRaDGyiycuFPbMRC44HzT
	 +4qgfASTb7NRqeTKa1mWs6y4LwfXhKVN/GW4JnETj+EsI+3Bh9CEXKtVfrH8TQGz1a
	 KHON9ZmI5DTHg==
Date: Wed, 24 Jun 2026 16:06:40 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: sungem: fix probe error cleanup
Message-ID: <20260624150639.GA1131256@horms.kernel.org>
References: <20260623025759.3468566-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623025759.3468566-1-ruoyuw560@gmail.com>

On Tue, Jun 23, 2026 at 10:57:59AM +0800, Ruoyu Wang wrote:
> gem_init_one() calls gem_remove_one() when register_netdev() fails.
> gem_remove_one() unregisters and frees resources owned by the net_device,
> including the DMA block, MMIO mapping, PCI regions, and the net_device
> itself. gem_init_one() then falls through to its own cleanup labels and
> frees the same resources again.
> 
> Keep the register_netdev() error path in gem_init_one(): clear drvdata so
> PM/remove paths do not see a half-registered device, remove the NAPI
> instance added during probe, and let the existing cleanup labels release
> the resources once.
> 
> The issue was found by a local static-analysis checker for probe error
> paths. The reported path was manually inspected before sending this fix.
> 
> Compile-tested with CONFIG_SUNGEM=y. Runtime testing was not performed
> because no sungem hardware is available.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> v2:
> - Add a Fixes tag.
> - Describe how the issue was found.
> - Add testing information.
> 
> v1: https://lore.kernel.org/netdev/20260620155326.80582-1-ruoyuw560@gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

