Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883F473C66
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845097; cv=none; b=b13IA7fn5fip8vFtJOKToBFMYt63xwNWybMOHfdqL4lPeGeNA1iOKspcDxZKcXSA/VgVQ+qtGhjTKzZwLT968L0rBu6D0rjIjM1dF/vHav6wPtZgsY52dCa9R5UEpW00dNxTFA/psJQid8cqm1W4aM0XSIAiFrzIIaz5LJNgFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845097; c=relaxed/simple;
	bh=6ix4iIeWlKSezZJnuJ7/f598wsfvkwThdlL0jD6Exzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNGOqXA9AkFEap2x2DERw782x1qXoWK3Xj8zTzV+pxW6157gEVad83IRzUuYDMh5DZdP+rmioRuTOIOHySzGUVKD0QOv/Be6kPP3stdmwARAjtgZuKXW3x162BmShOQt1NVJlDqNumSOI+svg5Gq0b8UhNkDqPOc/+dkix1z3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpC7BNgn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpC7BNgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748161F000E9;
	Thu, 27 Aug 2026 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787845086;
	bh=ouhEt6qkggpee9x0dWDtPhZWnv6qBFuFRqXKMCeiM2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hpC7BNgnRS45nzp+wP1+avFOMOvxaTJOPsm+gWptYy588hUvAHpHRPKwxhIOUerHA
	 ja1MixpJqGL7sa2H97nMcFElB+iKFUgRhMhOXh1Adq6zjBZiisPfGBJrPJ9A7hRvQY
	 5iy6kJF82DSMc8YssCiUiFDNS7CiKs3KwRGGSoZfAIuh6JN2hAACyXFTpe+Bv+sypQ
	 T3S5TKlPveX7qCg9jYZfXyFjj4WoANE8IegI6xNha+ZVflHTjzeT0SpaKrRrUUP66S
	 cjqK0KRUfa6JdSRuFTrEKMTCX7DWrgw4ICZORc2itN3RMYeCYyEKV3Oh2XZyYfFeuv
	 IlUkCSLKgx2tA==
Date: Thu, 27 Aug 2026 08:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, lorenzo@kernel.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 yangshiji66@outlook.com
Subject: Re: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA
 mask
Message-ID: <20260827083805.4417d1f1@kernel.org>
In-Reply-To: <20260820085941.380401-1-pawlik.dan@gmail.com>
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:59:40 +0200 Daniel Pawlik wrote:
> The driver calls dma_set_coherent_mask() but never dma_set_mask(),
> leaving the streaming DMA mask at the bus default. On the non-coherent
> EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
> after approximately 41 calls when using streaming DMA mappings.
> 
> Replace dma_set_coherent_mask() with dma_set_mask_and_coherent() to
> set both the streaming and coherent DMA masks, matching standard
> driver practice.

I'm going to take this in as it's uncontroversial and obviously correct.
Hopefully we hear something to understand the second one better before
merging.
