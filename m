Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C434D2EC3
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500297; cv=none; b=Ahp5KW0wgBbOyrXhnjZZcKUqxADn79YD8m24qJUZj5fbO9zwrBsfR1NPS/05wb9/40dLv6ODxeU4KBoyp+NKX4tmSvcYLF6erFx0btdUUMH2wy0t+s2dsL/0hktewSP6E5cmT9lrn/bRprQi3VZXt8Wh8mM2cnPIiAoOqd6zfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500297; c=relaxed/simple;
	bh=9bHaq52+LNuWMhtyY2yvMcwuGO77VgXguJIzqI3vybI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bT5U3KjHwvEBAS9AdqKiwaaIix/EiAiPftYUQOJSIw6qp9BkPV+BipyWOKwKaZTQyA5LkiCcnrdI3DxnaP8EhLjlIdIU2LhqomekAwuANmy6YXGu4qESNdU4UAaulLpmsntedk6U2riC0VzR9sb1RgVuPxB9rz/VMDsDvjJtHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsbQEKYK; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsbQEKYK"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e9af41731so42610241.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789500291; x=1790105091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hq+Kkm/TimJDkxPPQ14NOEWXj4ICc2WmuYGKUmYgsP8=;
        b=CsbQEKYK8ig+fCQWYGr4iU84KmWqbVVb+m8eAE0Nu0773ZW6wwf5KHb8upgd3T+FyC
         hFXd5Mool0Fjl8NA/8xMdC17QfDwG+N5vXiv5HNRbQM6537ULSviDCHiXyr4DjbMVOZ8
         kPFSa7iYcukJpvU0tFng1AGtCdzNiINOnEbVJ9mSD6IkZ1Cp+R93HHsU4+u6HmxZRtgU
         kPu8qUkZsLMucQpUcjqzisJGxyrippojq2IMoCxgwt81UBdTFrbavhJ8agy7Z6UWMzAx
         Lzph4xy3BzUOuOiLUMWVyD++HcdzJ1EvFBW1ei8PR0exN8o9maIVj+ue6+Gjwo85CSiZ
         Q3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500291; x=1790105091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hq+Kkm/TimJDkxPPQ14NOEWXj4ICc2WmuYGKUmYgsP8=;
        b=FB3laM0DZPOzdSvySpMDhfF9XH+lUhbCMKnhPSwqC5IeMqPLkU4A3HxIw1x07xGkwS
         kMOnKHCpThindj6eLSK6w7wvTCUWIABb3a9TS6t9E2Q8MIU+DK1b16LZwmgba3aDlJHH
         ttihOS+Xei4L+UqpF+p2OwOlW2LWk04TTYyAQ7g3xPUml60T5/L0B60FTlbQnOODT02P
         5PGIjlOlGwdrMqHg8lrrqZZinPE5+DuKloC2JVtKOvx+kEdwqknoMniU19ZzE/q2uHhM
         nR7Qw3EdC7Y5LmYzyauzTVt542H6sEBSzPzu8fmEDllUzSTp7xhH0PoxIuMEdzmHKxRB
         0GzA==
X-Forwarded-Encrypted: i=1; AKwUvBx9BC54Vei88e/AwnbFRNe0OqEm6/qdAVJ6Krw6Hi1jx8ldnE/KPWpA3n4+HmFiInBFitz7k48=@vger.kernel.org
X-Gm-Message-State: AFuF++mMarfQ996Eaee5xQtF3ui0r/13qxnGmTiJ3oXVvR1ZD+5Gkpf5
	AtmxspZHIrbmLoVnqMUw/zzkFWXZJYt4Ia4ri7Y5cnjVhjOZQd1zwdsUzNeuWLpg
X-Gm-Gg: AYBFou2/LedYzOQuTkPlRX721NIxvrdDcqrcLLDQ3otViKKUai3wBr/2WSFQe13Roox
	sjR7DNwySxHdBRRwbKwKvjhVSqWouoN+jkKJ3IvANb929PbN6+9jnbFxtqHwA0vJEHL0BniVI7f
	dUyLhl1JfQVLdWljCWhdX8yariYnWZTdyEuKGOmvUpxQcBCOL2yQOQNQzrD/GvFvhwrioyugnuO
	egNVVsm8JMQiY9vR5jdqyB3d6b0a8V+uQZ/dSnK3NuU+xOxbtjmFEteKKjIIvBwTaKHCHXLr4TH
	YRhOihtmxzV/7FAZrfMrtbEdoGUFSsMJV1XZ7DDn8ivS9S3Vuf2cggHJGaCLNhUT7JJgJxlnDmV
	A9VrJV5JjBt+VRv+ksh3MEWWL9zxeTipBbjyr+PC9kww03TE7HssWCmJeIOzenDJgAweHsMlcdg
	bYxzkdp2eztM7jvBigkkB3gvFvdUf98UnqkmDvaHYt1hQbm41WjwJZ36MJE0LX7odNVa4RWxAWC
	Bho9alHOCEsakdOafAplDQPfe1YGE5UgnpuijILvQ0eU5Noiz44L0gvCKA7RNFrCA==
