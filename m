Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673888;
	b=3/JxJif51KmgpwGu+CpTa0IPwnzfx1CqXAfcV//LNHpxur8z6s2vgrs7TGeqWKYIITHp
	 RRara8v2YWnWAVU/cVYpN8enVYZF/iDTUAOOhIFEP5+FwcqVV7x/lmBc+YViNBCBKDwGL
	 Te/Eu8LhwTPMvovH0jSIlGMRfZg5NikdP/H6H4AqJlnruu4neFrG4RbNKVX66fl2m4fx5
	 88McZsNemwdMu4Q//lQ3ul3sevkr+gXxtm42Ic3JG67K8zMnV40DwuMVJC9d1S1DDtzRR
	 31jRlExsIKXK3kmBSzqovgpvnZja1CWR9wZWrYIMt+ILpxVynYNw48Fc2hNFcjLXMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673888;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:X-Mailer:
	 X-Mutt-Fcc;
	bh=CCgTB6RIkCwM8dHY5A88kQSZOGczA39Y2iVzt/yKodk=;
	b=IOr+hS9HIGuEa/ZEmG+5QYSW+1cGck3UIB2Cm314+jORCf/pJdwpbEuQbqp825gg0+Ky
	 sLA9vB15kp1W3wsCkBRE+1MDrsLg4QJORei49mYCmTHcOElafh6AEVfCweUCOIUcNAIOu
	 ReViwhrH1OGt+C0GepL6ju2DTnLJBckTyhFQ5gtuXCfTn6RvdP9A9ER2n7r1u1RUyI3Od
	 HgT3YPkMFYlXlOqIvQtZnQ3ErdIvgGQMgdGtSpWCxzBKLBjjYaIPH+NyIZRXOUBY8WfYq
	 nNXRjm7MHbItOXzxWrgkbv6GflbPM0qdJQupXUBVvH2jdIc9aSN5TkDHJpeoStxqAZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IpCXK8bd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qhwo9qTd;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E1606A33A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F3E1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IpCXK8bd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qhwo9qTd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CCgTB6RIkCwM8dHY5A88kQSZOGczA39Y2iVzt/yKodk=;
	b=IpCXK8bdnzn4XrxxHwPJFOVsvF5Fmhr+2/G/8EFpag8tHMDJujF6k3OWuFTgD1zwrdNkOk
	Y0aH8kJMYwckTgD4+uggHRWhMH/3mMsFgg5PeY/+/ffzsk+nzkJWURij2N4G9DQR+JvwSG
	r5LGXO7kLgFmkKVcmOLmjmNc626ocW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-n7crEqWOPK-_JDzVdtM78A-1; Thu, 22 Oct 2026 12:58:00 +0000
X-MC-Unique: n7crEqWOPK-_JDzVdtM78A-1
X-Mimecast-MFC-AGG-ID: n7crEqWOPK-_JDzVdtM78A_1792673879
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso15310815e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792673879; x=1793278679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CCgTB6RIkCwM8dHY5A88kQSZOGczA39Y2iVzt/yKodk=;
        b=Qhwo9qTdJAPtAqyz/aIr9nXfq+oU0Q79njfLpQ5OqrkvpGOl0VhUgh01eyFjlAzGvx
         vosaXKxXenCBzZixQe7qB76DMCWx9j/wT7G074btRadNJb4rYqRPoLRbBtw2Puw/bt5d
         4o5v4mvZ62csMv++sXuVNv9VyUVxeIi9cGRDLzZGpYU93M5oFZ7b6QhgXaEOPKtgUfmh
         eDHp7KstgY1HQ6c1NzN50xQ64l6TqDFshPb0CH7xTcdEIbjTGFhgjLXuT9DzR9hGXmuw
         s1d3D+fR+Ok+VwpVvc+6xFdg4Vs7sAZkVNubRE9iq5ATeen3t/DSQTycAliBO/i44B8f
         znDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673879; x=1793278679;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCgTB6RIkCwM8dHY5A88kQSZOGczA39Y2iVzt/yKodk=;
        b=Kt6valsdpYEFQuW3xQv1CQRKYhOczfov2/70qjZqr96hGVL0theTT04mOY/oOEiS/l
         2AXVKdK7BnDNi+v2hn7IMex7egZddid0+7q8KuEKjEPjMoGzqDYHNj5pTozlsuV7g4HR
         ry+xLX5cz/w5Ijk1isxNLUhsrVIdsB8PyxpEGM1KGgvud2xZ+6adJ74qBBLBKj8pCLz/
         p+o0pYUocm4XmsGgRSSi8PaFPVCfPwqLXOlfS/OPT+MYmxQc7ow8E15dCn+Swrz7/rXP
         W7gyvUVwb5tcadeCF1ukvukG3gaeSL1IHFRgs/Z29RVNNG7p6XmN0BihgIRpqrDTDTBu
         V9mg==
