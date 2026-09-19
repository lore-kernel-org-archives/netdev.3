Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312F380FDB
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857274; cv=none; b=KbP5H2cy6O57pLebw7F5yUonNh8D+S30uJJYAr84DOnavfK1/Etjxzw16nCgWMeEDt7piQuphdNIG/u8apiVjTNRD8EXz31J4iMeRO50MoOSlJZekHQ6A32NPi39cJolhWoziWeoeMJP/1jI7wEavW9varO/bRbgGyUI7EM6o7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857274; c=relaxed/simple;
	bh=JBFXLhzHo1/W1XkPNm2f8N0vTk0jOx/ouyfoD7ChHO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGCWKlX+Iv2r9xbtPRiF5Dd2s5bbfzpyHavOn6Z7fOcceVW3Kg80WZggVbJ4WZxYY+aCidauSjuiPYgQDqNhXonzRAU8+3PTEQELnZ3lRIP+sIs+oTkZ2MEQadAKikDGsd1QckwRaozMQmLvxJlSqN9PH7OC3uo9PtS8o3Wnf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPNNRoMq; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPNNRoMq"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso1493509a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857272; x=1790462072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p69PMisrwCoU7hEWrCmi5c9SKhhm9fMhot3qveIvDqE=;
        b=hPNNRoMqOTAybRv25/lCPrzpQMX/DMfmmGUfd5bV48aB7u5W4E3EbrHoejbAwAFerm
         RQEzB/CiZJYuAnems7gGtLrJUXsXdDKMy8j9IsRmqdbY2Kw1cE7J/2cCa+K4LXOIgxhA
         kPrmHMuLP/cDrXXKf3hR6SK6VrtgaQrqHjpD6oy3U4L9rzMpEyRAunt4kNmybRQyy0el
         Nld97WY+YEFwpnAU4ppaYtidI1lztbdRiGnduGpRnAsWHep3vqMsG7gN4qgQRBLq2/6d
         Cw6bQPtnaJaijKfq1tTrwSoFL4GDU6KYYt6/jundHrn6NriOIvDeFTpwx/RYyILqW/I0
         8qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857272; x=1790462072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p69PMisrwCoU7hEWrCmi5c9SKhhm9fMhot3qveIvDqE=;
        b=nShuSdZhprpqV2twCwlk2dYanDyheibRbEoToHN2vteV8ya5Hc09FTY7jxDBrLYOUU
         9cbFCF9c58fPUPVFPacG1D5Gfl6BKdAC+mrZ26hymFG5s+BXB+CG9rpbKLC7AsMvNX0a
         WX8ypoLE17ZTniIMrxFShSltGI+U9dtCb8tAwkGvD7RPX4sMYfPrPfxdeYBGNh98bXY/
         hlNWKSxq3tfJHtFtyb1oV+xsPU++BeCL0i4oDf+URGn3DKhxNzc/+nJaY7rHmc3loBQp
         eeHaq1RVOts1M4BBRdDqx/8Hh7XEPMklarjTutH3JPLG7h7loq0o2lyP0qijVkZtNI3Q
         X7UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIeiwbYsMJ5nPzMm6yWlMbGIGnQCsQQTzEvKpGWpILrk2CdouvT60vIa7tYOJgOzw4OxLmS8U=@vger.kernel.org
X-Gm-Message-State: AFuF++k30BqRtx1dLBiorGM6U8A+7mqgESrVbxS9JW/uullcx8R71MkM
	cbOyzBpe4EdjsbcDDxk2lOI98Kqxhu9oj/SkKmkz9SpvJT1kmjKrnnbl
X-Gm-Gg: AYBFou3BBKFW3bDJFSFgcrc3UglyUU6Du5ia7Vi2rY4yHuINV/PQt+36EH/4sut61NB
	Qa0ZTKZPDqoprrUQc1LqJQBDiZqcSB0FBT9b0mziK5AkasyWXQyvhAJFWxgGX4YyM89ou/jYfAs
	hgHXCWWk8WS6EaHximi380XukpL1H4sSsjd4VufjJFZo/3alwRCQK+omAMhrefTC0fqxeqtG7zl
	DF01FNq/0alkDqdx4tBxyUxUaLimYIqnlVgrhc3Z1Y0Irke40IyLyOmU0JhZEREFU6fcyNNJa6K
	cPnxuIwcjJSg/G0E+v1t0MPnYcJMRBu/q7zh5OEnaAA4jCYKFsj9r2pFwEqxSUXeLO8E2Tw9Nal
	G1SAReQ2dGrbhl0hwxbCOn/E0nP6hnOV8TZ621C74hqQVI1ZEJBxFk7EV9H85wdafc0fQE+8HK6
	YrKqoGF87CkJuCxXdC2N7gCu7L6gC3rIdQOjkoJizhYxrZ2HrdJ0mlmyd2K3B1giUPSqaoVFdVT
	Pm6NOV6uYPxXbYZosxcEPFvDVbhq4hIXoNuv4So9U2uBKux2aTIN0wHPuEjsdMaWrISRzdlvGLw
	9lsB8wdj1g==
