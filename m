Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92131961B;
	Thu, 26 Feb 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109438; cv=none; b=uKBkCfxm1CXvXEAzXw8RHzEIcBOfnsgzxDJlvKYl5jo4cWka2IScgFJPqjNXto5apaFQoPFv0R5628CUSsC9m+yJgX7ceI5dnpN5PyVH2kVwL1zdvqvimVIWGtqBeSHn5xfdatnGPYbauGZZ03a2ymaZhTcizEvZMyErDPxGCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109438; c=relaxed/simple;
	bh=ykb8WtiM3T2+IvUqRkj7z/xekAAOUV592Y07X8ZwFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caQiXuj4RrAoe9Kvumu89sSt4cV75hBbPfNVDFil7ZuPpXeZ+zk8VklysizvbvCpiUj2Fygi10f4qf1h7mKGdzZH8K0R/jNrAa5Xhf8LeagqU4F6RNCyozuC3kaE7qFzRj+sqyIXEA9B0PTGIOVAxSvs6zx0FSTB0SE8diRzcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8zMnFzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8zMnFzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D229DC116C6;
	Thu, 26 Feb 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772109437;
	bh=ykb8WtiM3T2+IvUqRkj7z/xekAAOUV592Y07X8ZwFWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8zMnFzg9K09ccxpZQb4v71RI+XKs7Ejz6Vcd6bP2ppLykoVlOyC9nQC1gHIdGuER
	 16B7CecbTLpp0B5FJAsngBcQBiK5CZP0fBt79OtHPcnIkLAk1xlqjTT35XhAz0LhMQ
	 kAw1PmxNQjmK66udeDJInoA1MIRyYadx3mnwUYzJc7dSSmXp0zKK/KwPGk098T9ZY/
	 0id38zQ+Klbp/oZse1TeVLnQCKDRn3bG1DNtlEmfFunHg5srmui0MTnVsXVYW/RuZG
	 z2ZefQobgiPqs43ZjegpLYf4sRPhYuncc5zgtzzXXtpbNhPlvTo1FW4C0jCLwPLMe1
	 sncJw7pSriMtw==
Date: Thu, 26 Feb 2026 12:37:13 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com
Subject: Re: [PATCH net 1/2] amd-xgbe: fix sleep while atomic on
 suspend/resume
Message-ID: <aaA-efqBThRji-Cz@horms.kernel.org>
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
 <20260225110001.1000014-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225110001.1000014-2-Raju.Rangoju@amd.com>

On Wed, Feb 25, 2026 at 04:30:00PM +0530, Raju Rangoju wrote:
> The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
> (spin_lock_irqsave) while calling functions that may sleep:
> - napi_disable() can sleep waiting for NAPI polling to complete
> - flush_workqueue() can sleep waiting for pending work items
> 
> This causes a "BUG: scheduling while atomic" error during suspend/resume
> cycles on systems using the AMD XGBE Ethernet controller.
> 
> The spinlock protection in these functions is unnecessary because:
> 1. The functions are called from suspend/resume paths which are already
>    serialized by the PM core
> 2. The caller parameter was used to differentiate contexts, but the
>    only current usage is from the driver context (suspend/resume)
> 3. The power_down flag provides sufficient synchronization
> 
> Fix this by:
> - Removing the spinlock from xgbe_powerdown() and xgbe_powerup()
> - Simplifying the function signatures by removing the unused caller
>   parameter
> - Removing the unused XGMAC_DRIVER_CONTEXT and XGMAC_IOCTL_CONTEXT macros
> - Reordering operations in xgbe_powerdown() to disable NAPI before
>   stopping TX/RX (matching the order used in xgbe_stop())

I don't think that all of these changes are necessary to fix the issue at hand.
If so, please separate the fix(es) from other changes. And submit only
the fixes to net - ideally one patch per fix if there is more than one
discrete fix.

OTOH, enhancements and clean-ups should be submitted to net-next.
If there are dependencies on or conflicts with the fixes, then let
them go into net first. net is merged into net-next each Thursday or Friday.

> 
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

...

-- 
pw-bot: changes-requested
