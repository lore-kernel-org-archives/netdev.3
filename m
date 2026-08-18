Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BB373BEC
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036355; cv=none; b=Y3zahqURU/wjLfxp4OTBXoZs5zTy0HB1V+PNRiQxpuVaESMYuFAvflGwfs1EfA7mkAOL7WvAMbH7uW1WBaCzQyotG4FsVwBrLuG+G14vnDMbPKnulXCQX6lhE929dsGrWB61KWaeyMCV/B5TwFQ+s/MVfnI9lKZnYC3fPM5AMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036355; c=relaxed/simple;
	bh=SLr+JPD8H966PGr8RyYk2O8cefQBW1MdDmP/zvdAFJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwmWxe3z/XGL1gCi0bAtjdAudo4ksPpMptqRg/qoQ/d+ziizhjRilvXI7Ebghw7RRuP7B6DP5ky/AhG/mBIG14FrLuFiyrCKwSpu2O94qFadOMu45Sr3bFcDU/jx1T5Md8QqE/FYRwriFK+y5dhRlkPmsLBa6N7nbdFfTbs70Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkSUF887; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkSUF887"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ecd7216cso2290965a34.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036344; x=1787641144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6S7/HfEeviYM8kMOUgFBBnP6TBKiphaRKUEmhxWElI=;
        b=kkSUF887ByQz4NXUX4s2grAHVfN7ju+RAeK0yzOPE72JR46kGGHjeHPUvGPNpKHEdo
         CuUnxht4qJQNKqtyzjZCFBWoIWXdBwP1D2D3zWoLcT/SRRZdpRp/SNszzwphLIQNawES
         Jsejq/oH6rIfLg9MvsTDHQQ2WRjtgD+CCZRWIcXbIJGgujz8TvSQh4CFoweSiVw8bQaH
         q6xtFLM7QCPSf+h46B5GGl9/MUaPEDNPzN/Sl7vPWWQQV/PXCFj3rWwynQBJRxAdnpO7
         05Rgmeg0M2t78jnzDPHSnxuE3TkrgQUoTgIzYC3YdmW7uDhMUHUTrf2GkrGrCmThvrNn
         eMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036344; x=1787641144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6S7/HfEeviYM8kMOUgFBBnP6TBKiphaRKUEmhxWElI=;
        b=cVJzwksIAVE7NGi89dyLOyAwwvpLi41tbnw3WAYuqZHpbtsgaUHKQJsmYsMW6zbtm/
         UGyfEQdI1+AkF7trDYhBIA2+pR5yc2Mwx/iArQOOrYU3/6i/YGLWjTVBP0rdI9hOXNbX
         xIOokkHIdbazMZ6gCi2Cp025vO7NE7eINhL6r47dAxhRBR8HJGt4oPnrQ4lsQtV+g5LF
         QbyAFj2E25g4a6Ez7Xu5DgKPaMhRccRGhAXQ/haoAMSj69jQNUTS8HWlXXzuRs2x+u2k
         57FsMtIo27xh1R497fSEK4n/DfkGwdW1fMgimOzJnWBes9TfZw/YfaWhvg7e5iJ+4mCa
         CC6g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7fSNWtMy7ojg4C8/aq8/FxEM67SVYwiwG1r3Bx1k8M1Vf3ozBC2xNL/PQ6PajjfTwt3Ubj8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMIGFqFXZ8nutYwRz/FfEAvIRRyWjFFuXjoQ9wb05jdcGxlpo
	ZEcsUxLq/6wGojjKXtNvDlJQ4OID8lPIFV9iT56QQ/4Z7e4RyUh6Vuce
