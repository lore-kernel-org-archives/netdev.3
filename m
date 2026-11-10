Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348405;
	b=CaES9HypyTcOR74wIH/ozR6AKEu0T8sYAEyA7uc9wVs5crBGlxNhkLRuZHZFugYD8+4d
	 cNL380JdJepOJ18CCaPgFQR4sq4DTaEbknG3p2us4YHYwWApXzI9lVNw2XKRTvacn3y6k
	 6BD1yzszTUr1PTlhjJdRiWyrpMrkv2vVkVBPWBBDFs4EonzvyWh6dJqB1juhs4r7GjcGa
	 f6/hdK6Y7cuS7HWsJQ7jMibhmfZDBipVWSxd5s/syuIrGjrDnv3+rm9bcavJtZRkM3toR
	 Bn0Wl8vvDcE4sAU8vRKTXw2vwHZGg/G3j3A0/zMCwzPko7tdPDbw4fXFC78soVr1f4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=kEjK2T6kz9YShd/Epo4oqsZZxM3NGAQxYmS9vMoCEcU=;
	b=qB1kIkodNdoiEZPOBzEt3tkC2Ot5IjffXn3UVFlLGz+G4PclaA74XAcBV8IrNDBngZ2t
	 8/h/dXcBs5xBrIn5yU4E1loasuRYDQS18vlrg4ZFDur9yftNRwfxVHxC0oqm6TCmK3/1f
	 IckspHWG7FHJVpAmPWVst9Yrg62t0cTdRvvdotQrMb2F4iMiyt9AWc88keq1UBpv2yI/c
	 GjoATzgjemqpxJ73ZkJuL26tdtLO7c22Vtz+exEVMwCwYaw7FRKCsx8O8TU8bRf9VOGqu
	 oy6BnoSvylL47baEFlBqYcujGQWc4Tz7b7bLKOhlLINdu8vaJmkLOnO8ndvB0mik9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2qLec9f;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E213606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E213606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2qLec9f
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b30ff12f84so19645377b3.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794348404; x=1794953204; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kEjK2T6kz9YShd/Epo4oqsZZxM3NGAQxYmS9vMoCEcU=;
        b=d2qLec9fBP8SI081bvzwMjw6fndX+IiRdR1eV4GVw3BAQ8Q5KVIxOBKlmf2+hpa2NB
         W6fkZUtI6ExrK+C88gyfnaQwemJnhF6hIntEXn9mLihCIuz5XyoNMV/Tc3cPyrtLmONN
         STrE1tW15TQ0gYcKrpQNYJLWov/Vh7zQDDPA09tIf3TSMDLNTkkLQeb3kcRkjDsXP0l8
         ELcUEePMKD9gFxoPR+fIYLhoNYXP9ghJq5Js9+yQrqyiG52vOMplCA3zsPlLVQGdLqH9
         NSs9RoZngg+2YQbTS7QH8ySIoAFfVVUzA8M7gmotFkJ/PFfksO2ICOaDKiNfzoAKy0b2
         7gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348404; x=1794953204;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kEjK2T6kz9YShd/Epo4oqsZZxM3NGAQxYmS9vMoCEcU=;
        b=VsAXkiOJWOKXNol18mluEY8jUkpiGFNiVOfpi50bBQy7Rr4EE2IfqOkgtBkmuhx2R7
         CAiHos2ZDPCN42VnjtaeUxhpYVyupfxECeXSNMKiLy8yff/bSmJ/kpsyApKNHsb6FvQ7
         8Q/OcdTdZntkMgcFbQs2FyiFkKXZa1PbTdBzcpc2sKusyYQzo+omohEauD2WyiPRQsQ3
         7oa8uK3zIznYORu7j/HmyyDmJUMtaWMw8lUxEqSSn1Yy5npw4Hspn9yySxk3mBHn1JiT
         O/PcadQBCV3xR4DLJWFQ2H9rox/olrI3ce+kXHTPIB0zm6877eFuhdcD4Yj4gzq41Isn
         g+uw==
X-Gm-Message-State: APuU4Z972BNDCYm8Bxy76mFQKFYL4zGiyVuKzc2sFg9EXWcZ44Y/7kWB
	Q55nIqib6OxnN5kwFuPMsO6POlc396cRagmTIUVfPArbljVJFcdu/j/v
