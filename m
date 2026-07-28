Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175644E03B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249374; cv=none; b=XlP/THMMr2EukVUnnb5hxNYAtIQ2jktkVcTw+cR6Kf+A7U92nPy08Me4O3WohcLcdp4NzSTilSN4xcE3ZLnKq8WMS4N4sRbVV5Je1Eg9xZfgALTJIs6d/h7qQpFylaRpzO6UDMGsPiCNybsZEPAFVYn02KLuLf8XWGOHUpDFHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249374; c=relaxed/simple;
	bh=lMvHwdjXU/tguKBCDnl57L4KlTAZg6CmyfTitAknuRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3ytXhpX+XXIpSOqBnGDFmsx68WcCx7jU0rpBJKXACJJf9bN9SveXH+VptsL7keDZr0YJuSqHZkW6DPvc6ah1d/XHpeAR4CfnoLIMaETk7QKDRtgOdy4k5ugySLhMgOL37nCVX0I37ZdjA0mVpdH2ej7UDRaxZ9bLTittCMUMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhLuSrJr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhLuSrJr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so530445e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785249367; x=1785854167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gV+baTkVnmeIvpucnWX4cYoPM8VqelkCbFJAKxVz2bc=;
        b=qhLuSrJrB0NRb5qbPWM08Mm2ZLmErhg1wPYwMOsamGMR3uk3pG2plkPotTY8ygDsgb
         p6Fx952FDjoVUVsouOVtm9Ens2Fue3bKcQr6O8nkjn+8ZRS1dCA3TBGxaAyfq4NhSOD+
         /H+9LBIvg16YE83f3aTQBJ2gyEGsQKsVoS0h5S9E6C+HcI9Tj15MF05tiWqDii8rEGOb
         pl7KxQoLsJ0y9bO/6JBPzfASNLVWBXRjSFxa5gxTWKsCfr1FBLJlx7WggTvede0d7h+Z
         ppUUGptz4A7ws0gdYzR0qglRKXo4mjSou0vPGSuMj+Hq2zt8f+WCWvKv+NE1s40K1p68
         iYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249367; x=1785854167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gV+baTkVnmeIvpucnWX4cYoPM8VqelkCbFJAKxVz2bc=;
        b=BL5YvBjYE9K3p49sY+laKqiKqEZdJoHRTlWGLGz/kk+QfyvrQhNP3G7PNrYEV+7d13
         MhBzCrlOIslPP+V3QEkUqw71VbLOIPMQZDXzIHpEZvZ25OK20D7/GOOhK7/0iEfOPrPO
         VJx72i32Gxg4yRjngIiNPG5M2l2Z8tFqg5VCfE3VrNLveg+0yq4MB+z9HlZz5AF/RGUo
         beHUYPTWGpLFb+vTAAkmvr1a+3DxW2QtWny1w17kSMhEPBwRDQsGi3uX4Jb5klFXTbu7
         TVexJIOgHKZ9rfz05vMKJQoACEgILI1NbZI1uSLQiJO71c0/6Ckc8EWwB0k9jdyyeAe3
         Wa+g==
X-Forwarded-Encrypted: i=1; AHgh+RomSmtniKIUsawVEnn/pZLJcH+HB/8uRpOeMPBfuVi+/VN441VwMZNRv0u2ER9g1QxpmI2oJHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81I0yM0VB5Q3K912zoCgTuK2FpYFrwaae1le4Q7vdTYNnkSd+
	ycQLrOUG9vKg+y6hw49gbsRonvGKyjO4FxprHaE6fe80w8DrqWwh4H0U
X-Gm-Gg: AR+sD12sBpr2+PK/1lu+N6ohKuJT8HWwNkjiM7XyWSrULA0+Pp2VXSET4D9/l8Yn1kM
	OKUvtHM9JYobf5xmGkiGoQRp87DsTgNuqzlWA3uXYorUqZFUBDxKtSxp3klwTz5UKSH3Lv2ihXM
	2OIKbmUjv8301lB9ZJuw0ZQK7al3c2I1z2qczMpdEdiwvEb3F6AKyoeJt6gVjFJpTJOC2yVsZqQ
	z03UuarCtfPeL5g2w4tlF3PNw14jsZ7QX6tVGTgns6APIfT884fZR3tifXlv8Q+XWfsJ1xCYUMl
	KsyBULZPl8zfL8X67ZF2ckHsSAgQOemie4DxJW9xMgJ61AgBXWqu2tovpVY9I9svkiC6sSHLMLp
	rXgbTu5k3EI9AQQeBlebQfJroX4e27HbCP9LhdlurbAY3Tn5t5vWf5sQbzA7hr01gjeeJn5T0WZ
	Tw2Hvqj/ZJn26hWuQ7nehGsKo+MUgZJd7/Ypy8REfL9YMgmj5n78jI+T6yUeY/2+oqXzMV75RKm
	VUV84blfHWFyycgHlcS/LCERXPryzHcnugqKsM=
