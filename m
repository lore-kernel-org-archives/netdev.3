Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A8470433
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200330; cv=none; b=NOjBf4KUjyDebtbqTQtLdfh+2xc0PRzC3WN5Z1iK0xa7ayVpkFLpDRO3y/zMDOy9ZFG3SvQ+u62lnnSi+1GkWbh2gSdU3H9gCij2OyE4C49Jzb676TrgAc1zePPPVs4RqclJi5slS5z+0q3QHx5VMENfKPDb+Qhz6ciVV1NZg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200330; c=relaxed/simple;
	bh=g6MX+Fm5AEr7O32lbCH8xw6i4PM0zA4dZIAMIDl+8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICiuDvOlSj1jwnS58y3GtwQCdZ7oZm5h3k5rLo3Ke7c1syS8RZjmKqA/n6ChyrsFzI+w5L4mx0G8yW++1/9eN63xmrzYwPpPpj+TUrAqpnTcnjEw69LmRwQbUY/lLDJ2S+23+PLh2h+JG007oEIMg8H+r5RbhyRLKhx+1KJu/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc61FbKK; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc61FbKK"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-783fffcfb96so2038764137.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788200328; x=1788805128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTSkPnLnj+rCK/r3SoMMp8mtUCO8jXcltm+9dQ5/UVo=;
        b=Kc61FbKKD36Q6nCcttRUN0kqMbUg7iIuCuAlpcMGeCPVhg88LcwQ9bF7le/u7RIbI+
         /LzBC76ocHMhWlXOu/u6R0vps5QlbAOj0HUfTTmkKvPVoNuxuyIgT8oo8psMXzP4Dd0n
         ewylsn2hssB19wVOxM0p8+P2wBulKMKmF46W0v0B5rNDbzY6cQnCoc9UFwmMa8v+wVrI
         ieuYfvzw+QEC9YRTtyvGJsiwECEqZDdT7UxlOKzHTtFHyh1Tx30sVvRKkkdSrCCM2Cxw
         POVLLmqvjE+gk99RJeooSLSpCIxnEvagdTzNirDZ1RDlL8UFICOetODnKmuGP50nDOQa
         vzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200328; x=1788805128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTSkPnLnj+rCK/r3SoMMp8mtUCO8jXcltm+9dQ5/UVo=;
        b=Xhd8jhzTqJy8AoOdaWH2LrrkPpPWaHnhjfInoa9pSk50b8DlSxFGPNBTXJf/yfCHr0
         KkF32tGAcINbgbVP21+XmDqRUF/bqA1JVrKgDvIJq5t4k6nM+MSgX5M/PczROJLMr+vN
         7mZmqG26uNloA9+OcHmCebUItk6vc1ExrFhNPch4Ka6xaW2frb2QZlr7z5e6lXsKfAN+
         yQhrYTVag3sjMNKIhXIx51SMi8nKz5dC2dfNs4K8xNtma19VYPPx5083vGQjNyRhBMS0
         CNNLx5fl29EbHd8Tv9EDcdJJb1BPGoCeD5mQlP0SUPKsp3/IyEsHrxJjteWsY+fL1YuU
         1FSg==
X-Forwarded-Encrypted: i=1; AHgh+RrKb9Oi72LMSDHSp0tHpmbNfReLTGFZqyc8w4eZbwijUsDaHE0mBG5V0LaYV5uOiHRYC8J+Lpc=@vger.kernel.org
X-Gm-Message-State: AFuF++lEdt8rCQyIcjAMtSl6c2gyd2XrCrhPSechHmWZAe7UtHASQiDb
	gURWApblOr010371+lEJ0be54yqEubLT497iTjq8bqJl5PPXHPh2F5BxJ5sN2pMQxbR8LA==
X-Gm-Gg: AR+sD13w4fFtIGaIukPXhStR2oIQN5K2N7MFmsiXQzcT4VIUFR4ftQiNQ5/8+mrO5zU
	+jQNJie0jApqEePO9shQSoDNCxMi8MfEZgug0D2sTG+r26/8cQeIVc5N22Sxf0XkdSeonNPBTa3
	tw/OTombhbKe/gdmqs8VU/lnpoPlxTkEyP4IGwH2zUbutYfhC3z2r5mHNuqZ+4AAH6g2RDljUQP
	9WCMTOZBgrzcXgKhExbCe2L86+ISv2xuCoRkLBPb1QnJroFxyesMHn/6iguQUSUAA9El7jsxdIJ
	chg5xphcg54v3Kj7z11E90o08Ho3UFclL1vT5Qya8uv0IfRmQC+blmaqJeNXs/DdOnUqQYDEIq3
	SUL36blwhfWkiUNwTuYqfn+PXYtJwNJizXS1Uux6KONU2PvK2M4r/myp5NnTIwtHK6kE6K3ZPtL
	fIA4hKAHf3MSnZXg46RhePEzch8mU60G5U1HwA0Idtx2LtIwxHQMxi61Fl1a2iMRHej1P4nndOZ
	ikV/RAMinJ7GZK2obGuE/7wH6gSbN82q6WV2RItz5PDiUBl0MAogUI=
X-Received: by 2002:a05:6102:580f:b0:786:c86c:4f5e with SMTP id ada2fe7eead31-786c86c569emr7883170137.3.1788200328011;
        Mon, 31 Aug 2026 11:18:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7893f43666esm4329503137.9.2026.08.31.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:18:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-08-31
Date: Mon, 31 Aug 2026 14:18:37 -0400
Message-ID: <20260831181837.946230-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1376afc7660bad2a1a5ee0876898312a486cf8bd:

  octeontx2-af: fix CN20K default MCAM rule removal on port cleanup (2026-08-31 10:04:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-08-31

for you to fetch changes up to 2deb76c21b81e42b3282224f7dd2046fe73fd1e0:

  Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout() (2026-08-31 14:05:27 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Fix race condition during device registration
 - L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
 - L2CAP: fix out-of-bounds write in l2cap_ecred_connect
 - L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Drivers:

 - hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()
 - btintel_pcie: Clear automask on spurious interrupts
 - btintel: validate version TLV value lengths
 - btintel: bound firmware ID by TLV length
 - btintel: propagate version TLV parsing errors

----------------------------------------------------------------
Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

Kiran K (1):
      Bluetooth: btintel_pcie: Clear automask on spurious interrupts

Laxman Acharya Padhya (3):
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: btintel: bound firmware ID by TLV length
      Bluetooth: btintel: propagate version TLV parsing errors

Pauli Virtanen (3):
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

 drivers/bluetooth/btintel.c      | 44 ++++++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btintel_pcie.c |  3 +++
 drivers/bluetooth/hci_mrvl.c     |  3 +--
 net/bluetooth/hci_core.c         |  4 ++--
 net/bluetooth/l2cap_core.c       | 33 +++++++++++++++++++++++-------
 net/bluetooth/msft.c             |  2 +-
 6 files changed, 73 insertions(+), 16 deletions(-)
