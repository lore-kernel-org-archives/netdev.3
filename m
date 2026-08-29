Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA32361670
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788023230; cv=none; b=m2nhU9R3HtNZa/t9CIQiYN3UNSOdH+jPEFohmNzC80qsvrv8Bg0j91tY1QpqohiWBx7y299EBBGtVLOfpcJFkkJXuVsEXG5wW/FVtPr5qLH7PaY9I3VJfL5oP1aMUuYXbI//QI/SsM36NiHu8pdv3kWVyNtEHyKLGzN7CcQQJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788023230; c=relaxed/simple;
	bh=pHbnwUN3UUCK4uiyoAaioeKCV4llbaKe1YQzv4Jod+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaBoQlFSP4Qc5lww81uwzo06dif1GTzp5NDr90Xf1uUahyKwG+sakuQTjTpzOZXREkZmoflPDvTwz3ae8H6jBLtAx6vYS55qwEp90SWobYpICNDWd6fJK6Xx8WRNnf+IJwzrPRhYuVPK+HkN7aRhpnZavYz8DFxpp2KbhfA2OSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUhQOgkQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUhQOgkQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482f9309813so1234045f8f.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788023224; x=1788628024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qc1W4fex00U+eOWL5xaR6NDiG48y7mOQwn5RsxVM7a4=;
        b=fUhQOgkQ0huY0PfIjDpKtX1qwp34/hG2mIsavIkzOoZg17PInORw2E/9dkI9JWV0h6
         ZpApOoJxEDvO1ZvoD9C7JgcRm5DbFyD6oSGBqQDOSyo2/fBezZzv/wwYePwsO+5gUTCA
         KUlOSsMkQ9Oh4rh7FjYwQUXTSIDpYkCi/cccV/ISEYGdM5lB0iebrZPZLH8vG7OlrEiO
         7CqKYJwXQyon7Un/HLV+yg0ZU2f8JFnTVL5wBMw84lPT5wWTLxIHhoYTu8xyzBi94OHj
         sBDha1hvlxaDa9lSjuZnDtm3uDX2mnBPoDqVJKPusuKdb7OW/7JCtskFY39ebZ3ICv+t
         2lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788023224; x=1788628024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qc1W4fex00U+eOWL5xaR6NDiG48y7mOQwn5RsxVM7a4=;
        b=QE+6Y51MKEUxEkDGtXoPBalHA4tX4nOW0PnRsUiOAsFNNTZSf8DbSmnD/e826nXEnc
         6NmoEcotkcbbFzPyLyk/SUHtr8FxT15Ch5cx8UAuA7SL9TC/Yq/ibb4z2A5QhIoM6NTl
         2IdEFQK/HBnNKRBndCTuQcmwrVb2cskQqP4QaNqeaqgH9ivmINGom2EEzJU2aKasxDo7
         ZmRrxfydVCKPG1TVWqP//thJwszhc6CRTD71//wiJCPTIH+yMJrgfyOMprO7OfOyBd1y
         uvakVm0EAprlgcQps3ziVKEaf9ZFF3qsVgb1frTUgzdRn3fZam0fWm0SRZPrW50DDeHE
         nQVA==
X-Gm-Message-State: AFuF++kl0f/H/fs+WVLAyBKgJ4zyRjEdztEoKV2WOJUgLAnln8FbZP6y
	UqPoyM9tGLGWEFIkAY0mOBS7+ONG3jIAeYREJ+t+yuqefbQUqags0BN7MSYLXCy2
X-Gm-Gg: AYBFou1wktoadSt4Tb2FlaQEa9/duj4CfDBbjCEMInKYoRbkAAKjN45gX1sWe8ukOmt
	4PC4klD2AAlzs1qyhNyP2PB8p9z5H25rucKwLKAE/tz7/1fBIrt9gFJEHS9aAVmBfHmRgijsYrc
	DlUivFV6Le4tgQ3kPHitzw9wIwmFAKJNTb3/2CxVEtS9cMzJl5VCODTPXCrjYD3MEfixhDlMnDF
	9G0ntbN78GB0kXS/emkr8HgFviPn3/HU17MRLGHhwSYFjlUyVQUJgr8THVhJyP/VN1xmt5cDZ5H
	LOldFCTN4s/oMblVTUGd8cDS47+tGbSC7xfBWEWVPrRBxASmq3bOiaf3V09J1WUkYWNZRjpNafb
	PT1CXhtRjrLRS3Ks2xaXtQRl16uLTKf8+St4JJeZT7bkPPIwjN4ykhNGGEi4+7cU3qvSrJslLeN
	4dgggZYoIfuZUCJVKVqRS3MNn++iUVydbs/3sk9Yv4Gwdqk4obiWUlrO0tBNk341Dv9A==
X-Received: by 2002:a5d:64c5:0:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-482f7977aabmr22156144f8f.1.1788023224359;
        Sat, 29 Aug 2026 10:07:04 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.68.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbad04d4sm11936201f8f.15.2026.08.29.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 10:07:03 -0700 (PDT)
From: "user.email" <suruurism@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	horms@kernel.org
Subject: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Sat, 29 Aug 2026 20:06:56 +0300
Message-ID: <20260829170656.15548-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdifatah Suruur <suruurism@gmail.com>

An rmnet device may be created with its real device in a different
netns than the rmnet device itself (rmnet_newlink() resolves it in
link_net), and the rtnl config paths below only check CAP_NET_ADMIN
against dev_net(dev), while mutating rmnet port state attached to the
real device:

- rmnet_changelink() rewrites the endpoint mux table and
  port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
  MTU of the rmnet endpoint netdevs.
- rmnet_add_bridge() and rmnet_del_bridge(), reachable via
  ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
  port->rmnet_mode and port->bridge_ep on the real device's port; with
  bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
  forwards real-device ingress frames to it.

A caller privileged only in the rmnet device's netns can therefore
rewrite the shared cellular data-path state owned by another netns, and
steer its ingress traffic.

Gate all three with rtnl_dev_link_net_capable(), matching the "require
CAP_NET_ADMIN in the device netns for changelink" series (vxlan/geneve,
CVE-2026-68432).

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
v3:
- cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
  they mutate the same real-device port state via ndo_add_slave/
  ndo_del_slave and have no capability check of their own
- correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
  real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
  rmnet_vnd_change_mtu(), not on the real device
v2:
- drop Reported-by: (implied for the author), per Jakub Kicinski
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 78d4df55740a1..50c60e553d09f 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,14 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
+	/*
+	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	if (data[IFLA_RMNET_MUX_ID]) {
@@ -440,6 +448,14 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/*
+	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -488,7 +504,19 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/*
+	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but rmnet_unregister_bridge() below clears the bridge state of
+	 * the real device's port, which may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
-- 
2.53.0

