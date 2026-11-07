Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794089156;
	b=HJdynM+RKUte47ifs7RBRmTgPzaOmJq0qTVQizUzaIWvUJ5MWoya/7w6kEH9cz+LBibx
	 pEwroYwZTujTMRiMv9cfJo4SuojGH0jhZkNnUTEvSFMtuBYhT3yEoLY9fHdpIa66nYdu4
	 6ibo7lv7Of4g1u3rD5xenEt5Kz+Cqn4PIcL+oUCPPVEkTIRK6wBnQlbMkSWhN8mM8iQad
	 vxld0zFbRGy8WDasHUjwZDO3YtxRZyXdXU1SSofcVg2L0/7Fct1l0KIGoqfcDvuZd8N8R
	 OqgZbzZFaF+P+O1wcv16tII5JvPOoCaPO25771WNkX00O+6IzbBUefAkowvdt+oWgOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aKP/DpJRzJyt9/8HhoM5ZhK9oYmsUYgljoAV0yx+rFI=;
	b=p2F0w0NW/Mi9KBaRREf/hsSPQZPRtaejDakxCz75oYVl5lIx9UIpQ8U7RZWc0sIHSP92
	 ZUiTJElc9wqz0YfBfRzfakNn3AAtm1av//rzytR2TRYHyhHm0ZH/W1RKMcnF/M6fhNcbF
	 VkSks6N4dWXQ9Y0F/7hGULhJmA3N6ub7czvpw0G23/ykywBBe/yvVfBYy5lTuf9ZS/yTK
	 BGTTnZ1bV6kNgXSFb9xN5r4k0jAFx9N5Hil0qmHiv3AX+LyM51SYMqB6sGfrQpG+7AnDI
	 t4ILFHsrlDIGPf7KMndCT++RS+2lgyQx+dzvk8DmOdRYIK8LKTiYRrRoMSjkXM/vjog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Z4tRWN1;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290E606D83B
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 22:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1290E606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Z4tRWN1
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4913db60638so2197f8f.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 14:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794089154; x=1794693954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKP/DpJRzJyt9/8HhoM5ZhK9oYmsUYgljoAV0yx+rFI=;
        b=0Z4tRWN1mk2FwpqxkqSDckSzbbByd8wQ7IRIxNkV3PqQ94KO3Xm++Rj8wUzl59GVKR
         991wjvgrvDRu1NlfyMpXEql7xvwi7YhYygEd2SogkhV1UDJLk7ANj8+uMn0lAYV9fKej
         o+LIaqy871zlHDrnN1JAx/m5GGNUPI+BiLfhq7YCMxnPfj/w8DCfeAXXIrrHanYQagal
         YfY3XMMbf7U3wYn3j64bfGrY5A9hl3lnAvZ2nn8/eftyYotZgsU68biZ2jqQya58ixdr
         JCNaLcaq1RvMVRfmUjZ+S34W5kdWaZPSCU/wGMsR6TrI9pkbmIS6kTERLvf2vk3ci73a
         sY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089154; x=1794693954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKP/DpJRzJyt9/8HhoM5ZhK9oYmsUYgljoAV0yx+rFI=;
        b=LSOEOt/aI6uzUc7kofx282uTiZwKrl80Pnv9EwLxml3CyEPpzwf0RrlHihaeddFLcb
         EKMIC/hz9X6e2mb6UeZgWWKNiURd83FyzeM3U5llO/WWQbAERYvl5OsDEwFvRsvqxF+I
         d6Gg8r1Jmxs4wCU7PorHS07S4HHflqv6lIkoZYrc2kV9V2X2R0fn++999L9ubxPXXfOv
         8E0r9EWCOFiW+ruEoBU2FbvBqi8Wh9XSNSnpnkTzp0d/UFWzflgSdqHSfbNGmYSrG1A2
         UEJ3VkLMK09KfmT4e1JHXBtXJuSckT7sh+UGsySaWRAVJ/Iwl8uBk7FjABp0WlDM0nD4
         FhaA==
X-Gm-Message-State: APuU4Z+aX9Ra20VBCd+GN7sgyoaz4G2sSfSETm0vJpWVSDMKaFk48l35
	KOTbSJBGj0iKPzkn1IB+gpHgb19tax8MHL2xFQQ1M6MsetN2rGiCG/Yny0bXII20bsQ=
X-Gm-Gg: AYBFou2JFQIpMwq1G46hRp68fMjixYYICCWLgG8Mo8ypuLTyT2aKKvNnE2IBXxR2O+/
	TLBK2S5Rcp5HldpSupC8TAFOXujMraYu4IYOymfVDV0sbWmxPVrwm+oU//t2zYQBqg3KLxmfDq7
	a5AYWhquA3fbMSVN4PC7vb0pgdw4gS70Qt9/mEesJWAeAbcAM270BFWwEYiG/tlpPST+SiS9J62
	koBHRfI1A/4Bk0ljJ4B88CJDJ7m2Gr+18RqDht3XIr/FI2LT+pLWkMsN4Wtraz5KXfY7qi8bf3s
	ZvxUynXnx0VjKzGn61v1+WTWWGSWTVsDr1Gyrq8ZCp1rKFKFTOX5Ov/xbNHIz/GCjv3OKexWnYW
	88KcnUJNDFMn/8D48spYeNvxG0LF4B7vrG1C8P2Uh2/Q/SzSmFTgrd9IfERODopbWbKQ7S5c0qz
	vhIyIuMgF59FLfZwOpCn6vzaHP3z5IcukxhO9HrgmAlvv0+qEKaFWHyN79Zxe4hrXgrN86swaow
	tRk63k8PBgHeWZRDE2MDd8avjeWz11dySOcjsf43BbCXuu+cr84cbmOfSF0J5juAQ1HpYUfNI48
	p9ej64XCCoGu3PHUYO0ldfV6wMIANN/08umKPy7hk5fnZnt+lLsQGq83o/3Hj022zchfMRycrUN
	d6n3d2kE1nISxnpfRR0HztnJLpJcaEW6bquvoUSD7ul2FHC9jirIt7hp8lXHe69TZJrw1aBLoQu
	SpVrhHhFY2
