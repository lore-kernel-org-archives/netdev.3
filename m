Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282643;
	b=WTfCNspEyvcN2rU01PoYWZWgFDlE+DCnjpwJBDK276SO1cYmBOpcCBrNakVfdr4kwWm/
	 ENFnS9yQ0ujmk40JpMARiSrr5TQAyU22iZ6XYx+k0NPjCN7qZRT7a/dIG7jR0ca6Yew8U
	 2NSkj39pnWwZPwXIhkvJYUlhklg1EToDGU7xC0qJBr/B20DV8oQWcdyUQBANRYiQmTSZB
	 KxAtLMXt3b9u8d9UClCFuh4IF/jWCvYyILoTZTZquibyAbRDvuQE5K/il1hptJxO17m1V
	 PdrWk0aJ1s9V4BXuXeNTLMNdHx5FltnNvtlTIwN11IloTMzPmEnNApC9NzHD0WXBeTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282643;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=kvy1oROhGxytQvDnk0PwhBHRT1/OW69RQXLRvUpt4JI=;
	b=mF11EyDWXnycTOE+N5ksuGM32mBl8ubkGGeTEkwyfNSFAMC8Ymr4WXffGOuN47fLg1+W
	 4hwo7PGu49ZdHLuktlA0dAMqJ8EBxbf7CKrDAi7ASyEiGdyNn3wNfcZK+IZtF3sqOcCn3
	 TTFW3RtA6R/8FBvPPTSZd8G7a/H/HLk8+aW3FA5MCXEjKefXH+JfKPg0+Qw3CujBtWz6h
	 cFMjVW/ID4lw9mfwonyJtCA9Y2PgWcK3VqC+FBodEzeIwaca+r/KKmDhPk72l707gUge2
	 tlwWYjh5HEN4OpzZ4QwOxYm9UC2GYfQuSco1cTzn8Dw0IOIPWZlOyZUkx7LGSMWEWzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hn69WChe;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B660A5BC9
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B52B660A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hn69WChe
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1028023a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282642; x=1794887442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvy1oROhGxytQvDnk0PwhBHRT1/OW69RQXLRvUpt4JI=;
        b=i33fHDvfmUQm7xgN7IOUCP4LZOeK8oWpGXvBoNHhO8PaSYtOXucW20XJSrSIFAbW0P
         ayycOwyGc6Ui+pyU2fAQS1TEOPCL8sUBXAZPcFmiYMwuBG4iwkPu5gwEyJoVvU+5KSOx
         npPBK2LqSQ3VDw19GyjvVp/oH4NosQG2zZ3Iq4eCFGA4BHj4eMQGY5+8D7acMqPp7VAq
         sRSecdDk4H/g/OFPtvvtf8nMH2lB2dX7AqiEfBgjBIMHIgMxKPoopWMEc+znhv9IZmHk
         rd2hhvoU2A1YUqmV0pLChyal3YZhLRjb9oy+LgC4Y/Maj7S6b2Ve/uzcst7vJD0zGeZH
         Tmcg==
X-Gm-Message-State: APuU4Z9WvXquGuBASPZZUm+/kPK+jlDQWaoJOwAk7txBzsVRPhQzFpip
	ote6hrjq/fBCKBteqIykhEYbSe0CNTt4H+r6kUPBRkmnNsGaFzfqUVcAsUzKta4Gi68YrLLRK4h
	YyveIRJmW/4eCcTXrzHX3T7vrDUGF9OSdIGoP3G4sXKW4TRf1rCzyZBgdDtDXQf6D/zifAqMpSE
	TJAblKoE0Mxlqr9463TG4n5Fhg8XCc5G7bX6knQFV3vnZxrMxN8DENJQ+8hJI9SjmYsLsQAwYQ0
	zi3voMfyJAVmxQV
X-Gm-Gg: AYBFou1Zn8ly3tZLJFJxFrkPHpIsZNRnt+P6H+A5NYRt1gTOcGAhjgKWg+ltsoWEikw
	TI3VmdfWeCfzOl96XMw5yXYC8jnG1Xx0jD9Wp7ktQJGwZaQ/LJH+iaTgy52jxlux0kkuAB8DPDc
	cilC4T3LK7pv9/zPVcEVbxg5X3TVD5OXEltL4GW/YGDxvyEIOijng7H5rmSRG6XsgMX0/bVfO0F
	pe7UiKCTGnfuRSjsur04lvCFrEvH4mL1mJmyvgKiYNgrQrGDGh870S3UYOpooLfUs4T+8bkNeGA
	HfMn1CPjLG7T8rS0HlBQfB9TkT+e3B0ZSlMcB19OULxOG2xiXdDzHmzjRyPL9CSI/tdTzvNI9B9
	xdWgo/2RyUakHLdwFPIgLJgxaArN3QP7HGXEleNQObv6RJBEOeDxVxJPklb1PzqoVapdMZyWByK
	TFRSu2afmjPCAPnKhdaUQkjtdL42p9GHeB7JlpOz46
X-Received: by 2002:a17:90a:d647:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3b166ac9df2mr1702924a91.6.1794282641548;
        Mon, 09 Nov 2026 19:50:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b168ada5d1sm383565a91.0.2026.11.09.19.50.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5364605e74bso44118941cf.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282639; x=1794887439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvy1oROhGxytQvDnk0PwhBHRT1/OW69RQXLRvUpt4JI=;
        b=hn69WCheS/+Ebqyt0I2xSH8KkWYWozffeG95BJPuaUh8dWE74/FErM3SUEWFJ1cMfT
         bkdWOaTWqKCDjt+Ay9SyWUT5S004FLHkp47BrEMaNdehz2zzje130kum9b/J99z2zd18
         MN9YgBN+F2W7W1ExqQAmCzjJsQ5T23W7cFVU4=
X-Received: by 2002:a05:622a:5c06:b0:536:72b4:b84a with SMTP id d75a77b69052e-555287de783mr22560571cf.42.1794282639565;
        Mon, 09 Nov 2026 19:50:39 -0800 (PST)
X-Received: by 2002:a05:622a:5c06:b0:536:72b4:b84a with SMTP id d75a77b69052e-555287de783mr22560381cf.42.1794282639093;
        Mon, 09 Nov 2026 19:50:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:38 -0800 (PST)
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
Subject: [PATCH net v4 6/8] net: dsa: b53: reference count shared mirror source bits
Date: Mon,  9 Nov 2026 19:50:16 -0800
Message-ID: <20261110035018.2169370-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
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
 drivers/net/dsa/b53/b53_priv.h   |  3 ++
 drivers/net/dsa/bcm_sf2.c        |  6 ++--
 3 files changed, 68 insertions(+), 2 deletions(-)

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
index c4d2a41c714f..d55fba9bcb1d 100644
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

