Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758792;
	b=u7I1obW6PcMhppZt4YPsUEhJLJe+gZK1VAYfIQHs0q+NXIdhQ1WQU5bn3ollavFn4pOL
	 U15vM6lri60mjryH2ep6swUhd5TMEi7i9lQmD3vY2akm8thhalIXwvma0y+/zktG1HB/H
	 NDGgOpPfwg1iEla/89X9O2g5fkKIhkYDFcnnoG3CfdlSHRlkAo55rAk2WJhUGiMMuXCTm
	 DziJsES7bXzv7gfrqM+GNIKT/8vcdj/NAwgGykw8C9KnvbUMgnELQfzLUH5xqclOu3/xR
	 FRnKPJhAmkS+GpGIjydgE3bzMqsBLmQfzHmmAXooy1syiRAjmO5H8nhUBIoF3o/IgUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wDPnb5kC0rdGQBK898MutD9eBOrINRLYSXUnCJrhCVk=;
	b=v6PNrhTSEUPrRJ5j+ksyTX3Uone4R71PlW9SIQ+lGNSXalmEBLZS3MAZFJPWDv7JrH60
	 Nkh3ABEI8SMnPE776z2DsXNhA7siU0lHeLzuZbq16L9nxCvbLrb6fjRS1F5bRTREiwJEq
	 uq71UXCr8hJ6UHsb183yjhFGXK8oodYXY426GW0MfjCCwlcNSS0q0OvgvWd04gARtX8AO
	 TmFWeyuRaSCouIz77AcxN1GwkKyFuV4BGWxNt/nzmntqVHvTLHG2SnH777uHFfiTiAnPJ
	 XFQbJB1aLGE6CP/KMmw2JB15q1peNjjNjQDqhWxk0IdA3F9rrlBSIh9nPYv7jUtzb2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+WfxM2u;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A789606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A789606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+WfxM2u
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so36065137.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758791; x=1794363591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wDPnb5kC0rdGQBK898MutD9eBOrINRLYSXUnCJrhCVk=;
        b=E+WfxM2u2lBe831maX61GhythuBF5n38YuFj6YxJqCo+vx378tt6yW59/wCFfnikIt
         melnDJpeFKulAChSuB7QYS8fJFtm3GlfajCu9/S/fXIf+LJ04a8Qd0dl+3dYyZpU3HGz
         +oMHxScwGWiYr/XtjXI/4cG3x/KCHpM58GmvO7NfokEMBrBhsbaOT+qghvAlcmyvVErg
         aPi2so+R8E7Qhxvv7V4eJGSBAtVHOD2lZrHXUvsJFhW0ZzkHh8v/7LHJZieBuKJaz8sv
         ogDd7nMSo1ULJczuHokJkz9mdTbd5NWuzmyT1sKvpEYJis8qno1Ik/PHzgYU+wsWtaiM
         A0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758791; x=1794363591;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDPnb5kC0rdGQBK898MutD9eBOrINRLYSXUnCJrhCVk=;
        b=bVCSXfq9t1yhKWDlDbMryI5x5gPe+V4bu7KChtjHmPLWcBXY47Ba0NEs41vBe2hbuM
         1jBflSOaJYz1XaZQLxxMPU4W80NRZoSeB64P9vnDNX1LzhX+R7L+sKh71fHIzG+50L2g
         xlOvhA4rmf3XQXUZFnwOmZURgbkbfCuMPh41P98ATJz0eWaeCZ1kaGd66480BrB4D4Ek
         ZMjSL8jCBS2aDmQTEw2lVOXvt7sx+3sxYX6MWPibGWyDah8YQquSBNc0MwjeLq8dtZgX
         MEyncbUPsRQ28sJXM70XM/is105Rw5U8KKXZdPbv3hhWTNpZpYk/J+9I07H0zBc49vVN
         iSlg==
