Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550904;
	b=lBrWkybKIDULFp/5f6G5ZpGSXmkbjtO56zgFMonKeea2uEL7Tx63G1uvRyasSkPNYraQ
	 bPIzlN2nDUXcgjx7kJjjH3v9vuC3033ka2C42B+em37uD7d6n8q9bVkRFM7e8siL6HU7d
	 AANxgiXEg+weP8eLKYjHxaNxwMop7GijJzAHCw7oj3nuE82kcvGNYLXpgEkmAmjOCmKq0
	 nQl+N8XrUZ6yVVcmS2O/y6da210//5pzgsh5sevUPEiUxbgwTf4FaB5Rr9BtyGWWlvAY4
	 xeVvwd8G2CTHjG6zid+8IY4HjCPQVbj4OWLQRqJzjro/k9iY2yiIiMrqarJuk09cLRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qKIJ5uqdRYL0E2KypFSmmKBLWDmR1eXvzj3oXBexYBA=;
	b=t0a5E0P5QiuGqWCJhQ61yqN6qW+lBbutT38Wle5p0Os68LWm+T/wxbh6++8JcZQUHAFo
	 GmZ1oIDPy5mnOkUQb3uOL7csA83KGjyJ1wL4/6ZtmxcGVG+xrYTuwJmR7HpENiFGlEjB1
	 tlyX8vqfCej3cMtF4yUSSI6KjoM7qDouWyc01VvZuT58iOtxn4O/nD3GI/rto9bnAK3kQ
	 C3TFPf613Q6mV5IYPJtgfA2GCHvWq2L6KrEOpeyDKYrEns2wdDAmv/0L8xGtpBo6ut0r2
	 YMZS9CcPwPT/Uzpnv0oKbkeYWpVmfEpo8I5PjMRlYcMZ3Y4k59Omv16EsICG0OyabaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BTvIrXrh;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E2606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BTvIrXrh
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso31833a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792550903; x=1793155703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKIJ5uqdRYL0E2KypFSmmKBLWDmR1eXvzj3oXBexYBA=;
        b=BTvIrXrhp1VU5ae+bIutEaTCVUb3S9W/Y7jogPr7d6nALaPuvnDUoEPtfGz1lVpR/c
         L7M8FZaV/E6m3c4AEt5dtp+uhhNCcqvk6sXyhO8qG+axymP0BMFI//FGfRD6zXYV8Q7K
         lsuYGc4icbTw+1v1p6/32jAXCu/BZYhJLETgNbu2AGUK3MMAxafRkouEj3bQmS52uK4E
         EYtabuzlbJ2inzIFkIy/enfA+sxn/EChBymxc6oi21wOACIq5ydNa9L4aoUjFzHB+pb2
         sN4TJ4kjT0OGbbA+WTMTI+pDzA2+5Gxh+bTeJe6YaZQ8D1aWQG0GkeoBp8tjsYyuARDd
         +/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550903; x=1793155703;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKIJ5uqdRYL0E2KypFSmmKBLWDmR1eXvzj3oXBexYBA=;
        b=FpbTdFYiSXtNrsGFDEJf5qdPZ+LsCFGTdDuFoBl2f+TtpMJ4MyP0g0PqeF48++MoUM
         CzKzdhD6eh7Y/sLdmckUfUh674jXSlmG+xfcS9QgHvVl3n7+i1kZu7H4ihTGC03uzVlx
         Oarl7fEX++92OGcNJy6wUB4vC/VqrLJ1Ba0y2YgysKx0mO6bxrcrUK5EOPIhNWmgKcLh
         MBiebXGUu+Zyh7lQjUWyPzFwrseDgtuU3XV4iu/u2Oxbl2r//TJ+M8qM/dNwBrnYIhm/
         +roEG5XkPc53C+u72lcCgBh9T0UKiQJzltt2Xn8pXkk9eFFOvV1oy2Su9HXTA8pZBiNc
         ITUQ==
X-Gm-Message-State: AFq9FYKVaWTCBly5Gr9K5Xx0wfvKYqeUZPA/90yrvzdfXr7xfPuPEk57
	x7faYKDPvybYssGcKqu/dEen6bcm2xALF5UkBwsehKQgWTLRnhTVtLOl7prwPYzsQ0FjmYt75ys
	JByhh2c8=