X-Forwarded-Encrypted: i=1; AKwUvBxiE8hgLzaytQxkMoX3nw2ePVpTki/98jvZ4zZ/ax35QRHchGHzYCO14U4l9RFtRie0fdImWfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSjzb6E2ZX5kMT366/KUL+uuKCiXqJxq9MoTGCORethGDUNiA7
	uS/t6yieToXLx8F2Q8nS3ylYtnTkHmAUxRkVDGf2LcmO61SCfdtFmdIv2XfiRd9kfc/Si4cc9Xl
	swV7s0qWVJrSwa6EbV8baSPpWs1MVmJnTi5iCYueTkdBQ2s5FsJjJRoCyjw==
X-Gm-Gg: AYBFou2WKZ6o3uRYi8Guiwa0etlB7GDA9b7KdNIeji0QMFGWS63yi1RapBQ5gJRbouz
	yTBSGvsrC2OJP+XYuTIySELsOD0JEK2nOaxsxc7i8hc0EwMCXvWPHP3iYkx2E2uYUyhngMSCBzZ
	VY3LNR4qRmVL14kvZrDRC48Em3s+7Z0zMHYnMe99yUucZH/LXOdDNUtbDFUA6lCpivJ4wM9+T7x
	o03r23TMggBn4sZBRHVsmAq00gg4g+GzJghuOVeUP9fsuD59p6EbGDeAcPCTO+qrsNg0CPIHbS9
	ZiNcVfucvzBjwmTE6fEplA1v8nc07CF/Pm5DJFDZC6/iJxViZmEPe/q2PMgbAKl33KA=
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a1fdd31aebmr111244015e9.16.1792673878594;
        Thu, 22 Oct 2026 05:57:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a1fdd31aebmr111243305e9.16.1792673877808;
        Thu, 22 Oct 2026 05:57:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b42befsm66332875e9.8.2026.10.22.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:57:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:57:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net v5 0/7] more virtio-net csum hardening
Message-ID: <cover.v5.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Okay this seems to be converging.... But sashiko did find some issues I
thought are best fixed. Specifically I thought of a better way to handle
short gso in a tunnel - just clear tunnel gso! As a side effect we now
fix up the checksum for these dodgy packets like we did before, instead
of a drop. Good. And more false positives that prompted me to write a
bit more comments. So here goes.

Apologies for reposting so frequently, I know netdev bot will be unhappy
with that.  But Paulos's report made a lot of publicity, there is a lot
of people looking into this, so I feel there's value in defending
against all this class of issues sooner rather than later.

The issues were mostly found by code inspection, but all reproduced by
me in a VM.

------

As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users):

allowing untrusted hardware to specify csum start/offset for
CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
outside the actual checksum, and depending on the setup, the networking
stack could be looking at the packet both before and after the edit, and
seeing different results.

Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
completing checksum") validated all known instances where this
causes the most grief, but the real fix is to make sure
that either only actual checksum fields are ever edited,
or the checksum is completed before the net stack looks at it,
so it is always consistent.


This basically goes back to
what we did before f43798c27684 ("tun: Allow GSO using virtio_net_hdr"),
except in a narrow list of specified known good cases.


Summary of the patchset:

These are probabably net material (and seem to be too big for stable,
or I would recommend backporting there, too):

  net: account for ingress-resolved virtio net hdr state
	- accounting, not the fix itself, dependency of the fix
  um: vector: trim skbs before verifying the header
	- fixes the um receive path: without it the checksum would be
	  completed over the unreceived tail of the buffer
  virtio_net: parse tunnel csum_start little-endian
	- bugfix, a dependency of validating the header
  net: resolve uncommon partial checksums at ingress
	- fix itself
  net: add a sysctl to opt out of virtio net hdr checksum validation
	- reducing risk of the fix by adding a sysctl to disable it

These are cleanups, can be deferred to net-next, too:

  net: add ip4_parse()
  virtio_net: cleanup protocol calculation
	- cleanup resulting code duplication
	 (kept separate to simplify backporting)

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

