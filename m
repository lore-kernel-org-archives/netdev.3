Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526549;
	b=Okx6r+OGvl+1Ld8ZbqJzPHo68VDZQ/DD7Ghtb3xfOFBgu15EIydxMOOcDELoRTxEQf3n
	 qHqBzDpezBRzcBCAuSFm42dTv99yCB+LE9JqcVXjgMVEkdUptGv7xHuCz17GEU/RwR12J
	 JCZ/HL6MLHGcSWyQWUXoqW6VIr10ejN6RJ9WX8YahPO9hlPcW9ZVXcTiT+hCt3+ooG9ea
	 WIzKNcwV7XpWIFwzjmqdaFYfC2vkRd1k1aFsWtoLagR/vqD9DuphPsrRu5kKL+nztmp4g
	 uanKB2Cr4GG7eQGYgS6GGgr0MLu2OtxN1+8J/JHNCRibmPrrlyWf79HZEpqelINAKxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8ZysMSfbg6fBNJbq7ExrYH4kJLqlOfTHrM/s3F+kdh8=;
	b=m9xNxtZAvRidt4wBX5ZjRrth3X0EskZGyYpPqX343eOUvfoCzsUcevSaX9AbJHc8Qzcq
	 JNLxw+2GO73g896+keVg8Ahb5AOxXu/ZuLiDFiT69QAmUOqPH9fTvx/Vs1QTf4pqwvlI7
	 YhUtnnmEK9kJNqKIhrY/chuHC3IRovhSMd0o9eErL3KFQadsOhj7ul5KCfAiDIW1Vpcna
	 UJmJtMTYJvqpsG3jDUc3xjhfe9Yt4vKeB7lL2FJ8SCRXZrVHe3VSJi88pChnqjeJs2uRJ
	 qojF9QcEkU10akqFg1hlrzaZ1V6ZjJE1hZSAMuyGqsyBZbtS+whMUhFiQvDPL5O2kSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hAm+sOt6;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284E606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2284E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hAm+sOt6
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9907a58f14dso9746241.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526548; x=1793131348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ZysMSfbg6fBNJbq7ExrYH4kJLqlOfTHrM/s3F+kdh8=;
        b=hAm+sOt6EH4D5vva7EW689YF9IYxKzNh8GBRAPeaZ+3G+Ik1z1FdOzMr6/PIaD6pPa
         stexztaNe0IQbsnqsC6kiklftJIVIvKi97lt7ZjTrSQ+/eHykVg9NVjEG8ZiMSrAuhEz
         zLZEA5qwYYXtyt63z98Y0GM7/fZ2R1vExKgHCZ7C9TE+NKsxmlDzmJMXsxC0eEm5REPg
         RBUXRkGExaXKA2VQnTcdAvVP6Gxp+7Fm30QiuCgQOoC+9DsFa6fYQ47QAgf6dNZ7ewrn
         suSbbPGDpaunXHKGkFfamklUyJy6QTeEuiHcdRwHN51ssl05Xd7ezZX5NtkXHhCBNhfY
         0XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526548; x=1793131348;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZysMSfbg6fBNJbq7ExrYH4kJLqlOfTHrM/s3F+kdh8=;
        b=CNFnwESaKWdaatkF7YOwtpreqhYHxK6GTfMM0BrPYgfHkiUcnFaAtH6Km7D7hz+NZ+
         jpE8U3ckt4L4rePRANay9apFsm0C+R11OvU0kNWnLGcLhqFiW4YbNrTeWYiJOFGSnK7E
         4feig9cCyLYuJV+AoS71sl5IBSYqkRnVQiy4jA2IXnm7u44MNR7AByg5AivwxGLUK68r
         UgS0dqGX9xNSfx2Br7nMah74rBaO9z6BB2+tnxsxSXtSv7M0n0UjurZPSwnY+xYX8uWw
         efjbuWVFXn5a0VjZ6FSFkitowywpNF4cbL1iDtMoy4l2P/x4MD6PSSGT/S5SiFVwwjZe
         HnVw==
