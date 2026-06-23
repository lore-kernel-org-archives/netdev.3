Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC93D567E
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217356; cv=none; b=ahQBddDE4L5n7dGNRy5BbNhABhY3XZSkFU79elyUSpVhWh3KixJaD3WP9DZWg0dWBLcTGqyiW5qFZveH8cFWuX8WTR1BDUxlB8K/VA9MmQHio45hwpHwBb5bb1iDHxNluMXbDxw7xB5SaHH3MQidgsl1WpT0uiDX6X9Dsovy6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217356; c=relaxed/simple;
	bh=LH/VnGgCnFwSj9VN7+GY3WRshzT8ch55U7m4NbeUxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sndC2e54uPMeO+XKSa8NaxyJDZ523lPc3udFncF1Vr27VNf6pl8Og7K1c8nKM18uLJmnbkIo/zpvpHc12bdCUc7XRGMBvhv8dtW5JCHQF4U7A23+JIKkKH6Wlh6ds74fUaOGPO3BjSBKiuonYuFfNV+4iTVulWlpYEcWET3+RAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag5Hm+RN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag5Hm+RN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A061F000E9;
	Tue, 23 Jun 2026 12:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217354;
	bh=MVDyPTjerdOBmT+C67OudtG1LBzc9F1BxwLCyBzR8hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ag5Hm+RNMo+r6yIvjQMLwIJvPs0VMtJdS8EGJegKp4b5iax6ryfCSfvWAa29xCJSx
	 ob1ItoXIQYRHROsAHA2N+FwAYMOluOfQxAYR32IP5wH9XZN2dYMMysBcFYRty2bkVG
	 5rbmjUsIAAzpZdfm57nk9TKcrjVgpA533uZ1SKsnoeFfUNFumVJT7wp1cQTW+DPBO0
	 7Q+XJB0HKniWbooYsDAqdMB1e2hTRKjx1ulwBaHT1E/TkuY2Xc+1tZAJtfK/yLZayA
	 Sy33aAsKhsRMyM4e1U/UxrCRU40uSPM2QnVqNrxl7ZIVZqzjtTgV2AOYfu/99rA6mr
	 9E2hQWB/hZLOg==
Date: Tue, 23 Jun 2026 13:22:30 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH net] net: do not acquire dev->tx_global_lock in
 netdev_watchdog_up()
Message-ID: <20260623122230.GK827683@horms.kernel.org>
References: <20260622110108.69541-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622110108.69541-1-edumazet@google.com>

On Mon, Jun 22, 2026 at 11:01:08AM +0000, Eric Dumazet wrote:
> Marek Szyprowski reported a deadlock during system resume when virtio_net
> driver is used.
> 
> The deadlock occurs because netif_device_attach() is called while holding
> dev->tx_global_lock (via netif_tx_lock_bh() in virtnet_restore_up()).
> netif_device_attach() calls __netdev_watchdog_up(), which now also tries
> to acquire dev->tx_global_lock to synchronize with dev_watchdog().
> 
> This recursive lock acquisition results in a deadlock.
> 
> Fix this by removing the tx_global_lock acquisition from netdev_watchdog_up().
> 
> The critical state (watchdog_timer and watchdog_ref_held) is already
> protected by dev->watchdog_lock, which was introduced in the blamed commit.
> 
> Fixes: 8eed5519e496 ("net: watchdog: fix refcount tracking races")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/netdev/a443376e-5187-4268-93b3-58047ef113a8@samsung.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Simon Horman <horms@kernel.org>

