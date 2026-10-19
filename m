Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437105;
	b=W5+erGNLk/2vsPUo9yYDPWPOpitikQt7kYyc5dwjuMztu7dxxzwxbzlslKXStWWSyId1
	 g3WUroH9lHgWwZwqt1/JK0laU7gElcJnn8Kc2SRc/V8YE05kJS0kqmO0qOAIkI5uCiAR5
	 5rBBwBCtvZtrNEAJBJ6w4vdP7hFO/ibwBJBVAV2dEAkz3u8yYdstUkttQA96grd41iEbP
	 koL/a3he29n1QIk6WLl5PfdR7Psd53RP16mfFxbZAtqimdGbVCQgp39d9NJJQuK8AfT2Y
	 w0myFoeuWo56fpraWmyCQjajQlKVFkYw0Fk9yCb740zg+2c5ri9F1fAkUDkikUBoZVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bfu/wzBZOsGQROFqB89zmnlzWOzuKkO4kCy6zSciy6s=;
	b=5hHb1Zl7S0GRlafWeVFTj8z/1tn4GhoLOnZAzYE6D7hUd9L6iYU9o4gj2QeT74V5/JLG
	 l+KGVRPRFkn6QLPPEtU+zqCA91WtBZeCe40qcjDK+qc7ljby/mrEPrSi3+EBmtAkDkSD/
	 l038qx5fJv8CX/OPVeVUWagxe0tKnFIIXDLBCmyxT1CYlsRMyztO5zBM3FIdd1aK4NDoL
	 /g4kzq3MigvGG1ZvSHpYdJzLXKWhN4pSLNNKH0bjLlSV3pbDzds9wUWEizlj8BWFCH6/t
	 ZUzr6mU4GAR57SCPRXud+ntRZgNN8Fv+RCKhs0haWugm2jsCw1Eu1SEBGZDJe4Tz0Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XpDAIt6e;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12850606A31D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 19:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12850606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XpDAIt6e
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1480594f8f.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437103; x=1793041903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfu/wzBZOsGQROFqB89zmnlzWOzuKkO4kCy6zSciy6s=;
        b=XpDAIt6eUfJWGLow8UDURl/6Vo2Cj3WZD4dJyjI6jcLAY2cV0oAkJoN3+5XBj9gNX1
         bvhVIG6VCbvbxn0F+dn0iM4i6+Z+++ACygE+HDoruySjNvgLSbwvda/qkoA4zalO/EjU
         cYrR9/MgMPbJpii+jtpOxmirXSZ0F9fJmiA4i87+FLWHUteIQ5KSn0FZSXwDGuh8+9wJ
         639xTApG7UnoshmRPEgZ0PlwdmMliDp8bOZL7XQ/KbbIgCJg/ixhB4TRfC1RWsaJ6L4D
         c0AEdFXDYAIZ0Emz8O+KX6ycttalJ8+/yBPXLw7VNj8OlboIyRKI1dtWV74masGXelMF
         q4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437103; x=1793041903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfu/wzBZOsGQROFqB89zmnlzWOzuKkO4kCy6zSciy6s=;
        b=beLrmeoPKG1V3HvTCZhlaze3r9IxcM6cMDnij6GbSde+vZKVKR2D1QRX+kJ6xKAdaG
         fBjRA/LHAJbV+/GMLlH5qlOg7pKaNq7yVj39h//+tuYpIhJIriRjhNBEy7xynOWhgR4q
         20Ub3v9plIesRqyr5mO7M2P6zwmI8azPxdEVtgljXgF9b2R0b2SR+KxNKIY/suOP1DbY
         jshrRTEsgbX3c2fdh9MoByxBcCn9mlOX/M59amejJTg85lfeJPm3NwInPZFoifILOV6/
         zqlSCL5twdR+q2WqqxGQXvgQoPyuPaoVNlz0C+puC+uaP/EOuOOBPqEtflxhDVln0tJh
         0m5w==
X-Forwarded-Encrypted: i=1; AKwUvBxhNn7Yfs0paxuBomU7175WBaCf37MqQ2LqgXA6kk8W57Zs9eEbtXfKcrakZSE3pbyHT+cHwkg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIau0IXAfHNtxC97zZVYouEVAY/RnftnxxiAfZ5dCYLxOuQetT5
	Cz+tIdE+QPpLDn38S2a96vxOZtqn6M0nKqp1z1pkz9lILsVGeoKUWhzQ
