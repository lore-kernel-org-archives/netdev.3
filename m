Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D33515C5
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764566; cv=none; b=u8SrU/ELXESuhNqoTMssBUlZsGvqSObdpJi+AU5D9ZRR85KnUznMwltH98vSG+Ng2ll89XcDQDqU743+NFRyXqY0QGUdDYj+O/xhYWxfE2WaV485xNhEqrcP/LAHtpnac2j4LFv+0nsB0h8oqZFLgcnyk2oCRVTK65ZAvCZ/BhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764566; c=relaxed/simple;
	bh=/EgEdrXS4Wv0jxVQALIzvmIefQDOLKjUKXIiXmdSSu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d70FF/HFxuUm26j4nTkFEcBfv5/70u9R10f8H8a/ad6NNbnxS27fqLTMf/6pOBNFQVULYMVkjUCQZPjoXGk0msJMWRrpth2RN/Pi4sS6rx8pz1eBvGihKcs0LGSJBo53nRiT3lc6URO7oYMR+6QuH+N/zOqfe6xrxLjDidQ4xwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGrSiPzq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGrSiPzq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso2045260a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764540; x=1788369340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THUloCQaHU46tb48+FvM63t2s6NnBgSS/AfMphriNVc=;
        b=VGrSiPzqYwQ8lvdnCBpe3Dg9+bJ8S6B8gqRaXDUCZShsV/O56xGyEiH7Q9Ek2N+cE2
         5ip4c+p90xweTsn0MueVUo0UjJB2JAiNK8MQSK6kt7agUs840HRum6r977FhYFx2j+jd
         mjpR/PFMKJXZhuH5aPpqUFJYtFGb1qgFf4kHYYQz96f0SEq2bu1H9dxHq9AekgHI6xBO
         wUnmlIClaYwyGjph30WxRblE9NdJ5+QHawnH0uKYyVJTDRKP80FXGTMKAJWaravV6fLP
         YTjeoA5pu9clbdnHo3xZARtzgRe/a4ML2lKgZaJHGhSPONCG2vPKmYslgSOuy4Fbu3xC
         ajeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764540; x=1788369340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THUloCQaHU46tb48+FvM63t2s6NnBgSS/AfMphriNVc=;
        b=dNVyPY/7xkBo/8FhCMN41JbrwiP2x8WU1KNoBVbzE0+ViLLyJdy3L7x06vX9iZNecJ
         dVaB3NWjGiFKJ+tcXnr4UkUipkG/EJps1glZCCM3ygbh1T6BknozwYG8/ogEOcHrZdLB
         S3DwtssC6538qKnWdD9v3CbhaVHRs8HAQuvwlV46pTdSar965pERcZ1vhuboamUseKxp
         Ei6njBaz7I//ng7ybERnQyEhuAfshqefDz335ByGK0qBk1Rd9HrQ5eU1sVVbDKsCFiht
         axMmsaj/VnVBkq1A/Iky5zMavsoy7hEGEopCs0Kf7fJOfz/CYQl1Cjs4v4HPcKqZmEbW
         03kw==
X-Forwarded-Encrypted: i=1; AHgh+RoHmTxV/W2kmTNCiob73dj5XJ/e/Sj6IkCFUSDr3hMcMZcVDpAd1iVqyALu3ipLAlh5DcmUeiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lgcqtChapF4Qd36Hd/17m3I1/QbHCFZqRXBNdNlispuG/dXeva
	Qhe2isYxDyTReVrqf0tz4+RRBwglCi+gL2tAkn/sZyg0l+JDkoFXW4bp
X-Gm-Gg: AR+sD113WWbK/1r+/LwajBoUSgOA25GmcJfUgN7tD0J/5zDcga9uie8bAkbeNjmgCvw
	NA/8J/fnDOhpjeLoQ2CGsT5ppscdCm0gtGe+oQvJH/99OTY3SokVLXdir4HauJ8jQei9vFE+tQM
	q3grdrlBDC8n31Hl09vZpdTQIaDd2OZN75QSy3/6XQJqNm42tygLUT4ZRf2dKH5IenCIMTyeeVe
	ifBKi1x5ySfUbqvZe9TASCVaAStoanQ/FVjvxNw8ctGj85m9IOTBreMsOAV4x/7xsOenP8eZiHc
	YxR4jQ2TMlBByYXLvPU2+u/ta0ao9cSECFVPAOfnqe+Jwfd9h/Kx1xbFc9JSRGJteVcOVETf1kE
	yN3ztzHcpr9Gp6WK0metOLLD4unMSJBZDQNFzQoUC1VsIvQwrV/XX5uGqh2ZZeorR4raK+ZG78k
	y2s3n73bkOO6x8R642MJIoZomDjkNBjp4SvfNLtQZ6z1ZMGxnnP2WrzVI+VH9iZv9RgieNealf8
	w==
X-Received: by 2002:a05:6402:354b:b0:69a:928:9405 with SMTP id 4fb4d7f45d1cf-6a5df5ca50cmr9709673a12.1.1787764540403;
        Wed, 26 Aug 2026 10:15:40 -0700 (PDT)
