Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527005;
	b=zdbOGWqrl6rTBNBDrNHcU5SEGWWQoEPTTYFLSdiUJD1tZdopp84mLuGujucsL7v5nuly
	 l68jJkknzqAnqUqBXLbJbi/0lnyXHUW29sErCKGSeO+BK4uTJP8oBzxYdNirwRnr1EoB2
	 wSqlxxc9fjd6DKXW1J6nd1kuEDBU8gVvWRWY3/DwBfnKgoJw5D9SnP5oYwyimzuGuHhm1
	 hEQ2gcAK2/+hy3rUnoM3FvLuGrvTiaMJiiQ/w0zzqKX+fypbc3F/aIHZQcINSPFtep1My
	 x94je4F/Epw4RcfFtJFF1edOS7ZvHO8md5nS/2b69XlDk1MPFBH5tyKoO8wnFUbYPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527005;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
	b=x95F8MzxHxaTBFNNICF0ucDPQ7t7oLSZ4UcO03KhOpEFfaa1lmNKkR96KyesMM58poIG
	 /91uQa0nrDQ0SXLgVxMotz4GScYolGhC96ZRvBGKY80cEO0fjNWffo3cD74/8qqyMCOvm
	 iHDYGwufC19+AL2dR8z3JIVAzQkC3B4whH7xOL/84uQuDlr/Z7INsLU/oTX1zsoqPZ4KH
	 bZ5umECZdjNsEPeRu/kYDfmsc5bItMo2DsLwEVl06EHGr8CZ+fOyG1G+23NNg95J80E5K
	 CO9RkpBOoHHVKXURy03jqvU5J+aTTCUe2dICM8KLcBzpuYyeDQ6EbFQrCQ4SI9+pt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUHlkudy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rX3KPOmi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D3606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 039D3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUHlkudy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rX3KPOmi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
	b=ZUHlkudyzyiKHSdwgfsL6/mRONAwiENVBzCn+FGVD3R9qttD0VjQHOFx/6YbD8389lIql2
	YZELH+QRTyCHSl1mKOUyGKWZsIT0QisHamVXQqi0NO8fZ4X9wIi+N0FxqTSX4J7qr8pxI6
	T3hbObXaB7bwwqZ3JgCtZzJBgvegaco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Ehb8T33NOUqaFgB1WV2WHA-1; Tue, 20 Oct 2026 20:09:56 +0000
X-MC-Unique: Ehb8T33NOUqaFgB1WV2WHA-1
X-Mimecast-MFC-AGG-ID: Ehb8T33NOUqaFgB1WV2WHA_1792526995
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a17741243eso131595e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792526995; x=1793131795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
        b=rX3KPOmizCP4g97+YebllkCTaZVfiMWVjToFn5kmjY0LYqqWIcnYTGg1dgclLKG5Wx
         yGO4MxPuoAt6QYapo8UnnfuCqfsZzIfunHAz6MsnKNxlMRbLQ6ATZ/r2J+ArOuAsWHD5
         5tC/V+sNLk9w1AOxAiRL9E7/fut5O9rAvkSnwkVD5N/PR18YrF2Uqu+aB+ALD6iskqiI
         gy9WoUYtxXf0pKKvh4k1+eXHF9RJll/IFWh+xg1QOfXrN2CxfPMydFdgWm9IDKTkZP5W
         HluZVAIiF3VCqAM7N2lawwNR8u4E7PiyDdmVyKz0ynGIK/TNfVzMDnIaOvFvoB6qT6aE
         IVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526995; x=1793131795;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
        b=DrVkE+/83+UOs4ILB9hmgI4sjW/yU4dDrK2ywGG/e45gzahsL5EgBCFQyP3OY/7DnL
         9fXZcwN4fxriQd3yFM8YpnZQ6fKC6fBeMlwCKujUNazpXYFVDHW574xyjPsZBjOb8Qrb
         MsYreERkk1RCbFRVN0JIuN//HJLYodPuQ1cqY1u2kIfZ5nO8PMl1k9uoeAQpChwk1Xf8
         pxkHA1qB92vor6ZG3OZ2gFKIQOSz7btsSkUeQ3CLrpCaeFcRgMvqUPhjO3hL2u++vHIk
         C5PjKBuH+6/0L6fGF4ZEgOr629QsjjtZf6qH9y3rIfqIrZTxZ3sTiFrrMHY8jnl5PxI2
         2Hdg==
