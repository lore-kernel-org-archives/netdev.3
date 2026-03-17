Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983014594A;
	Tue, 17 Mar 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777931; cv=none; b=l6AP1TNK8gb/68FYvV3Ol3EUmdPY6gBEzNoiMat5N+RfzBYL3l2aouZTy2bI8JN7CpCj5TYbPDM5eScLh7esGEfbHVLqnblzHILaaUfqfWwPIcNleWgr2B4unmfhPbP04sKwgyHML5mspO2J7waGXC4foGpaWCgT4uLEqPD8AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777931; c=relaxed/simple;
	bh=1Z1mAp6/h90P/C/Wk/Es/v8k+aTzV6mkLEU0vlVt4aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jokUEUnfLgDVYt7fkZvHDsYp68+LGEhzZFt9gwzn5Wbm0b/cCY/yAwTpgJKDU+vCrbTMTpZCMmdQyNq9LHTarOXL7oBZo6njFccx8UW62yce6E4USpTEx5P00cnDBv+llnAg0xhPQ/JghSOTAQ7YbH5Q4O8zYqrzj8CDxuM9mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sGL9KQ+1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sGL9KQ+1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w7Mp6mlzCrW5RSiQUh8DAfWT/dVaZ7BMs2xgRQ8dpm8=; b=sGL9KQ+1sKNgyRVhmNUwawGKAm
	oa3bKuqpJ7RhE+4haJC5cVbCZcKvNT51LKyTpFA2D8R9kZOq55V02WmBuMH4aTkh9roF593m6+Olz
	ymSd8DqA0mig77iuPJfltyuNY2qDt1YMiun2ET1zLUQDdwGMiUPklL1qF/mlXBVS4QH9QJVOLe/x4
	Jg+CVyP91EmgJ70L5qd6f5zLww/3ca51cV+ACQgj/bHEIbmG8Mv+p5mQLPFLn1cjFEKOiD47tspwg
	R9fXpGNIJu8RBc9MdiRG53EP3Vdw0CPA41pJimEdwgY11ne97z3rBU986mvbYHYOaZFA0+87+3Rxo
	Q7ej5rAQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2afQ-00384f-Ta; Tue, 17 Mar 2026 20:05:27 +0000
Date: Tue, 17 Mar 2026 13:05:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH net-next] ppp: require callers of ppp_dev_name() to hold
 RCU
Message-ID: <abmyig2dVODQYTnX@gmail.com>
References: <20260316092824.479149-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316092824.479149-1-dqfext@gmail.com>
X-Debian-User: leitao

On Mon, Mar 16, 2026 at 05:28:23PM +0800, Qingfang Deng wrote:
> ppp_dev_name() holds the RCU read lock internally to protect pch->ppp.
> However, as it returns netdev->name to the caller, the caller should
> also hold either RCU or RTNL lock to prevent the netdev from being
> freed.
> 
> The only two references of the function is in the L2TP driver, both of

nit: The only two references of the function *are*...

> which already hold RCU. So remove the internal RCU lock and document
> that callers must hold RCU.

This symbol is also exported, but, we don't care if external drivers
call it without holding the RCU read lock.

> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
