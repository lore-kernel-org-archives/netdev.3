Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61737FF40
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332626; cv=none; b=ia/W8rXoG0hWSENNJTMMlFGfq1YMkKWefExytYfekQuDuMlr6NOY6yQT0v2qB7/bKxdoy7aFafsR3mr4yRZNBG3n6jxLdUVwCiVhd1lEAnAaSh0c1UGB8KSOmvjtORtlo/us5Z+IZWKZOtX4r8qhRPVuym5mSF0xM40+8GxUjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332626; c=relaxed/simple;
	bh=8zG6Il73X8XOj+y89DPMbE0wSRh913ay9W/WRMRmPj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNORK3cLjEz8U3pnSTuarb1CT7kXjW0uTirr9KYWkSzjKfSTv6HRGi8NMv1Dws2HBj8SH6SJsd6N2Zgy93dbNzIEUjJAJvYWSH3vDAXXuadtVAL/iahBnt3OnLS9oIuroiKLQ0yZ4Tj/Ux427Zwd5+64qh7yKu6vp0mhjVtPjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeT+TxQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeT+TxQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3A71F00893;
	Mon,  1 Jun 2026 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780332625;
	bh=8jl1Q/ZFKEpIXymFtUI6VqZghqC+lkQawLgoydOxlgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DeT+TxQRyMoVcXzm4rRxXRv9Pp5NwrR7Dnshvw2lBZHFA/L2Hz0NnV8D4pBTnZA2j
	 FGfPCKlKuB96/6SPeesJK9itvzDJAdMNSXLfX3wVjpD320Em9nuXoM9AuMFvq3eo4T
	 /uRieLuFlJs5qbMfyxqN8VR6CAWtDf0F7gkLh8TuzhM391MExtEDU5R7LEV4Kuibgr
	 JOS6kdGY+K1xwD8wJdBsr6YxSA5fAnftRlRZiAWVwI4zgl/7kH1Gv3EM6PppU3S+JD
	 TZEul+eX4eCLjCPcPCcQC/WaKm34y6lPrc7Gbk/JscY4I4zybMcut19h+7aGEAif34
	 dRWuryPPP6yjg==
Date: Mon, 1 Jun 2026 17:50:21 +0100
From: Simon Horman <horms@kernel.org>
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH xfrm] xfrm: iptfs: fix use-after-free on first_skb in
 __input_process_payload
Message-ID: <20260601165021.GZ2256768@horms.kernel.org>
References: <20260526105328.87078-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526105328.87078-1-kipreyyy@gmail.com>

On Tue, May 26, 2026 at 06:53:28PM +0800, Zhenghang Xiao wrote:
> __input_process_payload() stores first_skb into xtfs->ra_newskb under
> drop_lock when starting partial reassembly, then unlocks and breaks out
> of the processing loop. The post-loop check reads xtfs->ra_newskb
> without the lock to decide whether first_skb is still owned:
> 
>     if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb)
> 
> Between spin_unlock and this read, a concurrent CPU running
> iptfs_reassem_cont() (or the drop_timer hrtimer) can complete
> reassembly, NULL xtfs->ra_newskb, and free the skb. The check then
> evaluates first_skb != NULL as true, and pskb_trim/ip_summed/consume_skb
> operate on the freed skb — a use-after-free in skbuff_head_cache.
> 
> Replace the unlocked read with a local bool that records whether
> first_skb was handed to the reassembly state in the current call. The
> flag is set after the existing spin_unlock, before the break, using the
> pointer equality that is stable at that point (first_skb == skb iff
> first_skb was stored in ra_newskb).
> 
> Fixes: 3f3339885fb3 ("xfrm: iptfs: add reusing received skb for the tunnel egress packet")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>

FTR: An AI generated review of this patch is available on sashiko.dev.
I believe that review can be treated in the context of possible follow-up
and should not effect the progress of this patch.
