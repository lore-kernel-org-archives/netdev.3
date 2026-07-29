Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B79365A00
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366092; cv=none; b=XdLj+VhdJ7fXlrw5C3GeoiyE5wiUdY7dRMB5iqLLxCKyvnf53zuv/m4Ceq35PdwWdENjPFpamwjHREojDPEsqBEFJMWhrwCWJGk+DRNAueocC8hXfm66OaR+GnmGc9bJYI04/31eQ58tqwsh94GEjBB9+SJNnSylHiYsuiSSQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366092; c=relaxed/simple;
	bh=YRKwdqURGq6N6OM3wleKkfQLkDaDF1utDoSg9j5TPyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnV4T1Cqco672Rq1umXyNPpJNAKeXSstIdO1xuLDXqDAdG3KZcXv4XJDVunnH1FnvpFT9YHDdhFNudledx8cNxL/UDgmnkDqYx5qG6il06lxInzPWYxn3wb/413R77696mQQjlQlPSuYr270GtNpx29+hAjnfQQIK4rt9hCWHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Y/qOaorO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Y/qOaorO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1312962b3a.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785366090; x=1785970890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5yG2hwN2s0pmTB1HUCQ9ld3NCZfzYP4y96KfQfhBfhc=;
        b=Y/qOaorOMs33xAyY4ijIud3D66wGFPR9eJWw0SFeVdm7iiL1PJefeDyO/OhUNNAtrz
         bOxDI42gcFg4YZt6z3pkEYWBHirUG1F28RkG9RAzlq2G+YPM6KHi8JIjygNvlTwzRsRe
         guZcw43RGjNlDx6cMLhmWOWrJRLoTsQtQ3/gQXCnCVPrFp6pzS/q5KSXzMX9M/XuQvQd
         O63B7fm2gWAUCOveZ1WPR31vbM7LqIf5wtlYx2fOj8HzvVLiZL1ZDJYfSgXi34ss7szP
         D11yVMLwAwjnRW7z9WMz/3HgZb8pk2vDvAncA+xftRgA/ebDViKAT8j232GYRELa+eCG
         Ob4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785366090; x=1785970890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yG2hwN2s0pmTB1HUCQ9ld3NCZfzYP4y96KfQfhBfhc=;
        b=O55b2mhlEueyzUM5S9mzGZDDJoO/w3tSCQn77V1LXbp9bxttt+ITH4R4WTaw57f/jd
         mboDEXMVpZ+OVYVpr2cxXk25jEQcC+Unw2CorPSURxV5fSPrBoESq/FZR3eo0IdTTo5h
         0YPnFEoz9XQdd5WHtBB/LxJ6IIOeKbhGsWCBfXLfeLedmLcai0v1fkxHEkDI2eRzaY2R
         kfXSXsO0Kq+a8MotwaH2ygQhE4OgFcALf2VrkEnXflkCH1n0rvSZ8CZeeX5Gdvld1I5+
         sK/zaTY9Np85AdQ+8hihOfqiUv7LNb4kbNNhY49L3yT4+rZUxKMc+odog16u9668nccH
         J7cA==
X-Forwarded-Encrypted: i=1; AHgh+RqU3tzwYYMlYNAqDBOMBh5sZ470jaIE5AP53PFbBDXzsGhxoJOEF/TutTLVLXIONk5ppaYcVa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKQpgxPYjC4j4awxnS+ZeKUbt5I5DG/+9cVjUn09J9fzvAQG2
	umEmu7YxoFnlBaPZZHZ3FGmJ7MbJ5KV65XZSxPNIoJtkO0dFzO8EGaICF0vhyXA5XImo47v5h6N
	c4Ro=
X-Gm-Gg: AR+sD10riCUT8RqtUFocvVf81slWDxLKwQkeh/de9snjjTgxjxNwYXRovS2Yt0Nfr5N
	V+yEy6DH3nmqnVPC36nDbty2ljZaRyXvawV3JvQVGpmmQVhd6EHqZighz/FRXMXbqAt7i4Lo8Uk
	+0ItdwiJ0e1Hrpa3biSP/HjncZPFiASbdQLoKXltc9v4Htwcofx0PnR7jXXiKk9cJGDETUnEmAQ
	JPVKCiXgiAS9ZuXmerYD4lJArwVVQxwMIxbS7vqpFguuqmXkmAjMDDIyK9jO2Eg9PDXWmaQ9cJE
	WTFrsrdzSE9jugaoXgvoDeEtD3uIW0vqwtX1EkPw91hL0Yne7VMduogVuuidDpoUB8Sskv3DKNQ
	dey7gecChqehmTIKDL97BuWY4hKq5avC54j/GaYhYgBVZjS3bjidIgydbJN/xmsvXZEmWiLX35E
	ntMZlRF+JwVc8OYkquIA05lxJMqwK+w9WwB4ruXpwcQeobmNWa1MqFSMF8g+cnNVOwVvieP/6cO
	fnp