X-Gm-Gg: AYBFou36TMVl6a907zgxI8w9lz3DAtKf6RElMBlLsmW0sZ9No+xz8R9/TwkYG8NrI7u
	C89dBkr9ESWh46oMfNS3mj/ByUSPL6AzU6UEdXQbC6udYaC4v/0vKCZAS6kGGaH0j81mu5t3G7g
	7ldRLSxMxM5I+PN387HkpS4PKfsINhJfDsX1M2d2epH8V2k7JBSBOvnf0Jkwx7p4gLy7MJwNhye
	E+fbCqgdeQV5MUdEacPSIgMoUWRGUqKf72W9Za2YJCdIHkItrMRpqwrgzrLJb8k4WdjG78PIvYL
	plwjDT05/hiTvEU4Ha8XSxClFvZ0tnrkIOehnCNmQYBsG9ApK3igDeTsYnrgxB6aahHFROPGMEB
	aonursDta5yznBaAupmBUmh7ka3HkU+5tivTD+Lrv3UJnHDxzYcRJneNvmGvpI7QPwFL2mE5Axj
	lAwswNptRnpDjrMmUVoXXDsIvuxdlqKB/rmeB2IxrnZYCOwF8IndwrNpgHwSZ0bQebUeKR22GtH
	lMiYbmtSidS6dAkLICf
X-Received: by 2002:adf:e19a:0:b0:48e:6f:a9c1 with SMTP id ffacd0b85a97d-48e07fa6ffamr18010548f8f.54.1792437103154;
        Mon, 19 Oct 2026 12:11:43 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cd2:abb8:fed9:8342:c367:f022])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818c89sm804977f8f.32.2026.10.19.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:11:42 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: qca8k: report port statistics from the MIB
Date: Mon, 19 Oct 2026 21:11:35 +0200
Message-ID: <20261019191137.307514-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
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

qca8k has no .get_stats64, so a user port's netdev counts only what
crosses the CPU port; traffic the switch forwards in hardware never
shows up. Patch 2 reports the port counters from the switch MIB through
a delayed work, as ar9331 and rtl8365mb do. Patch 1 makes register
access safe for such a reader outside rtnl first.

Changes in v2:
- patch 1 is new: the regmap was created without locking while it
  formats register and value in its shared work_buf, and an autocast
  and qca8k_conduit_change() took the MIB and management mutexes in
  opposite orders (netdev AI review)
- read the MIB with one autocast request for all ports when the
  management path is up, register reads only as the fallback, only for
  ports with link (Christian)
- index ar8327_mib[] by an enum instead of a second table of offsets,
  share the register reads with qca8k_get_ethtool_stats() (Christian)
- MIB instead of STATS in the names, interval define in qca8k.h, one
  spinlock for the cached counters (Christian)
- stop the work on shutdown and suspend, init it in probe; keep the
  user port's tstats if the MIB did not come up; read the high word of
  a 64-bit counter around the low one and drop a 64-bit sample that
  goes backwards; take the FCS off the byte counters (netdev AI review)

On the FCS: on the CPU port of the B3000, with an 802.1Q tag on the
link, the maximum-size frames (1518 bytes without the FCS) land in
RxMaxByte, so the size buckets count the FCS; the CPU port's
RxGoodByte also matches the conduit GMAC's MMC octet counter byte for
byte. Please correct me if the byte counters are documented otherwise.

Tested on a GL-B3000 (QCA8337, CPU port 0), three 15 s uploads over the
WAN port per case: with register reads the wan netdev's TX bytes were
TxByte less 4 bytes per frame within 0.004%; with the qca tagger, where
every read is an autocast, the counters followed TxByte within 0.002%
(measured before the FCS change). With lockdep, a tagger change and
three conduit down/up cycles with the autocast work running and
ethtool -S in a loop gave no report.

v1: https://lore.kernel.org/netdev/20261018153658.209999-1-kuncy7@gmail.com/

Stanislaw Pal (2):
  net: dsa: qca8k: serialize register access
  net: dsa: qca8k: report port statistics from the MIB

 drivers/net/dsa/qca/qca8k-8xxx.c   | 194 ++++++++++++++++++++++++++---
 drivers/net/dsa/qca/qca8k-common.c | 137 ++++++++++++--------
 drivers/net/dsa/qca/qca8k.h        |  72 ++++++++++-
 3 files changed, 332 insertions(+), 71 deletions(-)


base-commit: d1241cdbbcf7bfac3e53482b2054504628f9f047
-- 
2.43.0

