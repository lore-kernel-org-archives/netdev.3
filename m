Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F93B47FA
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902497; cv=none; b=qu5L2zVOXFsGIElFBf4sLPDN7DvNNW1pOXXotlaaR8y0JAxRsDARONczICJkNAfs1P0zkk8kiEu1AxztvG9UYwHOqTObiS7MI009mrs/C5V8MhE2xiPrELp1lLJvb5pO1CMpjQeDFxQ5bwh9sYtm/77s2EM8i9LNn5EInz83d+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902497; c=relaxed/simple;
	bh=n0Be36ddKhDCk//9AN4Jf3YbaVHvs4EP8JCDUD3CJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZt5l6Pn9yfiopZvXUbZBKjuVkjjY7ALaua0UIRgFf/+7Lnp2pfx63WZWHft+DxzxM+Ac2R/ea3JaUFJfDv73X3y5Ji3TyOURIpdpIKRIQGZ1YjDsSb+FKDynyfHX7PljQIdkGluKTCoqhuAetmAd1+aB//NIqDB+YKs58281lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4z33yHi; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4z33yHi"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e80579b7dso113782241.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788902494; x=1789507294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/dQygOaKFFI7MqzO8ZJqXyglgwUJKtOP4ihAnFyxvE=;
        b=o4z33yHiyLSKfC3mNgIxrJIIFQrcpBnnQ9nf+IxZgwto5wbUQeAg6/a/42v+N914jo
         n15ArRh1kCuEp2FEenZ7GozNDxZaYlmux4m4EkN9dwgHrujaeYPHeIUB9ukM7UgxWkMG
         OqpQYYVNJZLQl+WjWmo1PhS0T4jDoPvTMvKfLojjNHpnxyRvlJ3nboOwnOJ0RwN93dTa
         oaSwe7onSitS5Y6ISjDQ/qZvwEMUxJzcqX2Q7TvXgbzR9mcDHNnNexLqy06gKsMTF5bq
         LBECXhCz/qG1ma8jPBjd7gzzTgdhghXuYVu8V7r61H5URmFtpLp+tCyVbL2Et5C6Ljfw
         uioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902494; x=1789507294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/dQygOaKFFI7MqzO8ZJqXyglgwUJKtOP4ihAnFyxvE=;
        b=haeeqGIN1NmYW3U3URqf7eTYv8pKO8X4WRSNv+8RmTFxRBLCjCncS5/33+sTp0EdkM
         iQgFpFL/ZEKKkEdX/rrXpxi9EfEUw29KuH7abnysiscCE7DVoSJ8+g90ZVfDuATFWZ/C
         dzp2zDFjEz43XuiD2vjf/SN4i8uou4kYBNZSt4lCbPsBeCljB9QaTkRuaRLCn4iZwv+v
         4KRhezSH+7Nm5HWwhkKQUrnPuePJul/5YNI0l6uh+l0sMJTH44Wqy3DUXdlkv7+9CwAT
         qn26xQACj1aaEvOog9pkFaFcKwI24bwpTjIy9OB+prbSH6Ypn4J/pkQ0vauWxnKTOSb8
         6SFA==
X-Forwarded-Encrypted: i=1; AKwUvBzrXhWHmZlVjQS/Id1N2wLSapnDN/rmWLQf/CYJIY/Yj3pGttRWlkUJze8HWogW3lL5fAWaxjU=@vger.kernel.org
X-Gm-Message-State: AFuF++lGBKesdURNkZxsdPPGvn02aUmYgkhuMwZFCtf2+reTXcpc7SLr
	ZLGsMJOStNt90v+eh7REhw+rctrUExkM4U7fyvGjHnOirNnktDvg3b9G
X-Gm-Gg: AYBFou0FcLA0yNsg71xnLEComk8rfPvlgtFRIv63aKgJmdW4ZBZTKgV56i/esHUXvSp
	IIHJ/pawqz+CPBdSG02ja59+K8dHj0fh3jRxfjDap8ACI5Tn2lpjiA+XRgPapcS7cN8W096NZxM
	ALkm88ooDDzlozJglBRmD+eZtpVsQAsd0SH5HzlkODpDnZdQN3HZuvkEXxGGvtOOLycRDvg2v+P
	nYo55tAavTMqTtjvuu1SKVLALXmj7Zj8wj9YDTDLL75FDccG/AAeIxSDv7r+49w7zIiVVsJDhSY
	BE83c1prkej2wGFFdyadZ3/Eyw+mJXmQ2CgjeoIcHxtttu5GDYtUqvq4sINxXwaHqwa4Ss26RO7
	c37atmfyPRHuhPkpv7LAxxKaz5UkSKoiZHXyKahWRy7ybD+FwyxbkvruJElGk6f0Wa7phJRpqqN
	TaCgQQCvgcodTYGQY+sCuqoKL7BxI6UIAEQnXzSCj/myD9IGYDU+ORQG4cgqznhczWhaT6dhI7V
	1ksd/JtgIu7fqhql5TBvi3yyuBwSczsvepMV48YXJ+Q/MPdilvvQb3Nd5ovzS3m9A==
X-Received: by 2002:a05:6102:3f87:b0:780:7e65:f0ab with SMTP id ada2fe7eead31-78f7380daa6mr871901137.1.1788902494402;
        Tue, 08 Sep 2026 14:21:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47a76aaasm9508030137.3.2026.09.08.14.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:21:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-09-08
Date: Tue,  8 Sep 2026 17:21:27 -0400
Message-ID: <20260908212127.1022197-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-08

for you to fetch changes up to c93922dd316b7273a8667d29084632066fa8a2d3:

  Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset (2026-09-08 17:18:47 -0400)

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
