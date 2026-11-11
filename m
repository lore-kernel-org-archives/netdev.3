Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440642;
	b=DizoAy+Ypupq/WQrk6pFrB2CBo8FzjzUDCzDNF7Cfy53VCNPalRu1rsn0w/FGahbF5Rr
	 6KFH6Ltxc3Kviwx0yC8J5tf2TuYWrre2e6M5QqZJKk800vQObXezuLUxIbZuHA6SJ6kET
	 KqFXeCmSwjH14nTc6yfAgqmXCOYx8onYlCmdIvGsBAHbtOX5CzhMBVfqlZlUwgVMhFr3o
	 phlDGR3cboA1F91soRtdRgwRwjVTKQIHvo5QG2Hvv0Iv3DNrEE7UzYP2QKwULiT5GQ7xF
	 A2c/EoldoCR2bcaejXTssIiJOCRNp56DFPARwoRjZcpSBuX9KYjs2BfVdVeXTFlLzcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4nwTcWKBQd+TU0Te6S0UfHED4bkzf8en/Ar11xJ+i5w=;
	b=jjE8pd9RS/5avmlYdol62iejR+mhaPxyoSey5LnSHe9vm84spDSN6F3ye23oOiYkewDG
	 bdAM0mVh6uGGYA8RjKxDBrD5bFRUQ6MYILuIU7k7IodBRnYoiMSNgtjxLutm+3cxwsfAe
	 Ni17bJolp+xQxCVeNprsEXNbWu/1m9iZ5l88ah1L/zRG/3ZheqWvU4HDcPf238gUkYTY8
	 QAi1C5q/Sso/Q8SssNxK0kDX8KiVlgk6wxMI6hnXaKVRviUXP655pu1dk7v5wdS15NtEu
	 SE8fOvsFRf7Mm79bZFj/O8Jg37K4jOprdmoRgzQ8j6yY5GkyRJ1+05i1HSoMxykdOOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MSlQS7T;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A57606A89C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A57606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MSlQS7T
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so197157a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794440642; x=1795045442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nwTcWKBQd+TU0Te6S0UfHED4bkzf8en/Ar11xJ+i5w=;
        b=0MSlQS7TrxODbVyWhIXvjexrlj43q+xYfxfDzsruD2dHxTCYYhfyKpNRdKAx3daCR+
         v8TB140rqAYxCBkAN5NNZ8KAgjpXMG7EcPM63y18/UspOL3Q0keUwKwyVGueSHqAu2Yu
         X/5MbB+0J6RMSDmoUzYWgMoJzsPzFFYocRtAvWIYRYa0q367tmCJOcjfHqlxH03/eaUt
         M4TCxiGYgPJKgouC1D5OdTRKHoaP6WJxVzZ+IAaBrOUPELVpv8hfRi1OkIZXMB8vkp/w
         20UJTrBz6Z04q7FB5UOB57qgPcqbnyYuSbN72DfTdnQnuQG2zZ15SxgSKwHxf/m13S2o
         3FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440642; x=1795045442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4nwTcWKBQd+TU0Te6S0UfHED4bkzf8en/Ar11xJ+i5w=;
        b=jlhZMSTX1It4p3dplQzwGdeSonwV55sh6egINM6AP+kFIQFGAx+iTV13QnIwgK52np
         ocNeSuTkuiKI6yOpj5N+rCLyLoBigRpIoNmDKh4W7hoq14FgWJNZZqRtxaIaU104M4YJ
         kZFTHDF0h/qHc8U9D0kyywkUrOGMdgGGDMnm7wSDp/WhofKMYtj6nQIs0qi8SD4N4CQV
         2d6sgQdpLw2Hokpqb6b468sAK0fdaDYdA/gdoaqZfcEPYeJeVCMPgeffD7TdooQfBYyB
         O00R8lsAiXOaN5vPfrZAZVmORQCd7K2EI6PyR914t4pDkDQdeuQPPETHYJueZCPJamO7
         tzMA==
X-Gm-Message-State: APuU4Z/DoCkdP0/V/Yh1GYLIEuj5UhfigXieVa/q780GcLCEpOtiqRwo
	N2wDDwu82ot11PA/VLpbqwHrWCvFg3srYkDRyJlRKy+sUUosZU5CmGjJnbDcEQ==
