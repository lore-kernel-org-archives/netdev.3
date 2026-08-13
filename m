Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFE4477F9;
	Thu, 13 Aug 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613980; cv=none; b=rlavz32yG5TYiyTt4gx/IUrwOszOJPzcXOh8XrPuVotBZkgHbOL/wMlLostzDieh8LSfTkpsDFPEX2L69WTxnZvR10AEjkl5B9KG06KIODo6/sgYJuWvXEVma/MntWuIGtwdWjHonkAuGc2Ic6f5I8aW2tGJDldqj86gkPCB16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613980; c=relaxed/simple;
	bh=L4XF8uNXcjv7VRkpB761vqjJh3OcVPeaLn6SeFuDq8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ZdUbdHx/E8HVbZtiPsco0eJMWcQaYqfR6llbrQxQDyzrYlslYfrtQNdysVFITk5v4GPUjPg2gFbcpDwkHkRS2pGmwj82csZVSmwyGVevgSlueiNX+oosfsCaNxJ1vCfSpVUQn7GmXgXf3ohdkhC8TTNs05aaTw39pTDLtIAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFGByBLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFGByBLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F31D1F000E9;
	Thu, 13 Aug 2026 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786613978;
	bh=6LOGg6GoL1PEr68ZyzKCZBBrW/+LY26NLdd/zdIlEio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AFGByBLxo8ncBrW8FPbGI2kmqNHkQqM0xT6KlHKTdM3/6jtyKKZrh7SDM+soWabIe
	 ROxnPYLUCmlBuG3cVyLZupKnJOPe49rCv6np3nNZterB/AlFixfpmNrPidRfSR5XON
	 ZOE0VG0yzwZefF4C1Uc8UQKuCAkXq9m8XQ5BWCOfYpVgo6Fj2eG6PodykimKuvdkl6
	 RJ001P2GF8k8WzyZvCq60oOY4x6p+s3DZP70vrhM07iWMwwY6cxg3cQAHQ7cuxe9rE
	 IVhK4BZlFZhEEG00+9UQ3gfhhP/OS/akLpL/9mcL/7fT/XJGu1SddCvbL5ykLCtszQ
	 ROhFeNau9UEwQ==
Date: Thu, 13 Aug 2026 10:39:33 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net] net: ibm: emac: mal: fix NAPI locking
Message-ID: <20260813093933.GC196815@horms.kernel.org>
References: <20260811070813.377573-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811070813.377573-1-runyu.xiao@seu.edu.cn>

On Tue, Aug 11, 2026 at 03:08:13PM +0800, Runyu Xiao wrote:
> Since commit 413f0271f396 ("net: protect NAPI enablement with
> netdev_lock()"), napi_enable() and napi_disable() take netdev_lock().
> 
> mal_register_commac() and mal_unregister_commac() call these helpers
> while holding mal->lock with interrupts disabled. In the unregister
> path, napi_disable() may also wait for polling to finish, while the poll
> completion path takes mal->lock.
> 
> Take netdev_lock() before mal->lock, use the locked NAPI helpers, and
> drop mal->lock before napi_disable_locked().
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

