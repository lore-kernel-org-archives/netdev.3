Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9936F419
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736645; cv=none; b=r5GI9dG7W3yGF9dN8VzvFAinLmvHQ0uYcd0kWrphG/7TjYj4/jB8i8qOEZQFVrwEnQGIJh01ap568/HEJljK/BgxM7W96ICzhW0UDGb9R2/TGvCZzvlxBmgqYb0wFhwO0YqJmuRH4k/sPIQPdWioOCC3N8lxonLQqQ9nP+ukrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736645; c=relaxed/simple;
	bh=XAE4o5LQfog7NLH7ts6fQJj9+rG07i6zlweAZ3vepPM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/K4ASzi2vwmHIAqlcKTq6laciO+I4knftmLQ4VhATGW69fFSDtv3dquqYdA1B7LljjkTXTlPP+dekDhRL7DykydN7404DYgJ8+Lfd/RmqgqUH3/pqir9YvDnXDnsuExEvLNmTdsoRfdm0whWzse8gVWjN3DClig42I+r0LDtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8EYsMQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8EYsMQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2011F00898;
	Wed, 30 Sep 2026 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736644;
	bh=roVljUNbhacUJ6B1MNCy9noHSzO1BTiRApUwVw0W8u0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A8EYsMQBj49bDLhE04cij2fG0kZPMUq+HSN1hs6Yam69mOWGElYM7tQcNydtfhShX
	 6aZRE+ACVffg3p9bgsnNNnVmbB9Z3XUZZ4KdkKyXCkJ1F/VjrTS5Zl4Jy/AYd5p1mv
	 tflJiohQsAHUwWLds9nUMvsP31AOzaNe4YyljrneKud/OtIU6TezEFKH0B1F3eswVq
	 b+eP+FIaHzyRdTBRbCmaIjFC2Zt56E8LN5OibIcLKw3dpQo7J0rJV9XwK2JF/tS03e
	 0I9aRSYy4+/90iBnofQADmXgfn4ChTTlngF4cbijECPE5eNJHrFlHIY1qRFiE6TT+1
	 SAuLBQmdseNZQ==
Subject: Re: [PATCH net-next v2 07/11] net: ethernet: cortina: Synchronize RX
 fragments for the CPU
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:43 +0000
Message-ID: <179073664341.434549.3840534078071705576@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-7-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-7-758a795d7a78@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: ethernet: cortina: Synchronize RX
  fragments for the CPU" presents the change as a bug fix.

--

net: ethernet: cortina: Synchronize RX fragments for the CPU

This commit adds a dma_sync_single_range_for_cpu() for each free queue
fragment when geth_freeq_claim() claims it. It also changes the final
full-page unmap to use DMA_ATTR_SKIP_CPU_SYNC. During teardown,
geth_freeq_release_pages() now syncs only the fragments the hardware still
owns before doing a skip-sync unmap.

> Free queue pages use streaming DMA mappings with DMA_FROM_DEVICE. The RX
> path reads packet data after the device has filled a fragment without
> first transferring ownership of that range to the CPU.

[Severity: Low]

Could the commit message say which configurations are affected and what
the user-visible symptom is? As written, it reads like a fix for RX data
corruption, but there is no Fixes: tag.

The missing sync_for_cpu seems to go back to the original driver, commit
4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet").
That commit added gmac_rx() and the claim/unmap logic.

This IP only appears on the Gemini SoC (ARCH_GEMINI, ARCH_MULTI_V4, FA526
core, no outer cache). On Gemini, arch_sync_dma_for_cpu() in
arch/arm/mm/dma-mapping.c does:

	if (dir != DMA_TO_DEVICE) {
		outer_inv_range(paddr, paddr + size);

		dma_cache_maint_page(paddr, size, dir, dmac_unmap_area);
	}

outer_inv_range() does nothing here. dmac_unmap_area resolves to
fa_dma_unmap_area in arch/arm/mm/cache-fa.S:

SYM_TYPED_FUNC_START(fa_dma_unmap_area)
	ret	lr
SYM_FUNC_END(fa_dma_unmap_area)

So the new dma_sync_single_range_for_cpu() in geth_freeq_claim() does not
seem to do any cache maintenance on this hardware. The old full-page
dma_unmap_single() did none either.

> Once all fragments have been claimed, tear down the full-page mapping with
> DMA_ATTR_SKIP_CPU_SYNC. Each range has already moved to the CPU domain, and
> another full-page synchronization could invalidate a sibling fragment
> already being consumed by the network stack.

Given the above, can the sibling-invalidation case happen on FA526 at
all?

If this fixes real RX corruption on some configuration, should it carry
"Fixes: 4d5ae32f5e1e"? If it is a DMA API correctness change with no
functional effect on Gemini, could the commit message say so? That would
let stable backporters tell the two cases apart.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