Received: from SVR.localdomain ([185.179.67.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8b5e5esm4244556a12.4.2026.08.26.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:15:38 -0700 (PDT)
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
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
Date: Wed, 26 Aug 2026 20:15:24 +0300
Message-ID: <20260826171526.391-1-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v5.15, a standalone port on a bcm5301x b53 switch cannot receive
its own tagged traffic: the switch VID lookup is always active, an 8021q
upper's VID never reaches the VLAN table, and a tagged frame with a
missing VID is forwarded only toward the IMP0 management port, which the
in-tree bcm5301x topology leaves disabled, so it never reaches the CPU.
The common victim is a VLAN-tagged PPPoE WAN, where the PADI goes out
and the tagged PADO never reaches the CPU.

My first attempt disabled the VLAN table while not filtering:

  https://lore.kernel.org/all/20260805072641.402-1-strst.gs@gmail.com/

Jonas pointed out that this moves the ARL to shared VLAN learning and
desynchronizes the hardware table from the bridge fdb, and I withdrew
it. I then measured the alternatives on an RT-N18U (BCM53011 rev 5),
with the outbound direction of the same link as a positive control on
every run:

  - With the table enabled, no ingress VID check setting delivers the
    frame: VC4_NO_ING_VID_CHK, VC4_ING_VID_VIO_FWD and
    VC4_ING_VID_VIO_TO_IMP all give 0, and the miss control bit
    VC5_DROP_VTABLE_MISS already sits in its non-drop state, whose only
    delivery target is the disabled IMP0. The frame does not die at
    ingress admission, it dies on the miss path behind it.
  - With the table disabled, a static fdb entry with VID 100 is lost
    from the hardware ARL no matter how the driver drives the ARL
    registers: keeping ARLTBL_IVL_SVL_SELECT at IVL does not preserve
    it, and neither does additionally keeping the VID learning bits in
    VLAN_CTRL0 set.
  - The VID to PVID rewrite bit (CHANGE_1Q_VID) does deliver such a
    frame, but only by rewriting the VID to the PVID, which destroys the
    VID the upper is keyed on.

So on this hardware, delivering the frame and keeping VID-keyed ARL
entries are mutually exclusive unless the VID is in the table. This
series therefore programs the table, narrowed to what is actually
needed: a standalone port only needs the VIDs its 8021q uppers use,
which is one table write per upper instead of entries for all 4096
VIDs.

I tried to keep the fix inside b53, but the driver cannot solve this
alone: without NETIF_F_HW_VLAN_CTAG_FILTER the 8021q layer never calls
.ndo_vlan_rx_add_vid, so the VIDs never reach the driver, and DSA
manages that feature bit. The one existing way to get it,
ds->needs_standalone_vlan_filtering, does not work here. It was
measured insufficient, because f089652b6b16 makes .port_vlan_add skip
the hardware write while not filtering, and its other effect is one
b53 cannot take: with vlan_filtering_is_global, the forced
vlan_filtering=1 in dsa_port_reset_vlan_filtering() would flip the
whole switch into VLAN filtering when any port leaves a VLAN-unaware
bridge. hellcreek relies on exactly those semantics, so patch 1 adds a
narrower opt-in that only delivers the VIDs and leaves vlan_filtering
alone, and patch 2 uses it in b53 and programs entries that carry
standalone members, masked so bridge VLANs stay without effect while
not filtering.

Tested on the RT-N18U: the standalone upper receives 7 of 7 probe frames
with vlan_filtering staying 0, the static fdb entry with a VID now
survives a vlan_filtering toggle since the table enable and the ARL mode
are never touched, uppers keep working across bridge join and leave and
across a vlan_filtering toggle including on ports that were bridged
while the toggle happened, deleting an upper or bridging its port
verifiably stops delivery of that VID to the CPU, and the PPPoE session
establishes. 802.1ad uppers keep working as software VLANs, since this
switch does not parse 0x88a8, and stacked QinQ over an offloaded upper
works too.

Changes in v2:
 - patch 1's commit message rewritten after Vladimir Oltean's review.
 - the delivery failure is scoped to bcm5301x in both messages; Jonas
   Gorski observed that other family members still deliver unknown
   VIDs, and the programmed entries are correct there as well.
 - the cover's description of the miss path corrected per the v1
   thread register discussion, and the measured alternatives extended
   with the CHANGE_1Q_VID result.
 - patch 1: the conduit change path no longer skips ports that sit
   under a bridge; with the permanent feature bit their uppers are
   offloaded too, so their CPU port VLANs must move with the conduit.
   Not reachable on b53, which has no .port_change_conduit.
 - patch 2: code unchanged.

v1: https://lore.kernel.org/all/20260806073119.387-1-strst.gs@gmail.com/

Semih Baskan (2):
  net: dsa: let drivers offload 8021q uppers on standalone ports
  net: dsa: b53: offload 8021q uppers on standalone ports

 drivers/net/dsa/b53/b53_common.c | 118 ++++++++++++++++++++++++++-----
 include/net/dsa.h                |   3 +
 net/dsa/port.c                   |  22 ++++--
 net/dsa/user.c                   |   4 +-
 4 files changed, 121 insertions(+), 26 deletions(-)

-- 
2.53.0.windows.1

