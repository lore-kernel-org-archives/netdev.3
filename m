Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186A4156C5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800381; cv=none; b=YkHgIRdjhF5W1peTYWOG6Wrp6HddlAx00+MTfqe9WFfvyZK/er5PocRu2VrtidmU7UTObT1zBIVmDJEoVKd1BJc2DqZs2BB+hcJwk9ItnVgQ/Cl4uZxH+QV/f2KDrgfpu577y5GV3uFH71QmQ8KQHqfWyCvNdP6K+7H/WsfO7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800381; c=relaxed/simple;
	bh=/aU2ElCxfvBpGFWw5b95iwicfMEJ4ikJN/NLh6ZhjPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFdk7yVPAHMP8yF9VSpMO+MSmx8Iuv2rZN3emRP8J0Cx1QceCuE8OXbF4IsKkCGHN+dzEj84d2nhBcyG5gsGwF6Il5b0pNLUevYpy7vPOmrf97PUOoX8YDKoVzZTQk9F6jSlCHjPaj9F21p0cxNbwdQSq7T9pLgatwcA48TpVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jOgu4nz9; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jOgu4nz9"
Message-ID: <0cd77f88-eb09-4993-a5a1-a70f5d4cf35e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784800376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msDwdTXG+60D9BbcKEwZ6GP5AdfrTy7HdfbNUzAYTGc=;
	b=jOgu4nz9mi0keJHpDOqFT6VehFAFsnosJS7CYNMhshGL56nn1SlgFmFwYsbRMWJH1ZrYdi
	krs/si5ndidoEMvKEfCYCy++omU+0Cja64PepBLvHCOKHcB853w+bNuej8EeWPv41LCYmu
	exGt4FSnHwtE50xwvJt3r+U7guLJXHk=
Date: Thu, 23 Jul 2026 10:52:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] ethtool: Embed FEC hist ranges as buffer in struct
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260723041342.39238-1-eric.joyner@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723041342.39238-1-eric.joyner@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 05:13, Eric Joyner wrote:
> When a driver's .get_fec_stats() handler is called and the driver
> supports FEC histogram stats, the driver supplies the histogram bin
> ranges via a pointer.  This pointer is assigned while under the netdev
> ops lock in fec_prepare_data(), but the actual data is only read after
> the lock is released; so this allows the driver to change the ranges
> (e.g. from another .get_fec_stats() call) while the current call chain
> is reading them in fec_fill_reply().
> 
> Fix this by adding an ethtool core-owned buffer, ranges_buf, to struct
> ethtool_fec_hist. Drivers whose ranges are built dynamically (currently
> just mlx5) fill ranges_buf and then point the existing ranges pointer at
> it, giving ethtool a consistent copy that stays valid after the netdev
> ops lock is dropped and later in fec_fill_reply(). Drivers whose ranges
> are compile-time constants (bnxt, netdevsim) are unaffected by the
> potential race and keep setting the existing ranges pointer to their
> constant array, without making copies.
> 
> Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
> v2: Take Vadim Fedorenko's suggestion
> (https://lore.kernel.org/netdev/f136bfb9-1756-4668-acc3-68962cdc6069@linux.dev/)
> and keep the ranges pointer for drivers that use constant ranges arrays;
> only use the new memory for dynamically constructed ranges.
> This makes this patch mostly an mlx5 change.

LGTM, but we definitely need a stamp from mlx folks.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
