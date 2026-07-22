Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD293019DC;
	Wed, 22 Jul 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742610; cv=none; b=uE8h3oaPapVWRaRiQUkRR6V8EYHev9E+7r0P3dTEIJlVf29g+UltnqYGAO3gy/ELC2iO2HJBKr3oGJ+ROt5+gXWMs3oVfC/wsbs10c5YSVDyxAi2pvr+JTR/VPVlmUb60mody5SAnlzVqHmgKJFCPD1zHnCBIVoUcHyWPu9bpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742610; c=relaxed/simple;
	bh=vYSkYRGt8h2yoWMXvjdTusgv90Y5E3oNYSfcefK1ToU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rxfH+fis6Pgi9TnK9BmRiCN/vsqEfyiKPYau6SW4NLBI0BpNyYoxq1JsRLwiJgpWLYwYKiflWm8oS5RoqhO0nsFY1uBbUAet8+sCZC3HCQqvT3RqxKNlTWfyYiyvIOfuuG5jBfzgxQR9QCG4/fvsTUzqOr2HwdvBNPRIHTFCoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=sTYj0mr0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9BP10YW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="sTYj0mr0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9BP10YW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C0600EC01A7;
	Wed, 22 Jul 2026 13:50:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 13:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1784742606; x=1784829006; bh=Vj
	eBbgf7TivvZDY2fpAlYlAUdw568fh+LoeNLjGrRpc=; b=sTYj0mr0UPDFN7nydR
	I9bl7QzdspDuWCJqIQDQ8X9nl4H2f+XRezgcaq7JJJiJgzvEFZOuXWMb+s0V2YoE
	1tzZnuuWI3T0kXp1ISu+VFrSs8Py5V/wnKSjeQ83JzgzC1+kLy0ypTp3Pgf0jAZm
	Tatzz0dfuNOvR9YPeBfNQYlvSXiYAScL2/bl2WLcAXRKB8KCqgqhHy0hZS8tSEp0
	xFtBhc6lETq+kOv6cuicjkJ2slyHz8YK/3KaWNDL8oma7szq0zmYoMCpeUr0YHJG
	hhqmldPANpiaEiquSglWq1jgAHTU7t+dB2mRIr618Fh24vIUKk7vdbp1luAQHI4c
	sqfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784742606; x=1784829006; bh=VjeBbgf7TivvZDY2fpAlYlAUdw56
	8fh+LoeNLjGrRpc=; b=c9BP10YW0w5cpjp3Ja4g3DAzV12qWuMMnQUijEFfFPIT
	hg6VbOAIKfmLwSUpAh2WLzh/FWpUaMy8upvxIt4OFkR/lLuvWQXrkEDVavc/OQsJ
	P9p9a9BNChOfl2FxhBonPbaU0gpO70vX5P1U1BJ8Dmm/jo9JOvOlO2KBrbQnS7uU
	r/isbKv6xfkqCUSHbMf2sAhXvmA9teR/S2MTSNl0MCmD8sQ6kEeZ0PBxUE0zavyo
	hIg+3ytrW3JU94IFAOVx00pGO9FRaCtKA2TWTNDCdxprWL7MG6yiriIDXrWPFgvE
	B+ZDjWB6T054/dte9Qrm4MxN8W48ImPov6cFif8+gg==
X-ME-Sender: <xms:zgJhaqRJwsxuFbs_8ASz_83FQldblafrBUw7rtd2QQp8cv7FFdPp5g>
    <xme:zgJhauA4izrCdFgm8qgWvKl8jWPN7C8cYvXFhhenxDCr1bg17Pf7OpPTkJBC9tI0X
    HfFNmYBVqy_dQcQ6PdZuEJosHTME1R4Vente9atRrRaKCWX6wlumP0>
X-ME-Received: <xmr:zgJhahK7LqhyUKdgfXs_rV57xRxyXmDxV4WI-fZ_QqTZDL5JhhGUPcI3BPRnNximoX8KN4HyjSeiwQFfaguRNpfDSUA6pzM>
X-ME-Proxy-Cause: dmFkZTF6wa05MuJGMx25qrIop1Vsd0JU3WMHun7XneUnnGpQah/hX6WX9AUODZG8NSinPG
    SZwL14EnUK1FbAmVcX2wA6U8JKmFqtTpSJS4zpMw3LwxQT5mPK+GjzaTSy8UMsumOCAxX/
    O057XSe0mAve/xfcRjg9Ow5EkcGl9010T8slvApxOVou39b2MepbiZrZXFis63cW5Vc3Ad
    8piK9hhFBPomLXUPKsL3KjwhQF2M3C1aE+ngA1GqSc9Gyezlk//VTHbZJl0de76mwI/cx6
    2UVudRWddsozAEqSe6W8UisC3R3bvUAK140femIyLBi7bto2hD3K+Cd9UVAJU+TVkulCZT
    jue/PNGG3iqAC8x4qKIlv+BsD67G1UUvqz8fRpG+tuqclwj59TzcShXvYPZQxZvvB35Soq
    nYWbVPTvqsSYqvwuFvbNCgug5AgyMARLcO2GJjjqimn7oNpY/hPuEtqJNE9uy7fDO91tOU
    sK8g2fdL0jlxOYSq3PJsavyXJaIcq97wgZ/l3XSQE+djrLsNRWnFTPsX2z9tMBQJZn7p5k
    JjsmKCQH8c+p9diEPSVbE1KlaK8RFWKZ/IubuISqRD/jzAuJ/oDI5vaSfjHJ3S7tbE9UOH
    T1PHta7g83aN2VrJ06zbxFMqyGqOauepoXhNDxAlRRVM/5EdTNKvhokTrL+A
X-ME-Proxy: <xmx:zgJhapCldJ9B0LO5q7CiDTVSQaMQNc-nw-n3R11LbGEkFrZkMZjdMg>
    <xmx:zgJhamv59AHoERKLt0L8wuJUhR6b6evLFqPhzko2kK8rwEkHL4AFHw>
    <xmx:zgJhanS_OWPRYaaV-wifjVhX4Ryr8JG5o81gFl_XPRZi0jXFlHXI_A>
    <xmx:zgJhatL12QAlDlN48yckdcaAiCKqvzqJfluowFfgECiQQJwhxTpejQ>
    <xmx:zgJhasozlUF-P1DC-8sdVxdPKqYJ6mMKJt-R2puJnRQJQnwM5nSlzMJG>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 13:50:05 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next] net: dsa: microchip: Fix log typo in error path
Date: Wed, 22 Jul 2026 19:48:53 +0200
Message-ID: <20260722174853.2316333-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All other log messages in the driver prefix hex values with 0x, add it
in the one missing message. While at it also add the missing opening
parenthesis in the same log message.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 67ab6ddb9e53..ff4dd51f6cb0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2994,7 +2994,7 @@ static int ksz_switch_detect(struct ksz_device *dev)
 			break;
 		default:
 			dev_err(dev->dev,
-				"unsupported switch detected %x)\n", id32);
+				"unsupported switch detected (0x%x)\n", id32);
 			return -ENODEV;
 		}
 	}
-- 
2.55.0