X-Gm-Gg: AR+sD118S3pT50auyPY/EyYNm8PWwkKX6BYhyJvRh9GfZIDmk0YfM+6ME8SWuOshW3h
	XAlpdIdF6pi6lJuAJTrMmX1j8G+RPDNJqJwr9xNZXI3ExMNbc6xlQbpSyhSWVZhSWinGyZlP7Kt
	8LVgEHZQcHxpijPEO7L2yvwVNpdCRcWT4aX9qsePgQopX2syR7B+BdnA0yt3w/PPymSu1f1ElPM
	TBYJBMQBWMoz81L1bhfCsSZwjT42DJ63kNWh+tD7sszX7i3RyNa8qWKiSFwtrYSUX1q+ffXzyuT
	ffuooKnCrjkRkYtAcsUwk3POLeQdGgy1kr+CZ683wq4x9NPLfX7O97iC9vNDZ7YHjOJ9rJZ0mMP
	eAcm2Rpkg30OiMzGukS0rbLCxscGstA4gTVmLRKZef4xzLJPqmuqK9tBKG/b5g+UBfov6ZYwUDN
	At2gT3O/nqAUOCpmcX2KIc5oOORoRXoJpsUqf6OJxOhKPFVVeCfIrz5AAjHWy9mfqwJBYMpmW/Y
	2v23L5GBQCJm1DvTVwxfnueONn6o8Tsy2Lvb05nv6D54LB9d7Nae9Zh2cZ/1awGaPTfr7RUGXq/
	jYUUfE2YOU4nzWLekJaVU1kX89/kau5fj5/K1IVhbo2Mu83lFfyMHZUIEK/rDUgUivBbeugwFf4
	nQG0O1EwMG9eUjzws
X-Received: by 2002:a05:6830:358e:b0:7d9:f50f:9691 with SMTP id 46e09a7af769-7f3de007b61mr31144874a34.0.1787036344096;
        Mon, 17 Aug 2026 23:59:04 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41beef430sm3599463a34.5.2026.08.17.23.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:59:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 18 Aug 2026 00:58:58 -0600
Subject: [PATCH net-next v3 2/4] net: mdio: link PHY package suppliers to
 member PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-submit-phy-package-fwdevlink-v1-v3-2-40a905ea16b6@gmail.com>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Ethernet PHY package nodes describe resources shared by their member
PHYs, but a package node is not instantiated as a device. Its
firmware-node supplier links therefore cannot become normal device links
for the PHY members without help from the MDIO layer.

When registering an OF-backed PHY whose parent is an
ethernet-phy-package node, copy the package supplier links onto the
member's firmware node before the PHY device is added. The ordinary
fw_devlink path then creates managed links after the PHY device has been
initialized for link registration and before its driver can probe.

Apply this to both ordinary OF discovery and the exported registration
path for a pre-created PHY device. Leave the package links intact so
every member, including one registered later, can acquire the same
dependencies. This preserves probe, unbind and runtime-PM ordering
without adding PHY-package policy to generic firmware parsing.

Fixes: 385ef48f4686 ("net: phy: add support for scanning PHY in PHY packages nodes")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v2 -> v3:
  - Move PHY-package handling out of generic OF property parsing and into
    OF MDIO registration, as suggested by Saravana Kannan
  - Copy package supplier links before device_add() so the normal
    fw_devlink path creates real member links at the correct stage
  - Cover both normal OF discovery and pre-created PHY registration
---
 drivers/net/mdio/of_mdio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b8d298c04d3f..ff540049b847 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/fwnode.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -34,9 +35,26 @@ static int of_get_phy_id(struct device_node *device, u32 *phy_id)
 	return fwnode_get_phy_id(of_fwnode_handle(device), phy_id);
 }
 
+static int of_mdiobus_link_phy_package(struct device_node *child)
+{
+	struct device_node *package __free(device_node) = of_get_parent(child);
+
+	if (!package || !of_node_name_eq(package, "ethernet-phy-package"))
+		return 0;
+
+	return fw_devlink_copy_suppliers(of_fwnode_handle(child),
+					 of_fwnode_handle(package));
+}
+
 int of_mdiobus_phy_device_register(struct mii_bus *mdio, struct phy_device *phy,
 				   struct device_node *child, u32 addr)
 {
+	int ret;
+
+	ret = of_mdiobus_link_phy_package(child);
+	if (ret)
+		return ret;
+
 	return fwnode_mdiobus_phy_device_register(mdio, phy,
 						  of_fwnode_handle(child),
 						  addr);
@@ -46,6 +64,12 @@ EXPORT_SYMBOL(of_mdiobus_phy_device_register);
 static int of_mdiobus_register_phy(struct mii_bus *mdio,
 				    struct device_node *child, u32 addr)
 {
+	int ret;
+
+	ret = of_mdiobus_link_phy_package(child);
+	if (ret)
+		return ret;
+
 	return fwnode_mdiobus_register_phy(mdio, of_fwnode_handle(child), addr);
 }
 

-- 
2.53.0

