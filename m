Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6253D9540
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623057; cv=none; b=Lmyt8S9Kqx5SmyqCKC7zJZHUCimNbyLk+mXeWgiGidA+a+EvlThEgOP4ft3hQTp2Wy2EgslyPvcFONCMfbLN11+/si5QPD2jNMpVhK3CxEL9QSRj6Pn6gNx3wdVCBQ+GtMUzDz4MChgDf1itT7DaSIH9TIUPowbdZiNh4KNCnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623057; c=relaxed/simple;
	bh=AjzfY91gtFLwaDB0IMIhJXNDOAtSCjGmwHPkOxCM+R0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=T73lHYEXBSmbGhcFTTyakwyVDTiKk9zzHCzyvk9x7ezWU8pAJK2axaM4gQ6YiLDvaQuLuOb50y541TbvOQt4kjUSH3QEIMhtxsh1MNDS620XJxkpaj3bz9qE/hWr3LGlcguMzsQms0IbCB/ESvDCDXMEv4XcDBB1eN863h3ltwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7hYDow6; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7hYDow6"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8496fd8c3so36514997b3.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623055; x=1791227855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aorafRBxnLCrUGwaOObDjUq+OOWzYocMWE8Vl3R8rNk=;
        b=j7hYDow6uf0/eqOts/L30v+nbdmlGcwASnsOt/blnuGMZWEUxS2zcP8wnB06LTdTRr
         GqeH+8ziHGMmTSuw+bdBdN68669M9GwoaSouiB8GGrF+aKWk5DWpOKrEj3vtddK0cETO
         TeCoHWyrePOCVmJUE6wZYfdZO/GWnNWb/uNtKrmo5Pz7VA64ZNNyvMO15mZMpKM24koL
         yA0QM8vVAF0xlV1q00dsi6Te0r6LOgqNituM97EW2bU6MwNZre8GoODiuK9MDutEwnc7
         AGdqf13cQiOYO99Yvgez5SN1QIdsuz/j3l4hL+CuCPq7e1pOAiYwh+SFa9lZBh5FKyRG
         54eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623055; x=1791227855;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aorafRBxnLCrUGwaOObDjUq+OOWzYocMWE8Vl3R8rNk=;
        b=KKrCciGHUkAWFs76dLDG/gJHUQS6Ls3rrbCrQ2lMPXwpH3HOpW544C4BM5FsgYCT8O
         5quDsAmYvel0anrCy9Nkr6ROzdqd6PCqXOxdOZNeQzt19URAw+9vs9gVMJPla9Azgj2A
         7JgeUkIdRa+LcT8oRphJXVseNZrw7Krs7pZhG4lbhshvdA2cGoRbbP4J3TP1D8Om8D1M
         P2sI5wGtkKxG2BbdnR2RoiHi+JB2gvs5g1ZzSKehoJxNod7C0elUN9clwsEZJ5QDBqTR
         Smf94+CxTsaG36tSjHvjIUZa4LDyPgIW8L9M+BadQ1AQfWpV1XQZl31noPnakXLxoN44
         sWvg==
X-Forwarded-Encrypted: i=1; AKwUvBz93gIYd6+5m5yvkWEZKc4OP2LU/yCQILPBTkJ0vqKFcdnH3rU0ocQ/L4cMukNzH2qLr7fFqko=@vger.kernel.org
X-Gm-Message-State: AFq9FYLysDHfvQKJbEGP16GrxEWE+qrwrz0xsqbkL+h2aP81uNiN/E8E
	JVrxvBAabeGvrvS9gApLDt7ssiI9oEygc8ZRrsrqsmqM3k9nLiRmi5ot
X-Gm-Gg: AYBFou1NMDXikMrISDAqE5U5B9xDgQc4YG8RQTzwKw6+OKwzgD4lpXa+oBz3pR+aykw
	Cdo1IZAOJ4LagJhWRUcH4d9zYH1VW0zjw1AZl3fuMlV/aGP4gKjs2rFmDim4Mkv7SclionXDYbf
	+rIxDcWClAAE0Wa9RwcY+Oa8ssvd0qZEk7+3I7bUuvR7zoMZJjRRTBHyPKYVhPNCQypHZT+nlXC
	FavovwH5UIi6Xt/cdU5Fidlu3gGXqRGSm0/d3QiSvm7pS1G4DSEkdKGp+oTI5d/cH3xg+alO7N4
	UbPwFxkukZ/3P/5tZki2yzmdJvJKoIX15ptD72Gyvaz9QSQfaMxBgg5FHe3+Mzbk+AsW8Sh5gwT
	amvPBITRTixdWNpgQnmVYiJp/h6SNvmCUaTYAhiFG+JtBqM4CcZ34AsOK5Zee2U5viNO99IO1Ps
	a7FKhtoCQr8xoiNPqbgUEy5gC1+PoOP07bqO/STHJsxSj2r7v0Zp1TwMB3OCb610FpPj6AojlcW
	1Qo4kJpHglRhHSIaSn3jUnpNoiFMkN5JtS65ohVup4epN5R5R0b
X-Received: by 2002:a05:690c:ec3:b0:89a:63bc:8be with SMTP id 00721157ae682-8a64e4c0cefmr57213937b3.72.1790623054847;
        Mon, 28 Sep 2026 12:17:34 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86103149dsm50140337b3.40.2026.09.28.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:17:34 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:17:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org
Message-ID: <willemdebruijn.kernel.293b4851be048@gmail.com>
In-Reply-To: <20260928144254.3361044-3-edumazet@kernel.org>
References: <20260928144254.3361044-1-edumazet@kernel.org>
 <20260928144254.3361044-3-edumazet@kernel.org>
Subject: Re: [PATCH v2 net 2/2] selftests: net: tun: add test for VLAN-tagged
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
> Add a selftest in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4 GSO
> packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags = 0 and
> flags = VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to a TAP
> device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).
> 
> Also verify that mismatched GSO types (e.g. VIRTIO_NET_HDR_GSO_TCPV6 on
> a VLAN-tagged IPv4 packet) and truncated headers without NEEDS_CSUM are
> rejected with -EINVAL.
> 
> Based on a reproducer by Michael S. Tsirkin <mst@redhat.com>.
> 
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  tools/testing/selftests/net/tun.c | 107 ++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50bb3b05df5c446836c1c3dfa9ea604..c6afafb7b957360e2873640e60a7d580c6564a66 100644
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
> @@ -542,6 +543,112 @@ TEST_F(tun, reattach_close_delete)
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

This is not a GSO packet if no vh.gso_type

> +	vh.flags = 0;
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +
> +	/* Valid VLAN-tagged TCPv4 GSO with flags = DATA_VALID */

Same

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
> +	/* Truncated TCP header without NEEDS_CSUM */
> +	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> +	vh.hdr_len = ETH_HLEN + 4 + sizeof(struct iphdr);
> +	memcpy(pkt, &vh, sizeof(vh));
> +	ret = write(self->fd, pkt, sizeof(vh) + vh.hdr_len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 


