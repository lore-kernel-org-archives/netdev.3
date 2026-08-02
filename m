Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9443ACA5D
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685598; cv=none; b=e27iFX5TMIfO4Amf0QnNCw30+33431gCAm+Wi3xOtzRCFYRBaL1or7EnQ1GLs7+7yDIgy7hwNVWYz+iUmZchEdeD6hqmV9YwMm3YT1t5ju7OqX+niXvF8f9a9i0ffV1zqjgwfOI5w86fkCY7oLPJHCbO15kJzTQG+GcHPNm7q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685598; c=relaxed/simple;
	bh=Mv2fB5QTMgzygfKi4oX9eQwPWNNkjLy2vCUnRHb4K0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCcUlBrtrz3o9nW7rggYyMOTncYXczYQRsgUDlJqz9q3tRPLAva5NpolZwkgTa3Ral0xHpEEKJ9TJneU6I99ql/5AGJH4RZJLB2USGbSjI/2KFmmbrcXXlt124T9cUJ46rbzMKnKw7JK998/zIljz3Dmv4C9o4Az/t3PC8PwxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMFtgvkJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMFtgvkJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2071643a12.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785685592; x=1786290392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXjf3n6y2o2sUp9ziyNWD3SU5x1Q1/QeHjG5pG2QUDY=;
        b=qMFtgvkJilu1Jb47IbDRWK0rgi8TfMB5dhX6YvSrkBWuPak0x9hqM1OXUoYHH4UsXq
         PWsKri8MRpuqN82Zifecsb4yB5xkRHZvS4dQLxWA9or7mtRec92uPOYU2IiAcf+K4lUR
         y7Cq8/W8dlzViTzq2o5GmjYvkg8GGbpF51J46oVLpfIOOgG1zZIQc9AhYs5lqzbIhZcd
         OIrEXtp4MMnfbl7fONSFA04QQ4epgrwWzD1FKLAtYkpCp6+zB6Tu8kLVQpJ8ESlBX5r1
         5T++mjmoN5NNJn6dPlyhAoEaHoHN1Wv/g+3vzJiI+Pn/vRlWDbRQMRtYJHlRCezLX3qk
         QwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785685592; x=1786290392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXjf3n6y2o2sUp9ziyNWD3SU5x1Q1/QeHjG5pG2QUDY=;
        b=hCQm5cdokhwlHz4+hW7gaIAMVR2BcI5v+X77QITRfsQtJ+OjIqmIs30QQy7z3MCTKj
         +kqQ6VPUCYXDOtn0gTuvgP0ZFLtM/3DnXloOErrDW2hzXZbLuydxC6Osq/DKHLnJ92M+
         DNDGZdsfAqAf/oW9Y7StT4nBCt9mWqOaBS79vPXUpghMTu6hc6hzvpvaQnpTLEsPFTEZ
         G88nych2Pk+IGj5wOYSXhEmmQgbLlaoEEKFfp2RrmlY1xixsovwyKp8eI3Yo/z9mZWWd
         9f2cg7dITVsWuacNsvlZL8KmVHAiBJ4ry6HbrW6GL+5z9zCq6iCj7BFCNo+aZVElDmip
         VdzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRDG1HH0VKDUApa9Hgz7DNy/AEUUH6ZgAeDPlrQmHzMougVT7nN3sYPsB6BZaBCuLERVOs5kM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4gT4Us3id+dWUqwuIh3V7PT8JUyCWgeRiK6Qkpn0GnhTKdAI
	W6HESRweF5xyC1dHV0A5KABLGIgvdFbiH5+BjPj5vDyHzMC1vItbTlW8
