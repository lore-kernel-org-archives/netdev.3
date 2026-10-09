Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667926FA4B;
	Fri,  9 Oct 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564660; cv=none; b=kH92aL9wBmu4btrv8L/Cu5Nf5K818eF9qs5x2C+LxgSkbwX3Sk7mZE4VocLB2OcrHtj/hyI9tP7lQkvd1q7UxviKyAHpGchGcVWsPHNQUFGCBs6yldN2PbrTSoD27Y3OViJJ4EbRskBibjN9+8a7gSAhYByx22Lwvo69EhqchHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564660; c=relaxed/simple;
	bh=PFmLssKDcusJBbxG5usTXRmrFBeqcyLWlgtt/gO1JoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD+XAt7JB7M5OnzRKqXOTxtiZnA55q2sIfUyO8eBIoPCgbTdzfjUf9VRfSml1pprKZIWYgVUWVIcP0V0aFLsgazNhRVw3fmV/67TPAw7b5X7KJru7FrIs1UZ5s8nvz4V1hR0DZMoxCURDFSAkA7ezpjU96nsYvM/9n4LzVdWI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXkqgPtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXkqgPtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA51F000FF;
	Fri,  9 Oct 2026 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791564658;
	bh=O9BMlJTdE9Y9VZdVW9+inED8bkLDwjOaM01fXKv8qfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JXkqgPtbCDRx3KC6KulxRMR2o64UyhwWCytktuRojvzxt49habrfIPit8XsAS+pvb
	 kyCtubuzUKHJkCvnOcGvgOl3spNLq8lsQ95pv3IXWMZs8oytvWTldI5vB26Edb05IX
	 GhxBJSzMJT+AKmtSRjaj7ISBGGQPTl3DGJrGjJnOPTgoyO2QiZl06Mf6/YqMH9HQiz
	 L/wi6uBJMBX5eJYOOS9D8Yn3h90CdIwHcg8h78nN1i7LUI1fuuPNHTTzZEpR2UV5su
	 T4XJIFDmOJTXhhj5ZLG7EK1uoctbsVYbpFJpBCtbCXYaRzxx1GC97bJHJYdayk0NCF
	 Vi/rfD4N0KgJg==
Date: Fri, 9 Oct 2026 17:50:54 +0100
From: Simon Horman <horms@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] sfc: fix stale kernel-doc member names in
 net_driver.h
Message-ID: <20261009165054.GH83879@horms.kernel.org>
References: <20261007175338.28683-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007175338.28683-1-kapoorarnav43@gmail.com>

On Wed, Oct 07, 2026 at 11:23:34PM +0530, Arnav Kapoor wrote:
> Several kernel-doc comments in net_driver.h describe struct members that
> have since been renamed or removed, and the EFX_MAX_FRAME_LEN() comment
> is separated from the macro by the EFX_FRAME_PAD define. kernel-doc
> reports:
> 
>   Excess struct member 'state' description in 'efx_channel'
>   Excess struct member 'state_lock' description in 'efx_channel'
>   Excess struct member 'indir_table' description in 'efx_rss_context'
>   Excess struct member 'irq_rx_mod_step_us' description in 'efx_nic'
>   Excess struct member 'tx_queue' description in 'efx_nic'
>   Excess struct member 'rx_queue' description in 'efx_nic'
>   Excess struct member 'extra_channel_types' description in 'efx_nic'
>   expecting prototype for EFX_MAX_FRAME_LEN(). Prototype was for
>   EFX_FRAME_PAD() instead
> 
> along with "not described" warnings for the renamed members.
> 
> Fix the member names to match the structs, drop the entries for members
> that no longer exist, and move the EFX_FRAME_PAD define above the
> EFX_MAX_FRAME_LEN() comment, documenting its @mtu parameter.
> 
> kernel-doc -Wall also reports three members that are not described
> because nothing in the driver uses them any more, so remove them rather
> than document them:
> 
>   - efx_channel::busy_poll_state, left behind when commit e7fe9491261e
>     ("sfc: get rid of custom busy polling code") removed its users.
>     @state and @state_lock above were its old kernel-doc entries.
>   - efx_tx_queue::flush_outstanding, only used by the Falcon/Siena
>     flush code, which commit 36ff6393292d ("sfc: Move Siena specific
>     files") moved into siena/ with its own copy of the struct.
>   - efx_rx_queue::min_overfill, whose kernel-doc entry and only
>     assignment were removed by commit ecc910f520ba ("sfc: Make the dmaq
>     size a run-time setting (rather than compile-time)").
> 
> The warnings were found with scripts/kernel-doc -Wall. I don't have sfc
> hardware; this is compile-tested only.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Changes in v2:
> - Remove busy_poll_state, flush_outstanding and min_overfill, which are
>   unused, instead of leaving them undocumented (Simon)
> - Use the Assisted-by format from coding-assistants.rst

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

