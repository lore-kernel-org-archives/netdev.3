Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992480;
	b=mk5cvtfoUwHnDcpIlSIexcig3q50ADvGHBwDJRJoCywUSmOXdfM2GCg+FeLaVyeVtgis
	 h1yzqDkQdqWEwVBM5snKPK/BRmzmJIeafaCnPhkY5x9did+/m9Ac/QWWjUOiuz4I02AwT
	 lKDcqR8gThPja3/BeD4fdQXOcUAcQMu3iipwJ1+kCEeY51G0vP6bgeTUZSABOyIMvUIwH
	 vpzUoHL2C4DPwDCEq8dOGFgCTbL75CWnaj5bFPVx37Jlfil+/hwo5hctNL4USi2djQa2a
	 TaMtMeto6FMuvmzruZmIQ18RXa/HyShKavMe9It1yiXLOgGN3fAcyz1eUqFAdwBc1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zHhr2ZuKOQTS3oVhgY7/wtWCuYen9Z8I9si9WIJ02xs=;
	b=mVJQM6YMI3hY5XvBGRXHyYkVIXNMXXidPeYGiokWoNaApkElpbiCvLua8slLPav4voQo
	 FjfbMNibt94QLXZRaax3hxnmHAR3mNBLolfU2Vu6gqNVY1jASaKD0lcg5by7kLoRlMV8F
	 XFTDW9alrloxXinDVd06AZ8Zgr7OB/9D44WQqjVOij69oun857hqjmiqah86r/n4RGV/t
	 ZSyJIu5GqV615Yt+jgkNmIwLput5RlA7GDh5D61H0mV5KwUBfhWu7ew0X/972RWyBDRDi
	 m6TNcF9d7UkaAkkume7Vpj7uAZaiJE6BPAcggLO2oo9R/Qu4Vto/Wb4vkrgfKoWKjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Jp4fXsAT;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105A606A331
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6105A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Jp4fXsAT
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so892332a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793992478; x=1794597278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHhr2ZuKOQTS3oVhgY7/wtWCuYen9Z8I9si9WIJ02xs=;
        b=Jp4fXsAT8wSFwYhafgrWnszG/hOU3DU7kjJC59pTLeSxIehqcJ+Ejo4Bc+T8ilzvLj
         ohV1D+CO9EEcBqRj6IX9VEdsRF/Ozdxs3UMqs1zTdZm8cvyyJd7QImrX+/0tMn3sGB3g
         swC5mqadAOVhCTWZ/OoKdGvunyl6wU7rWRrgV4Et1+Dd0TzTLsayE8r/1L7CMgfOqRzn
         vGS3GcRjPYgGHyexFkHMTwr2G/x8MMht+FBAeC2jBQfdsTxAjrGfJoDu3BKnZVG2NizR
         TYXCRrm2oa8YYl7C8tF1ec/E8w/4+0r1PKQMZ0HGvkiamFDAWMZZ6UufdFdIVXFtKBdm
         W/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992478; x=1794597278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHhr2ZuKOQTS3oVhgY7/wtWCuYen9Z8I9si9WIJ02xs=;
        b=SPdOJvJZLneKFL+bmDP/mP3n5p3SW/2oZ+L21FyDChejGn2PE0q12ZGDth1VX1cF74
         6rgVTONzGSnn7A+KZ31wNS2reUrpjVYSJVHkVPV8MnrfL5QPO8+PpyeeQvIYwjAr8L6Q
         BmmboAFkFUq59BbjBQJwOaNCz6Xw0eXe+8mt8/IrKErIb78kB4e5Q1OOreN2VW2H02Rv
         NFlQBQcyvYy994/9DTjwLEZY2sElsw+NNsLGnSAtAO8iaL+iE4HyhCdwfiY9+/aMiGfb
         n5KWtT8hhTi0mduVLblA6qZpKTMYcblP8ha4NrWLCZjrJsZnZk9uAGSH7xWzOCGjylNU
         xCIA==
X-Gm-Message-State: APuU4Z/1c7dd22ilKnTtAzJ2siBIUcppnp19HIuzaFzAMiHDR9vOl03i
	zDf9XVbN+qj9rUv/1FCpmQD9mYa3QGPcmsH5Wh/Wv+ih0KYWYMbJ15aihw3a89v0YFCOaj6GewT
	YvYUF
X-Gm-Gg: AYBFou0V33jcEaJFhZgD8EFXDmvZbcpbOjKxzT8bIijkf4F4zOGo7S2d4QB4lBFZVUF
	4dbyfmmYJOahXjOEVUGo+Gr3zG1X4kGe+lsCOYeqh2kQLG/R2dLoW6IVpmE5Vk31T8f5x0mgy32
	qV0k08sUYAIbgeQy7YScQemG+54ygXQmhwe8aB34TSd++57D0TxJUKNDNZBTMb8/wrZBfUdus3c
	VkHFWsyzhxKEW3zQvEjy3qTmfZBkC50oybiss1EbumDSQ/ERzTbgYD/v4qT0TFXJ27guYUnRBvy
	dVaH+aJsqIFvE7RqSAfRAZrmv542+tTp7n23OJr8E20MITESsBNLoVz92RcJrzkt4r+G2XH/cg6
	6APPADsvjRiU2whoXjFdYJLEYS8/+nsXqSopfIKQu3tHPmwrk45G0qxrYFa6zkEASi1YjezwLbu
	DWN5v7FoK92sht9V+T1LEGBotHR/AhGJip48piQ65MVoUFTuf03RUb4QiexCR9rxX/5zjkK+upd
	ifrw4Eo+1mY1fR7Xr2KqEjmoe7IJNmhyJEGA6vM3tp4fgopvYNoLqvxmTZHxqy4KN0lPx8+kpX6
	fnrAM6xu4ZxCTS68Vxkf2vuksPD2yUXm3Rb67yqs4mA=
