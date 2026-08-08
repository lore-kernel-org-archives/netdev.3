Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED239BA3D
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204361; cv=none; b=KHbnAknF1v59n2t+d2qTv/W4uMacCRLbKLNk0wwiDvONX1rbZt542YeXxy1CzuvXyErWkK9aij8t1PoFtbTFOrteY9ZXG9ES9u1KELL+9fJBaoGMv6fVCSTIqjERkXmuobYZaYOeJMPFInRueYxpjn4sp8B8naid35J3vM3JVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204361; c=relaxed/simple;
	bh=pmkrgEFMwlW10NfSy7U/UKFMiS0k1rJpu5H8jHpbDYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOBqn01Aa5cY6l313GUyr1LrQrXjRKUThybwSEJJZGqeSx+psx2sl6fNRGLtECfIkf+ryjz3BupWVQm/EsyGH8wa3BCQKe/f0quNboaRm2bUc2F0hRNXsAKNfUJqCZ30nWIuG1rz9YcgV5gMAYBgG7GVbFrfTG45Si3OEvVsDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOXPDMCw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOXPDMCw"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e6f2ee60bso43593857b3.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204359; x=1786809159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJjFtGpsZeLNWlPzOVeEhmIhXTVBEh63FbCc6q1Hy8s=;
        b=QOXPDMCwoQmHuL8OgFlAu0brk8BkR7cl3yiyKK3n3w9/5NA7vZPvOBKAmVNbv9yx0L
         cKl1b2NmKcaFrLlIWH2JPQ+Q86OWUj+BvTyns7DXWuRcVyn3nIpSd5Nnw8g4UoHcvKDo
         1+kGdmKikh2Dte4DMtvd8xkZ5FKEr1V3e0QtstS+gvyL7BRK8n4JB1g4buiQ+etn2dZP
         hVpCojKf2Xkm3ut0le9pe+oLqmDAhxA2aoPL6hhXDLslIJ9cnMTlqUxJemKB8J47cwgZ
         WxZNP+nfIc8MYbEs32lQhh2sPDBh2jj1cK0wYLETSLIJfePAGGNzsOLBD5BnSyNUvKP+
         hPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204359; x=1786809159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJjFtGpsZeLNWlPzOVeEhmIhXTVBEh63FbCc6q1Hy8s=;
        b=f5eQwbNaW93HpjbETc0jBu2CONpeaB/1oLVHpA4bSQ9lFAH7aDMHuDyGP3VqiOmLAc
         /5Zvm9UQeZlTIKmDjFn7nD5rqjupF1Ki9UOZC9l21YeBZezYZ0nYk0SJaw55lrPMi5Oe
         acYUUoyAyWi96djY7LQp2JD8/FxFEVIYBm0dsngdlFLhwqRlGFWPq/GntT60cAvny1LG
         /ZWMpkzY23+N80lSer9mns5bdX1TpD7JRC1R/zkKMXx51VIk3BtN+ypnsbY2qAuaAWa3
         HqovVTUtMEX9YQNfDhjhHX5voheIGGIXFwfvHpCN+qNQdxydiun5m7toxNEoiyWGmyN0
         Tacw==
X-Gm-Message-State: AOJu0Yzw3viDK/EA1AgqPPlyj0tUKRyBaATIWt+t7h2NPAXKTPihTtK7
	xyoN9R4zxR27VMQJ+R13ytleZJk0yQ8NSAW4UDnik3F7/UUH2bGUQJh4F/KeeQ==
X-Gm-Gg: AR+sD11kWwMrPF9q8vESBjoUYtkQJLqB6LoHRK10iq5QXO4Rdi2UFZO2QThDFbEqcyW
	idlwuWFlK+/cFh7Oz3I1a9qpqemU8Vuuy9u27uXSVZO9+CTWHtcjszhD7iTLyEwE0WYVbpguCPj
	RqAZdO7EH73lFoRNglnn0dMDVCD3+kBAqmoYAZZNuAH7eh/EE2Ukcbwvi9xl8umLlKseR61oR3f
	8u2ym2Wob1axY1wmy4gp2FoRxTRD5xMUlzD7OQFSevkcz+S//iG7ckt+NAZSliNHF06UDWtns/r
	9WHV+LY/SFAGEYd3ShWqSV69C6VY3y+ZcQRj3rZj/Weupxw6qNuKREXfh1qixZnLUqBSPXvGCL1
	QWltb2IGkUiv1gQ3IfHHDjcwoNYMsmm+SBzBL/TCrKu/aTUToeKjAoo1UClMitooLDDm/FhC8dV
	0FeV4jJR9sNfxZIg1xuwTYAdCcXG2T/J6KOlekOfv1svtNjcwJwWuPvRPWliKfnocq3xO1TqCkD
	sZo1vfPVbTbzho02GKR5StzbKW5xyRBZFCEKco337o458IAO4Uc0Mss0RU=
X-Received: by 2002:a05:690c:4881:b0:80e:dc2:873b with SMTP id 00721157ae682-825eed3b75bmr42159177b3.16.1786204358788;
        Sat, 08 Aug 2026 08:52:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:37 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 0/6] hardware pacing offload
Date: Sat,  8 Aug 2026 11:51:38 -0400
Message-ID: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
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
  v4 -> v5
    - Rebase + small kdoc fix only
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

NOTE: the idpf patch will have a minor merge conflict with commit
"idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc"
(https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).
I expect that this series will need another revision, at which point
that fix will have made its way to net-next. There is also a fix to
so_txtime.py outstanding, but that is structured so that these do not
conflict.

v4: https://lore.kernel.org/netdev/20260806232913.4020403-1-willemdebruijn.kernel@gmail.com/
v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

*** BLURB HERE ***

Willem de Bruijn (6):
  net: rtnetlink: add pacing_offload_horizon attribute to net_device
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  70 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  56 ++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  10 ++
 include/linux/netdevice.h                     |   4 +-
 include/linux/skbuff.h                        |  17 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  21 +++
 net/sched/sch_fq.c                            |  19 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 157 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  75 ++++++++-
 15 files changed, 386 insertions(+), 60 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

