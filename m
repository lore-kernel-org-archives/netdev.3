Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A23BE175
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268531; cv=none; b=JXFCdQTBgTVbVTmBkJfVIk81oC80VGmJyH0FJfAZBFIMlssRsqhF3LQmwKo7M40Fh3+6wlMvJuZWIC3WIYAj2uoe/+IhirhAQgV1v6ul7R1KR+CYwGNoImAxSZHMka082sjpBB6n7gk7OTLrdWGm/EKwBl+wuBwcRcZhAn2yrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268531; c=relaxed/simple;
	bh=js1kQuOA/gb46R/ssVVtUAmW7+NWA5UKw9EKfTa0DQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbczycEShBgd+d0C0QIEQAKmbRwQxiFlsvAOvGhshVMSozKo7AUm/9yBj4/TEup5QuPGxztnJabIctxqM1LHAkf+Vz87wA2PZiiZ55/aiBczcPu/EWl5vXgs2C9965/X9xZpv+i2hxtRj2Jn7KiIaNlxSdQR0fz2hGsakC+s+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3P+6k1x; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3P+6k1x"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso65888a91.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790268529; x=1790873329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPebfTs6ngqD5omPTzpXrw1OQUhp16wQuhk2z6XCEGE=;
        b=U3P+6k1xv0Huy31ud+FelFCMUdDvEnrNiKi3ueskGDc3q0vsY7XOkd8R9t0BgDDWFI
         6CYJbobY6BFoG2t0S/YcycgmvpbKOZ/J5KKnOHSoovx8QvPkqIrRzJjdVrpsLa81zL7D
         L4NKi+9Yip8y4MLH6uK4iX35hmhPdh8gmwGDaW1Y+jZdAUSTah25cgI2Nyy2LXX6Fwns
         O1ACj/50ErTyc4TdRmbao028hWBeYJtbaZUF4wTSTcXCTBosTU9fZfuXWPo62/ulOu53
         x5oCwak0xNF8vheLjeXhwGPROPLNvxzokJY3VicReHojXZlDHMyOtp04zoTrI8vF3POw
         KwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268529; x=1790873329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sPebfTs6ngqD5omPTzpXrw1OQUhp16wQuhk2z6XCEGE=;
        b=RT8cjdl64vhQrudHHJounT5yl20Hqu9LpX2x9E2VFwv+ndlsGNsMUdZuiv0Q9omzUP
         EU1emzJip9tjVKJLErNiTyzXUa4xeXL4RSrOEt4b5FS91g+nRyAVzB+DJQmka1VJqQb7
         K9/9t3I/KGRAUBDUL0uRxBecWSxP6ifYfZzcL/Ql07+v6KF7Nr84qaX6/34s2dr8VXDN
         fOW+2YHP4tN+l4q43iO2OOnKJkZXHCMGB8/y5F+p4nVTbVvzcoO/mNmBnUmA4JNlx3BU
         o1EHARHEvKo57R42rOSp7A53SqqcPG4Me9XJS1PRT/mYgwt3l4jmlbLHBfeno9CDnY4A
         44sw==
X-Gm-Message-State: AFuF++kaUFyC/n6oCBhzfWYBTg+l8AlWh5hgXsLw/GHWyGhcmOw9eIUH
	Ha8n4td3YEez/dmaQ7aEwIPqe+4/YmnzYuBTUJQ6emWtjhRzAJ3A6R51
X-Gm-Gg: AYBFou1Fj4gTpsl/ZulofuTTKXAwnQ7iD9hjw4t+QKIdtFZZtTqAX11EhSoCtPvi/Ls
	jwt9KBIHjd9Pi8pX57v+QKT4Pn//QgT+o8NRkIshLKm7vIeI0W2p7E1IJ/uUvZVPdWo46nao797
	d7ONM8+hYrh6Xe9tXXTUkK8zYR9DKFXnJ/uTHNUk+AQ7FBEICx+JHZeqdLcB1EsZI1SDWB4zI/J
	cPxNmqbZjldlj3XnWufQOX6b8guFiz8ujsN/QYOudV5JJ+yY+VMOzfgKY0ocmd0rXsXJq279mKV
	xd9oBant+hfY9GnW8NNWulgofJ180sVGv3pMKDvA9aXLwH1jSX68rzz77wYcnAvbvfAVNjMKSwl
	8UsVIFeCowCvEKekt1ES7lp/RSubBNhhz1uRFks5Aifin/tPhfMlm6w0DyaXLcxUEgFxOzU0Nt1
	GRdtUS4C2RbqrrQeuLmcQ8dNxxs3zSoCzvYQcU0yHmoxR0boPZ6cPn1QeH1F+lEmnk
