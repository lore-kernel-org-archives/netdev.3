Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369C6481255;
	Wed,  5 Aug 2026 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971482; cv=none; b=FCN5lH+Z9rLEKCq8xZHUanaPL6+b681e2hXhjogbNAYBE8vJ8OGfbd1IxbuFm32RPNcOap7TgyS97HtaycCi5VuCbFbxKOgKGQw3n4NHENZK1fuVjJ93WQe3R5wlibsuEgiao647V2dePbD71RgX/lCk0fOjEUB+S+hvbcPt69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971482; c=relaxed/simple;
	bh=xmYulstkJiGD0O9OitGUM5J/+5R83ZTMqaFD1Whu0kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8dB0AH5T3zprTv4NVJvrLoh0Yz3+AfGTG1Yy+YaMuuo9G0O0E9POvsAYfHHyXS1ExJw6oj+USeK1d0AtCvocVnDjwg5XO7jsJ9pbqkUx77QY03iqM3t+FMsc5oMSffYPikRQ6MGoVu5P1kQLtglfUtPOHvnKobhjzLYiFgMeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8ufgtfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8ufgtfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814581F00A3A;
	Wed,  5 Aug 2026 23:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785971476;
	bh=BB/30aWayO6B5yTBO+80Um1q25V7zjRPDDeWBSnzTQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h8ufgtfoCD0TIE9HhwapFmlTJ2jGiBY8i5qHS9k/FDpOsfd+KEg+tYqVDAxJyNrfT
	 l58iGo+1uQPP+n0wtNAyJYQzNbloALY3ZUfJup7X+VV5rTTN89MZHw3ultUpU+C/J3
	 JbUtxL6eebZsmx+7uU+57Q7py37gek8fo3j42wWSl+RiZkz84JOxe7y4KV1la8VeD7
	 I0Ikyc5acHvFLY5CzH//+0IhjnoUwcuV4bXibzsnzWGChIyri8F7vHJqwnYhVyCgwe
	 R5XDGU2gUQAA+faC8wvOBPriBMB3xOWTgFAo5J8S1u1C9iHw8ISQYIqNuI0j+S/nVT
	 vT1AGigPqzpBQ==
Date: Wed, 5 Aug 2026 16:11:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 toke@redhat.com, shenjian15@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, yangshuaisong@h-partners.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
Message-ID: <20260805161114.409b1d81@kernel.org>
In-Reply-To: <CAHS8izMVqidVkiVHNWZMqP4Eoi5N_M3Wv1Cnn4jjxHf3=cWNQA@mail.gmail.com>
References: <20260731111507.2355601-1-shaojijie@huawei.com>
	<CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com>
	<20260804191628.762ec7eb@kernel.org>
	<CAHS8izMVqidVkiVHNWZMqP4Eoi5N_M3Wv1Cnn4jjxHf3=cWNQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 20:50:46 -0700 Mina Almasry wrote:
> > Not sure this is a good idea? scrub is trying to touch just the DMA
> > mapping, right? It shouldn't try to update the page itself because
> > it has no reference to the page, the page may get freed in parallel.
> > Hopefully DMA unmap on a freed page is legal..  
> 
> Scrub actually frees the page in the loop in
> page_pool_empty_ring(pool), so it's not true AFAIU that it 'shouldn't
> try to update the page'.
> 
> My mental model (roughly) is that the pp has a ref and that single
> last ref can be dropped in the page_pool_destroy() path or the
> page_pool_put_netmem() path, but the ref can't be dropped twice and
> the same goes for dma unmapping.
> 
> Now that i look closer at the code I have no idea why we didn't 'just'
> put the dma-unmapping inside of page_pool_return_netmem(). That code
> path is already common between scrub() and put_netmem() and does the
> synchronization between these 2 paths.

from memory so likely wrong -
ring scrub is freeing pages from the cache
DMA unamp is clearing _all_ mappings, including actively on used pages
the are different sets
