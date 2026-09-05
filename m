Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D31282F1C;
	Sat,  5 Sep 2026 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572674; cv=none; b=UTdcHylK0DBTHT5CKDqKokPQAH9W+NkqINuTXfxOWjQQgOwiLmPuavow6Jrny8o0uPtt0J4Ow5fOgo0p4olIJsKtNNnBuAFrm5shrUSEon+U4p1mpWOg+P+X2Jn55qEkhmQDvDAUs+AlDkpdwmBLmAt7xLT+M6Xs3KBa7rENHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572674; c=relaxed/simple;
	bh=mq/PKKU3QC6tZ88dzDiqjdpKPJxivWXKes9rrwtDd00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVTDQqUJadHxYiBvFkv0NWinBpOfxlp+xW+WfFlJHnJBVY29XklKNL9iGwr3PLf9IlBrwWW/9W255uWiUARmfmzpaMOHF9YwEw0lEcGnkxKoGEDD6O3CGyA/QFvF9DelYF455KOfGxhCGxzbcMpV6wfWgY86SFnivwhYHBKax5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOZWqHw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOZWqHw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96881F00A3D;
	Sat,  5 Sep 2026 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788572673;
	bh=RtCepbsVnIiv1BwCgcpAIdkzWkfGkVZQNUx8DmzI2Xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VOZWqHw9jqJU6ugXyInzqxP1Qv3BEpLFCNkjwyQgwJF0mqcjhaVrBpYUnkPZmudKH
	 5TnXc+STML6yOIp6mXpLcIqZEJ0ggKQjk49LPZdvBWw2qqt+5wwjwn9CJqbiOBi6l/
	 TKROscEGaR3ACOhNqbqFKkrVP3H2AugfQUfM4vQi+8sj4FAE3rVFEIGO9ZuJt0ggjB
	 GnX9N0LEU7bc/wfaXKDNoW8b3g3jgv+VT/ma0bs5FzJwjzHnj7m57lTvneD5I5dnx4
	 BKttE275RPDojAIsb8yoxt4cjg07/AO67iAzVrXotWhNHJ7UewUO0+ypysypSXI6t5
	 VkdE1wkZ/dRLA==
Date: Fri, 4 Sep 2026 18:44:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <git@amd.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: macb: detach netdev before closing on
 shutdown
Message-ID: <20260904184432.02fd59a1@kernel.org>
In-Reply-To: <20260901142541.1469544-1-vineeth.karumanchi@amd.com>
References: <20260901142541.1469544-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 19:55:40 +0530 Vineeth Karumanchi wrote:
> macb_shutdown() calls netif_device_detach() after dev_close().
> netif_device_detach() only stops the TX queues when the device is
> still running:
> 
> 	if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
> 	    netif_running(dev))
> 		netif_tx_stop_all_queues(dev);
> 
> By that point dev_close() has already cleared the running state, so the
> detach only clears __LINK_STATE_PRESENT and the netif_tx_stop_all_queues()
> step is skipped.
> 
> Reorder so the device is detached while still running, letting
> netif_device_detach() mark it absent and stop the TX queues as intended,
> before dev_close() tears the interface down.
> 
> This is a cleanup with no functional change: dev_close() stops the queues
> and quiesces the DMA/HW via macb_close() regardless of ordering, so the
> reboot/kexec safety path is unaffected.

I'd guess the driver is trying to clear PRESENT so that the device
can't be opened again. It's not about stopping queues.
The patches doesn't make sense to me as is. You say yourself that
the move is a nop.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 76ee4f506033..21ebaee00f9e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -6246,12 +6246,11 @@ static void macb_shutdown(struct platform_device *pdev)
>  	struct net_device *netdev = platform_get_drvdata(pdev);
>  
>  	rtnl_lock();
> +	netif_device_detach(netdev);
>  
>  	if (netif_running(netdev))
>  		dev_close(netdev);
>  
> -	netif_device_detach(netdev);
> -
>  	rtnl_unlock();
>  }
>  