X-Received: by 2002:a17:90b:1cce:b0:39e:6c6a:6577 with SMTP id 98e67ed59e1d1-3a098a935e8mr2892457a91.58.1790268528450;
        Thu, 24 Sep 2026 09:48:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fdbsm8126754a91.10.2026.09.24.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:48:48 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:45:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk, sdf@fomichev.me, 
	bobbyeshleman@meta.com, kaiyuanz@google.com, linux-kernel@vger.kernel.org, 
	io-uring@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist
 helpers
Message-ID: <arVTC1w_VRwH4yV5@devvm7509.cco0.facebook.com>
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-2-sdf@fomichev.me>
 <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>

On 09/24, Mina Almasry wrote:
> On Tue, Sep 22, 2026 at 1:43 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > io_uring zero-copy receive and devmem both maintain a bounded LIFO for
> > net_iovs in a contiguous area. Store the freelist in struct net_iov_area
> > and provide common push and pop helpers.
> >
> > Leave synchronization to area owners. Keep devmem's area adjacent to its
> 
> This could be a follow up change, but I think synchronization should
> be provided by the netmem/niov infra, rather than the area owners. TBH
> the infra providing an unsynchronized data structure and letting the
> area owner use it and shoot themselves in the foot feels error prone.
> For now we could use a comment.
> 
> I also think we should not provide _push and_pop functions, rather we
> should provide _push_bulk() and _pop_bulk(), and the caller can decide
> to only push and pop 1 at a time if they need to. The reason is that
> in allocation paths, we almost always want to alloc in bulk. If the
> infra had the lock it could lock once and alloc a bulk.
> 
> The free path is more nuanced. I think _push_bulk() is actually not
> currently that useful, because page_pool_put_netmem_bulk() ends up
> internally looping over individual calls to __page_pool_put_page(). It
> seems like there is a very low hanging fruit optimization possible
> here where we change things such that page_pool_put_netmem_bulk()
> actually does free the entire bulk at once, and if the pp is using a
> memory provider, it uses push _push_bulk() to free the entire stack of
> netmems with 1 lock acquire.
> 
> But these can be future optimizations, so,
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Ack, let's discuss separately, this is probably a larger refactor.

> > lock. Use u32 indices and counts, which halves devmem's freelist storage
> > on 64-bit systems. Reject devmem areas with more than U32_MAX entries
> > before narrowing the count. With 4 KiB chunks, the limit is almost 16 TiB.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  include/net/netmem.h | 28 ++++++++++++++++++++++++++-
> >  io_uring/zcrx.c      | 25 +++++++++---------------
> >  io_uring/zcrx.h      |  4 ----
> >  net/core/devmem.c    | 46 ++++++++++++++++++++++----------------------
> >  net/core/devmem.h    |  7 +++----
> >  5 files changed, 62 insertions(+), 48 deletions(-)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index bccacd21b6c3..da885d95ea63 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -101,10 +101,15 @@ struct net_iov {
> >  struct net_iov_area {
> >         /* Array of net_iovs for this area. */
> >         struct net_iov *niovs;
> > -       size_t num_niovs;
> > +
> > +       /* Stack of free net_iov indices. */
> > +       u32 *freelist;
> >
> >         /* Offset into the dma-buf where this chunk starts.  */
> >         unsigned long base_virtual;
> > +
> > +       u32 num_niovs;
> > +       u32 free_count;
> 
> Why not keep num_niovs a size_t and make free_count a size_t as well
> (so that essentially we can support anything up to SIZE_T_MAX - if
> that exists - num entries)? Do we gain anything by converting these to
> u32? I know in practice in really doens't make a difference, but since
> struct dma_buf->size is a size_t and that's usually the type we use
> for memory sizes we should use it unless we see a reason not to. Tbh I
> don't think the size of the freelist array is a big deal?

My reasoning: 4K * UINT_MAX is ~18TB which should be enough for a
foreseeable future. So just saving a few bytes, free_count was already
u32 on iour side.
