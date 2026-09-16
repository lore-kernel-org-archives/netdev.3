Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC704EE87F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562108; cv=none; b=mrZWmhVV4Y84Y+kHvAmBnIzkII9UA4cRYvILwchQqAMDWqQbOb+D7cdO6Xz7nRKEQDY8W17WdztE7d8rEe42ONjIAFh/zHILqkEDKDxFJXOKIEmRsNsLz8B7S0uFqz1gbRmzDZ5Xs9mmYMgcjZXUXW2BSW/ovkztKX5lX4G0l0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562108; c=relaxed/simple;
	bh=VCLKLWhXdt113SN5py48YYJpfZW5pOKUyWyENVGV2Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCgueT8Z/YDd/0f4WI4DqIESRDlvgFik4gm9iJHTAf8Xms0g3rJ+jfsYNHiZmNRShor5o1xSpKgtmh2UwtVBcPeqo2MHXBZAoGPDBjlKD5DMOISAir3Qm+YeQkqSeONhk9cEVeP6xq+arGCUDmyfcnF07q0qhUd2Dc2IIrqa2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOPUhVNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOPUhVNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA51F000FF;
	Wed, 16 Sep 2026 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789562105;
	bh=YNB/s1mswh64q12U6Hacif3SbRQSsxBfLpW75bfhJA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JOPUhVNM8fxTnS8AZrznLsLnbvEYOk4AR8I1lvYWRgAKLdVMuRb4EAlVA5GE4vv//
	 Osj8v09uMCPAFs0to4mRuCtpWab7ueaREwEMM13HiNUtu6252NtErhXk2yr49OgV1T
	 y88FFP+bw9OzJBaVkQZ7MTIsIIqDjNadvAWDaQiI312J3128ravAzDUwhQqtAuA7h6
	 94F9jVdULkmHvm7ML9GZVnGgOmcYfREAFLbk23Xp7naIfZpNI9xr2wJDKeLeBLz6MT
	 lXZRAfR9nI4GV52uy2uacthfv/5EtngamcbF4jWsd3400LL7jqxFlgPVuIGgu3iDql
	 OGMsOUui1WKwQ==
Date: Wed, 16 Sep 2026 13:35:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: [PATCH net] eth: fbnic: ring the doorbell if a burst ends in a
 drop
Message-ID: <20260916123501.GE51261@horms.kernel.org>
References: <20260915022327.913218-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915022327.913218-1-kuba@kernel.org>

On Mon, Sep 14, 2026 at 07:23:27PM -0700, Jakub Kicinski wrote:
> fbnic_tx_map() skips the doorbell write, and the completion request,
> for every packet handed to it with xmit_more set, counting on the
> packet which ends the burst to publish them all. When that packet is
> dropped instead - skb_put_padto(), skb_cow_head() or a DMA mapping
> failure - nothing rings. The descriptors of the preceding packets stay
> invisible to the HW until the next transmit on that queue, which for a
> burst-then-idle workload may never come.
> 
> Remember the meta descriptor of the last packet left without a doorbell
> and flush it from the error paths. The completion request has to be set
> on that descriptor rather than simply writing the tail, otherwise the HW
> would transmit the packets but never report a head, and the ring would
> fill up and stall for good.
> 
> This is very similar to Joe's recent series of fixes for bnxt.
> Not seen in real life, reproduced under QEMU with failure injection.
> 
> Fixes: 9a57bacd574b ("eth: fbnic: Add basic Tx handling")
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Reproduced under the QEMU fbnic model by failing the DMA mapping of the
> last segment of a software-GSO burst: 21 descriptors (7 packets) stayed
> in the ring with head stuck at 24 and tail at 45, 10094 bytes stuck in
> BQL, and QEMU saw none of the 7 frames.

Reviewed-by: Simon Horman <horms@kernel.org>

