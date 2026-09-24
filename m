Received: from mail-vs2-f3.google.com (mail-vs2-f3.google.com [74.125.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A343C7DE
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267343; cv=none; b=RS7G35Ow+fzGDzJ1cBKbbmFkSJIkl0yWqBQP+5oTOHu4TMNeEnHMWTZo+HJ6+Jz9YFpOjLIAhXo63PMlcKhakD471Tu44bm/5fhGsWbfPakmfANawUkViwQkWAk8yLWCmVCGkc1Eh+kc735tc4KiUaEjMDZtSfjoJ4U72FqSuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267343; c=relaxed/simple;
	bh=6JAyN6KCHJkun8RaYA/N/Lkl7G4cohxxa40b/UiFDIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VefRsRlQP4t/61FyMDM0chfW0bAJ6l/VIVuYCqUpS/Jn6bAMBpNano1ZIPpQb5/aduzaC8M+lEPFYpVztpceYpeR2hV1/RTV9Ej4Iw+I42o6dGeB+X00yLFpPYV9FNFqwum5H9h+5UejqZ5Xo/1E4ibwd4iCeSvjXmDdvEse8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MllQU6lR; arc=none smtp.client-ip=74.125.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MllQU6lR"
Received: by mail-vs2-f3.google.com with SMTP id ada2fe7eead31-7837bfb7a4fso336534137.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267341; x=1790872141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xLyYsD993XTzHjZ8D4HrQO5P8mJRUn3I9bCqJpm8IUU=;
        b=MllQU6lRf4kX5WlGzJsip5OT30JRHd+lVK7yxTfNCyREeYKK7LlhKcb9Fy4kZv+TAc
         m9uUco//Zw8iNgf6xcHYecEtB7+njYD2axCEfsZlPVkmpeV3x0rBrVP4qCneXpXSCXth
         cWzLT01gbuThxYFk/bdOA4ujfOUYwVy9+YcSVUgCwBue+pJumK5G8XeG04SW3FdRNPaO
         M4zFHlY22GKY9DXDXnD9jQCIPgsUXfyRKE5/luLWgnEJJpkVlbckrg2s5xr9sCOcqZuM
         V/jTuzooBo3aI6B4YJs1cLQYs4mC4JAs9ATiRlA1P4d1ul9xoH6GfIA05Fhk2TzrEdfU
         Y5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267341; x=1790872141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xLyYsD993XTzHjZ8D4HrQO5P8mJRUn3I9bCqJpm8IUU=;
        b=ai4+JbaNedNVk6CVdaIlscp3daUgNqhxQdktMj9BLht3CLti2WzRF60qGcB19cNLzL
         OuIBV87x1slP0OKevTOKsrKdk5gVYq2wE1dAb0/xmnrubXFmLsZ81NUgLrPPZOdICjv2
         8Jh8kP2vyoVilRbSOvoumKbfSDlO9l6SZGF9aj3XyEy1BiK9KZVYJb7C9BVRj/b1BwM8
         2+T9FmGhXAP6FJnQy5NuEgQmXWeGa7jpAv/6yY6ceYRd9vb3y/qmfSsaNg/nSV0azTd8
         l/a1XB3njvYFZCoU+IqYVzbI0EsB4GuT86PoRjUaHTtJqes4mN7x+NR5TWnEvjkd6k14
         o75w==
X-Gm-Message-State: AFuF++nUK4j9e/2uGUoGW55DZ5TlB3rvNDpTH7SEjSbb45nrqqGIN/1i
	U5uChoHDoh1fgYRNRZYWJejbe3N4+R8ZV1TSSSJMjE+NX6hVcCJd6rIy
X-Gm-Gg: AYBFou3R99YukrOnXmn9xQBew+ruT4Fr72t0T1VeiOeyRhrNMa/HDD06GB3N5uCs/vz
	jfvOnKMnMtfHvFdrmzpYf+0ZIOFajtRMxlCEe7AN87PQi0g+TPvCB3UwUAd2kT2gV9JPRE9W6e1
	ZYt+09YjvZpHg6GMtBY0ad/NC4EILeOUszCfgW1GpspLcwu1aQ5BzpX9xPZ2wI+2grm5HS/KZZW
	J4PvyhFQSu30hdpLN01Y0hTpYiBeQDGdkvhm59yOvul4jwS8oyEToD6X+96/qVXA5tk4M9oSNdS
	rKuAsVobgK7IZTaeA6HbYPqsrsrckukXMAtUc5rc+Yi+9XkpuSJFvxbi76CF5Wf9cfUnsEEt0Sz
	STjwAmIDuX0LYv4QrvNqCrJm6VTl7HE0Ik2FI/wi8wW4u2cdFeHSsdIjcEXPNq0FHfAG+gzrqy7
	TbKWxgiJ0sx8VcQEtEhuuC1zoJLc5ke5elKaoCmbsmP2WfDJmbhwI0ZFSjJ32+xdYTSlRegdQp7
	c0=
X-Received: by 2002:a05:6122:1dac:b0:5c9:a5be:7b50 with SMTP id 71dfb90a1353d-5cb0b873c55mr1456356e0c.7.1790267341056;
        Thu, 24 Sep 2026 09:29:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f04c2a36sm7729420e0c.5.2026.09.24.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:29:00 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:25:20 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk, sdf@fomichev.me, 
	bobbyeshleman@meta.com, almasrymina@google.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: devmem: use memory provider helpers
 for net_iovs
Message-ID: <arVOvjCdkOKDoq1L@devvm7509.cco0.facebook.com>
References: <20260922204348.717198-3-sdf@fomichev.me>
 <179020718952.2160803.820732555059297637@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179020718952.2160803.820732555059297637@kernel.org>

On 09/23, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] net: devmem: use memory provider helpers for net_iovs bundles a
>   real bug fix into a patch whose commit message presents it as a…
> 
> --
> 
> net: devmem: use memory provider helpers for net_iovs
> 
> This converts net/core/devmem.c to the public memory-provider helpers
> net_mp_niov_set_dma_addr(), net_mp_niov_set_page_pool() and
> net_mp_niov_clear_page_pool() instead of open-coding page_pool state,
> switches the net_iov array to kvzalloc_objs(), and now rejects DMA
> addresses that cannot be represented in net_iov metadata.
> 
> >  	Zero the net_iov array because net_mp_niov_set_page_pool() ORs
> >  	PP_SIGNATURE into pp_magic. Reject DMA addresses that cannot be
> >  	represented in net_iov metadata.
> 
> [Severity: Low]
> This isn't a bug in the new code, but should the "Reject DMA addresses
> that cannot be represented in net_iov metadata" sentence spell out that
> the old behaviour was a silent truncation, and should the patch carry a
> Fixes: tag?
> 
> Before this patch net_devmem_bind_dmabuf() dropped the return value of
> page_pool_set_dma_addr_netmem(), which is the "this address does not
> round-trip through the compressed net_iov metadata" indicator:
> 
> net/core/page_pool_priv.h:page_pool_set_dma_addr_netmem() {
> 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> 		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
> 
> 		/* We assume page alignment to shave off bottom bits,
> 		 * if this "compression" doesn't work we need to drop.
> 		 */
> 		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
> 				       << PAGE_SHIFT;
> 	}
> 	...
> }
> 
> Every other caller treats a true return as fatal, e.g.
> page_pool_dma_map():
> 
> 	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
> 		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
> 		goto unmap_failed;
> 	}
> 
> and io_uring/zcrx.c returns -EFAULT. Devmem was the only site that kept
> the truncated address and handed it to the NIC for DMA.
> 
> The path looks reachable from user space on 32-bit arches with 64-bit
> dma_addr_t: netdev_nl_bind_rx_doit() only checks is_power_of_2() on
> NETDEV_A_DMABUF_RX_PAGE_SIZE before niov_shift = ilog2(rx_page_size), so
> a sub-PAGE_SIZE niov size is accepted, and the bind loop then advances
> dma_addr += niov_size producing non-page-aligned addresses whose
> compression fails.
> 
> Given that the next patch in the series ("net: devmem: decode DMA
> addresses for TX") does carry a Fixes: tag for the other half of the same
> 32-bit/64-bit-DMA problem, would it make sense to split this hunk out
> with its own Fixes: tag so it can be picked up for stable?

I do not think this suggestion makes any sense. We do need to check
the return value of page_pool_set_dma_addr_netmem. Whether it's this
patch (I think it fits better here), or next - does not matter much.
