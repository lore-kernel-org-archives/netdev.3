Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F533DEE9
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897839; cv=none; b=GMqgz9hEUOuviq/Qg7BEKrypY+Q/6IY5Y3JNXwT3uwDvaQAxvWOh0v2f53U2EhN7AB8VXypNY/ETJiX9/tJiXSj5fTP0JraFoQdj101iEpzQh/pOicexALznLwaTEGpf30uohOYXnWt7QZyTIPgOVxkbj7mmP2DfGNhXJ2Km46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897839; c=relaxed/simple;
	bh=mMJKmHhsdNBsXsA781hOliJbJz9k+ZVxaXfsbt5gogY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KgwH7ii1AzAiuOoVpVHvGxO0ncCIrh3jK0VY4ERP7265n2Jy9ZglnbSsL9lZNa0aLaqXS/rJvp6AAPXXSikbQpE6fCaNJgfcsthVj1YUlssBOKNI5uMpTpdkne+bsWLPrQgshN0eXwJztSIB8sIYujUkNnNQQsvsHU/P1Xv0dbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPEOSuNi; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPEOSuNi"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505832so66534837b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790897836; x=1791502636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EsUfczXOAqFC1GSojrpd6/FsnRGCEjTq53hjY2sgaYI=;
        b=pPEOSuNiK26Yyp5RFsZhNeNqChUI+TU0nI+6d4iqrKRspBsY1Q5rzm6t4aDa58a08f
         mxrBr/UmnhsG21ajObJWtfwXwkPJXA1KlDpuuSx3Pm/75eF7X4a8gGM9AWMEdqAicOLr
         QhyuzwLrQ0oF4OwaloW2qMSpvaO+mEc1EgkyphGCdih/L+9X7aYJEj0tPoO0QTUGEsu9
         6nZesjEpqh6PVIDKm/WEOt6cUmegbgt1LE3uFxEPY79s7YfIRO+/TcTjfE2QxWCr5IRM
         AKWItnYJObwbO1mlgsz7SBR3vHjv56TM/TzNU3G2jbYBgOAv4iR5JoHHAcA1hDxvfjXk
         nSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897836; x=1791502636;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsUfczXOAqFC1GSojrpd6/FsnRGCEjTq53hjY2sgaYI=;
        b=CNilfVARhv0JGHFx5XPjo0jV3c47fTsgKhRIjr4eZ3o61Z39nPJvoD8OfYM9WgjL1T
         MK2b6VXjOIYF5ClG4BCavWHkDa+TgH6gSBaF5/qOzj7WebAh0CKS/aWXQCfi2mfYqiKI
         UUFVdH9Kwd/r6WVf8wCMRaraLUPIhAb8hlHysWvoSzNCmnViotF+m/X5H/SFRSRo9/6h
         FLTSCdqZHaDfRqQrgzLQXN3Zh46hOOSNoKjBGzUqFs4A2554w0hwpSNdDnRaxVHP/dHH
         mCP45NlxltjGDDzAIjAxabcP3Hp90ZmkIM0HmQspzmKaH4R2Zt7bIolXEaWMqGaMiJD4
         Zp8w==
X-Forwarded-Encrypted: i=1; AKwUvBx06sDvQy4qt2Yi4c7Htk73/MOIDeX+T/vXqns5iEk2wX7dVpQNw3HRPYS3/w/ctk/cHWsROxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXmKBdCQFIizSkcWyvYW0Nj8b2IcWCL7S7eX4h+COyrNeJF4p5
	4eDSY3xIRZp1nYELGrZwZ/cOljY1melP+IcUNnC4GMJIgX+HMwGUoX6N
