Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434708;
	b=gOo6g+DNyyi3zgDbBfXs+KcIZX1pbD4Ijfotf2fYdpod0o+tazpBvwPoUOEbZSFLo8Wf
	 ORz/TYO8DD36m4RS1kJLp5kI3EvdQpn+yNu5x/nk02ef6IqBoipePAo2jyseGlc+k5QQP
	 si3Xe/thGSPCwWflkvHFAFtjBsfWhmoZqpAkkxn1lUnItxhmbvPwR57G3+eDi6/ttmNsY
	 nePgelCM7kX93hC7xuR9XvsjmptZDOGA6LPI/334BQNXnSYfMkT0Wfw3rC1rkG5CBDvKp
	 Tq08phra55KLZd7IR3/2DCX0P4bpF4Nea3tJ6b6uVlmZczkwyYHjt0rIzIKC4E5pyPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434708;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PvblXadRWi0Q+UmojTydH2DTtFuMXbJ1m5iPN2mwmmQ=;
	b=Pc8LDU87EVQfMm2oyWn5ON4xnOPwfYgpmCQ6hyjm+LytrWHh11Y6CAU/xxbKnXM42nVO
	 nOAlFNg2TeTfH5XtGvuKp41rQcwJKofis8ec2SufRITW6/jMqcrKUEIDVY1UEBvcfl1n8
	 dPX6tkHi1hC4mqCUi3HaV1GM6zb+Yk/2sKgjtZnwuGu3PKG8MQXqBFzHYMXYe5ffYuoRV
	 JhQH3KEEt89wkm+A1x2xWnNgQIX7PrFukPEIYa1xHHcDfJ/HGuv0/qKhmQKvcWVvrTFSf
	 eIx6CoaY8U3SkRAMcbE+bFCVQ1CJpzbHTiACrabGMkNu4OmbVHGe3WgkcSQH8XM9Sug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=EcoXWcE5;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F88606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54F88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=EcoXWcE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793434697;
	bh=PvblXadRWi0Q+UmojTydH2DTtFuMXbJ1m5iPN2mwmmQ=;
	h=From:To:Cc:Subject:Date;
	b=EcoXWcE5OyOurUinCo+estz+0bGGv9vIFUf7hGeTDOijHCY04x61qL4xe3ncKAmX6
	 w/8Xeq9fCwUfRzDPZ4vmb0pziIsG4ikXT2VDskmKvkhjcF/ubrr391K3qAyOivh73r
	 sTMOWY+945FqZgCFg+aGxxYnuuoxX+WCXyiezkFQ=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:751b:856d:f57c:9109])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 48E960B1; Sat, 31 Oct 2026 16:18:14 +0800
X-QQ-mid: xmsmtpt1793434694tbnof98l5
Message-ID: <tencent_4510E934B092EFBACA56C572150338051B06@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlC0LHBrr8SMqiM3b6G0QCSEV8Nqi1ycgbA04DW3mW/8bF2ihCN8
	 ImnTgttODHvltcYHwu7pRnkVrJjJAdn+pKACQ/IErlSFn5SSBI5fwmxYbzBekBsfeFESnb6Fm7YN
	 /AFhVVXJKvB+ExqO+FU5t0T5dqfisgEpBQSiFn1bqHCyZ5CA+XnI95iKdUYO9JCo4g8bEHY88yE6
	 YVN8ECp1ELG+p/4W+GO5DcBIyFM3JOy1tfcWZGR9lPmNCUQYOxTP4d3Ni4PMDOGZdTlUb5VInwhp
	 qgrq1CAriticTK2O4iQzasWwvUO6DPq6dNvo81gEKCewplwgceblflt8TMLpPuAvKb37K/sR67hl
	 AcZA5KMtTXfTe12RDEK2NWW+37eBysNcZpy+SjnrTFLJk/ypUsYkKTEEaoezcgzxSKToOhG1x8oh
	 1QrxDWnPupMen732g7oUIG0IzZ0RNEo518U7SRNjIR0pDHRK7ruM9dJ1VSluOk+SONhdlW3xLR5l
	 GTPh7cJDcYYOpI3+e62ct/4RNXwfaHTovOCDQS65AQ7M59iANFTtCPSUZ7M6UIhpNKutAtc3qwOW
	 CC0NT9e6wdAaQ7kESHjP6OpnEbijrlJabKfdYDv+pjZ5ynWUC+gI+8n3fx5cWq8FFvt4JKNa6dKg
	 EJp8Bc8LnSMXTOdGVzHUdBVrRtpARNlnVdpSWW9BEjh3JIRu76Ntr6uyq8exWzH8ZSwrIi9bhJSq
	 5pwywVnebZYfFb9BPkEuHwQ1BQHi/zsSBlSmj9PG4FgisPjw4IyVqqspghLAQOyx0iLBavWPhh9m
	 qBz40AKaFePVqePG2rQlp1SoH1+ZjvdsqbUKsO2g/fuRhD4WuShwVFka6eHaUN/UjEtsNYOBcp5U
	 msJGETHDYSgROgakXJVO3DM/Bgi5x5xIajMiU03gSLz8sTmuIsZiUAIqhHC6YrqXKuCQkqYU1JIQ
	 LJ/dUQHNPbv8wGuSbJaz+5EByAnmcTt3i4ZA6coguO2uTZKFzscOSho5HeeRvsHpb9NxdFEcFHsE
	 DGtq4YXlWB4S1sLgXZVJ/WaShSl3y/sYqB9J+/IbdRmnbEOd5wB6so+ND7uOU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 0/3] net: dsa: mxl862xx: bound FDB dump walk and validate BRIDGE_ALLOC ids
