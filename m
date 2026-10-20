Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515202;
	b=Fv6VELwUKhA2m0rjF5BSqWKXcrOgFe8vL6/G9UftSQnCN8uF9Ki6BLwnMuYQ7RfNn31z
	 ePKn3357hfQkSXwghE0+Nex87GLpOcaqe3Li7umKtFi/D6M26wlfN1jG0QQB7/NEH4oub
	 eQNYkJF40I+K+1hI3rMxStpt6/miXfsdUM2d8s4SUGTW+KkA7598BrMJUC91bjd0NMdMG
	 mOdo/3I4nAzz15ZOkLZ5iEyg42+xJqIjTgD9zL8sfwOXoG0o3HRsmGYa7ln7SJgNFAb2n
	 5ioVRVBqriFiXv/bX3sG0LDlMbLC6+UTYz09aHvYVlLzzLaV3pSKyxLlqfvLkZv/i3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515202;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=imfu4Q1xLhRu8Rb4R6sPh28+g8HdrHEwcBOMUN84DFw=;
	b=bn8ZQnS3L+iShialp3gS4fPfvoHj3sDlTD+15uz/N2gjX9IuaaNu6+Md/HRjb4gL+kxs
	 WoDTzgiz03lEvF3bBlCCWrHn9jtIMzg8QeJS0K7VR5IrTZKt+aJb+eRI1FbhTxU/U2Wo8
	 u5T/3GUn8kOXcIkIZcQoGF59WHtKiSbFRUwRHkFCIYIVc3SLXTsj5u3KrjLdmA9l25d8g
	 k6nyf3O9lMmS2iEBLwHjmgdTpWx0svpnnuUyF/qRTHYqXc6VAuBZYlHGs1HwqJuTKf9v3
	 cwjHhxMM1zW6CaTwU0ve9LQBAZc2V8wfx+izNfJBOYpSNoeFB9NPOTMivkOLpbhoceQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=bwnnMoh3;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3BCCB606A324;
	Tue, 20 Oct 2026 16:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BCCB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=bwnnMoh3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1792515199;
	bh=imfu4Q1xLhRu8Rb4R6sPh28+g8HdrHEwcBOMUN84DFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwnnMoh30H86OwYZ15UsSWVlD17cstjAGJtXI+iGD+SzpfNiBGGTq+ect7vgMAOxD
	 5R65v7pv3HGbBxpj5Ux8/9X+yLGY6ql0/BftfGBwuzte93HVxjBWPU2ug4zu/hj8gd
	 j6hQSQG9V/E/Q5tTuTGksLiZ1r0rT+LH5/+vjtwS1S639ZEETeoXDqn8btJiL5xYiO
	 3N/ceCCa9P6fOX5cifyzniGRKfleamtvNjfByKkUuW2dIL4JP2DROO2P3A1QXtM9jH
	 Xqyq61gqL3nOXDWZSIr3zK1Bd260eysJk33efAN2SnsqAgGVzmTcpMnLtVtfAFaO56
	 /LCfCrpnf5/Jw==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id BC99660051;
	Tue, 20 Oct 2026 18:53:19 +0200 (CEST)
Date: Tue, 20 Oct 2026 18:53:16 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
Message-ID: <atecfDGNBh2XIHqm@chamomile>
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
 <ee955f2c-c97b-4505-a996-f7d7c5d2a3f5@linux.dev>
 <ateaf9-cY50Goz0j@chamomile>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ateaf9-cY50Goz0j@chamomile>

On Tue, Oct 20, 2026 at 06:44:50PM +0200, Pablo Neira Ayuso wrote:
> On Wed, Oct 21, 2026 at 12:10:32AM +0800, Qingfang Deng wrote:
> > On 10/20/2026 11:08 PM, Eric Dumazet wrote:
> > > Le mar. 20 oct. 2026 à 16:30, Qingfang Deng <qingfang.deng@linux.dev> a écrit :
> > > > 
> > > > Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO packet
> > > > forwarded by a bridge can retain hardware GSO features and reach the
> > > > driver without software segmentation, if the egress Ethernet interface
> > > > advertises TSO.
> > > > 
> > > > To force software segmentation, clear the GSO feature mask for
> > > > ETH_P_PPP_SES in harmonize_features().
> > > > 
> > > > Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> > > > Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> > > > ---
> > > >   net/core/dev.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index a6951ea08961..27483a2ad747 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(struct sk_buff *skb,
> > > >          type = skb_network_protocol(skb, NULL);
> > > >          features = net_mpls_features(skb, features, type);
> > > > 
> > > > +       /* Ordinary TSO does not update the PPPoE payload length. */
> > > > +       if (IS_ENABLED(CONFIG_PPPOE) && type == htons(ETH_P_PPP_SES))
> > > > +               features &= ~NETIF_F_GSO_MASK;
> > > > +
> > > >          if (skb->ip_summed != CHECKSUM_NONE &&
> > > >              !can_checksum_protocol(features, type)) {
> > > >                  features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> > > > --
> > > > 2.34.1
> > > > 
> > > 
> > > Ouch.
> > > 
> > > harmonize_features() is called for every packet, GSO or not.
> > > 
> > > This is a GSO-only problem, please do not add more protocol-specific
> > > tests in this path. gso_features_check() is only called for GSO
> > > packets, and the cost there is amortized over all segments.
> > > 
> > > Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
> > > because of the can_checksum_protocol() check in harmonize_features(),
> > > and fraglist GRO packets (the main use case for PPPoE GRO) are
> > > segmented in software anyway.
> > > 
> > > This leaves bridged, non fraglist GRO PPPoE packets sent to a
> > > NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?
> > 
> > I reproduced this on a VM veth interface, which advertises both features.
> > The real hardware I have is an Intel IGC but I have not tested with it.
> 
> IIRC, I could reproduce the issue too with a virtio netdevice.
> 
> I made this inaceptable patch (see oneliner patch with protocol
> specific update below), so the recent pppoe gso support kicks.
> 
> I guess adding NETIF_F_GSO_PPPOE (similar to NETIF_F_GSO_SCTP) is a
> no-go to force software tx path to segment skbs too?

s/NETIF_F_GSO_/SKB_GSO_

> Thanks.
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 9981d637f8b5..07bf265d0295 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5514,7 +5514,8 @@ static inline bool netif_needs_gso(struct sk_buff *skb,
>  {
>         return skb_is_gso(skb) && (!skb_gso_ok(skb, features) ||
>                 unlikely((skb->ip_summed != CHECKSUM_PARTIAL) &&
> -                        (skb->ip_summed != CHECKSUM_UNNECESSARY)));
> +                        (skb->ip_summed != CHECKSUM_UNNECESSARY)) ||
> +               unlikely(skb->protocol == htons(ETH_P_PPP_SES)));
>  }
>  
>  void netif_set_tso_max_size(struct net_device *dev, unsigned int size);
> 
