Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3137C923
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264470; cv=none; b=oZmpLAYQNs6bTJsGJw/k47xU/8CvxaP9/YGZS4SnmtZTwJPBCgH74YtDo8VqiEI6k4oB5GglsPjbhffMO2SCSkzE9godUBAG8ums+SE62YsvzWeLeVHBezb38tGRmY69g9tH+Lz/4ZJtpgm2Nh6aExU8KjinYwZd2Rf6lmpAVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264470; c=relaxed/simple;
	bh=SxImGqPf0zfqDmVkBuiZjei+0XPbUZkCD0Ehro4yeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrQegAmqxutQCZKfdZMNNr2fb7yhV+WyK2yOHLAxfX+QiUExUlY0ZU/YQfXxbixDBcEG+pS8kJ0x1fmhCXQQoxpSK1miOGwTlp7p+RT2sPA3gzPG52SJXlBu01oHd8vvOyLk7M4xfTV7qdklDWOZbIN9o+g/lxWerAQVYhaZ+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JFllWibF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JFllWibF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843e397f74so892141f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264467; x=1788869267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=JFllWibFK23zYCxMJsp6SNwSpJPHCscOJVCgDNV1KEn4lZnMrsIdpBFoFQ34d+Qcil
         1hzHSq4xxtpr1N5czlFRAXb8GLTcmzPUyqs67zclcIF+viMI2gNts8/dogoF7/ZeZ2Rb
         V1D8sl/06RXNaEgJ68IpCLLWz7TppCNnUN+6F+UYmPKKvICErs6OEZ4aZGWdGBp38SKZ
         Ul5jOt+Jj5iiT1tFUDV7t4EbkGAa1E+u+pI4SYgYJMFAv89ppxWbgxEAS8P5stkqaD7I
         MrKct3sdl7rTTisvzxYFwdrLy0RCYteZ1HwTY+MDJz2rzMn3ZbBXYPLVqurJ8pEIAops
         Jzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264467; x=1788869267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=fcZNbDy016aZU6+8BYlhWFxlxaHhBOJU8qc7n2D2jEFV6LDgR1l3e7hO/i0TW8wl2+
         6nPN9/YiAG0nNNKrTB6sn4/l7j1yZTyWznwCxh/ocX9dcw2f73RndiyzZLBf8WfUF9i8
         Pje1G5dgy80p5SUVjGz7/sLylFslgVBYkcOqCTIsGqzfqZA6j9NAf90lL/nP5oAINLg4
         vhWhZ3EkCcBWDeWCJHyQWongxV+OYroS6zMxpNBY+yFkl3L4LY6SyiNBizV2HhE8PYjs
         l+crkhKVbr056eyBGPFrqaAtKDdVFktL82osVmEKtFLQYuEX6j1AR4uTL1k1Vt6v+EwC
         eZEg==
X-Gm-Message-State: AFuF++mn1xsm+CGv4iPy+mNSBFNAJC2Te8m7EWX/CrX34rbgoaip5lkX
	zeMwD6JoQNLCj9ZX0KMuJGH/29nGUFlSX0OA3fUH+mENmI2jNnzSOdokWYkNWtsEv/YLcalN7a/
	TmXQYksFZkA==
X-Gm-Gg: AYBFou3bpgtP8pzuZFHSlOq4SVf5pY+2qaUn6VptM7u5i5lYnWuLW13gRFH/DDlMRZS
	AcY1nLXK4sJ9665RyCOC0HkyvBT7r8NMU9PmznhtHzhe41AUQRA2YicBRFvYU3q8udOewoz7DOo
	yWw+RZ6KEepv7Qoh9IUt4VNHphC1k+4/GD9GtVqR0pj1M5R0I2EJ/rysLOH2aLjmZX2jWTj+NxI
	Ht0RfJQwqQgiuro1aXofFVa0cZHy0eOgISDKDX/Vd/ue/LzONApIhrtmLqmTW8wliKeoVPi0Wqh
	V/bg5YbkomgJLPrvcyjvqvZbPl5AwEqlSn3dco3lZ+j703B54A8TfUTYZbDF+BAoXcpzwOIWeqw
	QfndMT7lGmWQbzKHO66518X4qOiXvY/3iEdolmTXe9YJGhTrMMNonaA4RzUVRl02wZQKKIg/9DZ
	KZESF65EMpth3/SAuXFGaw1N0CocIHBcTCNSzuVHNxd0m9pNKN6XxGJOJ9Jk4aeASYepJQHtre3
	l4kZ9LGI3c=
X-Received: by 2002:a05:6000:46cf:b0:484:44ec:2c3a with SMTP id ffacd0b85a97d-48444ec2e31mr5495395f8f.0.1788264467369;
        Tue, 01 Sep 2026 05:07:47 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d78444sm5108478f8f.25.2026.09.01.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:46 -0700 (PDT)
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
Subject: [PATCH net-next 7/9] net: bridge: vlan: annotate lockless use of msti
Date: Tue,  1 Sep 2026 15:07:19 +0300
Message-ID: <20260901120721.747908-8-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate data races around vlan msti field, it can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 95e49ec8065e..76a5bf287578 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -123,7 +123,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 
 	err = 0;
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (v->brvlan->msti != msti)
+		if (READ_ONCE(v->brvlan->msti) != msti)
 			continue;
 
 		br_mst_vlan_set_state(vg, v, state);
@@ -176,7 +176,7 @@ int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	mv->msti = msti;
+	WRITE_ONCE(mv->msti, msti);
 
 	list_for_each_entry(p, &mv->br->port_list, list) {
 		vg = nbp_vlan_group(p);
@@ -249,7 +249,9 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 	sz = nla_total_size(0);
 
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (test_bit(v->brvlan->msti, seen))
+		u16 msti = READ_ONCE(v->brvlan->msti);
+
+		if (test_bit(msti, seen))
 			continue;
 
 		/* IFLA_BRIDGE_MST_ENTRY */
@@ -259,7 +261,7 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 			/* IFLA_BRIDGE_MST_ENTRY_STATE */
 			nla_total_size(sizeof(u8));
 
-		__set_bit(v->brvlan->msti, seen);
+		__set_bit(msti, seen);
 	}
 
 	return sz;
-- 
2.47.3

