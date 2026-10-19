Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23463493D51
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411390; cv=none; b=Q/5nseg0AwYkiChzcQj5DrXY/4ez5Zb+nsdnF9wD+plTOV/Ve+pqNkipOpRp2P3UYgythLslkVZMy7SH/Ms8AsnRQQirtyfYOUJPpTufecYbGFyHlbHqNyHIaGvoV9d72+jaTxM7mg6qVYeR8KRDpAVZerEpjaCXdmGJHGDa5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411390; c=relaxed/simple;
	bh=JfVrdU9i2N0Bpm2VJnX1p52qBM15ob8/6fn81bBvHrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MXxicYSnHecCGPrKEgHzlFrk0i+ja8/tBCkHchs4mrHQp7qHTy77tDlZuZ42RKeRwwECsbA1pKhOVWAkXWE8V6t1wShmXeVirao02/zwwn8Z0LFisilaiBhUIDuUXOX1Z3378rWWghQvcert2EJ3WKOHVpqmSIiXjkymdTpjUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PM5WyIqR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNBZ+Uzg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM5WyIqR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNBZ+Uzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MWgf1JLTlMs0FExF6oeyiAd0TQJNBBUWYDr7aW2ZUr4=;
	b=PM5WyIqRrvz8DL+Pyf7b8w0fJSE1MjcpXzc3dSO3UgFlCRLwPiVSOb/qCsiyTFyefavHAc
	qCkOks7LVdwvTSwA34h+TPwlSxb6lzyUVXzdf/IhXtY6tOAaVe6Kzway3S5xVt/RULGIPJ
	iN8hSzmH2bpgiTN5XXkwuFgpvHW1wEU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-4uZR9EiqMUC9B13zgiw1Rg-1; Mon, 19 Oct 2026 12:03:07 +0000
X-MC-Unique: 4uZR9EiqMUC9B13zgiw1Rg-1
X-Mimecast-MFC-AGG-ID: 4uZR9EiqMUC9B13zgiw1Rg_1792411386
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so1344061f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411386; x=1793016186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWgf1JLTlMs0FExF6oeyiAd0TQJNBBUWYDr7aW2ZUr4=;
        b=BNBZ+UzgNNtzFi4cCE21UpGMnrnq7wY/OVj1T4aJKlIGkMoxQy0kyXwTUqD743asJf
         mdMYQE0DoVl9oph6qbLlK4YQyr5u8mAqKE96mG7WCFBclU0XUTwPKXGz9McH53trtUT7
         JUeS+z8g25bSQDRFoHDjZA+HmrrGsswtA9rag3yDfWRv/lZWUoA9FhE7q4Xh09nI45qZ
         FpugXOAQxpF+SFzsnG8TflZgxPWsOfMimQ7F/a3FgS7DfER+xyaDMTQc23f8zzffV8FK
         2FMx2w2f+nKAtIfLpMSiqKxm5/8UhZZBbZmnYajPmjnY/7lCfK2nL9kkdpS34U7phkUW
         rUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411386; x=1793016186;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWgf1JLTlMs0FExF6oeyiAd0TQJNBBUWYDr7aW2ZUr4=;
        b=tIGY5b1zdLLRoIoRw7pXqblENWEaQ4ENjxfA+xe7koC3CDnwlHKo+NkpqPHdNDRlA1
         DGLiH9gEZ+CsvZLWlKmamD5Wz7kvICEP/YSY5FpLIcn+vso10lR4wz35UxZ8E1NeD/9g
         RbIBaEDfxWxRQZYYIIXfkIM8d+4Nmg0zXqpizT8MYjScDxvgpCmGJeqtaONNJDNwnZWL
         usV5gJwu6gA9aEt0GhQ7WaiRKage9Ov3YAYbksrWiivoVdz0jk+xgG9dOrfbWdA9Fhc+
         8OPAzTiyCSVRVL/frUNtGSicfqoWy7AuSEyoqIxPMY1/1oNRyV3ClD0FM9Zubi7v+58A
         IECA==
X-Forwarded-Encrypted: i=1; AKwUvBzlM+3RVDEPjZ/t55X279zciLUO2oQhqQEJpvte/5qrI2OLgq5ModhUa2m/4whFtikCLvjcSpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLou+A7Tj4PUqf0jYALhmw7LfGM8MaHsHDJnQB3aST1ETIsJP9N
	MFCYjUHV1dI3KnspuL4eyzGJVTh6fbUJ1LvnD2XzRX1OIfSe2/y3tDSBwKWESqcqlfSB1fyZ6oN
	WEpPSPKFqnt3OZd24ynn9URvCuVj7eaVv8zSQRlqmhUmopt7eX7t0q2sSRQ==
X-Gm-Gg: AYBFou2uN0AwBFB0mAhWB4p99zfglG15s3T6RcIRpNGXZXFHZpYOtjdIijiSwR6WkAr
	LBi2gMDMTZlUd+JLlRDEefFmTwudIEUWHVXPwKxNsM2MctV9Sv5ZYwWqP0mi4VJ6kif1re1Zbu4
	ASjAsoxdhBAn5lBnPfbuz1/VBHV0B2dKdPCcu7mD/YuJTW+Qwqx1tyOh5zVJFZWcCeWY6oeNUXp
	+8jpJJaD8Txfgivv1cRkX6JLCTt3PEdM6LAdhl3nV4aAJ8efTPsepIYOZgNpSdNwm0tkWVlhpOR
	JH97uu6ktYGxqgFgbxCuntKowuFh0s0/4xhUT/NFKCqH1fVp3m8LQzQBDA/JkFvWTlFQ9w==
X-Received: by 2002:adf:fa49:0:b0:486:f856:1975 with SMTP id ffacd0b85a97d-48e07bbca4amr10754779f8f.22.1792411384088;
        Mon, 19 Oct 2026 05:03:04 -0700 (PDT)
X-Received: by 2002:adf:fa49:0:b0:486:f856:1975 with SMTP id ffacd0b85a97d-48e07bbca4amr10754717f8f.22.1792411383453;
        Mon, 19 Oct 2026 05:03:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ec8dfsm23766001f8f.26.2026.10.19.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:02 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:00 -0400
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
Subject: [PATCH net v3 0/8] more virtio-net csum hardening
Message-ID: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent


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

These are definitely net material (and seem to be too big for stable,
or I would recommend backporting there, too):

  net: account for ingress-resolved virtio net hdr state
	- accounting, not the fix itself, dependency of the next one
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
  - parse csum_start in the tunnel header little-endian like
    the rest of it (spotted by LLM review)

net: add a sysctl to opt out of virtio net hdr checksum validation
  - the knob is no longer writable by root inside a user
    namespace: changing it now requires capable(CAP_NET_ADMIN)
    suggested by Willem de Bruijn

net: add ip4_parse()
  - comment converted to kernel-doc format (Willem de Bruijn)

um: vector: honor virtio net hdr conversion failures
  - commit log tweaks

New patch:
  um: vector: trim skbs before verifying the header
	found by code review

Somewhat tested, tunnel also tested now, um part compiled only


Michael S. Tsirkin (8):
  net: account for ingress-resolved virtio net hdr state
  um: vector: honor virtio net hdr conversion failures
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
 include/linux/ip.h                       |  27 +++
 include/linux/virtio_net.h               | 272 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/bridge/br_netfilter_hooks.c          |  15 +-
 net/core/dev.c                           |   6 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  60 +++++
 net/ipv4/ip_input.c                      |  13 +-
 net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
 net/packet/af_packet.c                   |   4 +-
 16 files changed, 445 insertions(+), 43 deletions(-)

-- 
MST

