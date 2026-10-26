Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034125;
	b=QD/JfQvW9LkSe/G1bhs4lrDYErFxTsGt57xdr8AGL/zR7CN+Flz1RQelO4HlJK45k6Ff
	 VxWOoDFG7JZtQWCUOF4EI4hJpisbigUudxiDsPbANpdATNPDv2nj54Jthl/lvuLhWAwTJ
	 FPl8nr52tWHeWDbhrbys7lDYW1EFlU1UC1LTXGQfm7zAnmhCAQWFhCsRDmfFo+vDtRFoQ
	 HDWvBFHublCY9akf2XUceswlGMzu6kkrSoQ/sCq/ZdSkuUs0V19Y598+bBoPcyJUn9nrV
	 eF0kZqr8PWgGTvyCHOjRNjM+hugatrJcnKq+PJ3XsScKqsR9eZPqiJAhlLXbzt+0TjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034125;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qkqhPHOCo4fTWwPKT7Kxijt1nrEHB3Og6VjW7E1Dyb0=;
	b=CmmoFA+IBfwgIpC//0gtvCgDs+Kn80dG4FyKncYyDWGNmmPBQdT03wjib2UlIN82sus5
	 aaS/v1t69xy5bnUkKBiCSBS4tw+edkre2QACbtogtQQ+dvECzGglGaabksHeI9jHsWLyZ
	 swqLx+Peic18CMfKKrAB3ehpvznYhTvy0B2zi9kgaGUs8iw2WtZxGRODcfqFsSFKiImUD
	 JsUJi4pgPEIY57nzKiJpDuX+lhlyJybkywH/BlSggdhdNVVbb8quItBLSsAp2d9+8OS5t
	 ESZbWUKJTwHyVOMom7xsxmmj2rFn1e7jss3HijkQWorIdx7nMZAh/FmQxXf+CcYNqwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awEcjpuD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EA606A31A;
	Mon, 26 Oct 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awEcjpuD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797861F01825;
	Mon, 26 Oct 2026 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793034124;
	bh=qkqhPHOCo4fTWwPKT7Kxijt1nrEHB3Og6VjW7E1Dyb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=awEcjpuD1v4ke9BAf8ab8An27hYYxZqCuvHfrQXBrDxsbhGC8Q0pnoyO/s7yM3Hbh
	 dxAzdCDsJDokzQs3Hqcq4dAFDYXCch3aRJO1/38iG0D34aKc1sbOj5P9MOLlc2Ix9E
	 QivOq0RPc4hjrcLC2tksBDa0O9Ivy8CMEUPtziBOOmZoaeT+0HKUV3CzD2IILMhm6i
	 /Z+oeMh9XxubnHZl55OXoblC8+CC6lCN8NMHj3//5iDQvLjh6v0OUqa6Y03SU6xUbG
	 jUidKixUOV5C9bucVx+27g63uiiNa88zCRgqV9dmWtoBLQdPUg6FaOGyAkJalb/1eZ
	 LOVf4Ead/0R7Q==
Date: Mon, 26 Oct 2026 17:02:00 +0000
From: Simon Horman <horms@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
Subject: Re: [PATCH net] vmxnet3: stop DMA mapping the adapter structure
Message-ID: <20261026170200.GF257209@horms.kernel.org>
References: <20261021221221.502428-1-kapoorarnav43@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021221221.502428-1-kapoorarnav43@gmail.com>

On Thu, Oct 22, 2026 at 03:42:12AM +0530, Arnav Kapoor wrote:
> vmxnet3_probe_device() maps the whole struct vmxnet3_adapter with
> dma_map_single() and passes its address to the device as the "driver
> data" (misc.ddPA/ddLen) in the shared area.
> 
> The adapter is the netdev private area, and alloc_netdev_mqs() allocates
> it with kvzalloc(). struct vmxnet3_adapter embeds 32 tx and 32 rx queues
> and is well above PAGE_SIZE, so when a high-order allocation fails the
> adapter ends up in vmalloc memory. dma_map_single() then warns
> ("rejecting DMA map of vmalloc memory") and returns DMA_MAPPING_ERROR,
> and probe fails with -EFAULT. syzbot hit this with page allocation
> fault injection.
> 
> The driver data is only informational: the mapping is DMA_TO_DEVICE,
> done once at probe and never synced, so the device could only ever see
> a stale copy. The per-queue descriptors in this driver already report
> no driver data with ddPA = ~0ULL and ddLen = 0, and other vmxnet3
> drivers, such as the one in DPDK, never set misc.ddPA at all.
> 
> Drop the mapping and report no driver data in the shared area as well.
> This also removes a probe failure path and the adapter_pa field.
> 
> Fixes: b0eb57cb97e7 ("VMXNET3: Add support for virtual IOMMU")
> Reported-by: syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8eed6f83440ecdaf4be6
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Tested in QEMU (q35, KVM) on net/main (abeacca61eea), with KASAN,
> CONFIG_DMA_API_DEBUG and fail_page_alloc (min-order=4, as in the syzbot
> reproducer):
> 
> - syzbot C reproducer: before, "rejecting DMA map of vmalloc memory"
>   WARNING and probe fails with -EFAULT; after, no warning (probe then
>   fails at BAR mapping, as the reproducer binds vmxnet3 to a non-vmxnet3
>   device).
> - QEMU's emulated vmxnet3 (-device vmxnet3): probes, link up, ping
>   works, before and after.
> - Same NIC unbound and rebound with order>=4 page allocations failing:
>   before, the WARNING and probe fails, so the NIC is gone; after, it
>   binds and ping works.
> 
> No new W=1 warnings in drivers/net/vmxnet3/. Not tested on ESXi.
> 
>  drivers/net/vmxnet3/vmxnet3_drv.c | 19 +++----------------
>  drivers/net/vmxnet3/vmxnet3_int.h |  1 -
>  2 files changed, 3 insertions(+), 17 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

