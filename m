Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3A351C27
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693839; cv=none; b=GiVIBZljh2P7Mnf5tpRqWtZtXXGMqqNQKC4+8BrwqoBiZGbJDRM7XYNh5fc8BnmZ0llpOEPd9HeUH35XEIFSci0m77VTe8YbQ5f2cT/3GDEUHsExlk+QRkFXMP1ZUeEDz+b5jDz5RKi17X+kZ9FHAUSvJ/FgJeqfvwlvGpqJO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693839; c=relaxed/simple;
	bh=XKcgQN1LwcPd7oBDnlN27f9Psf7Jl0a4T9D3l0TEfJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mi5wPim3b9js/iEtOLNtKzieX/Cz/4w1VH1DkS1aboaHC5Kh6QrtTY+V/2+QTzz1pjRhXDEu5e5L/vUVe1Y2o9qiwSzstXOtNc8tdl3CcfMGd7IP/TPoMdj26NpiYlROyJ4a43YCe9jJQibtVWH7OAbLCstMLI8VkR+CLHmXmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvDKQ5XT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvDKQ5XT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso143884225ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 21:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693833; x=1785298633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnX5uAxhdj7zkkHTRkiZpGious/56DxOlSP5Pxob66I=;
        b=DvDKQ5XT5tuMvjeE35+c/4fthXhiqLoN/nXLrUjKiKj5mAUq2D91aB5CoYF7oIugyY
         xDUnO/iy7cedVQxX+RX+FdjcsvHl7WiDa+QIjRvgbZ28ZxMhAcK2G+xSLw7nQfEpcZQR
         brguwWZqGpgNhWAWsgTtN2sJMsxlZDty4wHnZRd8cHiv5HNWV0cnd8ptR7ETvq4Sl4OY
         KWJQvEOUNg/Kyz9SUt+xBxzfaMWU5CQps4RiOZHb0/23bmjQMmQO6Q4QpFWP27rqmO8w
         UJa6cxJccP0a3+wa1siMPfW7OL0AtoQbBXg/H9taKBlxDPuFUPtWwj5F9/vFVtLNLffV
         WFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693833; x=1785298633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnX5uAxhdj7zkkHTRkiZpGious/56DxOlSP5Pxob66I=;
        b=murGYZdyDPMaGimchdw0dijCkvN06dwu6bAGBMSjL2I2nHSdoV78B57+ytlvZzLsNl
         xzQRGU4kar+cNnBtj0FVKgTUBGCVGfh2kuqd00UhApswch5KiXECgLD9tD4zrgnlMaLc
         NvT57pUjtk+ai9PBoBD06++1l5uE9tFx3a78RnUKdJ44lHBisEqMfd6P9nW1HA1tyPip
         lL+18RwJFA0EC2+jliq5H2mpeNsMg3sAM7+HyMTrqRLuI3H2P3r4r8Cy7y+J6FX7OlH4
         uW7nP7/5rP9Chvxf/6JOhtTEh0eDWYshBD2daT06JXFpdKi15vCoNmHpo+wmseMh1iqM
         NNLw==
X-Gm-Message-State: AOJu0YwURFRMXf14Z6SwjbiIibyubcjcXaUqeeYQ5KxxA1nsz7qG43QQ
	5TkpLyYl3SRhW7GW1lVGZEGQngJL6ifwG7idG5aH9BHRQikFdEp0FTReGGy+fhnfCcg=
X-Gm-Gg: AR+sD12XbluH0yt1OqtoAx4wce0cyla/scLZpaWxaHiXmvLr4XYFI+2KenEPXCAGeSK
	o8GGZOHXE4oCeM4mUkORL71DkuV7jg9S892W8+4WLn3H0uN8bThT1KWwYuVBAPo3wgIgWwaLVRa
	ZmqvGymMCqAjOGg7aDUTE2cIZLC7TuvTP2DLEeNgFYMZpSRDahoTUItemCI/4A7QfwZxf+ZYAlN
	DFy88WwbyORIBwAO1nUlpdxpqyK7jC8jZhqlXmJo//5XCfaLdIYjsDtBjjhyFhOOZYyFQZ595mn
	8Y9oDuqIm9gCaftCqbONJA1vd7WaUhQLG3fSJHHk8AWd3ZiAC0t33JoZNCFgwu3vw2/vByGq2Qx
	f73bGYJIvwXBQFBpoOT3JPflCnEsgyOOzmlNJ4Bp0QDiALXsWuVXr3AlH3aDJfebmt/MADt3RrT
	9Dj93Q4SyW8FvlaK2+NnZP
X-Received: by 2002:a17:902:ce84:b0:2ca:6c8:abde with SMTP id d9443c01a7336-2cf348b2527mr225232625ad.18.1784693832780;
        Tue, 21 Jul 2026 21:17:12 -0700 (PDT)
Received: from localhost.localdomain ([122.187.83.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a689sm4342950eec.4.2026.07.21.21.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:17:12 -0700 (PDT)
From: Aravind Krishna <aravindkrishhna@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	Aravind Krishna <aravindkrishhna@gmail.com>
Subject: [PATCH] hsr: prp: honor master promisc mode for local delivery with macvlan
Date: Wed, 22 Jul 2026 09:46:29 +0530
Message-Id: <20260722041629.657330-1-aravindkrishhna@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running MACVLAN over PRP, packets can be expected to be delivered
to the local stack when the PRP/HSR master is in promiscuous mode.

Update local destination handling in check_local_dest() so that if the
master device exists and has IFF_PROMISC set, the packet is marked
PACKET_HOST and treated as local destination.

This enables expected receive behavior for MACVLAN over PRP setups.

Signed-off-by: Aravind-kris <aravindkrishhna@gmail.com>
---
 net/hsr/hsr_forward.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a65c1..38ed6b09fc4a 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -589,6 +589,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
 			     struct hsr_frame_info *frame)
 {
+	struct hsr_port *master;
+
 	if (hsr_addr_is_self(hsr, eth_hdr(skb)->h_dest)) {
 		frame->is_local_exclusive = true;
 		skb->pkt_type = PACKET_HOST;
@@ -600,8 +602,24 @@ static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
 	    skb->pkt_type == PACKET_MULTICAST ||
 	    skb->pkt_type == PACKET_BROADCAST) {
 		frame->is_local_dest = true;
-	} else {
-		frame->is_local_dest = false;
+	}
+	else
+	{
+		master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
+
+		if (!master || !master->dev)
+		{
+        		frame->is_local_dest = false;
+		}
+		else if (master->dev->flags & IFF_PROMISC)
+		{
+        		skb->pkt_type = PACKET_HOST;
+        		frame->is_local_dest = true;
+		}
+		else
+		{
+			frame->is_local_dest = false;
+		}
 	}
 }
 
-- 
2.34.1