X-Gm-Gg: AYBFou03ubFKiqT63NhxBpP2YJwebaWEJnXtjVd/PDqZKvTrA0deoVNsxMQ4oBDat/Q
	nX7zlhUnXZBbCG/9PLKclt3GqzFDQbCzfO4k33zuAjQPa5A3aJZtmLojQbtA2nAGQKOhgSmg6jR
	uZhI536kZMG2F+ittMLA+JtGqbcINaMs+L44jboLPbmslX73UNfQN5acIOSLdFRQJa2lU0vKgSX
	Y1E/2aEashT6dhnWDwRlY14kwYZrWGjBpakNDuRKWXtIYrEhxTlVUrtDtWziiVacIOBTdHhpA+7
	dEyYavtLqd9MPZ4A7ppJwvY/We/leiO5G8dCCdBlVdh9GkUJjDyWYAK1WGwkGtxTSWM9OL9m1Be
	4E0BuVqe9Uq0Y0jp1mXhzLjs8vbXqw3UX1N/527qFkbMvipzLdbLByetZh3zLj76GQKmlM+YBjA
	iYcV0aZjc2I8+xqvLyaZbW6d5x9Mh4jXzxrO8r1j3F6j5m2dlyrjnjGBias5/l5AecRMd3yhXhW
	irBFmQg10PHAIZItnWqimnjd2jrMB0bzPFVUMfQWgVeiBE5/Lm3nkS6yw1/p015C2rBOZfs3169
	96ZYDju1D3RBzaaEnaimeQ==
X-Received: by 2002:a05:6a21:62c4:b0:3e2:b44:48f6 with SMTP id adf61e73a8af0-3e287de4116mr635059637.43.1792550902860;
        Tue, 20 Oct 2026 19:48:22 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933ca1dsm266478b3a.4.2026.10.20.19.48.21
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:48:22 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:48:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUCE] iproute2 7.3 release
Message-ID: <20261020194820.5c9fbfb8@phoenix.local>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is the regular release of iproute2 corresponding to the 7.3 kernel.

Highlights this cycle:
 * ip link details now show DPLL pin information
 * ip supports OVPN device mode
 * bonding gained lacp_strict support and fixes LACP partner port
   state display
 * SRv6 encap routes support the lookup attribute
 * nexthop supports fdb destination port
 * devlink param show/set supports u64-array values
 * rdma displays resource limits in curr/max format
 * ss no longer displays dccp sockets and fixes vsock port filter
 * ipmaddr uses RTM_GETMULTICAST to list multicast addresses
 * build fixes for Gcc-17 warnings and several memory leak fixes

Expected in next cycle:
 * Bug fixes for Anthropic Open Source Scanner
 

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.3.0.tar.gz

Repository for current release:
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Aman Sharma (1):
      man: ip-route: document uid parameter for route get

Andrea Mayer (2):
      seg6: add support for lookup attribute in SRv6 encap routes
      seg6: man: document the lookup attribute for SRv6 encap routes

Dave Seddon (3):
      iplink_bond_slave: read ad_partner_oper_port_state as u16
      testsuite: fix test_on_not on multi-line output
      testsuite: add bond slave LACP port state test

David Ahern (3):
      Update kernel headers
      Update kernel headers
      Update kernel headers

Ivan Vecera (1):
      ip: display DPLL pin information in link details

Jack Ma (1):
      ip nexthop: support fdb destination port

Louis Scalbert (1):
      ip/bond: add lacp_strict support

Luigi Leonardi (2):
      ss: widen sockstat lport/rport to long
      ss: fix vsock port filter

Marco Baffo (1):
      ip: add OVPN device mode support

Mohammad abu saleh (2):
      ip: remove redundant human-readable option match
      lib: fix memory leak in getcmdline()

Prabhakar Pujeri (1):
      u32: fix IPv6 port match pretty printing

Prijesh Patel (1):
      man: ip-route: document tcp_usec_ts route feature

Ratheesh Kannoth (2):
      devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
      devlink: support u64-array values in devlink param show/set

Stephen Hemminger (8):
      uapi: update from 7.3 merge
      json_print: fix Gcc-17 warnings
      lib: fix warning from ll_addr_a2n
      tc/f_u32: fix const strchr() warning
      iplink/can: fix format string warnings
      uapi: update magic.h
      lib: fix leak on realloc() failure
      v7.3.0

Tao Cui (2):
      rdma: update uapi headers
      rdma: display resource limits in curr/max format

Yafang Shao (1):
      ss: stop displaying dccp sockets

Yuyang Huang (1):
      ipmaddr: use RTM_GETMULTICAST to list multicast addresses
