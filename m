Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0A4FDE76
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744291; cv=none; b=tv8L5SG6HH4tQrjIZhibh/ubUkhUNqgG5tEt7QNRJsRLCgZBrfCee0PStKWYSKyBX6WFqM4lHx6kIsX8rjMce2R1d6G8N3oHWOw3IAcWXlspLrWCE6WKNGe9Ykupxrk7v7gXzcolcZMt80mePVH75x6KKDN8rUK8KjCu7lEqqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744291; c=relaxed/simple;
	bh=t6i5hOsL5N/epOj3KSeCQjd181ZLIpjpDMY8AjvbP0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk1WlLHDR9u9fDVzPf2RoVURS+RscQWkJL+5iqEnbnsQ5+GH4nmSWB8xP1mpBvqD698RwqupQ7HasRzksBh8JLw2wSqTeSJCVnE4GxjmPynsAK/3T9klOsTxDt0j9wExtZyldU/bAnni/9HhJ+oglIrcD2/6CCDEo4Tp5ixUVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNsGfBKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNsGfBKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA7A1F000FF;
	Fri, 18 Sep 2026 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744289;
	bh=JXiKbnmtcf/cIsTGuRbVQ3ukx8D/M7r7CKQczwX+sKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WNsGfBKgoz1ORupGnkyLLjQwPWP/k8VyZna4EIDHVqVcxJ4yOxlAS9n6ATTAnKHxA
	 5uKLFazgTKPN5GruN1JqC+6p+cgE4Wc1mYhKZPafYWe+er9aaYZlL9yxjszct5S2SW
	 tE6Bqqtj7DPUQJueRbt5V6mAkOqmnvKW0oeSSgO3sNS2jtlzi2odoWoBCGFLLzwoo9
	 hVFFH8QUOWhEKhYxlJH38cpgflZVk32TGZdq2ukUrr1D68quGqockrXCuTE3nu4d/h
	 rnILct2jB8BNKKGyxGQDYX7YX9CKdgeSNO3J953dJ1S/G9jC7PElLxaJgE/EnaXCon
	 QtQ0dBnBHutRg==
Date: Fri, 18 Sep 2026 16:11:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Message-ID: <20260918151125.GK51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-2-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:47PM +0200, Aleksandr Loktionov wrote:
> From: Kiran Patil <kiran.patil@intel.com>
> 
> iavf_watchdog_task() and iavf_reset_task() both run as work items on the
> same ordered adapter->wq, so they can't race with each other. However,
> iavf_set_ringparam() (and other ethtool ops) call iavf_reset_step()
> directly from process context under the netdev instance lock, without
> going through that workqueue at all. iavf_reset_step() can free and
> reallocate adapter->tx_rings and the q_vectors array via
> iavf_reinit_interrupt_scheme() while adapter->state still reads
> __IAVF_RUNNING, so the watchdog task can concurrently call
> iavf_detect_recover_hung() and dereference a NULL q_vector inside
> iavf_force_wb(), or index into a NULL tx_rings array, causing a crash.

I am concerned that iavf_reset_step() is also called from
iavf_set_channels(). And in that case the netdev instance lock is not held.

> 
> Guard against this by:
> - returning early if vsi->back->tx_rings itself is NULL, since
>   num_active_queues can still be nonzero while the array is being
>   reallocated;
> - skipping rings whose q_vector is NULL;
> - reading tx_ring->q_vector once with READ_ONCE() into a local variable
>   and reusing that same value for both the NULL check and the
>   iavf_force_wb() call, instead of re-reading the field right before
>   use, which would leave a window for the concurrent reset to swap it
>   from underneath us in between.
> 
> Also move the tx_ring declaration into the loop body and drop the
> redundant outer NULL initialisation, which the compiler can never
> observe since an array-element address is always non-NULL.
> 
> Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue scenario")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...