X-Received: by 2002:a05:6102:510b:b0:789:100e:3d1b with SMTP id ada2fe7eead31-79b51c82460mr3594256137.0.1789500290673;
        Tue, 15 Sep 2026 12:24:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9831526cf4fsm409743241.11.2026.09.15.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:24:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-09-15
Date: Tue, 15 Sep 2026 15:24:41 -0400
Message-ID: <20260915192441.1130583-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 83a945a529d6e002dd7339c532288a931f463dba:

  tcp: do not let tcp_rmem be set below 4096 (2026-09-15 15:21:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-15

for you to fetch changes up to 801fb950cae7048eb7d83b18857d1ca37b8cd5a4:

  Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup (2026-09-15 14:55:41 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci: put the peer's on-air address on air when we cannot resolve
 - hci: keep dst_type with dst when reusing an LE connection
 - hci_core: Fix queuing tx_work after workqueue is drained
 - hci_sync: Serialize local codec list cleanup
 - hci_codec: validate vendor codec count length
 - eir: validate service data length before reading UUID
 - RFCOMM: avoid socket lock inversion in listener cleanup
 - ISO: Fix parent socket leak in iso_conn_ready()
 - ISO: set BT_LISTEN before requesting a BIG sync
 - coredump: Quiesce dump work on unregister

Drivers:

 - btintel_pcie: validate TX skb length in send_sync
 - btmtk: fix wrong status for short WMT FUNC_CTRL events
 - btmtksdio, btmtkuart: validate WMT event length before struct access
 - hci_qca: Do not write to the serial port after it is closed
 - btusb: fix NXP IW610 composite device handling
 - btintel_pcie: fix off-by-one bounds check in RX submit
 - btmtksdio: Fix PM runtime reference leak in shutdown

----------------------------------------------------------------
Aamir Ahmed (1):
      Bluetooth: eir: validate service data length before reading UUID

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: validate TX skb length in send_sync

Chengfeng Ye (1):
      Bluetooth: hci_sync: Serialize local codec list cleanup

Chris Lu (2):
      Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
      Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access

Ibrahim Abdelkader (1):
      Bluetooth: hci_qca: Do not write to the serial port after it is closed

Juan Perdomo (1):
      Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

Laxman Acharya Padhya (1):
      Bluetooth: hci_codec: validate vendor codec count length

Luiz Augusto von Dentz (2):
      Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
      Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Radek Podgorny (2):
      Bluetooth: put the peer's on-air address on air when we cannot resolve
      Bluetooth: keep dst_type with dst when reusing an LE connection

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit

ThangNN99 (1):
      Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained

Tzung-Bi Shih (1):
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown

Weiming Shi (1):
      Bluetooth: coredump: Quiesce dump work on unregister

 drivers/bluetooth/btintel_pcie.c |  8 ++++-
 drivers/bluetooth/btmtk.c        |  7 ++++-
 drivers/bluetooth/btmtksdio.c    | 24 ++++++++++++---
 drivers/bluetooth/btmtkuart.c    | 20 ++++++++++++-
 drivers/bluetooth/btusb.c        | 17 +++++++++++
 drivers/bluetooth/hci_qca.c      | 14 ++++++---
 include/net/bluetooth/coredump.h |  2 ++
 net/bluetooth/coredump.c         | 65 +++++++++++++++++++++++++++-------------
 net/bluetooth/eir.c              | 10 ++++++-
 net/bluetooth/hci_codec.c        | 36 +++++++++++-----------
 net/bluetooth/hci_conn.c         | 21 +++++++++++++
 net/bluetooth/hci_core.c         | 18 +++++++++--
 net/bluetooth/hci_sync.c         |  2 ++
 net/bluetooth/iso.c              | 53 +++++++++++++++++++++++++-------
 net/bluetooth/rfcomm/sock.c      | 13 ++++++--
 15 files changed, 242 insertions(+), 68 deletions(-)
