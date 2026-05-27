Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844C280A20;
	Wed, 27 May 2026 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850085; cv=none; b=KFRU97rcwXI8Iy8scE19yuG4s4to9u78JPp3UFkOhRrRTCWfd8Shbi+TUCxzpz+IjI3/txFN7Yl/8jo1DUxkGVBAAxdRmwlMJCDnqjr0ySqjfl3ENgxablEM+kuNbwkfrkq/Z2scb32kR5M+PRe93jnZ6OWr/O/XF5P+pIXqHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850085; c=relaxed/simple;
	bh=+YaVXT3Qfz3bidbipcfu4uSlJzjQVzjGSoN3K3/6gKc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5HzIlFzJ4Kvqmf5hOCH95m/fzt4Yq+UUZvwyJyN7mMG5cp1lmy3rIcdY191LmWUAh04J/xiitClYAltvhIS/QXyEa7zgDzZbQay+rSsvlInMOE4IkvAlrSMoM+0tRHeg181wNnrKat1D0/T4f5nn0xLEm02L8rLU4afL+v4tsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wS4JN-000000006y5-0JPD;
	Wed, 27 May 2026 02:48:01 +0000
Date: Wed, 27 May 2026 03:47:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: dsa: mxl862xx: store firmware version
 for feature gating
Message-ID: <de7b70b32aea5ec4a2715fd5c3d72a768672d06e.1779849840.git.daniel@makrotopia.org>
References: <cover.1779849840.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779849840.git.daniel@makrotopia.org>

Query the firmware version at init (already done in wait_ready),
cache it in priv->fw_version, and provide MXL862XX_FW_VER_MIN()
for version-gated code paths throughout the driver.

MXL862XX_FW_VER() packs major/minor/revision into a u32 with
bitwise shifts so that versions compare with natural ordering,
independent of host endianness.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: use bitwise shifts in macro instead of endian-specific union
v2: no changes

 drivers/net/dsa/mxl862xx/mxl862xx.c |  3 +++
 drivers/net/dsa/mxl862xx/mxl862xx.h | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index b60482d93a85..2f22adedfbf6 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -257,6 +257,9 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
 			 ver.iv_major, ver.iv_minor,
 			 le16_to_cpu(ver.iv_revision),
 			 le32_to_cpu(ver.iv_build_num));
+		priv->fw_version.major = ver.iv_major;
+		priv->fw_version.minor = ver.iv_minor;
+		priv->fw_version.revision = le16_to_cpu(ver.iv_revision);
 		return 0;
 
 not_ready_yet:
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 80053ab40e4c..e3db3711b245 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -3,6 +3,7 @@
 #ifndef __MXL862XX_H
 #define __MXL862XX_H
 
+#include <asm/byteorder.h>
 #include <linux/mdio.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
@@ -241,6 +242,25 @@ struct mxl862xx_port {
 	spinlock_t stats_lock; /* protects stats accumulators */
 };
 
+/**
+ * struct mxl862xx_fw_version - firmware version for comparison and display
+ * @major: firmware major version
+ * @minor: firmware minor version
+ * @revision: firmware revision number
+ */
+struct mxl862xx_fw_version {
+	u8 major;
+	u8 minor;
+	u16 revision;
+};
+
+#define MXL862XX_FW_VER(maj, min, rev) \
+	(((u32)(maj) << 24) | ((u32)(min) << 16) | (rev))
+#define MXL862XX_FW_VER_MIN(priv, maj, min, rev) \
+	(MXL862XX_FW_VER((priv)->fw_version.major, (priv)->fw_version.minor, \
+			 (priv)->fw_version.revision) >= \
+	 MXL862XX_FW_VER(maj, min, rev))
+
 /* Bit indices for struct mxl862xx_priv::flags */
 #define MXL862XX_FLAG_CRC_ERR		0
 #define MXL862XX_FLAG_WORK_STOPPED	1
@@ -258,6 +278,8 @@ struct mxl862xx_port {
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
+ * @fw_version:         cached firmware version, populated at probe and
+ *                      compared with MXL862XX_FW_VER_MIN()
  * @ports:              per-port state, indexed by switch port number
  * @bridges:            maps DSA bridge number to firmware bridge ID;
  *                      zero means no firmware bridge allocated for that
@@ -275,6 +297,7 @@ struct mxl862xx_priv {
 	struct work_struct crc_err_work;
 	unsigned long flags;
 	u16 drop_meter;
+	struct mxl862xx_fw_version fw_version;
 	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
 	u16 evlan_ingress_size;
-- 
2.54.0
