Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524469;
	b=fRIs670eyF4BDTREb2F3NLFTX3zZIBPWEkjO7KVDiEPDU4wszt/UpFMFsIC0EY5VROCa
	 /Z858Hr9WbWhQmFLNSUbZCLJwRGNWZg9sG3VSHcUdxayremupRoD1g5fN9Yi3UAGR8bqX
	 LtfMZq7lmId9DfoR7HPBRkZrQzS2b86Fttpj1D0jAVnwiVCVsbz6an9pH85SuaUr/neTU
	 kD5KuZPKM8HrzBqPo0Ff0kutCAQTkxY5xxfT6EwcFishonM5xFlanawdTXNzNC1RRzOUI
	 uQk3EvNKX9c3Obt89GcqcRKMjBlPI7xxBtLfmILmRU/SmbJ8Niq0eNKUHjK1DiEXqPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8d0QJtk8ZEIWYlaqlfK6d7NfnOjbhnoYPvBNLRwXsqc=;
	b=E4bw9XtNXCbSewOc/kcmOOXatSF3Xec7rNzjx4f1dCA8ztztrchVg3ASwQFHL3NfQkxw
	 4axt5bBE8o+N17VuZYGiKIYF2+TkY3eawsl2HrCBpvfKXUKWXfl9HkhUjp+9Sfibv0jVA
	 chZD1dRzMyL+bMCoavf0b+XgdQFVYi+E5Te2bCTKI6wVN+b41h1CRb7411CpdQlIP/jwQ
	 qIvZcFTp+Dv8gRv86oDNH5bbcKXj4xQRM5nnLQUu0O8LP5/4jnGJdp+Rc0o3LMTEefuQl
	 TiD10aoYpH9gqzzAez6QC9pFq8bJhCKTS6KJEVNZJk6TBE75dbMduR5kLy7e0pvgL3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIVrRw9T;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D9606A32D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB5D9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIVrRw9T
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-77bf892b496so15800137.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792524468; x=1793129268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8d0QJtk8ZEIWYlaqlfK6d7NfnOjbhnoYPvBNLRwXsqc=;
        b=gIVrRw9TcMP0S+1ejN8MreF8RQAr++Pg+F+5F+qsRHMkg5RSBnobQ6iIeZAE/YT1jc
         jIGq7IdMS3WMs7PHbgS7ZVN5wmB3vfcZZIBm2M6JOLDZbw/EnHN2qnlmvASGKYytvARf
         K1g5p448TopoZTXVkKl3qTzbVOVdLgBg4uD9AxoCSwC76aD+rDFg8BrtW0kcq5gvSnDk
         3kcBY24YuhCdQeyej9hd+v0jnz569J4qucRnydfWXpvCAb1CFjqwKZMS5GlTQn82Xul4
         Ajq7BbzkWQoG+pBbciC4xNzq7CoHW+b1QtmNgGqd3WBcUtf3P7Y8YmcftYUSzi/Xz/6W
         4L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524468; x=1793129268;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8d0QJtk8ZEIWYlaqlfK6d7NfnOjbhnoYPvBNLRwXsqc=;
        b=1/q4dUZmpNzRmAoKeHZKhLY7A5gR/4k2NDqqzLRIXd6J+FCy7Wg77lfF4U2NldqdRQ
         6su4eC94t3hblm8km/BAmVMQ5RGGNEO9AQpOQkZVkf5YSBFjoKAkGmzQqBnATdZ/cWrh
         etgHl6vZAK4vAjSXkbMzinjnWKBtkMYWgeEHm5325DL52VlOMxYScTQgRWw327x4ouwF
         WlyEMcbuYVK8CErYuTZ8N7akPtgT+WpiA3AvHbGFCdO0mUFwJdvYLKQgsSDVLPReaBnP
         xl0nBnU46mUYmZ/Uxjxc9x1wwB8Q7FoWWZELI2ElJRI8jZ9vABttpUatIrMhA0kXVmiP
         2x6Q==
X-Forwarded-Encrypted: i=1; AKwUvByljxYCRMYy6YO55cRh5biKfvajam90+O1fxoj4VQKbunhxdbucRicym9bxEmhTWONPy0hAboI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe/hZv8Kc+6bbB1iE/BQqUcLnVDkQISO1YqJWJwyxpQ3TuwkOO
	eQOAy/2W1RdNnSimSJ08dfzw7U/sxAoY5F/616Mz8sLiNYs6PigNi6YX
