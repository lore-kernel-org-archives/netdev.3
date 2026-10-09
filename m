Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6803A7F60
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565136; cv=none; b=cNo3TJtS9/R4JSpSplL3SqpmJDGUB1fs30lrHUwSeeXNaxDa4AxmIppnbtq8rr/iqDE3/2lKSAXZzM/PfA+FnK0d4AHzKPsgKNlbmhtgHHh3QCFPAQj6/+M23JpxyRcnk+FjtpiKM1E4BBDSFYCiRcR2nhF3JxFKegNAn/PPDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565136; c=relaxed/simple;
	bh=xTaktD9KHN6Bfgb7x86rXbFQLwAo/BohZmt4wASCelY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn+ijO2hwZW7LNzD45UJS1Krxgm1wrxFYz6JCYuO5h3ofx15Vrd3grVMrMEaUBcwD1zPZPfOJysDwNpUzVLASOOXVQBlQDBWPIJMKvQaDukHZFsC2KGxTVh3reKEGDcoreAuR39dX960g6c/1mk23EIXtybthmacEU3Vxf3wnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXtMiO22; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXtMiO22"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-88aea027391so3606079b3a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565127; x=1792169927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+ApbkeyYaESsUG289DwjKqpCulzLsB537g9gn27q5U=;
        b=HXtMiO22sUSElXo0nhMqz7+q1BCS/v8fikxPT3bXqP7M7tQTLi7nbTaWjDb1dV+Q6Z
         jxHEQacwpMRtQN3rHJfYtcSVjgiKYe1J33TgtGynBBTWOvBP5NCrRhF6n2OUp43y2rEq
         iJC/a4nPN8KGZgLUR3SfTqVOy74jw9qv1ZZt47qNo07thkwKmrQBt3/46wsfTYPJPFqL
         AZbUrPCK6eJsuVefo0NGTq+l4YsZuJDP7lJ6DGC7H9QVDLhOuR9cJSrVF8+IsD7DBtXO
         SBuu2mAe4HmRv3owBD8J/syCInCL1pJPfmyQeFzF94tYP/b12NoS0KRFWkR+NXbvn91n
         DnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565127; x=1792169927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+ApbkeyYaESsUG289DwjKqpCulzLsB537g9gn27q5U=;
        b=sK4FMZHx38B3PmRODL6uru2n9ffiLPLUWd1WpgzUpLLqfPt+J6T1Zv/P4VjAY4jH6D
         38V7UJMa1LaHBS1lQgzjfVkW6Fxk6CsVw8MTRVdyoolp3vCEfWjHDMdEYa0cvg0N4fRJ
         mLzw49mGHiXDqOj/FqAInHkYm40kI1gPnAQ9h0ECJqB9kGvmjyiMSPiM4YOrHVZHWRmc
         7xRW8RjkTbZm4NUMjacj3ifXZCpxYHzK10K5hUWumTqaOwqjFBsokw3Q4Of0C3HVow3M
         Mg6ZDIMgILDZhfIXLu2byC4nHhoa3w6Iodt9aSEdeTMy5uGWGlI8AzNHzSwslsLg42AD
         gAAw==
X-Gm-Message-State: AFq9FYIzFFe5BgNIPT2R961dQqbrPmIj0IDNH5XoE5wq4OXuip3/HbBs
	l7c3NbU4GyrzOCnUiz0ahJqUFerjep7oiUbp5mgEPiJ6VI25G0scXcwMxNQ4vgy4
X-Gm-Gg: AYBFou29HYmeOirEkOoOQaNaCC+hAqtlHDpkfRqcD2aAlpfSFEkJ7Pkos5Yi4+5gu4Q
	XiqIPU1+upZUL7hFF+E2A1x/WJIbdsbCT+mx2mnQsqK+L1CXpjViVzLJQ4IJvtH0RccYedPzRp7
	U3jQOTutAnSiWc0sFkp05tuShOnpBOjOKkRGJhWKOniD1+r7T86JKqiOrZkFOVNpuJWaoa1DkvK
	G05QArLxa/g2DTrjtTeND0ncu0yejb2BdbP1pQ7iyCw+CQqPWUKg2YdiW+Jr8rCKHdzKeGB5m0B
	b9jFHXKVkPk/Mb8q6OALjj+39Cs0R1sJM2+o8XImYwqTwc2FBC59l6a99J6VD2jbMfC8/jU9Jri
	gCpwETMHVx1/YMxipI8nbpwlrxmCaYszh/pUnanALqf9zUUmR+B6zSwhdeusjjQnCF0z/51Ex2v
	oVUUkbrRWkpADz6f0K5R6v6lKjW7bnamnVZE25qfeRn8HEgp8IX6AeM8FGRzgSKtk9+chhKmXvS
	PScfozVf32qotxWEZKGaHA4Dw==
X-Received: by 2002:a05:6a00:3310:b0:892:e27c:5323 with SMTP id d2e1a72fcca58-897c79e15e6mr2279611b3a.34.1791565126077;
        Fri, 09 Oct 2026 09:58:46 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c37de994sm1494437b3a.26.2026.10.09.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:58:45 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: dsa: motorcomm: Split TC module
Date: Sat, 10 Oct 2026 00:58:19 +0800
Message-ID: <20261009165825.359259-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009165825.359259-1-mmyangfl@gmail.com>
References: <20261009165825.359259-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the traffic control code from chip.c into a separate tc.c, to
reduce the length of chip.c.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Makefile |    1 +
 drivers/net/dsa/motorcomm/chip.c   | 1662 ++--------------------------
 drivers/net/dsa/motorcomm/chip.h   |  350 +-----
 drivers/net/dsa/motorcomm/tc.c     | 1496 +++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/tc.h     |  380 +++++++
 5 files changed, 1969 insertions(+), 1920 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/tc.c
 create mode 100644 drivers/net/dsa/motorcomm/tc.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 9c1e3d538d21..9eaa59f699e8 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -6,3 +6,4 @@ yt921x-objs += mdio_bus.o
 yt921x-objs += mib.o
 yt921x-objs += pcs-921x.o
 yt921x-objs += smi.o
+yt921x-objs += tc.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 91cc5647f2b6..e2b5c89f7e77 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -24,7 +24,6 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
-#include <net/pkt_cls.h>
 
 #include "chip.h"
 #include "leds.h"
@@ -32,6 +31,7 @@
 #include "mib.h"
 #include "pcs.h"
 #include "smi.h"
