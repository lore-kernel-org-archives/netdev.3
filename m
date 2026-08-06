Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BA47A88F;
	Thu,  6 Aug 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030223; cv=none; b=HH2ULBLnRXveYWrcpcsWNKLXtrpilrXsuhOsu6FjaCFqC8h+/77IsIIKI9l/iJjTvbOi5wocmnFF8ogNrFEHVCLQ+eucVO0tmZatl/T313mgiLoiMriQd8TFAwCoQ0feT3plcXUj7Ldtd3SOVerzJimRjuox3ZU3dRu+iyBgQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030223; c=relaxed/simple;
	bh=7mEo2gJHMna00aknwl4FCw+U50fvdFPZiwYkGt1trc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4SOlw40YGyCJelv8T8QEpkUZWqnDhl5EXJNuQ+WDBIAQ7pLISa+Bod3tWqJh6wXnh+JE1TPZu6yEZzxSrFuo/+a22V5gx9PKT5AvpAF1Vxe6VKkqLJu5ll1nG4ui47oj64YJsdC6LjzwQZHyZG8Rmofqt3rDerL2gcpv1XIVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL/pblbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL/pblbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249131F000E9;
	Thu,  6 Aug 2026 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030221;
	bh=JqlJdCL3d/KB1MsydqQAb2AliPadISnFUnIB82EHIQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kL/pblbIDqEpmSkaaoCXnyuqAVXd+ICvnVrvR309gH6VlI5jjITafZW7k+T0HzvM8
	 LuE5ryyqwZGVjZmhhXAQfo4EOuXG6BiNJPvyLV1+Au7e5r0G8QMJ9Sow0zXwaIBe5T
	 GRPHhZhEtrQ/D35t7DjJ7baA8yrgU5zIZ19IyGkSdLHLNAYXwfv5razUr3WkyUQqxI
	 bnL/lx4HwL/f7NtBzSezAEZX3bJvpD+WoGkYkZdVX0FEtliXGqoatwwlhWjEqkHo7n
	 wFw9djCZ2Z1MrCHvfeUm5fMUltgOMIWl87mygTVqX+pTOJAoJlGT4XvTqhIxF+CuVx
	 V/jLL4G3JIVqQ==
Date: Thu, 6 Aug 2026 08:30:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: subratp@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 sbhatta@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sgoutham@marvell.com
Subject: Re: [PATCH net v2 1/2] octeontx2-pf: Fix aura BPID assignment when
 CONFIG_DCB is enabled
Message-ID: <20260806083020.3b747817@kernel.org>
In-Reply-To: <20260806152650.2562245-1-kuba@kernel.org>
References: <20260731055310.1229213-2-subratp@marvell.com>
	<20260806152650.2562245-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 08:26:50 -0700 Jakub Kicinski wrote:
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 3d253132a17f0..b4691472d2a3e 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > @@ -1132,10 +1132,10 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
> >  		if (!is_otx2_lbkvf(pfvf->pdev)) {
> >  			/* Enable receive CQ backpressure */
> >  			aq->cq.bp_ena = 1;
> > -#ifdef CONFIG_DCB
> > -			aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
> > -#else
> >  			aq->cq.bpid = pfvf->bpid[0];
> > +#ifdef CONFIG_DCB
> > +			if (pfvf->queue_to_pfc_map)
> > +				aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
> >  #endif  
> 
> [Severity: Low]
> This isn't a bug, but the same #ifdef CONFIG_DCB plus NULL test idiom now
> appears in three places: cn20k_aura_bpid_idx(), otx2_cq_init() and
> otx2_aura_aq_init().  cn20k_aura_bpid_idx() already encapsulates exactly this
> logic.  Would it be cleaner to generalize it into a single accessor, say
> otx2_get_bpid_idx(pfvf, qidx), and use it from all three sites?
> 
> Alternatively, could queue_to_pfc_map simply be allocated unconditionally
> (it is only pfvf->hw.rx_queues bytes) instead of being tied to dcbnl_ops

AI is getting better I guess. I was going to suggest this as well.
Please avoid hiding struct members under ifdefs unless there's a major
size win on the structures. If you care about runtime cost you can use
IS_ENABLED() inside the if () condition and compiler will eliminate it.
No ifdefs needed at that point.
