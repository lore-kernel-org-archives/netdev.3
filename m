Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6C2931F5
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696472; cv=none; b=Jx77KY3wEqPMj0ulz5G4CuTs9dVFkHZoW3f1drev+hph3g48yaLdl4T+PVeGVMGiKdPS6fCiI2NsRFodfxdJidnHbe9SSXQJ1wiEzlwIXj4o1yoFs7COmUbmTYLmWkKAYWS6nl0hLmJO4E3kue9TWt7h4TDTNA3m9GQvXqpGXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696472; c=relaxed/simple;
	bh=foON8w2BXwgTkz25IulWSyqmpatz6vUJ0ov4ZkYDheE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVfszxhD08zfqvIYtLZE4UkPhfuJybt2d0r0vPhKPjxGhxa0DsBpsPtVM0fPM9mq5JC4EmqjRU5VsbljDONWVS39E5RnwyNo28lLpqihusbb18bvLiRaufmVF+wx8FS3g2Q4vBEuW80aj3IvYXvQHSEU/JzUzTs/00HarPbAHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=cnwLKy/O; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="cnwLKy/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1787696461;
	bh=seHYojO4zctnClsc1uQ+nVDx9aEcAQUJZNaT8oCMIwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnwLKy/Ow+5zwCDEfKGzgVZtnjZ1KSqLmylPLWarDIN/cKUnSFOOEPrGNeuNxvzH2
	 yQ9ebw4sGrA6qzL4aF8cc9B1soFXkP1EtCpZ9SuNPWzuU18WLF5RT68vI+KP/HykK4
	 NkQoF78vSuppsnr5AikkP7+SQBiZh6+5rR/aJQ0kirQ6NxYpKX4RDLUmqE9jONKWBU
	 qz3sOS5DM9ARMFGZbuFlF7UfbCtc1gu+nFYqCk6DC8oheMXQJhS/w75nUgVtPvlSYE
	 LKTXyDQc6fy/95q2myPBUcS6cIg2ecQVrTMRQz8R1e54HsxxS81uNJ4apD84O8YnCi
	 CUkSxPy6c59Dw==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id EA6EF6005E;
	Wed, 26 Aug 2026 00:21:00 +0200 (CEST)
Date: Wed, 26 Aug 2026 00:20:58 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, laforge@gnumonks.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	kees@kernel.org, netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, zhangchangzhong@huawei.com,
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: iptunnel: fix stale transport header during
 tunnel decapsulation
Message-ID: <ao4VSt1Vzmj6XBfE@chamomile>
References: <20260825095000.1461124-1-dongchenchen2@huawei.com>
 <CANn89iJwWL9NdC19XbSFq7sf_tsZS96PTXWgO3oUMGJRkA0g-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJwWL9NdC19XbSFq7sf_tsZS96PTXWgO3oUMGJRkA0g-w@mail.gmail.com>

On Tue, Aug 25, 2026 at 11:59:53AM +0200, Eric Dumazet wrote:
> On Tue, Aug 25, 2026 at 11:41 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
> >
> > Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
> > transport_header offset after tunnel decapsulation.
> >
> >
> > The issue is completely latent until qdisc read transport header in
> > commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()").
> > The crash requires four conditions to line up:
> >
> > 1. The incoming packet is encapsulated and carries GSO metadata. The outer
> >    transport header offset is stored in skb->transport_header while the
> >    packet is still in the outer tunnel context.
> > 2. The tunnel receiver strips the outer headers. skb->data is advanced to
> >    the inner frame, but skb->transport_header is left pointing to the
> >    now-removed outer L4 header, so it becomes a negative offset relative to
> >    the new data.
> > 3. The inner frame is not delivered to the local IP stack. Instead, it
> >    is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
> >    the transport header is not reset to the inner L4 offset.
> > 4. The forwarding path calls __dev_queue_xmit(), which enters
> >    qdisc_pkt_len_segs_init(). That function computes the GSO header length
> >    from skb_transport_offset(skb). Because the offset is negative, the
> >    unsigned cast overflows and pskb_may_pull(skb, hdr_len +
> >    sizeof(struct tcphdr)) reads past the end of the skb, triggering a
> >    KASAN fault or page fault.
> >
> > The issue specifically requires GSO packets (shinfo->gso_size != 0), which
> > are processed/aggregated through gro_cells. Fix this by clearing
> > transport_header to the ~0U sentinel in gro_cell for all tunnnel driver.
> > GTP does not support GRO/GSO, drop the evil GSO packets in GTP directly.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/69de2bee.a00a0220.475f0.0041.GAE@google.com/T/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> > ---
> >  drivers/net/gtp.c      | 5 +++++
> >  include/linux/skbuff.h | 5 +++++
> >  net/core/gro_cells.c   | 2 ++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 9a12cc53da00..fbf617b1acc9 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -312,6 +312,11 @@ static int gtp_inner_proto(struct sk_buff *skb, unsigned int hdrlen,
> >  static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
> >                   unsigned int hdrlen, unsigned int role, __u16 inner_proto)
> >  {
> > +       if (skb_is_gso(skb)) {
> > +               netdev_dbg(pctx->dev, "GSO is not support in GTP\n");
> 
> Patch looks good to me but there is a small typo here.
> 
>                     netdev_dbg(pctx->dev, "GSO is not supported in GTP\n");
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Ouch, may I have a chance to fix GSO in this driver?

Thanks!
