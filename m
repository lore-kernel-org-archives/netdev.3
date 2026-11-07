Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053856;
	b=QuoxJuO6BvBW9g8VBn1QTlDlIUUWL6xgqu31/UmPlONnk8dumKgX4gLKQY0Q0T5Dk5Nh
	 vD9GZdgJe5guRIonaTogd00Q7x3sTacBHbY9ZUcDvbWKoqAh9CbfflMI1+SPeUeSEu9Qa
	 anOHSLfbjPfbBEreQnGMzE+Wcw52fCGbc4cnikacEUGU39DQD+M0l6pL+EsEtgoriI+x0
	 wRdwrUsCeHVIUQVNe5fK9WM9jdRkVXU5D1ULjlPlMNLOSf+m8BtWsQIpSFwVcaeZo4pEh
	 mtz8xjaXywJhiVXsRFXajvgsfGKmUZd4vAI5rdCNoly7CS6yoCLJkcPt1h/MOV/cm+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+LTjmG4hsfDMCjMMjlOaOrFD/YTDusiKSuFamLI40ko=;
	b=hEW5MpgPzE+5Gj85YVPkit3W4HlmbvWAcCsuXNyTvr4nZkXCemAYLsDTudtIp267mZYG
	 hCidLnNcWMqQ0sqp9ScUo65d6Czvvh8pa76+Mp95jACQlsDKCP04ylxPogIu84/H0Xww2
	 CRGLLtV3GIYUNleSoHiV3Yd2IKXyX5Puh8UO5DNRWBAwp4biVg9Tnd5UjSwyQ2Seg18QL
	 gziyBHMlcG3iv+cTruYQXAaRiS/1hFe+G1H5ZSsbZQ2g2qf3Vil8KFbnR5drB1c/dTBgz
	 HFGEnmAWStuY89F2EKxQyPRsCeMAQYZV8Jcl62S7nfTUZ5MeUiVclPxXoOYwzAQDvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSEBpHBG;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAA606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DAA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSEBpHBG
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed408b0d9dso5514385ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053856; x=1794658656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LTjmG4hsfDMCjMMjlOaOrFD/YTDusiKSuFamLI40ko=;
        b=TSEBpHBG9youCAn2APNHS9CvqsQApN/oIEkCTkdkoDgMmDSJ2UneLOVy1Rt9Ef1QM6
         0gRk63y4nFUEsUn1GL8piCSOV3tYrb5DfznWvoLylcrG/JHs6B4p4h3sGPQKyWOzkl9+
         1Xc5gLKKYS22avhwHcpiqPsBA85buETRw3ByL/AJ95hULgKn7+43AhAFORDHQTEUUYKg
         vKtqe22rio8YZXeJZdr5EzLDKK3rQWcGvDI5yGwCLd8rhVgmcW85ixDTmZosIob3Y8vx
         ZfX3MX0SJNRqADDjQtx7G0RCJrlFkANNlbW8jJOIzQAFXYv9zxaITrExGhwNAZMG7nKX
         WHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053856; x=1794658656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LTjmG4hsfDMCjMMjlOaOrFD/YTDusiKSuFamLI40ko=;
        b=xJAjr4oW1XD+GwbYOCXYrRXt7SGLKixPwo2PEQ2e2Je7a+ITWI2nI7fWhw5DgHQzGz
         hCb+UJFfaQFf3RDIPZOgLH+H/o0JFetP7NPncZCqu9cPyxHiIcyGYGNmwzf9Hkyg3TBF
         jEnm1OF7PLyWROcBDaI59r74Fk9GkZx1AhdDJ4dfLzMUfgK/C9gUTtwAGWlO0dy6Kj6l
         P2OKaa5NYheUuY2zmcdAOun1TSRgH0nF6AwrfpskFRiwLlhLJaUUMq8iClEBh4mVyxfy
         0qiiz8j+wpfnBMwLBSxquOCcqdkZi6rSK29Gak84Tl7v71fdpMG7QYmmIejEzR6DAUax
         5btA==
