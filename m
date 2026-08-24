Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71D2853F3
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587326; cv=none; b=hcM2kt2/+/MdznXQWeA6zLIOz+BAhAdM4J069MhUkbTGneRlVoaE73RqyUNQ56gOlhPzvnFlsYsgrU+v3nBv/pS+CySQajzE2ixc3WOoLiV2phhjBi0jQJyFtj+ugv00IV/TdqKnFcy1jCFcJ1+Z++gfRK3BDe0oPcKK3jWkLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587326; c=relaxed/simple;
	bh=uEDQxQRr5aCKBdJcT4+ABjgfPb6LCSfBbuKEzkIs7QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C66yGVtv7RjB2x6YPYwEFVgGGZpHrsCbLowRUDqGAbAp1N2h5zTs88ugRbVEwU/u09CsVWF2N1HazaFCrH9+jVaFP8pXIcXbzFI6kkluIUbJkz3riWAOpw3c7ob3XMMOOwaccbzHtSoMaG1WSHxfXGzi6X8oXKctHdpHkOOY0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrxyDW5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrxyDW5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F61F000E9;
	Mon, 24 Aug 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787587324;
	bh=LGq+20MTSxt1LGfHj3jPyYgDVwZp6lkTgCk64GTKZho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RrxyDW5PXTz7/JgnpWdBk/R+ttFpiejJO/6ekdULuH4V393VsC2hG9nXnv5ODKXqv
	 c8+8/aoSkmdlKpqJtRfV0EcsFwuSYYzVNGB7Cx1/woZqtL7Mwi5wY/3jeomKE7W+mQ
	 AQmQFITiHtWXB+ZObUlKWqT0l796jWqlPlyuY0+Fn2eNug7H1wXUr1nDkdnv283v81
	 bIOlmrtqs9RmbW6AXg3YDs6FrsQMnaMPN0wOSroSM6BqwYM+ISmrKH9RP+fq5vyV9M
	 UrclcChU3jIXXORGkR1CwQjy7SpfggF69hoKi4aUi5FwBQcm33OMTDnviyEYFu7uMJ
	 FTv8G9HtnAaDg==
Date: Mon, 24 Aug 2026 17:02:01 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 0/2] i40e: fix set_ringparam error path crashes
Message-ID: <20260824160201.GX265046@horms.kernel.org>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>

On Fri, Aug 21, 2026 at 03:01:55PM +0200, Aleksandr Loktionov wrote:
> i40e_set_ringparam() has two independent ways to crash a live queue
> while resizing descriptors. Both need a failure injected into the
> middle of the resize to hit, but both are 100% reliable once you know
> where.
> 
> Patch 1 is the reported bug: the free_tx: label frees vsi->tx_rings[i]
> (the live, NAPI-active ring) instead of &tx_rings[i] (the staged copy),
> on Rx allocation failure. desc/tx_bi go to NULL under a running NAPI,
> next poll dereferences them. Reproduced by forcing an Rx alloc failure
> right after a Tx descriptor count change; panic address matched the
> original report exactly (CR2 == old_count * sizeof(desc)).
> 
> Patch 2 was found reviewing patch 1. The staged tx_rings[] copies are
> shallow copies of the live rings, so they carry over the same
> ring->netdev/queue_index. Freeing one of these copies before
> i40e_down() has run - either from this same free_tx: label or from the
> i40e_setup_tx_descriptors() failure unwind loop above it - resets BQL
> state for the live queue it was copied from. dql_completed() then
> BUG_ONs the next time the live ring reports a completion that was
> queued before the reset. This one predates patch 1's bug by four
> years (Fixes: 9f65e15b4f98, 2013) and doesn't need patch 1 applied to
> be reachable via the setup_tx_descriptors() path.
> 
> Reproduced by forcing i40e_setup_tx_descriptors() to fail on a later
> queue while flooding real Tx traffic on the earlier ones:
> 
>   kernel BUG at lib/dynamic_queue_limits.c:99!
>   RIP: dql_completed+0x285/0x2a0
>   Call Trace:
>    <IRQ>
>    i40e_napi_poll+0x74b/0x1700 [i40e]
>    __napi_poll+0x10a/0x200
>    net_rx_action+0x2f7/0x380
>    handle_softirqs+0xcc/0x270
> 
> Confirmed clean with the fix applied, same traffic, repeated
> resize cycles.
> 
> Patch 2 touches both error paths above, but only the free_tx: hunk
> needs patch 1 applied first to match its diff context - the
> setup_tx_descriptors() unwind hunk applies, and matters, on its own.
> 
> Cc: Simon Horman <horms@kernel.org>
> 
> Aleksandr Loktionov (2):
>   i40e: fix set_ringparam error path freeing live Tx rings
>   i40e: avoid resetting BQL state when freeing temporary Tx rings in
>     set_ringparam

Thanks for the update.

For the series:
Reviewed-by: Simon Horman <horms@kernel.org>

