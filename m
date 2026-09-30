Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B923F9A13
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752503; cv=none; b=bg6g7PzRHej+PbP98nhXqiKAHa7n8gWlNfj9sllm8AIWFLcpjTa1cHNqHOQhhW9mYQYEcnWSJRL/6ujpCva8EvR1AG2ltzrN6egEuqw8paP4KbrJj7PCRceIraIRDRcgeqo/vr5XRjalR5AGoog524PE/q/ouEHlMK9qeGT+cK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752503; c=relaxed/simple;
	bh=HGcuEmCO1LQ0WKJA5UC1Yie15kNyMhHRdI2k1TnxTL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz+eEQf4McDdcNrpnICg0VNLtsS5RecU23P8yK8cdShhPwjjU/fDgJcLSmgTrGtvt6uxWXOkvJm87wiYr4j87lS2CWZ8e1bfyrO+vu+dM7h3/1kpCnr50i2RyJr3t4eMsc6lfsWHxh4v8o5cEfiB6ecC2YpCzxYltvqxd0lY0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HqqwE+yV; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HqqwE+yV"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c4f4daso158404f8f.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752497; x=1791357297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwxGLqNQgpZLReeYWZoTPk0vbZx9ySXeua7zM2Z2aLA=;
        b=HqqwE+yVGHlM0EFeFj+QLvxqLQg42zY3laB6l3lDmY/ovj2skTyTa6b7MqImCYSi0v
         V0XnME6ErefSb9xNVx2l1AAydti+qwy6c4sQ5DWbcMzM9rmjrzTiQ5+D0jvrk9atrqfj
         ddbBnM6dOcxOxl837QYO0BpdVicruNC5f5DPDVUukVZS5fRnUSxmFe0pVlWcKi1go8Jz
         wjdT8vSuHWDDUKuNoliOFN/ITPRJSpGi1KCV2MfGzg8YeBbqdlIRmDdmyHqMtCx1ZPxs
         ESMVeY4e7683j9Rp/BfERIBJ5C5mv0JFGUlyBHj7wfKWxkY7ybM/md7oSb+psqMvSmrL
         1qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752498; x=1791357298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pwxGLqNQgpZLReeYWZoTPk0vbZx9ySXeua7zM2Z2aLA=;
        b=gGXOTgp4FyMX0yyC4Tje/G7NYJopE0gY6XJSiRjGoLGgoywzu9Gc21eB9hrFqGIrvq
         DJrNcvGvBkbo1zmp/XpstbtLfrBgB1DT7zX45r++F2cA8SJofczhEm1mn0ja5LJEwdAA
         V5ng2cldX3MnIUmTaIXeJShnZN9SvIznQqsU+QHD7/BviGIJ80ATswhKkvafe3JCVA7J
         548F2uPmqyg3zmqIhZSI04iUXq27gdj7Nf90gNu5IOKRmKatdEPFSKkHLeQQWCBwgr6I
         tUTFPLY15gq+BpCcJ67UDAn4K16T4/YR4PmmTpPzTMts7hp/AnkkEmNceKkMhaWnly3w
         y64w==
X-Gm-Message-State: AFq9FYLQyqsRQra57VpzG9exl5JsgUtSO8gWfs8Yn+1WQNNMdxwjtUOK
	dwTCrUA5Q8RIGuRqK6uNdjS4XPsAU2oEL6qLh9vbgNS/ulWNKtqpShW2OfU5BxcxSghPHMQt7p7
	gw0mr
X-Gm-Gg: AYBFou2+y9AjBrQFm6Zx8IZe7SivTg4EFYLSM7zGCFZvH3Z5mJwJMUDC3CkENx6lwGz
	G+avxUbVdfLVLkhDIwhh9uaHpI59WMVmxYkaDvq9wrj380NsefUzSoi78MKCIYTKwmnKvRzdtRi
	/w/mFoGdXrQuNIg3gr+JBEIw2qNgiE2e3PGEVh83hep0NP9qa4U87AsOIJCZwWL0P4Q/ex8lGUP
	FZ+d5DfuzRcjlEqFJvHvBdFX6N1toOnuc4IfshxhlWJVLu/pLAHB7HTSAr+tgDQpae3xmJtgKcg
	wSkrnYUEkFK8X4BkIFmr+fOzzU6fzxaYjNy79b3xubtbMaDfqwbz+Q5SAvERcnTjuiOwE8l0++f
	9PHQ5jY30Mt7fSXMMZirwcCR8ImqT1/5A2opX7Z5AVTYJ6JRNzDw2B9xNlJLbfvN3w8uhohsIXy
	rBK4FtIJJrY5DclE5b0MCbokgjaSuwVvh2XhwGjaUGJ5zmbY2zX910fyq/qjm9T+TI53AN0tZwB
	N7F+msdTJBWBzFBqlXV
X-Received: by 2002:a05:6000:1788:b0:488:8ad2:e169 with SMTP id ffacd0b85a97d-48b0255cce1mr902065f8f.56.1790752497656;
        Wed, 30 Sep 2026 00:14:57 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b029d99bbsm1222968f8f.16.2026.09.30.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:14:57 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 01/12] net: bridge: introduce a bridge destination type
Date: Wed, 30 Sep 2026 10:14:00 +0300
Message-ID: <20260930071411.2786201-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an opaque destination type and helpers for representing bridge port
destinations. Using a separate structure makes raw pointer assignments and
comparisons fail at build time while marking its value member __private
makes sparse warn about accesses that bypass the helpers.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 67117fb3dc88..1146187aa2ba 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,6 +306,10 @@ struct net_bridge_fdb_key {
 	u16 vlan_id;
 };
 
+struct net_bridge_dst {
+	unsigned long __private value;
+};
+
 struct net_bridge_fdb_entry {
 	struct rhash_head		rhnode;
 	struct net_bridge_port		*dst;
@@ -670,6 +674,40 @@ struct br_input_skb_cb {
 #define br_debug(br, format, args...)			\
 	pr_debug("%s: " format,  (br)->dev->name, ##args)
 
+static inline struct net_bridge_dst
+br_dst_read(const struct net_bridge_dst *src)
+{
+	struct net_bridge_dst dst;
+
+	ACCESS_PRIVATE(&dst, value) =
+		READ_ONCE(ACCESS_PRIVATE(src, value));
+
+	return dst;
+}
+
+static inline void br_dst_write(struct net_bridge_dst *dst,
+				struct net_bridge_dst src)
+{
+	WRITE_ONCE(ACCESS_PRIVATE(dst, value),
+		   ACCESS_PRIVATE(&src, value));
+}
+
+static inline struct net_bridge_dst
+br_port_to_dst(const struct net_bridge_port *p)
+{
+	struct net_bridge_dst dst;
+
+	ACCESS_PRIVATE(&dst, value) = (unsigned long)p;
+
+	return dst;
+}
+
+static inline struct net_bridge_port *
+br_dst_port(struct net_bridge_dst dst)
+{
+	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
+}
+
 /* called under bridge lock */
 static inline int br_is_root_bridge(const struct net_bridge *br)
 {
-- 
2.47.3