+#include "tc.h"
 
 static const struct yt921x_info yt921x_infos[] = {
 	{
@@ -98,16 +98,6 @@ struct yt921x_reg_mdio {
 
 /* TODO: SPI/I2C */
 
-static u32 ethaddr_hi4_to_u32(const unsigned char *addr)
-{
-	return (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
-}
-
-static u32 ethaddr_lo2_to_u32(const unsigned char *addr)
-{
-	return (addr[4] << 8) | addr[5];
-}
-
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 {
 	struct yt921x_reg_mdio *mdio = context;
@@ -132,1330 +122,100 @@ static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 
 	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
 		   YT921X_SMI_READ;
-	res = __mdiobus_read(bus, addr, reg_data);
-	if (res < 0)
-		goto end;
-	val = (u16)res;
-	res = __mdiobus_read(bus, addr, reg_data);
-	if (res < 0)
-		goto end;
-	val = (val << 16) | (u16)res;
-
-	*valp = val;
-	res = 0;
-
-end:
-	mutex_unlock(&bus->mdio_lock);
-	return res;
-}
-
-static int yt921x_reg_mdio_write(void *context, u32 reg, u32 val)
-{
-	struct yt921x_reg_mdio *mdio = context;
-	struct mii_bus *bus = mdio->bus;
-	int addr = mdio->addr;
-	u32 reg_addr;
-	u32 reg_data;
-	int res;
-
-	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
-
-	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
-		   YT921X_SMI_WRITE;
-	res = __mdiobus_write(bus, addr, reg_addr, (u16)(reg >> 16));
-	if (res)
-		goto end;
-	res = __mdiobus_write(bus, addr, reg_addr, (u16)reg);
-	if (res)
-		goto end;
-
-	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
-		   YT921X_SMI_WRITE;
-	res = __mdiobus_write(bus, addr, reg_data, (u16)(val >> 16));
-	if (res)
-		goto end;
-	res = __mdiobus_write(bus, addr, reg_data, (u16)val);
-	if (res)
-		goto end;
-
-	res = 0;
-
-end:
-	mutex_unlock(&bus->mdio_lock);
-	return res;
-}
-
-static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
-	.read = yt921x_reg_mdio_read,
-	.write = yt921x_reg_mdio_write,
-};
-
-/* TODO: SPI/I2C */
-
-static int
-yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
-{
-	/* Poor datasheet for EEE operations; don't ask if you are confused */
-
-	bool enable = e->eee_enabled;
-	u16 new_mask;
-	int res;
-
-	/* Enable / disable global EEE */
-	new_mask = priv->eee_ports_mask;
-	new_mask &= ~BIT(port);
-	new_mask |= !enable ? 0 : BIT(port);
-
-	if (!!new_mask != !!priv->eee_ports_mask) {
-		res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_FUNC,
-					     YT921X_PON_STRAP_EEE, !!new_mask);
-		if (res)
-			return res;
-		res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_VAL,
-					     YT921X_PON_STRAP_EEE, !!new_mask);
-		if (res)
-			return res;
-	}
-
-	priv->eee_ports_mask = new_mask;
-
-	/* Enable / disable port EEE */
-	res = yt921x_reg_toggle_bits(priv, YT921X_EEE_CTRL,
-				     YT921X_EEE_CTRL_ENn(port), enable);
-	if (res)
-		return res;
-	res = yt921x_reg_toggle_bits(priv, YT921X_EEEn_VAL(port),
-				     YT921X_EEE_VAL_DATA, enable);
-	if (res)
-		return res;
-
-	return 0;
-}
-
-static int
-yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
-{
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_set_eee(priv, port, e);
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
-}
-
-static int yt921x_mtu_fetch(struct yt921x_priv *priv, int port)
-{
-	struct dsa_port *dp = dsa_to_port(&priv->ds, port);
-
-	return dp->user ? READ_ONCE(dp->user->mtu) : ETH_DATA_LEN;
-}
-
-static int
-yt921x_dsa_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
-{
-	/* Only serves as packet filter, since the frame size is always set to
-	 * maximum after reset
-	 */
-
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	struct dsa_port *dp = dsa_to_port(ds, port);
-	int frame_size;
-	int res;
-
-	frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN;
-	if (dsa_port_is_cpu(dp))
-		frame_size += YT921X_TAG_LEN;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_reg_update_bits(priv, YT921X_MACn_FRAME(port),
-				     YT921X_MAC_FRAME_SIZE_M,
-				     YT921X_MAC_FRAME_SIZE(frame_size));
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
-}
-
-static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
-{
-	/* Only called for user ports, exclude tag len here */
-	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
-}
-
-/* v * 2^e */
-static u64 ldexpu64(u64 v, int e)
-{
-	return e >= 0 ? v << e : v >> -e;
-}
-
-/* slot (ns) * rate (/s) / 10^9 (ns/s) = 2^C * token * 4^unit */
-static u32 rate2token(u64 rate, unsigned int slot_ns, int unit, int C)
-{
-	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
-
-	return div_u64(ldexpu64(slot_ns * rate, -e), 1000000000);
-}
-
-static u64 token2rate(u32 token, unsigned int slot_ns, int unit, int C)
-{
-	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
-
-	return div_u64(ldexpu64(mul_u32_u32(1000000000, token), e), slot_ns);
-}
-
-/* burst = 2^C * token * 4^unit */
-static u32 burst2token(u64 burst, int unit, int C)
-{
-	return ldexpu64(burst, -(2 * unit + C));
-}
-
-static u64 token2burst(u32 token, int unit, int C)
-{
-	return ldexpu64(token, 2 * unit + C);
-}
-
-struct yt921x_marker {
-	u32 cir;
-	u32 cbs;
-	u32 ebs;
-	int unit;
-	bool pkt_mode;
-};
-
-#define YT921X_MARKER_PKT_MODE		BIT(0)
-#define YT921X_MARKER_SINGLE_BUCKET	BIT(1)
-
-static int
-yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
-		  unsigned int flags, unsigned int slot_ns, u32 cir_max,
-		  u32 cbs_max, int unit_max, struct yt921x_priv *priv, int port,
-		  struct netlink_ext_ack *extack)
-{
-	const int C = flags & YT921X_MARKER_PKT_MODE ? YT921X_TOKEN_PKT_C :
-		      YT921X_TOKEN_BYTE_C;
-	struct device *dev = yt921x_priv_to_device(priv);
-	struct yt921x_marker m;
-	u64 burst_est;
-	u64 burst_sug;
-	u64 burst_max;
-	u64 rate_max;
-
-	m.unit = unit_max;
-	rate_max = token2rate(cir_max, slot_ns, m.unit, C);
-	burst_max = token2burst(cbs_max, m.unit, C);
-
-	/* Check for unusual values */
-	if (rate > rate_max || burst > burst_max) {
-		NL_SET_ERR_MSG_MOD(extack, "Unexpected tremendous rate");
-		return -ERANGE;
-	}
-
-	/* Check for matching burst */
-	burst_est = div_u64(slot_ns * rate, 1000000000);
-	burst_sug = burst_est;
-	if (flags & YT921X_MARKER_PKT_MODE)
-		burst_sug++;
-	else
-		burst_sug += ETH_HLEN + yt921x_mtu_fetch(priv, port) +
-			     ETH_FCS_LEN;
-	if (burst_sug > burst)
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Consider match rate %llu with burst at least %llu",
-				       rate, burst_sug);
-
-	/* Select unit */
-	for (; m.unit > 0; m.unit--) {
-		if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
-			break;
-		rate_max >>= 2;
-		burst_max >>= 2;
-	}
-
-	/* Calculate information rate and bucket size */
-	m.cir = rate2token(rate, slot_ns, m.unit, C);
-	if (!m.cir)
-		m.cir = 1;
-	else if (WARN_ON(m.cir > cir_max))
-		m.cir = cir_max;
-	m.cbs = burst2token(burst, m.unit, C);
-	if (!m.cbs)
-		m.cbs = 1;
-	else if (WARN_ON(m.cbs > cbs_max))
-		m.cbs = cbs_max;
-
-	/* Cut EBS */
-	m.ebs = 0;
-	if (!(flags & YT921X_MARKER_SINGLE_BUCKET)) {
-		/* We don't have a chance to adjust rate when MTU is changed */
-		if (flags & YT921X_MARKER_PKT_MODE)
-			burst_est++;
-		else
-			burst_est += YT921X_FRAME_SIZE_MAX;
-
-		if (burst_est < burst) {
-			u32 pbs = m.cbs;
-
-			m.cbs = burst2token(burst_est, m.unit, C);
-			if (!m.cbs)
-				m.cbs = 1;
-			else if (WARN_ON(m.cbs > cbs_max))
-				m.cbs = cbs_max;
-
-			if (pbs > m.cbs)
-				m.ebs = pbs - m.cbs;
-		}
-	}
-
-	dev_dbg(dev,
-		"slot %u ns, rate %llu, burst %llu -> unit %d, cir %u, cbs %u, ebs %u\n",
-		slot_ns, rate, burst, m.unit, m.cir, m.cbs, m.ebs);
-
-	m.pkt_mode = flags & YT921X_MARKER_PKT_MODE;
-	*marker = m;
-	return 0;
-}
-
-static int
-yt921x_marker_tfm_police(struct yt921x_marker *marker,
-			 const struct flow_action_police *police,
-			 unsigned int flags, struct yt921x_priv *priv, int port,
-			 struct netlink_ext_ack *extack)
-{
-	bool pkt_mode = !!police->rate_pkt_ps;
-	u64 burst;
-	u64 rate;
-
-	rate = pkt_mode ? police->rate_pkt_ps : police->rate_bytes_ps;
-	burst = pkt_mode ? police->burst_pkt : police->burst;
-	if (pkt_mode)
-		flags |= YT921X_MARKER_PKT_MODE;
-
-	return yt921x_marker_tfm(marker, rate, burst, flags,
-				 priv->meter_slot_ns, YT921X_METER_CIR_MAX,
-				 YT921X_METER_CBS_MAX, YT921X_METER_UNIT_MAX,
-				 priv, port, extack);
-}
-
-static int
-yt921x_marker_tfm_shape(struct yt921x_marker *marker, u64 rate, u64 burst,
-			unsigned int flags, struct yt921x_priv *priv, int port,
-			struct netlink_ext_ack *extack)
-{
-	return yt921x_marker_tfm(marker, rate, burst, flags,
-				 priv->port_shape_slot_ns, YT921X_SHAPE_CIR_MAX,
-				 YT921X_SHAPE_CBS_MAX, YT921X_SHAPE_UNIT_MAX,
-				 priv, port, extack);
-}
-
-static int
-yt921x_police_validate(const struct flow_action_police *police,
-		       const struct flow_action *action,
-		       const struct flow_action_entry *act,
-		       struct netlink_ext_ack *extack)
-{
-	if (police->exceed.act_id != FLOW_ACTION_DROP) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when exceed action is not drop");
-		return -EOPNOTSUPP;
-	}
-
-	if (police->notexceed.act_id != FLOW_ACTION_PIPE &&
-	    police->notexceed.act_id != FLOW_ACTION_ACCEPT) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when conform action is not pipe or ok");
-		return -EOPNOTSUPP;
-	}
-
-	if (police->notexceed.act_id == FLOW_ACTION_ACCEPT && action && act &&
-	    !flow_action_is_last_entry(action, act)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when conform action is ok, but action is not last");
-		return -EOPNOTSUPP;
-	}
-
-	/* mtu defaults to unlimited but we got 2040 here, don't know why */
-	if (police->peakrate_bytes_ps || police->avrate || police->overhead) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Offload not supported when peakrate/avrate/overhead is configured");
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static int
-yt921x_meter_config(struct yt921x_priv *priv, unsigned int id,
-		    const struct yt921x_marker *marker)
-{
-	u32 ctrls[3];
-
-	ctrls[0] = 0;
-	ctrls[1] = YT921X_METER_CTRLb_CIR(marker->cir);
-	ctrls[2] = YT921X_METER_CTRLc_UNIT(marker->unit) |
-		   YT921X_METER_CTRLc_DROP_R |
-		   YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN |
-		   YT921X_METER_CTRLc_METER_EN;
-	if (marker->pkt_mode)
-		ctrls[2] |= YT921X_METER_CTRLc_PKT_MODE;
-	update_ctrls_unaligned(&ctrls[0], &ctrls[1],
-			       YT921X_METER_CTRLab_EBS_M,
-			       YT921X_METER_CTRLab_EBS(marker->ebs));
-	update_ctrls_unaligned(&ctrls[1], &ctrls[2],
-			       YT921X_METER_CTRLbc_CBS_M,
-			       YT921X_METER_CTRLbc_CBS(marker->cbs));
-
-	return yt921x_reg96_write(priv, YT921X_METERn_CTRL(id), ctrls);
-}
-
-static void yt921x_dsa_port_policer_del(struct dsa_switch *ds, int port)
-{
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	struct device *dev = yt921x_priv_to_device(priv);
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), 0);
-	mutex_unlock(&priv->reg_lock);
-
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "delete policer on",
-			port, res);
-}
-
-static int
-yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
-			    const struct flow_action_police *police,
-			    struct netlink_ext_ack *extack)
-{
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	struct yt921x_marker marker;
-	u32 ctrl;
-	int res;
-
-	res = yt921x_police_validate(police, NULL, NULL, extack);
-	if (res)
-		return res;
-
-	res = yt921x_marker_tfm_police(&marker, police, 0, priv, port, extack);
-	if (res)
-		return res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_meter_config(priv, port + YT921X_METER_NUM, &marker);
-	if (res)
-		goto end;
-
-	ctrl = YT921X_PORT_METER_ID(port) | YT921X_PORT_METER_EN;
-	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), ctrl);
-end:
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
-}
-
-static int
-yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
-				  const struct tc_tbf_qopt_offload *qopt)
-{
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	struct netlink_ext_ack *extack = qopt->extack;
-	u32 ctrls[2];
-	int res;
-
-	if (qopt->parent != TC_H_ROOT)
-		return -EOPNOTSUPP;
-
-	switch (qopt->command) {
-	case TC_TBF_STATS:
-		/* Unfortunately the convention for TC_*_STATS is a mess,
-		 * neither 0 nor -EOPNOTSUPP is perfect here.
-		 */
-		return -EOPNOTSUPP;
-	case TC_TBF_DESTROY:
-		ctrls[0] = 0;
-		ctrls[1] = 0;
-		break;
-	case TC_TBF_REPLACE: {
-		const struct tc_tbf_qopt_offload_replace_params *p;
-		struct yt921x_marker marker;
-
-		p = &qopt->replace_params;
-
-		res = yt921x_marker_tfm_shape(&marker, p->rate.rate_bytes_ps,
-					      p->max_size,
-					      YT921X_MARKER_SINGLE_BUCKET,
-					      priv, port, extack);
-		if (res)
-			return res;
-
-		ctrls[0] = YT921X_PORT_SHAPE_CTRLa_CIR(marker.cir) |
-			   YT921X_PORT_SHAPE_CTRLa_CBS(marker.cbs);
-		ctrls[1] = YT921X_PORT_SHAPE_CTRLb_UNIT(marker.unit) |
-			   YT921X_PORT_SHAPE_CTRLb_EN;
-		break;
-	}
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_reg64_write(priv, YT921X_PORTn_SHAPE_CTRL(port), ctrls);
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
-}
-
-static int
-yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
-			 enum tc_setup_type type, void *type_data)
-{
-	switch (type) {
-	case TC_SETUP_QDISC_TBF: {
-		const struct tc_tbf_qopt_offload *qopt = type_data;
-
-		return yt921x_dsa_port_setup_tc_tbf_port(ds, port, qopt);
-	}
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-/* ACL: 48 blocks * 8 entries
- *
- * One rule can span multiple entries, but within a block.
- */
-
-static void
-yt921x_acl_entry_set(struct yt921x_acl_entry *entry, unsigned int offset,
-		     u32 flags, bool set)
-{
-	if (set)
-		entry->key[offset] |= flags;
-	entry->mask[offset] |= flags;
-}
-
-static unsigned int
-yt921x_acl_entries_set_is_fragment(struct yt921x_acl_entry *entries,
-				   unsigned int size, bool set)
-{
-	for (unsigned int i = 0; i < size; i++)
-		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
-		case YT921X_ACL_TYPE_IPV4_DA:
-		case YT921X_ACL_TYPE_IPV4_SA:
-			yt921x_acl_entry_set(&entries[i], 1,
-					     YT921X_ACL_BINb_IPV4_FRAG, set);
-			return size;
-		case YT921X_ACL_TYPE_IPV6_DA3:
-		case YT921X_ACL_TYPE_IPV6_SA3:
-			yt921x_acl_entry_set(&entries[i], 1,
-					     YT921X_ACL_BINb_IPV6_xA3_FRAG,
-					     set);
-			return size;
-		case YT921X_ACL_TYPE_MISC:
-			yt921x_acl_entry_set(&entries[i], 1,
-					     YT921X_ACL_BINb_MISC_FRAG, set);
-			return size;
-		case YT921X_ACL_TYPE_L4:
-			yt921x_acl_entry_set(&entries[i], 1,
-					     YT921X_ACL_BINb_L4_FRAG, set);
-			return size;
-		}
-
-	if (size >= YT921X_ACL_ENT_PER_BLK)
-		return 0;
-
-	entries[size] = (typeof(*entries)){};
-	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
-	yt921x_acl_entry_set(&entries[size], 1, YT921X_ACL_BINb_MISC_FRAG, set);
-
-	return size + 1;
-}
-
-static unsigned int
-yt921x_acl_entries_set_first_frag(struct yt921x_acl_entry *entries,
-				  unsigned int size, bool set)
-{
-	for (unsigned int i = 0; i < size; i++)
-		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
-		case YT921X_ACL_TYPE_IPV6_DA2:
-		case YT921X_ACL_TYPE_IPV6_SA2:
-			yt921x_acl_entry_set(&entries[i], 1,
-					     YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG,
-					     set);
-			return size;
-		case YT921X_ACL_TYPE_MISC:
-			yt921x_acl_entry_set(&entries[i], 0,
-					     YT921X_ACL_BINa_MISC_FIRST_FRAG,
-					     set);
-			return size;
-		}
-
-	if (size >= YT921X_ACL_ENT_PER_BLK)
-		return 0;
-
-	entries[size] = (typeof(*entries)){};
-	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
-	yt921x_acl_entry_set(&entries[size], 0,
-			     YT921X_ACL_BINa_MISC_FIRST_FRAG, set);
-
-	return size + 1;
-}
-
-static unsigned int
-yt921x_acl_entries_set_l3_type(struct yt921x_acl_entry *entries,
-			       unsigned int size, enum yt921x_l3_type type)
-{
-	for (unsigned int i = 0; i < size; i++)
-		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
-		case YT921X_ACL_TYPE_MAC_DA0:
-		case YT921X_ACL_TYPE_MAC_SA0:
-			entries[i].key[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE(type);
-			entries[i].mask[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M;
-			return size;
-		case YT921X_ACL_TYPE_MISC:
-			entries[i].key[0] |= YT921X_ACL_BINa_MISC_L3_TYPE(type);
-			entries[i].mask[0] |= YT921X_ACL_BINa_MISC_L3_TYPE_M;
-			return size;
-		}
-
-	if (size >= YT921X_ACL_ENT_PER_BLK)
-		return 0;
-
-	entries[size] = (typeof(*entries)){};
-	entries[size].key[0] = YT921X_ACL_BINa_MISC_L3_TYPE(type);
-	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
-	entries[size].mask[0] = YT921X_ACL_BINa_MISC_L3_TYPE_M;
-
-	return size + 1;
-}
-
-static unsigned int
-yt921x_acl_entries_set_l4_type(struct yt921x_acl_entry *entries,
-			       unsigned int size, enum yt921x_l4_type type)
-{
-	for (unsigned int i = 0; i < size; i++)
-		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
-		case YT921X_ACL_TYPE_IPV4_DA:
-		case YT921X_ACL_TYPE_IPV4_SA:
-			entries[i].key[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE(type);
-			entries[i].mask[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE_M;
-			return size;
-		case YT921X_ACL_TYPE_IPV6_DA0:
-		case YT921X_ACL_TYPE_IPV6_DA1:
-		case YT921X_ACL_TYPE_IPV6_DA2:
-		case YT921X_ACL_TYPE_IPV6_DA3:
-		case YT921X_ACL_TYPE_IPV6_SA0:
-		case YT921X_ACL_TYPE_IPV6_SA1:
-		case YT921X_ACL_TYPE_IPV6_SA2:
-		case YT921X_ACL_TYPE_IPV6_SA3:
-			entries[i].key[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE(type);
-			entries[i].mask[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE_M;
-			return size;
-		case YT921X_ACL_TYPE_L4:
-			entries[i].key[1] |= YT921X_ACL_BINb_L4_TYPE(type);
-			entries[i].mask[1] |= YT921X_ACL_BINb_L4_TYPE_M;
-			return size;
-		case YT921X_ACL_TYPE_MISC:
-			entries[i].key[1] |= YT921X_ACL_BINb_MISC_L4_TYPE(type);
-			entries[i].mask[1] |= YT921X_ACL_BINb_MISC_L4_TYPE_M;
-			return size;
-		}
-
-	if (size >= YT921X_ACL_ENT_PER_BLK)
-		return 0;
-
-	entries[size] = (typeof(*entries)){};
-	entries[size].key[1] = YT921X_ACL_BINb_MISC_L4_TYPE(type) |
-			       YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
-	entries[size].mask[1] = YT921X_ACL_BINb_MISC_L4_TYPE_M;
-
-	return size + 1;
-}
-
-static struct yt921x_acl_entry *
-yt921x_acl_entries_new(struct yt921x_acl_entry *entries, unsigned int *sizep,
-		       u32 type)
-{
-	unsigned int size = *sizep;
-
-	if (size >= YT921X_ACL_ENT_PER_BLK)
-		return NULL;
-
-	entries[size] = (typeof(*entries)){};
-	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(type);
-
-	(*sizep)++;
-	return &entries[size];
-}
-
-static struct yt921x_acl_entry *
-yt921x_acl_entries_find(struct yt921x_acl_entry *entries, unsigned int *sizep,
-			u32 type)
-{
-	for (unsigned int i = 0; i < *sizep; i++)
-		if (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1]) ==
-		    type)
-			return &entries[i];
-	return yt921x_acl_entries_new(entries, sizep, type);
-}
-
-static void
-yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 ord,
-			  u16 ports_mask)
-{
-	struct yt921x_acl_entry *entries = aclrule->entries;
-
-	for (unsigned int i = 0; i < hweight8(aclrule->mask); i++) {
-		entries[i].key[1] |= YT921X_ACL_KEYb_SPORTS(ports_mask) |
-				     YT921X_ACL_KEYb_ORD(ord);
-	}
-}
-
-struct yt921x_acl_rule_ext {
-	struct yt921x_acl_rule r;
-
-	struct yt921x_marker marker;
-};
-
-static int
-yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
-				       const struct flow_cls_offload *cls)
-{
-	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
-	struct yt921x_acl_entry *entries = ruleext->r.entries;
-	struct netlink_ext_ack *extack = cls->common.extack;
-	const struct flow_dissector *dissector;
-	struct yt921x_acl_entry *entry;
-	unsigned int size = 0;
-	bool use_dport;
-	bool use_sport;
-
-	/* Incomplete and probably won't, since it supports custom u32 filters.
-	 * New adapters are welcome.
-	 */
-	dissector = rule->match.dissector;
-	if (dissector->used_keys &
-	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
-		NL_SET_ERR_MSG_MOD(extack, "Unsupported keys used");
-		return -EOPNOTSUPP;
-	}
-
-	/* Entries */
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
-		struct flow_match_ipv4_addrs match;
-
-		flow_rule_match_ipv4_addrs(rule, &match);
-
-		if (match.mask->dst) {
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_IPV4_DA);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= ntohl(match.key->dst);
-			entry->mask[0] |= ntohl(match.mask->dst);
-		}
-
-		if (match.mask->src) {
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_IPV4_SA);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= ntohl(match.key->src);
-			entry->mask[0] |= ntohl(match.mask->src);
-		}
-	}
-
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
-		struct flow_match_ipv6_addrs match;
-
-		flow_rule_match_ipv6_addrs(rule, &match);
-
-		for (unsigned int i = 0; i < 4; i++) {
-			if (!match.mask->dst.s6_addr32[i])
-				continue;
-
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_IPV6_DA0 + i);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= ntohl(match.key->dst.s6_addr32[i]);
-			entry->mask[0] |= ntohl(match.mask->dst.s6_addr32[i]);
-		}
-
-		for (unsigned int i = 0; i < 4; i++) {
-			if (!match.mask->src.s6_addr32[i])
-				continue;
-
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_IPV6_SA0 + i);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= ntohl(match.key->src.s6_addr32[i]);
-			entry->mask[0] |= ntohl(match.mask->src.s6_addr32[i]);
-		}
-	}
-
-	use_dport = false;
-	use_sport = false;
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
-		struct flow_match_ports match;
-
-		entry = yt921x_acl_entries_new(entries, &size,
-					       YT921X_ACL_TYPE_L4);
-		if (!entry)
-			goto err;
-
-		flow_rule_match_ports(rule, &match);
-
-		use_dport = !!match.mask->dst;
-		use_sport = !!match.mask->src;
-
-		entry->key[0] |= (ntohs(match.key->dst) << 16) |
-				 ntohs(match.key->src);
-		entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
-				  ntohs(match.mask->src);
-	}
-
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
-		struct flow_match_ports_range match;
-
-		entry = yt921x_acl_entries_find(entries, &size,
-						YT921X_ACL_TYPE_L4);
-		if (!entry)
-			goto err;
-
-		flow_rule_match_ports_range(rule, &match);
-
-		if ((use_dport && match.mask->tp.dst) ||
-		    (use_sport && match.mask->tp.src)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Port mask and range are mutually exclusive");
-			return -EINVAL;
-		}
-
-		if (match.mask->tp.dst) {
-			entry->key[0] |= ntohs(match.key->tp_min.dst) << 16;
-			entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
-			entry->mask[0] |= ntohs(match.key->tp_max.dst) << 16;
-		}
-
-		if (match.mask->tp.src) {
-			entry->key[0] |= ntohs(match.key->tp_min.src);
-			entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
-			entry->mask[0] |= ntohs(match.key->tp_max.src);
-		}
-	}
-
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct flow_match_eth_addrs match;
-		u32 mask;
-
-		flow_rule_match_eth_addrs(rule, &match);
-
-		mask = ethaddr_hi4_to_u32(match.mask->dst);
-		if (mask) {
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_MAC_DA0);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= ethaddr_hi4_to_u32(match.key->dst);
-			entry->mask[0] |= mask;
-		}
-
-		mask = ethaddr_hi4_to_u32(match.mask->src);
-		if (mask) {
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_MAC_SA0);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= ethaddr_hi4_to_u32(match.key->src);
-			entry->mask[0] |= mask;
-		}
-
-		mask = (ethaddr_lo2_to_u32(match.mask->dst) << 16) |
-		       ethaddr_lo2_to_u32(match.mask->src);
-		if (mask) {
-			entry = yt921x_acl_entries_new(entries, &size,
-						       YT921X_ACL_TYPE_MAC_DA1_SA1);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= (ethaddr_lo2_to_u32(match.key->dst) << 16) |
-					 ethaddr_lo2_to_u32(match.key->src);
-			entry->mask[0] |= mask;
-		}
-	}
-
-	/* Entries + Misc */
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
-		struct flow_match_basic match;
-
-		flow_rule_match_basic(rule, &match);
-
-		if (match.mask->n_proto) {
-			enum yt921x_l3_type l3type = YT921X_L3_TYPE_OTHER;
-
-			if (match.mask->n_proto == htons(~0))
-				switch (match.key->n_proto) {
-				case htons(ETH_P_IP):
-					l3type = YT921X_L3_TYPE_IPV4;
-					break;
-				case htons(ETH_P_IPV6):
-					l3type = YT921X_L3_TYPE_IPV6;
-					break;
-				case htons(ETH_P_ARP):
-					l3type = YT921X_L3_TYPE_ARP;
-					break;
-				case htons(ETH_P_LLDP):
-					l3type = YT921X_L3_TYPE_LLDP;
-					break;
-				case htons(ETH_P_PAE):
-					l3type = YT921X_L3_TYPE_PAE;
-					break;
-				case htons(ETH_P_CFM):
-					l3type = YT921X_L3_TYPE_ERP;
-					break;
-				}
-
-			if (l3type != YT921X_L3_TYPE_OTHER) {
-				size = yt921x_acl_entries_set_l3_type(entries,
-								      size,
-								      l3type);
-				if (!size)
-					goto err;
-			} else {
-				entry = yt921x_acl_entries_new(entries, &size,
-							       YT921X_ACL_TYPE_ETHERTYPE);
-				if (!entry)
-					goto err;
-
-				entry->key[0] |= ntohs(match.key->n_proto);
-				entry->mask[0] |= ntohs(match.mask->n_proto);
-			}
-		}
-
-		if (match.mask->ip_proto) {
-			enum yt921x_l4_type l4type = YT921X_L4_TYPE_OTHER;
-
-			if (match.mask->ip_proto == (u8)~0)
-				switch (match.key->ip_proto) {
-				case IPPROTO_TCP:
-					l4type = YT921X_L4_TYPE_TCP;
-					break;
-				case IPPROTO_UDP:
-					l4type = YT921X_L4_TYPE_UDP;
-					break;
-				case IPPROTO_UDPLITE:
-					l4type = YT921X_L4_TYPE_UDPLITE;
-					break;
-				case IPPROTO_ICMP:
-					l4type = YT921X_L4_TYPE_ICMP;
-					break;
-				case IPPROTO_IGMP:
-					l4type = YT921X_L4_TYPE_IGMP;
-					break;
-				}
-
-			if (l4type != YT921X_L4_TYPE_OTHER) {
-				size = yt921x_acl_entries_set_l4_type(entries,
-								      size,
-								      l4type);
-				if (!size)
-					goto err;
-			} else {
-				entry = yt921x_acl_entries_find(entries, &size,
-								YT921X_ACL_TYPE_MISC);
-				if (!entry)
-					goto err;
-
-				entry->key[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.key->ip_proto);
-				entry->mask[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.mask->ip_proto);
-			}
-		}
-	}
-
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
-		u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG;
-		struct flow_match_control match;
-
-		flow_rule_match_control(rule, &match);
-		if (!flow_rule_is_supp_control_flags(supp_flags,
-						     match.mask->flags, extack))
-			return -EOPNOTSUPP;
-
-		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
-			bool set = match.key->flags & FLOW_DIS_IS_FRAGMENT;
-
-			size = yt921x_acl_entries_set_is_fragment(entries, size,
-								  set);
-			if (!size)
-				goto err;
-		}
-		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
-			bool set = match.key->flags & FLOW_DIS_FIRST_FRAG;
-
-			size = yt921x_acl_entries_set_first_frag(entries, size,
-								 set);
-			if (!size)
-				goto err;
-		}
-	}
-
-	/* Misc only */
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
-		struct flow_match_ip match;
-
-		flow_rule_match_ip(rule, &match);
-		if (match.mask->ttl) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Matching on TTL not supported");
-			return -EOPNOTSUPP;
-		}
-
-		if (match.mask->tos) {
-			entry = yt921x_acl_entries_find(entries, &size,
-							YT921X_ACL_TYPE_MISC);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= YT921X_ACL_BINa_MISC_TOS(match.key->tos);
-			entry->mask[0] |= YT921X_ACL_BINa_MISC_TOS(match.mask->tos);
-		}
-	}
-
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
-		struct flow_match_tcp match;
-
-		flow_rule_match_tcp(rule, &match);
-		if (match.mask->flags & htons(~0xff)) {
-			NL_SET_ERR_MSG_MOD(extack, "Unsupported TCP flags");
-			return -EOPNOTSUPP;
-		}
-
-		if (match.mask->flags) {
-			entry = yt921x_acl_entries_find(entries, &size,
-							YT921X_ACL_TYPE_MISC);
-			if (!entry)
-				goto err;
-
-			entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
-			entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));
-		}
-	}
-
-	if (!size) {
-		NL_SET_ERR_MSG_MOD(extack, "Empty rule generated, this should not happen");
-		return -EOPNOTSUPP;
-	}
-
-	ruleext->r.mask = (1 << size) - 1;
-	return 0;
-
-err:
-	NL_SET_ERR_MSG_MOD(extack, "Rule too complex");
-	return -EOPNOTSUPP;
-}
-
-static int
-yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
-				      const struct flow_cls_offload *cls,
-				      struct yt921x_priv *priv, int port)
-{
-	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
-	const struct flow_action *flow_action = &rule->action;
-	struct netlink_ext_ack *extack = cls->common.extack;
-	enum flow_action_id redir_act = NUM_FLOW_ACTIONS;
-	const struct flow_action_entry *act;
-	u32 *action = ruleext->r.action;
-	bool seen_priority = false;
-	const char *reason = NULL;
-	bool seen_police = false;
-	unsigned int i;
-	int res;
-
-	memset(action, 0, 3 * sizeof(*action));
-	flow_action_for_each(i, act, flow_action)
-		switch (act->id) {
-		case FLOW_ACTION_ACCEPT:
-		case FLOW_ACTION_DROP:
-		case FLOW_ACTION_REDIRECT:
-			if (redir_act != NUM_FLOW_ACTIONS &&
-			    redir_act != act->id) {
-				reason = "Different redirect actions";
-				goto fallback;
-			}
-			redir_act = act->id;
-
-			switch (act->id) {
-			case FLOW_ACTION_ACCEPT:
-				action[2] |= YT921X_ACL_ACTc_FWD_EN |
-					     YT921X_ACL_ACTc_FWD_FWD;
-				break;
-			case FLOW_ACTION_DROP:
-				action[2] |= YT921X_ACL_ACTc_FWD_EN |
-					     YT921X_ACL_ACTc_FWD_REDIR;
-				break;
-			case FLOW_ACTION_REDIRECT: {
-				struct dsa_port *to_dp;
-
-				to_dp = dsa_port_from_netdev(act->dev);
-				if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
-					reason = "Redirect to non-local port";
-					goto fallback;
-				}
-
-				action[2] |= YT921X_ACL_ACTc_FWD_EN |
-					     YT921X_ACL_ACTc_FWD_REDIR |
-					     YT921X_ACL_ACTc_FWD_REDIR_DPORTn(to_dp->index);
-				break;
-			}
-			default:
-				break;
-			}
-			break;
-		case FLOW_ACTION_PRIORITY:
-			if (seen_priority) {
-				action[0] &= ~YT921X_ACL_ACTa_PRIO_EN;
-				action[1] &= ~YT921X_ACL_ACTb_PRIO_M;
-
-				reason = "Multiple priority actions";
-				goto fallback;
-			}
-			seen_priority = true;
-
-			if (act->priority >= YT921X_PRIO_NUM) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Priority value is too high");
-				return -EOPNOTSUPP;
-			}
-			action[0] |= YT921X_ACL_ACTa_PRIO_EN;
-			action[1] |= YT921X_ACL_ACTb_PRIO(act->priority);
-			break;
-		case FLOW_ACTION_POLICE: {
-			const struct flow_action_police *police = &act->police;
-
-			if (seen_police) {
-				action[0] &= ~YT921X_ACL_ACTa_METER_EN;
-
-				reason = "Multiple police actions";
-				goto fallback;
-			}
-			seen_police = true;
-
-			res = yt921x_police_validate(police, flow_action, act,
-						     extack);
-			if (res)
-				return res;
-
-			res = yt921x_marker_tfm_police(&ruleext->marker, police,
-						       0, priv, port, extack);
-			if (res)
-				return res;
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	val = (u16)res;
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	val = (val << 16) | (u16)res;
 
-			action[0] |= YT921X_ACL_ACTa_METER_EN;
-			break;
-		}
-		default:
-fallback:
-			if (cls->common.skip_sw) {
-				NL_SET_ERR_MSG_FMT_MOD(extack,
-						       "Action not supported when skip_sw: %s",
-						       reason);
-				return -EOPNOTSUPP;
-			}
-			fallthrough;
-		case FLOW_ACTION_TRAP:
-			redir_act = FLOW_ACTION_TRAP;
-
-			action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
-				     ~YT921X_ACL_ACTc_FWD_M;
-			action[2] |= YT921X_ACL_ACTc_FWD_EN |
-				     YT921X_ACL_ACTc_FWD_TRAP;
-			break;
-		}
+	*valp = val;
+	res = 0;
 
