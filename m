Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940A27F017
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753104; cv=none; b=OCjPDzyvs67CaKXBedmmF1D5KQMwhXnSHhPouBvxUmfTJpnOf1zBPj351IkvXD1uD5Cvnt9947aOw0yYny5t62pdqKcq87OXgtQcE+PBTqReM5Ww7a1L9klcmvUUDe6IkYtpi0VBJUhZCn8AMI2CZ59MpkqCsMkEX8H6hNogYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753104; c=relaxed/simple;
	bh=mH9y17pdgx7uaZQ6ETTY6u9ccEEks8qY3xS03nAFffE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amhltPLD5TiCOlhwMO24WF+QMSSL7ZbGasTAc4MmmQPDSFmKUhaKHWIzWcS0vzJWbSrTzkWUxVBTSxYz41fS+7bQTOm8bpOrJ64PBCf7L8csur1hxlIXd75Kh+m0EGg/TtphoTQayyWrNYewqOz6hQxmD7Wiy5XzBycj2I/6BQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmbSTL2k; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmbSTL2k"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e6f2ee60bso49210757b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753102; x=1785357902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=61yMsraG9LFGyeJbG2t8IT8zBbMPaLmE4KF2xUNCs64=;
        b=hmbSTL2kfiJ2YG1NJh8H1D7bAky4cDG7933Rqbou2QHvJ+FjbhezaRVrbpIUvcA7Xm
         jC8/58GAeZ/sob+9AnIu+GYigfwaKqjDWoXqRtPXyIxa8edMw9lZgln7WMcySs+PKvjU
         Gh2bk49VR+XgfEiggGHMaKW3yyeTrxU9xcI+G9XlmUSUJwrGTTtYR1UKZ7V6Z41ZNkdi
         SL3US0cL04eCVU89iSjHFxMB+z4/LzVsfJNHIGLjLog4xfNwYM+UhBwjcSMLGo5T2KlH
         QxToXwzv4VHFv9VWbD+1o1i7JznXx4K4sGbnMg/fGYarsfLGP95ihwfoaKNK/q7HmU0X
         zMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753102; x=1785357902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61yMsraG9LFGyeJbG2t8IT8zBbMPaLmE4KF2xUNCs64=;
        b=XwQV5r4wtGQCD1Y7rCyY3HnN15C5D/pKypJQ6LHodkMmwyHop6rnZ8yXPE0vYtMYM/
         QNUtkgHvT6fkgyav54mGGC4ScVSgdoes2ExqfkleaRee909VwyMdVLDB1p5Asjcc8Rd9
         mpEiazz06g/OM+HZbazyN9COyk+TSUKKVm5VJ3cT5ohZFgFz3j8gOfZvWjZ6cLLYujSz
         Lu0m8AhgEImRPHIh0RqljbAnDLNuWJhJwiZ9UsJcX0H2SGO7m1xgD7ZfmHzq9bw7+vGx
         uqcB4SuGn23tahMQhJCnSKPnvqREdB1exa3YdjiEGsBIcyDLodEL6lWlotb44zaFQgmg
         0mYg==
X-Gm-Message-State: AOJu0Yzk5/NRFXxOz/yUdul1UBVrUyIaQxg25GbaUotKPrthD5SZT6Cy
	ECfqDpgCbt5NrYE2lcmOigWukj36c/d+ud00DthPxv+VpeJ829ru93RdqE10Unuj
X-Gm-Gg: AR+sD12CeHfOno8PT5tYrbiB+KzEn8napIRa/rHuraWAiEriqZsmY7g6ZCk4LocU35b
	TK2PLMSTlPquZUrScCkAIuet2QlQm7cGRnAXPn07JE8uUH70OZW4LM3Bi84rZvrAFCv5zYEl0+1
	wDUSGzC+5vkEQzFBi2p20wtRH3CAEunDrLcaSeJg2TUlHsDcnPosBvBjKgieFk/FuwK+eLu97Qg
	Ef4o+wsTMBrHi/g9LouBxJdWfq08COw+FrWFgy0a5QqexivoiTaKokHWn/ihL4cU47A+9c473rO
	IEy2ePb1yKRlzEuFQIjKIOhx5yARiXCj/AdtpvnIkstzVcsVfa7nBSQhfRzH/zqtuJrdaTlvbpU
	aud4lPiScZBgBu4m+o34wfIaOCPHib4/EmE8J52l0OOq6HsIKo+ptQguJEUu2UFj7yXMEJG4Vsm
	+mtJwpQxyGTsPtrGzLZAIbY0vQofpWUoYFjPBdSRqB3FcIzxLxLrBoEwb7t9uKR0bDoSCPOIcLP
	1G63A==
X-Received: by 2002:a05:690c:6e83:b0:7f0:38f7:6ca6 with SMTP id 00721157ae682-81f3398e120mr16852017b3.5.1784753102015;
        Wed, 22 Jul 2026 13:45:02 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:00 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/7] hardware pacing offload
Date: Wed, 22 Jul 2026 16:43:46 -0400
Message-ID: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add ethtool support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details in the individual patches.

v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (7):
  net: ethtool: add hardware pacing offload support to rings
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload
  net: pktgen: add support for SO_TXTIME

 Documentation/netlink/specs/ethtool.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  65 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 include/linux/ethtool.h                       |   6 +
 include/linux/netdevice.h                     |   6 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   2 +
 net/core/pktgen.c                             |  93 ++++++++++-
 net/core/rtnetlink.c                          |   2 +-
 net/ethtool/common.c                          |   3 +
 net/ethtool/netlink.h                         |   2 +-
 net/ethtool/rings.c                           |  30 +++-
 net/sched/sch_fq.c                            |  21 ++-
 tools/testing/selftests/drivers/net/settings  |   1 +
 .../testing/selftests/drivers/net/so_txtime.c | 147 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  72 ++++++++-
 18 files changed, 408 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/settings

-- 
2.55.0.229.g6434b31f56-goog