X-Forwarded-Encrypted: i=1; AKwUvBzVEjPrmjD3iiuvnpCt5F6GAozPDMKuXycV/ZbulM2ltcL6wATRkspynosNN2OlfSfbrEvP20k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nbW8XYq688MVVWC0Z3bkL3Q2d2LYnIlw0VWcdMAyvt9kBXgRN
	mlXh1mY0/1Nh5cQ1WOT8FQvg2VmlMvqJ+U636H9gqGgNKfgLIxCKliOt
X-Gm-Gg: AYBFou1OI+0DiM7hRKb7xFWJtHk3w5XGLMafxAY7ce4e50IvMLrYUPtUZT4/X580duS
	h4jvpAaHJwzN1jP/sIukUp8BPZMMwR67dYRee5yVCn1ONuCpNXEqYF3NQiSiv3QHfJgvK2FYbHW
	TuCz9IimcVJGBZtTU3TYnitO/ReMwpNi6iMs5aI2A771fZKEkE6Y9HMhotOZ21EqpR9rlYKctJo
	J5gD1nSmXkm5Md18x7kaax5TFl3xu13ugWzQC9pkLLeRfENcJ3P0DyPBad9ZDuZO7EBJU3pFTaX
	FOHog1QAb5t3iNFv4M3JmCGTXeZpO1WLFdt3yj0dgQASJVsgM1uwtr5VKYMcHgTKjLgfCm4xkEu
	qy+g16ssDuQ4POlFTxozGJktQFYUTF6qmCcxrL1CtZ+PQRbKl+Zzp2g/nj80GbUPwrxx3bUDLZF
	7sTeLdkaejqgkoulP1gGrb+XUvqSxD+eR/y/RbsfmgOc9+Grks3pgDAbFAKh1BKjuXth5chD/DZ
	5OLtvLPPecC8aY4xUJw/G1oTjRrEuvf8BKTG1PjDBVj3oRmaoz0z0/r0llZ+0sBjNb04H6jp7pc
	eOkcMzFIFhGGZXbFOjYR8wOaOEboRqPXXsU2AzhzOC/0tyXqZ8ylnymlxb/wT30mWzfNbPcZZIb
	B9l2IIV/taFMTwYc3OVuIGhAcarRJ8HVKJGR+R/idRkz7MnT4Adgf9js/6H4enDVAVnyYU1c=
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7d072c56c97mr5453392137.21.1793758790891;
        Tue, 03 Nov 2026 18:19:50 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm658096137.11.2026.11.03.18.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:19:50 -0800 (PST)
Date: Tue, 03 Nov 2026 21:19:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2bcc7ca0e8623@gmail.com>
In-Reply-To: <20261103203113.550604-4-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-4-edumazet@kernel.org>
Subject: Re: [PATCH net 3/3] selftests: net: tun: test outer protocol of UDP
 tunnel GSO packets
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

