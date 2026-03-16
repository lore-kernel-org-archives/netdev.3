Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DA3CD8BD;
	Mon, 16 Mar 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690263; cv=none; b=oD3B+5E0BSCZduFuOD+zTF1u9oZGu6b+X5ZDVWuA/8xzG48lqWCfeOzIrVuLLHPF9NF6/KKLGNZhKr52UrPmAWv5ZhwIydUhVrdTkEjsBAiuWKYRdPDoGAlf+2pEos1nsxr5uCNdjTVD5fWeYAczhGMoOj1VKNvTHeVPCK46DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690263; c=relaxed/simple;
	bh=K/9zQqWDOIZ02xhcKFxY3R1ays/fTGdkiB8VVp4het8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYYmZ7sdRlMl+lQqo9520Lnnd6JvpyRXsDOABO3wcS6ue+AXTyx7mT5KMkzsWyD9v01ruW2mbkoDhFtXWCSKVHkkKsO0f07DK0Gggs+7XGFjynmCbeYyufKKwQnRhAB2wRVktxxCQlj5LVF3cN5LKefSuqDM+J+HQ3TWdSqzoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG434r53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG434r53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED889C19421;
	Mon, 16 Mar 2026 19:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690263;
	bh=K/9zQqWDOIZ02xhcKFxY3R1ays/fTGdkiB8VVp4het8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG434r53eZ0OfE+KnXBfsox7a9jp2EnD4avLhhmU7BEyR3a0NavqY8O2Q4HMgjpSl
	 3Rbx4hHnepSvWKxRJwbmVxmevyx+RUCzgq6SaD0S2H6qErtIOeuVP1OasnpNUk6Lzs
	 RRQgbkBH0yn3MVs9roi5VKosMPTFhtWfIcShXy00wDdlKaCfnHhW4/wy69VWzhSxB5
	 btd0cQ81Iuee4KMixCbZpJ6NmLA8roZaKJoH8r76xThR/V8Gk8LjmNvInESREjJ8Yf
	 bGwKNYF9ufHYtpGXE6DJv942WPBdggMzUVf/BnRkxTtxv8I3Xb/WXGqwkTehyJ7z27
	 VrO0Q8Mspqq/A==
Date: Mon, 16 Mar 2026 21:44:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC net-next v2 00/12] Add TSO map-once DMA helpers and bnxt SW
 USO support
Message-ID: <20260316194419.GH61385@unreal>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>

On Thu, Mar 12, 2026 at 03:34:37PM -0700, Joe Damato wrote:
> Greetings:
> 
> This series extends net/tso to add a data structure and some helpers allowing
> drivers to DMA map headers and packet payloads a single time. The helpers can
> then be used to reference slices of shared mapping for each segment. This
> helps to avoid the cost of repeated DMA mappings, especially on systems which
> use an IOMMU.

In modern kernels, it is done by using DMA IOVA API, see NVMe
driver/block layer for the most comprehensive example.

The pseudo code is:
 if (with_iommu)
    use dma_iova_link/dma_iova_unlink
 else
    use dma_map_phys()

https://lore.kernel.org/all/cover.1746424934.git.leon@kernel.org/
https://lore.kernel.org/all/20250623141259.76767-1-hch@lst.de/
https://lwn.net/Articles/997563/

Thanks