X-Forwarded-Encrypted: i=1; AKwUvBy1xb0JViCpEFrsOj89mC/Y7yf7ZFP3ui9ej34Hsu1c3w1uc4dnbG2M6a6gMY87DyHk5Un7aa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdXcVY4vhletN061XP81gsPOjp30JUUlWbpzlqwq3fwM4f0dze
	tcLjcVMbwcP2IIBYmJguArCH3h3ZyefZLgdhLFrtU/JS5CwH/j/LBC7UFSRALM6uskxQShNYuug
	t1+JJqUwI7V9EDXTxkz2OoBH3pPFEFkkHCpFDgaPOOZYa4MR3vhzQ/CDN8g==
X-Gm-Gg: AYBFou3GXSlVZq2DMzAoqNZ4SC5KVr7qtDrrp16tdFyQ86K1J8aVzuYdcSfWh+r6tV0
	PAw1arEmPDgGhryrr3lybkYv+NufOBkaktaYnCuV3K7EbqrUd4LLFd5uJqVlYYQg9PIq9po41WB
	QFdXJQ85nV18RrCasDHt6f0BZrLIc9MV3/KscsFghN/LfaC+W73tE2MNeiifVkECQhwxcS+5spZ
	wz9TWGuuPaK0wPlonzQV8YYgoxRTtW6H5okH2TViDPNF7gOLjzHymGZcy5w41EKyghtm62khnB7
	75FlXzBh1kxeQwLFUtbcjtocI0CnAXHvkiLamAWQ00nMwbTViUDH/DcbxOejpq3YghGFVg==
X-Received: by 2002:a05:600c:3b1c:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a1d76046dbmr262528975e9.13.1792526995064;
        Tue, 20 Oct 2026 13:09:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1c:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a1d76046dbmr262528445e9.13.1792526994567;
        Tue, 20 Oct 2026 13:09:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc10de99sm10206805e9.1.2026.10.20.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:09:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:09:50 -0400
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
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3 1/8] net: account for ingress-resolved virtio net
 hdr state
Message-ID: <20261020160829-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.26f697d5a674b@gmail.com>
 <20261020153650-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.57aa9aa58b62@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.57aa9aa58b62@gmail.com>