X-Received: by 2002:a05:600c:1d0c:b0:495:6e5f:3961 with SMTP id 5b1f17b1804b1-496c9da4de7mr12963385e9.1.1785249366551;
        Tue, 28 Jul 2026 07:36:06 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-168-074.77.179.pool.telefonica.de. [77.179.168.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm303390105e9.3.2026.07.28.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:36:06 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	lukma@denx.de,
	m-karicheri2@ti.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net 0/3] net: hsr: fix shared-skb mutations in the forwarding path
Date: Tue, 28 Jul 2026 16:36:01 +0200
Message-ID: <20260728143604.26-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the review of the PRP RedBox v4 series (Simon Horman forwarding
the sashiko AI review), shared-skb-data mutation issues in the
existing HSR/PRP forwarding code were raised. They concern
pre-existing code, and we promised independent fixes for net. An
independent source audit then confirmed two distinct defect classes.
This series fixes both.

Patch 1/3 (interlink address mutations): on an HSR RedBox, frames
forwarded to the interlink arrive in hsr_xmit() as clones of a shared
skb. A tagged multicast or broadcast from a slave is also delivered
to the master through another clone of the same buffer, so the node
MAC written by hsr_deliver_master() and the RedBox MAC written by
hsr_xmit() land in the same six bytes; the local stack receives the
RedBox MAC instead of the originating node's. Master-originated
frames alias the original TX skb (taps may hold it), so the
master-origin substitutions and the RedBox rewrite would share data
too. The interlink-bound skb is now privatized with skb_cow() before
any address mutation: for all master-originated frames, and for ring
frames the master also consumes. On the hardware tag-insertion path,
the selected master-originated and locally consumed ring frames are
now isolated before the interlink address write. Ring frames the
master does not consume retain their existing zero-copy behavior and
pre-existing aliases; the pre-existing slave-side packet-tap alias is
explicitly not addressed here.

Patch 2/3 (path/LAN ID alias): hsr_create_tagged_frame() and
prp_create_tagged_frame() wrote the path/LAN ID into the received
skb's shared buffer and then skb_clone()d it per slave, so the
second slave's ID landed in the first slave's still-queued clone.
With a 200 ms netem delay, all 200 injected frames left slave A
carrying slave B's LAN ID. The helpers now clone first, privatize
with skb_cow(), reacquire the pointer, then write.

Patch 3/3 adds a regression selftest covering both classes:
pre-tagged PRP injection (base: 200/200 wrong-lan; patched:
isolated) and an HSR RedBox tagged-multicast case (base: the master
receives the RedBox MAC; patched: the master keeps the node MAC and
the interlink keeps the RedBox MAC).

Each code patch carries its own independently identified Fixes:
commit (5055cccfc2d1, RedBox introduction, v6.10; 451d8123f897, PRP
support, v5.9). The PRP RedBox v4 feature series is unaffected and
benefits when rebased.

Relationship with the in-flight GRO v2 series ("net: hsr: fix
GRO/GSO super-packet handling",
https://lore.kernel.org/all/20260724161253.79-1-xiexinet@gmail.com/):
full revised series vs full GRO v2 series verified applying cleanly
in both orders (selftest Makefile merges identically either way);
no textual or semantic dependency.

Validation (raw logs in the series' evidence archive):

- both shared-skb mutation tests: base failed, patched passed
- all executable HSR/PRP selftests of the base: pass
- create/delete loop x10: clean
- checkpatch --strict: 0 errors (one routine new-file MAINTAINERS note)
- W=1 base-vs-patched: allmodconfig + allyesconfig, 0 new warnings

Xin Xie (3):
  net: hsr: privatize interlink-bound skbs before address mutation
  net: hsr: clone before updating path and LAN IDs in tagged frames
  selftests: net: hsr: add shared-mutation regression test

 net/hsr/hsr_forward.c                         |  51 ++++-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_shared_mutation.sh  | 213 ++++++++++++++++++
 3 files changed, 260 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_shared_mutation.sh


base-commit: 53658c6f3682967a5e76ed4bc7462c4bdcddaec3
-- 
2.43.0

