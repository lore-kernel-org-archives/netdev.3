Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7DBA3D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642341; cv=none; b=dS0zNmC0rMBGDYiU5p+hcQ2ONqrE5yVQ4bUqwJrgf9qOdsobTy6fNrydecwV3lEr6sMyP5PZjb2cf4CBgruHRIQJhz4EG4W+/HjZeUdb9N/8Fhuw4hmXNXhcsfucaJo814NNHiX0h9ZR+OnBw+q7kfCWp2wIElBWea823ZDKh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642341; c=relaxed/simple;
	bh=k2SOSA6/EuPDsmN2Ora+h8sIqe3iJaya1h2iAN1tXRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWPuKmI2Bp3StQfAt3nQ8ct3OqVhnGaJUaWbd1nqO11P5mDmPptpTy9R/oC7EQ7kH264Ukkbd7ipO+j0+SWz/DxktwT4xHcwsUHYQFhjgXp0YBOs+9FSr9SZ3MqGL6w03CsU6X0a+c991PbDDehEENsvOOgbyYcBnmtgizt3ySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sh0sUQtc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh0sUQtc"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so478198a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642332; x=1790247132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
        b=sh0sUQtcemk14znTy4WgDBOlHlaHx8j88SF00HJ7UiAkXaCOxLX75uNIL4JO9FWHAO
         5mFHut4/WUfHIZQW1iY2WlcecYrqbe1gjFktaNrhQBTSsp4qD23C7OwkQvdNiaxK9Zf1
         epWo1QjfwCfSBstIAy3qJ6l1k+nCBY/Zmrv25egRyIrUKZ9RT4V9L8GfJYK0kBAb4ACs
         z7tTeMA197/Vt/QRs+NjbHjWcFlUC/BA2Upu+m+bkDV/UYw49c6EVPe1ZgorffWW3qfG
         AC5RI3mzwA8ECbu56e+jAj8dMEOzh3NSm0hWx1zr/gJtNPzaS6n2WoKAfbYS//zR/vH1
         /REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642332; x=1790247132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
        b=NryHQQ8JCeOC191jtNHqJQ8JkASh7kZCV6KEf0BuMyqV8NWDgAmSCf2Zp0Xg2YYzu6
         gcSuAaHQRpsR3ij18cPUOdcXVCuyEuBY7TtLLlC/8vZ5K/ymAKBy0+n/Pu7z9BcU1QFS
         156dYJlQfsJyCBb8U0IoT1d/wVGbafpM+3aRi14/4rmrHRqB8BAAk7rXPm1U1mAuk+VG
         z/U3UbAi7qxg/YuoN+KbPMlIEmyBgC3217tKSEGYaNXDL2K7AhzmmFEgtFmsqZtkSHVI
         dz4AlZ7hsaSAlTrAle2YXU67954vW13nxapA+k0ugQsdeOhz+yPo8e7v0nzIXLPHhDgf
         BdHA==
X-Gm-Message-State: AFuF++nBLKym1HTGKFrm2KYe3wJLDdMgbd5znNHXzT6DZ1W7UmmMtcqw
	/XBem8p9YQ0YhKTujESMUOcarCXYkLjLZ7EZhaj2ZujGLv4V1O9yHGro
X-Gm-Gg: AYBFou35yXVA8sV9fSPjlKRFAImpfSHP0K01xcU8Kb+s722D73MIeSndtRxvtoEEYQZ
	lB9R2E1hca1Q9F0LHC00G03gAVe5pIL8/5oMSzu6aPgtvu9X4tk8QIPKqAz0I/ZvBB2XhDsP6pD
	J+qXqHrCEgAs+ArJwBkJgYvuzAtJzE6nu2mpmvAkPxgmQGV+QVLNz9EI09/G4VLLhzhmel7nw/3
	CEulnO1tLnfJrecSG1J9Dv6n7wPIDK33FEpPjbA/W/Ue1CqtgM2ebfeqewjEtay2m4DS4ect3sH
	7bP5h+1xmMx2UQD45J2vIW4v9TXMMvdRdr5gGspd/N4TWFoNyz6ZxBJ2MLcWuXYlP5FXw90ywrI
	WM5wzN/HrO/q8Q5wPMjHqXCD4xL4rcPZFxm1xwmNUWrRkIeiB88LDqEdI52Y/R7LvVYXTsBr5MK
	agtRi96IoEui8QLimr5tvYGvgtDGpRrS0gi13MvGVxs/eBpdS3iFYxRn8Yc07mMYGdCJulojO3H
	i42rgHX+4UtM93jnqpFYWRuv3zuZvR2kS+a9ESroMGFx9wExaZElmRkoP6C4JN0sMTu5zi6Axks
	fjw=
X-Received: by 2002:a17:90b:4a51:b0:39d:ecb6:8d40 with SMTP id 98e67ed59e1d1-39e1e277458mr13370263a91.4.1789642331967;
        Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b8e1asm4486019a91.12.2026.09.17.03.52.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	emil.s.tantilov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net 0/2] idpf: stop stray device writes after a warm reboot
Date: Thu, 17 Sep 2026 18:52:03 +0800
Message-ID: <20260917105205.37561-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

After a warm reboot with idpf loaded, the device writes SW_MARKER TX
completions to DMA addresses that belong to the previous kernel, about
20 seconds into the next boot. With the IOMMU translating, this shows up
as a burst of F_TRANSLATION faults from the idpf PCI functions on every
such boot. In IOMMU pass-through mode the writes corrupt memory the new
kernel has already reused, and nodes crash in unrelated code (page table
freeing, slab allocation).

The cause is in idpf_shutdown(). Since commit 4c9106f4906a ("idpf: fix
adapter NULL pointer dereference on reboot") it no longer goes through
idpf_remove(), so idpf_vc_core_deinit() shuts the virtchnl transaction
manager down before the vports are torn down. The disable and destroy
messages then fail and the device keeps its queues enabled.

Patch 1 keeps the mailbox up for that teardown unless a hard reset is in
progress or has been detected. Patch 2 restores the function reset that
idpf_remove() performs on exit.

Testing:
- The same two changes, backported to a 6.17 kernel, were run on arm64
  (64K pages) servers with two idpf functions: no stray device writes in
  151 warm reboots (130 in IOMMU pass-through mode with page_poison=1,
  21 with the IOMMU translating), against stray writes after 20 of 20
  warm reboots on an unpatched control node.
- Not covered: restarts after a kernel crash, and a device that cannot
  answer at shutdown; the writes still occur in those cases.
- This series is those changes ported to the dev-queue branch of
  tnguy/net-queue. On this tree it is build-tested only: W=1 builds of
  drivers/net/ethernet/intel/idpf with arm64 defconfig (plus IDPF),
  allmodconfig and allyesconfig, with no warnings. It has not been run
  on hardware on this tree.

An LLM coding assistant helped analyse the crash dumps and fault logs,
locate the shutdown ordering problem, and draft both changes and their
changelogs. Both patches carry an Assisted-by tag.

Tian Xun Ng (2):
  idpf: keep the mailbox up while tearing down vports on shutdown
  idpf: reset the function on shutdown

 drivers/net/ethernet/intel/idpf/idpf_main.c    |  3 +++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)


base-commit: a98bd9f12dc5ed64029d00a8192a28685a54a587
-- 
2.50.1 (Apple Git-155)

