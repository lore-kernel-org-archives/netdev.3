Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8180357D0B
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808061; cv=none; b=k705MMqlv8fwaThnM+z7FUOmsNAFuD4EH9/G5vz1pEcNL/PMRTHfpmJt2RwkkWWoRpQMz5sQvdiix98xXuqWRteHGB+9JmQADniFR9kauy2sP/WuLyA/uxNtJX3j3qdDiBHUWja//m+DMFqIJS2NCJlOj37Cwb5SgyLlmsfAdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808061; c=relaxed/simple;
	bh=c34bA274rDOkL+YzQsrkmI4B6CAXTcZ3HUERhawzQJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBCMdrVs2LK5UM5Pjj+EWbO9g/tUPE+ySbHnCBoZnc9TBeLza4+W48LsIQoEmLBf9TVQzskDP46ZJ2yXsQLKmoQgk7xpqEf6MSsB7k3D5M4g4XbchETIxAwon+mG2lDuV437Lqw93dSshRd4j9+lSI8tz4qlTXDLZSqWf5FAFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2UJKo3O; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2UJKo3O"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f56039dso203041266b.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789808058; x=1790412858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfnLSG5yNDxYZ/H/GH7hb4ofWQcWDQyvGNAStGIjNUk=;
        b=L2UJKo3O29Tqp2YumXyJcVzLYPMS968qcO/z7RE5EonqHqLUKjOnT0vHssRS6inAye
         wOZXNiP7K+I9b5pZe32k6SxpIwhjA+qOvYlMSqpvizmhsNVS9qpTGumCWubbyRcM4SSh
         fmEesHCvkXWhBKsUnllF3EsW9kFwYKC69nNhu2/lKPGML7e32I3/OGKToj/xKBoA8Hl9
         8Gc5j0IS5w+buvO8vJ64tntBGInvjz3qZPga0Y7t2mOV2S1hBIaoHnaLeC3ZlyGolfJ9
         zed6kYhcJoYO7KZZS9seF4ickvxbzC3xgJgrwUlA+6CyaTvY4HH2499OgT+G88YNxkat
         8rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789808058; x=1790412858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfnLSG5yNDxYZ/H/GH7hb4ofWQcWDQyvGNAStGIjNUk=;
        b=OSDU5uEWRtFfTcC9eL+WqINoijmnpHHD3NizklMD/jkWzgg6u0xgN+/HCvxziQ5U62
         Bbjb6BEYs/vcDt0muPCtb5EJS+bBPqx618B735Vx6NgMjpIbPv52eAZXMA/QRyFDWS8W
         qLXCzDI+Drlw1uN2qyluRslPY5MA7NmIE6LIq7X/S1IkGy7W8EWOVLSjVJEPOpnb1vuX
         SFl3HdL5t/ihBoSAuC7HLEdgU26+RZuX6pIOujT1r2o3hT+Hiyy3jiQGpYqSdLiCAHGm
         KAXiFOOMD4dYKm8DvFEvxvtN5UPL06+2yekrpZTXtyhaDH3nnU9o+AF5W3Ione35KDgw
         w5LA==
X-Gm-Message-State: AFuF++mW8bee9SgvEL9+w56N29orZzcFXdgM52gm6OKZNpI/cBGjxpES
	Awy/tdX74OfzzCRdssg8CaYYAuIilX/ZbWy0Bqz0DvqfC6D0a44oSj9fpttkTF/ZfwA=
