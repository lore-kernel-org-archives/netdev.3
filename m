Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F523B0AE2
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166361; cv=none; b=mjFtSXE87w/f0xntkqI8mcnzyCePvsLsvEeq0BVK2JnvJrIUQkHWrTPGG11AhiR/A0W35qokMNs2Qx/WZHTbE4O0gs6rkPSLo7h+KUXzl/ajQ+wuT+LXl3e5Rm1svJXFEWKE4rxdBV+jHSKfH9oDfGCP/Vm0UnvWd+XQoaOew4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166361; c=relaxed/simple;
	bh=HY2X3kiRDp3kythZt+92BEYBkfXvqmSM4G0ZSL7mjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkVm3PmKITUCqvtNAsmjONW9I9hcjOKnsHuRObdZdIdPZGK3jTNeHYc/ZyPOJ8n+DUkZVDQv3DOdHVvHtAe9cQsX6ZVr6z3FXt5YX3fWUCqIvSJS6ktT3/qPG9lQMtvhE8bTi9KTUCeOYsaLhbnJwZ0h2Xa1cXQhQnetv53/7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKQop7GG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKQop7GG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso21384045e9.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788166357; x=1788771157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5vek8wQdewxnK/VGrPkZ61ONNEO3P7RJOJ6UtIbKqA=;
        b=mKQop7GGmq87dksh6g9vsgex3xAlRWP+Jv3oq4aTmnXYLl7JsD4Tj8eRn+deC8QlMp
         NV0bVCUrRJtyjTqnkUQ0igio8KP5NRNho9Az7i0wxLTJmQ8mRxe79wJFPygC6HRRqWfB
         2o+Oh64NJm1wCa4w0K9u3tX+ZL/BUC/WXRmqsZT+J53R2GkW0M1q9y6ci/JiOe2S2Yhl
         CFq37+WOy6BzujtzKrClbR6qwlqa2LG64f4qqLiJvbvjG4WVFqYF2JCwSEvftljNB+wK
         RRxa4WmVhrlCdWOn+DPSEFxjM3jykLIxCFlj1/W/m49lIGBG+1fLLeN3CLtTNBWLjJU3
         XNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166357; x=1788771157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5vek8wQdewxnK/VGrPkZ61ONNEO3P7RJOJ6UtIbKqA=;
        b=kRvRxjNVAxsnEMNeqXxg65jjQ/oHkHfPpop36PJNb/jILILtVlRFSzyoT2LqC7zyh4
         gnUBPoEttVC/cOx/6Bh/c33TPJ7KcwBomCkl2XGT+abjc6nPn3/dhBSLBhDEHvfLvgvJ
         Fn4ugm6sKwd8s/IkCOvBYg8QWemBToMPOFnFb8CXbBBazX+U8qL316Z00df1Xi20TdGs
         mBaAnXXL2y0Lcz8CW1PBjPwqqVvhKvVT5JFKavTijdmzLTXRyNjzlMwVl0vv3en/RFGV
         xVyYtF66Eu3nqEmA66SatN4/GE7IaDLkUfFQhh95QcldpKgnOJ+u2ivvd3NBG7zkRDVi
         kVZA==
X-Forwarded-Encrypted: i=1; AHgh+Rqxhk7kKmfeugi49E7TT3MQrwJRcDYNzs2NKpnk07Q0P4hW6K5kScOKVB+8Zaosl6yTtwjuQJU=@vger.kernel.org
X-Gm-Message-State: AFuF++lpruW1Zw7nd5w2FdUJ5/DfAqsYQl+jKcZYeJGpWFozd3UXzvFU
	GQLj7AqWpfMal/NjLjESOqv+hHnCvs6LIKAtrUmmkaT+ZMqNcFryBHHo
X-Gm-Gg: AR+sD102IIminXCRUtXiSE2QQhkU3S68mygSw6zAr03062uqcbNHXip6g4RhDNKLlu6
	PKFQgnI4SAfMpcn4ilE52tvIVcoCJjKdra1wzbrYTz0OWx8j8uyAaNAoGhmA/opj3w41y2yblnU
	XnKEIRCmJ5tp2FhVqhBYrIl+H8pMgPZSGuUSTZlD2eytuwNpHH2+zceRbSpNqmocS5dwJeKFF28
	oU+YphfOdKaxs4P81t7V+Xjm0AYm5ODyK68X8xM1LZmIvgelZfdQurSDRaKBkb8VYUDtc5NkjMT
	aOGV9KqBYJT54BicX41E21Hkjo3PjwQqTZcGVPEDxcqT7TPU55S8nznUQfKRMZSojEAEfFnAayy
	HbWobSZNYiM/GL2rpEfOyJ/Yh/TgjDk/BWl+6NPp8sYpDh7xU/NE9ca0+J16EXuBq7DEgi9xKOq
	C5I04y4fSu/RZe+HY346Y+bnuaQocJ0WrLo0R7Y1QCNdw3pbnd2y0CoJrABvXwSv7oS3GP8mBF6
	Q==
X-Received: by 2002:a05:600c:3f0c:b0:49c:cedf:f870 with SMTP id 5b1f17b1804b1-49ccedff89amr197881865e9.16.1788166357312;
        Mon, 31 Aug 2026 01:52:37 -0700 (PDT)
Received: from SVR.localdomain ([185.179.67.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484397f33fesm7786600f8f.15.2026.08.31.01.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:52:36 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
Date: Mon, 31 Aug 2026 11:52:15 +0300
Message-ID: <20260831085217.391-1-strst.gs@gmail.com>
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

I looked for a fix inside b53 first. The one existing way to have the
upper VIDs delivered to the driver, ds->needs_standalone_vlan_filtering,
does not work here. It was measured insufficient, because f089652b6b16
makes .port_vlan_add skip the hardware write while not filtering, and
its other effect is one b53 cannot take: with vlan_filtering_is_global,
the forced vlan_filtering=1 in dsa_port_reset_vlan_filtering() would
flip the whole switch into VLAN filtering when any port leaves a
VLAN-unaware bridge. hellcreek relies on exactly those semantics, so
patch 1 adds a narrower opt-in that only delivers the VIDs and leaves
vlan_filtering alone, and patch 2 uses it in b53 and programs entries
that carry standalone members, masked so bridge VLANs stay without
effect while not filtering.

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

Changes in v3:
 - patch 2: BCM5325 and BCM5365 are left out of the opt-in, which now
   gets set after chip detection. Both forward a VLAN table miss, so
   their standalone uppers already work, and their tables hold only 16
   and 256 entries, so v2 made b53_vlan_prepare() refuse an upper whose
   VID lies beyond the table. The message no longer claims such uppers
   fail loudly.
 - patch 1: unchanged.

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

v2: https://lore.kernel.org/all/20260826171526.391-1-strst.gs@gmail.com/
v1: https://lore.kernel.org/all/20260806073119.387-1-strst.gs@gmail.com/

Semih Baskan (2):
  net: dsa: let drivers offload 8021q uppers on standalone ports
  net: dsa: b53: offload 8021q uppers on standalone ports

 drivers/net/dsa/b53/b53_common.c | 119 ++++++++++++++++++++++++++-----
 include/net/dsa.h                |   3 +
 net/dsa/port.c                   |  22 ++++--
 net/dsa/user.c                   |   4 +-
 4 files changed, 122 insertions(+), 26 deletions(-)

-- 
2.53.0.windows.1

