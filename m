Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231471;
	b=WQQ3iG7x4e5glqyzLX0NnJqcGmY5Xz6ZDPy2g3RbvwTjeLW8n/mRCwJmvxkZDKl5Yuef
	 dZMW7x+0g9VOeik0dxdeaww7aKKbMOHTwcuXx3jS3j9NRn21qxSU3MoeVYaG2KAT0VBNK
	 cK42wfx5lYzY90wiR1WrDLAahcM/tjVOYQPMMDMLPWvxzU92/lVm8tLlbq3NaLxRt+ENO
	 3XG7q6gQj7eR2c8vxyMxEEcUjjHVLt1lKak6M4jYMdbQ4OBJM6CT7c0c24Lhqjs6qveHd
	 /28aXeZdeEETCI9SgNaNLLZYzeHMbUep0gXHjVbnf0IOwAyE55GuyEnd81MuWVE/vdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231471;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=lgFFymOVFSBRHf7/adfIU8nmoW/OAqhrDRgNC52A1Jw=;
	b=O//w8+igYqphdnPu7hP/YGCWRXHIeHzcGksgWprGznKHPSUsQd28+KkEYrDPZXmlv+Kx
	 Y1NPLfa8FpMXJPWES5CoT4WB2KsWiYSrgPG9ZhQ7azC/OdRIxRUZZ21ZLW3ye6UPcqrqA
	 Rj8OuHlHTz+EOC78xYM6//vYkW336+fcVdZLYL9RsWsLFEh+wqdXlepkI9WKJHXCEO13b
	 F0THcXmR2xHWXdXu7TmZDZuj1M5wRbSHK/yP+1kAXymt3gH4yjk5MYSGspWOOyZIo+5KC
	 +klJ0sxlGd42tqekmgdFOHSOunrfFGs7in0VegR3Pmf2b1qK3lGs9pgL5qqhvfp+xHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BN36Fgzq;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFA606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BN36Fgzq
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd69954c755so1121097a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231470; x=1793836270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lgFFymOVFSBRHf7/adfIU8nmoW/OAqhrDRgNC52A1Jw=;
        b=MIrtYdnf77dl/q0Vuzd9ylsIlpMpaU7+dsBI8xtj0KZONkRrPCxm90N9hR8Y+iV5wO
         dow6nsWlqfU74lK303Ynm2U+G7e+PuEyV1hpD+gwaR69yrullWGg7nVjsHjS99SGCLu0
         qn6pb3o3gf3kIliiTXsWy27d8ivs07WIYwCKwa6G+NyHbEXU5GlK27Z/LsjjduUV5MMJ
         ynoZrNWsftEzYM4I3cMqfQ547jZRXfbItW3LK9/svO9o3R6t+7ZUjeq1fRmWJWnbglVP
         yHTGmtCC37YyqLdx2zv5IjnSZqjqxLF6eMDHwRLXZDXL25kBJtlNt//A8Yt+XzDePbvd
         hk9Q==
X-Gm-Message-State: AFq9FYKrSoiJRvnhYZRz52JNefoPs7DeF5SmEy7wTU16eSmopr02pGMm
	qgPrQbDQr5pScy0chFcG9i2UTHGJeQni0QOIk4ax/MBF5IecOg0KFvkkcaYb1ZyazmWwwFgMjdr
	i2itdMCSLIwY6Afw3nWWzoavFdGon3VRiqF6FgunWyLYlvJLNxcmoh5QynF2oeBJmpffXq86kja
	urxv5LhoANcoYJMpgAcMmFyJ4ohQBUhCcLE9SgVzIStNoeozhCREEQ1GIfWiAc9lYa7ntZX4jnX
	GH6rVksvgWWct5y
X-Gm-Gg: AYBFou0rAUAJLlIjvmgNFIi0X2gs9LeV5QVlOEoy3AymMGsSqJng4c3tfEHfmzR22sO
	5bAW5K8MMIE00izC14BTpV4pbRupDP6rQIVwqjZAhvYOm9cpKoWzl92a84Hdrlfr2wj33WXbZgQ
	VKtdQ73/KCrSkpzxhG6lPuYrUBG+MbVbCyV5yABEpGf2rUj4smPcwyabF4zOkaQDQgplpnjqbPd
	JcTwy/0N85oyPXF4Hmcb6m+PBccjtBJYHMpAiU2kx9/OKoCWU1grcpDH/ULtQ5JMiiVs5C4m/8m
	YMdfKK5Z7OZs+zcJ6u6E5FTpABaqBHUor1AmOlx3tShjoZig9hK3JJM49fpAsCMp3sJFoF1XlYe
	xzkCZsLc/n5u/C8RETEVBmWai0vKMRBl7C4IvoIWnmdbrv9COp3zC6Wu2sBPpzjgMiWypqmRt0l
	9uu0HJU3RJByPhvDDxyiOCyumdSLmzwfBu8p8yJS+4
X-Received: by 2002:a17:90b:3f8c:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3ae5835d8a6mr2872309a91.59.1793231469905;
        Wed, 28 Oct 2026 16:51:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e5e5305sm752309a91.1.2026.10.28.16.51.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 16:51:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so308909385a.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793231469; x=1793836269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgFFymOVFSBRHf7/adfIU8nmoW/OAqhrDRgNC52A1Jw=;
        b=BN36Fgzqmgw+/kQJi8a0iox/HGcFnBcsseqgP8GcY29Qfut0HplbsGSRrhD6qVHGFG
         aNcBzwK+JJYpz7nGhxugoEiToQekHX9UG7XHUVjJbAsukLkcrXemul3L1X4/amaYiORl
         xnHjfMw9qQBVJ9jMGYDmDsVkP2d5k8TFLSgoA=
X-Received: by 2002:a05:620a:4008:b0:939:de48:e41f with SMTP id af79cd13be357-94408c97559mr630504185a.31.1793231468762;
        Wed, 28 Oct 2026 16:51:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:939:de48:e41f with SMTP id af79cd13be357-94408c97559mr630500385a.31.1793231468280;
        Wed, 28 Oct 2026 16:51:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c84ca44e3sm23074216d6.10.2026.10.28.16.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:51:07 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 0/2] net: dsa: b53: Fix IGMP/MLD snooping
Date: Wed, 28 Oct 2026 16:50:58 -0700
Message-ID: <20261028235100.3892374-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch series fixes IGMP and MLD snooping for b53, these were found
by running multicast membership/learning tests.

Changes in v3:

- move general IGMP/MLD snooping comment to be applicable to all
  switches, move comments about zero controls where they belong
- added IGMP snooping programming for older switches, too

Changes in v2:

- export the helper and call it from bcm_sf2.c as well as spotted by
  Sashiko

Florian Fainelli (2):
  net: dsa: b53: Enable IGMP and MLD control packet CPU copies
  net: dsa: b53: Enable legacy IGMP snooping controls

 drivers/net/dsa/b53/b53_common.c | 74 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_priv.h   |  1 +
 drivers/net/dsa/b53/b53_regs.h   | 19 ++++++++
 drivers/net/dsa/bcm_sf2.c        |  5 +++
 4 files changed, 99 insertions(+)

-- 
2.53.0

