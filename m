Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB82496D34
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017597; cv=none; b=lUeGRJM85VKdbJFK0FjHufVbPjduI+5P3yF+byihHVvMUAweDTgDrWuqTUxCs/QIXG0n/8dr7B9FT2vPKc51cp4nHMumG6IFqaQVvRVNZq3agsOZ9zjy+NURBHah33WI30gzOMyvK60AZnekmaJrd+YvTSg8WkOXLEpYUyku0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017597; c=relaxed/simple;
	bh=F0/PSnK0UYXRQwLpNd8hP6ZKOte9su8aiS8d81Stb/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2LXPjF3CKJS/UJaOHNhdt+IM+CUkSgt+dCKsjuI0x4060hjhQL3unWwqT5J5E2flqbJHGWCmz5kpFj4qDL8MthxnxkMMTPHD4rh7XgDSct0z0hHq1SGtP4lwbCNzjRNVxkrZwSBmUEx2bTifQ+pH0AhAfLPrqz4sKP2SVURez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkhdQU4B; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkhdQU4B"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2e823bf32e9so2034585ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792017596; x=1792622396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UyEnW2lOZvazx37QD4Yu1Cl+1Ebx+89Hh4Lc5xhOSk=;
        b=NkhdQU4BSUgrd2KnOU1fSeIT0KDZl28mboXqjG1uBLY1r1/+3yH48RMQtFwfO3ccOu
         kj3/AqdjT5QjGvsRjfIbBomr8UxWGwGz1NA6TTeyYwvaXZ5gKS4TIS6/Ww793+AEYSZ/
         YFKQ6a5nHBfZJNJsbyHDOWm6xRkUkMQk4nS/mGqf/qvzS2oFKnEH9lHtzEqoOv5emqVb
         5pOP98lBwbxUcRZqjr1Bsxw9xiCn4ce5nP0OCv2QQRrtXgu32aEiMV0jlCuYfG+YTddN
         arVRRi1wBLb5/4CcJhyIs2pHBu5S8vGcxrigYhpr2IygHIo3B/Sw2AdrXIaAGFg27kbh
         QYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017596; x=1792622396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UyEnW2lOZvazx37QD4Yu1Cl+1Ebx+89Hh4Lc5xhOSk=;
        b=tlxTyrUWInXoF0kDvI0VhiFrAoy2Pz4NnmsHGyhbSKvBEYzsktSlPrwavuE6fTVrrB
         biARDg4jIrK6WdMkpptThuPPOEVufd2La7OQTVwoMk1UGcn4Ltrd8QI+U7DQbEjW44Yn
         df0rMBmV2xXI5MXufOZDAMm8ru6nwfLO7iwsV6Nw7E/l+NQ7IrrFp8/fooI1X8TMRfPz
         QXqqkHmuu5TnPgyi96ZmYhx2QMDzlyXPhDvArN5sJdAVEIqZkdnSJT1MmsoH/yC1FnVc
         +r282cCxXbDB+dehR+m6OwGtO0LIE85mVh5GVChAtg3aIY50pFU8D8lKcqzWD7AiZG/A
         oZRQ==
X-Gm-Message-State: AFq9FYKeqNt85tcfdxrXgp025O1WtnnNd2kZ5LqjPoY6TkXa+s5nZfTg
	XQq8gzI+xAGkeCkZrotKc5OHBo1AZvOjIsdHZWyuWwh8V4Vu5SN/QH1kGutNtWChgsY=
X-Gm-Gg: AYBFou3NUDl9ycaa3j+rhiZA2ARSypoOPGtz5mVVH0OxJoffGg+RCHpokAgeZepbMfR
	BtDJVzSFUVOWo8dJ2FiPhfU5u/V2giWMFg3l2Qj8Kw0vXHMiuxB2blAtc1NoS85o49euy4AYIIn
	Vbr1dlXOZ0ta1dP0KciD1dXqK4ujkQxXAD4Y/bgj/HJ1F8QnxvCb41ngjfm1NoD6fr0OcU8vwC0
	UiFyML5xTqZddQKb5+KqDbilFPi9023zt/BnFEBUwQGjnYtzIetyoxXmNpKMUdTpri5yVMRPqek
	M0OK6yCcBpuJpt/uBjYNkQeRq4jzaeqrxnfnPE/SKEJMVTilDuspHInuCDA4puKVWrA9iGsOD6a
	B+8I/CG8dnuNeyFqVRw2YY7h9r50kzClCr/D8WDXP5RsP8jJHTFRvdtb/ZgYZsoFiY7V2IQVslW
	TMrpSP5bxL0KevK4D7JEi4ss9kRiBghjR+MqDxMHhz76KtoqzZphQDxBeC1zgSNdqT
