Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D843F0B9
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588702; cv=none; b=orvW0UoZN7RMVHBKGMMYZk1vhHLSUtbzMPyjoKb97KoelLqzEGEnUZ0nl0vYtPsP6AGBfmWEw7iMv72FOflUpvNAyyi/VnJI5vNcgOP1d1KHepXsRY6kDa6D7CreKz9ettRn+thx0FJ9ZmnCS2ZS+A5He8dqasyhhLkW/S+PT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588702; c=relaxed/simple;
	bh=Ki7NN7Qmcie26yOmnohF6eP+Nmz0kYw/zHwlVnpOmbU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=h5yOgrNPTPgMiMEQNjbjKqKn3upwk1obq2aXooBrG5uArMbiqlVpLXfllYyv1KBltabKZ453hFgtJiwYskcwNAT0RFV0siV0nbWBFTs99+fQk9yFCg/xNgdna7bm2JzhJsfd54zg5q/eBO8ZnAke1tFtnIzeQK/68Ce/SocOPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=kVzttXvJ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="kVzttXvJ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so17575066b.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1789588686; x=1790193486; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j92NLv1vusg4NTs4kzoe1mqEKCmRFXV8Wht2u0ae/g=;
        b=kVzttXvJjLKXqDrqgsf52QoNNZsNfquaHKE/bISNe+buK6nRZ7W/leqhHLraLz3E14
         2B/c/9mamrGJAbroVUYBL6ae6Km7df0bw3tcUNComJBgsADCL8FfDC9J+SEQcem5I7PW
         cY/6Zhx/n9pDHlzReVNI6l+X7nEZt76aF6to0kTjsUJP8vZtldOOuIdwXDVOO6JpKIwW
         KH1xDuffqTGGvgHldq96m6og43HEiY4PA94Gq+skXAHlqUpx4L7/ELtXO5ZW9D+KQKQY
         STJKKg2/zlmGgHpTRtyvMzM5rDOsSz8Wld5e8xKF1VWf2tpr0qgqYEWZV7xLLr4azKAp
         eKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588686; x=1790193486;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7j92NLv1vusg4NTs4kzoe1mqEKCmRFXV8Wht2u0ae/g=;
        b=F9NHqETJ/4T2xyZj3TLERSXGaJIK/sRSBYW2sihkz9TZeT+p1dFu7NWlNVVPLz0hcX
         Pt4U18OgH0dl7Hd1p3OSeOvy3EKqjRAiFLI9HSBTnTQ05i786DqJkUXdF8rivqalNVfI
         BDD2hU1jJQgCJAVebsA8bK9npXWws4yMUUmpV+VCdsUJhnOdBCW2+XqHVUSdd/2vJw18
         rNh3zTEq8jt0V4hD1Cl3P6OCDEtaZo7XpB0OjqXxOiMfsn9OTDcMqSwwo7I/A2lPElMD
         NDw1zE7Se+qblUNTmSV5BWBl9mVCGYbKZUBU40u0/S55rlOdajB02kM9ZjVOB57iInLk
         OOdw==
X-Gm-Message-State: AFuF++m9Iaey8WWsapuqSTNILabnClKF9Tn4ScjgVekjruvZLpXnx+7U
	Hn+euynOZMFQDOoP50s+gTOR+/8maRLl2x/7m00E0rT8xBdWyp1j7CQ2+zw1IqsbtB9onqJmM/O
	slIwGudIt1A==
