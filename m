Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794172443;
	b=n69M2ELimmXBSKLtDWG1M+Wjcjz3ugfGPKhXqGFOJo15/yGuYFatwCz7qi3RPXGlInjy
	 P70/U82s4DHUQ3TZTplr8oH+q+WaWCTDrXK4zkXR6GYN4HwNeRwW1OdT8NXS7MLuM0kLl
	 4SmJpScfq+hRghp8ZQDzqUCr/JJJYYnsBFHxwNazMNo5NhrFbgnvVUnDinPc1DyE0yRTs
	 vYzfVuRBf5YCUHjbrGV9+mAwpwD8HUztV3XgXF50yD1GdXi+fZJXNYgqZ83Jc0wLwNcuo
	 NG9na7w3iPr1LIpnTD6dx1iQIKAo82X41Tj0E8ajxQB0a9powegNEXZ9veHwqsoD64Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172443;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DrXeH+tZC3Vva3ircwn3Kn4fX5MCrsA321e2xqYBjtM=;
	b=CYPt9+RtnKwvHQMzHNHOqQ4armgQ/fHCLP5a5Sm396yaRsAPWlMiBE7LIbIYtl5Nyztq
	 xAWsWDF0F+vlwkn9w1KLSGl1v0BTdGUVSu7ruFaNbeZAh3fwq0nXgvZ90K2ex05lPaAPR
	 u1Ngvc8TlU+nmWidbROafZO2EuEWbp4tvlVAqEnHIjvvfnMIbgXuod1vG7TGpIfsx0V9M
	 ZCb2P5AjYFpY+D2XNofRU1zBdzq4lSjsuaeLeYOhHw6F9faxvI0X275WN8WVhVWOgh4lT
	 F1PckctsLCQlbjdMrjd8WNRtskp3+arpKa7bqqpCCEwXmtUZ/2syn1dBSPHQ9We/pTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcWOFHVJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D05606A31C;
	Sun,  8 Nov 2026 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcWOFHVJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794172443;
	b=gDWVPeBOn3nJlATfG1LVYerjsdbkRspbR6GfyxfM0PIFDu0QKE6hoVIiyfYmmZRmfeF1
	 q1SDwXru7PqiuWfBdsdzy+Shnap2Hjxdde87c8Jr4jMsFRV1Nhw82+n5dfYDer72nSCb5
	 1h/9+m1kmoKDMuWkADVtSmajdi8SJrYvFWQPr+Et+LHpUgflj4apVoXdTrXFQgy/zVBEM
	 jLfhgVXHRPnterZB+zV0+KisIz7jB8fnIONvtteI2rOmHi5GvZx1nQaM0YXyg8xYHzsm2
	 AGCWVQcTTyv3m6FudAm7XMQnI0K8BNvKWPbmSrAkBlE2pV21Fn13qudcLiMwaqaHUrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794172443;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DrXeH+tZC3Vva3ircwn3Kn4fX5MCrsA321e2xqYBjtM=;
	b=lGBCQhSkdC9KKEEbvxim+m9+b28i4pNDj9ZEcZnGqSfdMKMB2TT4gtE6N5Nyr7SioCcT
	 mijrVS2h5J6iprr2XCZkK86mefi36sOLCiecCIB3889oQ5PzeV2XSjoQcjp0OrDGc2KkR
	 yEqJkFdnZFvMfbgXB63srREuw5z9PoIuXllPlEB1WuWpEQiNGXDtUQ6I1kyzq2yFezpvL
	 sUPJJqDU2KTwrUpTPFQcECMa5V9si+RitIPA1TTwWc0LiBcQnjo9jeIrAkA+eVFTkJCnb
	 jIYf/LT366X0JVjdqP0jCoCqiiWV9a1xe+217Fbv1wSieuv/iVlBDy/9jYV+HGK8xUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 876631F0089F;
	Sun,  8 Nov 2026 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172443;
	bh=DrXeH+tZC3Vva3ircwn3Kn4fX5MCrsA321e2xqYBjtM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=NcWOFHVJZq14LewoCUBVIRX0EsT6kJzu6MA7RGn195T2fR/FQ8rTTIr9Vf9tXLrLx
	 89iU5Z4YnHfG3+y3LAW3ec22MTONCbWFhvE4oeIthi7mpZ+3W/VmXm23S1qaPyY2o3
	 ozn6GRATyfdfCIg1Hyt2rsyaQW7FYp1NFsU9X0seXiiUiYuzCiLuplV7I3GmIyU++7
	 mOoILHSCqhM+u8jZXIaqR+cJq7C1d5SSKudMECoXQe6/3vtGa14KcZMP2yUezgBZX9
	 GseOEhUPlh/nQmk4e8t0QP6oPjPyRriN9DM7wcaK2v+P4tN5glCeBDY5A1SetMWX7L
	 2XT+d/mvvoIRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DA721480FC;
	Sun,  8 Nov 2026 21:14:01 +0000 (UTC)