X-Gm-Gg: AYBFou1vZ/eljVkLeAAhkemqoFUWYAOleownGSfur81qd8jBwicj8xCSPbZ95ryFrUo
	KnIeo551Q0i8YocLu3KIZvriUPcYMjai3odVJCjvvaDR9UOC7DuFYbDLUe9FZemn4af113bUqjB
	fM7E1WOthNHz71D8GZQ3l+kqbPPymsKpJpjKdU0YyjDiLMoz6ZLT+be/u/12kp9zpYU6Dne5iTR
	OaVvSd2yK1RIWSw/C7wTCb5iB1lNMuf0MSq39VBTp7cjltnMDH6QjAUieX4U7RVpo6yCX0Nukj5
	uMnz2VeLUFLaa0ndmSLAGR52yWqSAwjX8MI/pT+jG/OL8BHfIVhxIAg+UeXvk0iM1wXNLY0UcfS
	hJiEsx9jezit8PtBbVzucoA/Toe7NJj+IywCIzV4XNWDV5d0aFt7fG/GgapqvenT2Nhsp5FlueN
	iF0SH0ZDIbcDpnchYbbdUKSU/bADhikQ00GPilYZSplpyCgD04v892kSYTjh+Vp5HwO9ndskiAi
	DYrFhzZT4foZYTHP+Jhuu0fmwrHpVMORaj2tz6Mbc4ty+sWajHF0Ak0kNNlOw5hMzJrX9F/Fk/0
	wV4dn9kbd4RBU35tG/bl
X-Received: by 2002:a17:906:6a1c:b0:c29:6184:5e13 with SMTP id a640c23a62f3a-c2a15cd5b73mr428764966b.40.1789808057658;
        Sat, 19 Sep 2026 01:54:17 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3572d4d5sm64731766b.33.2026.09.19.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:54:17 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux@armlinux.org.uk,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next] net: dsa: pass PHY flags when connecting shared ports
Date: Sat, 19 Sep 2026 10:54:06 +0200
Message-ID: <20260919085406.1395-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSA calls get_phy_flags() when attaching user-port PHYs, but passes zero
when connecting shared (CPU and DSA) ports. Shared ports backed by PHYs
can also need switch-specific initialization data. The motivating case is
qca8k PHY-to-PHY CPU-port support carried by OpenWrt, where the internal
PHY driver needs the switch revision. That support is absent from this
net-next baseline.

Call the existing callback before connecting shared-port PHYs and document
its expanded scope. Drivers without the callback continue to pass zero.
Preserve the existing PHY connection error handling.

Make bcm_sf2 and ksz88xx return zero for non-user ports. This avoids newly
passing their PHY power-management and erratum flags to shared ports,
while retaining their existing user-port values.

Link: https://github.com/openwrt/openwrt/pull/25225
Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
This RFC proposes using get_phy_flags() for PHY-backed shared DSA ports,
with bcm_sf2 and ksz88xx guards to preserve their existing behavior.
The callback already carries switch-specific initialization data to PHYs;
the shared-port path should provide it before PHY initialization too.

The use case comes from qca8k PHY-to-PHY CPU-port support carried by
OpenWrt. That support is absent from this net-next baseline. The downstream
PHY driver needs the switch revision and a flag for a QCA8337 CPU-link
SmartSpeed quirk. This patch covers the generic flag propagation and
compatibility guards; the PHY-to-PHY support and quirk are outside its
scope. The complete RA74 fix would need those changes as well.

Reusing the callback keeps one interface for switch-to-PHY information.
The guards make bcm_sf2 and ksz88xx return zero for non-user ports,
preserving their previous contribution on those paths. They do not clear
flags already held by the PHY. qca8k continues to supply its revision for
internal PHYs. The pinned tree has no other callback implementations.

The patch is based on net-next
26ee8cd69d46a14b37ba5e512084fe80d730127a. Validation:

- Four fresh x86_64 builds compare baseline and candidate allyesconfig
  and allmodconfig with GCC 13.3.0, W=1 and KCFLAGS=-Wno-error. All builds
  produce vmlinux, bzImage and every expected module: 66 for allyesconfig
  and 11,173 for allmodconfig. Paired configurations are byte-identical;
  source, configuration and toolchain checks remain stable throughout.
  Complete warning/note comparisons, including repetition counts and
  compiler targets, show no new code diagnostics. Allmodconfig matches
  exactly. Allyesconfig differs only by four baseline make clock-skew
  diagnostics. Their two empty module lists were checked, and full-target
  replays reached stable dependencies with no new diagnostics. Raw logs
  and the review are retained. The default CONFIG_WERROR=y builds had
  stopped on warnings reproduced in the unpatched baseline: all 48 and
  12 initial error diagnostics, respectively. The common -Wno-error
  setting enables the complete comparison; these are not warning-free
  builds. Earlier affected-object COMPILE_TEST/W=1 builds also passed.
