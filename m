Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFB3612C5
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344168; cv=none; b=oq4lhIa1EnWpkguslL7cqzVa1wHsdqgXFrGBM9FL4pmJLtumyLBImQ7f0G52RWFM0nXlth8uG2w9/WINza4zX4hLjzQJvAsHpE5LKsoAejo6uTjZlGx5dyiplVkq57cGHr9aKVjBWzpNHeRosVUI+O1hPdrufWfGwYjldunP+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344168; c=relaxed/simple;
	bh=hBEexpGsozqVjbTeslIcUOnyqc3sUtF0rSAocoEUWZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiD58pXafsst2JoW16ajkYHKFbOiBzJ1i1hxM/dm109xb/kVq6nbjuBb9o1fLD1I5PesiVW7UsTOPgC0cIW15yasCua7FJajQxSSPhwgwIBvEZyxTAqEJWGjiEQV93GcEEXzliN5iM+J7ufMnMU+Ukxc+p4LO990gqEqSd5Dejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skTtSccc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skTtSccc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AAEC4CEF7;
	Tue, 17 Feb 2026 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771344167;
	bh=hBEexpGsozqVjbTeslIcUOnyqc3sUtF0rSAocoEUWZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skTtScccmxAYc2fCV+llebuSnOH0aXB4HxnnZnEdamb3UR4gG7gtAWvMYoM4UbX5W
	 uoCLUNq72Uf9ekmy60e8THR8p4Et9zHIZGJT7U4B9b468gkj0hziBJr7x7ZoyADwVf
	 wyZay0v3Dzc0aV6Z7V8di1muRnRxXfndBhV/i2K8gO/Dkucu6yS/6iGN1LU5lFJ0k7
	 J06TWLNb5PazNbXpOA3V0zZnO5f0oiwHLsw8sWXoYWPATqrUKNpbKdhGnn5ob175M5
	 uOUxH7CPsX48s7FFKEj+iBEyzwmnIpjxP7ZXYBN4bO58+smjmbgHMVZ/Hl56LpNBiu
	 eajpvZjA5EffQ==
Date: Tue, 17 Feb 2026 16:02:42 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	jedrzej.jagielski@intel.com, kohei.enju@gmail.com, kuba@kernel.org,
	mateusz.palczewski@intel.com, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com,
	przemyslawx.patynowski@intel.com, witoldx.fijalkowski@intel.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix out-of-bounds writes in
 iavf_get_ethtool_stats()
Message-ID: <aZSRIh9Xz2q-PUaS@horms.kernel.org>
References: <aZMZTTXWtIO1ERpm@horms.kernel.org>
 <20260216144457.19871-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216144457.19871-1-kohei@enjuk.jp>

On Mon, Feb 16, 2026 at 02:44:57PM +0000, Kohei Enju wrote:
> On Mon, 16 Feb 2026 13:19:09 +0000, Simon Horman wrote:
> 
> > > @@ -345,19 +344,19 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
> > >  	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
> > >  
> > >  	rcu_read_lock();
> > > -	/* As num_active_queues describe both tx and rx queues, we can use
> > > -	 * it to iterate over rings' stats.
> > > +	/* Use num_tx_queues to report stats for the maximum number of queues.
> > > +	 * Queues beyond num_active_queues will report zero.
> > >  	 */
> > > -	for (i = 0; i < adapter->num_active_queues; i++) {
> > > -		struct iavf_ring *ring;
> > > +	for (i = 0; i < netdev->num_tx_queues; i++) {
> > > +		struct iavf_ring *tx_ring = NULL, *rx_ring = NULL;
> > >  
> > > -		/* Tx rings stats */
> > > -		ring = &adapter->tx_rings[i];
> > > -		iavf_add_queue_stats(&data, ring);
> > > +		if (i < adapter->num_active_queues) {
> > 
> > Hi Enju-san,
> 
> Hi Horman-san, thank you for reviewing!
> 
> > 
> > If I understand things correctly, in the scenario described in the patch
> > description, num_active_queues will be 8 here.
> 
> Yes.
> 
> > 
> > Won't that result in an overflow?
> 
> I think it won't overflow.
> 
> In Thread 1, iavf_set_channels(), which allocates {tx,rx}_rings and
> updates num_active_queues, is executed under netdev lock. Therefore
> Thread 3, which is also executed under the netdev lock, sees updated
> num_active_queues and {tx,rx}_rings.
> 
> The scenario flow lacked netdev_(un)lock, my bad.
> 
> Thread 1 (ethtool -L)       Thread 2 (work)        Thread 3 (ethtool -S)
> netdev_lock()
> iavf_set_channels()
> ...
> iavf_alloc_queues()
> -> alloc {tx,rx}_rings
> -> num_active_queues = 8
> iavf_schedule_finish_config()
> netdev_unlock()
>                                                    netdev_lock()
>                                                    iavf_get_sset_count()
>                                                    real_num_tx_queues: 1
>                                                    -> buffer for 1 queue
>                                                    iavf_get_ethtool_stats()
>                                                    num_active_queues: 8
>                                                    -> out-of-bounds!
>                                                    netdev_unlock()
>                             iavf_finish_config()
>                             netdev_lock()
>                             -> real_num_tx_queues = 8
>                             netdev_unlock()

Thanks, and sorry for missing that the first time around.
With that clarified in my mind this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