Eric Dumazet wrote:
> Add a tun_vnet_udptnl_proto fixture writing single 4in4 Geneve GSO
> frames to a tap device with UDP tunnel offloads enabled:
> 
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
>   tag) is rejected with EINVAL.
> 
> Without the previous virtio_net patch, outer_proto_bad fails because
> the kernel accepts the frames.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  tools/testing/selftests/net/tun.c | 130 ++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32e..47a24b9c477b 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -683,6 +683,136 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
>  	ASSERT_EQ(ret, len);
>  }
>  
> +#ifndef ETH_P_NSH
> +#define ETH_P_NSH 0x894F
> +#endif
> +
> +FIXTURE(tun_vnet_udptnl_proto)
> +{
> +	char ifname[IFNAMSIZ];
> +	uint8_t *pkt;
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(tun_vnet_udptnl_proto)
> +{
> +	int flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> +	int features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
> +		       TUN_F_UDP_TUNNEL_GSO_CSUM | TUN_F_USO4 | TUN_F_USO6;
> +
> +	self->fd = -1;
> +	if (unshare(CLONE_NEWNET))
> +		SKIP(return, "Cannot create network namespace: %s",
> +		     strerror(errno));
> +
> +	self->pkt = calloc(1, MAX_VNET_TUNNEL_PACKET_SZ);
> +	ASSERT_NE(self->pkt, NULL);
> +
> +	memset(self->ifname, 0, sizeof(self->ifname));
> +	self->fd = tun_open(self->ifname, flags, TUN_VNET_TNL_SIZE, features,
> +			    param_hwaddr_outer_src);
> +	ASSERT_GE(self->fd, 0);
> +}
> +
> +FIXTURE_TEARDOWN(tun_vnet_udptnl_proto)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +	free(self->pkt);
> +}
> +
> +/* Build a 4in4 Geneve GSO frame whose outer ethertype is @l3proto,
> + * optionally behind an 802.1Q tag.
> + */
> +static int build_udptnl_frame(uint8_t *buf, bool vlan, uint16_t l3proto,
> +			      int payload_len)
> +{
> +	struct virtio_net_hdr_v1_hash_tunnel *vh = (void *)buf;
> +	int vlan_len = vlan ? 4 : 0;
> +	int hlen = ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
> +	uint8_t *outer_udph, *cur = buf;
> +	int pktlen;
> +

zero buffer. It is zeroed by calloc, but reused for multiple packets.

> +	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
> +						   AF_INET, AF_INET);
> +	vh->outer_th_offset += vlan_len;
> +	vh->inner_nh_offset += vlan_len;
> +	vh->hash_hdr.hdr.csum_start += vlan_len;
> +
> +	if (vlan) {
> +		uint16_t vlan_tag[2] = { htons(100), htons(l3proto) };
> +
> +		cur += build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_dst,
> +				 param_hwaddr_outer_src);
> +		memcpy(cur, vlan_tag, sizeof(vlan_tag));
> +		cur += sizeof(vlan_tag);
> +	} else {
> +		cur += build_eth(cur, l3proto, param_hwaddr_outer_dst,
> +				 param_hwaddr_outer_src);
> +	}
> +
> +	pktlen = UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
> +		 payload_len;
> +	cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen,
> +				 &param_ipaddr4_outer_dst,
> +				 &param_ipaddr4_outer_src);
> +
> +	outer_udph = cur;
> +	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT,
> +				pktlen - sizeof(struct udphdr));
> +	cur += build_geneve_header(cur, VN_ID);
> +	cur += build_eth(cur, ETH_P_IP, param_hwaddr_inner_dst,
> +			 param_hwaddr_inner_src);
> +	cur += build_ipv4_header(cur, IPPROTO_UDP,
> +				 sizeof(struct udphdr) + payload_len,
> +				 &param_ipaddr4_inner_dst,
> +				 &param_ipaddr4_inner_src);
> +	cur += build_udp_packet(cur, UDP_DST_PORT, UDP_SRC_PORT, payload_len,
> +				AF_INET, false);
> +	build_udp_packet_csum(outer_udph, AF_INET, false);
> +
> +	return cur - buf;
> +}
> +
> +TEST_F(tun_vnet_udptnl_proto, outer_proto_ok)
> +{
> +	uint8_t *pkt = self->pkt;
> +	int len, ret;
> +
> +	len = build_udptnl_frame(pkt, false, ETH_P_IP, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +
> +	/* The outer IPv4 header can follow a VLAN tag. */
> +	len = build_udptnl_frame(pkt, true, ETH_P_IP, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +}
> +
> +TEST_F(tun_vnet_udptnl_proto, outer_proto_bad)
> +{
> +	uint8_t *pkt = self->pkt;
> +	int len, ret;
> +
> +	/* Outer ethertype does not match the declared IPv4 tunnel. */
> +	len = build_udptnl_frame(pkt, false, ETH_P_IPV6, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Outer header is not IP at all. */
> +	len = build_udptnl_frame(pkt, false, ETH_P_NSH, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Same, behind a VLAN tag. */
> +	len = build_udptnl_frame(pkt, true, ETH_P_NSH, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];
> -- 
> 2.53.0
> 