X-Forwarded-Encrypted: i=1; AKwUvBxAHMj9hCYq3I6eeEvlckDmbowmN2w2QSS3LF9WTrHUOWSIpMpwke/yrKyE3k3+VoNnrQKhR1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIF/GiZdEX/kLMBXUVlnCj9LNPbL1/ji3eXKJ4PFHK9Ngf6x6F1
	kbenBYf3iCm18J0eMUrGyAn7U9azDjVw10m0luQ8LgcVRLLagU4PgBQE
X-Gm-Gg: AYBFou26C3JjpemOyfstd8Zng22C9lIpvg+2NY5iBPkaM+RN/ynaEFpWe/j/u3gnjPs
	cCpiswpwD3fnd6fiR2Q9IHndLbnmlRlqUmeJjpKaw1IzL6CFH/1/Wzg+tXaBF6k83tDE6dBSpjs
	tSqyF2CTKfAw9Yx8kTktGUIowUrLXNtqC1jPg1zOne6QiM+7yMv5OgJkHDoMkzQhvFi7PIJfz06
	JsasOlHDf8/n4+9UWylSi0nFkMUb/i0t2RwQJ+D9NNLf/aVDvwAH8NNERBg4bUEzjD0kpmiOCeQ
	FfIm7LTtAll+5n+ClYfW/7QQ8J/80GEJq6pAUBZknEZf4AmwmzcGx89N6RPgMBFC4WKv3xhk5BX
	BFc2vwEd6yT5bGq+Jbcc1iX8sJ6bE1vuafTRcqAy6Dm/EFSdUfu++tu/Z83Xqe3W0gVRePdzERj
	tQD4qnDJXdC3ByXj7HcL74xfuHjixDQAAHE/l+SB0BW/L6vxSvh/2hTvXEzBOFvjTf4l+LqwLoW
	oPNOf9GDtb+H/vJid6fHtc1nAk56qoEcV0/TmxmTwYk8oDOjOVmPZfgqXBq95zV81rSH3fG4xg7
	28ycTlt47gjifi5RJLK6jRshhjAdkzK7we65Ow==
X-Received: by 2002:a05:6102:38ca:b0:7b2:508e:3d57 with SMTP id ada2fe7eead31-7cc92469ef4mr87919137.4.1792526547926;
        Tue, 20 Oct 2026 13:02:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9236f63csm306154137.5.2026.10.20.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:02:26 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:02:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.57aa9aa58b62@gmail.com>
