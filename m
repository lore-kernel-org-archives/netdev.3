Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793596;
	b=vV/3ZjcLmgw+7GBbLCAho+2IDGSZ8MxWECB7EwqWxmdHYT1qYarHwxuJBuVCyT6HL0za
	 vopI16zsmTR7ifgB4FnNvZ+qgaTGBeaCGNBFdnzEVBmc13LSqhR99gsohsPOFwm7QQoJn
	 a9Q15z0tBR4MpYExYahs00auN7LNTNrXnNbcFr8bu3MqnRxeJ4lUQsw3wuwhSm3X0cm90
	 +cyAAxmo/jhJXZG+55dxFwteUuOGuX7hahqNBpE+eewM0ySoXtrRQrDNIReUJ7HJZnJRJ
	 XN32ffNZWkRWJRfLcFPvIb6q/oPkyiEDtVMJoVJXThMH8Jsde1cTjmrbWkr9GXN7DXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793596;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:X-Mailer:
	 X-Mutt-Fcc;
	bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
	b=yBdnqIQ6MXTEcgNzxZkx0eavbYb5M9kHgXZHMUDSLVKS3M+IQEAy+EsQjCLCmGeLqEua
	 TFQuwvk+qbJ80cqjDCJplJszinM7VzfiJvjUMFmEjeMs2zNRwR5bU0KhLZRLoW9KWdY3G
	 PNdEWZnm9AhKSx/2HbGhAnQL0RHZZA2kDvlLwkqPVrwyOMKnA082p97i36c7HpgM6vWZZ
	 ZPRViQEehyGeV9E/R2OZWseUNwy+3H7vKA4elIPK+Xhh/A4vQ/na1LYgyBLEM1OGz3EWj
	 8VqeDH/so++NzJQagU9Ee+ovh3c+LjiaVRhRL6S54VZ07i7ozsnkKTKYAJyn3Oteapg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="f6GQ/Neg";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mzvWxrLG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADA606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7ADA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f6GQ/Neg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mzvWxrLG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793793594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
	b=f6GQ/NegPyQWLwkjGOrBgY/y9GxvBF3TBdFnAQQIsEMiBsXg5HfyV8AdaXXIsjXerOiVHf
	zSTsaXufbCDNRimZr4F6sJDrCJVSCTI8NRiMmlKr8B9CcxiiLamcSwyFCrR/Y85u3W5ec0
	ZOqeNowBkXTV9UDqIkCGMAlJ+jafMk0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-7m78cIsSPZWZTa0peH_1CA-1; Wed, 04 Nov 2026 06:59:53 -0500
X-MC-Unique: 7m78cIsSPZWZTa0peH_1CA-1
X-Mimecast-MFC-AGG-ID: 7m78cIsSPZWZTa0peH_1CA_1793793593
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso4841665e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 03:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793793592; x=1794398392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
        b=mzvWxrLGCkgv1cs8MgMio46A1ZW+IGzd/YtIjeMuzkDVaF5SDwe3TUJ1SdUOphZFgg
         gglmDVyTsoY9ljCSZyOVQEmpE72oe9yUHvVSH4euifHFAm5GDHX1Miqqj2t6fV6pKkQc
         3E6T0NFYoekNDiNMhVpGhV8CUrjqlpP2tJXwnLxr+3JRvslRatEjy+FJIoKz8ggikZfo
         G8t0qkmHun8CeoWWG6fFQKnh1/Zjyq7xJsX+zoWictWZI1mBslzqpfP1TY4tO3RHLTsq
         rhb3TBRWvZa9NsLSmjR1F7ot6B5Ehx2p8M+3+cmDFl22ONONXoxvFahur90NE8xJF95W
         bRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793592; x=1794398392;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
        b=vTvxydgJZIPWn1NmDlBTjRsGcxTD+jx3LfFtN0EIF/FE+xM9TT9m4OzV1DfiCqseZi
         O1dl2ew7MZMdWFYVnpnM4lfZpJ7ET49TNLlcvRVbryR5tNPwa92a+0UPTh0zwr2WrBG5
         jD/f1i9jcfK7ts+8NrIrcwS6Da9I9LCCKkv1XeeowvPXqfabot2lqTKyAkKYWopgG2o4
         CT7/g/Qyxn8iNP8D25ZcpCCiiI3tUEaVIzZD2uQR3J3ijdyr31sV02yVfPIfJi7yF34I
         nJJAVF2CnnR02V8s9tYSezNy3/nPrGOZjZAWbd4jjkLmyfChuY2NOWUmMRfyQwTPsuOY
         n7kg==
