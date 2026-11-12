Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506639;
	b=HkmPqMmCHyTcLbF/W2itKsrcfLzhbxiRmVhP1BZRLS9cmYnMejDEU3C+SbDQKRfxSNMB
	 VZ34rlT/Mtcq8nxhN0MtP6/Y6+aDlmlzzh15U1Ym/2GUdBtah1bG5D/lDEfzTnHcF0PId
	 ygU5SULdEYWz2U1hMBQgdd0OxB+5aQJKu7mZ/PK7cWOiNLZQ/GKUtogvE6+SFg6qcrNit
	 /LE60bqEwcLNBt4386k/0wDsfC6FZNlCzjs/BT+ZXLyNJaTPpQ3BQ9DalnTRr9SBaGarA
	 Rexzaxu3q3slzdt9T8CgX0JpXXLPAvUEMtokvcktXpeeHhUX9bl4ERK4OIOxtkbwjgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506639;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Ajk6da4fFo8BLmAPTr1Lm266LYSOfPr/a6DbHRqN51U=;
	b=hbeZ1zGvQNyT97/XEFWCwgxBC+EYwXaSnTRJ6w87v3rZKO/4uLrWcymau52beIBWXyAz
	 ohgamj/2qdfZ/W/06CK2WyW6g8OWwb2JsEaM2Zww8SbNDeyBcEn/FBBWyn39HciJo26ih
	 zDOAWcC4yn0x0L5YfBdxoa7Mma5EzyxfQZIjFlPQSv4dZQkXyvSUw3yAttzBpf8qUaog3
	 fCPzFLu1Wy2Xxl9LtqHrRJIZmDtABkLiaKyntS4dMFEMjWwxmX3s5ojXDOlwKciAQkpam
	 y8j9tFSmdCSJE0C1zXj1o5eO2lvZ72Y5cHehcSUOcVFH8eXe+l9s8KIfj+IpQhHb/ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Uby4QPHU;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A860A3814
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731A860A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Uby4QPHU
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93f20b304c0so89785a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506638; x=1795111438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ajk6da4fFo8BLmAPTr1Lm266LYSOfPr/a6DbHRqN51U=;
        b=Vdr+jj9bc0ik7d6pkzFNQE/jDVmrRCw5tgtHCu7uO8euW0zNg6HK3rHw0FCVr3vmrL
         zpPFsD5Tv80hUoDtYGKs58QfkaFYC7Y7X228fxi9sakPYMf/269A2oATeFqVCj8jcnGG
         bt7vqDDn4tHnSf20qBStU+UEx6dV65PLcAF3XAkFKyxAekbqh6ioYm0tq0j0rLKGJ8Bj
         +iGbt2A41U5K8C3O1xW4ZtmnVPn8eHivY0m++t4tE4000jEEdNMFDh4p6oMoWLFcRN/f
         it4OoECv7FOgt5Vpv61LnppudRkL/kehf3Stqenv0BYbAVvM8FSD0E1r/C4FLHGrAHiL
         LFYA==
X-Gm-Message-State: APuU4Z8ulchL9O2l1goELU7ms5UVE/lJ+dT+N/eprnJ1YSNmU0NT7Wgv
	2zXd0uNESB0F0ig5sLNPEar75LihqbOh8+W49xpoC4Td4S7COBdDB3tsAGRWErWtWbz8X+CM1Oh
	778aAqeGN0Kj5bo+0/3adPTk1ki9fnEyFYoMaFfJ+hK7LVCSMX6jtCl27byakhxPL0HRlYNDoCp
	0AQWvcOQPV8Xzd8M+B7pU1F5Z0bjhQiUTOM4VTth/x7XO/LDcITou+R2DLUjjFRwqsrxOCmQdku
	ICCi6j22CsRgfbE
X-Gm-Gg: AYBFou1jF9dkah+NvpzkMhhfCRJxrTvagCpHPP/81yE/QCPwPjh0EKI6rHLNFEyrzLf
	GcPPluyKrXDrv/5IL8OJY4Rro3jGD9X8MbStgFdHzxvEWmzNsh4phZJqfy53b1Z5Fex5OAHGU/q
	A++pAZS+UkpvOSEtDBvqbugv4/QI/EKgobMIBaUf4UtgYqCeETowgYP2EDHAfkYuOLaQkP/U0Dv
	fkNN5Vr7c2lTGyCRsGkTk9N2BKYMAuWKKKIA9guqneZPlNvpF1HTWIhozZvkOFzMq5I05dMqhb/
	erEeDLCpFLzYg65vK5XHo+zot6OoVc+EPAfHU0lH58IXJVBB9KDeez850v4NFXpf37NplFz84VX
	akAfPHoeWO8X7+/6PjpQbUYiRY1u+O6sUxphZiaMDFlyOdKZslM9YzxDImCB2gZeRz72a42kURW
	cdhDsm3CgB2DthA3pGE7EVkarqhssfMT12EPkDyT66
X-Received: by 2002:a05:620a:6f01:b0:93e:653e:6981 with SMTP id af79cd13be357-9494ba5556bmr31784585a.11.1794506638334;
        Thu, 12 Nov 2026 10:03:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479f0221a7sm118906385a.19.2026.11.12.10.03.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b7614e9762so46617b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506637; x=1795111437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ajk6da4fFo8BLmAPTr1Lm266LYSOfPr/a6DbHRqN51U=;
        b=Uby4QPHU3CYUNyB/Gc/laRVFEk2SbKtVhr5X9quADN5M842OQZuSOZN9x/JgORoq+t
         xN+PdRTW8xrqowYLH0Gt/nMxAS2TfKs3gyTCBnNr1W9sH/a4pwDfUrXUXsAQWezHFVhg
         1Eg1KR0IpdWoKoj7m49dFMm9beRYLxxfk7AqQ=
