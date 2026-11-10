Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794306012;
	b=a9QFghKLEwI90HvHHWDEEDinYFycak5ByCHF07JJeiQQXxdsfW9P+0DXf4u5JwWKPnPi
	 s7haE1yWY4qxPzR4DTpo82WW3aqHMhmB1R5S/3QZ2PGFfPwBWcVbfdKXjHCPN+6M+1C1f
	 jQoXqNo1rVTwEc2+tNuGFRKmVIZE1lh4BpN8xaH/3/QR6icfG1bX7D+RxPJBVITwqSO3V
	 nK64lMbi2qKf2guJ8fBDxqMV249QGOnv16hrhEsXebMG3DUFig201mg2U/qYQ6DeYW5VP
	 IkUnn+9eLz3RK4xHNKNL+gII1/4OpSW/pI4XiUnyJC3iwCVei5UAUCnR7XYAMjWcabg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306012;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZhakFzXWHmC22oDdbGMEayGQsS98Xx4EYQhF9ATraBQ=;
	b=tuJjX8pfxzCkzDrYIRTC1q6EPBj57hFgumxuW3NtKqm8AMnXwPZRbYfc1C+pzbU8SHFW
	 KGSqtsuXU3wv6Pdy3szjuuQMlKjPDQsqLFKKVUPaYZ84NQ/d1zyCZ+OhHeJzCHYkIeElh
	 ZRXB8prvFfSyz+ebE82B+WUZT5oGxtJtj/n0WXY/PS2oScUgymvQvGq/I0ITAMMREKbVx
	 ix4laKZ9BGupK+NuWnSAWCHbR6Cs4t19yhlNpsEIQpGj+xoM6tQL5Cxglo+V2I/At7W1f
	 BBD4OC7+F5pzZbVEkh24ugilPtSVUSFRdTswc7WMK12COZiYpETDd/hg8z2fPcvtgbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZHVL1qqT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DE606A337;
	Tue, 10 Nov 2026 10:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964DE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZHVL1qqT
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5A8C72004B4;
	Tue, 10 Nov 2026 11:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794306008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhakFzXWHmC22oDdbGMEayGQsS98Xx4EYQhF9ATraBQ=;
	b=ZHVL1qqTXD3zt7sPO6+Ke8B2jPq05xnqB+1xRFzh8O3FDs3HmvO1QhN6bpMwXS4vlZkqdT
	HR9oeokY4Ex/YwGjhMKyzp6D+KmU1TyEuleXm08iYGS8glLU1s5giJgM8SJxkZDT3G+Zj+
	yMhgLXn7MM5I29XZWSc0tadR+JgfUthdxiQX2JD6EyW0okKqOJT7C091W6xSNm2hd2ep2S
	5GHqaNbccpn7tvHV0e14uIvAWF5Oghc/q9NFOA1GDG6Bwz8xWDqL+BJupf/VeqPNrfW6Ik
	quCIVLeffpX+mICRJEyU59bHw0SY2VdTQzmbM1Dp5m78aJVrFOmXRsnRW14FAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794306008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhakFzXWHmC22oDdbGMEayGQsS98Xx4EYQhF9ATraBQ=;
	b=cFul36IAGkePAej/Bs0Tf9cVq0qfMHgJO9GlxoERNVM8OkpPBPI4alObbTScIu4+7YdzvZ
	T8TO+qMT6ClgsPqNSwG97obLDYre6HV7/951dX/5A5u11v7yEZt+6iXvg87yFNnXHhtFeS
	swsC1zZeRebCfyXFeYWVFDSgljhgHHp7QeQbbAej49RLqHWn8FahsK+7TB6etEyYZTVfNv
	rp/MV1VOTc8u+OhbD+x6Rgc4PfwFmX+TwhC+V+gzgsGjc8fM4+64y+y69MmLKU0v6P74pQ
	cvjfc7EijCK1I4azOeuDYSujEAsd5+61VwKGdvr6IJG8Rfqp2+q1YKLwRJtjxw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794306008; a=rsa-sha256;
	cv=none;
	b=dHi09yWyz4jGmsB2Db61vPK2HhqL4JK35FBa0XNM2HYfkBuEDhucM++fPEUmZJUm5gPZyx
	4yF0yd/Dq/pA1WpUZe8w14qzBi+KBvJkwH5YIT0sSaOzrsXZ37nINBYiTt8WBT7INCEDZZ
	+UxTT1Cysq1Fvht13Tfyw2Ds2FTRVnbjzA1bUdl0JGTFzlR3A4gbyemJ5q/I18veRV4XRQ
	3gDyUvi+moAuwrkk9F5QGmQbj+t3vnVMa7wMYIfIZAFws74eQ3tkgWdUWjRDrnQ7q+gUxi
	lDNb2Tg6Edz9Dahmm8n8OeMGv40zH11OwO8T8fGxVQbc3/Nq4PeVHoUxYLK2WQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH net-next v4 0/4] net: dp83867: add new output-impedance DT
 binding