X-Received: by 2002:a17:90b:4a03:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-39e54d38c48mr16282630a91.8.1789857271719;
        Sat, 19 Sep 2026 15:34:31 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm6339035a91.9.2026.09.19.15.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:31 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: 3chas3@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atm: br2684, pppoatm: add missing pskb_may_pull() and headroom checks
Date: Sat, 19 Sep 2026 22:34:31 +0000
Message-ID: <20260919223431.3882212-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In net/atm/br2684.c and net/atm/pppoatm.c, verify packet header lengths
with pskb_may_pull() on receive and ensure sufficient skb headroom via
skb_cow_head() before skb_push() on transmit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index 05712c28386a..4e397b1a3a27 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -369,8 +369,11 @@ static int br2684_setfilt(struct atm_vcc *atmvcc, void __user * arg)
 		 * by device.
 		 */
 		struct br2684_dev *brdev;
+		struct net_device *net_dev;
+
 		read_lock(&devs_lock);
-		brdev = BRPRIV(br2684_find_dev(&fs.ifspec));
+		net_dev = br2684_find_dev(&fs.ifspec);
+		brdev = net_dev ? BRPRIV(net_dev) : NULL;
 		if (brdev == NULL || list_empty(&brdev->brvccs) ||
 		    brdev->brvccs.next != brdev->brvccs.prev)	/* >1 VCC */
 			brvcc = NULL;
@@ -392,6 +395,7 @@ packet_fails_filter(__be16 type, struct br2684_vcc *brvcc, struct sk_buff *skb)
 	if (brvcc->filter.netmask == 0)
 		return 0;	/* no filter in place */
 	if (type == htons(ETH_P_IP) &&
+	    pskb_may_pull(skb, sizeof(struct iphdr)) &&
 	    (((struct iphdr *)(skb->data))->daddr & brvcc->filter.
 	     netmask) == brvcc->filter.prefix)
 		return 0;
@@ -449,7 +453,7 @@ static void br2684_push(struct atm_vcc *atmvcc, struct sk_buff *skb)
 			__skb_trim(skb, skb->len - 4);
 
 		/* accept packets that have "ipv[46]" in the snap header */
-		if ((skb->len >= (sizeof(llc_oui_ipv4))) &&
+		if (pskb_may_pull(skb, sizeof(llc_oui_ipv4)) &&
 		    (memcmp(skb->data, llc_oui_ipv4,
 			    sizeof(llc_oui_ipv4) - BR2684_ETHERTYPE_LEN) == 0)) {
 			if (memcmp(skb->data + 6, ethertype_ipv6,
@@ -468,7 +472,7 @@ static void br2684_push(struct atm_vcc *atmvcc, struct sk_buff *skb)
 		 * Note, that only 7 char is checked so frames with a valid FCS
 		 * are also accepted (but FCS is not checked of course).
 		 */
-		} else if ((skb->len >= sizeof(llc_oui_pid_pad)) &&
+		} else if (pskb_may_pull(skb, sizeof(llc_oui_pid_pad) + ETH_HLEN) &&
 			   (memcmp(skb->data, llc_oui_pid_pad, 7) == 0)) {
 			skb_pull(skb, sizeof(llc_oui_pid_pad));
 			skb->protocol = eth_type_trans(skb, net_dev);
@@ -479,6 +483,8 @@ static void br2684_push(struct atm_vcc *atmvcc, struct sk_buff *skb)
 		if (brdev->payload == p_routed) {
 			struct iphdr *iph;
 
+			if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+				goto dropped;
 			skb_reset_network_header(skb);
 			iph = ip_hdr(skb);
 			if (iph->version == 4)
@@ -489,6 +495,8 @@ static void br2684_push(struct atm_vcc *atmvcc, struct sk_buff *skb)
 				goto error;
 			skb->pkt_type = PACKET_HOST;
 		} else { /* p_bridged */
+			if (!pskb_may_pull(skb, BR2684_PAD_LEN + ETH_HLEN))
+				goto dropped;
 			/* first 2 chars should be 0 */
 			if (memcmp(skb->data, pad, BR2684_PAD_LEN) != 0)
 				goto error;
@@ -535,6 +543,8 @@ static int br2684_regvcc(struct atm_vcc *atmvcc, void __user * arg)
 	struct atm_backend_br2684 be;
 	int err;
 
+	if (atmvcc->user_back)
+		return -EINVAL;
 	if (copy_from_user(&be, arg, sizeof be))
 		return -EFAULT;
 	brvcc = kzalloc_obj(struct br2684_vcc);
diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 5214786e61d1..c3a693e20aba 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -397,6 +397,8 @@ static int pppoatm_assign_vcc(struct atm_vcc *atmvcc, void __user *arg)
 	atomic_set(&pvcc->inflight, NONE_INFLIGHT);
 	pvcc->old_push = atmvcc->push;
 	pvcc->old_pop = atmvcc->pop;
+	if (atmvcc->user_back)
+		return -EINVAL;
 	pvcc->old_owner = atmvcc->owner;
 	pvcc->old_release_cb = atmvcc->release_cb;
 	pvcc->encaps = (enum pppoatm_encaps) be.encaps;
