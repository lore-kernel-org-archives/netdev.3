Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8F3D34A4;
	Tue, 18 Aug 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069218; cv=none; b=nnoUmLgyrXzJAnq2rQ5ldg/amH+GG+ppmQEMYF4RB/sxnFnvJIw5IDBpuq5bIBmwfYDwdKxFgYw+o6Ce+UPram9fwtFYZg3xZO/d5TyUtCjhdXI3RY4lHUaujLVcdLWFHZy4YTXopAyNazWUcly+wQY0AJxBGykt0MN1253hHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069218; c=relaxed/simple;
	bh=ogRGQQYJ6AKsXsZBhjXGkux8MUh5uJ0mphKF3Ui6X1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb+Us3o09EWtn4eGNdRqzliu2w+uPTIIxUAoNspTpkDW+jM4kWukUsLzZKa7ROt+lcIJra82ejirbatRUegnPUixvJEV5hNDi+/GE8IpnYdv3LLrLPV9/8d5E58TnHycnSPg21Z+l1BuX74KwlTVa9dAKfAWpu8ebZDm3Dqtzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTXhLs8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTXhLs8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E8F1F000E9;
	Tue, 18 Aug 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069216;
	bh=P3q77nsKUuV5Ur9mTpeFCB7unuzEABVbHObWrwEIitA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JTXhLs8aRsrmWKNroKyniSGSxFXQhiKu2RuFhNutzB5hZWh2blsSgnCxqGiVQSaye
	 zXNpoHuiIrysj0uRMS715KFEJFYrX6durnbXQ0l9h9TZ3L5lMAsGwvT3PmskcnagKR
	 SuH+XLoWOF3eCrjRDxJxzRhsQvB1999G8Yv0DG51ZT2F8LboB72/y5TMpp/Uk7Fbya
	 ItI3y+jMKy5rJ4XDcnt5/fWrsQRd4QUOlvc2pU6JlPgjou+rG8NDtaNkF6hbIXD9fH
	 yDhI5I4ivdppT9nGZaqsIqo4lV4bW0dzGUwjr7RzLOt8y6oie7/CIHgWm6hjKZzL6S
	 dJl+WgSPPVbtg==
Date: Tue, 18 Aug 2026 09:06:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v6 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Message-ID: <20260818090655.1e28cd61@kernel.org>
In-Reply-To: <20260812-fix-race-condition-and-crash-v6-3-6cf90f4a271a@onsemi.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
	<20260812-fix-race-condition-and-crash-v6-3-6cf90f4a271a@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 20:00:11 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> +	/* disable_traffic, when set, is a point of no return to working
> +	 * state. TX queues are disabled. In some cases, upper layer or
> +	 * vendor code may inadvertently enable the queue. Intention of
> +	 * the disable_traffic flag is to stop traffic from flowing.
> +	 */

I don't get this comment and why this isn't part of patch 1.
Patch 1 is the place where the stop is removed:

-	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
-		netif_stop_queue(tc6->netdev);
-		return NETDEV_TX_BUSY;
-	}

Also the "vendor code may inadvertently enable the queue"
is some vague indication of a race? I have no idea what "vendor code"
means here, this "library" has one user. If there is a race please fix
it. If there's not - please don't add confusing comments.
