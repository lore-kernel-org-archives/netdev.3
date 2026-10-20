Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525142;
	b=IKMBKeeYxcdhnlyrRhQjAePLyDn8AXoc6HP8+NvNklZEoW/xAyACoiW9rYO9cOdditjQ
	 EMd3fEaQYz9j8AI2LCByQyVlqOnVIsRTRY130JC6S12xlo4FRNy9PjhXRI6JCEZ+4CJhz
	 S8OZPdElbfx/5gFVBEsUCC0iq1HNwbKutU6e1mr3VwZbXOJwovknEohyYhWG6CP4F7jzO
	 dxrOGhUA3u+nUqElszpRN9sLGElIoi1q7uslRhuV6QTmpVgvVY9AgddAx5xcyS1M2VC7x
	 6Puc0PYFnifiatiCw3cFNMFksz9+d0KJrVJDb8XZO2zRu7KhGoVQkTd8xjaZaVnW43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525142;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
	b=Lqlz8as4vSglLgItW5vPDjvJPUVVGXdLHaqV/DouRjWcVlfLI0GVaHZXPByxwXdRxZLw
	 8/JuGQ+UCtyzmpz8zWzqpTCcNzgVWSI5QL79mN4RAjtQ2ARwl+nPsPRF82s0WmQ6+Kd2N
	 0tMjIWWfboe6i8K8BTslhJ9MDPq7DHLmkqFJ5bCp5DZ9bhab00n9gqP3b36EhBStU7W3G
	 Jf8SfEqX76j7BQTE1OVjyj2KZsu5Gu6Q7AR7hZARDdpRqBmrDwXpY+wpIav0406d3hYiy
	 f0ozb7EL182g61c0Ov60u5ukqNPQiMhtELuR+RmH063WUtXUjdD1vpJvqasmWW4d0wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V8NgYpPL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="YwG4gyY/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9D606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V8NgYpPL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YwG4gyY/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792525141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
	b=V8NgYpPLdhhsbQtO3iYneWd57AAW7beqOgrKW+gPAQNG3HrDa/JVB+NNfb5unOqMN+7awR
	SlwBVr1oXJDluOv6PsdY9fq1lwzN/twzBGULnIKczNgvoo/ZBpZlVac5/3Vgv7iTTUaEGe
	W2TdElz7Cs1j4fEkkhva2jTrCc5SD+s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-AhTvT1bSMVmPlXvfpIaTEQ-1; Tue, 20 Oct 2026 15:38:59 -0400
X-MC-Unique: AhTvT1bSMVmPlXvfpIaTEQ-1
X-Mimecast-MFC-AGG-ID: AhTvT1bSMVmPlXvfpIaTEQ_1792525138
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dff112136so2627744f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792525138; x=1793129938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
        b=YwG4gyY/ENGGcCpJomkCZlMTnbLuumIdx/YPQEbXTc6mcrNQIGVoYqhUPsb2ciyYi6
         dWF2+TOjfKrDOnMQrSld4XieEBCV9y4sGWE23WnyZN4rWdVJcCjUtqQ8Gv+v/4U9upww
         B/9ahfxfMjpN4QW9vybfDsi28gOPkbNLD51RFgskjTuzajsO2WE+NgyOzXE6BzOd/lPY
         zYKWRcOP0DqtbiXEmzt+b8fLjKgJRU4x60osFysMs1sw9xQOylAvV4LprEyFWA+AKIii
         nO18HsQ++KofGc7S4bJwE/86uHMrshLR0LEZlKwFrKDyALFud/RsaWebstj4sPSvP+6N
         MTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792525138; x=1793129938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
        b=VmfF8F0sydCmkHqbTr2VQlZJcAgEdLLg/19dZ43uM1G6drIUk99CWwd48Ew7OI6Vix
         GHpSw2lVA+wMRrDNak1wvRCGd9Uny9+qLbm9yaY3bkOnbbTLG5WLOQQ4cMsdo6KlSAJv
         oPjtGE89Tf3y6DToYZha1SxI48RR91LyIooUiQAxfRRFo18vQPR/gUpqQ/nPe6lXVITY
         tOsCvpnCHqmCBoqhM6pyQL50PC2PCL12E/fGcJ3afZ9zlJTNoepvWMHp4oYXJ3pLxN7D
         lylS1cGuypXxbRsARhIrUPrgVdD0Pi3u/Rycs+/YSWfM1/oErJdqwa/ZVWn1IOSThoBS
         /wTw==
