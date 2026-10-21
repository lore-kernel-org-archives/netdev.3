Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600126;
	b=TpoRalt/cJL4ZG4IHjiEGwHSH83jatf/KMR3U8Q8j9EgZnL3j0zgDJQzrQWZKPZvCI6D
	 SGPQE4ceq4LvFzHVAs1HvSJZI8VCj6z0qStwyz16aYHMkl3snQs28KyJC4h6p/UzqO37H
	 xppSLFU7w0akafjN3R7GcoA5Ro8HL3eLrSw5Mu2ChsjiB1RmQKxjPBTY5obA5hicPRoWP
	 DZQlE5f1lSqdCmEy24zfmaz+QevVuErFDSwLe7tIQRkesgyx7YtHDrwF+amjG9RhoB43k
	 RTDgj71uK75r+P+WmS9YGfHd+C72HdH17soYlMMQB2uFIPHf2O3/sadQtlR8pFF+3QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600126;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DuhU5hIzP9cRbXzhddHSBskcwCIQgflcGLokcZYSZwc=;
	b=ZqneR42PpvPSeHgvbGUTEr8f7I+WoYloWCCVgHWsHCb/G0ZzizYmubigDa3CwX4vxhBF
	 7UdsXEIZYYy53ASDioB3QgjDbGfPQ2BQbO3bqtRKsoarxOYgr6FUCsBqx5uW4G1W09nna
	 Rw9mqWs4JaWP2Ly3DfMk5QqE8EGEvlJD72KW0jbrZKil33khHzWb/Egxy6OQsY7Kp/feJ
	 fK4IKPkGJZagdog5gYT7d4LKhg/MX27nUYrYaTb0SeHRz1Vlx+UC5bqlx1gsMfwseCXDx
	 S/eU9xA+8OHpJiVKOgg/IQ3YT733lZ//QtSysCgj39oLQEMC/q60eQqY+ZNtwdQzk5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WI6gwNrB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y9h6D6mv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB8606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WI6gwNrB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y9h6D6mv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuhU5hIzP9cRbXzhddHSBskcwCIQgflcGLokcZYSZwc=;
	b=WI6gwNrBotPKG5KuLqRAbxeABOp0v6UwEZLaTLiuo5nQEB/OCVUyMNVveCxrlVmWMBnycn
	Hlj87HA7uR2W8tnTdmkWKqJFOdeL83JautYFiXJKD9GEbI6H32kB3Gj4mDN+hBrQYZMcar
	d6TkuCAh9It2/AJHB9SC1Or7m/NtO3w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-NiLHlHWFNVeIcDqhNsqXSQ-1; Wed, 21 Oct 2026 12:28:42 -0400
X-MC-Unique: NiLHlHWFNVeIcDqhNsqXSQ-1
X-Mimecast-MFC-AGG-ID: NiLHlHWFNVeIcDqhNsqXSQ_1792600121
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso488707f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792600121; x=1793204921; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuhU5hIzP9cRbXzhddHSBskcwCIQgflcGLokcZYSZwc=;
        b=Y9h6D6mvFRP9NpOgIQUk0fUN+R+7gbY0OOWoFSWjGn/Wn2dOn+PpES1ifbVFt5LKiX
         SIZlWPvN9/1fHCFh2GtQs2oN4LnAaXEAokYH/mEoVjmInJo/DBllcUQL3hFi5cS9WhIk
         SflsNqtWRVuwrWu2+DPJ4iWCyVWnct/qn1GDeQ0dswrachrYXQBqqUyufN1YXj5ckopO
         dcSkTEbET+EkD6e2bYpTUQrps/ikEuohNgPaAz97nTThCLbuFWdQAyfw4XtP/Hl4jpls
         rLjsQXh/Xl/lhY2woQpgZ+fJp4t5c1jtGTZmzvGi2O40iOn9IV022jzQH0/Mv2yslsED
         9yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600121; x=1793204921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DuhU5hIzP9cRbXzhddHSBskcwCIQgflcGLokcZYSZwc=;
        b=oVe5LRlZw/wf58XSg/3d6R8HCXRj+DXfo3OfRCeDz7ftD6AhOw0QWSVC968qTbqWLW
         P/qfzVzV0qTydcnRUP6FuQoL1biPwbiHC9oN3n3C/81gfxZe3brP5zHdMqeauDUat8wk
         NPmD3qE8sG1Ffz/cfBWZyeHQDTZhsVHY2/f2TtcWvIQLHNPm0Mqk70eNv4Wz8yKuk8ic
         nNq3uOkvCq1zKo0tlQNBvwoOWx6uPYcfV1nopxFX6BTTS/kYaMds17qTPjzSGyPH4WSJ
         U4bBK83pqz5EV3RAb7MDouLNdsNvnRDyloAERMlIh86e3r5kfpi1+oX7N7lfFTCeUEOz
         z0Ow==