-	ruleext->r.sw_assisted = !cls->common.skip_sw;
-	return 0;
+end:
+	mutex_unlock(&bus->mdio_lock);
+	return res;
 }
 
-static int
-yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
-			       const struct flow_cls_offload *cls, bool ingress,
-			       struct yt921x_priv *priv)
+static int yt921x_reg_mdio_write(void *context, u32 reg, u32 val)
 {
-	struct netlink_ext_ack *extack = cls->common.extack;
+	struct yt921x_reg_mdio *mdio = context;
+	struct mii_bus *bus = mdio->bus;
+	int addr = mdio->addr;
+	u32 reg_addr;
+	u32 reg_data;
 	int res;
 
-	if (!ingress) {
-		NL_SET_ERR_MSG_MOD(extack, "Only ingress is supported");
-		return -EOPNOTSUPP;
-	}
-
-	if (cls->common.chain_index) {
-		NL_SET_ERR_MSG(extack, "Only chain 0 is supported");
-		return -EOPNOTSUPP;
-	}
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
 
-	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
+	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
+		   YT921X_SMI_WRITE;
+	res = __mdiobus_write(bus, addr, reg_addr, (u16)(reg >> 16));
 	if (res)
-		return res;
-	res = yt921x_acl_rule_ext_parse_flow_entries(ruleext, cls);
+		goto end;
+	res = __mdiobus_write(bus, addr, reg_addr, (u16)reg);
 	if (res)
-		return res;
-
-	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
-	ruleext->r.tag = cls->cookie;
-	ruleext->r.type = TC_SETUP_CLSFLOWER;
-	return 0;
-}
-
-static unsigned int
-yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
-		unsigned long tag)
-{
-	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
-		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
+		goto end;
 
-		if (!aclblk)
-			continue;
+	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
+		   YT921X_SMI_WRITE;
+	res = __mdiobus_write(bus, addr, reg_data, (u16)(val >> 16));
+	if (res)
+		goto end;
+	res = __mdiobus_write(bus, addr, reg_data, (u16)val);
+	if (res)
+		goto end;
 
-		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
-			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
-			    aclblk->rules[i]->type == type)
-				return YT921X_ACL_ENT_PER_BLK * blkid + i;
-	}
+	res = 0;
 
-	return UINT_MAX;
+end:
+	mutex_unlock(&bus->mdio_lock);
+	return res;
 }
 
-static unsigned int
-yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
-		   struct netlink_ext_ack *extack)
-{
-	int candidates[YT921X_ACL_ENT_PER_BLK + 1];
-	unsigned int acl_used_cnt = 0;
-
-	if (WARN_ON(entscnt > YT921X_ACL_ENT_PER_BLK))
-		return UINT_MAX;
-
-	for (unsigned int i = 0; i < ARRAY_SIZE(candidates); i++)
-		candidates[i] = -1;
-	for (unsigned int i = YT921X_ACL_BLK_NUM; i-- > 0;) {
-		unsigned int blk_used_cnt = hweight8(priv->acl_masks[i]);
-
-		candidates[blk_used_cnt] = i;
-		acl_used_cnt += blk_used_cnt;
-	}
+static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
+	.read = yt921x_reg_mdio_read,
+	.write = yt921x_reg_mdio_write,
+};
 
-	if (acl_used_cnt >= YT921X_ACL_NUM) {
-		NL_SET_ERR_MSG_MOD(extack, "ACL entry limit reached");
-		return UINT_MAX;
-	}
-	if (acl_used_cnt + entscnt <= YT921X_ACL_NUM)
-		for (unsigned int i = YT921X_ACL_ENT_PER_BLK - entscnt + 1;
-		     i-- > 0;)
-			if (candidates[i] >= 0)
-				return YT921X_ACL_ENT_PER_BLK * candidates[i] +
-				       ffz(priv->acl_masks[candidates[i]]);
-
-	NL_SET_ERR_MSG_MOD(extack,
-			   "ACL entry allocation failed, simplify your rules or remove existing rules");
-	return UINT_MAX;
-}
+/* TODO: SPI/I2C */
 
 static int
-yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
+yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
 {
-	const struct yt921x_acl_rule *aclrule;
-	const struct yt921x_acl_blk *aclblk;
-	unsigned int blkid;
-	unsigned int binid;
-	unsigned long mask;
-	u32 zeros[3] = {};
-	unsigned int i;
-	unsigned int o;
-	u32 ctrl;
-	int res;
-
-	blkid = entid / YT921X_ACL_ENT_PER_BLK;
-	binid = entid % YT921X_ACL_ENT_PER_BLK;
-	aclblk = priv->acl_blks[blkid];
-	aclrule = aclblk->rules[binid];
+	/* Poor datasheet for EEE operations; don't ask if you are confused */
 
-	/* Write actions */
-	res = yt921x_reg96_write(priv, YT921X_ACLn_ACT(entid),
-				 aclrule ? aclrule->action : zeros);
-	if (res)
-		return res;
+	bool enable = e->eee_enabled;
+	u16 new_mask;
+	int res;
 
-	/* Select the block */
-	ctrl = YT921X_ACL_BLK_CMD_MODIFY | YT921X_ACL_BLK_CMD_BLKID(blkid);
-	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
-	if (res)
-		return res;
+	/* Enable / disable global EEE */
+	new_mask = priv->eee_ports_mask;
+	new_mask &= ~BIT(port);
+	new_mask |= !enable ? 0 : BIT(port);
 
-	/* Write keys and masks */
-	ctrl = 0;
-	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
-		ctrl |= YT921X_ACL_BLK_KEEP_KEEPn(i);
-
-	mask = entsmask;
-	i = 0;
-	for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
-		res = yt921x_reg64_write(priv, YT921X_ACLn_KEYm(blkid, o),
-					 aclrule ? aclrule->entries[i].key :
-					 zeros);
+	if (!!new_mask != !!priv->eee_ports_mask) {
+		res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_FUNC,
+					     YT921X_PON_STRAP_EEE, !!new_mask);
 		if (res)
 			return res;
-
-		res = yt921x_reg64_write(priv, YT921X_ACLn_MASKm(blkid, o),
-					 aclrule ? aclrule->entries[i].mask :
-					 zeros);
+		res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_VAL,
+					     YT921X_PON_STRAP_EEE, !!new_mask);
 		if (res)
 			return res;
-
-		ctrl &= ~YT921X_ACL_BLK_KEEP_KEEPn(o);
-		i++;
 	}
 
-	res = yt921x_reg_write(priv, YT921X_ACL_BLK_KEEP, ctrl);
-	if (res)
-		return res;
-
-	ctrl = 0;
-	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++) {
-		const struct yt921x_acl_rule *other = aclblk->rules[i];
-
-		if (!other)
-			continue;
+	priv->eee_ports_mask = new_mask;
 
-		mask = other->mask;
-		for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK)
-			ctrl |= YT921X_ACL_ENTRY_ENm(o) |
-				YT921X_ACL_ENTRY_GRPIDm(o, i);
-	}
-	res = yt921x_reg_write(priv, YT921X_ACLn_ENTRY(blkid), ctrl);
+	/* Enable / disable port EEE */
+	res = yt921x_reg_toggle_bits(priv, YT921X_EEE_CTRL,
+				     YT921X_EEE_CTRL_ENn(port), enable);
 	if (res)
 		return res;
-
-	/* Commit the block */
-	ctrl = YT921X_ACL_BLK_CMD_BLKID(blkid);
-	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	res = yt921x_reg_toggle_bits(priv, YT921X_EEEn_VAL(port),
+				     YT921X_EEE_VAL_DATA, enable);
 	if (res)
 		return res;
 
@@ -1463,263 +223,47 @@ yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 }
 
 static int
-yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
-	       unsigned long tag)
-{
-	struct yt921x_acl_rule *aclrule;
-	struct yt921x_acl_blk *aclblk;
-	unsigned int binid;
-	unsigned int blkid;
-	unsigned int entid;
-	int res;
-
-	entid = yt921x_acl_find(priv, type, tag);
-	if (entid == UINT_MAX)
-		return -ENOENT;
-
-	blkid = entid / YT921X_ACL_ENT_PER_BLK;
-	binid = entid % YT921X_ACL_ENT_PER_BLK;
-	aclblk = priv->acl_blks[blkid];
-	aclrule = aclblk->rules[binid];
-
-	aclblk->rules[binid] = NULL;
-	res = yt921x_acl_commit(priv, entid, aclrule->mask);
-	/* the kernel never rolls back on failure */
-
-	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
-		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
-				    aclrule->action[0]),
-			  priv->meters_map);
-	priv->acl_masks[blkid] &= ~aclrule->mask;
-	kvfree(aclrule);
-	if (!priv->acl_masks[blkid]) {
-		kvfree(aclblk);
-		priv->acl_blks[blkid] = NULL;
-	}
-	return res;
-}
-
-static int
-yt921x_acl_add(struct yt921x_priv *priv,
-	       const struct yt921x_acl_rule_ext *ruleext,
-	       struct netlink_ext_ack *extack)
-{
-	unsigned int entscnt = hweight8(ruleext->r.mask);
-	struct yt921x_acl_rule *aclrule;
-	struct yt921x_acl_blk *aclblk;
-	bool use_trap = false;
-	unsigned int meterid;
-	unsigned long mask;
-	unsigned int binid;
-	unsigned int blkid;
-	unsigned int entid;
-	unsigned int o;
-	int res;
-
-	/* Allocate resources */
-	entid = yt921x_acl_reserve(priv, entscnt, extack);
-	if (entid == UINT_MAX)
-		return -EOPNOTSUPP;
-
-	if (!(ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN)) {
-		meterid = YT921X_METER_NUM;
-	} else {
-		meterid = find_first_zero_bit(priv->meters_map,
-					      YT921X_METER_NUM);
-		if (meterid < YT921X_METER_NUM) {
-			res = yt921x_meter_config(priv, meterid,
-						  &ruleext->marker);
-			if (res)
-				return res;
-		} else if (ruleext->r.sw_assisted) {
-			use_trap = true;
-		} else {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "No more meters available");
-			return -EOPNOTSUPP;
-		}
-	}
-
-	/* Prepare acl block ctrlblk */
-	blkid = entid / YT921X_ACL_ENT_PER_BLK;
-	binid = entid % YT921X_ACL_ENT_PER_BLK;
-	aclblk = priv->acl_blks[blkid];
-	if (!aclblk) {
-		aclblk = kvzalloc_obj(*aclblk);
-		if (!aclblk)
-			return -ENOMEM;
-		priv->acl_blks[blkid] = aclblk;
-	}
-
-	/* Prepare acl rule ctrlblk */
-	aclrule = kvmemdup(&ruleext->r,
-			   offsetof(struct yt921x_acl_rule, entries[entscnt]),
-			   GFP_KERNEL);
-	if (!aclrule) {
-		res = -ENOMEM;
-		goto err;
-	}
-
-	/* Replace the placeholder resource IDs */
-	aclrule->mask = 0;
-	mask = priv->acl_masks[blkid];
-	for_each_clear_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
-		aclrule->mask |= BIT(o);
-		entscnt--;
-		if (!entscnt)
-			break;
-	}
-
-	if (use_trap) {
-		aclrule->action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
-				      ~YT921X_ACL_ACTc_FWD_M;
-		aclrule->action[2] |= YT921X_ACL_ACTc_FWD_EN |
-				      YT921X_ACL_ACTc_FWD_TRAP;
-	}
-	if (meterid < YT921X_METER_NUM)
-		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
-	else
-		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
-
-	/* Write rules */
-	aclblk->rules[binid] = aclrule;
-	res = yt921x_acl_commit(priv, entid, aclrule->mask);
-	if (res) {
-		aclblk->rules[binid] = NULL;
-		kvfree(aclrule);
-		goto err;
-	}
-
-	if (meterid < YT921X_METER_NUM)
-		set_bit(meterid, priv->meters_map);
-	priv->acl_masks[blkid] |= aclrule->mask;
-	return 0;
-
-err:
-	if (!priv->acl_masks[blkid]) {
-		kvfree(aclblk);
-		priv->acl_blks[blkid] = NULL;
-	}
-	return res;
-}
-
-static int
-yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
-			  struct flow_cls_offload *cls, bool ingress)
+yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	res = yt921x_set_eee(priv, port, e);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
 }
 
 static int
-yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
-			  struct flow_cls_offload *cls, bool ingress)
+yt921x_dsa_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
-	struct netlink_ext_ack *extack = cls->common.extack;
+	/* Only serves as packet filter, since the frame size is always set to
+	 * maximum after reset
+	 */
+
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	struct yt921x_acl_rule_ext ruleext;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	int frame_size;
 	int res;
 
-	res = yt921x_acl_rule_ext_parse_flow(&ruleext, port, cls, ingress,
-					     priv);
-	if (res)
-		return res;
+	frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN;
+	if (dsa_port_is_cpu(dp))
+		frame_size += YT921X_TAG_LEN;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_add(priv, &ruleext, extack);
+	res = yt921x_reg_update_bits(priv, YT921X_MACn_FRAME(port),
+				     YT921X_MAC_FRAME_SIZE_M,
+				     YT921X_MAC_FRAME_SIZE(frame_size));
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
 }
 
-static int
-yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
-{
-	u32 mask;
-
-	if (ingress)
-		mask = YT921X_MIRROR_IGR_PORTn(port);
-	else
-		mask = YT921X_MIRROR_EGR_PORTn(port);
-	return yt921x_reg_clear_bits(priv, YT921X_MIRROR, mask);
-}
-
-static int
-yt921x_mirror_add(struct yt921x_priv *priv, int port, bool ingress,
-		  int to_local_port, struct netlink_ext_ack *extack)
-{
-	u32 srcs;
-	u32 ctrl;
-	u32 val;
-	u32 dst;
-	int res;
-
-	if (ingress)
-		srcs = YT921X_MIRROR_IGR_PORTn(port);
-	else
-		srcs = YT921X_MIRROR_EGR_PORTn(port);
-	dst = YT921X_MIRROR_PORT(to_local_port);
-
-	res = yt921x_reg_read(priv, YT921X_MIRROR, &val);
-	if (res)
-		return res;
-
-	/* other mirror tasks & different dst port -> conflict */
-	if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
-			    YT921X_MIRROR_IGR_PORTS_M)) &&
-	    (val & YT921X_MIRROR_PORT_M) != dst) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Sniffer port is already configured, delete existing rules & retry");
-		return -EBUSY;
-	}
-
-	ctrl = val & ~YT921X_MIRROR_PORT_M;
-	ctrl |= srcs;
-	ctrl |= dst;
-
-	if (ctrl == val)
-		return 0;
-
-	return yt921x_reg_write(priv, YT921X_MIRROR, ctrl);
-}
-
-static void
-yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
-			   struct dsa_mall_mirror_tc_entry *mirror)
-{
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	struct device *dev = yt921x_priv_to_device(priv);
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_mirror_del(priv, port, mirror->ingress);
-	mutex_unlock(&priv->reg_lock);
-
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unmirror",
-			port, res);
-}
-
-static int
-yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
-			   struct dsa_mall_mirror_tc_entry *mirror,
-			   bool ingress, struct netlink_ext_ack *extack)
+static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
 {
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_mirror_add(priv, port, ingress,
-				mirror->to_local_port, extack);
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
+	/* Only called for user ports, exclude tag len here */
+	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
 }
 
 static int yt921x_lag_hash(struct yt921x_priv *priv, u32 ctrl, bool unique_lag,
@@ -3791,48 +2335,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	return 0;
 }
 
