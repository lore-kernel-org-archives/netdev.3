Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E833C507
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693390; cv=none; b=TD/63njzFdeGVNsxqCqvRfu4tkV4KfWZPMPqap0vhgSFdChTJvgagoLn8lxv/GMhxX+UUC8NE1DJkWQnt5D21/EgUMIcU70xk+6Z7KbNUxA11e+MpfpXaFyrVrvuKE0bPBNCzm0YbdN6fR3OklmCgytWEsNatOR4r0+Hi7rWF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693390; c=relaxed/simple;
	bh=xf0tTaO3Gm8Xjis1WLnRLgpsFcTzaHDM0gKsVSqZMNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdASIapRfkJmMHxwxsVC7cvkuYvBkvB6nrT9waZAwzIgHQ7up97SMNs+U0CnUDIq/GXvL1TCebRz7e1t8rVo+Tl4yAZtDkS7p52BzxoB7tAbvtoQoYjYTKb0wf6N4dn0ymcZ7zwbG7mEbsJDLGG5Yq0zUGxsBVzWkFu7JVk83lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVl48ex9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVl48ex9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CB0C19425;
	Mon, 20 Apr 2026 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693390;
	bh=xf0tTaO3Gm8Xjis1WLnRLgpsFcTzaHDM0gKsVSqZMNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVl48ex9RER8/JzKxBkveYrE2ellMnaOAMPIczfkVEb1EpZPZgr9KZPsv9HRLl48G
	 QFlUHOAsaIUMvYpd/MPSkBKE+MCj0UCqW7rguc2HCUGkdRWFOES6FiB7jM6pcCYi18
	 IZZG7I+1J+DP9uwF7qeTPJikPlw0G8xmdyIlNDlj+jP75S00I0bKE5p63nvR6Wa7lt
	 1BscwQCskJB2r4C8rsiHiGt5uyW1/2JmDX8nLcahuXa7kIZyF1u9FZB7Aiiw9WqFRZ
	 6hqvpd0UGceMhUMGSNQ6mtb31U4X1Ig26789VT56Y8o72E2Oni9SalLfHss7LdzuVR
	 RjAOnddA/Nyuw==
Date: Mon, 20 Apr 2026 14:56:25 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] net: airoha: Fix
 airoha_qdma_cleanup_tx_queue() processing
Message-ID: <20260420135625.GQ280379@horms.kernel.org>
References: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>

On Fri, Apr 17, 2026 at 08:36:30AM +0200, Lorenzo Bianconi wrote:
> Add missing bits in airoha_qdma_cleanup_tx_queue routine.
> Fix airoha_qdma_cleanup_tx_queue processing errors intorduced in commit
> '3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order
> DMA tx descriptors")'.
> 
> ---
> Changes in v4:
> - Drop patch 2/3 to move entries to queue head in case of DMA mapping
>   failure in airoha_dev_xmit().
> - Link to v3: https://lore.kernel.org/r/20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org
> 
> Changes in v3:
> - Move ndesc initialization fix in a dedicated patch.
> - Add patch 2/3 to move entries to queue head in case of DMA mapping
>   failure in airoha_dev_xmit().
> - Cosmetics.
> - Link to v2: https://lore.kernel.org/r/20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org
> 
> Changes in v2:
> - Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
>   order to avoid any possible NULL pointer dereference in
>   airoha_qdma_cleanup_tx_queue()
> - Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
> - Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
>       net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
> 
>  drivers/net/ethernet/airoha/airoha_eth.c | 40 +++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 6 deletions(-)

Thanks for the updates, this series looks good to me:

Reviewed-by: Simon Horman <horms@kernel.org>


As is the way of things, Sashiko has some feedback on this patchset.
Please consider looking over it for potential follow-up changes.
I do not think that needs to block progress of this patchset.

