Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1373A838A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001496; cv=none; b=EpRGm2g74GZeAc1dY46StZ0ZWu1CxC0lpaA8/tMi1XxTS2LiJYd5zJYhcHrQnApiBVMJu5r4HM6QKlFzGjsl+AuHSvKQW97xFLYyYfrM4Wv+gDu3mOAyvxU1t+SM0GkERFyYswzCsVT24+TMgNv2jXfAfM8SOVjvL4VCDmWOuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001496; c=relaxed/simple;
	bh=BRPYXCecTDnjSVaChCQSCTURDJvYwheTIwAy5EhtNRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH7Bhpuy/3zy/guGJrWcYgHMu7B07XWKrZXokY9gfNeyp9jdO7KuUL4kbrMdEATA/gUsngzvCyZazurQcQI9Qlu9areDpUjUU8/xTKuUp7cRBVk13B/44zJy2dpjvoirJMl7OmkwwtsXDcP5HQ4b16yOrc5R1ubEBa0kd2ZR9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWf67QTT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWf67QTT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49553515a8bso27332475e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786001491; x=1786606291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0kLjzVMGQP2GDl+xLrm6TwqzVKVcj9RXEl6sHzZBCM=;
        b=BWf67QTTdBXK/Y8T9eWKpD5IrHAPsnyZP/ZN0hxF+idpTy5mCiDRjVvU2VB0kstIQR
         IY2girq6LocI8gtKVF1IlMHf6lKACgEgjEMdLfYjSNWzFnC4oMF+DSDq3bsFcHNIv0/l
         0o+lLHHA4j5rvdJqdOwQQBvE2YHEvmmKS1vNrQLnfqsrCCoFp1jP8hBZ98CC00o0N90F
         /Tm8v1p+M2SnF71DT4ZiVdFbynveGiyMhmcBsPzesJ5jvZGHixewNuDvKMdpTVItm3vC
         jBjNSMafEW1Zo2IfH86HiH+PMbZUC550KDhY4Gyqulqs1Lr5XtL2oeDvlDFWsjD7DtfH
         oZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001491; x=1786606291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0kLjzVMGQP2GDl+xLrm6TwqzVKVcj9RXEl6sHzZBCM=;
        b=IVXpSj4Hvz99m5L4s9n5X0xvs2rz/kHK0LS0+gk0bUE9dclGuQYAIghFBVHCDtep0P
         okw1tyPauYqI2Z677tHTYllhFC5aa71Zo6wrf6TP+g2wcbLHFFHBWdYRLatmOYG3gs7n
         1NV2MrYILXSr8mSEKlPLv8ZeJr7rGVIhT4xTQxKtV84lBj3ucWqbbhEWZjWbvMYt88/5
         kJ/4HZUQeOS1zEwpBH0d1rQdzvEZWYaNghRmv6SRDpbSvhirnQWhtLJDV7epcRVs5H4t
         kSkLxpLdlYSRyb4gcUFFe4ZaeXv5HBaB76gV6UBjJSHM31yx2tb/8sRSyeebFP9ifdVO
         2T7w==
X-Forwarded-Encrypted: i=1; AHgh+RpUvB1SVUT+MrzWer1F+qldACKdRv3moLCj9whSmll9UuVHBhpYmDXbjEvvuYdzTIKhcwGqW8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1WACdZSR8HWjolEfhAkPa3VMq/etMIb+0UAE/CbP9qi36uzP
	wk0DDmCfDZ1swDs/9vUGcmBUMiuh92P/QDOH9KTsxrZjjE4NsB8jmw1hGVK8IpkU
X-Gm-Gg: AR+sD10xCAOahak7bfumf+DTUHpI2Um+Z9fmxcDRjV6ruWz4MdMyfrca6WfkzDVZdiv
	Sv/wEccHLlLRRshUjUnNVdVCtTbNVTx1P4smtUbMKhN2D8YUrq1w0j9YnuZ856fZMoSTzwZBLR0
	7rW4nn+mpZwbh3Hyo6gUqaAZKZBnUSGbB7JR6ja2DiX6XOnmtNzXzbs3yHxRi79o2eEd+tK4dr7
	YSzXiC/KX4mwCmV4a8hASvsvujAWHq05BeOLhqRPckNObnHFvjcxDXqg5kjskSgQ+FcgIKsIWPG
	46tl8KFzNmzYELUaSa8CDdRvm8Lx13t3N63T1bEYYS5PPGzbcN9o3+aXYzu7gmn9EpnuP4ZECl/
	gd2iXA9V1AvfzJ1UMlJ5cLsrQn51GJekbDoylh7uahMaakGHB5vmkKY2J+SgEvt2eTzwn7fHFlm
	ifumCNAwjAGffEIQuLYRRgt3uZRPawElQg+64JPM5XdEUB8O4Ucc/r2Yn2DoDTjLzcq6pVbDi+2
	Q==
X-Received: by 2002:a05:600c:a206:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-4994e7ccadbmr109314435e9.11.1786001490746;
        Thu, 06 Aug 2026 00:31:30 -0700 (PDT)
