Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261194;
	b=ophNzuIuVgKi2n1MLgS/n/YX5j1rJCgnDis2U4hLuo+JVbciJ8EaWrEbQaCHjH1LrcCZ
	 mF1oKbhk1G1WGIyXnN075azwdkbL4nm2S5o05iV23I3wUD+L4rRQ4IS+FC3StuSkYLZ3i
	 G5OakTIMl9GiRPBdf7lTAvxiCeGa4w9s88J7/Hj1va24SOrzE72B4csoAMALwZE/f0FWu
	 icu/594fMQNHrL75XbXVaKGaT34+zQCcLv3pNMp6iYekz4NvFAg3V0i+N6EijcPqr6Yx0
	 i/YOEe0f/5ixcs7e+GbFMLX9U2Tz2HJZ97+FuCRiaojRaavfUl9LRNiJJBXVY7+b3LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261194;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=/tYKCvUDpneuK6FPNTGWTD3OkVsIaVbYK3p4JHt9LJo=;
	b=l2/rE8H0vVDWDCxen5YFMN5XIGgkDLRnR0PZr+dlUq0AGNoyprZexb/QEXmljkDn4MnA
	 nXsuwMM5CO8fknawwttE76FzDMEUn3Cxnz2KgRmEVG1+VjP8MF6/555m9Suke/RzzAGVc
	 SU1bIGz/sDzyIRpFRIWYXbsYndesCO4sTpWswNPJSNMDx0V8dNpYXwhhx9kALhIFJ1kaD
	 6V74ziyJ1J3XoCi/SzXlLaTKxxsAcFaAETTPDaGZYjdfFyXThwc7HZgVp3a28y2m6yIM9
	 j4LMMG7GDMd5k3NV8KZ9MH6gYO7qHq9E7TGFPdPZ+wtociKUjc30Q01CIcasxFXLfOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=tHECXazi;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6868606A321;
	Mon,  9 Nov 2026 21:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6868606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=tHECXazi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15ECBA1574;
	Mon, 09 Nov 2026 22:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794261189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/tYKCvUDpneuK6FPNTGWTD3OkVsIaVbYK3p4JHt9LJo=;
	b=tHECXaziiu+NMhha5P7NxShwABIXC01OE+S4/N2ey6zIHzxU0pOCL7iAyXKIvNr1SInzll
	StdF3v6MFURrPWUp53D1P8Pm44y1XAEEVvBWfzdGN2agwPMVYXQ8s5DqEp8/0m/jRE95yG
	Pwtn92/or4YIT1FG2cTFFRkYtmLvxexmM9emHD8ud7auM7Vy1WeUPUIsoFYI0B9i9itGYN
	NWFAj5T06VSk92QSWPDl4QNhHJl/9CJvnKrPI7mBfMH8D3lsk/YAFAd43Z52nso5rfu0Ee
	HfBP9V5B5dd2D1i+k4SSBzpZKLFROxXenx1tokZUIYIbd7npzPkiBRMZKhTmQQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2 0/2] net: bcmgenet: fix tx stalls on 32 descriptor
 rings
Date: Mon, 09 Nov 2026 22:53:00 +0100
Message-Id: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RhaoBhX3sOwoHSAMaZgWwmGc
 HdbPIDLN/P+/xt4ckwertkGjhb2PNkI8pRBN7Z2IGQTGWQulRC5QqtxIEsBw/rCMD4NJqD8osp
 eFpWREmJ2dtTzevTeIQrQ/I7+rR/UhdSYtJF9mNznWF/EIf8ZWgQKrAqt206Vta7FLfDM6XU2B
 M2+718zqunR0wAAAA==
X-Change-ID: 20261106-nb-genet-txq-thld-net-e0864f235d22
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Found this while fixing the clashiko findings on v6 of my MTU series. After
those fixes this bug would be easier to hit. At the moment it needs a larger
CONFIG_MAX_SKB_FRAGS than the default.

Queues 1 to 4 hold 32 descriptors, which is less than the Tx path assumes
in two places with CONFIG_MAX_SKB_FRAGS >= 31.

The wake threshold wants MAX_SKB_FRAGS + 1 free descriptors, which is not
possible on these rings. Therefore the queue stops on the first packet
without any recovery.

Same situation for the admission check, which wants one descriptor more than
the frame needs. As a result a 31 fragment frame is refused, even if the
ring is empty.

Patch 1 caps the threshold, patch 2 flattens those frames.

Patch 1 was tested on a Raspberry Pi CM4 (BCM2711, genet v5). The 31 fragment
case was flagged by Clashiko in v1 and seems reasonable.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v2:
- New patch 2 for the admission check (clashiko)
- Link to v1: https://patch.msgid.link/20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de

Patch 2 could also clear NETIF_F_SG in ndo_features_check like bnge does. I
kept it in xmit because the limit is the ring size.

To: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Nicolai Buchwitz (2):
      net: bcmgenet: cap the Tx queue threshold at the ring size
      net: bcmgenet: flatten frames that cannot fit the ring

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 22 ++++++++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)
---
base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
change-id: 20261106-nb-genet-txq-thld-net-e0864f235d22

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

