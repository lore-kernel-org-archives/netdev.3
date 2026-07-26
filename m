Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FD1C860A
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097751; cv=none; b=mzF2Gz1mCLXnHDhQdj9lquJxZYtweHl2B2bGpFmkcLbVY9chy84YecbPXLzS4Bk+j0lcM581F9rC0Thcf5BDFtuZCmqxLLpbzkwaLk5ToHc8kulcGvSxMh3YbVuRZ3XPpYe4Ca+rHUVKG/uRfG2855/YGmeZABH8XHYReeuS1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097751; c=relaxed/simple;
	bh=Wx3NQwLKwKmBsPRdNIHZlS4yRqTAuxmhzI7/CHyH31o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmjZkAdE+r3DyZok2QYVOFLQi9raOUhK5qNeHBJIJcTQs/tRUh7w+B69uS0DMnVeH3oJ//etW8jormBhVsg4iJ4Dkyt80EyeMgEC8x/X2li+ltqARGI17qLYISReg8CTMnYTvDx5YgzvZK1mGP3WaFWLOr+LzjKayQ1uhkqcLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0JOT7mO; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0JOT7mO"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6682259cb3dso3090442d50.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097749; x=1785702549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFOa9qPwdvlouljXshYVJZ5Jcrh4fqiX931eWWcq1H4=;
        b=Z0JOT7mOLlSCJYDWdXP0Ea/7AnhA2SMFvu+NItDd5XMJZE2jmVbq5cF2IwAa63VDtK
         FKZDWKwcKgIFZLbpERmxorwLBpqHerYhGGBfI0D6Iwj/2IhV7PfmEkDb77/uGiFtovC6
         /pAUPQMxdDwnTKIHjSmDaeL28MZXGH/bSTodFI3PPSx6GwqLTzilSw2yYRZiP64JYXYc
         dJvpNU178+jwIwWtAhfUMq3n8wVwyihIoTK8pa5lo2mMbGWEyqNkkvZ/HcGpFgkhh0Md
         2h1Ccs2BI8iYg9bsjWq573fimJvZzPQOomUjefzcTDZSXOU1q/PfcxJ91L2h3SxXRWSG
         EIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097749; x=1785702549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFOa9qPwdvlouljXshYVJZ5Jcrh4fqiX931eWWcq1H4=;
        b=TbxvOMtzAZw4qdZoLTD2+Kouolufego1APiOMluSqKzr0W25o+wsFtka3AMCdCrfkt
         8xqAppnumppqlOzkGagpXT4qkwVUSrvjxTLdtX7VfunPHILhv14/ZObgAhksnLQiddAm
         Ft84C6e2M2wswKpRBBC50Ep7D07dq5oz78TvJ2K5RexfMI5Hu6RXTFJoDv9EOHgcWnT/
         MucBcrjEJn5bPYPmQmLF2ekC0Ai/mOmtXO8ZmNElParsrOWkOkcWbtHJwGl8Y1V6hjeU
         1paDrjIga7k2WIVIzEshKZp0tSGKT6EkY79n+40W50IV499t4ZjIGCltRSrJACMgnWP6
         ofEA==
X-Gm-Message-State: AOJu0YzJAokYoK/m0E2QGJ2bPGSA754KhgsQdzVCrpCF6cWvRHt52C/i
	Xod1G9G1SPiEj6UaUKkb6/vzOieHI5fz0ac2BL/YLShdrs222KKqiZCZHI9dyQ==
X-Gm-Gg: AR+sD120pAKUeo130hDqtVt/07YMSpT0EQ2BxmesEwnCLf7t1G/h+VZo0sIO4x4WuhQ
	eybkJKPobLr6+RJMR407LRk7OczcYjh8BWFjSjwi/9klFC/YH9L81cPNgd/OUevMcKdfR1qrJ2z
	BNFq1rVYqt3l1r5ehV6fiafMN6eqHq+JnD5uzTt8+i+RpbKauVGD8jhbkuuy0RsNtpID9zP544O
	g+eI8dBkAnspGHhrIqnsVjSw74QagDos1DKAssE5p5j2Hv9PW9dKjzA8184yPF2bRRFP+6lIRRz
	myghU5mRtCdALKnkjCFNN33MVh66zWxSxEw4VR6sLN0PL6iN/S5Xn0L4CYhUOSvesLDCAcg7TPZ
	fZ2gCVjOzMRQ1whxR6gc74O47ACl6KqUBEhoZIOtNEctITdA/Z7zwSysf4L3Cq6CWte6DDpNSAB
	hocazC11rb8gHr1IGBUe8djPownwYxTwRr1nlX5sJMUHAaglTEbYVG06Kt/7FX7FPYV0s2InZMw
	RBvqVawuak=
X-Received: by 2002:a53:ce83:0:b0:666:2274:f7ae with SMTP id 956f58d0204a3-668bfefb2e0mr1715910d50.45.1785097749289;
        Sun, 26 Jul 2026 13:29:09 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:08 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 0/7] hardware pacing offload
Date: Sun, 26 Jul 2026 16:28:44 -0400
Message-ID: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
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

v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (7):
  net: ethtool: add hardware pacing offload support to rings
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload
  net: pktgen: add support for SO_TXTIME

 Documentation/netlink/specs/ethtool.yaml      |   8 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  69 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 include/linux/ethtool.h                       |   6 +
 include/linux/netdevice.h                     |   6 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   2 +
 net/core/pktgen.c                             |  93 ++++++++++-
 net/core/rtnetlink.c                          |   2 +-
 net/ethtool/common.c                          |   4 +
 net/ethtool/netlink.h                         |   2 +-
 net/ethtool/rings.c                           |  33 +++-
 net/sched/sch_fq.c                            |  22 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 147 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  72 ++++++++-
 17 files changed, 418 insertions(+), 61 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