-static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
-{
-	unsigned int op_ns;
-	u32 ctrl;
-	int res;
-
-	op_ns = 8 * priv->cycle_ns;
-
-	ctrl = max(priv->meter_slot_ns / op_ns, YT921X_METER_SLOT_MIN);
-	res = yt921x_reg_write(priv, YT921X_METER_SLOT, ctrl);
-	if (res)
-		return res;
-	priv->meter_slot_ns = ctrl * op_ns;
-
-	ctrl = max(priv->port_shape_slot_ns / op_ns,
-		   YT921X_PORT_SHAPE_SLOT_MIN);
-	res = yt921x_reg_write(priv, YT921X_PORT_SHAPE_SLOT, ctrl);
-	if (res)
-		return res;
-	priv->port_shape_slot_ns = ctrl * op_ns;
-
-	return 0;
-}
-
-static int yt921x_chip_setup_acl(struct yt921x_priv *priv)
-{
-	u32 ctrl;
-	int res;
-
-	ctrl = YT921X_ACL_PERMIT_UNMATCH_PORTS_M;
-	res = yt921x_reg_write(priv, YT921X_ACL_PERMIT_UNMATCH, ctrl);
-	if (res)
-		return res;
-
-	ctrl = YT921X_ACL_PORT_PORTS_M;
-	res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
-	if (res)
-		return res;
-
-	return 0;
-}
-
 static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
 {
 	u32 ctrl;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 25ff77054de3..012de4f444f5 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -371,249 +371,6 @@ enum yt921x_app_selector {
 #define  YT921X_VLAN_CTRLa_METER_EN		BIT(5)
 #define  YT921X_VLAN_CTRLa_METER_ID_M		GENMASK(4, 0)
 
-#define YT921X_ACLn_ACT(n)		(0x1c0000 + 0x10 * (n))
-#define  YT921X_ACL_ACTc_STAG_M			GENMASK(26, 25)
-#define   YT921X_ACL_ACTc_STAG(x)			FIELD_PREP(YT921X_ACL_ACTc_STAG_M, (x))
-#define   YT921X_ACL_ACTc_STAG_DONTCARE			YT921X_ACL_ACTc_STAG(0)
-#define   YT921X_ACL_ACTc_STAG_UNTAG			YT921X_ACL_ACTc_STAG(1)
-#define   YT921X_ACL_ACTc_STAG_TAG			YT921X_ACL_ACTc_STAG(2)
-#define   YT921X_ACL_ACTc_STAG_KEEP			YT921X_ACL_ACTc_STAG(3)
-#define  YT921X_ACL_ACTc_CTAG_M			GENMASK(24, 23)
-#define   YT921X_ACL_ACTc_CTAG(x)			FIELD_PREP(YT921X_ACL_ACTc_CTAG_M, (x))
-#define   YT921X_ACL_ACTc_CTAG_DONTCARE			YT921X_ACL_ACTc_CTAG(0)
-#define   YT921X_ACL_ACTc_CTAG_UNTAG			YT921X_ACL_ACTc_CTAG(1)
-#define   YT921X_ACL_ACTc_CTAG_TAG			YT921X_ACL_ACTc_CTAG(2)
-#define   YT921X_ACL_ACTc_CTAG_KEEP			YT921X_ACL_ACTc_CTAG(3)
-#define  YT921X_ACL_ACTc_FWD_M			GENMASK(22, 21)
-#define   YT921X_ACL_ACTc_FWD(x)			FIELD_PREP(YT921X_ACL_ACTc_FWD_M, (x))
-#define   YT921X_ACL_ACTc_FWD_FWD			YT921X_ACL_ACTc_FWD(0)
-#define   YT921X_ACL_ACTc_FWD_COPY			YT921X_ACL_ACTc_FWD(1)
-#define   YT921X_ACL_ACTc_FWD_REDIR			YT921X_ACL_ACTc_FWD(2)
-#define   YT921X_ACL_ACTc_FWD_TRAP			YT921X_ACL_ACTc_FWD(3)
-#define  YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M	GENMASK(20, 10)
-#define   YT921X_ACL_ACTc_FWD_REDIR_DPORTS(x)		FIELD_PREP(YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M, (x))
-#define  YT921X_ACL_ACTc_FWD_REDIR_DPORTn(port)	BIT((port) + 10)
-#define  YT921X_ACL_ACTc_FWD_EN			BIT(9)
-#define  YT921X_ACL_ACTc_SDEI			BIT(8)
-#define  YT921X_ACL_ACTc_SDEI_REPLACE		BIT(7)
-#define  YT921X_ACL_ACTc_SPRI_M			GENMASK(6, 4)
-#define   YT921X_ACL_ACTc_SPRI(x)			FIELD_PREP(YT921X_ACL_ACTc_SPRI_M, (x))
-#define  YT921X_ACL_ACTc_SPRI_REPLACE		BIT(3)
-#define  YT921X_ACL_ACTbc_SVID_M		GENMASK_ULL(34, 23)
-#define   YT921X_ACL_ACTbc_SVID(x)			FIELD_PREP(YT921X_ACL_ACTbc_SVID_M, (x))
-#define  YT921X_ACL_ACTb_SVID_REPLACE		BIT(22)
-#define  YT921X_ACL_ACTb_CDEI			BIT(21)
-#define  YT921X_ACL_ACTb_CDEI_REPLACE		BIT(20)
-#define  YT921X_ACL_ACTb_CPRI_M			GENMASK(19, 17)
-#define   YT921X_ACL_ACTb_CPRI(x)			FIELD_PREP(YT921X_ACL_ACTb_CPRI_M, (x))
-#define  YT921X_ACL_ACTb_CPRI_REPLACE		BIT(16)
-#define  YT921X_ACL_ACTb_CVID_M			GENMASK(15, 4)
-#define   YT921X_ACL_ACTb_CVID(x)			FIELD_PREP(YT921X_ACL_ACTb_CVID_M, (x))
-#define  YT921X_ACL_ACTb_CVID_REPLACE		BIT(3)
-#define  YT921X_ACL_ACTb_PRIO_M			GENMASK(2, 0)
-#define   YT921X_ACL_ACTb_PRIO(x)			FIELD_PREP(YT921X_ACL_ACTb_PRIO_M, (x))
-#define  YT921X_ACL_ACTa_PRIO_EN		BIT(31)
-#define  YT921X_ACL_ACTa_COLOR_M		GENMASK(30, 29)
-#define   YT921X_ACL_ACTa_COLOR(x)			FIELD_PREP(YT921X_ACL_ACTa_COLOR_M, (x))
-#define   YT921X_ACL_ACTa_COLOR_GREEN			YT921X_ACL_ACTa_COLOR(0)
-#define   YT921X_ACL_ACTa_COLOR_YELLOW			YT921X_ACL_ACTa_COLOR(1)
-#define   YT921X_ACL_ACTa_COLOR_RED			YT921X_ACL_ACTa_COLOR(2)
-#define  YT921X_ACL_ACTa_COLOR_EN		BIT(28)
-#define  YT921X_ACL_ACTa_DSCP_M			GENMASK(27, 22)
-#define   YT921X_ACL_ACTa_DSCP(x)			FIELD_PREP(YT921X_ACL_ACTa_DSCP_M, (x))
-#define  YT921X_ACL_ACTa_DSCP_REPLACE		BIT(21)
-#define  YT921X_ACL_ACTa_METER_ID_M		GENMASK(20, 15)
-#define   YT921X_ACL_ACTa_METER_ID(x)			FIELD_PREP(YT921X_ACL_ACTa_METER_ID_M, (x))
-#define  YT921X_ACL_ACTa_METER_EN		BIT(14)
-#define  YT921X_ACL_ACTa_MIRROR_EN		BIT(13)
-#define  YT921X_ACL_ACTa_FLOWSTAT_EN		BIT(12)
-#define  YT921X_ACL_ACTa_FLOWSTAT_ID_M		GENMASK(11, 6)
-#define   YT921X_ACL_ACTa_FLOWSTAT_ID(x)		FIELD_PREP(YT921X_ACL_ACTa_FLOWSTAT_ID_M, (x))
-#define  YT921X_ACL_ACTa_GPIO_EN		BIT(5)
-#define  YT921X_ACL_ACTa_GPIO_PIN_M		GENMASK(4, 1)
-#define   YT921X_ACL_ACTa_GPIO_PIN(x)			FIELD_PREP(YT921X_ACL_ACTa_GPIO_PIN_M, (x))
-#define  YT921X_ACL_ACTa_INTR_EN		BIT(0)
-#define YT921X_ACL_BLK_KEEP		0x201000
-#define  YT921X_ACL_BLK_KEEP_GRPIDn_M(bin)	(7 << (4 * (bin) + 1))
-#define   YT921X_ACL_BLK_KEEP_GRPIDn(bin, x)		((x) << (4 * (bin) + 1))
-#define  YT921X_ACL_BLK_KEEP_KEEPn(bin)		BIT(4 * (bin))
-#define YT921X_ACL_PORT			0x202000
-#define  YT921X_ACL_PORT_PORTS_M		GENMASK(10, 0)
-#define   YT921X_ACL_PORT_PORTS(x)			FIELD_PREP(YT921X_ACL_PORT_PORTS_M, (x))
-#define  YT921X_ACL_PORT_PORTn(port)		BIT(port)
-#define YT921X_ACL_BLK_CMD		0x202004
-#define  YT921X_ACL_BLK_CMD_BLKID_M		GENMASK(6, 1)
-#define   YT921X_ACL_BLK_CMD_BLKID(x)			FIELD_PREP(YT921X_ACL_BLK_CMD_BLKID_M, (x))
-#define  YT921X_ACL_BLK_CMD_MODIFY		BIT(0)
-#define YT921X_ACLn_ENTRY(blk)		(0x203000 + 4 * (blk))
-#define  YT921X_ACL_ENTRY_GRPIDm_M(bin)		(7 << (4 * (bin) + 1))
-#define   YT921X_ACL_ENTRY_GRPIDm(bin, x)		((x) << (4 * (bin) + 1))
-#define  YT921X_ACL_ENTRY_ENm(bin)		BIT(4 * (bin))
-#define YT921X_ACLn_KEYm(blk, bin)	(0x204000 + 0x200 * (bin) + 8 * (blk))
-#define  YT921X_ACL_KEYb_ORD_M			GENMASK(29, 21)
-#define   YT921X_ACL_KEYb_ORD(x)			FIELD_PREP(YT921X_ACL_KEYb_ORD_M, (x))
-#define  YT921X_ACL_KEYb_SPORTS_M		GENMASK(20, 10)
-#define   YT921X_ACL_KEYb_SPORTS(x)			FIELD_PREP(YT921X_ACL_KEYb_SPORTS_M, (x))
-#define  YT921X_ACL_KEYb_SPORTn(port)		BIT((port) + 10)
-#define  YT921X_ACL_KEYb_REVERSE		BIT(9)	/* reverse match */
-#define  YT921X_ACL_KEYb_TYPE_M			GENMASK(8, 4)
-#define   YT921X_ACL_KEYb_TYPE(x)			FIELD_PREP(YT921X_ACL_KEYb_TYPE_M, (x))
-/* KEY_* fields need no masks */
-#define YT921X_ACLn_MASKm(blk, bin)	(0x205000 + 0x200 * (bin) + 8 * (blk))
-
-enum yt921x_acl_type {
-	YT921X_ACL_TYPE_NA,
-	YT921X_ACL_TYPE_MAC_DA0,
-	YT921X_ACL_TYPE_MAC_SA0,
-	YT921X_ACL_TYPE_MAC_DA1_SA1,
-	YT921X_ACL_TYPE_VLAN,
-	YT921X_ACL_TYPE_VTAG,
-	YT921X_ACL_TYPE_IPV4_DA,
-	YT921X_ACL_TYPE_IPV4_SA,
-	YT921X_ACL_TYPE_IPV6_DA0,
-	YT921X_ACL_TYPE_IPV6_DA1,
-	YT921X_ACL_TYPE_IPV6_DA2,
-	YT921X_ACL_TYPE_IPV6_DA3,
-	YT921X_ACL_TYPE_IPV6_SA0,
-	YT921X_ACL_TYPE_IPV6_SA1,
-	YT921X_ACL_TYPE_IPV6_SA2,
-	YT921X_ACL_TYPE_IPV6_SA3,
-	YT921X_ACL_TYPE_MISC,
-	YT921X_ACL_TYPE_L4,
-	YT921X_ACL_TYPE_UDF0,
-	YT921X_ACL_TYPE_UDF1,
-	YT921X_ACL_TYPE_UDF2,
-	YT921X_ACL_TYPE_UDF3,
-	YT921X_ACL_TYPE_UDF4,
-	YT921X_ACL_TYPE_UDF5,
-	YT921X_ACL_TYPE_UDF6,
-	YT921X_ACL_TYPE_UDF7,
-	YT921X_ACL_TYPE_ETHERTYPE,
-	YT921X_ACL_TYPE_NUM
-};
-
-/* Range: turn KEY:MASK into MIN:MAX */
-
-#define  YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M	GENMASK(3, 0)
-#define   YT921X_ACL_BINb_MAC_xA0_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M, (x))
-#define  YT921X_ACL_BINa_MAC_xA0_MAC_xA0_M	GENMASK(31, 0)
-
-#define  YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M	GENMASK(2, 0)
-#define   YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE(x)	FIELD_PREP(YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M, (x))
-#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_DA1_M	GENMASK(31, 16)
-#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_SA1_M	GENMASK(15, 0)
-
-#define  YT921X_ACL_KEYb_VLAN_SVID_RANGE_EN	BIT(31)
-#define  YT921X_ACL_KEYb_VLAN_CVID_RANGE_EN	BIT(30)
-#define  YT921X_ACL_BINb_VLAN_CDEI		BIT(3)
-#define  YT921X_ACL_BINb_VLAN_CPRI_M		GENMASK(2, 0)
-#define   YT921X_ACL_BINb_VLAN_CPRI(x)			FIELD_PREP(YT921X_ACL_BINb_VLAN_CPRI_M, (x))
-#define  YT921X_ACL_BINa_VLAN_CTAG_FMT_M	GENMASK(31, 30)
-#define   YT921X_ACL_BINa_VLAN_CTAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_CTAG_FMT_M, (x))
-#define  YT921X_ACL_BINa_VLAN_SDEI		BIT(29)
-#define  YT921X_ACL_BINa_VLAN_SPRI_M		GENMASK(28, 26)
-#define   YT921X_ACL_BINa_VLAN_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SPRI_M, (x))
-#define  YT921X_ACL_BINa_VLAN_STAG_FMT_M	GENMASK(25, 24)
-#define   YT921X_ACL_BINa_VLAN_STAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_STAG_FMT_M, (x))
-#define  YT921X_ACL_BINa_VLAN_SVID_M		GENMASK(23, 12)
-#define   YT921X_ACL_BINa_VLAN_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SVID_M, (x))
-#define  YT921X_ACL_BINa_VLAN_CVID_M		GENMASK(11, 0)
-#define   YT921X_ACL_BINa_VLAN_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_CVID_M, (x))
-
-#define  YT921X_ACL_KEYb_VTAG_SVID_RANGE_EN	BIT(31)
-#define  YT921X_ACL_KEYb_VTAG_CVID_RANGE_EN	BIT(30)
-#define  YT921X_ACL_BINa_VTAG_CDEI		BIT(31)
-#define  YT921X_ACL_BINa_VTAG_CPRI_M		GENMASK(30, 28)
-#define   YT921X_ACL_BINa_VTAG_CPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CPRI_M, (x))
-#define  YT921X_ACL_BINa_VTAG_SDEI		BIT(27)
-#define  YT921X_ACL_BINa_VTAG_SPRI_M		GENMASK(26, 24)
-#define   YT921X_ACL_BINa_VTAG_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SPRI_M, (x))
-#define  YT921X_ACL_BINa_VTAG_SVID_M		GENMASK(23, 12)
-#define   YT921X_ACL_BINa_VTAG_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SVID_M, (x))
-#define  YT921X_ACL_BINa_VTAG_CVID_M		GENMASK(11, 0)
-#define   YT921X_ACL_BINa_VTAG_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CVID_M, (x))
-
-#define  YT921X_ACL_KEYb_IPV4_ADDR_RANGE_EN	BIT(30)
-#define  YT921X_ACL_BINb_IPV4_FRAG		BIT(3)
-#define  YT921X_ACL_BINb_IPV4_L4_TYPE_M		GENMASK(2, 0)
-#define   YT921X_ACL_BINb_IPV4_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV4_L4_TYPE_M, (x))
-#define  YT921X_ACL_BINa_IPV4_ADDR_M		GENMASK(31, 0)
-
-#define  YT921X_ACL_BINb_IPV6_L4_TYPE_M		GENMASK(2, 0)
-#define   YT921X_ACL_BINb_IPV6_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV6_L4_TYPE_M, (x))
-#define  YT921X_ACL_BINa_IPV6_ADDRx_M		GENMASK(31, 0)
-
-#define  YT921X_ACL_BINb_IPV6_xA1_IP_OPTION	BIT(3)
-
-#define  YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG	BIT(3)
-
-#define  YT921X_ACL_KEYb_IPV6_xA3_ADDR_RANGE_EN	BIT(30)
-#define  YT921X_ACL_BINb_IPV6_xA3_FRAG		BIT(3)
-
-#define  YT921X_ACL_BINb_MISC_FRAG		BIT(3)
-#define  YT921X_ACL_BINb_MISC_L4_TYPE_M		GENMASK(2, 0)
-#define   YT921X_ACL_BINb_MISC_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MISC_L4_TYPE_M, (x))
-#define  YT921X_ACL_BINa_MISC_PPPOE_FLAG	BIT(30)
-#define  YT921X_ACL_BINa_MISC_FIRST_FRAG	BIT(29)
-#define  YT921X_ACL_BINa_MISC_IP_OPTION		BIT(28)
-#define  YT921X_ACL_BINa_MISC_TCP_FLAGS_M	GENMASK(27, 20)
-#define   YT921X_ACL_BINa_MISC_TCP_FLAGS(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_TCP_FLAGS_M, (x))
-#define  YT921X_ACL_BINa_MISC_IP_PROTO_M	GENMASK(19, 12)
-#define   YT921X_ACL_BINa_MISC_IP_PROTO(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_IP_PROTO_M, (x))
-#define  YT921X_ACL_BINa_MISC_TOS_M		GENMASK(11, 4)
-#define   YT921X_ACL_BINa_MISC_TOS(x)			FIELD_PREP(YT921X_ACL_BINa_MISC_TOS_M, (x))
-#define  YT921X_ACL_BINa_MISC_L3_TYPE_M		GENMASK(3, 0)
-#define   YT921X_ACL_BINa_MISC_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_L3_TYPE_M, (x))
-
-#define  YT921X_ACL_KEYb_L4_DPORT_RANGE_EN	BIT(31)
-#define  YT921X_ACL_KEYb_L4_SPORT_RANGE_EN	BIT(30)
-#define  YT921X_ACL_BINb_L4_FRAG		BIT(3)
-#define  YT921X_ACL_BINb_L4_TYPE_M		GENMASK(2, 0)
-#define   YT921X_ACL_BINb_L4_TYPE(x)			FIELD_PREP(YT921X_ACL_BINb_L4_TYPE_M, (x))
-#define  YT921X_ACL_BINa_L4_DPORT_M		GENMASK(31, 16)
-#define  YT921X_ACL_BINa_L4_SPORT_M		GENMASK(15, 0)
-
-#define  YT921X_ACL_BINb_UDF_IS_IGMP		BIT(0)
-#define  YT921X_ACL_BINa_UDF_UDF0_M		GENMASK(31, 16)
-#define   YT921X_ACL_BINa_UDF_UDF0(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF0_M, (x))
-#define  YT921X_ACL_BINa_UDF_UDF1_M		GENMASK(15, 0)
-#define   YT921X_ACL_BINa_UDF_UDF1(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF1_M, (x))
-
-#define  YT921X_ACL_KEYb_ETHERTYPE_ETHERTYPE_RANGE_EN	BIT(30)
-#define  YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M	GENMASK(2, 0)
-#define   YT921X_ACL_BINb_ETHERTYPE_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M, (x))
-#define  YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M	GENMASK(15, 0)
-#define   YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE(x)	FIELD_PREP(YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M, (x))
-
-enum yt921x_l2_type {
-	YT921X_L2_TYPE_ETH,
-	YT921X_L2_TYPE_ETHV2,
-	YT921X_L2_TYPE_ETHSAP,
-	YT921X_L2_TYPE_ETHSNAP,
-};
-
-enum yt921x_l3_type {
-	YT921X_L3_TYPE_OTHER,
-	YT921X_L3_TYPE_IPV4,
-	YT921X_L3_TYPE_IPV6,
-	YT921X_L3_TYPE_ARP,
-	YT921X_L3_TYPE_LLDP,
-	YT921X_L3_TYPE_PAE,
-	YT921X_L3_TYPE_ERP,
-	YT921X_L3_TYPE_SLOW_PROTOCOL,
-};
-
-enum yt921x_l4_type {
-	YT921X_L4_TYPE_OTHER,
-	YT921X_L4_TYPE_TCP,
-	YT921X_L4_TYPE_UDP,
-	YT921X_L4_TYPE_UDPLITE,
-	YT921X_L4_TYPE_ICMP,
-	YT921X_L4_TYPE_IGMP,
-	YT921X_L4_TYPE_MLD,
-	YT921X_L4_TYPE_ND,
-};
-
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
 #define YT921X_PORTn_IGR_TPID(port)	(0x210010 + 4 * (port))
@@ -630,47 +387,6 @@ enum yt921x_l4_type {
 #define  YT921X_LAG_HASH_MAC_SA			BIT(2)
 #define  YT921X_LAG_HASH_MAC_DA			BIT(1)
 #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
-#define YT921X_UDFn_CTRL(x)		(0x210094 + 4 * (x))
-#define  YT921X_UDF_CTRL_UDF_TYPE_M		GENMASK(8, 7)
-#define   YT921X_UDF_CTRL_UDF_TYPE(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_TYPE_M, (x))
-#define   YT921X_UDF_CTRL_UDF_TYPE_ETH			YT921X_UDF_CTRL_UDF_TYPE(0)
-#define   YT921X_UDF_CTRL_UDF_TYPE_L3			YT921X_UDF_CTRL_UDF_TYPE(1)
-#define   YT921X_UDF_CTRL_UDF_TYPE_L4			YT921X_UDF_CTRL_UDF_TYPE(2)
-#define  YT921X_UDF_CTRL_UDF_OFFSET_M		GENMASK(6, 0)
-#define   YT921X_UDF_CTRL_UDF_OFFSET(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_OFFSET_M, (x))
-
-#define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
-#define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
-#define YT921X_METER_SLOT		0x220104
-#define  YT921X_METER_SLOT_SLOT_M		GENMASK(11, 0)
-#define YT921X_PORTn_METER(port)	(0x220108 + 4 * (port))
-#define  YT921X_PORT_METER_EN			BIT(4)
-#define  YT921X_PORT_METER_ID_M			GENMASK(3, 0)
-#define   YT921X_PORT_METER_ID(x)			FIELD_PREP(YT921X_PORT_METER_ID_M, (x))
-#define YT921X_METERn_CTRL(x)		(0x220800 + 0x10 * (x))
-#define  YT921X_METER_CTRLc_METER_EN		BIT(14)
-#define  YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN	BIT(13)	/* RFC4115: yellow use unused green bw */
-#define  YT921X_METER_CTRLc_DROP_M		GENMASK(12, 11)
-#define   YT921X_METER_CTRLc_DROP(x)			FIELD_PREP(YT921X_METER_CTRLc_DROP_M, (x))
-#define   YT921X_METER_CTRLc_DROP_GYR			YT921X_METER_CTRLc_DROP(0)
-#define   YT921X_METER_CTRLc_DROP_YR			YT921X_METER_CTRLc_DROP(1)
-#define   YT921X_METER_CTRLc_DROP_R			YT921X_METER_CTRLc_DROP(2)
-#define   YT921X_METER_CTRLc_DROP_NONE			YT921X_METER_CTRLc_DROP(3)
-#define  YT921X_METER_CTRLc_COLOR_BLIND		BIT(10)
-#define  YT921X_METER_CTRLc_UNIT_M		GENMASK(9, 7)
-#define   YT921X_METER_CTRLc_UNIT(x)			FIELD_PREP(YT921X_METER_CTRLc_UNIT_M, (x))
-#define  YT921X_METER_CTRLc_BYTE_MODE_INCLUDE_GAP	BIT(6)	/* +GAP_VALUE bytes each packet */
-#define  YT921X_METER_CTRLc_PKT_MODE		BIT(5)	/* 0: byte rate mode */
-#define  YT921X_METER_CTRLc_RFC2698		BIT(4)	/* 0: RFC4115 */
-#define  YT921X_METER_CTRLbc_CBS_M		GENMASK_ULL(35, 20)
-#define   YT921X_METER_CTRLbc_CBS(x)			FIELD_PREP(YT921X_METER_CTRLbc_CBS_M, (x))
-#define  YT921X_METER_CTRLb_CIR_M		GENMASK(19, 2)
-#define   YT921X_METER_CTRLb_CIR(x)			FIELD_PREP(YT921X_METER_CTRLb_CIR_M, (x))
-#define  YT921X_METER_CTRLab_EBS_M		GENMASK_ULL(33, 18)
-#define   YT921X_METER_CTRLab_EBS(x)			FIELD_PREP(YT921X_METER_CTRLab_EBS_M, (x))
-#define  YT921X_METER_CTRLa_EIR_M		GENMASK(17, 0)
-#define   YT921X_METER_CTRLa_EIR(x)			FIELD_PREP(YT921X_METER_CTRLa_EIR_M, (x))
-#define YT921X_METERn_STAT(x)		(0x221000 + 8 * (x))
 
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
@@ -689,29 +405,6 @@ enum yt921x_l4_type {
 #define  YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED	BIT(1)
 #define  YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED	BIT(0)
 
-#define YT921X_MIRROR			0x300300
-#define  YT921X_MIRROR_IGR_PORTS_M		GENMASK(26, 16)
-#define   YT921X_MIRROR_IGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_IGR_PORTS_M, (x))
-#define  YT921X_MIRROR_IGR_PORTn(port)		BIT((port) + 16)
-#define  YT921X_MIRROR_EGR_PORTS_M		GENMASK(14, 4)
-#define   YT921X_MIRROR_EGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_EGR_PORTS_M, (x))
-#define  YT921X_MIRROR_EGR_PORTn(port)		BIT((port) + 4)
-#define  YT921X_MIRROR_PORT_M			GENMASK(3, 0)
-#define   YT921X_MIRROR_PORT(x)				FIELD_PREP(YT921X_MIRROR_PORT_M, (x))
-
-#define YT921X_PORT_SHAPE_SLOT		0x34000c
-#define  YT921X_PORT_SHAPE_SLOT_SLOT_M		GENMASK(11, 0)
-#define YT921X_PORTn_SHAPE_CTRL(port)	(0x354000 + 8 * (port))
-#define  YT921X_PORT_SHAPE_CTRLb_EN		BIT(4)
-#define  YT921X_PORT_SHAPE_CTRLb_PKT_MODE	BIT(3)	/* 0: byte rate mode */
-#define  YT921X_PORT_SHAPE_CTRLb_UNIT_M		GENMASK(2, 0)
-#define   YT921X_PORT_SHAPE_CTRLb_UNIT(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLb_UNIT_M, (x))
-#define  YT921X_PORT_SHAPE_CTRLa_CBS_M		GENMASK(31, 18)
-#define   YT921X_PORT_SHAPE_CTRLa_CBS(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CBS_M, (x))
-#define  YT921X_PORT_SHAPE_CTRLa_CIR_M		GENMASK(17, 0)
-#define   YT921X_PORT_SHAPE_CTRLa_CIR(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CIR_M, (x))
-#define YT921X_PORTn_SHAPE_STAT(port)	(0x356000 + 4 * (port))
-
 #define YT921X_EDATA_EXTMODE	0xfb
 #define YT921X_EDATA_LEN	0x100
 
@@ -728,19 +421,8 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
-#define YT921X_TOKEN_BYTE_C	1	/* 1 token = 2^1 byte */
-#define YT921X_TOKEN_PKT_C	-6	/* 1 token = 2^-6 packets */
-#define YT921X_TOKEN_RATE_C	-15
 /* Custom meters only, not including dedicated port meters (11) */
 #define YT921X_METER_NUM	64
-#define YT921X_METER_SLOT_MIN	80
-#define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
-#define YT921X_METER_CIR_MAX	((1 << 18) - 1)
-#define YT921X_METER_CBS_MAX	((1 << 16) - 1)
-#define YT921X_PORT_SHAPE_SLOT_MIN	80
-#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
-#define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
-#define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
 
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
@@ -758,8 +440,6 @@ enum yt921x_fdb_entry_status {
 #define YT921X_TAG_LEN	8
 
 #define YT921X_ACL_BLK_NUM	48
-#define YT921X_ACL_ENT_PER_BLK	8
-#define YT921X_ACL_NUM		(YT921X_ACL_BLK_NUM * YT921X_ACL_ENT_PER_BLK)
 #define YT921X_UDF_NUM		8
 
 #define YT921X_LED_GROUP_NUM	3
@@ -770,26 +450,6 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_NAME	"yt921x"
 
-struct yt921x_acl_entry {
-	u32 key[2];
-	u32 mask[2];
-};
-
-struct yt921x_acl_rule {
-	unsigned long tag;
-	enum tc_setup_type type;
-
-	u32 action[3];
-	bool sw_assisted;
-
-	u8 mask;
-	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
-};
-
-struct yt921x_acl_blk {
-	struct yt921x_acl_rule *rules[YT921X_ACL_ENT_PER_BLK];
-};
-
 struct yt921x_port {
 	unsigned char index;
 
@@ -893,4 +553,14 @@ static inline int ethtool_speed_to_yt921x(int speed)
 	}
 }
 
+static inline u32 ethaddr_hi4_to_u32(const unsigned char *addr)
+{
+	return (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
+}
+
+static inline u32 ethaddr_lo2_to_u32(const unsigned char *addr)
+{
+	return (addr[4] << 8) | addr[5];
+}
+
 #endif
diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
new file mode 100644
index 000000000000..433a428ed070
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -0,0 +1,1496 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include "chip.h"
+#include "smi.h"
+#include "tc.h"
+
+static int yt921x_mtu_fetch(struct yt921x_priv *priv, int port)
+{
+	struct dsa_port *dp = dsa_to_port(&priv->ds, port);
+
+	return dp->user ? READ_ONCE(dp->user->mtu) : ETH_DATA_LEN;
+}
+
+/* v * 2^e */
+static u64 ldexpu64(u64 v, int e)
+{
+	return e >= 0 ? v << e : v >> -e;
+}
+
+/* slot (ns) * rate (/s) / 10^9 (ns/s) = 2^C * token * 4^unit */
+static u32 rate2token(u64 rate, unsigned int slot_ns, int unit, int C)
+{
+	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
+
+	return div_u64(ldexpu64(slot_ns * rate, -e), 1000000000);
+}
+
+static u64 token2rate(u32 token, unsigned int slot_ns, int unit, int C)
+{
+	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
+
+	return div_u64(ldexpu64(mul_u32_u32(1000000000, token), e), slot_ns);
+}
+
+/* burst = 2^C * token * 4^unit */
+static u32 burst2token(u64 burst, int unit, int C)
+{
+	return ldexpu64(burst, -(2 * unit + C));
+}
+
+static u64 token2burst(u32 token, int unit, int C)
+{
+	return ldexpu64(token, 2 * unit + C);
+}
+
+struct yt921x_marker {
+	u32 cir;
+	u32 cbs;
+	u32 ebs;
+	int unit;
+	bool pkt_mode;
+};
+
+#define YT921X_MARKER_PKT_MODE		BIT(0)
+#define YT921X_MARKER_SINGLE_BUCKET	BIT(1)
+
+static int
+yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
+		  unsigned int flags, unsigned int slot_ns, u32 cir_max,
+		  u32 cbs_max, int unit_max, struct yt921x_priv *priv, int port,
+		  struct netlink_ext_ack *extack)
+{
+	const int C = flags & YT921X_MARKER_PKT_MODE ? YT921X_TOKEN_PKT_C :
+		      YT921X_TOKEN_BYTE_C;
+	struct device *dev = yt921x_priv_to_device(priv);
+	struct yt921x_marker m;
+	u64 burst_est;
+	u64 burst_sug;
+	u64 burst_max;
+	u64 rate_max;
+
+	m.unit = unit_max;
+	rate_max = token2rate(cir_max, slot_ns, m.unit, C);
+	burst_max = token2burst(cbs_max, m.unit, C);
+
+	/* Check for unusual values */
+	if (rate > rate_max || burst > burst_max) {
+		NL_SET_ERR_MSG_MOD(extack, "Unexpected tremendous rate");
+		return -ERANGE;
+	}
+
+	/* Check for matching burst */
+	burst_est = div_u64(slot_ns * rate, 1000000000);
+	burst_sug = burst_est;
+	if (flags & YT921X_MARKER_PKT_MODE)
+		burst_sug++;
+	else
+		burst_sug += ETH_HLEN + yt921x_mtu_fetch(priv, port) +
+			     ETH_FCS_LEN;
+	if (burst_sug > burst)
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Consider match rate %llu with burst at least %llu",
+				       rate, burst_sug);
+
+	/* Select unit */
+	for (; m.unit > 0; m.unit--) {
+		if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
+			break;
+		rate_max >>= 2;
+		burst_max >>= 2;
+	}
+
+	/* Calculate information rate and bucket size */
+	m.cir = rate2token(rate, slot_ns, m.unit, C);
+	if (!m.cir)
+		m.cir = 1;
+	else if (WARN_ON(m.cir > cir_max))
+		m.cir = cir_max;
+	m.cbs = burst2token(burst, m.unit, C);
+	if (!m.cbs)
+		m.cbs = 1;
+	else if (WARN_ON(m.cbs > cbs_max))
+		m.cbs = cbs_max;
+
+	/* Cut EBS */
+	m.ebs = 0;
+	if (!(flags & YT921X_MARKER_SINGLE_BUCKET)) {
+		/* We don't have a chance to adjust rate when MTU is changed */
+		if (flags & YT921X_MARKER_PKT_MODE)
+			burst_est++;
+		else
+			burst_est += YT921X_FRAME_SIZE_MAX;
+
+		if (burst_est < burst) {
+			u32 pbs = m.cbs;
+
+			m.cbs = burst2token(burst_est, m.unit, C);
+			if (!m.cbs)
+				m.cbs = 1;
+			else if (WARN_ON(m.cbs > cbs_max))
+				m.cbs = cbs_max;
+
+			if (pbs > m.cbs)
+				m.ebs = pbs - m.cbs;
+		}
+	}
+
+	dev_dbg(dev,
+		"slot %u ns, rate %llu, burst %llu -> unit %d, cir %u, cbs %u, ebs %u\n",
+		slot_ns, rate, burst, m.unit, m.cir, m.cbs, m.ebs);
+
+	m.pkt_mode = flags & YT921X_MARKER_PKT_MODE;
+	*marker = m;
+	return 0;
+}
+
+static int
+yt921x_marker_tfm_police(struct yt921x_marker *marker,
+			 const struct flow_action_police *police,
+			 unsigned int flags, struct yt921x_priv *priv, int port,
+			 struct netlink_ext_ack *extack)
+{
+	bool pkt_mode = !!police->rate_pkt_ps;
+	u64 burst;
+	u64 rate;
+
+	rate = pkt_mode ? police->rate_pkt_ps : police->rate_bytes_ps;
+	burst = pkt_mode ? police->burst_pkt : police->burst;
+	if (pkt_mode)
+		flags |= YT921X_MARKER_PKT_MODE;
+
+	return yt921x_marker_tfm(marker, rate, burst, flags,
+				 priv->meter_slot_ns, YT921X_METER_CIR_MAX,
+				 YT921X_METER_CBS_MAX, YT921X_METER_UNIT_MAX,
+				 priv, port, extack);
+}
+
+static int
+yt921x_marker_tfm_shape(struct yt921x_marker *marker, u64 rate, u64 burst,
+			unsigned int flags, struct yt921x_priv *priv, int port,
+			struct netlink_ext_ack *extack)
+{
+	return yt921x_marker_tfm(marker, rate, burst, flags,
+				 priv->port_shape_slot_ns, YT921X_SHAPE_CIR_MAX,
+				 YT921X_SHAPE_CBS_MAX, YT921X_SHAPE_UNIT_MAX,
+				 priv, port, extack);
+}
+
+static int
+yt921x_police_validate(const struct flow_action_police *police,
+		       const struct flow_action *action,
+		       const struct flow_action_entry *act,
+		       struct netlink_ext_ack *extack)
+{
+	if (police->exceed.act_id != FLOW_ACTION_DROP) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when exceed action is not drop");
+		return -EOPNOTSUPP;
+	}
+
+	if (police->notexceed.act_id != FLOW_ACTION_PIPE &&
+	    police->notexceed.act_id != FLOW_ACTION_ACCEPT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when conform action is not pipe or ok");
+		return -EOPNOTSUPP;
+	}
+
+	if (police->notexceed.act_id == FLOW_ACTION_ACCEPT && action && act &&
+	    !flow_action_is_last_entry(action, act)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when conform action is ok, but action is not last");
+		return -EOPNOTSUPP;
+	}
+
+	/* mtu defaults to unlimited but we got 2040 here, don't know why */
+	if (police->peakrate_bytes_ps || police->avrate || police->overhead) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when peakrate/avrate/overhead is configured");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_meter_config(struct yt921x_priv *priv, unsigned int id,
+		    const struct yt921x_marker *marker)
+{
+	u32 ctrls[3];
+
+	ctrls[0] = 0;
+	ctrls[1] = YT921X_METER_CTRLb_CIR(marker->cir);
+	ctrls[2] = YT921X_METER_CTRLc_UNIT(marker->unit) |
+		   YT921X_METER_CTRLc_DROP_R |
+		   YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN |
+		   YT921X_METER_CTRLc_METER_EN;
+	if (marker->pkt_mode)
+		ctrls[2] |= YT921X_METER_CTRLc_PKT_MODE;
+	update_ctrls_unaligned(&ctrls[0], &ctrls[1],
+			       YT921X_METER_CTRLab_EBS_M,
+			       YT921X_METER_CTRLab_EBS(marker->ebs));
+	update_ctrls_unaligned(&ctrls[1], &ctrls[2],
+			       YT921X_METER_CTRLbc_CBS_M,
+			       YT921X_METER_CTRLbc_CBS(marker->cbs));
+
+	return yt921x_reg96_write(priv, YT921X_METERn_CTRL(id), ctrls);
+}
+
+void yt921x_dsa_port_policer_del(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), 0);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "delete policer on",
+			port, res);
+}
+
+int
+yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
+			    const struct flow_action_police *police,
+			    struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct yt921x_marker marker;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_police_validate(police, NULL, NULL, extack);
+	if (res)
+		return res;
+
+	res = yt921x_marker_tfm_police(&marker, police, 0, priv, port, extack);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_meter_config(priv, port + YT921X_METER_NUM, &marker);
+	if (res)
+		goto end;
+
+	ctrl = YT921X_PORT_METER_ID(port) | YT921X_PORT_METER_EN;
+	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), ctrl);
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
+				  const struct tc_tbf_qopt_offload *qopt)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct netlink_ext_ack *extack = qopt->extack;
+	u32 ctrls[2];
+	int res;
+
+	if (qopt->parent != TC_H_ROOT)
+		return -EOPNOTSUPP;
+
+	switch (qopt->command) {
+	case TC_TBF_STATS:
+		/* Unfortunately the convention for TC_*_STATS is a mess,
+		 * neither 0 nor -EOPNOTSUPP is perfect here.
+		 */
+		return -EOPNOTSUPP;
+	case TC_TBF_DESTROY:
+		ctrls[0] = 0;
+		ctrls[1] = 0;
+		break;
+	case TC_TBF_REPLACE: {
+		const struct tc_tbf_qopt_offload_replace_params *p;
+		struct yt921x_marker marker;
+
+		p = &qopt->replace_params;
+
+		res = yt921x_marker_tfm_shape(&marker, p->rate.rate_bytes_ps,
+					      p->max_size,
+					      YT921X_MARKER_SINGLE_BUCKET,
+					      priv, port, extack);
+		if (res)
+			return res;
+
+		ctrls[0] = YT921X_PORT_SHAPE_CTRLa_CIR(marker.cir) |
+			   YT921X_PORT_SHAPE_CTRLa_CBS(marker.cbs);
+		ctrls[1] = YT921X_PORT_SHAPE_CTRLb_UNIT(marker.unit) |
+			   YT921X_PORT_SHAPE_CTRLb_EN;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg64_write(priv, YT921X_PORTn_SHAPE_CTRL(port), ctrls);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+int
+yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
+			 enum tc_setup_type type, void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_TBF: {
+		const struct tc_tbf_qopt_offload *qopt = type_data;
+
+		return yt921x_dsa_port_setup_tc_tbf_port(ds, port, qopt);
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/* ACL: 48 blocks * 8 entries
+ *
+ * One rule can span multiple entries, but within a block.
+ */
+
+static void
+yt921x_acl_entry_set(struct yt921x_acl_entry *entry, unsigned int offset,
+		     u32 flags, bool set)
+{
+	if (set)
+		entry->key[offset] |= flags;
+	entry->mask[offset] |= flags;
+}
+
+static unsigned int
+yt921x_acl_entries_set_is_fragment(struct yt921x_acl_entry *entries,
+				   unsigned int size, bool set)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV4_DA:
+		case YT921X_ACL_TYPE_IPV4_SA:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV4_FRAG, set);
+			return size;
+		case YT921X_ACL_TYPE_IPV6_DA3:
+		case YT921X_ACL_TYPE_IPV6_SA3:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV6_xA3_FRAG,
+					     set);
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_MISC_FRAG, set);
+			return size;
+		case YT921X_ACL_TYPE_L4:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_L4_FRAG, set);
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	yt921x_acl_entry_set(&entries[size], 1, YT921X_ACL_BINb_MISC_FRAG, set);
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_first_frag(struct yt921x_acl_entry *entries,
+				  unsigned int size, bool set)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV6_DA2:
+		case YT921X_ACL_TYPE_IPV6_SA2:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG,
+					     set);
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			yt921x_acl_entry_set(&entries[i], 0,
+					     YT921X_ACL_BINa_MISC_FIRST_FRAG,
+					     set);
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	yt921x_acl_entry_set(&entries[size], 0,
+			     YT921X_ACL_BINa_MISC_FIRST_FRAG, set);
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_l3_type(struct yt921x_acl_entry *entries,
+			       unsigned int size, enum yt921x_l3_type type)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_MAC_DA0:
+		case YT921X_ACL_TYPE_MAC_SA0:
+			entries[i].key[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			entries[i].key[0] |= YT921X_ACL_BINa_MISC_L3_TYPE(type);
+			entries[i].mask[0] |= YT921X_ACL_BINa_MISC_L3_TYPE_M;
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[0] = YT921X_ACL_BINa_MISC_L3_TYPE(type);
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	entries[size].mask[0] = YT921X_ACL_BINa_MISC_L3_TYPE_M;
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_l4_type(struct yt921x_acl_entry *entries,
+			       unsigned int size, enum yt921x_l4_type type)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV4_DA:
+		case YT921X_ACL_TYPE_IPV4_SA:
+			entries[i].key[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_IPV6_DA0:
+		case YT921X_ACL_TYPE_IPV6_DA1:
+		case YT921X_ACL_TYPE_IPV6_DA2:
+		case YT921X_ACL_TYPE_IPV6_DA3:
+		case YT921X_ACL_TYPE_IPV6_SA0:
+		case YT921X_ACL_TYPE_IPV6_SA1:
+		case YT921X_ACL_TYPE_IPV6_SA2:
+		case YT921X_ACL_TYPE_IPV6_SA3:
+			entries[i].key[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_L4:
+			entries[i].key[1] |= YT921X_ACL_BINb_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			entries[i].key[1] |= YT921X_ACL_BINb_MISC_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_MISC_L4_TYPE_M;
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_BINb_MISC_L4_TYPE(type) |
+			       YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	entries[size].mask[1] = YT921X_ACL_BINb_MISC_L4_TYPE_M;
+
+	return size + 1;
+}
+
+static struct yt921x_acl_entry *
+yt921x_acl_entries_new(struct yt921x_acl_entry *entries, unsigned int *sizep,
+		       u32 type)
+{
+	unsigned int size = *sizep;
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return NULL;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(type);
+
+	(*sizep)++;
+	return &entries[size];
+}
+
+static struct yt921x_acl_entry *
+yt921x_acl_entries_find(struct yt921x_acl_entry *entries, unsigned int *sizep,
+			u32 type)
+{
+	for (unsigned int i = 0; i < *sizep; i++)
+		if (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1]) ==
+		    type)
+			return &entries[i];
+	return yt921x_acl_entries_new(entries, sizep, type);
+}
+
+static void
+yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 ord,
+			  u16 ports_mask)
+{
+	struct yt921x_acl_entry *entries = aclrule->entries;
+
+	for (unsigned int i = 0; i < hweight8(aclrule->mask); i++) {
+		entries[i].key[1] |= YT921X_ACL_KEYb_SPORTS(ports_mask) |
+				     YT921X_ACL_KEYb_ORD(ord);
+	}
+}
+
+struct yt921x_acl_rule_ext {
+	struct yt921x_acl_rule r;
+
+	struct yt921x_marker marker;
+};
+
+static int
+yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
+				       const struct flow_cls_offload *cls)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	struct yt921x_acl_entry *entries = ruleext->r.entries;
+	struct netlink_ext_ack *extack = cls->common.extack;
+	const struct flow_dissector *dissector;
+	struct yt921x_acl_entry *entry;
+	unsigned int size = 0;
+	bool use_dport;
+	bool use_sport;
+
+	/* Incomplete and probably won't, since it supports custom u32 filters.
+	 * New adapters are welcome.
+	 */
+	dissector = rule->match.dissector;
+	if (dissector->used_keys &
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported keys used");
+		return -EOPNOTSUPP;
+	}
+
+	/* Entries */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs match;
+
+		flow_rule_match_ipv4_addrs(rule, &match);
+
+		if (match.mask->dst) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV4_DA);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->dst);
+			entry->mask[0] |= ntohl(match.mask->dst);
+		}
+
+		if (match.mask->src) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV4_SA);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->src);
+			entry->mask[0] |= ntohl(match.mask->src);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+		struct flow_match_ipv6_addrs match;
+
+		flow_rule_match_ipv6_addrs(rule, &match);
+
+		for (unsigned int i = 0; i < 4; i++) {
+			if (!match.mask->dst.s6_addr32[i])
+				continue;
+
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV6_DA0 + i);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->dst.s6_addr32[i]);
+			entry->mask[0] |= ntohl(match.mask->dst.s6_addr32[i]);
+		}
+
+		for (unsigned int i = 0; i < 4; i++) {
+			if (!match.mask->src.s6_addr32[i])
+				continue;
+
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV6_SA0 + i);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->src.s6_addr32[i]);
+			entry->mask[0] |= ntohl(match.mask->src.s6_addr32[i]);
+		}
+	}
+
+	use_dport = false;
+	use_sport = false;
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		entry = yt921x_acl_entries_new(entries, &size,
+					       YT921X_ACL_TYPE_L4);
+		if (!entry)
+			goto err;
+
+		flow_rule_match_ports(rule, &match);
+
+		use_dport = !!match.mask->dst;
+		use_sport = !!match.mask->src;
+
+		entry->key[0] |= (ntohs(match.key->dst) << 16) |
+				 ntohs(match.key->src);
+		entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
+				  ntohs(match.mask->src);
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		struct flow_match_ports_range match;
+
+		entry = yt921x_acl_entries_find(entries, &size,
+						YT921X_ACL_TYPE_L4);
+		if (!entry)
+			goto err;
+
+		flow_rule_match_ports_range(rule, &match);
+
+		if ((use_dport && match.mask->tp.dst) ||
+		    (use_sport && match.mask->tp.src)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Port mask and range are mutually exclusive");
+			return -EINVAL;
+		}
+
+		if (match.mask->tp.dst) {
+			entry->key[0] |= ntohs(match.key->tp_min.dst) << 16;
+			entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
+			entry->mask[0] |= ntohs(match.key->tp_max.dst) << 16;
+		}
+
+		if (match.mask->tp.src) {
+			entry->key[0] |= ntohs(match.key->tp_min.src);
+			entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
+			entry->mask[0] |= ntohs(match.key->tp_max.src);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_match_eth_addrs match;
+		u32 mask;
+
+		flow_rule_match_eth_addrs(rule, &match);
+
+		mask = ethaddr_hi4_to_u32(match.mask->dst);
+		if (mask) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_MAC_DA0);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ethaddr_hi4_to_u32(match.key->dst);
+			entry->mask[0] |= mask;
+		}
+
+		mask = ethaddr_hi4_to_u32(match.mask->src);
+		if (mask) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_MAC_SA0);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ethaddr_hi4_to_u32(match.key->src);
+			entry->mask[0] |= mask;
+		}
+
+		mask = (ethaddr_lo2_to_u32(match.mask->dst) << 16) |
+		       ethaddr_lo2_to_u32(match.mask->src);
+		if (mask) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_MAC_DA1_SA1);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= (ethaddr_lo2_to_u32(match.key->dst) << 16) |
+					 ethaddr_lo2_to_u32(match.key->src);
+			entry->mask[0] |= mask;
+		}
+	}
+
+	/* Entries + Misc */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+
+		if (match.mask->n_proto) {
+			enum yt921x_l3_type l3type = YT921X_L3_TYPE_OTHER;
+
+			if (match.mask->n_proto == htons(~0))
+				switch (match.key->n_proto) {
+				case htons(ETH_P_IP):
+					l3type = YT921X_L3_TYPE_IPV4;
+					break;
+				case htons(ETH_P_IPV6):
+					l3type = YT921X_L3_TYPE_IPV6;
+					break;
+				case htons(ETH_P_ARP):
+					l3type = YT921X_L3_TYPE_ARP;
+					break;
+				case htons(ETH_P_LLDP):
+					l3type = YT921X_L3_TYPE_LLDP;
+					break;
+				case htons(ETH_P_PAE):
+					l3type = YT921X_L3_TYPE_PAE;
+					break;
+				case htons(ETH_P_CFM):
+					l3type = YT921X_L3_TYPE_ERP;
+					break;
+				}
+
+			if (l3type != YT921X_L3_TYPE_OTHER) {
+				size = yt921x_acl_entries_set_l3_type(entries,
+								      size,
+								      l3type);
+				if (!size)
+					goto err;
+			} else {
+				entry = yt921x_acl_entries_new(entries, &size,
+							       YT921X_ACL_TYPE_ETHERTYPE);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= ntohs(match.key->n_proto);
+				entry->mask[0] |= ntohs(match.mask->n_proto);
+			}
+		}
+
+		if (match.mask->ip_proto) {
+			enum yt921x_l4_type l4type = YT921X_L4_TYPE_OTHER;
+
+			if (match.mask->ip_proto == (u8)~0)
+				switch (match.key->ip_proto) {
+				case IPPROTO_TCP:
+					l4type = YT921X_L4_TYPE_TCP;
+					break;
+				case IPPROTO_UDP:
+					l4type = YT921X_L4_TYPE_UDP;
+					break;
+				case IPPROTO_UDPLITE:
+					l4type = YT921X_L4_TYPE_UDPLITE;
+					break;
+				case IPPROTO_ICMP:
+					l4type = YT921X_L4_TYPE_ICMP;
+					break;
+				case IPPROTO_IGMP:
+					l4type = YT921X_L4_TYPE_IGMP;
+					break;
+				}
+
+			if (l4type != YT921X_L4_TYPE_OTHER) {
+				size = yt921x_acl_entries_set_l4_type(entries,
+								      size,
+								      l4type);
+				if (!size)
+					goto err;
+			} else {
+				entry = yt921x_acl_entries_find(entries, &size,
+								YT921X_ACL_TYPE_MISC);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.key->ip_proto);
+				entry->mask[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.mask->ip_proto);
+			}
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG;
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		if (!flow_rule_is_supp_control_flags(supp_flags,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
+
+		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			bool set = match.key->flags & FLOW_DIS_IS_FRAGMENT;
+
+			size = yt921x_acl_entries_set_is_fragment(entries, size,
+								  set);
+			if (!size)
+				goto err;
+		}
+		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
+			bool set = match.key->flags & FLOW_DIS_FIRST_FRAG;
+
+			size = yt921x_acl_entries_set_first_frag(entries, size,
+								 set);
+			if (!size)
+				goto err;
+		}
+	}
+
+	/* Misc only */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
+		struct flow_match_ip match;
+
+		flow_rule_match_ip(rule, &match);
+		if (match.mask->ttl) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Matching on TTL not supported");
+			return -EOPNOTSUPP;
+		}
+
+		if (match.mask->tos) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MISC);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= YT921X_ACL_BINa_MISC_TOS(match.key->tos);
+			entry->mask[0] |= YT921X_ACL_BINa_MISC_TOS(match.mask->tos);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
+		struct flow_match_tcp match;
+
+		flow_rule_match_tcp(rule, &match);
+		if (match.mask->flags & htons(~0xff)) {
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported TCP flags");
+			return -EOPNOTSUPP;
+		}
+
+		if (match.mask->flags) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MISC);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
+			entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));
+		}
+	}
+
+	if (!size) {
+		NL_SET_ERR_MSG_MOD(extack, "Empty rule generated, this should not happen");
+		return -EOPNOTSUPP;
+	}
+
+	ruleext->r.mask = (1 << size) - 1;
+	return 0;
+
+err:
+	NL_SET_ERR_MSG_MOD(extack, "Rule too complex");
+	return -EOPNOTSUPP;
+}
+
+static int
+yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
+				      const struct flow_cls_offload *cls,
+				      struct yt921x_priv *priv, int port)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	const struct flow_action *flow_action = &rule->action;
+	struct netlink_ext_ack *extack = cls->common.extack;
+	enum flow_action_id redir_act = NUM_FLOW_ACTIONS;
+	const struct flow_action_entry *act;
+	u32 *action = ruleext->r.action;
+	bool seen_priority = false;
+	const char *reason = NULL;
+	bool seen_police = false;
+	unsigned int i;
+	int res;
+
+	memset(action, 0, 3 * sizeof(*action));
+	flow_action_for_each(i, act, flow_action)
+		switch (act->id) {
+		case FLOW_ACTION_ACCEPT:
+		case FLOW_ACTION_DROP:
+		case FLOW_ACTION_REDIRECT:
+			if (redir_act != NUM_FLOW_ACTIONS &&
+			    redir_act != act->id) {
+				reason = "Different redirect actions";
+				goto fallback;
+			}
+			redir_act = act->id;
+
+			switch (act->id) {
+			case FLOW_ACTION_ACCEPT:
+				action[2] |= YT921X_ACL_ACTc_FWD_EN |
+					     YT921X_ACL_ACTc_FWD_FWD;
+				break;
+			case FLOW_ACTION_DROP:
+				action[2] |= YT921X_ACL_ACTc_FWD_EN |
+					     YT921X_ACL_ACTc_FWD_REDIR;
+				break;
+			case FLOW_ACTION_REDIRECT: {
+				struct dsa_port *to_dp;
+
+				to_dp = dsa_port_from_netdev(act->dev);
+				if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
+					reason = "Redirect to non-local port";
+					goto fallback;
+				}
+
+				action[2] |= YT921X_ACL_ACTc_FWD_EN |
+					     YT921X_ACL_ACTc_FWD_REDIR |
+					     YT921X_ACL_ACTc_FWD_REDIR_DPORTn(to_dp->index);
+				break;
+			}
+			default:
+				break;
+			}
+			break;
+		case FLOW_ACTION_PRIORITY:
+			if (seen_priority) {
+				action[0] &= ~YT921X_ACL_ACTa_PRIO_EN;
+				action[1] &= ~YT921X_ACL_ACTb_PRIO_M;
+
+				reason = "Multiple priority actions";
+				goto fallback;
+			}
+			seen_priority = true;
+
+			if (act->priority >= YT921X_PRIO_NUM) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Priority value is too high");
+				return -EOPNOTSUPP;
+			}
+			action[0] |= YT921X_ACL_ACTa_PRIO_EN;
+			action[1] |= YT921X_ACL_ACTb_PRIO(act->priority);
+			break;
+		case FLOW_ACTION_POLICE: {
+			const struct flow_action_police *police = &act->police;
+
+			if (seen_police) {
+				action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+
+				reason = "Multiple police actions";
+				goto fallback;
+			}
+			seen_police = true;
+
+			res = yt921x_police_validate(police, flow_action, act,
+						     extack);
+			if (res)
+				return res;
+
+			res = yt921x_marker_tfm_police(&ruleext->marker, police,
+						       0, priv, port, extack);
+			if (res)
+				return res;
+
+			action[0] |= YT921X_ACL_ACTa_METER_EN;
+			break;
+		}
+		default:
+fallback:
+			if (cls->common.skip_sw) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Action not supported when skip_sw: %s",
+						       reason);
+				return -EOPNOTSUPP;
+			}
+			fallthrough;
+		case FLOW_ACTION_TRAP:
+			redir_act = FLOW_ACTION_TRAP;
+
+			action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
+				     ~YT921X_ACL_ACTc_FWD_M;
+			action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				     YT921X_ACL_ACTc_FWD_TRAP;
+			break;
+		}
+
+	ruleext->r.sw_assisted = !cls->common.skip_sw;
+	return 0;
+}
+
+static int
+yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
+			       const struct flow_cls_offload *cls, bool ingress,
+			       struct yt921x_priv *priv)
+{
+	struct netlink_ext_ack *extack = cls->common.extack;
+	int res;
+
+	if (!ingress) {
+		NL_SET_ERR_MSG_MOD(extack, "Only ingress is supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (cls->common.chain_index) {
+		NL_SET_ERR_MSG(extack, "Only chain 0 is supported");
+		return -EOPNOTSUPP;
+	}
+
+	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
+	if (res)
+		return res;
+	res = yt921x_acl_rule_ext_parse_flow_entries(ruleext, cls);
+	if (res)
+		return res;
+
+	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
+	ruleext->r.tag = cls->cookie;
+	ruleext->r.type = TC_SETUP_CLSFLOWER;
+	return 0;
+}
+
+static unsigned int
+yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
+		unsigned long tag)
+{
+	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
+		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
+
+		if (!aclblk)
+			continue;
+
+		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
+			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
+			    aclblk->rules[i]->type == type)
+				return YT921X_ACL_ENT_PER_BLK * blkid + i;
+	}
+
+	return UINT_MAX;
+}
+
+static unsigned int
+yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
+		   struct netlink_ext_ack *extack)
+{
+	int candidates[YT921X_ACL_ENT_PER_BLK + 1];
+	unsigned int acl_used_cnt = 0;
+
+	if (WARN_ON(entscnt > YT921X_ACL_ENT_PER_BLK))
+		return UINT_MAX;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(candidates); i++)
+		candidates[i] = -1;
+	for (unsigned int i = YT921X_ACL_BLK_NUM; i-- > 0;) {
+		unsigned int blk_used_cnt = hweight8(priv->acl_masks[i]);
+
+		candidates[blk_used_cnt] = i;
+		acl_used_cnt += blk_used_cnt;
+	}
+
+	if (acl_used_cnt >= YT921X_ACL_NUM) {
+		NL_SET_ERR_MSG_MOD(extack, "ACL entry limit reached");
+		return UINT_MAX;
+	}
+	if (acl_used_cnt + entscnt <= YT921X_ACL_NUM)
+		for (unsigned int i = YT921X_ACL_ENT_PER_BLK - entscnt + 1;
+		     i-- > 0;)
+			if (candidates[i] >= 0)
+				return YT921X_ACL_ENT_PER_BLK * candidates[i] +
+				       ffz(priv->acl_masks[candidates[i]]);
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "ACL entry allocation failed, simplify your rules or remove existing rules");
+	return UINT_MAX;
+}
+
+static int
+yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
+{
+	const struct yt921x_acl_rule *aclrule;
+	const struct yt921x_acl_blk *aclblk;
+	unsigned int blkid;
+	unsigned int binid;
+	unsigned long mask;
+	u32 zeros[3] = {};
+	unsigned int i;
+	unsigned int o;
+	u32 ctrl;
+	int res;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	/* Write actions */
+	res = yt921x_reg96_write(priv, YT921X_ACLn_ACT(entid),
+				 aclrule ? aclrule->action : zeros);
+	if (res)
+		return res;
+
+	/* Select the block */
+	ctrl = YT921X_ACL_BLK_CMD_MODIFY | YT921X_ACL_BLK_CMD_BLKID(blkid);
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	if (res)
+		return res;
+
+	/* Write keys and masks */
+	ctrl = 0;
+	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
+		ctrl |= YT921X_ACL_BLK_KEEP_KEEPn(i);
+
+	mask = entsmask;
+	i = 0;
+	for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+		res = yt921x_reg64_write(priv, YT921X_ACLn_KEYm(blkid, o),
+					 aclrule ? aclrule->entries[i].key :
+					 zeros);
+		if (res)
+			return res;
+
+		res = yt921x_reg64_write(priv, YT921X_ACLn_MASKm(blkid, o),
+					 aclrule ? aclrule->entries[i].mask :
+					 zeros);
+		if (res)
+			return res;
+
+		ctrl &= ~YT921X_ACL_BLK_KEEP_KEEPn(o);
+		i++;
+	}
+
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_KEEP, ctrl);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++) {
+		const struct yt921x_acl_rule *other = aclblk->rules[i];
+
+		if (!other)
+			continue;
+
+		mask = other->mask;
+		for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK)
+			ctrl |= YT921X_ACL_ENTRY_ENm(o) |
+				YT921X_ACL_ENTRY_GRPIDm(o, i);
+	}
+	res = yt921x_reg_write(priv, YT921X_ACLn_ENTRY(blkid), ctrl);
+	if (res)
+		return res;
+
+	/* Commit the block */
+	ctrl = YT921X_ACL_BLK_CMD_BLKID(blkid);
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
+	       unsigned long tag)
+{
+	struct yt921x_acl_rule *aclrule;
+	struct yt921x_acl_blk *aclblk;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	int res;
+
+	entid = yt921x_acl_find(priv, type, tag);
+	if (entid == UINT_MAX)
+		return -ENOENT;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	aclblk->rules[binid] = NULL;
+	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	/* the kernel never rolls back on failure */
+
+	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
+		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
+				    aclrule->action[0]),
+			  priv->meters_map);
+	priv->acl_masks[blkid] &= ~aclrule->mask;
+	kvfree(aclrule);
+	if (!priv->acl_masks[blkid]) {
+		kvfree(aclblk);
+		priv->acl_blks[blkid] = NULL;
+	}
+	return res;
+}
+
+static int
+yt921x_acl_add(struct yt921x_priv *priv,
+	       const struct yt921x_acl_rule_ext *ruleext,
+	       struct netlink_ext_ack *extack)
+{
+	unsigned int entscnt = hweight8(ruleext->r.mask);
+	struct yt921x_acl_rule *aclrule;
+	struct yt921x_acl_blk *aclblk;
+	bool use_trap = false;
+	unsigned int meterid;
+	unsigned long mask;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	unsigned int o;
+	int res;
+
+	/* Allocate resources */
+	entid = yt921x_acl_reserve(priv, entscnt, extack);
+	if (entid == UINT_MAX)
+		return -EOPNOTSUPP;
+
+	if (!(ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN)) {
+		meterid = YT921X_METER_NUM;
+	} else {
+		meterid = find_first_zero_bit(priv->meters_map,
+					      YT921X_METER_NUM);
+		if (meterid < YT921X_METER_NUM) {
+			res = yt921x_meter_config(priv, meterid,
+						  &ruleext->marker);
+			if (res)
+				return res;
+		} else if (ruleext->r.sw_assisted) {
+			use_trap = true;
+		} else {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "No more meters available");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/* Prepare acl block ctrlblk */
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	if (!aclblk) {
+		aclblk = kvzalloc_obj(*aclblk);
+		if (!aclblk)
+			return -ENOMEM;
+		priv->acl_blks[blkid] = aclblk;
+	}
+
+	/* Prepare acl rule ctrlblk */
+	aclrule = kvmemdup(&ruleext->r,
+			   offsetof(struct yt921x_acl_rule, entries[entscnt]),
+			   GFP_KERNEL);
+	if (!aclrule) {
+		res = -ENOMEM;
+		goto err;
+	}
+
+	/* Replace the placeholder resource IDs */
+	aclrule->mask = 0;
+	mask = priv->acl_masks[blkid];
+	for_each_clear_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+		aclrule->mask |= BIT(o);
+		entscnt--;
+		if (!entscnt)
+			break;
+	}
+
+	if (use_trap) {
+		aclrule->action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
+				      ~YT921X_ACL_ACTc_FWD_M;
+		aclrule->action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				      YT921X_ACL_ACTc_FWD_TRAP;
+	}
+	if (meterid < YT921X_METER_NUM)
+		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
+	else
+		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+
+	/* Write rules */
+	aclblk->rules[binid] = aclrule;
+	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	if (res) {
+		aclblk->rules[binid] = NULL;
+		kvfree(aclrule);
+		goto err;
+	}
+
+	if (meterid < YT921X_METER_NUM)
+		set_bit(meterid, priv->meters_map);
+	priv->acl_masks[blkid] |= aclrule->mask;
+	return 0;
+
+err:
+	if (!priv->acl_masks[blkid]) {
+		kvfree(aclblk);
+		priv->acl_blks[blkid] = NULL;
+	}
+	return res;
+}
+
+int
+yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+int
+yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress)
+{
+	struct netlink_ext_ack *extack = cls->common.extack;
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct yt921x_acl_rule_ext ruleext;
+	int res;
+
+	res = yt921x_acl_rule_ext_parse_flow(&ruleext, port, cls, ingress,
+					     priv);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_add(priv, &ruleext, extack);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
+{
+	u32 mask;
+
+	if (ingress)
+		mask = YT921X_MIRROR_IGR_PORTn(port);
+	else
+		mask = YT921X_MIRROR_EGR_PORTn(port);
+	return yt921x_reg_clear_bits(priv, YT921X_MIRROR, mask);
+}
+
+static int
+yt921x_mirror_add(struct yt921x_priv *priv, int port, bool ingress,
+		  int to_local_port, struct netlink_ext_ack *extack)
+{
+	u32 srcs;
+	u32 ctrl;
+	u32 val;
+	u32 dst;
+	int res;
+
+	if (ingress)
+		srcs = YT921X_MIRROR_IGR_PORTn(port);
+	else
+		srcs = YT921X_MIRROR_EGR_PORTn(port);
+	dst = YT921X_MIRROR_PORT(to_local_port);
+
+	res = yt921x_reg_read(priv, YT921X_MIRROR, &val);
+	if (res)
+		return res;
+
+	/* other mirror tasks & different dst port -> conflict */
+	if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
+			    YT921X_MIRROR_IGR_PORTS_M)) &&
+	    (val & YT921X_MIRROR_PORT_M) != dst) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Sniffer port is already configured, delete existing rules & retry");
+		return -EBUSY;
+	}
+
+	ctrl = val & ~YT921X_MIRROR_PORT_M;
+	ctrl |= srcs;
+	ctrl |= dst;
+
+	if (ctrl == val)
+		return 0;
+
+	return yt921x_reg_write(priv, YT921X_MIRROR, ctrl);
+}
+
+void
+yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
+			   struct dsa_mall_mirror_tc_entry *mirror)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_mirror_del(priv, port, mirror->ingress);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "unmirror",
+			port, res);
+}
+
+int
+yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
+			   struct dsa_mall_mirror_tc_entry *mirror,
+			   bool ingress, struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_mirror_add(priv, port, ingress,
+				mirror->to_local_port, extack);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+int yt921x_chip_setup_tc(struct yt921x_priv *priv)
+{
+	unsigned int op_ns;
+	u32 ctrl;
+	int res;
+
+	op_ns = 8 * priv->cycle_ns;
+
+	ctrl = max(priv->meter_slot_ns / op_ns, YT921X_METER_SLOT_MIN);
+	res = yt921x_reg_write(priv, YT921X_METER_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->meter_slot_ns = ctrl * op_ns;
+
+	ctrl = max(priv->port_shape_slot_ns / op_ns,
+		   YT921X_PORT_SHAPE_SLOT_MIN);
+	res = yt921x_reg_write(priv, YT921X_PORT_SHAPE_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->port_shape_slot_ns = ctrl * op_ns;
+
+	return 0;
+}
+
+int yt921x_chip_setup_acl(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = YT921X_ACL_PERMIT_UNMATCH_PORTS_M;
+	res = yt921x_reg_write(priv, YT921X_ACL_PERMIT_UNMATCH, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_ACL_PORT_PORTS_M;
+	res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
new file mode 100644
index 000000000000..32b53f1f3825
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -0,0 +1,380 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_TC_H
+#define _YT_TC_H
+
+#include <net/dsa.h>
+#include <net/pkt_cls.h>
+
+#define YT921X_ACLn_ACT(n)		(0x1c0000 + 0x10 * (n))
+#define  YT921X_ACL_ACTc_STAG_M			GENMASK(26, 25)
+#define   YT921X_ACL_ACTc_STAG(x)			FIELD_PREP(YT921X_ACL_ACTc_STAG_M, (x))
+#define   YT921X_ACL_ACTc_STAG_DONTCARE			YT921X_ACL_ACTc_STAG(0)
+#define   YT921X_ACL_ACTc_STAG_UNTAG			YT921X_ACL_ACTc_STAG(1)
+#define   YT921X_ACL_ACTc_STAG_TAG			YT921X_ACL_ACTc_STAG(2)
+#define   YT921X_ACL_ACTc_STAG_KEEP			YT921X_ACL_ACTc_STAG(3)
+#define  YT921X_ACL_ACTc_CTAG_M			GENMASK(24, 23)
+#define   YT921X_ACL_ACTc_CTAG(x)			FIELD_PREP(YT921X_ACL_ACTc_CTAG_M, (x))
+#define   YT921X_ACL_ACTc_CTAG_DONTCARE			YT921X_ACL_ACTc_CTAG(0)
+#define   YT921X_ACL_ACTc_CTAG_UNTAG			YT921X_ACL_ACTc_CTAG(1)
+#define   YT921X_ACL_ACTc_CTAG_TAG			YT921X_ACL_ACTc_CTAG(2)
+#define   YT921X_ACL_ACTc_CTAG_KEEP			YT921X_ACL_ACTc_CTAG(3)
+#define  YT921X_ACL_ACTc_FWD_M			GENMASK(22, 21)
+#define   YT921X_ACL_ACTc_FWD(x)			FIELD_PREP(YT921X_ACL_ACTc_FWD_M, (x))
+#define   YT921X_ACL_ACTc_FWD_FWD			YT921X_ACL_ACTc_FWD(0)
+#define   YT921X_ACL_ACTc_FWD_COPY			YT921X_ACL_ACTc_FWD(1)
+#define   YT921X_ACL_ACTc_FWD_REDIR			YT921X_ACL_ACTc_FWD(2)
+#define   YT921X_ACL_ACTc_FWD_TRAP			YT921X_ACL_ACTc_FWD(3)
+#define  YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M	GENMASK(20, 10)
+#define   YT921X_ACL_ACTc_FWD_REDIR_DPORTS(x)		FIELD_PREP(YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M, (x))
+#define  YT921X_ACL_ACTc_FWD_REDIR_DPORTn(port)	BIT((port) + 10)
+#define  YT921X_ACL_ACTc_FWD_EN			BIT(9)
+#define  YT921X_ACL_ACTc_SDEI			BIT(8)
+#define  YT921X_ACL_ACTc_SDEI_REPLACE		BIT(7)
+#define  YT921X_ACL_ACTc_SPRI_M			GENMASK(6, 4)
+#define   YT921X_ACL_ACTc_SPRI(x)			FIELD_PREP(YT921X_ACL_ACTc_SPRI_M, (x))
+#define  YT921X_ACL_ACTc_SPRI_REPLACE		BIT(3)
+#define  YT921X_ACL_ACTbc_SVID_M		GENMASK_ULL(34, 23)
+#define   YT921X_ACL_ACTbc_SVID(x)			FIELD_PREP(YT921X_ACL_ACTbc_SVID_M, (x))
+#define  YT921X_ACL_ACTb_SVID_REPLACE		BIT(22)
+#define  YT921X_ACL_ACTb_CDEI			BIT(21)
+#define  YT921X_ACL_ACTb_CDEI_REPLACE		BIT(20)
+#define  YT921X_ACL_ACTb_CPRI_M			GENMASK(19, 17)
+#define   YT921X_ACL_ACTb_CPRI(x)			FIELD_PREP(YT921X_ACL_ACTb_CPRI_M, (x))
+#define  YT921X_ACL_ACTb_CPRI_REPLACE		BIT(16)
+#define  YT921X_ACL_ACTb_CVID_M			GENMASK(15, 4)
+#define   YT921X_ACL_ACTb_CVID(x)			FIELD_PREP(YT921X_ACL_ACTb_CVID_M, (x))
+#define  YT921X_ACL_ACTb_CVID_REPLACE		BIT(3)
+#define  YT921X_ACL_ACTb_PRIO_M			GENMASK(2, 0)
+#define   YT921X_ACL_ACTb_PRIO(x)			FIELD_PREP(YT921X_ACL_ACTb_PRIO_M, (x))
+#define  YT921X_ACL_ACTa_PRIO_EN		BIT(31)
+#define  YT921X_ACL_ACTa_COLOR_M		GENMASK(30, 29)
+#define   YT921X_ACL_ACTa_COLOR(x)			FIELD_PREP(YT921X_ACL_ACTa_COLOR_M, (x))
+#define   YT921X_ACL_ACTa_COLOR_GREEN			YT921X_ACL_ACTa_COLOR(0)
+#define   YT921X_ACL_ACTa_COLOR_YELLOW			YT921X_ACL_ACTa_COLOR(1)
+#define   YT921X_ACL_ACTa_COLOR_RED			YT921X_ACL_ACTa_COLOR(2)
+#define  YT921X_ACL_ACTa_COLOR_EN		BIT(28)
+#define  YT921X_ACL_ACTa_DSCP_M			GENMASK(27, 22)
+#define   YT921X_ACL_ACTa_DSCP(x)			FIELD_PREP(YT921X_ACL_ACTa_DSCP_M, (x))
+#define  YT921X_ACL_ACTa_DSCP_REPLACE		BIT(21)
+#define  YT921X_ACL_ACTa_METER_ID_M		GENMASK(20, 15)
+#define   YT921X_ACL_ACTa_METER_ID(x)			FIELD_PREP(YT921X_ACL_ACTa_METER_ID_M, (x))
+#define  YT921X_ACL_ACTa_METER_EN		BIT(14)
+#define  YT921X_ACL_ACTa_MIRROR_EN		BIT(13)
+#define  YT921X_ACL_ACTa_FLOWSTAT_EN		BIT(12)
+#define  YT921X_ACL_ACTa_FLOWSTAT_ID_M		GENMASK(11, 6)
+#define   YT921X_ACL_ACTa_FLOWSTAT_ID(x)		FIELD_PREP(YT921X_ACL_ACTa_FLOWSTAT_ID_M, (x))
+#define  YT921X_ACL_ACTa_GPIO_EN		BIT(5)
+#define  YT921X_ACL_ACTa_GPIO_PIN_M		GENMASK(4, 1)
+#define   YT921X_ACL_ACTa_GPIO_PIN(x)			FIELD_PREP(YT921X_ACL_ACTa_GPIO_PIN_M, (x))
+#define  YT921X_ACL_ACTa_INTR_EN		BIT(0)
+#define YT921X_ACL_BLK_KEEP		0x201000
+#define  YT921X_ACL_BLK_KEEP_GRPIDn_M(bin)	(7 << (4 * (bin) + 1))
+#define   YT921X_ACL_BLK_KEEP_GRPIDn(bin, x)		((x) << (4 * (bin) + 1))
+#define  YT921X_ACL_BLK_KEEP_KEEPn(bin)		BIT(4 * (bin))
+#define YT921X_ACL_PORT			0x202000
+#define  YT921X_ACL_PORT_PORTS_M		GENMASK(10, 0)
+#define   YT921X_ACL_PORT_PORTS(x)			FIELD_PREP(YT921X_ACL_PORT_PORTS_M, (x))
+#define  YT921X_ACL_PORT_PORTn(port)		BIT(port)
+#define YT921X_ACL_BLK_CMD		0x202004
+#define  YT921X_ACL_BLK_CMD_BLKID_M		GENMASK(6, 1)
+#define   YT921X_ACL_BLK_CMD_BLKID(x)			FIELD_PREP(YT921X_ACL_BLK_CMD_BLKID_M, (x))
+#define  YT921X_ACL_BLK_CMD_MODIFY		BIT(0)
+#define YT921X_ACLn_ENTRY(blk)		(0x203000 + 4 * (blk))
+#define  YT921X_ACL_ENTRY_GRPIDm_M(bin)		(7 << (4 * (bin) + 1))
+#define   YT921X_ACL_ENTRY_GRPIDm(bin, x)		((x) << (4 * (bin) + 1))
+#define  YT921X_ACL_ENTRY_ENm(bin)		BIT(4 * (bin))
+#define YT921X_ACLn_KEYm(blk, bin)	(0x204000 + 0x200 * (bin) + 8 * (blk))
+#define  YT921X_ACL_KEYb_ORD_M			GENMASK(29, 21)
+#define   YT921X_ACL_KEYb_ORD(x)			FIELD_PREP(YT921X_ACL_KEYb_ORD_M, (x))
+#define  YT921X_ACL_KEYb_SPORTS_M		GENMASK(20, 10)
+#define   YT921X_ACL_KEYb_SPORTS(x)			FIELD_PREP(YT921X_ACL_KEYb_SPORTS_M, (x))
+#define  YT921X_ACL_KEYb_SPORTn(port)		BIT((port) + 10)
+#define  YT921X_ACL_KEYb_REVERSE		BIT(9)	/* reverse match */
+#define  YT921X_ACL_KEYb_TYPE_M			GENMASK(8, 4)
+#define   YT921X_ACL_KEYb_TYPE(x)			FIELD_PREP(YT921X_ACL_KEYb_TYPE_M, (x))
+/* KEY_* fields need no masks */
+#define YT921X_ACLn_MASKm(blk, bin)	(0x205000 + 0x200 * (bin) + 8 * (blk))
+
+enum yt921x_acl_type {
+	YT921X_ACL_TYPE_NA,
+	YT921X_ACL_TYPE_MAC_DA0,
+	YT921X_ACL_TYPE_MAC_SA0,
+	YT921X_ACL_TYPE_MAC_DA1_SA1,
+	YT921X_ACL_TYPE_VLAN,
+	YT921X_ACL_TYPE_VTAG,
+	YT921X_ACL_TYPE_IPV4_DA,
+	YT921X_ACL_TYPE_IPV4_SA,
+	YT921X_ACL_TYPE_IPV6_DA0,
+	YT921X_ACL_TYPE_IPV6_DA1,
+	YT921X_ACL_TYPE_IPV6_DA2,
+	YT921X_ACL_TYPE_IPV6_DA3,
+	YT921X_ACL_TYPE_IPV6_SA0,
+	YT921X_ACL_TYPE_IPV6_SA1,
+	YT921X_ACL_TYPE_IPV6_SA2,
+	YT921X_ACL_TYPE_IPV6_SA3,
+	YT921X_ACL_TYPE_MISC,
+	YT921X_ACL_TYPE_L4,
+	YT921X_ACL_TYPE_UDF0,
+	YT921X_ACL_TYPE_UDF1,
+	YT921X_ACL_TYPE_UDF2,
+	YT921X_ACL_TYPE_UDF3,
+	YT921X_ACL_TYPE_UDF4,
+	YT921X_ACL_TYPE_UDF5,
+	YT921X_ACL_TYPE_UDF6,
+	YT921X_ACL_TYPE_UDF7,
+	YT921X_ACL_TYPE_ETHERTYPE,
+	YT921X_ACL_TYPE_NUM
+};
+
+/* Range: turn KEY:MASK into MIN:MAX */
+
+#define  YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M	GENMASK(3, 0)
+#define   YT921X_ACL_BINb_MAC_xA0_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MAC_xA0_MAC_xA0_M	GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M	GENMASK(2, 0)
+#define   YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE(x)	FIELD_PREP(YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_DA1_M	GENMASK(31, 16)
+#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_SA1_M	GENMASK(15, 0)
+
+#define  YT921X_ACL_KEYb_VLAN_SVID_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_VLAN_CVID_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_VLAN_CDEI		BIT(3)
+#define  YT921X_ACL_BINb_VLAN_CPRI_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_VLAN_CPRI(x)			FIELD_PREP(YT921X_ACL_BINb_VLAN_CPRI_M, (x))
+#define  YT921X_ACL_BINa_VLAN_CTAG_FMT_M	GENMASK(31, 30)
+#define   YT921X_ACL_BINa_VLAN_CTAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_CTAG_FMT_M, (x))
+#define  YT921X_ACL_BINa_VLAN_SDEI		BIT(29)
+#define  YT921X_ACL_BINa_VLAN_SPRI_M		GENMASK(28, 26)
+#define   YT921X_ACL_BINa_VLAN_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SPRI_M, (x))
+#define  YT921X_ACL_BINa_VLAN_STAG_FMT_M	GENMASK(25, 24)
+#define   YT921X_ACL_BINa_VLAN_STAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_STAG_FMT_M, (x))
+#define  YT921X_ACL_BINa_VLAN_SVID_M		GENMASK(23, 12)
+#define   YT921X_ACL_BINa_VLAN_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SVID_M, (x))
+#define  YT921X_ACL_BINa_VLAN_CVID_M		GENMASK(11, 0)
+#define   YT921X_ACL_BINa_VLAN_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_CVID_M, (x))
+
+#define  YT921X_ACL_KEYb_VTAG_SVID_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_VTAG_CVID_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINa_VTAG_CDEI		BIT(31)
+#define  YT921X_ACL_BINa_VTAG_CPRI_M		GENMASK(30, 28)
+#define   YT921X_ACL_BINa_VTAG_CPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CPRI_M, (x))
+#define  YT921X_ACL_BINa_VTAG_SDEI		BIT(27)
+#define  YT921X_ACL_BINa_VTAG_SPRI_M		GENMASK(26, 24)
+#define   YT921X_ACL_BINa_VTAG_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SPRI_M, (x))
+#define  YT921X_ACL_BINa_VTAG_SVID_M		GENMASK(23, 12)
+#define   YT921X_ACL_BINa_VTAG_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SVID_M, (x))
+#define  YT921X_ACL_BINa_VTAG_CVID_M		GENMASK(11, 0)
+#define   YT921X_ACL_BINa_VTAG_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CVID_M, (x))
+
+#define  YT921X_ACL_KEYb_IPV4_ADDR_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_IPV4_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_IPV4_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_IPV4_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV4_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_IPV4_ADDR_M		GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_IPV6_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_IPV6_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV6_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_IPV6_ADDRx_M		GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_IPV6_xA1_IP_OPTION	BIT(3)
+
+#define  YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG	BIT(3)
+
+#define  YT921X_ACL_KEYb_IPV6_xA3_ADDR_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_IPV6_xA3_FRAG		BIT(3)
+
+#define  YT921X_ACL_BINb_MISC_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_MISC_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_MISC_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MISC_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MISC_PPPOE_FLAG	BIT(30)
+#define  YT921X_ACL_BINa_MISC_FIRST_FRAG	BIT(29)
+#define  YT921X_ACL_BINa_MISC_IP_OPTION		BIT(28)
+#define  YT921X_ACL_BINa_MISC_TCP_FLAGS_M	GENMASK(27, 20)
+#define   YT921X_ACL_BINa_MISC_TCP_FLAGS(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_TCP_FLAGS_M, (x))
+#define  YT921X_ACL_BINa_MISC_IP_PROTO_M	GENMASK(19, 12)
+#define   YT921X_ACL_BINa_MISC_IP_PROTO(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_IP_PROTO_M, (x))
+#define  YT921X_ACL_BINa_MISC_TOS_M		GENMASK(11, 4)
+#define   YT921X_ACL_BINa_MISC_TOS(x)			FIELD_PREP(YT921X_ACL_BINa_MISC_TOS_M, (x))
+#define  YT921X_ACL_BINa_MISC_L3_TYPE_M		GENMASK(3, 0)
+#define   YT921X_ACL_BINa_MISC_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_L3_TYPE_M, (x))
+
+#define  YT921X_ACL_KEYb_L4_DPORT_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_L4_SPORT_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_L4_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_L4_TYPE(x)			FIELD_PREP(YT921X_ACL_BINb_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_L4_DPORT_M		GENMASK(31, 16)
+#define  YT921X_ACL_BINa_L4_SPORT_M		GENMASK(15, 0)
+
+#define  YT921X_ACL_BINb_UDF_IS_IGMP		BIT(0)
+#define  YT921X_ACL_BINa_UDF_UDF0_M		GENMASK(31, 16)
+#define   YT921X_ACL_BINa_UDF_UDF0(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF0_M, (x))
+#define  YT921X_ACL_BINa_UDF_UDF1_M		GENMASK(15, 0)
+#define   YT921X_ACL_BINa_UDF_UDF1(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF1_M, (x))
+
+#define  YT921X_ACL_KEYb_ETHERTYPE_ETHERTYPE_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M	GENMASK(2, 0)
+#define   YT921X_ACL_BINb_ETHERTYPE_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M	GENMASK(15, 0)
+#define   YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE(x)	FIELD_PREP(YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M, (x))
+
+enum yt921x_l2_type {
+	YT921X_L2_TYPE_ETH,
+	YT921X_L2_TYPE_ETHV2,
+	YT921X_L2_TYPE_ETHSAP,
+	YT921X_L2_TYPE_ETHSNAP,
+};
+
+enum yt921x_l3_type {
+	YT921X_L3_TYPE_OTHER,
+	YT921X_L3_TYPE_IPV4,
+	YT921X_L3_TYPE_IPV6,
+	YT921X_L3_TYPE_ARP,
+	YT921X_L3_TYPE_LLDP,
+	YT921X_L3_TYPE_PAE,
+	YT921X_L3_TYPE_ERP,
+	YT921X_L3_TYPE_SLOW_PROTOCOL,
+};
+
+enum yt921x_l4_type {
+	YT921X_L4_TYPE_OTHER,
+	YT921X_L4_TYPE_TCP,
+	YT921X_L4_TYPE_UDP,
+	YT921X_L4_TYPE_UDPLITE,
+	YT921X_L4_TYPE_ICMP,
+	YT921X_L4_TYPE_IGMP,
+	YT921X_L4_TYPE_MLD,
+	YT921X_L4_TYPE_ND,
+};
+
+#define YT921X_UDFn_CTRL(x)		(0x210094 + 4 * (x))
+#define  YT921X_UDF_CTRL_UDF_TYPE_M		GENMASK(8, 7)
+#define   YT921X_UDF_CTRL_UDF_TYPE(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_TYPE_M, (x))
+#define   YT921X_UDF_CTRL_UDF_TYPE_ETH			YT921X_UDF_CTRL_UDF_TYPE(0)
+#define   YT921X_UDF_CTRL_UDF_TYPE_L3			YT921X_UDF_CTRL_UDF_TYPE(1)
+#define   YT921X_UDF_CTRL_UDF_TYPE_L4			YT921X_UDF_CTRL_UDF_TYPE(2)
+#define  YT921X_UDF_CTRL_UDF_OFFSET_M		GENMASK(6, 0)
+#define   YT921X_UDF_CTRL_UDF_OFFSET(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_OFFSET_M, (x))
+
+#define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
+#define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
+#define YT921X_METER_SLOT		0x220104
+#define  YT921X_METER_SLOT_SLOT_M		GENMASK(11, 0)
+#define YT921X_PORTn_METER(port)	(0x220108 + 4 * (port))
+#define  YT921X_PORT_METER_EN			BIT(4)
+#define  YT921X_PORT_METER_ID_M			GENMASK(3, 0)
+#define   YT921X_PORT_METER_ID(x)			FIELD_PREP(YT921X_PORT_METER_ID_M, (x))
+#define YT921X_METERn_CTRL(x)		(0x220800 + 0x10 * (x))
+#define  YT921X_METER_CTRLc_METER_EN		BIT(14)
+#define  YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN	BIT(13)	/* RFC4115: yellow use unused green bw */
+#define  YT921X_METER_CTRLc_DROP_M		GENMASK(12, 11)
+#define   YT921X_METER_CTRLc_DROP(x)			FIELD_PREP(YT921X_METER_CTRLc_DROP_M, (x))
+#define   YT921X_METER_CTRLc_DROP_GYR			YT921X_METER_CTRLc_DROP(0)
+#define   YT921X_METER_CTRLc_DROP_YR			YT921X_METER_CTRLc_DROP(1)
+#define   YT921X_METER_CTRLc_DROP_R			YT921X_METER_CTRLc_DROP(2)
+#define   YT921X_METER_CTRLc_DROP_NONE			YT921X_METER_CTRLc_DROP(3)
+#define  YT921X_METER_CTRLc_COLOR_BLIND		BIT(10)
+#define  YT921X_METER_CTRLc_UNIT_M		GENMASK(9, 7)
+#define   YT921X_METER_CTRLc_UNIT(x)			FIELD_PREP(YT921X_METER_CTRLc_UNIT_M, (x))
+#define  YT921X_METER_CTRLc_BYTE_MODE_INCLUDE_GAP	BIT(6)	/* +GAP_VALUE bytes each packet */
+#define  YT921X_METER_CTRLc_PKT_MODE		BIT(5)	/* 0: byte rate mode */
+#define  YT921X_METER_CTRLc_RFC2698		BIT(4)	/* 0: RFC4115 */
+#define  YT921X_METER_CTRLbc_CBS_M		GENMASK_ULL(35, 20)
+#define   YT921X_METER_CTRLbc_CBS(x)			FIELD_PREP(YT921X_METER_CTRLbc_CBS_M, (x))
+#define  YT921X_METER_CTRLb_CIR_M		GENMASK(19, 2)
+#define   YT921X_METER_CTRLb_CIR(x)			FIELD_PREP(YT921X_METER_CTRLb_CIR_M, (x))
+#define  YT921X_METER_CTRLab_EBS_M		GENMASK_ULL(33, 18)
+#define   YT921X_METER_CTRLab_EBS(x)			FIELD_PREP(YT921X_METER_CTRLab_EBS_M, (x))
+#define  YT921X_METER_CTRLa_EIR_M		GENMASK(17, 0)
+#define   YT921X_METER_CTRLa_EIR(x)			FIELD_PREP(YT921X_METER_CTRLa_EIR_M, (x))
+#define YT921X_METERn_STAT(x)		(0x221000 + 8 * (x))
+
+#define YT921X_MIRROR			0x300300
+#define  YT921X_MIRROR_IGR_PORTS_M		GENMASK(26, 16)
+#define   YT921X_MIRROR_IGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_IGR_PORTS_M, (x))
+#define  YT921X_MIRROR_IGR_PORTn(port)		BIT((port) + 16)
+#define  YT921X_MIRROR_EGR_PORTS_M		GENMASK(14, 4)
+#define   YT921X_MIRROR_EGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_EGR_PORTS_M, (x))
+#define  YT921X_MIRROR_EGR_PORTn(port)		BIT((port) + 4)
+#define  YT921X_MIRROR_PORT_M			GENMASK(3, 0)
+#define   YT921X_MIRROR_PORT(x)				FIELD_PREP(YT921X_MIRROR_PORT_M, (x))
+
+#define YT921X_PORT_SHAPE_SLOT		0x34000c
+#define  YT921X_PORT_SHAPE_SLOT_SLOT_M		GENMASK(11, 0)
+#define YT921X_PORTn_SHAPE_CTRL(port)	(0x354000 + 8 * (port))
+#define  YT921X_PORT_SHAPE_CTRLb_EN		BIT(4)
+#define  YT921X_PORT_SHAPE_CTRLb_PKT_MODE	BIT(3)	/* 0: byte rate mode */
+#define  YT921X_PORT_SHAPE_CTRLb_UNIT_M		GENMASK(2, 0)
+#define   YT921X_PORT_SHAPE_CTRLb_UNIT(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLb_UNIT_M, (x))
+#define  YT921X_PORT_SHAPE_CTRLa_CBS_M		GENMASK(31, 18)
+#define   YT921X_PORT_SHAPE_CTRLa_CBS(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CBS_M, (x))
+#define  YT921X_PORT_SHAPE_CTRLa_CIR_M		GENMASK(17, 0)
+#define   YT921X_PORT_SHAPE_CTRLa_CIR(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CIR_M, (x))
+#define YT921X_PORTn_SHAPE_STAT(port)	(0x356000 + 4 * (port))
+
+#define YT921X_TOKEN_BYTE_C	1	/* 1 token = 2^1 byte */
+#define YT921X_TOKEN_PKT_C	-6	/* 1 token = 2^-6 packets */
+#define YT921X_TOKEN_RATE_C	-15
+#define YT921X_METER_SLOT_MIN	80
+#define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_METER_CIR_MAX	((1 << 18) - 1)
+#define YT921X_METER_CBS_MAX	((1 << 16) - 1)
+#define YT921X_PORT_SHAPE_SLOT_MIN	80
+#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
+#define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
+
+#define YT921X_ACL_ENT_PER_BLK	8
+#define YT921X_ACL_NUM		384
+
+struct yt921x_acl_entry {
+	u32 key[2];
+	u32 mask[2];
+};
+
+struct yt921x_acl_rule {
+	unsigned long tag;
+	enum tc_setup_type type;
+
+	u32 action[3];
+	bool sw_assisted;
+
+	u8 mask;
+	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
+};
+
+struct yt921x_acl_blk {
+	struct yt921x_acl_rule *rules[YT921X_ACL_ENT_PER_BLK];
+};
+
+void yt921x_dsa_port_policer_del(struct dsa_switch *ds, int port);
+int
+yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
+			    const struct flow_action_police *police,
+			    struct netlink_ext_ack *extack);
+int
+yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
+			 enum tc_setup_type type, void *type_data);
+int
+yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress);
+int
+yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress);
+void
+yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
+			   struct dsa_mall_mirror_tc_entry *mirror);
+int
+yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
+			   struct dsa_mall_mirror_tc_entry *mirror,
+			   bool ingress, struct netlink_ext_ack *extack);
+
+int yt921x_chip_setup_tc(struct yt921x_priv *priv);
+int yt921x_chip_setup_acl(struct yt921x_priv *priv);
+
+#endif
-- 
2.53.0

