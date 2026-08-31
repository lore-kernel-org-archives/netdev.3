Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C537BE9C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211948; cv=none; b=f1n9UgFH5dhFMo6sKGq03xhf06jUnQSOt1UQxQaRb24eAWFwZpdOrB2P8WKTgVcg0StVLnq796c2TJIYkI0JcsAsaInsncvLaC73DdQx4j11rJO1HwgPv97E/WoeuKwUB8WVQrrWv4HTqf48N6SLtqIkeoRtcwt/6KONnBNS9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211948; c=relaxed/simple;
	bh=N4B57SZpPLoVWRmO8tZWIafFjkL7Tvry2bBjzoNjn5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZkv8g8zP/xA0UZQO1KgKwHBB6vgn6klSo//IJZ1NtOBfipyT2SOKP/JFV8dYNe4kzATnSJnipltoU4HA1NacC+qwzb7rbEv4gRBIo4mkTgkpcNgIdlmh8nYZPvia7/H7c6k022JfWcbrT5Ythh/LDk25xz6AQDwbYBNbolZt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkQn9SsD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkQn9SsD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81ecf499af9so48327897b3.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211946; x=1788816746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4dpfyGcHDjDiUcGiLRewZ76d7YjF7miMEuQ8SJeOus=;
        b=WkQn9SsDlbANGom81G6iQqsNhrwvdmKUyUNkBbRXk8Zk4UdQ8/XN7G4IzAaiRT7/nn
         /rN3xq5jtqsHEkvPtAqcx685jAJFXAu/eqXvrmZwBil5ClDVVCcJTxRM4oSn8817iq/W
         pKCayrIWeMA+ukVMZUogPFZnr4Lia7rNsXO6NO6zGuYLxiNc1F5vXS6FbYaP9bBcFyVY
         m5sBzf20LQgJ0LKmrX/opqDoJ+qpzpLnEm2RTCEt9ei7DOkXchUloZIpItbE3QbX0P1A
         2lDmmxrSc2zS0EeJpaLJcEqFHroZR9IkNr86dXhk8ZD4r4QKjCxLgEMsq6tI/mpPn75O
         9Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211946; x=1788816746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4dpfyGcHDjDiUcGiLRewZ76d7YjF7miMEuQ8SJeOus=;
        b=XsDtyLgvC0UHpUf4KwVIXVgEjuP++PAB6e4SSZQyeD9HTt5DE1hHiNKyz6pzZ81cIv
         wsli9yqeiXnXQ44v2mItMlhy8QShzdaKk5Rk/P0vTbcqt3VouDkn0GM1cjFt0uyHhXlm
         oFc6D+x4xcyt2NTU/yg0BFE05lzkAltf0L4eH8BOg6Iillkk+Hmeai5Rg0WvxufBaXoL
         +T6xcK8qh5I8bsBSd4Q4ZYaS2vqzGyCpKiutA1bJDiKI4qOjREZ5m47iGlgyCI1SqfIF
         xRyP2ntftteRNuepD50ZCrY2ohSKuHOB3PO2qcjfnF0k32wG5N6Br6UlL9zItR2lK8oV
         OImg==
X-Gm-Message-State: AFuF++lUgCXDUR52iDut0YMrR4bYZ9rS7AcXZU6ZmKesKU0rbnMAxb2F
	W2X2yg7C0f22J0bMfZJSSkxwcWqMkuOP2xUDFDiOxhQt2r1bj+IGtzKNgkAdUw==
X-Gm-Gg: AYBFou3vvI1ATCR0M93aSPzHhgQs+nu5UYl8GXz+0o3+ED3BZGHDyd501MsgxIOG2Gm
	3l+pD6/cGfb2HhMkAcQmD0HYyIbw2bnLCuy3k0yB4fZBHXVZqmBGTTbdE1BjGU7NRI4g0FRPFS6
	89uyPvDyq4PqoK67aHDDwcl6YszG/D8pVmIfIqVvGLuQs4ICuLhIT/gM8JXc79BAOzElNfJ/LA2
	VwpHu5dciU7nDUUfUqn7ABjK7S7leunvy14xIFKEMqVlIBiDVWawtlIXHD+TTJn6oFLZqINTnMl
	ny9v2SXRfi6FmQQCJPXcEmIVN9xAUNfat+lRxr6Ln+rN4OVd+9MlGw/og0nnOcAZ/545hRq2zgu
	2AXj1faUFMJJ0g1OjhLwmlyQ6M52JwtMfy6JKiZfCoDPwf1ZqWtcXz9CtLYmfeVCQLgqjUwV3gZ
	ji3fphrfc6bpW5ZPM8jlD9EAFvb+/Z9FGXC3F7I908t95sxhpyivy+j2yY+oBDj1UUrrsEF2waR
	aR/uX48efq9PHVXQ/v+Cqv/XRkk9aeqAqBg9IohO3LNiljVasIBbpOPzUO4Ijfb
X-Received: by 2002:a05:690c:ec3:b0:809:6b62:2f7a with SMTP id 00721157ae682-85d6a2e0645mr103722737b3.21.1788211946292;
        Mon, 31 Aug 2026 14:32:26 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:25 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 0/6] hardware pacing offload
Date: Mon, 31 Aug 2026 17:26:09 -0400
Message-ID: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add rtnetlink support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details and detailed changelog in the individual patches.

High level changes:
  v6 -> v7
    - Rebase after conflicting patches and more feedback
  v5 -> v6
    - Address substantial opus 5 feedback
  v4 -> v5
    - Rebase + small kdoc fix only
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

NOTE: the idpf patch will have a minor merge conflict with commit
"idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc".
The result should look as in this series.
(https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).

v6: https://lore.kernel.org/netdev/20260813020529.3506539-1-willemdebruijn.kernel@gmail.com/
v5: https://lore.kernel.org/netdev/20260808155217.885299-1-willemdebruijn.kernel@gmail.com/
v4: https://lore.kernel.org/netdev/20260806232913.4020403-1-willemdebruijn.kernel@gmail.com/
v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (6):
  net: rtnetlink: add pacing_offload_horizon attribute to net_device
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |  12 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   6 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  67 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   8 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  60 ++++++-
 include/linux/netdevice.h                     |   4 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  21 +++
 net/sched/sch_fq.c                            |  23 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 159 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  74 +++++++-
 13 files changed, 388 insertions(+), 56 deletions(-)

-- 
2.55.0.897.gb25b4bd76c-goog

