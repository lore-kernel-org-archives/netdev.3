Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768161;
	b=fXoiCpcNc4yAijwb7bFXSOIy/NBpADMxs6FxYmRbLfCmNy5rLON+BQ8EcXsSXI2Pe0xn
	 wOe2kzGuy7/rG4wKuPcgP234cpvGH3vDEYW++mz7u3Gq9V4ztUuNWYZNQ2K5Mhm/4eoha
	 ZC5bIhSpyo0iA6PkZQGfg42v3E5nwuYAbjFxxWWG8XzIHZ3ymM5GXu85hCdBxzSuQugT6
	 5LfxVDvoIM2cqJ5FzGw47aaGzLV7AzHzcFbyru4py/2SFAphmQsYekRfN2LiMxxaGzNv9
	 4SlgtkzcW9gJno8AqHys/FAr9iY0Udbf/aYAOU/Rr1goNTddsEbnx3eyYqMjg6OWtLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768161;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:X-Mailer:
	 X-Mutt-Fcc;
	bh=6rh8t+ieIZ7gnLjDlx3Ddd6qZJAChVB6q5mpHU4/pfk=;
	b=jAzRH//ZO0kA6pjYv0jY0tabis4lMoI5JW8OcI1LD62y9zeahUMil1S57srDvi8TCoPo
	 wWcIt8bS9eyDKHfWPr5q8+IusRf+SNkl9W0sAlasouhygA1BXOdtHXe3V3m76BP96sNwb
	 W9OYOyMXXlfOVatbTePsTE60Uo43zRFFdVyJFOY6PVbphUP5IElIm9PJ1H70PTdyCl9M/
	 yoz8+0yhkl30mbHh0WpJVA8+ieANNXU9q4DmQUMxHr1m0hKZtl9Q+peIWasWZPNc+Fs8C
	 u+9jHX78fzl+rEM2HWjF9KSfyH3K8PvK40ZqzxBoWufaNrLiepczvHIwfOOmLEZOz0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RcFzaqId;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ph7JShYP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26564606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26564606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RcFzaqId;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ph7JShYP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6rh8t+ieIZ7gnLjDlx3Ddd6qZJAChVB6q5mpHU4/pfk=;
	b=RcFzaqId77GbY8LSv2cwoSYSzgxIlvoaJ4bidn6vmZPrTmVa/ezY0yCm1MCZAqWzUVy3eX
	wlAgi5NsRpeQz5BkiqxpFWPI26L006n+ld4MsM6rmMPSrn8rxoHoQiQDcR+oTFttV3KnMT
	FNNtzURGUXIM7k6Qe/vWUF0NFCe5li0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-Mx81pbncPTGPdZ0RhFaodg-1; Fri, 23 Oct 2026 11:09:18 -0400
X-MC-Unique: Mx81pbncPTGPdZ0RhFaodg-1
X-Mimecast-MFC-AGG-ID: Mx81pbncPTGPdZ0RhFaodg_1792768158
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a21053899aso6233575e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768157; x=1793372957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6rh8t+ieIZ7gnLjDlx3Ddd6qZJAChVB6q5mpHU4/pfk=;
        b=Ph7JShYPZxYN6fYIjrh09f0UTea+Jj4KbDL6Bqne3zKsaMI7GNTRcKqY6eGdAXZILv
         5sotsnwDlOLnyFdFZyUarkpO7gYDZMqwJ1nw+98p0u04bujS42xZlrr3SP2qSdqZ9Hes
         GlXfhkizxcLV9nwGOW9QNtuJYL+rQAFp4+uP6dYiH/H1PfLQIcxZQoe0/M0pDOMUvtDw
         T9iD/7AVwt3O4VjW28h+l7jMX21e/rYsdhmkg7ob/dpucGMsHnJRUDfoalTeHYJRDQ+/
         wnK483ieHCANJd3b8ravsM2qcOh+iWxTD9G4CJzZlLqtVd1Voitmkz1qBsS7+Ln4+S45
         /bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768157; x=1793372957;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rh8t+ieIZ7gnLjDlx3Ddd6qZJAChVB6q5mpHU4/pfk=;
        b=0KQ9J00YF45U3c0TSx6C8D8c3Rk5uARgjL9lUCqoD0h6jlEJ2yOQ1hbgf0xLCRiFBt
         FLrNBxZkpokW0kGmrtZOrAB3eVcngOZtkGmfzAKb/ayrWMpkqgOrJgLqM/dRjyyrdHpf
         EqFjAfd6JVWGlCJkcb58vSt8sUgQYRxSpRUJ8QtCal6CfWoXLdSJgP3vTM/KG5u4+/Xr
         w7bRmBJMAjgVZv22FeZrZ4vn3kKnv/7nvMU7v70iJJ3/AjVibnvzqA2KXynKDAM1Ce/9
         cEQxnkjtfrTrsJF0McmYQULWd5qm5Jsd4mIBV161uNTzMLEn5TY3oBryQb2cqzELTJlq
         psgQ==