X-Forwarded-Encrypted: i=1; AKwUvByeL+bK7F99qFOBgZ6zXPIItENosJ1Pwo7zWB8z4NLcDTS9QEqzWhRS/31HhmNzJOiRbo08Dpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6nDY9PB74zvQXoEtF55jOBV8bQELwQNLMyZLpZcdwnoID/aKl
	J+jOAlEmQcdB+T0Ekf7sWfD7Em+eqgjIGqxm+u/JRbR5D8qOwm3JbpApk4cjZS7E4puBjtzQPK4
	UlW/9v5KqW8SG1mhy5jTC9HMo6vtKkfhcE8EGzSqDz1mxqFXR7b3wV4I+1Q==
X-Gm-Gg: AYBFou0a8z3b3hfUB0MkMmyH/5wV5LZ6+eFN9y7BX26Konewydh9NSl3St+QxN4jgha
	IQy90W2mNPJ2kvsCrwQVLub8n7KCEC65coZ7pblBFZIL2SZsqfo2pEHGVI9mhnMN0oHACliiibo
	Y01h/14jCPbFS8NfXc+Httf1KZtU/Hq8ZGn/o+FUbt1YJWWeRa61xZjtrZtN2uaH452J41XquPX
	SeOLDqc15QBncNUIKSvULkE8Ne4sJ4UXs4X9GhjSwW8OZzQT4Ek/dC6DcP/vLjkv8FO6jGk/U9N
	frhdMFWo1Z6Rtg84oXtPYnwaGbGuIdJF0x7fMBg1F9QEvYCjR1l9Y+QmzQeXF4nJA1MsqBfkx/h
	lmKZBDi+2otbjrmP+MgcQA4Z2mFs9vyYDtDBanboBog==
X-Received: by 2002:a05:600c:1d23:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4ac185bccfbmr364154515e9.13.1793793592214;
        Wed, 04 Nov 2026 03:59:52 -0800 (PST)
X-Received: by 2002:a05:600c:1d23:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4ac185bccfbmr364154215e9.13.1793793591720;
        Wed, 04 Nov 2026 03:59:51 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ecdasm74195465e9.5.2026.11.04.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:59:50 -0800 (PST)
Date: Wed, 4 Nov 2026 06:59:48 -0500
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
Subject: [PATCH RFC v7 0/5] more virtio-net csum hardening
Message-ID: <cover.1793276116.git.mst@redhat.com>
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


Sending this one as an RFC: two issues are still open.

I'm going to be working on other things in the next couple of weeks,
but I thought I'd post this in case anyone wants to take this up.

Issues:

First, the general issue is not addressed 100%: if a tunnel inner packet
happens to have a valid header at inner_nh_offset, it will pass all
checks, but the transport header can in fact overlap e.g. the real TCP
header and the checksum will overwrite that.  I do not have a good idea
how to address this without either a heavy protocol-specific anchor
derivation or dropping well-formed offload.

Second, completing the checksum at input breaks nf/BPF programs that
might assume that the packet carries CHECKSUM_PARTIAL,
then tweak the payload of a packet in flight and rely on the checksum being
fixed up later.


The sysctl added in the last patch could serve as a work-around, but it
is a very blunt tool.

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

Changes since v6:

all patches
  - rebased on the current net tree: v6 no longer applied
    (Jakub Kicinski)

net: resolve uncommon partial checksums at ingress
  - validate header before the tunnel metadata is installed (Willem de Bruijn)
  - some cosmetic tweaks

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