Changes since v1:
	- reorder patches to fix bisectability, addressing
	  a comment by Björn Töpel.
	- code refactoring, different patch splitup,
	  a sysctl knob to disable as suggested by Willem de Bruijn.
	- fix a bunch of minor issues spotted by LLMs


Changes since v2:

virtio_net: parse tunnel csum_start little-endian
  - new patch. correctly parsing the header is a dependency
    of validating it, otherwise i do not know what to validate

net: account for ingress-resolved virtio net hdr state
  - make rx_csum_sw counter 64 bit so it won't wrap
    (spotted by LLM review)

net: resolve uncommon partial checksums at ingress
  - tunnel fixes to bugs noticed by Willem de Bruijn and
    Chris Arges
  - restore the csum_offset checks as suggested by Willem

net: add a sysctl to opt out of virtio net hdr checksum validation
  - the knob is no longer writable by root inside a user
    namespace: changing it now requires capable(CAP_NET_ADMIN)
    suggested by Willem de Bruijn

net: add ip4_parse()
  - comment converted to kernel-doc format (Willem de Bruijn)

um: vector: trim skbs before verifying the header
  - new patch, found by code review


Changes since v3:

net: account for ingress-resolved virtio net hdr state
  - um: vector: honor virtio net hdr conversion failures
    folded in (Björn Töpel)
  - count on tap and virtio_net, too (Willem de Bruijn)

net: resolve uncommon partial checksums at ingress
  - walk the frame on loopback, too: loopback_xmit() runs
    eth_type_trans() on it (Willem de Bruijn)
  - return the mismatch handling directly, GSO is implied in
    the tunnel path so drop there outright, and fold the helper
    into its one remaining caller (Willem de Bruijn)
  - read the IP version through struct iphdr (Willem de Bruijn)
  - document the ipv6_find_hdr() flags choice

net: add a sysctl to opt out of virtio net hdr checksum validation
  - renamed to virtio_net_hdr_validate, in case more validation
    is gated by the same knob later (Willem de Bruijn)
  - point .data at the value like the neighboring entries,
    the per-netns registration rebases it, and the handler reads
    the value directly - no ctl_table copy (Björn Töpel,
    Willem de Bruijn)
  - check the opt-out before parsing: with the knob off, packets
    the parser cannot handle were still dropped (Willem de Bruijn)
  - include virtio_net.h in net/core/dev.c so the static key
    definition sees its declaration (build warning reported by
    Jakub Kicinski)

net: add ip4_parse()
  - add the missing kernel-doc Return: section
    (Jakub Kicinski)


Changes since v4:

net: account for ingress-resolved virtio net hdr state
  - count on tun only: dropped the tap, macvtap, ipvtap and
    virtio_net counters (Willem de Bruijn)
  - the driver side branches are in their final form here now,
    moved from "net: resolve uncommon partial checksums at
    ingress" (Willem de Bruijn)

net: resolve uncommon partial checksums at ingress
  - no longer touches the drivers (Willem de Bruijn)
  - a packet too small to be GSO: ignore the tunnel GSO request,
    same as plain GSO ones, and complete wild metadata in place
    (sashiko)
  - document the zero copy interaction (sashiko)
  - honor a preset skb->protocol on ethernet: the stack uses it,
    except on loopback which re-parses the frame (sashiko)

net: add a sysctl to opt out of virtio net hdr checksum validation
  - document the netns lifetime requirement (sashiko)

net: add ip4_parse()
  - pull the whole header, options included, so that the
    transport header offset is within the linear data
    (Willem de Bruijn)

Tested: full suite on the final tree, tunnel included.
um part compiled only.


Michael S. Tsirkin (7):
  net: account for ingress-resolved virtio net hdr state
  um: vector: trim skbs before verifying the header
  virtio_net: parse tunnel csum_start little-endian
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation
  net: add ip4_parse()
  virtio_net: cleanup protocol calculation

 Documentation/admin-guide/sysctl/net.rst |  19 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  41 +++-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/ip.h                       |  37 +++
 include/linux/virtio_net.h               | 287 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/bridge/br_netfilter_hooks.c          |  15 +-
 net/core/dev.c                           |   7 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  50 ++++
 net/ipv4/ip_input.c                      |  13 +-
 net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
 net/packet/af_packet.c                   |   4 +-
 16 files changed, 461 insertions(+), 43 deletions(-)

-- 
MST