X-Gm-Gg: AYBFou0A2p236vrDdNfop96Y9ksLR2MyqXOC99dSI/kZ/yY9lbf3NW493NnbhkSiWXU
	Ic1r93o8v84OWU9HK143JtnY8++Ewbua8wJBiEFWPYSB/2JYJAekvvUuCXfWbM9vnVITu0er61K
	Zk0kKofhUxoWGjGegbIImqk+oxwVj/UDO51AZDN8lKjl7rGKLhflDEWzwu+jMnIriBcG/ALpHKs
	pt+zj7OXX18uBrCMpNehx2V0xNIv8xjx9cEoVQuTFpwb576x/RDCsvqPHFXud1Muo3UCcKOoJS6
	m6NkcjyGRce1GFxU+DSMywTXkJ9UX+ZBU09tfN+///UT+iSdCA5KMqkUCL91RIzSfy9AX8lUrSq
	SQ6vM31Hsv5SJ7FHXvvSY7xF2ArNWMqlGiV6IwTNxzDLS82tjNX7STUXYBzQq0KC0hA/2qYs3AB
	kF5UXF6IJICPhgsDwhb9RFi7i8/GbeaL5xI2HeZ5LQrRDTUET1zS0fKFWsOAotvfd7eESNUvEaq
	XTXosn2V2ZG4UWqdw2Ienzn17fj5J/7SXRsC9viwjOhDWyIhRwc+D+1gKg3+4lhgQmKs8X4l5Lo
	O8dGOkGVsETTDY4F0HyT3Z2hP7EgwAKMYYZvNqpxBUQ9kJ0STWbJ3JjEBoUWa4KNrWgl9VZG+0w
	=
X-Received: by 2002:a17:90b:1dc7:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b197c81836mr533867a91.8.1794440641776;
        Wed, 11 Nov 2026 15:44:01 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm1328794a91.10.2026.11.11.15.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:44:01 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: dsa: motorcomm: Use VID 0 as the unaware PVID
Date: Thu, 12 Nov 2026 07:41:06 +0800
Message-ID: <20261111234110.1449602-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111234110.1449602-1-mmyangfl@gmail.com>
References: <20261111234110.1449602-1-mmyangfl@gmail.com>
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

The hardware classifies untagged and priority-tagged frames to the
port's PVID before the VLAN table lookup, and the FDB lookup key equals
the classified VID (measured on YT9215S).

The driver assigned PVID 4095 to the VLAN-unaware ports, while switchdev
reports the bridge's FDB entries with VID 0. These entries were then
installed under FID 0 and could never be hit by the hardware lookups.
Dynamic entries learnt under VID 4095, if any, took effect instead.

Lift the restriction on VLAN 0, and use it as the PVID of the
VLAN-unaware ports instead. The standalone default of 4095 stays, so
mislearnt entries, if any, would not pollute the bridge FDB.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index a2be819ccbed..376f16466cdd 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -79,7 +79,6 @@ static const struct yt921x_info yt921x_infos[] = {
 	{}
 };
 
-#define YT921X_VID_UNWARE	4095
 
 struct yt921x_reg_mdio {
 	struct mii_bus *bus;
@@ -962,7 +961,7 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 	bdev = dsa_port_bridge_dev_get(dp);
 
 	if (!bdev || !vlan_filtering)
-		pvid = YT921X_VID_UNWARE;
+		pvid = 0;
 	else
 		br_vlan_get_pvid(bdev, &pvid);
 	res = yt921x_port_set_pvid(priv, port, pvid);
@@ -1030,8 +1029,7 @@ yt921x_pvid_clear(struct yt921x_priv *priv, int port)
 
 	vlan_filtering = dsa_port_is_vlan_filtering(dp);
 
-	res = yt921x_port_set_pvid(priv, port,
-				   vlan_filtering ? 0 : YT921X_VID_UNWARE);
+	res = yt921x_port_set_pvid(priv, port, 0);
 	if (res)
 		return res;
 
@@ -1188,7 +1186,7 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 	/* Unrelated since learning is off and all packets are trapped;
 	 * set it anyway
 	 */
-	res = yt921x_port_set_pvid(priv, port, YT921X_VID_UNWARE);
+	res = yt921x_port_set_pvid(priv, port, 4095);
 	if (res)
 		return res;
 
@@ -2270,7 +2268,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
-	u32 ctrls[2];
 	u32 ctrl;
 	int port;
 	int res;
@@ -2328,15 +2325,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	/* Tagged VID 0 should be treated as untagged, which confuses the
-	 * hardware a lot
-	 */
-	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
-	ctrls[1] = 0;
-	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
-	if (res)
-		return res;
-
 	return 0;
 }
 
-- 
2.53.0

