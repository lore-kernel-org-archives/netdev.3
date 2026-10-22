Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685401;
	b=1A0kg+8o8uRBakkHIT3OBAIm0jg4325zNtXJP+7LEyrZvI1QML+13KyCVPDpulxunuui
	 Mw47eXUygOI8PTKIH/IX73K8ORV5JNHaA3QwXtHtEWQ2PiwKuP9yxn/STmI8vAeyFtSyb
	 wYWlAqqckW7pkWMaU7VlWzPKKB7SYW2OcDUyh+yt8U5rFtzke/x9iYWTtfj7cZQQ8ylB6
	 Poes4XIIyiCjH4mfvZHgwra66wNpjrosYnwsA1QVVdU5CWPa8l5dPgic2AiqEfY4MLvzQ
	 RNOyyG2ixLB/Q2O8PO4JTieof5+XqLcoVt2nfPB78yx4RRSxJQt6kYVr79ACX9T3awA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GpbUIm6RX7Iel46gw55j7xKHlKF59H1RZ41ZjqItGOY=;
	b=gpYKYKBBfrgrs4MpgaRVc4HeizTraGRb9OgN2Lol/ujOPC09ac3e6n+gOHClf9Sxjbsk
	 qaHoP8KTqTBCrWd9ZUCEKgQZn4UBVGhEOfKehzsPLiSjF9+q0tFSu5JqxX0q6bX3Kfypk
	 Sj7gDBUv4Wt7LhLGediRoE/2bdu3AQm2V52IYtk2wvZiedKA0d4Lqe4RqsPWjnnrW68Zr
	 jMltzH5u4+Y2HSK6/VkLyLL5fqIgTsLpmqO7sVipjDARBOXDC9XBemPYO26ndlCBjC50l
	 oopyLT23/8CnR2ypblQyNDB6l85tH+cdIPl27VwRkoNi2E1kG5VooU/vOnacXjaqJqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sSXDT7SD;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797960A2637
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6797960A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sSXDT7SD
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1517bda04a0so2343897c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685400; x=1793290200; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpbUIm6RX7Iel46gw55j7xKHlKF59H1RZ41ZjqItGOY=;
        b=sSXDT7SDopEOwXdk7VRiArKA6rfD15wc/wBymk0WpLF7503Zp0Bn7wxAUvw8tGzwpm
         9+nMwwIxqY2QfpSh/9C011p0nq5/lbN1M8HtVuZKGlYI9wkixU8f8FrPqssGMLtF61F0
         L7cXCp35J/amP99terbcFS1luW2Z0Jumm3ij4zJ9ilcJ9SVW6eCEymXEeeZlqghFaa0y
         36XUVuXBoSH4uTn4+UZM0qa2DkDwhXXuSHYAq1qo0gJqj0OBulPqFh47FfaAMIWuzpNk
         MccvHKCdcskaohIxnd75cF4UHjxSNH16n0XXyoMIznqWTy8Pylqx9HbR0xMn9FnmpK6Q
         au4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685400; x=1793290200;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GpbUIm6RX7Iel46gw55j7xKHlKF59H1RZ41ZjqItGOY=;
        b=Q1/+MpEu4ohr1uoaKyZBrUq4fhXuKlat42FFPoZDLxOtfTITaGWTKGYE+UEH4g5SRK
         bZrfyBvOoPTfGVBnkYX5c7LLdLsRzJJkNlMgsQ6NuB/hRNUMf0eNxmtLoWAGNavZv/Y1
         4KiSzrPtlc+lFJcKeH31c8a0gDPfEpnLpRWrbBMvZJNmJWr7m1a0PLohODbkQKREHG4f
         B7x5RLDHoEOqJruTl+D7NF1QKVREEWkJQ4AgJ9h3WtAZ3qAaLIVho/eBBZ33d3FlnwEn
         xIW29iiWO0KJvtmSs5/532Msmv1qNX71vj49XnXCwLrxp7sHHXO9SfN9AUHnowFm/OST
         pm/w==
X-Forwarded-Encrypted: i=1; AKwUvByG+cYT+UVoz8Z+7CPufDwcGzdR6TtRf2lij1buAgcAJq8jgNltbCFjLELRYGSADR0At7PfYC8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9ZBu3ErbZXN5cxamX+p9TpH3J4Z9TUjh9ddrdneYP3qlxgmIK
	b6U2J+l8CEUSQvxHBWrrlFl2btnsLiv4Xhr+AvP5OdmgMOYSiYYzfvHm
X-Gm-Gg: AYBFou379ljkZZipY6su1QXYyGGAEqoMMC7y5hDDG0+lIGbdCI05U4Yvm0TFGiYGl7j
	lYpqk3nBMMRP+e2Aer2i4JQJ1Mvfz3nRBu8b3PjGjMyYmkFnrNiLINLcpsR1NKXBejdzw0kjavk
	kGrzooR5IJQ6fkQ3in9n0nZH3zJ8/Q+F+JrTYkGZiWSyVzPtlTQkDN1gHmJO6L95aAxfkC0b/nW
	PByVuvobiEKAilvvBySimjUCEwZx80eWi4/w8i+Hn+bOJyPVwdhhEfF2dnJDKxjxde1z5r+uGIX
	vfMFxViup7kMhxuIhgDIZQO05lPek+PZdyDR8OIpazaAqriRXZQQ2aQUFhjyKU/Raxh8CncvGDr
	zwMdRC2gwgcM7wDXQXwNc/NBB238oFl+MBo1VRHmHP3Y/x5+dEhBRCpqlrSEFwQCJTaLwfQV8CT
	VjjvwvgK37Fcb1bcCgAYVmYhB0OM+nD4/glePjOx2Dxqgd5HQ7y4n3rxLhADKz+Gf3mDnAPrMe/
	FMUR+Muh2StPiT5YNpD5ldImTxR9NsDrvFvjl3sPiFN50ieZnTsVQXoM0ipML9TXayqWB6aB4mT
	AevM
X-Received: by 2002:a05:7022:eb46:10b0:159:aa67:2893 with SMTP id a92af1059eb24-190a632f2bemr7128725c88.30.1792685400457;
        Thu, 22 Oct 2026 09:10:00 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:09:59 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Horatiu Vultur <horatiu.vultur@microchip.com>
Subject:
 [PATCH net] net: bridge: flush FDB again after unregistering the RX handler
Date: Thu, 22 Oct 2026 08:26:49 -0700
Message-ID: <179268538303.70821.8213834342995341232@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

del_nbp() flushes the port's FDB entries before it unregisters the RX
handler.  For a normal port, br_stp_disable_port() has already moved
the port to BR_STATE_DISABLED, so no frame is learned in between.

That does not hold for an MRP ring port.  br_set_state() ignores state
changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
the port state alone, and br_mrp_port_del() then sets the port to
BR_STATE_FORWARDING (when the bridge is up) before clearing the bit.
A frame received between br_fdb_delete_by_port() and
netdev_rx_handler_unregister() is learned with dst == p.  Nothing
removes that entry before destroy_nbp_rcu() frees the port, and a later
frame to the learned MAC is forwarded to the freed port:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8 at addr ffff888079f4e038 by task br005-poc/9379
  Call Trace:
   <IRQ>
   br_forward+0x55/0x3c0
   br_handle_frame_finish+0x1300/0x1d40
   br_handle_frame+0x90a/0x15c0
   __netif_receive_skb_core+0x953/0x3040

Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
state bypass") fixed the same race for MST, which bypasses the port
state in a similar way.

Flush the port's FDB entries again after netdev_rx_handler_unregister().
Once it returns, no frame received on the port can be learned, so no
new entry can point to the port before it is freed.

MRP ring ports can be created when CONFIG_NET_SWITCHDEV is disabled, or
through a switchdev driver that offloads MRP.  The race was reproduced
on a KASAN kernel with CONFIG_NET_SWITCHDEV=y, using a test module that
accepts the MRP switchdev objects and holds del_nbp() between the FDB
flush and the RX handler unregistration.

Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_if.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..8e774329af01 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -367,6 +367,13 @@ static void del_nbp(struct net_bridge_port *p)
 
 	netdev_rx_handler_unregister(dev);
 
+	/* The first flush can race with an MRP-aware port whose state was
+	 * restored to forwarding by br_mrp_port_del().  The handler
+	 * unregistration above waits for all active receive paths, so flush
+	 * once more before the port is queued for RCU free.
+	 */
+	br_fdb_delete_by_port(br, p, 0, 1);
+
 	br_multicast_del_port(p);
 
 	kobject_uevent(&p->kobj, KOBJ_REMOVE);

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

