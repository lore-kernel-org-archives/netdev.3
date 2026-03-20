Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCC2F0661
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773971511; cv=none; b=p6EmXnIh7tYGMkVWJd6PeHMy9Tqg1NoUeC/eQ07PKRFaK8t/JDJ2vZfi+RanOzWUz/6DFoTwtdexnUZ5BI2TeOyDK0HCPtENnC0rNcTwLSEZsUaytEqj96Jr3l8c7/PGnikBLAeFFOTDQbkrEOwGeaMNm/9xvwGg0orWuxiJWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773971511; c=relaxed/simple;
	bh=/TbWxvlmanNQoCdIIbTnj1NseyOL63aFw965iRS1XhM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=t4cTCZjYQLuJm/MZIXrWAJv4/FaeYzYTjmc/yYKwwQzfQwWXC4kzdE7beylyktguadu5JRP/S9iMIy3IBZzx9HdxZOalcPw9597vGkcPi0GCGT3H+mCCgRsVuWWnpdNDtd/TZHQXg3ny1kjiybelB+gcE38MR6kMVL4y0FiS3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hog0R7qS; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hog0R7qS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773971502; h=Message-ID:Subject:Date:From:To;
	bh=rQ9ztebKVRUhdVhBDDLvbYshAWFrplTl6Mh171aANhU=;
	b=Hog0R7qSQ4p28zGtXpiKLJUs3OIMYJnetS6YNICq2aRhGrBkaJjG5q/OYcWvdxSiEeCFJjfsF5XGSP0EQzf4SARw4GznwvAz0aRGw5WpAvPpUvS9RyBmcDoqh9fc/73YrDRcsTxSZIu12bXbg/i+121mLwN/K7xODhmKcvCQmoo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.JxLTH_1773971500;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.JxLTH_1773971500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 09:51:41 +0800
Message-ID: <1773971222.0876994-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 20 Mar 2026 09:47:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
 <bc3a66a1-8c0d-4038-9b92-0fe3d10b1555@redhat.com>
In-Reply-To: <bc3a66a1-8c0d-4038-9b92-0fe3d10b1555@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 17 Mar 2026 12:29:17 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/13/26 8:59 AM, Xuan Zhuo wrote:
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/tun_vnet.h     |  2 +-
> >  drivers/net/virtio_net.c   |  6 +++++-
> >  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
> >  3 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index a5f93b6c4482..fa5cab9d3e55 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> >
> >  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> >  					tun_vnet_is_little_endian(flags),
> > -					vlan_hlen, true)) {
> > +					vlan_hlen, true, false)) {
> >  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
> >  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 72d6a9c6a5a2..7106333ef904 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> >  	int num_sg;
> >  	unsigned hdr_len = vi->hdr_len;
> > +	bool feature_hdrlen;
> >  	bool can_push;
> >
> > +	feature_hdrlen = virtio_has_feature(vi->vdev,
> > +					    VIRTIO_NET_F_GUEST_HDRLEN);
> > +
> >  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> >  	/* Make sure it's safe to cast between formats */
> > @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >
> >  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> >  					virtio_is_little_endian(vi->vdev), 0,
> > -					false))
> > +					false, feature_hdrlen))
> >  		return -EPROTO;
> >
> >  	if (vi->mergeable_rx_bufs)
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 75dabb763c65..48de4a16a96a 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >  	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> >  }
> >
> > +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> > +					 struct virtio_net_hdr *hdr,
> > +					 bool little_endian)
> > +{
> > +	u16 hdr_len;
> > +
> > +	hdr_len = skb_transport_offset(skb);
> > +
> > +	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > +		hdr_len += sizeof(struct udphdr);
> > +	else
> > +		hdr_len += tcp_hdrlen(skb);
> > +
> > +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> > +}
>
> The series LGTM, let's wait for Jason and or Michael.
>
> If another revision is needed, please consider factoring out a
> __virtio_net_set_hdrlen() helper taking an additional explicit
> transport_offset argument, to deduplicate a bit the code between patch
> 1/2 and 2.2. Not a blocked anyway for me.

Hi, currently, a new version seems necessary. However, I do not plan to
implement it this way. This is because we require two parameters: one for
transport and another for TCP offset (tcp_hdrlen or inner_tcp_hdrlen). I believe
it would be inappropriate to put the TCP offset into the parameters as well,
since we must first determine whether the protocol is TCP before calling
tcp_hdrlen or inner_tcp_hdrlen. Therefore, I think having two
separate functions is clearer.

Thanks.


>
> /P
>