X-Received: by 2002:a05:6a20:a10e:b0:3eb:aeb4:2c39 with SMTP id adf61e73a8af0-3f7a6cad582mr5419637.17.1794506636831;
        Thu, 12 Nov 2026 10:03:56 -0800 (PST)
X-Received: by 2002:a05:6a20:a10e:b0:3eb:aeb4:2c39 with SMTP id adf61e73a8af0-3f7a6cad582mr5371637.17.1794506636108;
        Thu, 12 Nov 2026 10:03:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:55 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v5 6/8] net: dsa: b53: reference count shared mirror source bits
Date: Thu, 12 Nov 2026 10:02:00 -0800
Message-ID: <20261112180202.324504-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112180202.324504-1-florian.fainelli@broadcom.com>
References: <20261112180202.324504-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Multiple tc matchall filters can use the same source port, direction and
capture destination, but the hardware represents that source with one
mask bit. Removing any one filter currently clears the bit even when
another filter still needs it, and can also disable mirroring globally.

Track references to each port's ingress and egress source bits. Program
a bit for the first reference and retain it until the last reference is
removed. Keep the two directions independent and ignore a deletion with
no matching reference to avoid underflow. The tc callbacks serialize this
accounting under RTNL.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 61 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_priv.h   |  4 +++
 drivers/net/dsa/bcm_sf2.c        |  6 ++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 6b4a94a97d66..7f5bae290eaa 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2604,11 +2604,56 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_get_tag_protocol);
 
+int b53_mirror_init(struct dsa_switch *ds)
+{
+	struct b53_device *dev = ds->priv;
+	u16 ingress = 0, egress = 0, cap_ctl = 0;
+	unsigned int port;
+	int ret;
+
+	/* A switch reset may leave the previous mirror configuration intact. */
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, 0);
+	if (ret)
+		return ret;
+
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_IG_MIR_CTL, 0);
+	if (ret)
+		return ret;
+
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_EG_MIR_CTL, 0);
+	if (ret)
+		return ret;
+
+	/* DSA retains matchall filters across suspend and resume. */
+	for (port = 0; port < dev->num_ports; port++) {
+		if (dev->ports[port].mirror_count[true])
+			ingress |= BIT(port);
+		if (dev->ports[port].mirror_count[false])
+			egress |= BIT(port);
+	}
+
+	if (!(ingress | egress))
+		return 0;
+
+	cap_ctl = MIRROR_EN | dev->mirror_port;
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
+	if (ret)
+		return ret;
+
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_IG_MIR_CTL, ingress);
+	if (ret)
+		return ret;
+
+	return b53_write16(dev, B53_MGMT_PAGE, B53_EG_MIR_CTL, egress);
+}
+EXPORT_SYMBOL(b53_mirror_init);
+
 int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct dsa_mall_mirror_tc_entry *mirror, bool ingress,
 		   struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
+	unsigned int *mirror_count = &dev->ports[port].mirror_count[ingress];
 	u16 reg, loc, cap_ctl;
 	int ret;
 
@@ -2623,6 +2668,11 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 	}
 
+	if (*mirror_count) {
+		(*mirror_count)++;
+		return 0;
+	}
+
 	if (ingress)
 		loc = B53_IG_MIR_CTL;
 	else
@@ -2637,6 +2687,9 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	cap_ctl |= MIRROR_EN;
 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
 
+	(*mirror_count)++;
+	dev->mirror_port = mirror->to_local_port;
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_mirror_add);
@@ -2645,9 +2698,17 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 		    struct dsa_mall_mirror_tc_entry *mirror)
 {
 	struct b53_device *dev = ds->priv;
+	unsigned int *mirror_count =
+		&dev->ports[port].mirror_count[mirror->ingress];
 	bool loc_disable = false, other_loc_disable = false;
 	u16 reg, loc;
 
+	if (!*mirror_count)
+		return;
+
+	if (--(*mirror_count))
+		return;
+
 	if (mirror->ingress)
 		loc = B53_IG_MIR_CTL;
 	else
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index c4d2a41c714f..df00a5ae46c9 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -119,6 +119,8 @@ struct b53_pcs {
 #define B53_N_PCS	2
 
 struct b53_port {
+	/* References to each egress/ingress mirror source mask bit. */
+	unsigned int mirror_count[2];
 	u16		vlan_ctl_mask;
 	u16		pvid;
 	struct ethtool_keee eee;
@@ -170,6 +172,7 @@ struct b53_device {
 
 	/* run time configuration */
 	bool enable_jumbo;
+	unsigned int mirror_port;
 
 	unsigned int num_vlans;
 	struct b53_vlan *vlans;
@@ -545,6 +548,7 @@ int b53_mdb_add(struct dsa_switch *ds, int port,
 int b53_mdb_del(struct dsa_switch *ds, int port,
 		const struct switchdev_obj_port_mdb *mdb,
 		struct dsa_db db);
+int b53_mirror_init(struct dsa_switch *ds);
 int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct dsa_mall_mirror_tc_entry *mirror, bool ingress,
 		   struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 1c846f6d7802..6570279cc040 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -996,9 +996,11 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
-	ds->ops->setup(ds);
+	ret = ds->ops->setup(ds);
+	if (ret && !priv->wol_ports_mask)
+		clk_disable_unprepare(priv->clk);
 
-	return 0;
+	return ret;
 }
 
 static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
-- 
2.53.0