In-Reply-To: <20261020153650-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.26f697d5a674b@gmail.com>
 <20261020153650-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 1/8] net: account for ingress-resolved virtio net
 hdr state
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 03:27:46PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > The following patch will add ingress resolution of uncommon virtio net
> > > hdr checksum metadata (software checksum completion at ingress) which
> > > adds performance overhead to the packet processing.
> > > 
> > > We should make it visible, so a hypothetical workload relying on
> > > uncommon metadata can be distinguished from none at all. This way issues
> > > in the parsing will be reported and not quietly pay the host-CPU
> > > checksum overhead instead of offload.
> > > 
> > > Flip every call to virtio_net_hdr_to_skb to test for negative errno
> > > only, and have tun count these events per device as rx_csum_sw, exposed
> > > via ethtool -S.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/net/tap.c        |  4 ++--
> > >  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
> > >  drivers/net/virtio_net.c |  2 +-
> > >  net/packet/af_packet.c   |  4 ++--
> > >  4 files changed, 44 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > index ff67d99deb39..73e883394446 100644
> > > --- a/drivers/net/tap.c
> > > +++ b/drivers/net/tap.c
> > > @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> > >  
> > >  	if (vnet_hdr_len) {
> > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > > -		if (err) {
> > > +		if (err < 0) {
> > >  			rcu_read_unlock();
> > >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> > >  			goto err_kfree;
> > > @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> > >  
> > >  	if (vnet_hdr_len) {
> > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > > -		if (err) {
> > > +		if (err < 0) {
> > >  			rcu_read_unlock();
> > >  			goto err_kfree;
> > >  		}
> > 
> > similar to tun, should tap count this event?
> > 
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index 242899f7fd07..19cb443c89b0 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -210,6 +210,7 @@ struct tun_struct {
> > >  	u32 flow_count;
> > >  	u32 rx_batched;
> > >  	atomic_long_t rx_frame_errors;
> > > +	atomic64_t rx_csum_sw;
> > 
> > is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?
> 
> well it can overflow easily. i don't know that we care that a slow
> path will be even a bit slower on these ancient platforms. correct
> reporting seems more important.

Ok. I would hope that monitoring catches this before it hits 4B, but
agreed that as slow path it doesn't matter.

> 
> > >  	struct bpf_prog __rcu *xdp_prog;
> > >  	struct tun_prog __rcu *steering_prog;
> > >  	struct tun_prog __rcu *filter_prog;
> > > @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > >  		break;
> > >  	}
> > >  
> > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > > +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> > > +	if (err < 0) {
> > >  		atomic_long_inc(&tun->rx_frame_errors);
> > >  		err = -EINVAL;
> > >  		goto free_skb;
> > >  	}
> > > +	if (err > 0) {
> > 
> > } else if (err > 0) {
> > 
> > > +		atomic64_inc(&tun->rx_csum_sw);
> > > +		err = 0;
> > > +	}
> > >  
> > >  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> > >  		skb->protocol = eth_type_trans(skb, tun->dev);
> > > @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
> > >  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> > >  	skb->dev = tun->dev;
> > >  	skb_set_network_header(skb, ETH_HLEN);
> > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> > > +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> > > +	if (ret < 0) {
> > >  		atomic_long_inc(&tun->rx_frame_errors);
> > >  		kfree_skb(skb);
> > >  		ret = -EINVAL;
> > >  		goto out;
> > >  	}
> > > +	if (ret > 0)
> > 
> > same
> > 
> > > +		atomic64_inc(&tun->rx_csum_sw);
> > 
> > maybe reset ret = 0 in all these branches
> > 
> > >  
> > >  	skb->protocol = eth_type_trans(skb, tun->dev);
> > >  	skb_reset_network_header(skb);
> > > @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
> > >  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
> > >  }
> > >  
> > > +#define TUN_STATS_LEN	1
> > > +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> > > +	"rx_csum_sw",
> > > +};
> > > +
> > > +static int tun_get_sset_count(struct net_device *dev, int sset)
> > > +{
> > > +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> > > +}
> > > +
> > > +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > > +{
> > > +	if (stringset == ETH_SS_STATS)
> > > +		memcpy(data, tun_ethtool_strings,
> > > +		       sizeof(tun_ethtool_strings));
> > > +}
> > > +
> > > +static void tun_get_ethtool_stats(struct net_device *dev,
> > > +				  struct ethtool_stats *stats, u64 *data)
> > > +{
> > > +	struct tun_struct *tun = netdev_priv(dev);
> > > +
> > > +	data[0] = atomic64_read(&tun->rx_csum_sw);
> > > +}
> > > +
> > >  static const struct ethtool_ops tun_ethtool_ops = {
> > > +	.get_sset_count		= tun_get_sset_count,
> > > +	.get_strings		= tun_get_strings,
> > > +	.get_ethtool_stats	= tun_get_ethtool_stats,
> > >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
> > >  	.get_drvinfo	= tun_get_drvinfo,
> > >  	.get_msglevel	= tun_get_msglevel,
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index daab43ac92ce..2e6fd81df9c4 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> > >  	skb_set_network_header(skb, ETH_HLEN);
> > >  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> > >  				      vi->rx_tnl_csum,
> > > -				      virtio_is_little_endian(vi->vdev))) {
> > > +				      virtio_is_little_endian(vi->vdev)) < 0) {
> > >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> > >  				     dev->name, hdr->hdr.gso_type,
> > >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> > 
> > should virtio_net count these too? Or do we assume that devices are
> > more trustworthy, so unlikely to cause this issue?
> 
> With memory encryption, from an untrusted host?
> i can add that.

I honestly don't know if it's worth the effort. Just curious whether
you had purposely skipped this and tap.
> 
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index 52ae3d875e97..e6aec9ecfa99 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
> > >  		}
> > >  
> > >  		if (has_vnet_hdr) {
> > > -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> > > +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> > >  				tp_len = -EINVAL;
> > >  				goto tpacket_error;
> > >  			}
> > > @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> > >  
> > >  	if (vnet_hdr_sz) {
> > >  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> > > -		if (err)
> > > +		if (err < 0)
> > >  			goto out_free;
> > >  		len += vnet_hdr_sz;
> > >  	}
> > > -- 
> > > MST
> > > 
> > 
> 