X-Gm-Gg: AYBFou0khM7vjHkN0bowQrOA5kBXxzAUFMSXpKaDF6xicuvTyWxLq2N/I0YGWT2sflC
	eY3UcXOBwKeH53lQbXyfunkQTZabh/YVyLrXNyjfSQR9JpOPup9IOokpVpdUJIWTibWds46/ccW
	zJLnzeFyd/SKoiBSVGfnbHW/kpkANsIXyKn8Sw7Cebavs4uHJhc0TOLLzBD/3TP1sxQznMxfTCx
	VXscSD3pSwtjelve8FQ5WADRF5cvh3JoAleDm2AZ2PJgEvptdM6+XW9SGAdU6deiehG6zFJKOv/
	r4M7IYhnySkS3h1kiGpCgGSmsQIEnJsFPCGpsVEDFX+dOv5Xg4G2ZyoC+b3oZKoXkIr1endzKAs
	0DoqVllVr2aA56Uxt/i9DzAyl1YfY+5l5ke35tycS/smzSlrv5jaLUuhPG3W87NH4wR3kbK+Edz
	MRV1ZqqFAnoLpyV08FCm5/mPAGNZAqnyFBf0oc693Q6qeol+wXdCa6TX1iSu7E5RjRHstvV+rJi
	4bhqIqWAUMGfwnMjXmU67lH4MJy6bIEP481LWbVBy5cJCkJLBio7rdJNeAnNhcb85R+BqXUk4Ab
	vuQKfgoTC0AzVBqc2/tEe1qCNdlPhiRouZtilw==
X-Received: by 2002:a05:6102:688b:b0:7cc:892:f746 with SMTP id ada2fe7eead31-7cc9246601cmr60179137.1.1792524467589;
        Tue, 20 Oct 2026 12:27:47 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d10439absm628407241.5.2026.10.20.12.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:27:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:27:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.26f697d5a674b@gmail.com>
In-Reply-To: <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
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
> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
> 
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
> 
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only, and have tun count these events per device as rx_csum_sw, exposed
> via ethtool -S.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/tap.c        |  4 ++--
>  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
>  drivers/net/virtio_net.c |  2 +-
>  net/packet/af_packet.c   |  4 ++--
>  4 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index ff67d99deb39..73e883394446 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  
>  	if (vnet_hdr_len) {
>  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> -		if (err) {
> +		if (err < 0) {
>  			rcu_read_unlock();
>  			drop_reason = SKB_DROP_REASON_DEV_HDR;
>  			goto err_kfree;
> @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  
>  	if (vnet_hdr_len) {
>  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> -		if (err) {
> +		if (err < 0) {
>  			rcu_read_unlock();
>  			goto err_kfree;
>  		}

similar to tun, should tap count this event?

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 242899f7fd07..19cb443c89b0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -210,6 +210,7 @@ struct tun_struct {
>  	u32 flow_count;
>  	u32 rx_batched;
>  	atomic_long_t rx_frame_errors;
> +	atomic64_t rx_csum_sw;

is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> +	if (err < 0) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
>  	}
> +	if (err > 0) {

} else if (err > 0) {

> +		atomic64_inc(&tun->rx_csum_sw);
> +		err = 0;
> +	}
>  
>  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
>  		skb->protocol = eth_type_trans(skb, tun->dev);
> @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
>  	skb->dev = tun->dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> +	if (ret < 0) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
>  		goto out;
>  	}
> +	if (ret > 0)

same

> +		atomic64_inc(&tun->rx_csum_sw);

maybe reset ret = 0 in all these branches

>  
>  	skb->protocol = eth_type_trans(skb, tun->dev);
>  	skb_reset_network_header(skb);
> @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
>  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
>  }
>  
> +#define TUN_STATS_LEN	1
> +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> +	"rx_csum_sw",
> +};
> +
> +static int tun_get_sset_count(struct net_device *dev, int sset)
> +{
> +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> +}
> +
> +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
> +	if (stringset == ETH_SS_STATS)
> +		memcpy(data, tun_ethtool_strings,
> +		       sizeof(tun_ethtool_strings));
> +}
> +
> +static void tun_get_ethtool_stats(struct net_device *dev,
> +				  struct ethtool_stats *stats, u64 *data)
> +{
> +	struct tun_struct *tun = netdev_priv(dev);
> +
> +	data[0] = atomic64_read(&tun->rx_csum_sw);
> +}
> +
>  static const struct ethtool_ops tun_ethtool_ops = {
> +	.get_sset_count		= tun_get_sset_count,
> +	.get_strings		= tun_get_strings,
> +	.get_ethtool_stats	= tun_get_ethtool_stats,
>  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
>  	.get_drvinfo	= tun_get_drvinfo,
>  	.get_msglevel	= tun_get_msglevel,
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce..2e6fd81df9c4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  	skb_set_network_header(skb, ETH_HLEN);
>  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
> -				      virtio_is_little_endian(vi->vdev))) {
> +				      virtio_is_little_endian(vi->vdev)) < 0) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
>  				     dev->name, hdr->hdr.gso_type,
>  				     hdr->hdr.gso_size, hdr->hdr.flags,

should virtio_net count these too? Or do we assume that devices are
more trustworthy, so unlikely to cause this issue?

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 52ae3d875e97..e6aec9ecfa99 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		}
>  
>  		if (has_vnet_hdr) {
> -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
>  				tp_len = -EINVAL;
>  				goto tpacket_error;
>  			}
> @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  
>  	if (vnet_hdr_sz) {
>  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> -		if (err)
> +		if (err < 0)
>  			goto out_free;
>  		len += vnet_hdr_sz;
>  	}
> -- 
> MST
> 