X-Gm-Message-State: APuU4Z8a6t+1/ybJBDzJ37Zo0a2yd6EHbTUHd0ciTu5lDUzNd0BukKQk
	rlf/H7W0Y3e0OHcNU27zchMfRMkYyk3mFGg8C6kgxMXdL7Dvw2SGP8/17HFWet/Z3Fg=
X-Gm-Gg: AYBFou0X/GeXQt8vrlaCmpree7VNUFap8ZsOtFNLuIstw3uYnziA3pKlIFMnbX0lnzQ
	Os2w5n6C0UkPUOggxZmnyHfsl/hcWYRTUkf9SMDQ3uY0ICmJZDDFlxrYnE/iA6aAeNqt458KjeZ
	vzH81Jzt2EiQoydDSfx18BvOwYZU4Im+WJLI4FhvueZ9P4vJET6nF0H1gCfaPNLF/pMXRzOBalL
	efgjNeTm8imccxp1vHA/gB/JMfEBYFZeUa+EEJHpOh2vYCTEbx0SNmRBSCUynG/WDks5JiJq7ss
	DYtZB9GAXymowUKLTtiiWLz57nzzWrDakzoAjsZURMCGuq/IN13pEbOhhdPKjI1mlCDFUKVbzi8
	fJuHpCUgjjn54UbiocYCzMaxj2juKl+hB/8KLGkXqvKTtvjTuZJGlk8qkZc5ORNdGlRMIcC3m83
	ZpkeFk4gBFnOEs0kYgLVztzIUNBTuUZlaO4lp5W7X0rJSyDUP91j3A24A2+ItwaC3OUpUSL7+dI
	AAfyCzlcqx+Y4QwjgjAa3HA8XjFooy8FUXR7Tihu92DO3YUBY0Mh2Jt1hKO+x+aX9yN6sOcH5o5
	1CfHCgSzX+61DXRY3BbKYuZzJtoh/idzUh9fW9UNuG23yjR/qBl3/o8SZxP64geL+L1F4ogPzhY
	=
X-Received: by 2002:a17:903:22c2:b0:2ed:2e3f:20db with SMTP id d9443c01a7336-2ed41c1f858mr55545125ad.46.1794053855695;
        Sat, 07 Nov 2026 04:17:35 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:35 -0800 (PST)
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
Subject: [PATCH net-next v4 7/8] net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges
Date: Sat,  7 Nov 2026 20:16:28 +0800
Message-ID: <20261107121631.1040612-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
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

A VLAN-unaware bridge reports VID 0 for its FDB entries, but lookups run
with the unaware FID (VID 4095). Entries added through switchdev were
installed under FID 0 and could never be hit by the hardware lookups.

Translate the unaware FID and VID 0 back and forth, so the software
mapping stays symmetric with the hardware lookups.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 1b05ac29ecd7..e41fe4859bfe 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -590,6 +590,9 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
 	res = yt921x_fdb_read(priv, addr, &vid, &pmask, &index, &status);
 	if (res)
 		return res;
+
+	if (vid == YT921X_VID_UNWARE)
+		vid = 0;
 	if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
 		res = cb(addr, vid,
 			 status == YT921X_FDB_ENTRY_STATUS_STATIC, data);
@@ -618,6 +621,8 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
 		if (!pmask)
 			break;
 
+		if (vid == YT921X_VID_UNWARE)
+			vid = 0;
 		if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
 			res = cb(addr, vid,
 				 status == YT921X_FDB_ENTRY_STATUS_STATIC,
@@ -740,6 +745,10 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
 	u32 val;
 	int res;
 
+	/* See yt921x_fdb_join() */
+	if (!vid)
+		vid = YT921X_VID_UNWARE;
+
 	/* Check for presence */
 	res = yt921x_fdb_has(priv, addr, vid, &index);
 	if (res)
@@ -782,6 +791,13 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	u32 val2;
 	int res;
 
+	/* A vlan-unaware bridge reports vid 0, but untagged lookups on its
+	 * ports run with the unaware FID; map so that static entries match the
+	 * hardware lookups.
+	 */
+	if (!vid)
+		vid = YT921X_VID_UNWARE;
+
 	/* Check for presence */
 	res = yt921x_fdb_has(priv, addr, vid, &index);
 	if (res)
-- 
2.53.0

