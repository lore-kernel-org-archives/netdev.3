Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343A4FE2CF
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744367; cv=none; b=cErhVgIArZNY2hAkuOAQC2PZD4aN7PrJ2Gggdig5mDhU/MjI3rG5voeXFVAlI3f6Gsp3UkI+k8BboVzCDcXb0q0R9BDkJJNi8226/YqGgEBym0oi/Av2XOrwsN25F3s86dttnTSLzQixYyDnIUvAtM0iGxU2yDO1Ol5hqRwVkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744367; c=relaxed/simple;
	bh=AfATNlyz865HGbjategr5Z0V4FAybPE6ybgZYJtAQdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE6YqaYR5a3RT9EUxO7l7/NAuRz0J6Lz+z8B9LwOTb45wdStx/OPy5OYP1Xy4I6ua45VEnEPR973nBaaetcDpNoaATiWw0Wp4Z8F28VvI88Ab39+/n0lgEM/OvhlPh8o+adicsT0fimutxkGZHD1uvFqgiER02/0qkurMSPNEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpx0ZPZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpx0ZPZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F40E1F00898;
	Fri, 18 Sep 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744365;
	bh=BDTa5eGNRHtyidtFIAbfYZfxCv24hJn3EuLA6apZr+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qpx0ZPZmWDyphc2im9c0d6ZzVdP5wUuNmPQdKDAv0Lc6HC2ZtGwGxaT/m6w4y/rNL
	 sjIBbfN4zXCWA7g/SMYe45da24D00KX9ovazOSG9UtvH+htUvBrg6gDb/dV09lbTnZ
	 TD9FX/6Z+qE8LAsj+Pbk04qlVxQdTQTQnQJVbAxNRQA8tijq1RlRHbeGQC7ii4RVvm
	 GfpFNCBRj4IO9414HBFjY+qV8oeUhQOMRaJAsF9Dq1ohgnY/JpAayWl8ObNpO3DHY3
	 CWj3iqGqsFiXU3lBd/OCl8zm1Yv57b+BY9y5TKE8rvD2+FUMEimi0msi84w7YZV0Wj
	 JxBEh9m4sbUeg==
Date: Fri, 18 Sep 2026 16:12:41 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Subject: Re: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when ring
 params changed during reset
Message-ID: <20260918151241.GM51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-4-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:49PM +0200, Aleksandr Loktionov wrote:
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> Changing ring parameters via ethtool triggers a VF reset and queue
> reconfiguration. If ethtool is called again before the first reset
> completes, the second reset races with uninitialised queue state and
> can corrupt the VSI resource tree on the PF side.
> 
> Return -EAGAIN from iavf_set_ringparam() when the adapter is already
> resetting or its queues are disabled.
> 
> Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 1cd1f3f..3909131 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
>  	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>  		return -EINVAL;
>  
> +	if (adapter->state == __IAVF_RESETTING ||
> +	    (adapter->state == __IAVF_RUNNING &&
> +	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
> +		return -EAGAIN;
> +
>  	if (ring->tx_pending > IAVF_MAX_TXD ||
>  	    ring->tx_pending < IAVF_MIN_TXD ||
>  	    ring->rx_pending > IAVF_MAX_RXD ||

I believe I reported this for v1 as well, but AI-generated review reports
a TOCTOU issue here. And I believe a similar, pre-existing, problem also
exists in iavf_set_channels.

Text from
https://sashiko.dev/#/patchset/20260915125551.3976068-1-aleksandr.loktionov%40intel.com
follows:

Could this state check introduce a time-of-check to time-of-use (TOCTOU) race
against the background reset task?

The background iavf_reset_task() relies on netdev_lock() to serialize, but
ethtool callbacks for drivers like iavf (which do not set request_ops_lock =
true) are executed under rtnl_lock() without holding netdev_lock().

Because they do not share a common lock, the background task can acquire
netdev_lock(), change the state to __IAVF_RESETTING, and tear down queues
immediately after iavf_set_ringparam() evaluates this condition to false.

Will this lock mismatch also cause a lockdep splat later in the same function?

iavf_set_ringparam() proceeds to call iavf_reset_step() directly:
drivers/net/ethernet/intel/iavf/iavf_ethtool.c:iavf_set_ringparam() {
...
	if (netif_running(netdev)) {
		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
		iavf_reset_step(adapter);
	}
...
}

Looking at iavf_reset_step(), it asserts that netdev_lock() is held:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
...
	netdev_assert_locked(netdev);
...
}

Executing iavf_reset_step() from the ethtool callback without holding
netdev_lock() would trigger this lockdep assertion, and allow it to
concurrently step on any executing reset task.