X-Received: by 2002:a17:903:1b0c:b0:2e9:3dd0:c8d with SMTP id d9443c01a7336-2e93dd01892mr28961315ad.14.1792017595732;
        Wed, 14 Oct 2026 15:39:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8483c3dfcsm72333795ad.24.2026.10.14.15.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:39:55 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:39:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Petr Machata <petrm@nvidia.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Jakub Raczynski <j.raczynski@samsung.com>, 
	Wang Zhan <wang.zhan@smartx.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 3/6] net: skbuff: replace skb_page_unref()
 and __skb_frag_unref() with skb_netmem_unref()
Message-ID: <atAEVu_Hife2dWUz@devvm7509.cco0.facebook.com>
References: <20261014173945.373295-1-almasrymina@google.com>
 <20261014173945.373295-4-almasrymina@google.com>
 <as_yg4hCCfpkukZB@devvm7509.cco0.facebook.com>
 <CAHS8izPDAjfRFCM2LrC7tzVQRkGCcn6zsghEvHJ9FJ1ET9odYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPDAjfRFCM2LrC7tzVQRkGCcn6zsghEvHJ9FJ1ET9odYg@mail.gmail.com>

On 10/14, Mina Almasry wrote:
> On Wed, Oct 14, 2026 at 2:25 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 10/14, Mina Almasry wrote:
> > > Unreferencing a page_pool fragment with recycle=false decrements the
> > > non-pp backing refcount instead of pp_ref_count, underflowing the page
> > > refcount when the fragment was owned via page_pool (as on mlx4's RX
> > > error path). Having both skb_page_unref() and __skb_frag_unref(frag,
> > > recycle) made it easy for callers to pass hardcoded recycle=false on
> > > SKB-owned fragments.
> > >
> > > Replace skb_page_unref() and __skb_frag_unref() with
> > > skb_netmem_unref(netmem, recycle), which dispatches to
> > > napi_pp_put_page() when recycle is true and put_netmem() otherwise:
> > >
> > > - Use skb_frag_unref(skb, ...) on SKB-owned fragments in mlx4, sky2,
> > >   tls_strp, and skb_shift() so unrefs always match skb->pp_recycle.
> > > - Use put_netmem() directly in tls_device's destroy_record(), which
> > >   releases raw non-pp page references outside an SKB.
> > >
> > > Found by code inspection and confirmed with the KUnit tests added later
> > > in this series; not observed in production. The mlx4, sky2, and TLS
> > > call-site changes are compile-tested only.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > ---
> > > v2:
> > > - Note how the issue was found and how the change was tested.
> > > - Link to v1: https://lore.kernel.org/netdev/20261010083935.3274178-4-almasrymina@google.com/
> > > ---
> > >  drivers/net/ethernet/marvell/sky2.c        |  2 +-
> > >  drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
> > >  include/linux/skbuff_ref.h                 | 34 +++++++++++-----------
> > >  net/core/skbuff.c                          |  7 +++--
> > >  net/ipv4/esp4.c                            |  4 +--
> > >  net/ipv6/esp6.c                            |  4 +--
> > >  net/tls/tls_device.c                       |  2 +-
> > >  net/tls/tls_strp.c                         |  2 +-
> > >  8 files changed, 29 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
> > > index 30facdece3e29..1d42a82db8f2b 100644
> >
> > [..]
> >
> > > --- a/drivers/net/ethernet/marvell/sky2.c
> > > +++ b/drivers/net/ethernet/marvell/sky2.c
> > > @@ -2501,7 +2501,7 @@ static void skb_put_frags(struct sk_buff *skb, unsigned int hdr_space,
> > >
> > >               if (length == 0) {
> > >                       /* don't need this page */
> > > -                     __skb_frag_unref(frag, false);
> > > +                     skb_frag_unref(skb, i);
> > >                       --skb_shinfo(skb)->nr_frags;
> > >               } else {
> > >                       size = min(length, (unsigned) PAGE_SIZE);
> > > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > > index 96f97fa0f5489..fe18606c2ab55 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > > @@ -497,7 +497,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
> > >  fail:
> > >       while (nr > 0) {
> > >               nr--;
> > > -             __skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
> > > +             skb_frag_unref(skb, nr);
> > >       }
> > >       return 0;
> > >  }
> >
> > These do not support qops and don't advertise devmem tx, so they are not
> > going to deal with netmems anytime soon, why touch these?
> >
> 
> They're still using page-backed netmems that have 2 refcounts, and
> frag ref/unref needs to pick the right one. Before they were
> hardcoding false for the pp-recycle bit, so if a skb->pp_recycle==true
> here for any reason, this code would hit a ref imbalance. Now after
> this series both skb_frag_ref and skb_frag_unref do the right thing by
> checking skb->pp_recycle.
> 
> This has nothing to do with net-iovs or devmem.

Ack, I was a bit confused because I was assuming that these are not
using pp at all, but looks like mlx4 does :-/ And I see you drop
__skb_frag_unref so these have to be converted anyway...
And I guess the same for __skb_frag_unref below.. Let me go through the
rest of the patches and see if anything else catches my eye, thanks!