X-Gm-Gg: AYBFou1APg9ynzhNALVY1/oiNkuVsH6sUhibdC0EBt2l+l4ANa+g21VZ+E8Hdr7mH/H
	trd1EmZx39yO5akf31vwpI59ZOV2r0MsZyF1rvn3tKAblJqPpWI9tUB9XWCv7DbJY2mojonnWvC
	XLdxn5/hRZksPBf2uPmfjq9ZLlYZJdGLtoMAgyh3SAP3UX6cP3nynd58NAB/+Ilgi5txhFNWr7U
	BAGE1zZqOs8GQu2luu4DU7CQ9AZMAB+dfdY7jDZIgQk1RBgWxbMXMTQFupW+KDYyF/8kvba3jzC
	IRDYmk+WRd/bE0YDhAr5hrsuC0tOnwdUgFiahSGmwI/O4XGJL3I1wjwWCNqHObXa42S29PLegVF
	rEo4neDNOgZUvng1I3LNEIyMqMEofdUF/9Xx9YjTJGFp8p7mWmnSX8dWgZftScsQC9G86IWUniu
	SCpcytpvZvL1JB8FJmGb1/6jTKYIFCVKbaaVDzASLVBBiWKfe7Mjoc2duuEJfEy80x3jbq3Edgd
	LyiYEipOh5ocKGxP1qyUujw9t9LYKAa1MYUjuxpzyDy6qp/P41RkZGhnkA0CvRAZ6Fl
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c29e5244c19mr402266066b.10.1789588686107;
        Wed, 16 Sep 2026 12:58:06 -0700 (PDT)
Received: from smtpclient.apple (83.10.8.214.ipv4.supernova.orange.pl. [83.10.8.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5e4ca9sm178474666b.42.2026.09.16.12.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 12:58:05 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH net v2] ipv6: do not let ipv6_find_hdr() return an offset past
 the packet end
Message-Id: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
Date: Wed, 16 Sep 2026 21:57:53 +0200
Cc: David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

ipv6_find_hdr() walks the extension header chain, skipping each header =
by
the length that header itself declares.  ipv6_optlen() returns up to =
2048,
and the skip is never checked against skb->len, so the offset stored in
*offset can point past the end of the packet.

openvswitch installs that offset as the transport header, and
update_ipv6_checksum() then reads and writes the transport checksum =
field
out of bounds:

  BUG: KASAN: slab-use-after-free in =
inet_proto_csum_replace16+0x445/0x470
  Read of size 2 at addr ffff88810b754b06 by task ovs_ipv6_oob/629
  CPU: 4 UID: 1000 PID: 629 Comm: ovs_ipv6_oob Tainted: G N 7.3.0-rc3+ =
#348
  Call Trace:
   inet_proto_csum_replace16+0x445/0x470
   set_ipv6_addr+0x3dd/0x460
   do_execute_actions+0x6a3d/0x7c40
   ovs_execute_actions+0xfd/0x480
   ovs_packet_cmd_execute+0xc38/0xf20
   genl_rcv_msg+0x59e/0x870
   netlink_rcv_skb+0x18b/0x450
   genl_rcv+0x2d/0x40
   netlink_unicast+0x6bc/0xa20

  The buggy address belongs to the object at ffff88810b754980
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 390 bytes inside of
   freed 704-byte region [ffff88810b754980, ffff88810b754c40)

Other callers use that offset too, so bound it here rather than in one
caller.

Reject a header whose declared length does not fit in the packet.
ipv6_find_hdr() already fails with -EBADMSG on a malformed chain, so =
this
adds no new failure mode.

Fixes: f8f626754ebe ("ipv6: Move ipv6_find_hdr() out of Netfilter =
code.")
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
v2:
  - fix ipv6_find_hdr() instead of the openvswitch caller, per the =
review
    of v1
  - dropped the openvswitch change
  - retitled
v1: =
https://lore.kernel.org/netdev/114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyens=
ec.com/

Reproducer available on request.

 net/ipv6/exthdrs_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 9d06d487e8b1..4a9748338cf4 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -278,6 +278,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, =
unsigned int *offset,
 			hdrlen =3D ipv6_optlen(hp);
=20
 		if (!found) {
+			if (skb->len - start < hdrlen)
+				return -EBADMSG;
+
 			nexthdr =3D hp->nexthdr;
 			start +=3D hdrlen;
 		}
--=20
2.55.0