Date: Tue, 10 Nov 2026 11:20:04 +0100
Message-Id: <20261110-v7-2-topic-dp83867-v4-0-a268f83b1ec1@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTW7DIBAF4KtErDMVfwY7q9yj6gLD2CELbAFGr
 iLfvcSVqkqxshzNvO/NgySMHhO5nB4kYvHJT6EO8nwi9mbCiOBdnQmnXNGWSigaOORp9hbc3Ip
 WaUAtTCut0JQpUoNzxMGvO/pJAmYIuGby9btJS39Hm5/m8/bmU57i995f2J54V1UYUGDW6A77R
 iIO1xnDuOQ4Bb9+ONxbCv/ncHXo8OqYTvfSolXYiUNH/DmM0WNHVEc2yJwwbmD96z/btv0AqHD
 eA2UBAAA=
X-Change-ID: 20260804-v7-2-topic-dp83867-e73a84c37016
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@amd.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=UyGY4B4iVJRLQpKtyyya2EN6ZHfXGaESrzVeignIFm4=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9an99cfmKf5u+yMKuz6F6yb3rxsy5MM+XPddfET0ywvV
 azmOPaoo5SFQYyLQVZMkUVlYQWfqMcHz8hpIlwwc1iZQIYwcHEKwES+PWH4w/tJ9djGxizF0E1r
 c3MPSjtV6edv+bG+8lTbqx5Ot+C+74wM984+SJtr8VH/tcSukJDyDTf3cZfsNN67J8qrdJHUq+k
 abAA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently the dp83867 supports setting the io impedance to minimum,
maximum, default or a value from a nvmem cell. In situations where there
is no backend for a nvmem cell, the value can not be set to anything but
minimum, maximum or default.

Add support for a ti,output-impedance-ohms binding, allowing to specify
the impedance in ohms via the devicetree. It is mutually exclusive with
the nvmem cell and the boolean bindings for minimum and maximum; the
binding schema now enforces this for all of them.

Until now, dtschema never applied the binding: it had neither a
compatible nor a select. The binding gets the compatible of the PHY ID,
which several devicetrees already use. The Xilinx ZynqMP devicetrees
then fail validation on an unused #phy-cells in their DP83867 nodes
without the patch from

    https://patch.msgid.link/20261110-v7-4-topic-zynqmp-dp83867-v1-1-04500475a560@pengutronix.de 

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v4:
- split xilinx patch out of this series
  https://patch.msgid.link/20261110-v7-4-topic-zynqmp-dp83867-v1-1-04500475a560@pengutronix.de 
- Link to v3: https://patch.msgid.link/20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de

Changes in v3:
- new patch: drop the unused #phy-cells from the Xilinx DP83867 nodes,
  which fail validation once the binding applies to them
- new patch: give the binding a compatible and reference
  ethernet-phy.yaml; without a compatible or select, dtschema never
  applied the binding, so the new constraints would not have been checked
- ti,output-impedance-ohms takes ohms (35..70) instead of the register
  value, the driver maps it linearly to the nearest of the 32 settings
  (the datasheet does not specify the impedance of each setting)
- fix the range check, out of range values were silently masked
- describe the mutual exclusivity instead of a wrong precedence in the
  commit messages
- fix typo in commit message
- also forbid ti,min-output-impedance together with
  ti,max-output-impedance and drop the precedence note from the binding
- rename the binding patch to "Add ti,output-impedance-ohms"
- Link to v2: https://patch.msgid.link/20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de

Changes in v2:
- change 'u8 *val' to 'u32 *val'
- fix logic in driver
- update description of new binding
- rename ti,output-impedance -> ti,output-impedance-ohms
- make mutual exclusivity explicit in binding
- Link to v1: https://patch.msgid.link/20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de

---
Steffen Trumtrar (4):
      dt-bindings: net: dp83867: add compatible and reference ethernet-phy.yaml
      dt-bindings: net: dp83867: make exclusivity explicit
      dt-bindings: net: dp83867: Add ti,output-impedance-ohms
      net: phy: dp83867: support setting output-impedance

 .../devicetree/bindings/net/ti,dp83867.yaml        | 47 ++++++++++++++++++----
 drivers/net/phy/dp83867.c                          | 29 +++++++++++--
 2 files changed, 65 insertions(+), 11 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20260804-v7-2-topic-dp83867-e73a84c37016

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

