Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED844F557
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752509; cv=none; b=qTuSNkSxYapy7agX6Qiz/2cVvWV4cJHRMJViuDYAIWOe0EG3h5JO7fIxjNjEcb8DqJflRYTh9lgHUVDBA4+0grBlD+xyrvnIiHuumxqLN8zIXa+a2J9fTwijNJZR08eycKtoUEvafKozb8MrtsXnDtP5G8Z8L8hQtab/FIO+UMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752509; c=relaxed/simple;
	bh=bWE9ofDX9CCpzagYpyK7ryLzafK2njjC+bGI8hqcJSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lx/4Q/XtsQRPIsDNhMLG1/VvHEVY24Eh9iUMpNyCR+BWewpnn+0l676A6GU3D2oIh78VHDRGvoNFGNphWCyf5WYc5BnuasKTB7TJtJQlGnGzvihwH7P57tiNerfrkDmu2wIQYe4jRTfRwEKdadifK9sztGroyKxCz1R5e9RCckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TQP7i/yY; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TQP7i/yY"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so2906055f8f.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752502; x=1791357302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh5ZySD4TgiYlccRMgkd8gbGRWxAVqs9TX0Efg3qKOU=;
        b=TQP7i/yYK6lv7tmox1EO78qUf9hRVNFjW7/cmJ/kcUOY3oVBmRhTn3XfnGA9ZCMgeQ
         0QUZiZAAmHLREFA1m452bUtEPwuL5W7Ue1N4kTA0iziDiiEA3/3ITvBd3bnOIhJCjQg/
         Zqr4RG02j158xfTALhLB41YWH3yGggkcBdOTl6NGArjzs9fjgkW0IXfY8VxT/GYycNiL
         VfCdx0ChDfClMKV3b1zVsIU6CZfFPyS9k0X3K+umaJB9uYImK+JwQS8ZGwYd7MMkyi1a
         RXAU8SBx0cY1DJZahFj0KggJ92sTTY/DCAtnmNjOo7/ubu8iB4PHeysvtWa+WND1hyTr
         BZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752502; x=1791357302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wh5ZySD4TgiYlccRMgkd8gbGRWxAVqs9TX0Efg3qKOU=;
        b=eQ50ZM/Mo4IXgIPJFZ2BS5PmrumBTYjCO5mVhCX42H/dUB7DlDsErAu8Hj/fmNI0zQ
         9LjHgY+NnY8bVy5d+NV9gVt88OYQuZMonoe4kflwSs9XDGNNl7RYYUqErLyhup3UEY1V
         rsMcnGRgsTK3nqsTGS0RwBRjMA6ZO7JzQHXF+laJW7BMLdoW4j0Yrv+qgm0sG3Ya2JbM
         AP46Dnb5zrg7O8Py8gR7qDAkqqBpySEwipr1AvuRGRoW/sJFpwqG2oQOtmX2B12jIyzF
         hTdyq3SglWCqo068jShGD7kQR0AsQ1Lu3xHDPJQ/uX2s9nB9xSfV6SdFCfQcH4wN473i
         iObA==
X-Gm-Message-State: AFq9FYIuB8Rz0+eGf7lwFthZq12sw3PiLK+zcsxLQNhYSBgBEHAOadW8
	OfkK9x64+XyTs+mMH14S4JEgXx+Vf209ZV+E/oL4t8aeJp/jjQivhXwuucbyjMSJQKVeaT5VzVM
	y+/aq
X-Gm-Gg: AYBFou1gteSuOsyk10aovin6N9xmoPSrdJzxaUsAWSeVPp7K0uXWEf9Jd/pTvv47ltP
	7Sir+8t/ZsnG/EDRJT4J2cLKFtOCKcwmui/SHDkvHC4viOZzbXDOwpaiCKFjeKSBD/pyRgyoI+4
	wbXc8sRw+VVnPv3WnjDctdIazqS2Is/ntWb/SD/RBHilwtXSQgLywO+LDJznoMCRWT3gqEiHiTK
	6X83l04Wfq59VrEF88DsYnOKBr1MGQ3mzVshdB7wc/C88WMv1PV9aCh6hWRNjrLEgJJFjkH5McE
	HgN8xX8skOC9Ci4TEBsTHW5r1XWBAQFzCIEiNyPFExoYjPPSVyHse1ju6idPt7OgCAhQ8mDQp5a
	6W3y5UUVmAUx9zClL3Sr1vsRLazieCOPKsIXKrDyM/MrQ+UUVPKuWcW/YtX2V3L3tAjvASDp4xV
	bcX7QylWy5u9Hs/3oS9ShPc70EAAYu+DhfwTeysAwhFogcKJlxJNGIkLLDDLJL1GB6pV9b6zpGg
	nsXCXGtnZ6bkrfHdysl
X-Received: by 2002:a05:6000:2408:b0:48a:f432:f266 with SMTP id ffacd0b85a97d-48b02380f8amr1072223f8f.0.1790752502446;
        Wed, 30 Sep 2026 00:15:02 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b02e7b0d0sm732092f8f.14.2026.09.30.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:01 -0700 (PDT)
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
Subject: [PATCH net-next 03/12] net: bridge: add VLAN support to bridge destinations
Date: Wed, 30 Sep 2026 10:14:02 +0300
Message-ID: <20260930071411.2786201-4-razor@blackwall.org>
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

Use bit 0 to distinguish port-VLAN pointers from bridge port pointers in
struct net_bridge_dst. Add helpers for constructing and decoding VLAN
destinations. No caller creates one yet, so behavior remains unchanged.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bbb59b53e745..2bf7f4429a3b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,6 +306,8 @@ struct net_bridge_fdb_key {
 	u16 vlan_id;
 };
 
+#define BR_DST_VLAN_TAG	BIT(0)
+
 struct net_bridge_dst {
 	unsigned long __private value;
 };
@@ -702,10 +704,56 @@ br_port_to_dst(const struct net_bridge_port *p)
 	return dst;
 }
 
+static inline struct net_bridge_dst
+br_vlan_to_dst(const struct net_bridge_vlan *v)
+{
+	struct net_bridge_dst dst;
+
+	ACCESS_PRIVATE(&dst, value) = (unsigned long)v | BR_DST_VLAN_TAG;
+
+	return dst;
+}
+
+static inline void br_dst_decode(struct net_bridge_dst dst,
+				 struct net_bridge_port **port,
+				 struct net_bridge_vlan **vlan)
+{
+	struct net_bridge_vlan *v;
+	unsigned long value;
+
+	value = ACCESS_PRIVATE(&dst, value);
+	if (!(value & BR_DST_VLAN_TAG)) {
+		*port = (struct net_bridge_port *)value;
+		*vlan = NULL;
+		return;
+	}
+
+	v = (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
+	*port = v->port;
+	*vlan = v;
+}
+
 static inline struct net_bridge_port *
 br_dst_port(struct net_bridge_dst dst)
 {
-	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
+	struct net_bridge_port *p;
+	struct net_bridge_vlan *v;
+
+	br_dst_decode(dst, &p, &v);
+
+	return p;
+}
+
+static inline struct net_bridge_vlan *
+br_dst_vlan(struct net_bridge_dst dst)
+{
+	unsigned long value;
+
+	value = ACCESS_PRIVATE(&dst, value);
+	if (!(value & BR_DST_VLAN_TAG))
+		return NULL;
+
+	return (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
 }
 
 static inline struct net_bridge_dst
-- 
2.47.3