- A standalone C harness compiles actual DSA and driver function bodies
  with stubbed PHY/phylink operations under ASan/UBSan. All 52 cases pass,
  covering BCM/KSZ compatibility, qca8k revision propagation, all flag
  bits, callback arguments and call count, missing callbacks, and
  attachment errors. Removing either guard or disabling propagation
  makes the corresponding assertion fail. Earlier compiled-function
  checks also cover the OpenWrt 6.12 and 6.18 adaptations.
- Runtime testing used an OpenWrt 6.18 image on Redmi AX5400 (RA74), with
  the PHY-to-PHY support and QCA quirk. It passed sysupgrade and warm
  reboots, a physical 20-second power cycle, WAN/LAN DHCP, wired traffic
  and LAN VLAN isolation. These results cover the combined downstream
  changes. This net-next patch has not been runtime-tested on hardware;
  BCM SF2 and KSZ hardware have not been tested.

Codex assisted with the implementation, test harnesses and draft text.
The work addressed OpenWrt PR 25225 review, preserving other drivers'
behavior and preparing the generic change for upstream discussion.
Gemini 3.8 Flash, through agy, reviewed the design and an earlier draft.
The paired whole-tree build experiment was completed after those reviews.

 Documentation/networking/dsa/dsa.rst | 2 ++
 drivers/net/dsa/bcm_sf2.c            | 4 ++++
 drivers/net/dsa/microchip/ksz8.c     | 4 ++++
 net/dsa/port.c                       | 6 +++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 42a99f5df..9bb7a8f75 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -668,6 +668,8 @@ PHY devices and link management
   on its own (e.g.: coming from switch memory mapped registers), this function
   should return a 32-bit bitmask of "flags" that is private between the switch
   driver and the Ethernet PHY driver in ``drivers/net/phy/\*``.
+  It is called when connecting PHYs for user, CPU and DSA ports. Drivers
+  should return zero for ports that do not need switch-specific PHY flags.
 
 - ``phy_read``: Function invoked by the DSA user MDIO bus when attempting to read
   the switch port MDIO registers. If unavailable, return 0xffff for each read.
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 9e5713015..f516fc396 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -709,6 +709,10 @@ static u32 bcm_sf2_sw_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 
+	/* Shared ports previously received no PHY flags. */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
 	/* The BCM7xxx PHY driver expects to find the integrated PHY revision
 	 * in bits 15:8 and the patch level in bits 7:0 which is exactly what
 	 * the REG_PHY_REVISION register layout is.
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 941ae9f66..d284c199f 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2953,6 +2953,10 @@ static u32 ksz88xx_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
+	/* Shared ports previously received no PHY flags. */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
 	switch (dev->chip_id) {
 	case KSZ88X3_CHIP_ID:
 		/* Silicon Errata Sheet (DS80000830A):
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0d..4db7e6f9c 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1666,6 +1666,7 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct device_node *port_dn = dp->dn;
+	u32 phy_flags = 0;
 	int err;
 
 	dp->pl_config.dev = ds->dev;
@@ -1675,7 +1676,10 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 	if (err)
 		return err;
 
-	err = phylink_of_phy_connect(dp->pl, port_dn, 0);
+	if (ds->ops->get_phy_flags)
+		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
+
+	err = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
 	if (err && err != -ENODEV) {
 		pr_err("could not attach to PHY: %d\n", err);
 		goto err_phy_connect;

base-commit: 26ee8cd69d46a14b37ba5e512084fe80d730127a
-- 
2.43.0

