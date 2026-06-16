Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298702882C5;
	Tue, 16 Jun 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781644879; cv=none; b=GVOnSiRpwYoh/1UgccwsGdhZoQWVEMcIUfLkhIbfbpB7lJyF7LVZ/m10DYH7wT5wjf7rRPLBx6BTGI0M+vCYrAN4OB5kYzJxtTrr2lngnhWtf2qUzec7DUVgw/xGuwcMGWg5IPAQuaipW09hEqR6RkWX285d1MB4t0R4wUsJxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781644879; c=relaxed/simple;
	bh=1Tv5/FnFyi6D+fKZCd/Z4zN0OO59xLBI9zeOH/aArFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5OfE9sOCu1rZ0Lxe9ESC0ppSQ37owBu4atHsQRfwwuS+fapONnbDTcrsK+xuS7jsbSzHymoQ6DiEqobWNMgZykzE9NDxwRKb7wULd+qYnIyon/lheArg5Hk0ppEbm/MGmPkQbGEJFFkEqnHeWKmvwQh38sSlnUChFe0AITTBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rlke8vdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rlke8vdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FF41F00A3F;
	Tue, 16 Jun 2026 21:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781644877;
	bh=F9tJ8J+1YWFhgXIDv2qG/wlrFsT4MjPbuiDu5CVNtus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rlke8vdQM9yJeswSAxiqSkZ4HFICgvCP0im/gOYdMNBldqbAXlLMQIo9OlzkKUnqD
	 4Wd1pbTBb9SIbvlGVX2o/y+FYHQ58k0cw36aokN8lVhDE7SvWMUnLvp9kfjeNNt2lD
	 R+0tNOZ5rSVaJzomIk49YNpOwyGXiLq5mPXaGh8oLEMNoFtj+Xt2xas5FaF9Uqget3
	 e81LVxx1Fyb1CRa7DPL+lSYJhjUyt/7XBVANGAbei8PP20CkDXPEmAD0607e6jk54l
	 pRo+jv8y1TuWheTFVHqygmmY6B+qGOdqpZ3sbkd529x1xSv9Jy3fs27Qv+XhVkj16G
	 z23obFjtBxfPQ==
Date: Tue, 16 Jun 2026 14:21:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Lee <skunkolee@gmail.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: faraday: ftmac100: convert to devm resource
 management
Message-ID: <20260616142116.51831811@kernel.org>
In-Reply-To: <20260616203233.55234-1-skunkolee@gmail.com>
References: <20260616203233.55234-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 13:32:33 -0700 Jack Lee wrote:
> Replace manual resource management with device-managed alternatives:
> - alloc_etherdev() -> devm_alloc_etherdev()
> - request_mem_region() + ioremap() -> devm_platform_ioremap_resource()
> 
> This simplifies error handling by removing manual cleanup in error
> paths and the remove function, and eliminates the risk of resource
> leaks.

net-next is closed right now. Also:

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject
