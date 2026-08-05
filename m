Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C63E3C4F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914861; cv=none; b=eK/ncmJx41MqWiK7vIgB+yr8pD+7CzK9bZE9Xjn8cZRiWKq3goBX/maNncF2luQYQrQ+3t0+iVpN1D6vPbVFwGraVgO6h/9A7zano7v3+kqGWRpJtNVBHmxT5iWSN5ZKw7wBj1jsbkxpuqdih/FBJMmg/F5I2jOKu9XhgDm/+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914861; c=relaxed/simple;
	bh=8/mrO32EbTkmK1xI73MeuqWdTLB1c894bz9CQ9cXQGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oq7BXbmYeB7nGIoiD2lFNn4K9CPud3yoIl81k1fFyTtxvn7fNl12kBYjUEecfqC5rY+KewCCkP0dGmxttJbGzkmQ0b7ky39PBJoVhClYabpSX0EdOnmX53PmAzqlc4R9kv0q6AoQ8gJ8MAqeN6z8F6yfmzOsPLJufcvx7WZI5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leWyQtVv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leWyQtVv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f6609c657so282687f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914858; x=1786519658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QV4CuF3cSkbZ2yqrarjSB5TBYdXOtQHnfrJj1HMl9k0=;
        b=leWyQtVvSfo3lnuPEKvpXa18k/vNnCbdl2feLqwMwrdssrBgvoJtdeVLcBD/aH1w08
         eaGPLnxqPAA0aSfEYEwqwV6up4ZfFxK6g3B5JoB1+GDV9cA0WKgDnth8c7GThi8euEN1
         PAPHwlIUkHmh9iDNq+EJ1cvgclMksHbYVDjAu0Lt26VIIisrl9/SKlCUp3OJ3ToTFnsZ
         E198UNd8XO4kC4luyTBQZK1GjQeB3hbLKc1LUI93Yae00DiK+95hAg/+qmJL9/mrecFz
         q99m1fvQL8bxjY5GuVC/1BvW2AmiS1jLWHv3Usnc1fZQGxSEBfZiK1a6NxvWPloUP4T1
         2hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914858; x=1786519658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QV4CuF3cSkbZ2yqrarjSB5TBYdXOtQHnfrJj1HMl9k0=;
        b=n745VhQFGgjoXMrP5px76p9B6qbaYsZroB++fmuyUveDcuiFBwlD/AHKaE/fixTkBa
         ClXPYZ4qnkPkqLtpDFhA7GjvEgGBPJ71FmEGej1UabceyEe8BMC3jrRgyNnNuvYDpi8j
         48TK9tSCRNLltj7y+d8hkLkHxvFReBokmJdr0qSgqvKKL19Jqz88lBetGY7Njaj4tN05
         9xCgbOX+FTOnWmSSeFgWYym+TjJ6iwdBgZ61DvTsXILjZ63C+H3FL7/8rsP0Ln/1V8yL
         RoulECK7+Q2+vlcYN7iCvPbYrIoUEfGmYoEBa1dOulO6/Jw2LYvtpc/QACIwvHnNBK5q
         p4hw==
X-Forwarded-Encrypted: i=1; AHgh+RoVY9xPLWxzcI1HT59QxOrK1oevNS0Wpq2OXvfWOhIPQeXDPfpJ5MUov4kDttO2HsYHTluWoKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5gEysaLxFSlwbGbRDqSNdTsxcK3LwZQzMe41K/TMWA8KfvPp
	sNN7QjDJCN2j0RzPaQ3evTBKoEXjZ725r/HAWNNzacKnhyINZwtoteDa