X-Forwarded-Encrypted: i=1; AKwUvBx8iiQiv7FSwNjKFeFJmap26wnszrRFRneD4DbXywqIc7yFjsj7nmwslXywdcSUc4hsNflNdeg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7MoLLcOjFfa1IlBhjf09ffBwPpxN7jYp6IOqsRkgF0Dd71oVo
	QMls62VTMIqGYSHxO28G9mpszbYWbhnggCeRkt6xdcxcj9Vsx4NyWlrb5fWBLJ+UnOg39+lUTRW
	KH3UBn6OmphLc97jx/z5vQh/kepI0ifwXfz4hEhk1gBQVzPTK+8zHxZcjOA==
X-Gm-Gg: AYBFou2ztMk7pe1CIxV/i1uyRfVLjIUT2p04x+UiF2fvt1YRC/i/dbZgC/ZsZVJP/kM
	R3Z13uBil/Rn8C5xe7PGwW+MV8wAKPtcil16fDwW8TrLhLGi6zl4mtC5W6Ge/6jlAZHcYrD0BEt
	s2TdIOMudRCNCiR7yCRv742X1xuvaQmtnvk7/hoMZkxGIQvO9DKyLxbBBKtOJHTB7HuXUcxJVcb
	QD704FDKXrdqCCX/y7TLp4f7myXIOZ2eyTUzwbL/GfALLh7vDghmZsDu2nMgGAVmkgFEqbnMG8l
	x4ujeoLsRm1kcXbCxgU48Pda425tmi1RjAn6Pw8mpkXh9qZoUDXPzftbUuh5FIhDaD6kEw==
X-Received: by 2002:a05:6000:1b8f:b0:487:72f:fb41 with SMTP id ffacd0b85a97d-48e07fa0e82mr18492823f8f.39.1792525138239;
        Tue, 20 Oct 2026 12:38:58 -0700 (PDT)
X-Received: by 2002:a05:6000:1b8f:b0:487:72f:fb41 with SMTP id ffacd0b85a97d-48e07fa0e82mr18492786f8f.39.1792525137659;
        Tue, 20 Oct 2026 12:38:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm425597f8f.23.2026.10.20.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:38:56 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:38:53 -0400
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
Message-ID: <20261020153650-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.26f697d5a674b@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.26f697d5a674b@gmail.com>

On Tue, Oct 20, 2026 at 03:27:46PM -0400, Willem de Bruijn wrote:
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
> > only, and have tun count these events per device as rx_csum_sw, exposed
> > via ethtool -S.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/tap.c        |  4 ++--
> >  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/net/virtio_net.c |  2 +-
> >  net/packet/af_packet.c   |  4 ++--
> >  4 files changed, 44 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > index ff67d99deb39..73e883394446 100644
> > --- a/drivers/net/tap.c
> > +++ b/drivers/net/tap.c
> > @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >  
> >  	if (vnet_hdr_len) {
> >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > -		if (err) {
> > +		if (err < 0) {
> >  			rcu_read_unlock();
> >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> >  			goto err_kfree;
> > @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >  
> >  	if (vnet_hdr_len) {
> >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > -		if (err) {
> > +		if (err < 0) {
> >  			rcu_read_unlock();
> >  			goto err_kfree;
> >  		}
> 
> similar to tun, should tap count this event?
> 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 242899f7fd07..19cb443c89b0 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -210,6 +210,7 @@ struct tun_struct {
> >  	u32 flow_count;
> >  	u32 rx_batched;
> >  	atomic_long_t rx_frame_errors;
> > +	atomic64_t rx_csum_sw;
> 
> is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?

well it can overflow easily. i don't know that we care that a slow
path will be even a bit slower on these ancient platforms. correct
reporting seems more important.

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
> 
> } else if (err > 0) {
> 
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
> 
> same
> 
> > +		atomic64_inc(&tun->rx_csum_sw);
> 
> maybe reset ret = 0 in all these branches
> 
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
> > index daab43ac92ce..2e6fd81df9c4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> >  	skb_set_network_header(skb, ETH_HLEN);
> >  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> >  				      vi->rx_tnl_csum,
> > -				      virtio_is_little_endian(vi->vdev))) {
> > +				      virtio_is_little_endian(vi->vdev)) < 0) {
> >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> >  				     dev->name, hdr->hdr.gso_type,
> >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> 
> should virtio_net count these too? Or do we assume that devices are
> more trustworthy, so unlikely to cause this issue?

With memory encryption, from an untrusted host?
i can add that.

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