Received: from SVR.localdomain ([86.106.74.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e52d819sm79075085e9.1.2026.08.06.00.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:31:30 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on standalone ports
Date: Thu,  6 Aug 2026 10:31:18 +0300
Message-ID: <20260806073119.387-2-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806073119.387-1-strst.gs@gmail.com>
References: <20260806073119.387-1-strst.gs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some switches cannot deliver a tagged frame to the CPU while its VID is
absent from the VLAN table, not even with VLAN filtering turned off.
b53 is one of them: its VID lookup is always active, and disabling it
moves the ARL to shared VLAN learning, where ARL operations force VID 0
and the hardware table drifts away from the bridge fdb. On such
hardware a standalone port can only receive the traffic of its 8021q
uppers if their VIDs are programmed into the table.

The existing opt-in for this class of problem,
ds->needs_standalone_vlan_filtering, delivers those VIDs but does more:
dsa_port_reset_vlan_filtering() also forces vlan_filtering=1 on a port
that leaves a VLAN-unaware bridge. hellcreek wants exactly that. b53
must not have it, because it sets vlan_filtering_is_global, so the
forced flip would turn the whole switch into a VLAN filtering device
the first time any port leaves a VLAN-unaware bridge and change
behaviour for every other port.

Add ds->needs_standalone_vlan_offload for the narrower need. It
advertises NETIF_F_HW_VLAN_CTAG_FILTER on user ports, so the 8021q
layer reports upper VIDs to .port_vlan_add, and it leaves the
vlan_filtering state alone.

Upper offload of such a switch never depends on vlan_filtering: every
VID was already delivered when the upper was created, since the
feature bit is always on. dsa_port_vlan_filtering() therefore skips
its ports entirely when a bridge toggles VLAN awareness. Restoring
them on the way up would add VIDs that were never cleared, and
clearing them on the way down would strip the driver's record of a
bridged port's uppers and the feature bit, leaving a port that later
leaves the bridge with uppers that cannot receive and no way to
re-offload them. The conduit change path keeps its explicit teardown
and restore of standalone VLANs, and now also runs it for a standalone
port of such a switch while VLAN filtering is off, because that port
has VLANs on the CPU port too.

The Fixes tag is for backport dependency tracking: the b53 fix in the
next patch needs this flag to exist.

Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
Cc: stable@vger.kernel.org
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
 include/net/dsa.h |  3 +++
 net/dsa/port.c    | 21 ++++++++++++++-------
 net/dsa/user.c    |  4 +++-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6f7f5c17b532..6f3a60c23d14 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -403,6 +403,9 @@ struct dsa_switch {
 	/* Keep VLAN filtering enabled on ports not offloading any upper */
 	u32			needs_standalone_vlan_filtering:1;
 
+	/* Offload 8021q uppers of standalone ports even when not filtering */
+	u32			needs_standalone_vlan_offload:1;
+
 	/* Pass .port_vlan_add and .port_vlan_del to drivers even for bridges
 	 * that have vlan_filtering=0. All drivers should ideally set this (and
 	 * then the option would get removed), but it is unknown whether this
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc..23d1c5ae6934 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -831,6 +831,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			if (!user)
 				continue;
 
+			if (ds->needs_standalone_vlan_offload)
+				continue;
+
 			err = dsa_user_manage_vlan_filtering(user,
 							     vlan_filtering);
 			if (err)
@@ -839,10 +842,12 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 	} else {
 		dp->vlan_filtering = vlan_filtering;
 
-		err = dsa_user_manage_vlan_filtering(dp->user,
-						     vlan_filtering);
-		if (err)
-			goto restore;
+		if (!ds->needs_standalone_vlan_offload) {
+			err = dsa_user_manage_vlan_filtering(dp->user,
+							     vlan_filtering);
+			if (err)
+				goto restore;
+		}
 	}
 
 	return 0;
@@ -1445,10 +1450,12 @@ int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
 
 	/* The port might still be VLAN filtering even if it's no longer
 	 * under a bridge, either due to ds->vlan_filtering_is_global or
-	 * ds->needs_standalone_vlan_filtering. In turn this means VLANs
-	 * on the CPU port.
+	 * ds->needs_standalone_vlan_filtering, and standalone ports of a
+	 * ds->needs_standalone_vlan_offload switch keep their VLANs without
+	 * filtering. In turn this means VLANs on the CPU port.
 	 */
-	vlan_filtering = dsa_port_is_vlan_filtering(dp);
+	vlan_filtering = dsa_port_is_vlan_filtering(dp) ||
+			 (ds->needs_standalone_vlan_offload && !bridge_dev);
 	if (vlan_filtering) {
 		err = dsa_user_manage_vlan_filtering(dev, false);
 		if (err) {
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 03c7af6abe18..2b1695b386ef 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1946,6 +1946,7 @@ static int dsa_user_clear_vlan(struct net_device *vdev, int vid, void *arg)
  *
  * - If standalone (this includes software bridge, software LAG):
  *     - if ds->needs_standalone_vlan_filtering = true, OR if
+ *       ds->needs_standalone_vlan_offload = true, OR if
  *       (ds->vlan_filtering_is_global = true AND there are bridges spanning
  *       this switch chip which have vlan_filtering=1)
  *         - the 8021q upper VLANs
@@ -2718,7 +2719,8 @@ void dsa_user_setup_tagger(struct net_device *user)
 	user->hw_features |= NETIF_F_HW_TC;
 	if (user->needed_tailroom)
 		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
-	if (ds->needs_standalone_vlan_filtering)
+	if (ds->needs_standalone_vlan_filtering ||
+	    ds->needs_standalone_vlan_offload)
 		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	user->lltx = true;
