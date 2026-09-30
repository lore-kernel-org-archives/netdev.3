Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6A4E324D;
	Wed, 30 Sep 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776817; cv=none; b=jJeMhGH2wt1BW2udMSuGWCMvWSXfqwGT7Et1PDkwGb2zN/7qygM1hijSs5ymT25lFDVtwaqvslusIkps+cgOj9hIfkY/2BkhjKMPlxUj2FXzH/J3v2dbrAp237ZMOSp6OHaAfoLWjRZ+L5KD9jPFm3vD7vNnq2bGlAJhKhCNEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776817; c=relaxed/simple;
	bh=0Rt3eulJluPPJ1sHyYiqw+zHySZy2IsYUyUxc1GJm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqgFT5QFVGRTT2H0tJPdI9JaiMXahoeovXq3ueWT0NtR1IoEUtt8cXFKzwkIcOSCkVtl9Jgsrz2WIOI1SHnbDBbDsKwGHFBQQW0RuxQIAVF6dLqJdt+QYM5ygJbVOpfOgLVJUaoE1y8pZU/YiBxd/ysc9TvP6Z8nk46CEcIbZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5k68cvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5k68cvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97C71F00898;
	Wed, 30 Sep 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776802;
	bh=ZbA0QkGzOozlt+78D8aHv1h3LYCa9yiegRCU5V+Vb+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c5k68cvMq3NX1y0ReHV2Obsc6iZ9Qdnp1m7aLqp4+OAmLwPb9YCEWiaeXSyYBzmcP
	 qy03zFMcqOOi7jICgtNqzrFvtSSbgGbseCWVGjyJ+teQEFMDdOsx2rnn4udtR1zLoM
	 PPpVyYuKne965FEI5OSMlLXDLp9sPNvHWyAnhMO5YndWYOWhcwbEJWLNlII80E0wm1
	 6L99RrOBQfx+H0RMXJKbjmN3bV2AVS6f2NE4u9kV4xR1Hs+DQ37IbfJZQ5biWRWyB4
	 GqtYYnnmkMKiHdM5Jm5rqok/MZ2Xzc4g+/z1Rp2bXmTRyJK7IOTV26tzhywW9AKL3l
	 RzGX3Mt1NexAg==
Date: Wed, 30 Sep 2026 16:59:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: shashank Jain <jain.sm@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Tal Gilboa <talgi@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] lib/dim: fix 32-bit overflow in dim_calc_stats()
 rates
Message-ID: <20260930135957.GH3401365@unreal>
References: <20260927051743.71460-1-jain.sm@gmail.com>
 <20260927051743.71460-2-jain.sm@gmail.com>
 <20260930084943.GB3401365@unreal>
 <CA+FWx=k7LbhYcA7CMDcQ1Wq5ysjKqc1R=9HT=Q9Z0CQLVp6NUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FWx=k7LbhYcA7CMDcQ1Wq5ysjKqc1R=9HT=Q9Z0CQLVp6NUQ@mail.gmail.com>

On Wed, Sep 30, 2026 at 02:58:37PM +0530, shashank Jain wrote:
> > How does this 32-bit overflow differ from the overflow that can also occur on
> > 64-bit systems in `nbytes * USEC_PER_MSEC`?
> 
> On 64-bit the multiplication itself cannot overflow. nbytes (like npkts
> and ncomps) is a u32, and USEC_PER_MSEC is 1000L, so the product is
> computed in a 64-bit long and is at most (2^32 - 1) * 1000, about
> 4.3 * 10^12 (42 bits). DIV_ROUND_UP() adds at most delta_us - 1 to that,
> which also fits. So on 64-bit the product is always exact.
> 
> On 32-bit the same product is computed in a 32-bit long and wraps once
> nbytes exceeds 4294967, i.e. about 4.3 MB in one DIM window. That is
> reached at normal line rates, which is what the patch fixes. With the
> u64 cast and DIV_ROUND_UP_ULL() the 32-bit results are the same as on
> 64-bit.
> 
> There are two other limits, but they apply to 32-bit and 64-bit alike
> and the patch does not change them:
> 
> - The counters in struct dim_sample are u32 and BIT_GAP() takes the
>   difference modulo 2^32, so a window that carries 4 GiB or more is
>   already undercounted before the multiplication. With 64 events per
>   window that needs a very long window at very high rates (for example
>   about 86 ms at 400 Gbit/s).
> 
> - The rates are stored in int fields of struct dim_stats. bpms is bytes
>   per millisecond, so it only exceeds INT_MAX above 2^31 bytes/ms,
>   about 17 Tbit/s.
> 
> I can add a sentence to the changelog saying that the 64-bit product
> cannot overflow, if you think that helps.

There is no need.

Thanks

> 
> Thanks,
> Shashank
> 
> On Wed, Sep 30, 2026 at 2:19 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sun, Sep 27, 2026 at 10:47:42AM +0530, Shashank Mohan Jain wrote:
> > > dim_calc_stats() computes the per-millisecond rates as
> > >
> > >       DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us)
> > >
> > > where nbytes is a u32 and USEC_PER_MSEC is 1000L. On 64-bit the product
> > > is done in 64-bit long arithmetic, but on 32-bit architectures long is
> > > 32 bits wide and the product wraps as soon as a measurement window
> > > carries more than 4294967 bytes (about 4.3 MB). The same applies to the
> > > packet and completion counts, although those need more than 4.29
> > > million packets or completions per window.
> > >
> > > A DIM window spans DIM_NEVENTS (64) events. Drivers count events per
> > > interrupt or per NAPI poll, so under sustained load a window can easily
> > > carry more than 4.3 MB: 64 full NAPI polls of 64 MTU-sized frames are
> > > already 6.2 MB, and drivers such as mtk_eth_soc count one event per
> > > interrupt while NAPI keeps polling with the interrupt masked. On 32-bit
> > > users of the library (for example mtk_eth_soc on MT7621, bcmgenet and
> > > bcmsysport on 32-bit ARM, or virtio_net in a 32-bit guest) bpms then
> > > becomes the product modulo 2^32 divided by the window length, and
> > > net_dim_stats_compare() makes its BETTER/WORSE decisions on a value
> > > that has little to do with the real throughput.
> > >
> > > For example, a 1 Gbit/s link at line rate that moves 5 MB in a 40 ms
> > > window gives bpms = 125000 on 64-bit but 17626 on 32-bit, and 5 million
> > > packets in 2 s gives ppms = 353 instead of 2500.
> > >
> > > Widen the products to 64 bits and divide with DIV_ROUND_UP_ULL(). The
> > > results are unchanged on 64-bit.
> >
> > How does this 32-bit overflow differ from the overflow that can also occur on
> > 64-bit systems in `nbytes * USEC_PER_MSEC`?
> >
> > Thanks