X-Forwarded-Encrypted: i=1; AKwUvBzQEx/3ihn9oiNIhCDHjRd7RhYwh2CaQb4z3AkwwKSi+Lwag5CjsbAomxovSSt0vZ74zF1nqT8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrmSXhqiu/PQ2O53nzbb7JGtLK/+y6E9QZEneZPy73TMo0lMoB
	mtHakJGdTqTv8dpbfgfRvImI2TVDB8r9j6VRMTb4sTKL4b9/CBpVckp6RufyZftek8XPtZdihqi
	JWr18iQ76o/dt7mFVN68eOrWzqEgWsnhBIOr4+tVmrVnJg045nIGURKgovg==
X-Gm-Gg: AYBFou2EhM6esJ3zL9gpgRM6ZUyxj+gszAXIzs+OMz3dqMSOMEoK35k/sAdap5mkQxH
	ArKIwhz5MdNNG8S4lO2KsrJcR/s+TPXNoZE3syy7QDZ8HWWeciLA801MBPYhxjck5wB04LtbBAW
	vj7bAxMHcDPt2Oh4R+xZGjJL8nlg04q4IMTnRmvnu+nphkJARLexruqiy5dAMWDwu169VKWG7Yv
	Fg1IxDbmNh3nCZB9IBF5O/QSEgz+fqX2fFuUFvPw8gTof1J94oCgp7qDJjN+WoKktj47jdBHRz2
	2wE35kc7Bmf+C7s3YCcJprCHNytgXn9H0dOyOlTG8YvIXYHnXx1HbKNhy/SBvDXuUPM=
X-Received: by 2002:adf:f5c2:0:b0:48d:ed3c:4cdd with SMTP id ffacd0b85a97d-48e264e014cmr4386724f8f.49.1792600120564;
        Wed, 21 Oct 2026 09:28:40 -0700 (PDT)
X-Received: by 2002:adf:f5c2:0:b0:48d:ed3c:4cdd with SMTP id ffacd0b85a97d-48e264e014cmr4386659f8f.49.1792600119920;
        Wed, 21 Oct 2026 09:28:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm7086866f8f.40.2026.10.21.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:28:38 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:28:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Simon Horman <horms@kernel.org>, linux-um@lists.infradead.org
Subject: Re: [PATCH net v4 1/7] net: account for ingress-resolved virtio net
 hdr state
Message-ID: <20261021122818-mutt-send-email-mst@kernel.org>
References: <cover.v4.git.mst@redhat.com>
 <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <willemdebruijn.kernel.190b5b13a550@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.190b5b13a550@gmail.com>

