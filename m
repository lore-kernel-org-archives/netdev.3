Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC861354AE3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114467; cv=none; b=nddEEm/DfoIu+iAtMryHKGgDQILHa288/t9Q9rvzeUv/ST/VTLfobsbps4WbF2MvWTBhiSocfZnivXgYLu0+2uez3ulO8Kav6klQxfEczKbgPNHqbfycC631xH71Cz/MF9mZeIMr5dLHKWtMShEJpIA/KuJicHMFG07jsm01OL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114467; c=relaxed/simple;
	bh=f2ejQVxewrDKsob82JgfUlTj3330mYg4KIAMFvIEs7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqytMRjnKoh16eLiSXx71QjWfWioD4mCKjrgvDhF8AxzQwMvHlt9vmmlm1o97dACdxBPi03reKFYidPM5MBGdZZyge8DFXNzWI50tkk7LdB6SMoLWrdIRONgv3xaRuy2DO/AOXh8un8pD+7GigiMFuRL+OWhhquLHgZeNcoIeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDMOhmRA; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDMOhmRA"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59c2a81ca92so4135681e0c.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114465; x=1781719265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGp3yuhK4hPwbgdawSH7Sgib95jVuTbwLXx+HiTWnO4=;
        b=tDMOhmRA60wGFa2dGul9cAL3CSmHaq+Qj5KRV0JX7rf5pyvGR/IMZvBjArynYA4VP3
         1v5bfAlUSQrY14eykI7b4OqG7B2ei5K4/lTvprVQgPo0oHP84KAqnJw2wL775J/wAiJK
         ++GxpknYjDXRbKwdrMCR5KA4ctv+387U7MLOkUTER5VvVBkh1vJtraUuBaJyytvmxD9r
         qMCGTxFot/vqD/rIqf3gc45DNp3o2NnCQrtDeHOiWVUHQpv4r2qovvSoTdy0NmhQL+B3
         ukT6lm7hUPVIHBp4Pj3K2nDdXHkgMo136tP7u6HJFgNyfMvFgcAKq/H/SSW6dqC809Ip
         kWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114465; x=1781719265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGp3yuhK4hPwbgdawSH7Sgib95jVuTbwLXx+HiTWnO4=;
        b=i3xkjVgrMhBJOs2kLQRkg+ddI9KxR33RUwPZptjr/qpf3JbV8NwTadkq1Y1+/Ewq/E
         563ybkA+Tg79DuN9PHFiOE7oBGbcWvFxFmJWEZc13LskYIFsmNQqyBTfxMNLJTej+RXl
         IRRlvO72yPtJgV+UnTBt4opNJFwvtSFzVzKpIdKUi34lwZ8bU+VksN47aOTWjl6jh8Rc
         0pRHJI09mEJWaAaYN4MywGzKkQKntHPNtclk2onEmkP1VjKicMI3k0CCI8vYW9M5sRCC
         QnNjhRMF8nx5U8mCdeBGY7iUD93olAI3+MkTIlykMXFo8XB44Od05qkh9yxVqLw+f09Y
         6xlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Dldl3jz0dylEvWddGY79fwb8q16xFLMDDWCkaiN+BsOU5Twb3FIZjXw3nYefKb1x/lYiNifU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLt4qrrBXb5Mn5owSgSSHOUYXk9CzyuhysBNTAHTrMtI2paf5
	sYUQrSodN3scHwwyjfvdpun66z148UjdvFEQRMzDpmvlUZf6O9810jtAncAW2Y0AgwU=
X-Gm-Gg: Acq92OEX3/vjAOg8tVRwfY5Ei4B+DMZhSQXdGyRyo4zdCoexFPc5yQPH97qXDDM8U0E
	CDzTNQ6BYKZ4HcVvnDnVjzZwyjwWqBQp+afvEDyBJyNIYEHSs6gSXkJcsPmfBZlZhgosOtHsfWQ
	13lBrr2z3ov2GyDKk0kDCAW0krJXEuNTGPgCzTGFyfuwVzYgGNuGC6WhotXOZ6ucC7X2ccl/D95
	xq6/Ibr+6NNA7nb5ynmA67izyo0ua7SR1urYcZTflOG8k771U1S+MMAaNu2tDd4CH103qhQle2R
	hNNF72o+h23hzD05oHaK7W+HNP0mdwKbuMcwrLoXtCKocm8ZAra8fmMqC759eKq2DNgH3yuEwNK
	9ishUlVQMF2ZQZTJptfqC7HaMp4Stal0jtb8F+j54bpIctpCY+E4J9XsaxxiF7rHt1cxf6sWghq
	k1gDa0GEXGyGtngpFuP3YfwIci0vqYlddVWrA2uSJz88WBpPiNGi500rIJ8KKdQreP5+ZOdQfzN
	1jhYDTi8WaCA/RvAmArDFasFUFE
X-Received: by 2002:a05:6122:786:b0:567:4e8a:fb13 with SMTP id 71dfb90a1353d-5ba441ed976mr177164e0c.8.1781114463102;
        Wed, 10 Jun 2026 11:01:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9641414e1d7sm19418359241.12.2026.06.10.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:01:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-06-10
Date: Wed, 10 Jun 2026 14:00:50 -0400
Message-ID: <20260610180050.419401-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 149324fc762c2a7acef9c26790566f81f475e51f:

  Bluetooth: MGMT: Fix backward compatibility with userspace (2026-06-03 11:24:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-10

for you to fetch changes up to f98220e190507d3eb3e02f9a2f20c418c30d04ae:

  Bluetooth: vhci: validate devcoredump state before side effects (2026-06-10 13:51:15 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: Fix UAF in hci_unregister_dev()
 - hci_event: fix simultaneous discovery stuck in FINDING
 - hci: validate codec capability element length
 - eir: Fix stack OOB write when prepending the Flags AD
 - L2CAP: Fix UAF in channel timeout by holding conn ref
 - btusb: fix use-after-free on registration failure
 - btusb: fix use-after-free on marvell probe failure
 - btusb: fix wakeup source leak on probe failure
 - btusb: fix wakeup irq devres lifetime
 - btmtk: fix URB leak in alloc_mtk_intr_urb error path
 - vhci: validate devcoredump state before side effects

----------------------------------------------------------------
Jiajia Liu (1):
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING

Johan Hovold (4):
      Bluetooth: btusb: fix use-after-free on registration failure
      Bluetooth: btusb: fix use-after-free on marvell probe failure
      Bluetooth: btusb: fix wakeup source leak on probe failure
      Bluetooth: btusb: fix wakeup irq devres lifetime

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Marco Elver (1):
      Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

Samuel Moelius (2):
      Bluetooth: hci: validate codec capability element length
      Bluetooth: vhci: validate devcoredump state before side effects

Weiming Shi (1):
      Bluetooth: eir: Fix stack OOB write when prepending the Flags AD

Zhao Dongdong (1):
      Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path

 drivers/bluetooth/btmtk.c     |  4 +++-
 drivers/bluetooth/btusb.c     | 55 ++++++++++++++++++++++++++++++++++---------
 drivers/bluetooth/hci_vhci.c  | 10 ++++++++
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/eir.c           |  8 ++++---
 net/bluetooth/hci_codec.c     |  2 +-
 net/bluetooth/hci_core.c      |  2 ++
 net/bluetooth/hci_event.c     |  7 ++++++
 net/bluetooth/l2cap_core.c    | 34 +++++++++++++++-----------
 9 files changed, 93 insertions(+), 30 deletions(-)