From: Hleb Shauchenka via B4 Relay <devnull+me.marleb.org@kernel.org>
Date: Sun, 08 Nov 2026 22:13:45 +0100
Subject: [PATCH net-next v3] net: phy: realtek: return MDIO read errors
 from hwmon
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
Message-Id: <20261108-realtek-hwmon-tz-v3-1-b4e9fb16d323@marleb.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwXLCMAxEf4XxGdHYCTHm1P9gONhGJGqJ3ZFNo
 GXy7yThAjP0uLvS272JhEyYxHZxE4w9JYphFOVyIXxrQ4NAh1ELVahayqIERnvK+A3tpYsB8h+
 YtSq1NUq6oxHj2w/jka4zcicCZgh4zWL/SNLZfaHPE3G6dTYhOLbBt5MVmRoKH52lMKUtpRz5d
 97Wy5n3/4xeggSstdKq9OuNd5+d5RO6VeRmbu/VM0G/ISgooHbG1uZQVZUuXgjDMNwBfY53XS0
 BAAA=
X-Change-ID: 20261103-realtek-hwmon-tz-95237a921bf9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hleb Shauchenka <me@marleb.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=me@marleb.org;
 h=from:subject:message-id;
 bh=5AKdSsLeZoi/+Kn1tEFUpy3mbr1m+5jW94geBAoL4co=;
 b=owJ4nJvAy8zAJTZJnM368y8lXsbTakkMWR+eSVi1KVY4Vc3v8pvwIE/FzeBPUYR6eNP9C1stb
 lpkJNlmr+4oZWEQ42KQFVNk2dRcJPp0ZfRb1+o9WTBzWJlAhjBwcQrARNYrMTJMN1h+qPnclRcX
 hQS6v1kw/FvxLPPM+0y9bxU/v6y/wbp4ASPDx55uD4UdZ73s2oJDuGtDNrM4mKwrF3x3713cvE4
 +nU/sAGBtSQw=
X-Developer-Key: i=me@marleb.org; a=openpgp;
 fpr=B2837215E5A95BED457BBC6A9217063BF3FA220D
X-Endpoint-Received: by B4 Relay for me@marleb.org/default with
 auth_id=1394
X-Original-From: Hleb Shauchenka <me@marleb.org>
Reply-To: me@marleb.org
Content-Transfer-Encoding: 7bit

From: Hleb Shauchenka <me@marleb.org>

rtl822x_hwmon_read() masks or shifts the value returned by
phy_read_mmd() without checking it and returns success, so a failed
MDIO read is reported as a temperature: -EIO reads as -2.5 C and
-ETIMEDOUT as -55 C.

Return the error instead, so that readers of the hwmon attributes see
the failure rather than a plausible but wrong temperature.

Signed-off-by: Hleb Shauchenka <me@marleb.org>
---
This patch was prepared with AI assistance (Claude Opus 5.5), after an
AI review of v1 pointed out the problem. It is build-tested only: I
could not provoke a failed MDIO read on hardware.
---
Changes in v3:
- Drop the binding and HWMON_C_REGISTER_TZ patches: their only user is
  out-of-tree code.
- Send this patch alone, without the Fixes tag.
- Move the AI note below the ---.
- Link to v2: https://patch.msgid.link/20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org

Changes in v2:
- New patch, in a series with two others.
- Link to v1: https://patch.msgid.link/20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org
---
 drivers/net/phy/realtek/realtek_hwmon.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
index ac96e2d1e..b6b2806e2 100644
--- a/drivers/net/phy/realtek/realtek_hwmon.c
+++ b/drivers/net/phy/realtek/realtek_hwmon.c
@@ -30,13 +30,17 @@ static int rtl822x_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (attr) {
 	case hwmon_temp_input:
-		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR) & 0x3ff;
-		*val = rtl822x_hwmon_get_temp(raw);
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR);
+		if (raw < 0)
+			return raw;
+		*val = rtl822x_hwmon_get_temp(raw & 0x3ff);
 		break;
 	case hwmon_temp_max:
 		/* Chip reduces speed to 1G if threshold is exceeded */
-		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSSR) >> 6;
-		*val = rtl822x_hwmon_get_temp(raw);
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSSR);
+		if (raw < 0)
+			return raw;
+		*val = rtl822x_hwmon_get_temp(raw >> 6);
 		break;
 	default:
 		return -EINVAL;

---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261103-realtek-hwmon-tz-95237a921bf9

Best regards,
--  
Hleb Shauchenka <me@marleb.org>


