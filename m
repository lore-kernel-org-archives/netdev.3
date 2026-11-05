Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909600;
	b=2q6+A5V+ce7O5GJXy2S1zB2/sBtfLx7QqgP62w1jWC11rZqIviad7EZNVVOZ82eUnIn8
	 T5vjzTb3fg7MD63fIJlCWCd4XCZi/MeqCCutxPumEZdVwCdtNtn78jilxoM5CdaJ/T2oE
	 s591lj4gxw4/uPB99LMrPqdR3qnLW70VQlltqy0ou3cf+gFMzH1B3xq2Z+qVqjsdya+rd
	 leWUsCtt0gHu8mk7GfVhUQR5YIyVfqQvpCx46OuvzcGT6hJNtEB14QJ6ZVB9mCR+nJS3T
	 OhveEdMps273C5yQqWwkON+wRr569SMbl/gYxfTZuqM94oqc2pBpq9ry85rZAxk/XTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U8qBZjLEwMIlWz7QTylFNniXcKRmY3EUw4hBNwrH4/0=;
	b=vjj2+gL1a7FLnptqSQgtRexKUI5FgQkFlfmoR/xIhoAPCCq69tRGe2j+K33O8//fAqR1
	 n5ASsTGUjFtIGIhvsPFB5HpohZKsNVU7i9G9Er/hUHFJpP9WahXXb5wt4hS3oq7SYmFkx
	 Ju2i+u+h8DH0Hg1hSjC2JSJ0AN4LUos8HJZ993p5zg5ttboD4pVg8QLVb0WZJgd988uy4
	 +VR7OaPMjQYC6xGvPG/RqS4gf44cIBlaF6xeb2+Sv8zDgArdozh+kRpbD7M3FXLlhou4I
	 7qKp6p5ypPNpTkuohKyt9ADrj8lQpqWWCo71Ttu9La8yZmM7RzeqBY0BermRRk8ZL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ktl0F54B;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72992606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72992606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ktl0F54B
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so4323703eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909599; x=1794514399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8qBZjLEwMIlWz7QTylFNniXcKRmY3EUw4hBNwrH4/0=;
        b=Ktl0F54BLSlywIdDmOQWFU0tQKBzV2ID7ODdaufrTiJByJIZ1KdIxTexRzMIUNcym3
         PSRP/LGFHkG1QVyVtXEAY+R0BAjBJQxR3T3oOrhCkSz8zZNsx+f1iLmTWQWKu2lVPiOC
         ewkIhkxGXz/n7sMPFFqejyOl3OgnK9WWxXV0W4Xq0rhR8rD8kuzJ8CqfYYwWMD+8PAJt
         AdBQH/peVN5cCUvhlVzDpf0S+7TABqDbr9j0+ecjSLpFwQRWC7M6HOV1CCXCDAxd7God
         Tg/6u9Oud9TIMU5GdWZK/Sxqced5hBW9x7OBnpeo+/xsqcSfwsBKZVdU88SM9rUwCD3H
         iHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909599; x=1794514399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U8qBZjLEwMIlWz7QTylFNniXcKRmY3EUw4hBNwrH4/0=;
        b=rX8g0H1FFqllx5t8tIrAxBzv2v7gh726zAUUaR1GbldqsmC2qaP5nHjYJ719b/wj0E
         BcwKhCO4V2YxVN3P/N5eX9T68d+6m0iDm8JbPYqIqZh/ajr9paj7nrERyL7YUSeJnkNB
         lG/TkmPWmgfDYysbngWh4x3k+oMuWFHDx7jc447/O+BMDmYMyTj6IZHuBbV3k/3f2aNV
         qKzqinxc7i3UbFbrm7sFvAYaVz/GA/b6ef69DFEYqeLrhy3Y/sbyp86Vig86v7mkQbqQ
         FzXABFkA3QhNXpI9Qw7Pmeh3fqDbiy67QiI6LeBrprJ/QH4LKLTxNhGLzES6v8ZrfdXK
         jVAQ==
X-Gm-Message-State: APuU4Z8xgiDcCZvqSuLAuDYQktZhWPh7HNTJVdwZbo0zolsm8i3G/ltL
	5uS2BgtYAaLIxuATBR2GPCiItk/RV9qysfAWuI2xyMdJzjfW+zjjlk+GRe8qRzzo