On Tue, Oct 20, 2026 at 04:02:26PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:27:46PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > The following patch will add ingress resolution of uncommon virtio net
> > > > hdr checksum metadata (software checksum completion at ingress) which
> > > > adds performance overhead to the packet processing.
> > > > 
> > > > We should make it visible, so a hypothetical workload relying on
> > > > uncommon metadata can be distinguished from none at all. This way issues
> > > > in the parsing will be reported and not quietly pay the host-CPU
> > > > checksum overhead instead of offload.
> > > > 
> > > > Flip every call to virtio_net_hdr_to_skb to test for negative errno
> > > > only, and have tun count these events per device as rx_csum_sw, exposed
> > > > via ethtool -S.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  drivers/net/tap.c        |  4 ++--
> > > >  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
> > > >  drivers/net/virtio_net.c |  2 +-
> > > >  net/packet/af_packet.c   |  4 ++--
> > > >  4 files changed, 44 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > > index ff67d99deb39..73e883394446 100644
> > > > --- a/drivers/net/tap.c
> > > > +++ b/drivers/net/tap.c
> > > > @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> > > >  
> > > >  	if (vnet_hdr_len) {
> > > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > > > -		if (err) {
> > > > +		if (err < 0) {
> > > >  			rcu_read_unlock();
> > > >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> > > >  			goto err_kfree;
> > > > @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> > > >  
> > > >  	if (vnet_hdr_len) {
> > > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > > > -		if (err) {
> > > > +		if (err < 0) {
> > > >  			rcu_read_unlock();
> > > >  			goto err_kfree;
> > > >  		}
> > > 
> > > similar to tun, should tap count this event?
> > > 
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index 242899f7fd07..19cb443c89b0 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -210,6 +210,7 @@ struct tun_struct {
> > > >  	u32 flow_count;
> > > >  	u32 rx_batched;
> > > >  	atomic_long_t rx_frame_errors;
> > > > +	atomic64_t rx_csum_sw;
> > > 
> > > is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?
> > 
> > well it can overflow easily. i don't know that we care that a slow
> > path will be even a bit slower on these ancient platforms. correct
> > reporting seems more important.
> 
> Ok. I would hope that monitoring catches this before it hits 4B, but
> agreed that as slow path it doesn't matter.
> 
> > 
> > > >  	struct bpf_prog __rcu *xdp_prog;
> > > >  	struct tun_prog __rcu *steering_prog;
> > > >  	struct tun_prog __rcu *filter_prog;
> > > > @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > > >  		break;
> > > >  	}
> > > >  
> > > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > > > +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> > > > +	if (err < 0) {
> > > >  		atomic_long_inc(&tun->rx_frame_errors);
> > > >  		err = -EINVAL;
> > > >  		goto free_skb;
> > > >  	}
> > > > +	if (err > 0) {
> > > 
> > > } else if (err > 0) {
> > > 
> > > > +		atomic64_inc(&tun->rx_csum_sw);
> > > > +		err = 0;
> > > > +	}
> > > >  
> > > >  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> > > >  		skb->protocol = eth_type_trans(skb, tun->dev);
> > > > @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
> > > >  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> > > >  	skb->dev = tun->dev;
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> > > > +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> > > > +	if (ret < 0) {
> > > >  		atomic_long_inc(&tun->rx_frame_errors);
> > > >  		kfree_skb(skb);
> > > >  		ret = -EINVAL;
> > > >  		goto out;
> > > >  	}
> > > > +	if (ret > 0)
> > > 
> > > same
> > > 
> > > > +		atomic64_inc(&tun->rx_csum_sw);
> > > 
> > > maybe reset ret = 0 in all these branches
> > > 
> > > >  
> > > >  	skb->protocol = eth_type_trans(skb, tun->dev);
> > > >  	skb_reset_network_header(skb);
> > > > @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
> > > >  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
> > > >  }
> > > >  
> > > > +#define TUN_STATS_LEN	1
> > > > +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> > > > +	"rx_csum_sw",
> > > > +};
> > > > +
> > > > +static int tun_get_sset_count(struct net_device *dev, int sset)
> > > > +{
> > > > +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> > > > +}
> > > > +
> > > > +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > > > +{
> > > > +	if (stringset == ETH_SS_STATS)
> > > > +		memcpy(data, tun_ethtool_strings,
> > > > +		       sizeof(tun_ethtool_strings));
> > > > +}
> > > > +
> > > > +static void tun_get_ethtool_stats(struct net_device *dev,
> > > > +				  struct ethtool_stats *stats, u64 *data)
> > > > +{
> > > > +	struct tun_struct *tun = netdev_priv(dev);
> > > > +
> > > > +	data[0] = atomic64_read(&tun->rx_csum_sw);
> > > > +}
> > > > +
> > > >  static const struct ethtool_ops tun_ethtool_ops = {
> > > > +	.get_sset_count		= tun_get_sset_count,
> > > > +	.get_strings		= tun_get_strings,
> > > > +	.get_ethtool_stats	= tun_get_ethtool_stats,
> > > >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
> > > >  	.get_drvinfo	= tun_get_drvinfo,
> > > >  	.get_msglevel	= tun_get_msglevel,
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index daab43ac92ce..2e6fd81df9c4 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > >  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> > > >  				      vi->rx_tnl_csum,
> > > > -				      virtio_is_little_endian(vi->vdev))) {
> > > > +				      virtio_is_little_endian(vi->vdev)) < 0) {
> > > >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> > > >  				     dev->name, hdr->hdr.gso_type,
> > > >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> > > 
> > > should virtio_net count these too? Or do we assume that devices are
> > > more trustworthy, so unlikely to cause this issue?
> > 
> > With memory encryption, from an untrusted host?
> > i can add that.
> 
> I honestly don't know if it's worth the effort. Just curious whether
> you had purposely skipped this and tap.

more like it slipped my mind.

> > 
> > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > index 52ae3d875e97..e6aec9ecfa99 100644
> > > > --- a/net/packet/af_packet.c
> > > > +++ b/net/packet/af_packet.c
> > > > @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
> > > >  		}
> > > >  
> > > >  		if (has_vnet_hdr) {
> > > > -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> > > > +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> > > >  				tp_len = -EINVAL;
> > > >  				goto tpacket_error;
> > > >  			}
> > > > @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> > > >  
> > > >  	if (vnet_hdr_sz) {
> > > >  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> > > > -		if (err)
> > > > +		if (err < 0)
> > > >  			goto out_free;
> > > >  		len += vnet_hdr_sz;
> > > >  	}
> > > > -- 
> > > > MST
> > > > 
> > > 
> > 
> 