X-Gm-Gg: AR+sD13AEopqkGnbrZk6OMPA2u40Fop13JO/eJAAAIOFqw2gDnV4AvkF/Z3jso4UMWe
	a7SxQFLuRc+Qvu33VIH1UM8MPIrUcfLBDlfFcHmis8L6qH3uFUxmFbFjVOpqbJhH4x84rbrNr9r
	3/lu2WfK9p+gufGmCkMNit+I/yarZtjiFT+IpFvsXZRpw3kyY7yhNU4l8ynR1W/RLWZbY5NrmPF
	GLyRShA8xLFPRMR3jV5trXwjfIYrhH9gzH2xtnRi6SavNLVvpcmkTeT2oPf7IpD0vXeJFYDfm4L
	A3VsMHU9u6WHMrlb2c80vE10EfHL6r1MQ8UmIJ7+oena1qrpc213dcFfos7eYbAJkQ1RAujGUxk
	hOXmbDoYK9bcIdIhWGHfsj/8pNV0GRMO+piOlxkQ5mHbJlqkTQBiAp+dHNMmjk5NxCVFj9Ov6xB
	buNFIINR6+YNqqMHmMYxPwrWhXjzXEd5bzvOEqBvL0o+PESG2mOQ2dfz34qFPr04QHY/D5bVy0n
	yXcgs8ALgpYjWQTDwcSRIZPIH/oupZdjrWXhPo=
X-Received: by 2002:a05:6a21:7a95:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3c92a89c7bbmr7671642637.36.1785685592428;
        Sun, 02 Aug 2026 08:46:32 -0700 (PDT)
Received: from Mac.net (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm30602192eec.31.2026.08.02.08.46.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 08:46:31 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [RFC net-next 3/4] i2c: mux: Propagate software nodes to channel adapters
Date: Sun,  2 Aug 2026 08:46:19 -0700
Message-ID: <3e76f1dc25b104a2c8558142c12e23b297f9c58c.1785684064.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1785684064.git.ahmadexp@gmail.com>
References: <cover.1785684064.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent software-node descriptions are not.

Find the software-node child whose reg value matches the channel and
assign it to the new adapter. Keep a reference for the adapter lifetime
so downstream clients can find the channel by firmware node.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c2..1e587ea4e 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -264,6 +265,49 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct fwnode_handle *
+i2c_mux_get_channel_swnode(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
+	struct fwnode_handle *mux_node, *child = NULL;
+	u32 reg;
+
+	if (!is_software_node(dev_node))
+		return NULL;
+
+	if (muxc->arbitrator)
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-arb");
+	else if (muxc->gate)
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-gate");
+	else
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-mux");
+
+	if (mux_node) {
+		/* A "reg" property indicates an old-style firmware entry. */
+		if (!fwnode_property_read_u32(mux_node, "reg", &reg)) {
+			fwnode_handle_put(mux_node);
+			mux_node = NULL;
+		}
+	}
+
+	if (!mux_node)
+		mux_node = fwnode_handle_get(dev_node);
+	else if (muxc->arbitrator || muxc->gate)
+		child = fwnode_handle_get(mux_node);
+
+	if (!child) {
+		fwnode_for_each_child_node(mux_node, child) {
+			if (fwnode_property_read_u32(child, "reg", &reg))
+				continue;
+			if (chan_id == reg)
+				break;
+		}
+	}
+
+	fwnode_handle_put(mux_node);
+	return child;
+}
+
 int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			u32 force_nr, u32 chan_id)
 {
@@ -364,6 +408,12 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 
 		priv->adap.dev.of_node = child;
 		of_node_put(mux_node);
+	} else {
+		struct fwnode_handle *fwnode;
+
+		fwnode = i2c_mux_get_channel_swnode(muxc, chan_id);
+		if (fwnode)
+			device_set_node(&priv->adap.dev, fwnode);
 	}
 
 	/*
@@ -408,6 +458,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
+	if (is_software_node(dev_fwnode(&priv->adap.dev)))
+		fwnode_handle_put(dev_fwnode(&priv->adap.dev));
 	kfree(priv);
 	return ret;
 }
@@ -420,6 +472,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
+		struct fwnode_handle *fwnode = dev_fwnode(&adap->dev);
 		struct device_node *np = adap->dev.of_node;
 
 		muxc->adapter[muxc->num_adapters] = NULL;
@@ -430,6 +483,8 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
+		if (is_software_node(fwnode))
+			fwnode_handle_put(fwnode);
 		of_node_put(np);
 		kfree(priv);
 	}
-- 
2.50.1 (Apple Git-155)

