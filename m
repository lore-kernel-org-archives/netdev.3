Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D452ED36
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060316; cv=none; b=IomGaaqbs88gsjTRh0gQ/RLEiHtPHpJx4Jyt8nTjaLfwu8BFo3Evi8vyuo87b7/uIsInnEU47vVYpKcjcoVCoV2tFdEdo76GB3L5RlSx6RKlibCSeIi36MptlM1boE+n5TCVX9xb+evbVJj8i9mp+9F2joeBDcKTie1tN5jMDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060316; c=relaxed/simple;
	bh=+MYsjBwPymBk2yV7jbIwvw2ffBBK5bwONLGkkDiRH4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD2tGpVbG+kCfy9qVEYRdhRLWW3//z7+6zOVz+zxkec/WxheWQi78VAmiXeMRNP2e00c1Y1+FWUzGB9YXELqbZgeUloApN60Q8t2iijGa7VgkmMcOgTo5Mi6LVZstZlFRTSVLECn5ztSiQ4OC7xsSQIUouIKH8hV/vC2hu/y9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InZKIrGj; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InZKIrGj"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66fa10f35caso7631037d50.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060297; x=1789665097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IihmtklcDtSp4Licvqngyw/4kmzQaVFh9jDfLAulLLo=;
        b=InZKIrGjZUNRIXf87R5YVg5PmDdNSQi4y+QCkoaZcmGv9iaT3g/zF1gOrXO6MvpEsa
         ekPEBCnVMrmioywSBNJsVqP/uM8j8RsQaEXRh7vHlnNroWvdyv1P9dCqMcKBQv9DgVKk
         Le8UA4VJWOJC12GwUqysijdn5GwWAer63tD47np0mzc/aiiaCtxBa2hX7IQOuCA9K+Wg
         LYBXfQmW04VyaCfcfz5wyqgqj2QLyGwBNi0s2XhyLWuwttNjLEgqDkS/kOi3WCl9coRH
         g/HOnjvGX3+l0Sp0ypvzCfjuU+4HG2YZ7bmZisobo/yp0Y1Uhumw2iHdUrel9Xa8rBb9
         77iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060297; x=1789665097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IihmtklcDtSp4Licvqngyw/4kmzQaVFh9jDfLAulLLo=;
        b=DzbbX87b4II1wxiiUFrog7G50HK1DgWc0SlMz0X2KBJb9CTThYzhltnXSVOUkydmvq
         Hh3xF4nY0fGIFVkClUnRTwkpAjzrwr130wqo7/zkku0M+DoOz8Ywz3WCEAJ52JD1b279
         StjGih55iCdKuFOJBZ3RTeTyi58mlyrjIfJqnIBthNCBKa4wzLPbI/PMbHY2VTcTK4wG
         jZkpR9uUOKvvq+THT7d7bgqUKcZXqKyglQfDQh4CO7OVMBRtjbBMCs2huz36hbBJwSO9
         atl+HRxb6Lvv4rLffk50WCdUxed4YUQnmyKeHlr+cn68+t1z6kk6WDpyIiZXE3LZwAva
         FWlg==
X-Gm-Message-State: AFuF++nBIEWmYAgWuxiT/G4tDMmre/Z9iTeWf2TzgLDYh/tdewihNNmc
	yUzNblXwuMJBorJLGuBcuwUleZqujEBnZeQKcWN6VzOwxxjn2m7nsDKp0CQ6sw==
X-Gm-Gg: AYBFou1/oMuedwM4Lk7VXDdzxj+fKKWyuncdA3PBSDkPrCljgW6Bs4iSYFcFQqIxQJt
	yLR4JL4SM1iP1GzyHzXDUvOlQXOGZjPHVdFGOV8/dczWfvCEova1hlD1aTQRn0R3OiyoyGc8xcT
	n+mXrxP6AcD/TlA9IcxzXI1ITHXoVmVT0r/+GVNFzNwCn3X27y5AnHCM4KxZDgSi6/WZXB9xNX5
	zykUGR3pE8NaNC6Tbtuw25+oXh/z3yAzQL+/N/Kas4R6Pw8rRX5UXhOYWXZSiZ81k8zqeCXqCE7
	aX2BLB30tAf53SB/hDYO//h09znm+cRG+gGCh1fi6wmRBm9HHopTQKYQyL/nU8kIWkjZtJQrNoI
	wxI3myfq5cIW5zE+Pq2xA4BV4zrsuWWMnVHYTdUmhVUZk09h+E0T9+7Sk8tzZysI/M4GOamQ6UL
	E6q5+d+y5yoHCcOXvtdQlA/gsGitqG7cTMas15FJrLL/5RPUiCFZqewrdHywbl7oBnFYa4lPhap
	VtmUG/JAMFDOGvXQNPN4l6VsnXlcgfsDhJrU0fc7dnr5x7O4Dc6Jrpup07aMAgel3Neb0YwZzQ=
X-Received: by 2002:a05:690e:4514:10b0:66e:4064:7475 with SMTP id 956f58d0204a3-6712451b9a2mr141748d50.1.1789060296632;
        Thu, 10 Sep 2026 10:11:36 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:36 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 0/7] hardware pacing offload
Date: Thu, 10 Sep 2026 13:10:19 -0400
Message-ID: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
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

Details and detailed changelog in the individual patches.

High level changes:
  v8 -> v9
    - graceful fallback to sw pacing if hw pacing becomes unavailable
        - add new FQ patch for this fq_offload_horizon() check
    - simplify dev->pacing_offload_horizon to bool dev->pacing_offload
  v7 -> v8
    - 2 small fixes: unused variable in idpf and new ruff warning in test
  v6 -> v7
    - Rebase onto conflicting patches and address feedback
  v5 -> v6
    - Address substantial opus 5 feedback
  v4 -> v5
    - Rebase + small kdoc fix only
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

v8: https://lore.kernel.org/netdev/20260902181747.2483351-1-willemdebruijn.kernel@gmail.com/
v7: https://lore.kernel.org/netdev/20260831213221.1370774-1-willemdebruijn.kernel@gmail.com/
v6: https://lore.kernel.org/netdev/20260813020529.3506539-1-willemdebruijn.kernel@gmail.com/
v5: https://lore.kernel.org/netdev/20260808155217.885299-1-willemdebruijn.kernel@gmail.com/
v4: https://lore.kernel.org/netdev/20260806232913.4020403-1-willemdebruijn.kernel@gmail.com/
v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/
Willem de Bruijn (7):
  net: rtnetlink: add pacing_offload attribute to net_device
  net_sched: sch_fq: check device pacing offload
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   5 +
 .../networking/net_cachelines/net_device.rst  |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  12 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  19 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  69 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   8 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  60 ++++++-
 include/linux/netdevice.h                     |   2 +
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  22 +++
 net/sched/sch_fq.c                            |  71 ++++++--
 .../testing/selftests/drivers/net/so_txtime.c | 159 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  80 ++++++++-
 13 files changed, 443 insertions(+), 66 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog

