Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805559;
	b=ywZuHK90876jPo6MpgKZPJXwHFOC9WePnMOWaUQv3RfENalhW7A0JHMNCFQArnnQFb/f
	 F7w8APoNUBfThmwtRgKhK60F3bO4zp7NQMlrrW3HhRG75yuWwieE+4Me4jKxDBMGlzgPU
	 j5ZdCtqFlSdwk5Yqt4bRTzGDiqcdqJElxzrisKy1/VE6Mbwiiptcyh1VQfGaetifVZ3LM
	 UKjP90Sq3DmEsDiKi6mCbnOnziqp4e3c4rPx3iEPW1F8vJ1b9k+En5EXvlXGglr/zqsIe
	 t6fWtKOw3aGbJzIHwKVmEzdfpZMm5WMsVXNl8x9R2OIlJOvoztVKtPAXUUwR6Wr4kSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805559;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s6n+1O0vv7H3iZHusRNAoBbUxsNQKqIKFg3s49HK+Eg=;
	b=CMhthMFGPKWKx52aR5TE8U5bimdSiq/KCnwaATGT3DhqFUl31XF+AHNdDwlwPZCe7FOG
	 cxHJxccdm5y0a/YWLCjiECxw+KxlZuefF+FW0DdbKKfO8+91j2/xTHimC/wSsyuYOsYVw
	 mQ7VZ2kN7EWKg12Tu3/4ItYUpBMlNf4/HsvXPHqYynL2scew5nL03zC4Mdr4UAmEpEQIt
	 00BYAx6usr8GuXiZ4vO1RP9cCDsdtDiPJwUZG7EURpQKvLr/aaPEjDi7mGlchKGIzIdCS
	 IHkzuLgyuuD5Qq+TYiaQ5feEXyjQCN0rr9vFmBAwpUYpjd525l585DdUMUGQlEhUUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FE606D834
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A4FE606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so7578175e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805557; x=1794410357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6n+1O0vv7H3iZHusRNAoBbUxsNQKqIKFg3s49HK+Eg=;
        b=Aq5OpubaBocrFaA68Wlw4kvshCJviJYspA1tLJMn9TEQHvTAwXpnKfKC/Xp+UBDTou
         Js6t5u0t6zfvNWWxVW5KcsFyyj8W4icI1d1htRE0vGYvTASvK+6fPeXkh7Jbu/BhnWMo
         4HP/uZzzsLcg2tPrdC6KVKfyD8s2bOZmJxngIlcIcCcPdGsmlMrwlPFnOu+p6CYmBbBc
         LDlKwnRmKZ/c77mxSpcYyhWJGLZ41LrlGVhBARBkBJLRvLkwULGW8m9aJ3tTcB8Gbqoe
         Pp52lgJqSO5FR1LP5qXJjo42n4OUWqBaIe0SGJ2RsxtyBIIdeQV9+QFRAKYjKSd9JWos
         X9cQ==
X-Gm-Message-State: APuU4Z+cfRjOdcUBSu3Y66jn5Ckpztuxl3ujrlMZjJ934tLaRT0DquOf
	xKA6AaFbj6kDZwp/Nec43EzaIqeUBtRlmMk5PYqhQRI7AP0m6p/2LWufaEQknInFtIVONV8u+QM
	PzXyzDhSGWjA9
X-Gm-Gg: AYBFou1PWS37d9ZztEmkNVai39+GHsa2SnQPyT5l8V7Vys5s2L4X+7br9q9QDcFViN/
	n7+8D5pp7a03ndI33aUdDbxq0paVqec1WGEU2QUuBmIZnskl3jWYiqf/YCt+64WRiD9KXI99+va
	FuQKlELIu7uxtOCD1e2KwzeuNBXxlaLiVfJTdABxqlWgLWNYpQEfbphlksaNR8+V4dzBgyv4W3S
	bfUZsT8ocPNUP69FnaoMX8lVHlLZ9u0/+wV3RTQauWo1Y1bMHLhMtWvnxxqqZ/nkfeVl5vmU3y0
	UkOiabxdY8pTjpXiroPoX09QdtZEkLakxFMLSYOclaeDnsMD3cI/d+7fvOctFCLg301+bz3NbRG
	8TlWq1NnsD7wWZ67bWkfzbW/uQyZViOVc43mos49Gu59g45j8ZPzGmIV1F0+Du2k9R3EGnvyuhN
	StIXKWWOy+QT9l+e5uemVp4bBIZowzgPX7sd4eISW/bh9OIL4JL+KzwBNkYCgeNxyAlp8Gn46n3
	MXH23QDNysexWbqlgFv9MxXn48q5/bWoczCpfg5PkQ3AcPD60Ig3OjskHoHf0iJXi/LsuQjph3U
	zO4drneKW1K6HmjdMq+iRn56uiVNsdLefA0C+2CXY/RGXOMB
X-Received: by 2002:a05:600c:46d2:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4ac1980118cmr359849885e9.33.1793805557406;
        Wed, 04 Nov 2026 07:19:17 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:15 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>
Subject: [PATCH net v2 0/3] net: stmmac: deliver frames with Rx checksum errors to the stack
Date: Wed,  4 Nov 2026 16:19:10 +0100
Message-ID: <20261104151914.2651241-1-opensource@grische.xyz>
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
2 and 3 make them reach it on dwmac1000 as well. Patch 3 depends on
patches 1 and 2.

Tested on an Aruba AP-325 (ipq806x-gmac-dwmac) on the net tree, with
and without the series.

Not tested:

- Patch 1 was only compile-tested, as an AF_XDP zero-copy setup was not
  available.
- dwmac-loongson, which also uses dwmac1000_dma_ops.
- Cores with normal descriptors, such as Rockchip RK3288, RK3328 and
  RK3399.

Changes in v2:

- Rebase on net, where commit 834ec9530832 ("net: stmmac: drop split
  frames on AF_XDP zero-copy RX") fixed the multi-buffer issue that
  Sashiko raised in the v1 review.
- Drop RDES0_LENGTH_ERROR from the Error Summary mask in patch 2, as
  the bit does not contribute to Error Summary and the length check
  further down discards such a frame anyway.
- Explain in the commit message of patch 2 why RDES0 bit 7 is not
  treated as an L2 error.
- Set DMA_CONTROL_DT in patch 3 only with enhanced descriptors, as
  the normal descriptor parser does not report a checksum-only error.

v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/

Christian Schmidbauer (3):
  net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
  net: stmmac: dwmac1000: don't discard frames with only a checksum
    error
  net: stmmac: dwmac1000: stop hardware from dropping checksum-error
    packets

 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c      | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 8 +++++---
 4 files changed, 18 insertions(+), 7 deletions(-)


base-commit: 241dec6f9ab74d8c3ef246764f3611666b96b9e1
-- 
2.54.0

