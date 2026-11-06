Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964635;
	b=kF34U+QuwdnD4q8RygcS7f+obitqAfHZRxBD7Vwyk7BeWC9UMgH3AWvhaGHEr2KizM38
	 UqqhJFE3lYmuUuQkO4rxfw6APJ0JlMPjsmQqBXv2Bute8xUISZMxy8q5EOuFhEX0SUrzi
	 wTP0/y0035digOB5/QerE5lehtJDQ/LkByij6zIAfSXoFsdb6mTcezHV0cgwGG4hqojg4
	 sw6AouaK/93fYUTVPm5CIiNmiavGAGbSUCTi78PYugsAQZCosGiUwfgN9ilJj8RM2IatR
	 woDjEBmstBeO+E4F4y489+MiiNcSmdgyrbmwwQPdxR3gT2VVO0IoUaBJaFZ/uFxEqsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=KN9/ub/FctDy2gJbqeBK1tq1ZA+4dJOgZ+Bt8XtgxKo=;
	b=LqkrR5/2rUDFmodDHCoDr5AbQt32/Tbu3OGGOhDBtoy6D/HWZrprDcnl3pqXSmUbdH+Z
	 iYop7HzvNM4EhtxiFBTWAxw5L9edlENHSsZG+SeUn4AuVYQADq0wrVmcEVdcWSTrt/uVi
	 CF5wjpMIiN2wjx4hkSSzmbmoYfTiwc9jDlwhA1TunvmgYArEl1U3/qXl46fQ5ca96Frmy
	 rhbKdsh+tbGqStYlJJbF2zfuPSHG6XJ4vL29VsLXdZwMGQM2Q/IVBWYr3bdH0ntfSM56k
	 YmxCi8GY66TC+FFvxXPgwk9rqdJRz3Tn62ylPIro416ZRHt4TmrH6Q6UOL2y1iwwxxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qznd+T2f;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E656082BCA
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E656082BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qznd+T2f
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679965fb848so505780d50.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964633; x=1794569433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KN9/ub/FctDy2gJbqeBK1tq1ZA+4dJOgZ+Bt8XtgxKo=;
        b=qznd+T2fMgYM6P0YG6K8I4IBFIbJQagR2enWIAqirBA/y6zx0W1O5x1SiddBQsCgiW
         vZmujEcZx1Yd6CMzPwFDb93J6nvR16hmXYXBHEkJhAxz88YpDuowUO/PdEiEj3G0OxO9
         Uf1t0lkcmbIvpsAhpI9ds8eIbITLOFcmInDLty+rt40xtYOOZlekp96poSQANARodzLm
         n+/95xaZmPRaTAxerjr6hHBBVKPx1aqejUGIsi2p3SEmjwA2R1vd6X/kHYeUVk556J0i
         SbhrQzwA5Lc8ROuotwRKVc81RDUvRzVKGxLP961pf0/hZEy7LI8mlvaCPIh37SCW9GFF
         Do9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964633; x=1794569433;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KN9/ub/FctDy2gJbqeBK1tq1ZA+4dJOgZ+Bt8XtgxKo=;
        b=UKvlPJSDX0kA9xLjaS04AhU4gtKiJPehv4PMa+xk/tl3fXdHeaYKKPyXHFDNlkSrgx
         uYqZT0NK8cuN/YE2LuRfO03j6ZZBmqv3srNL2qb4tolX+RuuapQOqA7055FLaA0hYcHR
         LF9K5/tf4xsTIwC8vM+w4MmP2m7b0LwRBdarEiYUxvOu9QJE6GSpuzfG3T3IKUYBwz+5
         A0LujxuelDq1tAOc1eZiADWLoei+4yyeZh8T2nCKWRkaLd6QXEPa/9wjt/zEvY45WLU8
         nOdBtg0LSZOzrQw29xn9B32reFyCEFa0thha6o7YXqRIG5b4nnzAJM8FEctX09KaBUGs
         xyHA==
X-Gm-Message-State: APuU4Z9/rhQMDhquiBFzHfbvwP0jWlcaII92UFsano3ze0XSe1pVU7p0
	rz9pgrmBTXGfkxvqEzyBLGqWBIAJqxnNxc6erspDnZPsM+iNXyvtL6p5
X-Gm-Gg: AYBFou3s+1FcJCRhf4ajRVM9VyyAvaoCSvqAHLVLjPMuPIM98JkNIeQBzlWVz8cBbWp
	QfeBtzDBSTjuDm2Radj2WMUx1DL9D0KMbwsdH+30UgABGuhyDBgaaNxI6dJrg4jiDRG+MAmfpd5
	vaFvdn9WjbNN5aaiF7l9Lx5EpeDoFOBxp8rdHFkDVC0HRM0+01kbYDfCbWC+LslQsBmWh0dTdjV
	TX/wec87r2XMbVK5XLNgYv8pQ5y2hF63k0coxICfDZae6bKn7uiWEIN6gZjh7oaqovLKm/brj8H
	vqSQYv1kIsnapA1gPhXopnegND33X/BOC3KBRDDLHFQLDagevtXT59CrJ2DDlA215OxqicCu9V5
	ihH3YWEPxLZkn98CxQCi/jeH3BZS2kU2xrYxi31K8Cj/mUPAIcwLAseHWCyC6i0RoFHA1TcDx72
	xSv1Tx8asI8CvV/uyRrW+FQt8HW2WGGD7MTDdy0diMuv7jOZG3oeVuyg0qvcQbdcvFGLu4tUQ/o
	FtmbVvu2TcVCiSnkvajJA2VnYp3kEPpeuFw9VAfw7NKY2BG0z7eliy6yAQB2rS7uS5O6zNI4zzF
	t/IEgtxUZf4d56UqM4Ie6Mqq0Q==
X-Received: by 2002:a05:690e:1186:b0:67a:2ca2:8a39 with SMTP id 956f58d0204a3-67c14073c55mr1001612d50.3.1793964633238;
        Fri, 06 Nov 2026 03:30:33 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c131664c4sm1764604d50.0.2026.11.06.03.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:30:32 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next 0/6] eth: mpnic: checksum and segmentation
 offloads
Date: Fri, 06 Nov 2026 03:30:04 -0800
Message-Id: <20261106-mpnic-lso-v1-0-e943ff1493e4@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIADy67WoC/x3M2wpAQBRG4VfRvrbLjEN4Fblw+LGLTTOSknc3u
 fxqtR7ycAJPdfSQwyVedg0wcUTD0ukMljGYbGILYxLL26Ey8Op3NlWHPi2RF1lJoT8cJrn/V0O
 KkxX3Se37fnwsQKRlAAAA
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
Daniel Zahka (6):
      eth: mpnic: Tx checksum offload
      eth: mpnic: Rx checksum offload
      eth: mpnic: TCP segmentation offload
      eth: mpnic: UDP segmentation offload
      eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation
      eth: mpnic: add GSO_PARTIAL for other tunnels

 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  41 +++++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   |  14 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  43 ++++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |   6 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 235 ++++++++++++++++++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |   9 +
 6 files changed, 346 insertions(+), 2 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20261102-mpnic-lso-19aeb38e5648

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

