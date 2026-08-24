Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01423FF886;
	Mon, 24 Aug 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593125; cv=none; b=GbFeNDHkr3HR++9zNb/ikSHXBR7SEv63LS2Vz0nRnl8wN1Rx6AB/J8M0ErEI5BVpZD0aELDuMe5r9Y4RgXwhffa2r0R2dTjCTtnN3egA3rdxr/RPr9UptRS4HhnXbGa/ySk4EmerjM4/yuvsdtEIphWApIcFtliXC3Nxj1odiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593125; c=relaxed/simple;
	bh=2CK6p/WWkpSkFeN/5uCJoYOiBPJVEgn4LSqoPKEzOnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5B0gWIfKW+EUz5oAvEuK9M/R+4pFjZfjFdJY6Q5oMISOTDhJJ7PZBGiE8uKMLfbhhZOeKOUJ0LP32tqa/hUVmqa9fIPGqGsGam3MoFG0g8Nk6cP92q92vYyg9RzjxjPuK/060S88n7hcT1nlGKVjWe5FOm0MNxUn6LhlHAtmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ocVnnBLn; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ocVnnBLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xc
	dV0ryY6MWUqqG2NDQ5dBfZkd913zFZ6v481leHPe0=; b=ocVnnBLn7OsDMjoZSJ
	Uf7HE7O5yHd9jtUT1Lp0wRiwkifVL8nzW9DKUQDcjwUVVxwKNojfHZ0uk+20QZeD
	dqVE0ajSIGnX1tZdkY4zCVDZVnL0KstGLl2vsmpeAnmQJCqIx9cNbz6anjSG5Fqf
	oLAJdSbvqjZeq2hXPB7MtlZ7M=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3+5lrgYxqd1X2RA--.60967S2;
	Tue, 25 Aug 2026 01:37:50 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@gmail.com,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sunshx@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	zhangjn_dev@163.com
Subject: Re: [PATCH] net/packet: fix network header offset-VLAN raw packets on VLAN subinterfaces
Date: Tue, 25 Aug 2026 01:37:45 +0800
Message-ID: <20260824173745.16757-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.2d3e4407199d8@gmail.com>
References: <willemdebruijn.kernel.2d3e4407199d8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3+5lrgYxqd1X2RA--.60967S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr43CFW5Wr43KF18trykGrg_yoW5ZF4fpa
	1jkasayw4DJr4aqr40qa1IqF40vrs3G3W3uFyfJryjva15uFySyrWxKF4jgFyrKrWxWw1U
	Xr1DZayY9a1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BtUUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbCxQ45zmqMgW5JwwAA3-

Hi Willem,

Thank you for the review.

> > AF_PACKET SOCK_RAW reserves dev->hard_header_len bytes of headroom. For
> > VLAN subinterfaces, hard_header_len VLAN tag space (18 bytes)
>
> Does it?
>
> vlan_dev_init:
>
>         dev->hard_header_len = real_dev->hard_header_len;

You are right that this is only true when VLAN hardware offloading is
available, i.e. vlan_hw_offload_capable() returns true and vlan_dev_init()
takes the first branch. The bug I am fixing only happens in the else
branch:

        dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;

I observed it on a virtio_net device, which advertises
NETIF_F_HW_VLAN_CTAG_FILTER but not IF_F_HW_VLAN_CTAG_TX. So any VLAN
subinterface created on top of it uses software VLAN tag insertion and
has hard_header_len = 18 while min_header_len stays at 14.

> > while min_header_len is the real Ethernet header length (14 bytes). When
>
> Which device did you observe this with?

virtio_net (in a KVM/QEMU guest).

> > userspace sends a standard untagged Ethernet frame through a VLAN
> > subinterface, packet_parse_headers() only correct_header for
> > VLAN-tagged frames. For non-VLAN frames it leaves network_header at
> > hard_header_len, so the IP header is found 4 bytes too late and
> > inet_gso_segment() fails with -EINVAL.
>
> Which path did you observe generating these untagged packets through
> a VLAN interface?

The reproducer is an AF_PACKET SOCK_RAW socket bound to the VLAN
subinterface, with PACKET_VNET_HDR enabled. Userspace sends a large
IPv4/TCP frame that exceeds the path MTU; the virtio-net header in the
packet sets gso_type, so the skb goes through GSO. The userspace frame
contains a plain Ethernet + IP + TCP layout, without a VLAN tag. The VLAN
sub inserts the 802.1Q tag in vlan_dev_hard_start_xmit().

Before the fix, packet_snd() leaves network_header at base +
hard_header_len (18), while the real IP header starts at base + 14 + 14 =
base + 28. network_header points 4 bytes past the IP header, so
inet_gso_segment() gets a misaligned ip_hdr(skb) and returns -EINVAL.

> > +	bool has_vlan;
>
> nit: confusing variable, combining test on packet and device.

Ag. In v2 I will restructure the function to test dev->type once and
use a clearly packet-only variable. For example:

        if (likely(skb->dev->type == ARPHRD_ETHER)) {
                bool is_vlan = eth_type_vlan(skb->protocol);

                if (!is_vlan && sock->type == SOCK_RAW &&
                    skb->dev->min_header_len < skb->dev->hard_header_len)
                        skb_set_network_header(skb, skb->dev->min_header_len);

                skb_probe_transport_header(skb);

                if (is_vlan &&
                    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
                        skb_set_network_header(skb, depth);
        } else {
                skb_probe_transport_header(skb);
        }

> > +	    likely(skb->dev->type == ARPHRD_ETHER) &&
>
> nit: repeat test, also included in that has_vlan

Yes, this is fixed by the above restructuring. ARPHRD_ETHER is tested 
only once.

I will update the commit message to make the "non-offload VLAN
subinterface" scope explicit, add the virtio_net observation and the
reproducer, and fix the code nits. I will then send v2 as a separate
thread per netdev posting rules.

Thanks,
Junnan Zhang

