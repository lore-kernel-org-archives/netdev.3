Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8130F526
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213196; cv=none; b=bV/MLC2LtvPqjOCer7LYqbvfq9Ijo5TfySrPY9IvVtTAdlrj9otWFHy0vrmWmZmsIRCqHWIXJS4WOW2pe3FVdZ14j7fCEfUESBqo/m3j61TGfSHSgQKge6aDde5SgrHTvCFW9tzuheTR0+llYdX4DO605pRAKH8quczvLgGH6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213196; c=relaxed/simple;
	bh=dpGgJsi8tXj9cx3m+TPw9PzfvlNEtUCCr0yt6OqCuK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6yTqtnjX38C+KUNK56eiA8fSx6QyRrQ1JR52rjpqLdWlp0g/pNSyRIAMwCyU4OXVz1CLzVo9KIsStqXBIfBYFbXkFwEHzmtGz1xsxlhlglgb2o0H2E8yeYMkAWloXrERJV4lmAPacNvs5smOMfdq59MStHaJNpdq94T4ENP1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=SxgieV7Q; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="SxgieV7Q"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so8076145ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790213194; x=1790817994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVZRQ5x1Nbv//jPzfv8xU7FIm9fRp81uaD5AoZR8zmM=;
        b=SxgieV7Qu7qrrOtnTAGgPPohcEQ7u0QMiQs0hZ8S8Z/tleL/9ZFCabF2K7DxxOr/v6
         QIc5Wj0mXGRDu2Ufkgfqz2vzHoBW7NGZTg17331dXS2XX2Eo/a59EWdkUgf/kGJKXn8d
         iLeDVSeh1fouPFWMXI6jTaQgD1jANkvgl2j+rmVjSN4yRvJslQ/wQF/oVmTRav64kxj5
         rRuX199D+wg7jkDk2dOSHuWDTmg4uOfNm6BPe8ATIkPx/lM7qPBXTwVn7v2h8nFUc6HR
         jj7hydaNSB5NOEEH02pyrAYjBUR7VcAk6oCo1Fa58SAKhj4IMgvCa5CYJ5gE2N0PNvzT
         EV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790213194; x=1790817994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVZRQ5x1Nbv//jPzfv8xU7FIm9fRp81uaD5AoZR8zmM=;
        b=cbtqBBKZAmcwsoKv8QSglMilBAQG0ZcO+O/Si+6bJ8PGudfBkP6UN0BtasVbcIM1wP
         qHrq9ZuTNKsZBoqSbOzyuqu6uo1xvw0zGOVa4EzSn2w5YB8+dM1E/pJ0549cjiKrH4f5
         X5jLMpMUXyi0TAwBnyHDuZemDhroXKdiPj6VYHh79t3GTDrDChBBH1eUzV+f24ozHjAT
         p1VtiHIOx1GewCR02xzqDRbW37Q7jeHOU2Kp+uHOCi6Xb3Br6qfZ5gQTSN3rx3RQ8NBD
         99uZ3Aa4xsK14iHvwn+8JaWLM/OIdO3ANAjDEdaIxWxvF9uvDajZ/YTi+QOEh9g84Id8
         B9qw==
X-Gm-Message-State: AFuF++kWX/m5Bg6AtIdAs8XndavKQIXEAxOR8xa2w6qbrYUAm/Asnm2s
	mdAMtz11kBwmcLKSopihWVULHz9HvxRS403uSmL1siSYm1czyPRP6ydqoKhcUD9OQYnZhcqH9xG
	lZHQYokfM
X-Gm-Gg: AYBFou27OK2Tui5LFAXFO0wVlnkKZ7/ZD7pey6bvC6AR5PKSlGNB1nXjUSfVKKhdyCv
	soScg4hL2BXmehw0zaxFfjzGO6VYJpsxfSqUeXlSIiYKad4NmvILGouJ2uQ4+MOVegc+PH6IyGH
	mAof2QzFPvi3I+s4lx5drKhyLsn8PpjqIRtu8QLNfGNanl+FAHzQOcbvL4wsHzoAUeupA6mimvB
	VkVxMgbaTljEFsi9W15e0409O7i9ZkVLBf+cZ6KNTVYlIlGkuVd4fX6Xa5z03GKfff93tp6jWUB
	61lvqRXVVrAEEd0sR9M4x38cBBgNQF7tqgtFBC6CcbSrbepfalXSE5LvazSDRnHdTt5sHFvgxmN
	pvWs2PwKW+X5eamIwIw6rZbaSuRM0w1Mm+cKsSFESQlaTwE3KHk1Acy4cwZQMS1QmQAmwXgfYSK
	mSky968KTUumCWUKKM5GrRCGTRXFdIdTLN/h3g1gzClPZkpb9pDVTPBf8bzR8Z3esS
X-Received: by 2002:a17:903:ac4:b0:2d8:d4d0:7931 with SMTP id d9443c01a7336-2df7da85644mr7547015ad.21.1790213194416;
        Wed, 23 Sep 2026 18:26:34 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([2a05:dfc1:8bc4:feda::14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a5157sm18730375ad.14.2026.09.23.18.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:26:34 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	opurdila@ixiacom.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] llc: reserve device headroom for allocated frames
Date: Thu, 24 Sep 2026 09:26:05 +0800
Message-ID: <20260924012613.2533934-1-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790141817.git.petalzu987@gmail.com>
References: <cover.1790141817.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

llc_alloc_frame() reserves link-layer headroom using the device type.
This is insufficient for stacked Ethernet devices such as VLAN devices,
where vlan_dev_hard_header() pushes a VLAN header before the lower
device's Ethernet header. An LLC response on such a device can
therefore underflow skb headroom in eth_header().

Use LL_RESERVED_SPACE() to account for the device's actual required
headroom while preserving the existing LLC device-type check.

Fixes: bf9ae5386bca ("llc: use dev_hard_header")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/llc/llc_sap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 1bd446a21092..3904a1b4ba84 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -19,12 +19,12 @@
 #include <linux/llc.h>
 #include <linux/slab.h>
 
-static int llc_mac_header_len(unsigned short devtype)
+static int llc_mac_header_len(struct net_device *dev)
 {
-	switch (devtype) {
+	switch (dev->type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
-		return sizeof(struct ethhdr);
+		return LL_RESERVED_SPACE(dev);
 	}
 	return 0;
 }
@@ -45,7 +45,7 @@ struct sk_buff *llc_alloc_frame(struct sock *sk, struct net_device *dev,
 	int hlen = type == LLC_PDU_TYPE_U ? 3 : 4;
 	struct sk_buff *skb;
 
-	hlen += llc_mac_header_len(dev->type);
+	hlen += llc_mac_header_len(dev);
 	skb = alloc_skb(hlen + data_size, GFP_ATOMIC);
 
 	if (skb) {
-- 
2.34.1