X-Gm-Gg: AYBFou0byYC0B+hIh0gPysgI98hdgReKtJEZ+kJpZbx/eunww3vhbF0E4oeEwcnmXm6
	4dzGshHzAUj0X3CPpSb/Pj3YDxA7i8T/BGOd3zaq9KRGvHwSkE0hZEwTy5JGCMyAiBQ11abRXXK
	+yMWBCgUs1QiS8xpJRAfC9K3c4kFP7UIjZjqOdjrMOvhGWV13QYeMRRwsB5Y/qAGfZl/Z6p96W8
	l30sDFDuN6HY9ATddBKjPwG2cyjSCGB5QHarNINhX/g75/4aGOG8ad4WjhE+M3/7a4Bb8YO9H+F
	5Vrt2Ha+YZMjco4JqQXBn+yRXpyj4AjvNi0zIhd8/W1TmFzAGsEahe/QsuAAh+bqsh9PZv6EJrV
	pc7BwvTpw0yS1LUAUHjBJAamosOGbV38jOxS0LsVtQaFH9Woak5S0i2hNG+NPQRBSkx2u3Qyf7M
	5m2Dn0sO7ATIUSVz3W6ULjtpD3AuutztlS1mZzRE0PzFDGswWeZNlQWvRXZ44TTUDSqzLnOPerm
	Tdowd1jZ7Xj7VLv1Ezpakgnk8V14mRz2w2eEl3MUX+TcvrzTTn1g07ytEyBihNifsfTwWWcX9C2
	NsOmWHDvaGvWDzfUDBjbpofLCA==
X-Received: by 2002:a05:690c:38b:b0:8b0:c71d:2b2b with SMTP id 00721157ae682-8b3a8209ea8mr5614887b3.45.1794348404380;
        Tue, 10 Nov 2026 14:06:44 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39339cc9dsm30081607b3.8.2026.11.10.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:06:43 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next v2 0/6] eth: mpnic: checksum and segmentation
 offloads
Date: Tue, 10 Nov 2026 14:06:33 -0800
Message-Id: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGqV82oC/02NywqDMBBFf0Vm3SnmUTFd9T+Ki9SOOqCJJEEsk
 n9vkC66PJzLuQdECkwR7tUBgTaO7F0Beamgn6wbCfldGGQtGyFqicvquMc5ehTG0ku1dGt0C2W
 /Bhp4P1tPcJTQ0Z6gK2bimHz4nCebOP2v1/z1NoE1ktFqGIQ2ivRjXCzP194v0OWcv5bOg6GsA
 AAA
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Add checksum and segmentation offload support. Tx checksum offload
follows the generic csum_start/csum_offset model. Rx checksum also
follows the normal unnecessary/complete model. The device can validate l4
checksums for tcp or udp, when the l3 type is one of: ipv4, ipv6,
ipv4-in-ipv6, or ipv6-in-ipv6. The full l2 checksum of a frame is always
passed to driver via a Rx completion descriptor field, which can be used
for checksum complete on other packet types.

Tx segmentation supports tcp or udp in ipv4, ipv6, 4-in-6, or 6-in-6
natively, and can support most other tunnels with GSO_PARTIAL.

Counters for CSO/LSO are exported via the netdev qstats API.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- eth: mpnic: Tx checksum offload
  - use skb_network_offset() for the L2 header length in
    mpnic_features_check(), since the mac header is not yet set when
    called from the IP GSO slow path
  - also enable Tx checksum offload for encapsulated packets via
    hw_enc_features (moved from the IPv4 and IPv6 in IPv6 patch)
- eth: mpnic: Rx checksum offload
  - convert l2_csum with cpu_to_le16() before csum_unfold(), since the
    device reports it in network byte order and skb->csum was wrong on
    big-endian hosts
- eth: mpnic: TCP segmentation offload
  - count discarded skbs rather than segments in twq.dropped, matching
    the xmit error path and the core's tx_dropped
  - report only hw_gso_wire_packets; drop the super-packet counter
- eth: mpnic: UDP segmentation offload
  - fall back to SW GSO for skbs shorter than MPNIC_MIN_FRAME_LEN, since
    HW LSO would segment the zero padding as payload
- eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation
  - derive inner L3 header length from csum_start rather than
    inner_transport_header, which can be stale for DODGY skbs
  - check the outer header is IPv6 in mpnic_ipxip6_gso_ok(), since
    SKB_GSO_IPXIP6 can be set by a nested tunnel under an IPv4 outer
  - move hw_enc_features setup to the Tx checksum offload patch
- eth: mpnic: add GSO_PARTIAL for other tunnels
  - derive the L3 header length from csum_start rather than
    inner_transport_header, matching mpnic_features_check() and
    mpnic_tx_lso()
- Link to v1: https://lore.kernel.org/r/20261106-mpnic-lso-v1-0-e943ff1493e4@gmail.com

---
Daniel Zahka (6):
      eth: mpnic: Tx checksum offload
      eth: mpnic: Rx checksum offload
      eth: mpnic: TCP segmentation offload
      eth: mpnic: UDP segmentation offload
      eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation
      eth: mpnic: add GSO_PARTIAL for other tunnels

 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  41 +++++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   |  14 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  40 +++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |   5 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 242 ++++++++++++++++++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |   8 +
 6 files changed, 346 insertions(+), 4 deletions(-)
---
base-commit: 97ced2c090bfc2156db31fca9f52cf253e4bc186
change-id: 20261102-mpnic-lso-19aeb38e5648

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