X-Received: by 2002:a05:6000:220d:b0:48e:eb:56a5 with SMTP id ffacd0b85a97d-49583dec0camr553506f8f.4.1794089154261;
        Sat, 07 Nov 2026 14:05:54 -0800 (PST)
Received: from L-022584.energy.envision.com (dynamic-077-189-161-157.77.189.pool.telefonica.de. [77.189.161.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597b1f969sm358958f8f.50.2026.11.07.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 14:05:53 -0800 (PST)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	xiexinet@gmail.com,
	lukma@denx.de,
	fmancera@suse.de,
	danishanwar@ti.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com,
	sd@queasysnail.net
Subject: [PATCH net v8 2/4] net: hsr: refuse forwarding devices as HSR/PRP ports
Date: Sat,  7 Nov 2026 23:05:41 +0100
Message-ID: <20261107220544.20-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107220544.20-1-xiexinet@gmail.com>
References: <20261107220544.20-1-xiexinet@gmail.com>
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

syzbot reported recursive locking with an HSR device whose slave is a
bridge, and that bridge has the master of a second HSR device as a port.
The first device transmits its supervision frames with its seqnr_lock
held; the bridge floods them to the second HSR master, whose
hsr_dev_xmit() takes the seqnr_lock of that device:

  WARNING: possible recursive locking detected
  ...
   hsr_dev_xmit+0x18a/0x210 net/hsr/hsr_device.c:234
   ...
   br_dev_xmit+0x1202/0x1b40
   ...
   hsr_forward_skb+0x171c/0x2ac0 net/hsr/hsr_forward.c:728
   send_hsr_supervision_frame+0x63b/0xcc0 net/hsr/hsr_device.c:351
   hsr_announce+0x1f8/0x3a0 net/hsr/hsr_device.c:408

Interlink RX forwards to the slaves with the same lock held. A chain of
two devices does not deadlock, but such a port makes no sense: an HSR
ring and the two PRP LANs are attached to the node directly.

Refuse bridge and OVS masters, bond and team masters (also without
ports, since ports can be added later), and macvlan and MACsec devices
as slave or interlink. The rule is by device type, not by the presence
of lower devices, because a DSA user port is an upper of its conduit
and can offload HSR. VLAN devices are already refused. A tunnel device
whose route leads back through the HSR master, or a software device
without an identifying flag such as batman-adv, is not covered.

Also refuse, before any state is changed, a device whose RX handler is
in use or not supported (IFF_NO_RX_HANDLER: ipvlan, VRF), with an
extack message and the same error codes. Some of them, such as a
macvlan lower, ipvlan or VRF, used to fail only in
netdev_rx_handler_register(), after the previous patch had dropped
their GRO request; a refused device now keeps its state.

A bridge can no longer be used directly as the interlink; connect it
through a veth pair.

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_slave.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index bc340ae0b52e..26f16d98e479 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -120,6 +120,22 @@ static int hsr_check_dev_ok(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	/* The RX handler is taken by devices such as bridge/bond/team
+	 * ports, macvlan and ipvlan lowers and HSR ports, or unsupported
+	 * (IFF_NO_RX_HANDLER). Refuse before any state change, so a
+	 * failed attach leaves the device as it was.
+	 */
+	if (dev->priv_flags & IFF_NO_RX_HANDLER) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "This device does not support an RX handler.");
+		return -EINVAL;
+	}
+	if (netdev_is_rx_handler_busy(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "RX handler busy: device is already a lower of another device.");
+		return -EBUSY;
+	}
+
 	if (is_vlan_dev(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "HSR on top of VLAN is not yet supported in this driver.");
 		return -EINVAL;
@@ -131,9 +147,19 @@ static int hsr_check_dev_ok(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	/* HSR over bonded devices has not been tested, but I'm not sure it
-	 * won't work...
+	/* Forwarding devices feed HSR frames into another device's
+	 * transmit path. A bridge, bond, team or OVS master or a macvlan
+	 * or MACsec device makes no sense as a ring or LAN port and can
+	 * nest seqnr_lock through a second HSR device. Refuse them by
+	 * type: devices with lower devices in general stay valid, DSA
+	 * user ports are uppers of their conduit.
 	 */
+	if (netif_is_any_bridge_master(dev) || netif_is_lag_master(dev) ||
+	    netif_is_macvlan(dev) || netif_is_macsec(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot use a bridge, bond, team, OVS, macvlan or MACsec device as HSR port.");
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.53.0