X-Gm-Gg: AYBFou37lHW7d/m4byilfQrXCSe7nZLbG8Xe5RYiANVesCREdGoeBwei6BI/PE1osom
	fHI3GNa2HMUH/zducljciwN3Y1Lw6AS11DrrLnsH2FLw8XSJLS3k60hp2+VQKQHpP+2fP9Yr1ZA
	jh9h/mLRwfwocPdSFdlKIeUvXPX73pwg4eic4atLPAtZF3+U5z0L91eYEqlUkrmHQ68pTIsH9Pg
	4kNL5pF50d/fcnqmgreGQgPIoAniCvW9Pck3seyrix4k+zbnnfdZ9Z8Po/fxhVKiL28uWyzmXEL
	Cazpp1cUeRLTIwPXNWjhenrIOUsNmKQlSC2gzSRzGrq2mA2JwQNF+BLuDn8ZB7JhO8nfQEwr36s
	TOhFjEWs724qYp6Kqm3HeznqyvtWJlQC1yvy+HQTaZxXHhSGzwT0D522n/UNbR92oMBOZ//tj9V
	A+OKu9R/KQF4dOczkV2tDksqpqjKLDEBSLzeGb93oj9vLyHGJTUlhfcjR5mDf/R974IfnhWkO9A
	OhcFQe4cVlSsth5bCGQ2hYXZi8af7EyO8jSgK+X4t5O/WbO+NjN
X-Received: by 2002:a05:690c:2782:b0:8a5:af04:fb1d with SMTP id 00721157ae682-8ae3b0d9321mr4241327b3.55.1790897836252;
        Thu, 01 Oct 2026 16:37:16 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae3011f406sm3121897b3.5.2026.10.01.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:37:15 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 Eric Dumazet <edumazet@kernel.org>
Message-ID: <willemdebruijn.kernel.e759da52def9@gmail.com>
In-Reply-To: <20261001191140.2818991-4-edumazet@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
 <20261001191140.2818991-4-edumazet@kernel.org>
Subject: Re: [PATCH v3 net 3/3] selftests: net: tun: add test for VLAN-tagged
 GSO without NEEDS_CSUM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Add selftests in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4 GSO
> packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags = 0 and
> flags = VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to a TAP
> device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).
> 
> Also verify that the following are rejected with -EINVAL:
> - a mismatched GSO type (VIRTIO_NET_HDR_GSO_TCPV6 on a VLAN-tagged IPv4
>   packet).
> - a frame whose TCP header is truncated after 10 bytes. Pulling only
>   sizeof(struct iphdr) + sizeof(struct tcphdr) bytes would accept it,
>   so this requires the transport offset found by flow dissection.
> 
> Finally, verify that a 65540-byte frame is accepted. Its skb->len is
> above U16_MAX while it is flow-dissected, before eth_type_trans() pulls
> the Ethernet header.
> 
> Based on a reproducer by Michael S. Tsirkin <mst@redhat.com>.
> 
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/tun.c | 136 ++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50bb3b05df5c446836c1c3dfa9ea604..afaa81c9bac5311944c9a70a20de05bffb683f26 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <linux/if_tun.h>
> +#include <netinet/tcp.h>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>  
> @@ -542,6 +543,141 @@ TEST_F(tun, reattach_close_delete)
>  	EXPECT_EQ(tun_delete(self->ifname), 0);
>  }
>  
> +FIXTURE(tun_vnet_gso)
> +{
> +	char ifname[IFNAMSIZ];
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(tun_vnet_gso)
> +{
> +	int flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> +
> +	memset(self->ifname, 0, sizeof(self->ifname));
> +	self->fd = tun_open(self->ifname, flags, 0, 0, NULL);
> +	ASSERT_GE(self->fd, 0);
> +}
> +
> +FIXTURE_TEARDOWN(tun_vnet_gso)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +}
> +
> +static int build_vlan_tcpv4_gso_packet(uint8_t *buf, int payload_len)
> +{
> +	uint16_t vlan_tag[2] = { htons(100), htons(ETH_P_IP) };
> +	uint8_t *cur = buf + sizeof(struct virtio_net_hdr);
> +	struct virtio_net_hdr vh = { 0 };
> +	struct tcphdr tcph = { 0 };
> +	uint32_t sum;
> +
> +	cur += build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_src,
> +			 param_hwaddr_outer_dst);
> +
> +	/* 802.1Q tag: VID=100, inner protocol=ETH_P_IP */
> +	memcpy(cur, vlan_tag, sizeof(vlan_tag));
> +	cur += sizeof(vlan_tag);
> +
> +	cur += build_ipv4_header(cur, IPPROTO_TCP,
> +				 sizeof(tcph) + payload_len,
> +				 &param_ipaddr4_outer_src,
> +				 &param_ipaddr4_outer_dst);
> +
> +	tcph.source = htons(12345);
> +	tcph.dest = htons(80);
> +	tcph.seq = htonl(1);
> +	tcph.doff = sizeof(tcph) / 4;
> +	tcph.ack = 1;
> +	tcph.window = htons(65535);
> +	memcpy(cur, &tcph, sizeof(tcph));
> +	memset(cur + sizeof(tcph), PKT_DATA, payload_len);
> +
> +	sum = add_csum((const uint8_t *)&param_ipaddr4_outer_src,
> +		       sizeof(param_ipaddr4_outer_src));
> +	sum += add_csum((const uint8_t *)&param_ipaddr4_outer_dst,
> +			sizeof(param_ipaddr4_outer_dst));
> +	sum += htons(IPPROTO_TCP) + htons(sizeof(tcph) + payload_len);
> +	sum += add_csum(cur, sizeof(tcph) + payload_len);
> +	tcph.check = finish_ip_csum(sum);
> +	memcpy(cur, &tcph, sizeof(tcph));
> +	cur += sizeof(tcph) + payload_len;
> +
> +	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> +	vh.gso_size = 1400;
> +	vh.hdr_len = (cur - buf) - sizeof(vh) - payload_len;
> +	memcpy(buf, &vh, sizeof(vh));
> +
> +	return cur - buf;
> +}
> +
> +TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)
> +{
> +	struct virtio_net_hdr vh;
> +	uint8_t pkt[4096] = { 0 };
> +	int len, ret;
> +
> +	len = build_vlan_tcpv4_gso_packet(pkt, 2800);
> +	memcpy(&vh, pkt, sizeof(vh));
> +
> +	/* Valid VLAN-tagged TCPv4 GSO with flags = 0 (no NEEDS_CSUM) */

iff respinning and not relevant for this fix, which targets the
!VIRTIO_NET_HDR_F_NEEDS_CSUM branch.

But would it be worthwhile to also run this test with
VIRTIO_NET_HDR_F_NEEDS_CSUM? Adds coverage of the other branch.

> +	vh.flags = 0;
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +
> +	/* Valid VLAN-tagged TCPv4 GSO with flags = DATA_VALID */
> +	vh.flags = VIRTIO_NET_HDR_F_DATA_VALID;
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +
> +	/* Mismatched GSO type (TCPV6 on VLAN-tagged IPv4 packet) */
> +	vh.flags = 0;
> +	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* TCP header truncated after 10 bytes, without NEEDS_CSUM.
> +	 * Requires the transport header offset found by flow dissection:
> +	 * pulling only sizeof(struct iphdr) + sizeof(struct tcphdr) bytes
> +	 * from the mac header would accept this frame.
> +	 */
> +	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> +	vh.hdr_len = ETH_HLEN + 4 + sizeof(struct iphdr) + 10;
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, sizeof(vh) + vh.hdr_len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
> +TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
> +{
> +	/* Ethernet frame of 65540 bytes: skb->len is above U16_MAX when the
> +	 * frame is flow-dissected, before eth_type_trans() pulls ETH_HLEN.
> +	 */
> +	const int payload_len = 65540 - ETH_HLEN - 4 -
> +				sizeof(struct iphdr) - sizeof(struct tcphdr);
> +	struct virtio_net_hdr vh;
> +	uint8_t *pkt;
> +	int len, ret;
> +
> +	pkt = calloc(1, sizeof(vh) + 65540);
> +	ASSERT_NE(pkt, NULL);
> +
> +	len = build_vlan_tcpv4_gso_packet(pkt, payload_len);
> +	ASSERT_EQ(len, sizeof(vh) + 65540);
> +	memcpy(&vh, pkt, sizeof(vh));
> +
> +	vh.flags = 0;
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, len);
> +	free(pkt);
> +	ASSERT_EQ(ret, len);
> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 