X-Received: by 2002:a17:90b:3b52:b0:3ae:8983:4ef8 with SMTP id 98e67ed59e1d1-3b0db6b701amr2004602a91.9.1793992478518;
        Fri, 06 Nov 2026 11:14:38 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c3db1sm97167a91.4.2026.11.06.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:14:37 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [PATCH net v5 0/4] bnxt_en: Make RING FREE more robust
Date: Fri,  6 Nov 2026 11:14:16 -0800
Message-ID: <20261106191423.4194081-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This is a follow up to the previous RFC (linked below).

On two production systems, I saw the following dmesg pattern:

  NETDEV WATCHDOG: transmit queue 0 timed out 6073 ms
  Resp cmpl intr err msg: 0x51                  x20
  hwrm_ring_free type 1 failed                  x12
  hwrm_ring_free type 2 failed                  x8
  AMD-Vi: IO_PAGE_FAULT  x3

This suggests that, for some currently unknown reason, TX completions stall
and the netdev watchdog fires. The driver asks FW to free the rings, this
times out, but the driver ignores the possible failure and frees ring memory.
Since the FW didn't respond to the ring free command, it is possible that the
FW is still DMAing to the memory which was freed.

Since the RFCv4, I found a third system that hit this repeatedly:

  NETDEV WATCHDOG: CPU: 35: transmit queue 0 timed out 5459 ms
  hwrm_ring_free type 1 failed. rc:fffffff0 err:0    x64
  hwrm_ring_free type 2 failed. rc:fffffff0 err:0    x32
  hwrm_ring_free type 0 failed. rc:fffffffb err:1    x64
  hwrm_ring_alloc type 1 failed. rc:ffffffe4 err:4
  hwrm_ring_free type 1 failed. rc:fffffff0 err:0    x44
  Abandoning msg {0x51 0x3e35} len: 0 due to firmware status: 0x408100
  nic open fail (rc: fffffffb)
  DMAR: [DMA Write NO_PASID] Request device [47:00.0] fault addr
  0xffffa07ef000 [fault reason 0x05] PTE Write access is not set

This case differs from the first two in a few ways, but this series would have
still helped:

 - The ring frees fail on the close path and again on the error path of
   the reopen (bnxt_init_chip()), and the device then writes to memory the
   driver has already unmapped. The series stops DMA on both paths.

 - The interface came back up later, the watchdog fired again, and the
   cycle started over. The host logged 79 DMAR write faults in about 20
   hours. Patch 4 breaks this loop by refusing to reopen after DMA has
   been stopped.

 - The firmware answers each RING_FREE about 5 seconds late, after the
   driver has given up, and finally reports an error in its health
   register. Patch 2 does not treat these late responses as success because
   their sequence ids do not match.

In this most recent case, I suspect the hardware is faulty, but the driver
shouldn't hand memory back to the system while the device could still write to
it.

In all of the above cases, the IOMMU caught the error. If the system had no
IOMMU or the IOMMU was in passthrough mode, data corruption or crash would
have occurred.

In the future, this could possibly be extended to make recovery automatic.

Thanks,
Joe

v5:
 - Switched from RFC to actual submission
 - Patch 4 updated to use an un-used bit to make backporting easier.

v4: https://lore.kernel.org/netdev/20260925174404.2789072-1-joe@dama.to/
  - No changes to patch 1 or 2
  - Patch 3: reworded the message logged when DMA is stopped, a rebind is
    what recovers the device, not a firmware reset. No functional change.
  - Patch 4 added which adds a new bit (BNXT_STATE_DMA_STOPPED) that is set
    when DMA is disabled. When this bit is set, the device requires user
    intervention to bring back up.

v3: https://lore.kernel.org/netdev/20260923210744.3406861-1-joe@dama.to/
  - No changes to patch 1
  - Patch 2: Don't poll for the valid bit as Michael suggested.
  - Patch 3: bnxt_hwrm_ring_free now returns -EIO instead of stopping the
    device, so the remaining resources can be freed and the remaining commands
    can be sent before stopping the device, as Michael suggested. Note the
    switch to using pci_clear_master in this patch instead of
    pci_disable_device. This was done so that the normal shutdown paths can
    call pci_disable_device without generating a warning.

v2: https://lore.kernel.org/netdev/20260922182405.1290749-1-joe@dama.to/
  - No changes to patch 1
  - Patch 2 from v1 dropped
  - Patch 2 in the v2 now checks the response and logs state before giving up
  - Patch 3 in the v2 disables the device to stop DMA before freeing ring
    memory

RFCv1: https://lore.kernel.org/netdev/20260917233218.1160001-1-joe@dama.to/


Joe Damato (4):
  bnxt_en: return the RING_FREE status to callers
  bnxt_en: check HWRM response if completion never arrives
  bnxt_en: stop DMA before releasing rings the firmware did not free
  bnxt_en: refuse to open a device with stopped DMA

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 122 ++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    |  33 ++++-
 3 files changed, 115 insertions(+), 41 deletions(-)


base-commit: 19a227903e65c7a9c179156485660a4e017575fe
-- 
2.53.0-Meta

