Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523003;
	b=vEn1qxFRNDD76yfSzr6UTCnZECvNlbyChGn1luCoIBqLZJOB+/2iY+gdk9Jmn9ItJEqW
	 jwxtIqv1mPXHfuQLWm8R4fNnTFe0mHX5kv7l9NSs/yTHVyEZElB5fJ/+h2qRILzYNIT/u
	 kLqRdzjKUB8ys2jFXH1KoHSzSEy/8yiUcs1GMrc3/Af06L+C7eIzpfy6mKbCHKfMSgIv6
	 CVsvy1U2981WmUaVDmkaq6bcdhQ/uPV9Ti8ETapEV97cJ3cIK4RrpeoSw1C4smxW5Or7E
	 CusJBRbjPLH+4loi5yLgOIUX1Zc51vbZ3BfHgV8HfUb8IKat20Zhq1UxYBNNtPIViDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523003;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OX67+gtR1w8kI3KAmmNC3rvP5AlFBSTFkE9RrFUfYQM=;
	b=Ch1ZFBui8F3qr5Q1dK2/2qT/7RjxVd/stBBYDh1tYh+OtTkuZaH6yMs99INMJjfaivJ9
	 KEmrBzt1H+mDnn3aXlOIuk8idKr7ioF2XgMoPf6p0sYpUPHQcwyAYvcc30JZMohTQnFH3
	 5qmjFF/eaJq06EJ1CrUskmivGq0MzL4Xcp25NCMslZs18VQ1TOqZ8EKennrthmZeiUKYM
	 +ujRJXDMsaxHeBrlzSuhIQdssiygffPq4pGsSf5TT1s3R6sYgsyn5nHeK9z/nkC9ZXFwp
	 5hbG6WAJdQ8CdZqLF+vuquwDMg5u9rljFWlzt4Ra7gVkLC6HV63V0HO8teOyhU0fRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B40606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B40606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b042c0728so1145091f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523001; x=1793127801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OX67+gtR1w8kI3KAmmNC3rvP5AlFBSTFkE9RrFUfYQM=;
        b=uDMphzEGFLWfudSgHc8CSjsFCPdLkFAcKUEunEuVM/hlNve6CBb6lX7ZUaLyD4lkZP
         Op4kU4o44BOzmFtnuWwDEtVh/0eoTxXnEdmfu8CC+8vGaMP/m9mBDRJggDZ6meWpbr+Y
         zZjkDMkyQFShbnJvNFuoM9LuFJHCFm/yL+PB2x0SzkBrxtZdiEVZGC5S3H174nN3h533
         vOxYsjBi4QTJuiH09say+P4D1nzFo5svmqRR/xHpfEfvmsEzslubxtR8NlJnzpL9rCw5
         ca+K2UlZjhoO7HpSecmNePxBCfCeXG0g/lXNYl4wA2lmmBMwQNkYUyfDrxDjEva6JHAe
         ljrg==
X-Gm-Message-State: AFq9FYLbkDMKffB1cwvBJsOLZNpcf0enOd1ns0AP8ZLGVhcz1eBJnHUN
	HIpwxoZYTZqTizQBPCQgvLzEAo4Yf+nmmDfDDRnP7NkTxhWX6jd26RE029tdXtXqDbhjiYVHCzX
	5ga47/n1l3g==
X-Gm-Gg: AYBFou2wCC2pYbixnrSOOBAekX6xCcIfHoLwWPvFD1dsKGg/BGue4Eo3ui36pmIT3y5
	k92vNPFLZJMkra0DFVroKwtFgPfa91L9JItungjXkLzLzEgtVG0weo9FpcxYJCDHl1ajPkIUz/b
	NpKAHzkzC7PsbD27YgX9uZMnqGKltPFLsPuVonEtzDu9pdUFPqO6qDOqMs/WUgoTgkGuRaucOwF
	DwCO9weWbDRtm7cQ9KMOOFpJzwek9m/7kQsn/odZlQG+cequauEwxVMReJmtzI/rxBdt7ayMdYt
	OzqwZoTZ0Fc4Pi1D0sw8MYwlwn8D4/ehEu9sLVPXZlRe2z8YVZkDdA1N3x2lHyze03NGd6C4l0C
	xubReNyKGE57Nt0KCIW/x8dVw68wmIeK2S/vwhux0Dk1V4MUwPHFRRk5F+b2K4oeFzG5VuVgBBo
	LmhzyEJ6zE0ik8nbUijFItWFMnmTADSQ2SheSNedNUuYScJ0O32723BQ3ldm1FGZC4Izk=
X-Received: by 2002:a05:6000:26ca:b0:48a:f318:ac03 with SMTP id ffacd0b85a97d-48e07f98fa0mr24813037f8f.25.1792523001226;
        Tue, 20 Oct 2026 12:03:21 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:20 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>
Subject: [PATCH net 0/3] net: stmmac: deliver frames with Rx checksum errors to the stack
Date: Tue, 20 Oct 2026 21:03:15 +0200
Message-ID: <20261020190319.884375-1-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
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

On dwmac1000 the MAC drops every frame that fails Rx checksum validation
before the driver sees it. The enhanced descriptor parser would discard
such a frame even if the MAC delivered it. As a result, a VXLAN tunnel
over IPv6 with zero UDP checksums receives nothing while Rx checksum
offload is on, and neither rx_dropped nor rx_errors shows the loss.
Patches 2 and 3 deliver these frames with CHECKSUM_NONE instead, as
commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from dropping
checksum-error packets") did for dwmac4.

Patch 1 makes the AF_XDP zero-copy Rx path honour the checksum error
status. That path already receives such frames on dwmac4, and patches
2 and 3 make them reach it on dwmac1000 as well.

Tested on an Aruba AP-325 (ipq806x-gmac-dwmac) on the net tree, with
and without the series.

Not tested:

- Patch 1 was only compile-tested, as an AF_XDP zero-copy setup was not
  available.
- dwmac-loongson, which also uses dwmac1000_dma_ops.

Grische (3):
  net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
  net: stmmac: dwmac1000: don't discard frames with only a checksum
    error
  net: stmmac: dwmac1000: stop hardware from dropping checksum-error
    packets

 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c      | 9 +++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 8 +++++---
 4 files changed, 13 insertions(+), 7 deletions(-)


base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.54.0