On Wed, Oct 21, 2026 at 12:08:06PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > The following patch will add ingress resolution of uncommon virtio net
> > hdr checksum metadata (software checksum completion at ingress) which
> > adds performance overhead to the packet processing.
> > 
> > We should make it visible, so a hypothetical workload relying on
> > uncommon metadata can be distinguished from none at all. This way issues
> > in the parsing will be reported and not quietly pay the host-CPU
> > checksum overhead instead of offload.
> > 
> > Flip every call to virtio_net_hdr_to_skb to test for negative errno
> > only.  The um vector raw transport even ignored the return value
> > altogether: rejected packets went on into the stack with their
> > metadata unvalidated, so check it there as well.
> > 
> > Have tun, tap and virtio_net count these events per device as
> > rx_csum_sw, exposed via ethtool -S.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/um/drivers/vector_transports.c |  4 ++-
> >  drivers/net/ipvlan/ipvtap.c         | 36 +++++++++++++++++++++++++
> >  drivers/net/macvtap.c               | 36 +++++++++++++++++++++++++
> >  drivers/net/tap.c                   |  8 ++++--
> >  drivers/net/tun.c                   | 41 +++++++++++++++++++++++++++--
> >  drivers/net/virtio_net.c            | 15 ++++++++---
> >  include/linux/if_tap.h              |  1 +
> >  net/packet/af_packet.c              |  4 +--
> >  8 files changed, 135 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > index e1fb2a76fdff..8b7548458663 100644
> > --- a/arch/um/drivers/vector_transports.c
> > +++ b/arch/um/drivers/vector_transports.c
> > @@ -210,7 +210,9 @@ static int raw_verify_header(
> >  		return 1;
> >  
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > +			virtio_legacy_is_little_endian()) < 0)
> > +		return -1;
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
> > index 66c949d94261..9e2f1c7073d2 100644
> > --- a/drivers/net/ipvlan/ipvtap.c
> > +++ b/drivers/net/ipvlan/ipvtap.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  #include <linux/etherdevice.h>
> > +#include <linux/ethtool.h>
> >  #include "ipvlan.h"
> >  #include <linux/if_vlan.h>
> >  #include <linux/if_tap.h>
> > @@ -74,6 +75,32 @@ static void ipvtap_update_features(struct tap_dev *tap,
> >  	netdev_update_features(vlan->dev);
> >  }
> >  
> > +static int ipvtap_get_sset_count(struct net_device *dev, int sset)
> > +{
> > +	return sset == ETH_SS_STATS ? 1 : -EOPNOTSUPP;
> > +}
> > +
> > +static void ipvtap_get_strings(struct net_device *dev, u32 stringset,
> > +			       u8 *data)
> > +{
> > +	if (stringset == ETH_SS_STATS)
> > +		ethtool_puts(&data, "rx_csum_sw");
> > +}
> > +
> > +static void ipvtap_get_ethtool_stats(struct net_device *dev,
> > +				     struct ethtool_stats *stats,
> > +				     u64 *data)
> > +{
> > +	struct ipvtap_dev *vlantap = netdev_priv(dev);
> > +
> > +	data[0] = atomic64_read(&vlantap->tap.rx_csum_sw);
> > +}
> > +
> > +/* checkpatch warns but this can't be const: cloned from ipvlan's
> > + * ops at newlink time, with the statistics above added.
> > + */
> > +static struct ethtool_ops ipvtap_ethtool_ops;
> > +
> >  static int ipvtap_newlink(struct net_device *dev,
> >  			  struct rtnl_newlink_params *params,
> >  			  struct netlink_ext_ack *extack)
> > @@ -91,6 +118,15 @@ static int ipvtap_newlink(struct net_device *dev,
> >  	vlantap->tap.update_features =	ipvtap_update_features;
> >  	vlantap->tap.count_rx_dropped = ipvtap_count_rx_dropped;
> >  
> > +	/* ipvlan's ethtool ops are already installed at this point;
> > +	 * clone them and add the tap statistics on top.
> > +	 */
> > +	ipvtap_ethtool_ops = *dev->ethtool_ops;
> > +	ipvtap_ethtool_ops.get_sset_count = ipvtap_get_sset_count;
> > +	ipvtap_ethtool_ops.get_strings = ipvtap_get_strings;
> > +	ipvtap_ethtool_ops.get_ethtool_stats = ipvtap_get_ethtool_stats;
> > +	dev->ethtool_ops = &ipvtap_ethtool_ops;
> > +
> 
> LLM:
> 
>   This cloning pattern in ipvtap_newlink (and identically in macvtap_newlink below) has serious concurrency and hardening issues:
>   1. Concurrent Data Race: ipvtap_ethtool_ops is a single static global struct. Although newlink runs under rtnl_lock(), ethtool readers on
>   existing devices (e.g. netlink stats_prepare_data() and strset_prepare_data()) run under rcu_read_lock() without RTNL. Whenever a new
>   ipvtap/macvtap device is created, ipvtap_ethtool_ops = *dev->ethtool_ops overwrites the global ops table in-place, temporarily clearing
>   get_sset_count and get_strings to NULL before re-populating them. Any concurrent ethtool query on an existing device can observe NULL or
>   torn function pointers.
>   2. Writable Function Pointer Table: ethtool_ops contains function pointers and should reside in .rodata (const) to prevent kernel exploit
>   targets.
>   3. Hardcoded Set Count: ipvtap_get_sset_count returns 1 unconditionally; if the lower device ever adds ethtool stats in the future, they
>   are completely masked.
> 
>   Instead of dynamically mutating a non-const global ops struct on every newlink, either:
>   • Export the base ops from macvlan/ipvlan so tap can declare a const struct ethtool_ops directly, or
>   • At the very least, initialize it once (e.g. guarded by a check or at module init) so it is not re-clobbered while readers are active.
> 
> Additionally, in general, ipvlan/macvlan/tun/tap changes are preferred
> to be individual patches.
> 
> I don't think this is as important as the main patches 4 and 5. If you
> want to submit quickly, I would drop/postpone these second order
> features. Maybe go back to the previous tun-only counter for now, if
> you consider that important enough.

ok I will do tun only.

> >  	err = netdev_rx_handler_register(dev, tap_handle_frame, &vlantap->tap);
> >  	if (err)
> >  		return err;
> > diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
> > index cc975dfb7380..3288cc6ae6c2 100644
> > --- a/drivers/net/macvtap.c
> > +++ b/drivers/net/macvtap.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  #include <linux/etherdevice.h>
> > +#include <linux/ethtool.h>
> >  #include <linux/if_macvlan.h>
> >  #include <linux/if_tap.h>
> >  #include <linux/if_vlan.h>
> > @@ -78,6 +79,32 @@ static void macvtap_update_features(struct tap_dev *tap,
> >  	netdev_update_features(vlan->dev);
> >  }
> >  
> > +static int macvtap_get_sset_count(struct net_device *dev, int sset)
> > +{
> > +	return sset == ETH_SS_STATS ? 1 : -EOPNOTSUPP;
> > +}
> > +
> > +static void macvtap_get_strings(struct net_device *dev, u32 stringset,
> > +				u8 *data)
> > +{
> > +	if (stringset == ETH_SS_STATS)
> > +		ethtool_puts(&data, "rx_csum_sw");
> > +}
> > +
> > +static void macvtap_get_ethtool_stats(struct net_device *dev,
> > +				      struct ethtool_stats *stats,
> > +				      u64 *data)
> > +{
> > +	struct macvtap_dev *vlantap = netdev_priv(dev);
> > +
> > +	data[0] = atomic64_read(&vlantap->tap.rx_csum_sw);
> > +}
> > +
> > +/* checkpatch warns but this can't be const: cloned from macvlan's
> > + * ops at newlink time, with the statistics above added.
> > + */
> > +static struct ethtool_ops macvtap_ethtool_ops;
> > +
> >  static int macvtap_newlink(struct net_device *dev,
> >  			   struct rtnl_newlink_params *params,
> >  			   struct netlink_ext_ack *extack)
> > @@ -99,6 +126,15 @@ static int macvtap_newlink(struct net_device *dev,
> >  	vlantap->tap.count_rx_dropped = macvtap_count_rx_dropped;
> >  	vlantap->tap.update_features  = macvtap_update_features;
> >  
> > +	/* macvlan's ethtool ops are already installed at this point;
> > +	 * clone them and add the tap statistics on top.
> > +	 */
> > +	macvtap_ethtool_ops = *dev->ethtool_ops;
> > +	macvtap_ethtool_ops.get_sset_count = macvtap_get_sset_count;
> > +	macvtap_ethtool_ops.get_strings = macvtap_get_strings;
> > +	macvtap_ethtool_ops.get_ethtool_stats = macvtap_get_ethtool_stats;
> > +	dev->ethtool_ops = &macvtap_ethtool_ops;
> > +
> >  	err = netdev_rx_handler_register(dev, tap_handle_frame, &vlantap->tap);
> >  	if (err)
> >  		return err;
> > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > index ff67d99deb39..d7520622e809 100644
> > --- a/drivers/net/tap.c
> > +++ b/drivers/net/tap.c
> > @@ -649,11 +649,13 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >  
> >  	if (vnet_hdr_len) {
> >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > -		if (err) {
> > +		if (err < 0) {
> >  			rcu_read_unlock();
> >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> >  			goto err_kfree;
> >  		}
> > +		if (err > 0)
> > +			atomic64_inc(&tap->rx_csum_sw);
> >  	}
> >  
> >  	skb_probe_transport_header(skb);
> > @@ -1084,10 +1086,12 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >  
> >  	if (vnet_hdr_len) {
> >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > -		if (err) {
> > +		if (err < 0) {
> >  			rcu_read_unlock();
> >  			goto err_kfree;
> >  		}
> > +		if (err > 0)
> > +			atomic64_inc(&tap->rx_csum_sw);
> 
> (repeat) reset err to 0 in all paths.
> 
> >  	}
> >  
> >  	skb_probe_transport_header(skb);
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 242899f7fd07..19cb443c89b0 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -210,6 +210,7 @@ struct tun_struct {
> >  	u32 flow_count;
> >  	u32 rx_batched;
> >  	atomic_long_t rx_frame_errors;
> > +	atomic64_t rx_csum_sw;
> >  	struct bpf_prog __rcu *xdp_prog;
> >  	struct tun_prog __rcu *steering_prog;
> >  	struct tun_prog __rcu *filter_prog;
> > @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >  		break;
> >  	}
> >  
> > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> > +	if (err < 0) {
> >  		atomic_long_inc(&tun->rx_frame_errors);
> >  		err = -EINVAL;
> >  		goto free_skb;
> >  	}
> > +	if (err > 0) {
> > +		atomic64_inc(&tun->rx_csum_sw);
> > +		err = 0;
> > +	}
> >  
> >  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> >  		skb->protocol = eth_type_trans(skb, tun->dev);
> > @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
> >  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> >  	skb->dev = tun->dev;
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> > +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> > +	if (ret < 0) {
> >  		atomic_long_inc(&tun->rx_frame_errors);
> >  		kfree_skb(skb);
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> > +	if (ret > 0)
> > +		atomic64_inc(&tun->rx_csum_sw);
> >  
> >  	skb->protocol = eth_type_trans(skb, tun->dev);
> >  	skb_reset_network_header(skb);
> > @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
> >  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
> >  }
> >  
> > +#define TUN_STATS_LEN	1
> > +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> > +	"rx_csum_sw",
> > +};
> > +
> > +static int tun_get_sset_count(struct net_device *dev, int sset)
> > +{
> > +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> > +}
> > +
> > +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > +{
> > +	if (stringset == ETH_SS_STATS)
> > +		memcpy(data, tun_ethtool_strings,
> > +		       sizeof(tun_ethtool_strings));
> > +}
> > +
> > +static void tun_get_ethtool_stats(struct net_device *dev,
> > +				  struct ethtool_stats *stats, u64 *data)
> > +{
> > +	struct tun_struct *tun = netdev_priv(dev);
> > +
> > +	data[0] = atomic64_read(&tun->rx_csum_sw);
> > +}
> > +
> >  static const struct ethtool_ops tun_ethtool_ops = {
> > +	.get_sset_count		= tun_get_sset_count,
> > +	.get_strings		= tun_get_strings,
> > +	.get_ethtool_stats	= tun_get_ethtool_stats,
> >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
> >  	.get_drvinfo	= tun_get_drvinfo,
> >  	.get_msglevel	= tun_get_msglevel,
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index daab43ac92ce..b0441bf8e875 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -125,6 +125,7 @@ struct virtnet_rq_stats {
> >  	u64_stats_t packets;
> >  	u64_stats_t bytes;
> >  	u64_stats_t drops;
> > +	u64_stats_t rx_csum_sw;
> >  	u64_stats_t xdp_packets;
> >  	u64_stats_t xdp_tx;
> >  	u64_stats_t xdp_redirects;
> > @@ -158,6 +159,7 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
> >  
> >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> >  	VIRTNET_RQ_STAT("drops",         drops),
> > +	VIRTNET_RQ_STAT("rx_csum_sw",    rx_csum_sw),
> >  	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
> >  	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
> >  	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
> > @@ -2502,6 +2504,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> >  {
> >  	struct virtio_net_common_hdr *hdr;
> >  	struct net_device *dev = vi->dev;
> > +	int ret;
> >  
> >  	hdr = skb_vnet_common_hdr(skb);
> >  	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > @@ -2517,15 +2520,21 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> >  
> >  	skb->dev = dev;
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> > -				      vi->rx_tnl_csum,
> > -				      virtio_is_little_endian(vi->vdev))) {
> > +	ret = virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> > +					vi->rx_tnl_csum,
> > +					virtio_is_little_endian(vi->vdev));
> > +	if (ret < 0) {
> >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> >  				     dev->name, hdr->hdr.gso_type,
> >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> >  				     vi->rx_tnl, vi->rx_tnl_csum);
> >  		goto frame_err;
> >  	}
> > +	if (ret > 0) {
> > +		u64_stats_update_begin(&rq->stats.syncp);
> > +		u64_stats_inc(&rq->stats.rx_csum_sw);
> > +		u64_stats_update_end(&rq->stats.syncp);
> > +	}
> 
>   Because rx_csum_sw was added to virtnet_rq_stats_desc[], virtnet_poll() already iterates through virtnet_rq_stats_desc[] and syncs each
>   field from the local stack stats into rq->stats at the end of the NAPI polling cycle inside a single u64_stats_update_begin/end(&rq-
>   >stats.syncp).
>   Calling u64_stats_update_begin/end(&rq->stats.syncp) directly per-packet in virtnet_receive_done() bypasses that batching pattern. While SW
>   csum is off the fast path, it is inconsistent with how other rq stats are handled.
> 
> >  
> >  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> >  	skb->protocol = eth_type_trans(skb, dev);
> > diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
> > index 553552fa635c..4eac24bb1df7 100644
> > --- a/include/linux/if_tap.h
> > +++ b/include/linux/if_tap.h
> > @@ -41,6 +41,7 @@ struct tap_dev {
> >  	struct list_head	queue_list;
> >  	int			numvtaps;
> >  	int			numqueues;
> > +	atomic64_t		rx_csum_sw;
> >  	netdev_features_t	tap_features;
> >  	int			minor;
> >  
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 52ae3d875e97..e6aec9ecfa99 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
> >  		}
> >  
> >  		if (has_vnet_hdr) {
> > -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> > +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> >  				tp_len = -EINVAL;
> >  				goto tpacket_error;
> >  			}
> > @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> >  
> >  	if (vnet_hdr_sz) {
> >  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> > -		if (err)
> > +		if (err < 0)
> >  			goto out_free;
> >  		len += vnet_hdr_sz;
> >  	}
> > -- 
> > MST
> > 
> 

