Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609251E44B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802018; cv=none; b=lUTJy+aRHSLaPdeUY63uaoXRTWyFNiZxy9u5R8GdS/eBCRVy740biUF2ISncCDof3qI6+smb0WNmW6auBNW5MbJKoUg0GHWmHcV9FAUk6+RwPv2Zrwo6RVhv0KeLRpPH9tPXLDow3Cu0/X5ljW+HaY29ppnfWy18riIlQ7uQzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802018; c=relaxed/simple;
	bh=02qaJEwVgTIqA4K8p/BTonU2DB7NC6EVGzLYjbxtdUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cor9ne3M6VLCKk0dog5cFZ3sjheuefVPW+CN72jDnvYTchdii8b4RRvSyf5Kq/F1AWJZoqlscxYGZ6Lm4ANYHQMu2WqQ9RVyyYPUB+3x2TusLWrW6t1q3cO/a2UrvgiGIvrZdMl1NoNf4FZDeoumENV3gLGIJL6yFqSGX3lDBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0tUoLhw; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0tUoLhw"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-78a338fe106so3500034137.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788802016; x=1789406816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXd7v2Ygni0i6U7y+pmnE/Fo/s2IHHa5Wom3Hs7W14k=;
        b=N0tUoLhw51+XM3ffY46NaIqbPVpXAXNtpp0XCsYvM2Bg8UTXO9bd8Vz3LAIQktelJE
         qrGO1kMw7w3ofut7SZ1JNPIsSnudovLXmLs16lJqKVpSH7Ez9G7NADgAfHMLTL54Jzj0
         /wDHk30BceDulSJPMpWZiEdtkKIOruzALgx3LNqMahRORrXBI9XU4ftEiKJ9/kCxul1F
         LioHRilnxi5YEctjxggUBPdWPzwE/DFD/Btqh6UatuNftP50FFNDMLHGCVuyjQmePGa7
         +iZVtJAvI65GAXzsblq5FZHj+ZG+6FWIIsDw18CNbrBngspeH00tqo6rjcrptQhui3gK
         figw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788802016; x=1789406816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXd7v2Ygni0i6U7y+pmnE/Fo/s2IHHa5Wom3Hs7W14k=;
        b=O9ypKAYkdinRnWaWtT2keCaNYawX+UfUXbXy0oceeBmHoGG7mVzzJyLwirave0pDOc
         kADlVsujtW+uxBEsBH3J12xqLJJKVsNHinFBdlnSRSqMtvgGearUsFbmACXK2tEq82ip
         Qejh2cDNYEuOk8Ulx5LMY5ormDT9yoeiOWQ+qE/ZJvq95IA/DaFtV/5OwtLSOHQwEe/F
         LMAXif3PgU6t+7VsF9kyhe5quONsMb0l7s6dxKL4e4S/h4qG9ptuImcigRYrmXUzoSZV
         OscUdHk+sileKO/SPypSEnPyf6F6eaNTZKQR0Xh+PxvzvEdu4soLUCspB5VisaZb5THw
         HUeQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0m3Dwe6R57dKzBKP5BYGoeplm7TxQ+6Fj6U7uu35wxC4X2Iswq+T6WODa6gMXwkND5ZJoLhY=@vger.kernel.org
X-Gm-Message-State: AFuF++k6IzlemCpRaLZbalpIbo9iqX43bcpW3PgMwn7sAFBpHCNfuvPX
	INvPGUCaW2uWz/37hg0iyBSfShkzCw3U0MnoM8XAeer0M5JR/3NEtIMMqZeh8RRm
X-Gm-Gg: AYBFou0uRbE2945pYdCm7OPFN65EFUhjgMgnANMoBUcde6cLbAo8IcPgIWOHsSu4V5T
	7d1f6gmiyF7vNJlbzwmrj+EqK6M1qdRywPuPHyzXS4dYgYTcl59FcBL/6G6GHHI2TR4nwRzRddf
	RXwz4Dc7HHWDEKcaobeelFCiEo/5hrYjzO8emfFzsVOKi6j8oBs/NbtVQQgchIDdunOLmjS2w9/
	MEdXDaWVB2LtB6bcZUlbcELzryb4D/HJW9kaHVtDgKkF28Mgk2wSOLcgCmDbpdclEmbs7oP4OcD
	GasoiXgy/CdBdPubsfD8wEeSPYer/R2Z6jGCTdtj0toFcasG5kRI2czbIM8zpYQmiJH36UGhPYl
	wCck/DL1UQodXwW5NB7RdiyMg3COuQ25pOQnfkBozD9Syjq1QUzMhlXN0mPDe+P6vj0Dm0nxhx9
	OxxbEd/2CCOjBOUKDn+ZtzNVRAtRZHQR5025SLYSseuJUyUkcBuA3frTNIk/QwNyez1Ogmd/GIZ
	hg+dEu+A0tf3aale88+xTH5ExnjxcBPdoUTrMGDvRrKtG7XdqrNZb/AaXR+5+NN7w==
X-Received: by 2002:a05:6102:30c6:20b0:780:c9c:bfcd with SMTP id ada2fe7eead31-78a2f00e2a9mr5595522137.17.1788802015660;
        Mon, 07 Sep 2026 10:26:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980d774ad5dsm855190241.9.2026.09.07.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:26:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-09-07
Date: Mon,  7 Sep 2026 13:26:48 -0400
Message-ID: <20260907172648.457103-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 38b6be101006d3e7af972999f45d4f1e8250587a:

  net: macb: fix NULL pointer dereference on unbind with fixed-link (2026-09-05 13:58:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-07

for you to fetch changes up to 3ffa1008d5018a15163938fa54a99284bbde1c31:

  Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset (2026-09-07 13:13:49 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_sysfs: Fix NULL pointer dereference in device_del()
 - hci_sync: Fix not setting CE length properly
 - btqcomsmd: destroy RPMsg endpoints before freeing hci_dev

Drivers:

 - btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
 - btusb: mediatek: Fix leaked runtime PM reference in reset
 - btusb: Fix leaked runtime PM reference in btusb_reset
 - btusb: Fix UAF of btusb_data by rx_work
 - btusb: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
 - btintel_pcie: validate packet_len before skb_put_data
 - btintel_pcie: fix tx_handle bounds off-by-one
 - btrtl: Don't leak return code when parsing firmware format v2

----------------------------------------------------------------
Ivan Hu (1):
      Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware

Jiajia Liu (2):
      Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
      Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset

Kiran K (2):
      Bluetooth: btintel_pcie: validate packet_len before skb_put_data
      Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one

Krystian Kaniewski (1):
      Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()

Luiz Augusto von Dentz (2):
      Bluetooth: btusb: Fix UAF of btusb_data by rx_work
      Bluetooth: hci_sync: Fix not setting CE length properly

Rong Zhang (2):
      Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
      Bluetooth: btrtl: Don't leak return code when parsing firmware format v2

Xu Rao (1):
      Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev

 drivers/bluetooth/btintel_pcie.c |   6 ++-
 drivers/bluetooth/btmtk.c        |  11 +---
 drivers/bluetooth/btmtk.h        |   1 +
 drivers/bluetooth/btqcomsmd.c    |   6 ++-
 drivers/bluetooth/btrtl.c        |   5 +-
 drivers/bluetooth/btusb.c        | 105 +++++++++++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c         |  38 +++++++++++++-
 net/bluetooth/hci_sysfs.c        |  17 ++++++-
 8 files changed, 159 insertions(+), 30 deletions(-)