X-Gm-Gg: AR+sD12T2hUOT93nDkBn93ieihr6IE81EkDxuNi7IZ12d53qVaxQTHXifveIPNCYgpG
	t2iGpnkpBbFnGBZKHtC/oSQZ5p0xtwjCKcZwNRxXb7JtA2UO4iqVBykUkvh2JbEoEVzK14qizDK
	/ua4btXyc9j+YxCXicyKSQj7V4TaN1wxV2jIEaYCJHjtocgu+MPhlk2T2stsW2PgflQFfm3Mba5
	QGBmZw6cOvkCurZEjhOaYCWg36jyYCI+JGGX2aQRguqqv2yillFum6eKcPVGich4zjDb0qylEXR
	JAc0TM3/igqPKkmzfw35AWukdlhAykzyiZ9lTb89k/d4hO19W0iAAu40fAI0jfMlGFiXefDgrXd
	BHmRk+uJ1FWREj6Lk5BqKrk0hM6ZkHsSE9vao4ZObsGoXDTP5L92zZWFxeM3ek1EEvsShFRbdcV
	+qweKsgIVxrI3zaaj/uIxg3VavHbr+MbfxXdu1DUUZQEnO+4xopQ4wp14BtXiE7w==
X-Received: by 2002:a05:600c:4f4c:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4994e7b74afmr60156055e9.11.1785914857480;
        Wed, 05 Aug 2026 00:27:37 -0700 (PDT)
Received: from SVR.localdomain ([86.106.74.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5e85sm6484406f8f.14.2026.08.05.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:27:36 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
Date: Wed,  5 Aug 2026 10:26:41 +0300
Message-ID: <20260805072641.402-1-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b53 keeps the VLAN table enabled at all times, so a tagged frame whose VID
is not in the table resolves to an empty member set and is dropped before
it reaches the CPU. Documentation/networking/switchdev.rst requires a
standalone port to keep every VLAN configured on top of it working, and a
port that is not filtering to forward frames whose VID is absent from the
table.

Turn the table off in that case. It also selects shared VLAN learning,
which b53_arl_rw_op() already ties to the same flag. Switches with no tag
protocol keep the CPU port tagged in every VLAN and identify the source
port from that tag, so they stay VLAN aware.

b53_configure_vlan() has to stop passing dev->vlan_enabled back in as the
requested state. b53_enable_vlan() stores its result there, so the disabled
state latches and enabling VLAN filtering later would not re-enable the
table.

An 8021q upper on a standalone port is the case that breaks, for example a
PPPoE WAN on VLAN 35. The PADO comes back tagged and is dropped, so no
session comes up and there is no default route.

Tested on an Asus RT-N18U (BCM53011 rev 5) against a PPPoE concentrator on
a VLAN 35 subinterface. pppd timed out waiting for PADO before, and the
session establishes after. With VLAN filtering enabled the table is still
programmed and still enforces port membership.

Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
Cc: stable@vger.kernel.org
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
I tried setting ds->needs_standalone_vlan_filtering on hardware first. It is
not sufficient on b53: f089652b6b16 ("net: dsa: b53: do not program vlans
when vlan filtering is off") makes .port_vlan_add return before the hardware
write while filtering is off, so the VID still never reaches the table.
rx-vlan-filter flipped to on and tagged frames were still dropped, 0 of 5.

Relaxing that check instead also works, but only together with the opt-in
above, since without the feature bit 8021q never calls .port_vlan_add at
all. Making the port VLAN unaware follows the same switchdev rule that
commit cites.

I also checked the case where another bridge on the same chip has
vlan_filtering=1, since b53 sets vlan_filtering_is_global. DSA offloads the
uppers on the standalone port too, so rx-vlan-filter goes on there and the
tagged frames keep arriving. This patch cannot execute in that state.

 drivers/net/dsa/b53/b53_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f5b9592794d..76378afe4993 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -385,6 +385,9 @@ static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
 {
 	u8 mgmt, vc0, vc1, vc4 = 0, vc5;
 
+	if (!enable_filtering && dev->tag_protocol != DSA_TAG_PROTO_NONE)
+		enable = false;
+
 	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, &mgmt);
 	b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL0, &vc0);
 	b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL1, &vc1);
@@ -916,7 +919,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
 		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
 	}
 
-	b53_enable_vlan(dev, -1, dev->vlan_enabled, dev->vlan_filtering);
+	b53_enable_vlan(dev, -1, true, dev->vlan_filtering);
 
 	/* Create an untagged VLAN entry for the default PVID in case
 	 * CONFIG_VLAN_8021Q is disabled and there are no calls to