X-Forwarded-Encrypted: i=1; AKwUvByAEWKGGPBbbWUdsrZZNc78vF+Iw5CxuPGDU42Whf6YBIzolJ4EZ0Xb68g6pvc0mNkoStyhnDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3vuaovfKEjWdoZvb4cYShh0kUkzv6+FvLD5YP/JR2rmLjuFsY
	ihSg/x1UnyXwEbQLkWw/dIZqyBfO/5wjoWz76IAJGuAVslkUul9inUBd271GjArPfoyLz69o5oB
	7O670g4w6iDO5qzmuh4sEJJzBchxWRQKnjhbZbOXtQwLLZaGlaNEgzNEceg==
X-Gm-Gg: AYBFou1hCAh973Z6bjN29zZZv1vh8AKysk/lNThWa8t8c6KkkNsJBAzDHiWCZnirahb
	lXQawPNOa2qAAzbyRg2t0ldo9utQa+se55diu7DZCuvk7P+l4fgVgLWA+iEb3uzqhOzj/guw68H
	8/g2DJbVnRttdIo2l5qP0k5sOnVDC3t6cdZ+vIc7LNje6JOJCX+XtYwrqkZTTkoBB430iQzlmuN
	TU/DnQCnoEAEshJn7vM586XcdqMSI1aC68t6qldOEX19j/G+XOY5xGEdUSU1BvhRSk9euO6wfJY
	Gn/FRydfhoJnO8MkbhM0ajsHXBKp/DWEcrjkhBqp2aGwEXQYrEQVmS39I1EVnVl8zXbrw9A=
X-Received: by 2002:a05:600c:a101:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a211f2b694mr36183625e9.34.1792768157469;
        Fri, 23 Oct 2026 08:09:17 -0700 (PDT)
X-Received: by 2002:a05:600c:a101:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a211f2b694mr36183025e9.34.1792768156891;
        Fri, 23 Oct 2026 08:09:16 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2b0637460sm10017715e9.8.2026.10.23.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:15 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:13 -0400
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
Subject: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <cover.1792768096.git.mst@redhat.com>
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


Changes since v5:

net: resolve uncommon partial checksums at ingress
  - read both skb->protocol and the frame ethertype: do not
    validate when they disagree, instead of preferring the
    preset protocol; same check after the IP version inference
    where there is no L2 header (Willem de Bruijn)
  - pull the IPv4 options in the helper as introduced, with the
    transport header offset computed before the pull
    (Willem de Bruijn)
  - fold the trivial protocol calculation cleanup, formerly a
    separate patch, in (Willem de Bruijn)

net: add ip4_parse()
  - the options pull moved to the helper introduction in
    "net: resolve uncommon partial checksums at ingress"

Tested: full suite on the final tree, tunnel included.
um part compiled only.


Michael S. Tsirkin (5):
  net: account for ingress-resolved virtio net hdr state
  um: vector: trim skbs before verifying the header
  virtio_net: parse tunnel csum_start little-endian
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation

 Documentation/admin-guide/sysctl/net.rst |  19 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  41 ++-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/virtio_net.h               | 319 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/core/dev.c                           |   7 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  50 ++++
 net/packet/af_packet.c                   |   4 +-
 12 files changed, 441 insertions(+), 17 deletions(-)

-- 
MST