X-Gm-Gg: AYBFou3/GRzqwLAo6ZffmncJWH5xOYY121PNrknSmwH6+Md2yqHbMss/YkY2TPPo/53
	ztBtkq4XKlW0KBnSLazFspKgl/vWYMhjofgq4qcTVKT0rgCeGvCzdRkWrY8+/avzcMRKoMaFxmc
	JqIAuOirVC7cjS7DEFsJUugLe8BfBi+PIBdBNxd2aqjWIGlAvQCAwxVmQyI4QfjQBLR5d9O/lOG
	r7jRT1dR7ONWMtRtKZLYqBE2q/tqJ2UsYLmmBEq6phx94o3uYTiz07Ft90catkkgXSPnLBkj7RD
	iT+tukruviRA4ViYVPYTmcv5Z37TqpOE29tvJwwDad+UdJjNpSAvrSohJkwZjPp7l2gZ6WdlVFV
	xoPo093l60Q9nlBKWqTVeAbgSrpI9Y+Ou/DTUIFI6yjwmpYrg3tUBYz2mDkc6/ALAHmFn6YNIS1
	GwTIvwov8WVfe/aW82+RARsDhnMarcWumq/r1EKRyD1alvMZ31w53aU8DsWUxrgQGD/bviz2ho+
	pluDXQsQkm6C7qgnchN6DjmRJyVhocr6Yupv2GOOLhdhegSiimDtTFiyr2K53yjkkylUXUYSt7n
	LCMX48R5XZYpMKwc1ME5/MhHDIeuzEg=
X-Received: by 2002:a05:693c:68c3:b0:36a:32ac:ad89 with SMTP id 5a478bee46e88-36f722e7fd7mr374752eec.2.1793909599270;
        Thu, 05 Nov 2026 12:13:19 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed312sm590869eec.19.2026.11.05.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:13:18 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next 0/4] ipv6: fix stale transport header of GSO packets with extension headers
Date: Thu,  5 Nov 2026 15:13:05 -0500
Message-ID: <20261105201309.3182307-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 input uses transport_header as a cursor over the extension headers:
ip6_rcv_core() sets it just past the fixed header, and each handler
advances it. Forwarding stops after hop-by-hop options, so a forwarded
GSO packet with a destination options or routing header keeps
transport_header at that extension header, in place of the L4 offset
GRO had computed. seg6 inline, rpl and ioam6 inline likewise point it at
the header they insert on output.

Code that runs later reads the extension header as TCP:

- Since commit fe6cc55f3a9a ("net: ip, ipv6: handle gso skbs in
  forwarding path"), ip6_forward()'s MTU check can answer with Packet
  Too Big at the current MTU, and the flow stalls.
- Since commit 7fb4c1967011 ("net: pull headers in
  qdisc_pkt_len_segs_init()"), in v7.1 and 6.12.114,
  __dev_queue_xmit() drops the packet as SKB_BAD_GSO when the bogus
  doff is below 5. Zero padding and SRH segment addresses make that
  common.
- Qdisc length accounting and ndo_features_check() see the wrong
  header lengths.

Rather than make each reader find the L4 header itself, set
transport_header where it goes stale. Patch 1 does it in ip6_forward()
before the MTU check, which every forwarding path reaches, including a
router that processes a routing header and forwards the packet again.
Patches 2-4 restore it after inline insertion on output. The input
paths keep it at the inserted header, where local input parses from.

For these packets, drivers now see the real L4 header in
ndo_features_check(), and in ndo_start_xmit() too for those that are not
CHECKSUM_PARTIAL, such as fraglist GRO. CHECKSUM_PARTIAL packets already
reached ndo_start_xmit() with this value.

Not covered: bridged IPv6 with br_netfilter, where
br_nf_pre_routing_ipv6() does what ip6_rcv_core() does, and GSO
packets that never pass through IPv6 input, such as LRO aggregates
redirected by tc.

Tested on net-next in QEMU with 3 s TCP flows between network
namespaces over veth, forwarded by the host unless noted:

                                        before     after
  dstopts, byte 12 = 0x00 (drop)        1.1 MB     13.9 GB
  dstopts, byte 12 = 0xf0 (PTB loop)    6.2 MB     13.9 GB
  SRH set by an unprivileged sender     5.0 MB     14.4 GB
  SRH with the router as a segment      4.7 MB     11.4 GB
  fraglist GRO, dstopts 0x00            3.8 MB      3.0 GB
  sender's seg6 / rpl / ioam6 inline     65 KB   9.3-11.0 GB

Forwarding without extension headers was unchanged within run-to-run
noise.

Matt Vollrath (4):
  ipv6: fix transport header of forwarded GSO packets
  ipv6: sr: keep transport header after inline SRH insertion
  ipv6: rpl: keep transport header after SRH insertion
  ipv6: ioam: keep transport header after inline insertion

 net/ipv6/ioam6_iptunnel.c |  7 +++++++
 net/ipv6/ip6_output.c     | 17 +++++++++++++++++
 net/ipv6/rpl_iptunnel.c   |  7 +++++++
 net/ipv6/seg6_iptunnel.c  |  8 ++++++++
 4 files changed, 39 insertions(+)


base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
-- 
2.43.0