Date: Sat, 31 Oct 2026 16:18:10 +0800
X-OQ-MSGID: <20261031081813.64518-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Zhang Hewei <memoriaru@foxmail.com>

Hello,

v4 of the mxl862xx robustness fixes, rebased onto the current net tree
and extended after the sashiko review of v3.

The v2 series did not apply because it carried full copies of
mxl862xx-api.h and mxl862xx.h predating the upstream restructure into
mxl862xx-host.c / mxl862xx-phylink.c; v3 re-ported the two fixes onto
the restructured driver. This version adds a third patch for the
firmware-result handling that the sashiko review of v3 flagged.

New in v4 (patch 3): MXL862XX_API_READ() returns the firmware result
value (>= 0) on success rather than an errno, so a CRC-valid firmware
status of 1..1023 comes back as a positive value that passes
"if (ret)" guards. The ALLOC-style call sites (QOS_METERALLOC,
EXTENDEDVLAN_ALLOC, VLANFILTER_ALLOC) tested the result with
"if (ret) return ret;" and could hand a positive firmware status to
callers that only check ret < 0. Patch 2 additionally splits the
transport result from the payload id inside
mxl862xx_allocate_bridge() so the bridge_id contract checks
(0 / 0xffff / in-use) run on the ret == 0 path only. The firmware
result-code semantics will be cross-checked against the GSW API
documentation; a follow-up can extend the same split to the remaining
API_READ call sites if that is preferred.

v1: https://lore.kernel.org/netdev/tencent_5A7AEC56CDB23A83120519D0C074B592C706@qq.com/
v2: https://lore.kernel.org/netdev/tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com/
v3: https://lore.kernel.org/netdev/tencent_A40150C474B4D2DDBAEA56D8B20F03130506@qq.com/

Changes since v3:
- patch 2: split transport status from the payload id in
  mxl862xx_allocate_bridge() (sashiko review: a positive firmware
  status passed "if (ret)" and was stored in priv->bridges[] by
  callers testing only ret < 0)
- new patch 3: same split at the QOS_METERALLOC / EXTENDEDVLAN_ALLOC /
  VLANFILTER_ALLOC call sites
- rebased onto net (cb284914e); no functional change to patch 1

Changes since v2:
- re-ported both fixes onto the restructured driver; dropped the
  mxl862xx-api.h / mxl862xx.h file creations

Changes since v1:
- walk limit checked after the "last" test; "conservative read limit"
  wording; BRIDGE_ALLOC validation extended to 0xffff and in-use ids;
  Fixes: tags added, self Reported-by dropped

Base-commit: cb284914e749388eef402938bdb3115fe1f6d337

Cc: Daniel Golle <daniel@makrotopia.org> (driver author)
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org

Zhang Hewei (3):
  net: dsa: mxl862xx: bound FDB dump walk with a read limit
  net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC
  net: dsa: mxl862xx: do not leak firmware result values at ALLOC call sites

 drivers/net/dsa/mxl862xx/mxl862xx.c | 81 +++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 3 deletions(-)

-- 
2.39.5 (Apple Git-154)