X-Received: by 2002:a05:6a21:2c15:b0:3c4:1c9f:d7d with SMTP id adf61e73a8af0-3c90085d309mr13877637.46.1785366089506;
        Wed, 29 Jul 2026 16:01:29 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d373c3sm13777272eec.23.2026.07.29.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:01:28 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [RFC net-next v2 0/3] bonding: fix NS probe transmit over stacked VLANs
Date: Wed, 29 Jul 2026 23:01:16 +0000
Message-ID: <20260729230119.2717507-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bonding NS monitor (ns_ip6_target) builds a Neighbour
Solicitation with ndisc_ns_create() and tags it for the slave's VLAN path in
bond_ns_send().  ndisc_ns_create() returns only the ICMPv6 message: the IPv6
and link-layer headers are pushed later, by ndisc_send_skb().  bond_ns_send()
however hands that bare skb to bond_handle_vlan() first, which is too early:

  - bond_handle_vlan() inserts each inner tag with mac_len = ETH_HLEN, so it
    writes 12 bytes into the ICMPv6 message (inside the target address) when no
    Ethernet header is present yet.  Any config with two or more stacked VLAN
    devices therefore emits a probe no peer can answer.

  - Each inner tag also eats VLAN_HLEN of the headroom that was reserved for
    the IPv6 header.  With LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) = 56
    bytes, six stacked VLAN devices leave 36 and the subsequent
    ip6_nd_hdr() -> skb_push(sizeof(struct ipv6hdr)) underflows past skb->head:

    skbuff: skb_under_panic: text:ffffffff85eef44b len:84 put:40
      head:ffff88801400b740 data:ffff88801400b73c
      tail:0x50 end:0x180 dev:veth0
    kernel BUG at net/core/skbuff.c:214!
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    Workqueue: bond0 bond_arp_monitor
    RIP: 0010:skb_panic+0x142/0x230
    Call Trace:
     skb_push (net/core/skbuff.c:224)
     ndisc_send_skb (net/ipv6/ndisc.c:454 net/ipv6/ndisc.c:506)
     bond_ns_send (drivers/net/bonding/bond_main.c:3255)
     bond_ns_send_all (drivers/net/bonding/bond_main.c:3313)
     bond_arp_monitor (drivers/net/bonding/bond_main.c:3458)
     process_one_work (kernel/workqueue.c:3322)
     worker_thread (kernel/workqueue.c:3405)
     kthread (kernel/kthread.c:436)
    Kernel panic - not syncing: Fatal exception

The minimal fix for just the panic is a skb_cow_head() before ndisc_send_skb();
it stops the crash but leaves the packet malformed for two or more stacked
VLANs, because the tags are still inserted into a header-less skb.  This series
instead fixes the root cause: it builds the probe in the same order the rest of
the stack uses, which removes the corruption and the headroom underflow at once.

Approach
========
  1/3  Export the ndisc route attach as ndisc_attach_dst().  ndisc_send_skb()
       both attaches a route and transmits; a caller that has to build the
       link-layer header itself needs only the attach, because
       ip6_route_me_harder() in the LOCAL_OUT path dereferences skb_dst()
       unconditionally and icmp6_dst_alloc()/icmpv6_flow_init() are not
       exported.  No behavioural change for existing callers.

  2/3  Rework bond_ns_send() to build headers in stack order:
         - bond_ns_build_ip6hdr() pushes the IPv6 header and computes the checksum;
         - the probe then traverses NF_INET_LOCAL_OUT as a bare L3 packet, so
           netfilter sees skb->data at the IPv6 header rather than at a
           half-built Ethernet frame;
         - only once the hooks accept it does bond_ns_add_llhdr() push the
           link-layer header and bond_handle_vlan() add the VLAN tags, after
           which the probe is transmitted on the slave being tested.
       With the headers pushed first, skb_vlan_push() grows the headroom
       itself, so no skb_cow_head() is needed.

  3/3  Convert bond_handle_vlan() to skb_vlan_push(), which inserts the tags at
       the correct offset once the Ethernet header exists, and share the path
       with the ARP probe.

Why RFC
=======
I understand the security issues, but I am not familiar with the related
development concerns.  I have tried my best to learn and follow similar
implementations, but still not sure if it's complete/missing any problems.

Testing
=======
Reproduced the skb_under_panic and the malformed probe on a bond over 6 stacked
VLAN devices, and verified correct NS probes (accepted by the peer, correct
checksum and tag stack) with 0, 1, 2, 5 and 6 stacked VLAN devices after the
series.

Xiang Mei (Microsoft) (3):
  ipv6: ndisc: export the route attach as ndisc_attach_dst()
  bonding: build NS probe headers before inserting VLAN tags
  bonding: use skb_vlan_push() for probe tags

 drivers/net/bonding/bond_main.c | 144 ++++++++++++++++++++++++++------
 include/net/ndisc.h             |   3 +
 net/ipv6/ndisc.c                |  53 ++++++++----
 3 files changed, 160 insertions(+), 40 deletions(-)

-- 
2.43.0

