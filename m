Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4313B58A;
	Wed, 29 Apr 2026 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423126; cv=none; b=pHudqB3I4G6JmF6yOLYvtfec+aZyYkafLSJ1TfQ7dEhypsPDrkAl4dU22Pfu/Jh14ASgowaiOgwmfoNxypnqXG6t9/UinHzPE+9VXB/iSmtKkXvoM7S9gWv48MQEudf1aOiVoudRL4X/+OXTdEZjgbigEnvU6ZmksjdFp2zq1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423126; c=relaxed/simple;
	bh=xJelKp5dXphtLs1h9nUKyIqYRLi6PAmKwfXU4R+9K3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMDN+6RAC+gDQK5N0t9KYoVBy/qAY7Mr7u1SFwirOjPFigIGo1o4paL8BmUak/z7tKIZYNAin38R9wKE4ZGg6gxsY3b4hpm9qmL/x3cvm83bxX2oVi5m2DSEZpz0nn0a1dyRfoyGD+5b+1jC2wwgeQzznXB7S2FfNtDHb33rMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guL2P1Vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guL2P1Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD66C2BCAF;
	Wed, 29 Apr 2026 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777423125;
	bh=xJelKp5dXphtLs1h9nUKyIqYRLi6PAmKwfXU4R+9K3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=guL2P1VjZEmZ/mnHsup1H6KDSO2e4q47YHAzKi42UDA7xiEw6oHPEhI06LBD7FKQd
	 1xHatDwSm6zCanbcVzLKFKqATTgSZOU1/tPLgUj3rFlpsb4dMBAGG83K+wC0HSdVQE
	 DCw4jh+a2HzAebA1fN4E2kjpI586gqmGenQ0Kb7qR/yah/w1Ti/eKw4T9GzCLYakRl
	 WftHM+9Qu4YxXessaUjdm9WiG1hpu36YfrjMjs9sYSrQOJrpKXmb4vn+YXqqH43B8c
	 NSliWYb5Mxe7UswJ0ZwpHwlT8hUq+wBshvPPi/S1YEF6KZ1D01K7Nh0Gm3iZ/mEqa7
	 L+xnrOQguYB7Q==
Date: Tue, 28 Apr 2026 17:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Martin Karsten
 <mkarsten@uwaterloo.ca>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, Frederik Deweerdt
 <fdeweerdt@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <20260428173844.1354aabe@kernel.org>
In-Reply-To: <20260428175134.1197036-3-dtatulea@nvidia.com>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
	<20260428175134.1197036-3-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
> +	local_irq_save(flags);
> +	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> +		      HRTIMER_MODE_REL_PINNED);
>  	clear_bit(NAPI_STATE_SCHED, &napi->state);
> +	local_irq_restore(flags);

I don't think disabling IRQ is necessary?
Isn't it legal to clear the bit first then schedule the timer?
The timer does not own the napi instance.
