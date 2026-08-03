Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE483BB669
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800949; cv=none; b=nqp7pTudv+fyAzAL9+CIvi6NcnuheMtUl+7mYXevzm4om66XIf2Ma+s+kjQUVKrXs3StF496y0yhrEhWsYPJOlZwG+GgcLG9F2GfP8XGJUPcUfQS5R3PoUx5wPLoxj6tN418rRlggc0KapQMMH2GdxSrvIJUYmL3642YEmZ6mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800949; c=relaxed/simple;
	bh=Sr8dyV4BUJveQT1PtSWbb9k/q9Iou6el0LuvDx3Kqns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UyLGoIqkD+IZ4nH3QGp/JEqetE7qZ0kCowR58DEYxH2nTuY9OvEwpcaEY2fr/VpdEsvDnqIr3CdPGK37NKHuNKEQzIsJbNs/zfUB0h3lZCY5r8DdH1bqby0Nx8LwAJa+k8NlJmI/7dUPxaYynlXfWoLhbOJWnEE2dOLAILy6HcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tENz1JmI; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tENz1JmI"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ae45c58003so1755969eaf.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800934; x=1786405734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZmRK+kGZ63x1J3SYoJu/ncVhBhHSRqz2+vlZB+kGeKo=;
        b=tENz1JmIKe/yLxC9sWQfIe6MYfzBfVMEDR6NjRpaOhdlJ144T0Zua8WOgU2qZOW3dW
         59ua1f7ELx0zb4trAS2FovGoWFAk2atfTfinjP+z2XYxkfz3gLC5J2IPN2/Z7g2Z3d89
         S6UsFbARV8qNv1LskMB+OR6ShhwSOgHAGHoLma6L58ectr0Yx7vjG3kNdpZnfEs0exb7
         mgAzdSglH7C3gCJAdCwqmCM3zwVLbE0qEAtwuQ2vaVtuccsiykMjHdEajBdiXVqhSMKD
         rzYFRF1XSe84OzyXxWb35fWi+XajlYLRuXp3uKQXWl7DNGQ9XvMI/my3x5DyCWkV4Lm2
         AU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800934; x=1786405734;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZmRK+kGZ63x1J3SYoJu/ncVhBhHSRqz2+vlZB+kGeKo=;
        b=fAhcFdnUOM+o/TcQW11R3AM1BNkkp1XDmvIygvLZM+vt3io8ssgPVW3TS0qeMvC7y7
         w2Ymx+JkBvYkb+AOKq9YCSGc0uUlcmMVv3qnzSkr/B+dXfWAaIZ4/31BrqsLg6YivKjq
         m3ucx+nbCXvBGUxk/E4LvcG/SuGnyOT2deWXOochAyhoaEjTc+v69/m4QlNwz0Q0QUcG
         4tvkbynSQDCkZuo7YTTXzHQzKBrcj0Kv1aNsCUqQPH8UItvF4IJAhruIDsXEY90BKSty
         VZjsNiseKzV8MQyjoMimXiy4YlVKT1gtog4BWsk8EenTDTAO1KhT4hTkJ/LpoZm+Rz1S
         lxxQ==
X-Gm-Message-State: AOJu0YzLJNeH4XNg4mNvOsy1g3+G6CF2Rp8EILvAK1aSf7osGOonax7I
	HFwLULroftGM9IaflvI9XJ3GOYyU38O1DF4vEVilVFPxSsuypv+Kp4Mz
X-Gm-Gg: AR+sD11TcHF5BeMpJeqTpK0x/6aEVf7gA0grt5fUL47GpJeQqhmPlswLwgGhJilnXbl
	W6chc95INTJw+LWUBMfoTFerYK0pWVXb7lK7ePr1onARbtwOcU2rjbZqwR8wYBxpcppDI6eMW/w
	S+oJc2x7ozXTqkNPD1lnxCoj35xCdN90fmr3JoBg1zJX5haqhn5A6eXDVV0Oqbp94bEMNo6Cd3v
	5qMT6l+YPUdPk0m4VOAECf7rUmF6tfIKhiH20KtzKHFO/hesox0IALhVdNNqLLiCyuQAI7FKAyU
	l0yWoSli2o3U0nCPU1f1KpfWzdmWv72pGQyP5yQEw1VNjkJzx1Tw4nzfp72l2rB+HaJ8qtsRv/t
	5DYtsEIZ3N5oeC01ELGFb4UlOZla5v07B17TLPNdCdMhR4Wm0i6Pbcx+u1TYJLBk5+F90UNZj3y
	ATGFOCE1MP6/F6n2hV8osyWRg9QYiewGoWlLCMSuJtA9hASB1+PLxocNgksYRXWPyEr/YtCb496
	Ip4xwoI6phyi5AZ3Tc6N4fv70lLaslj9Tp57LfxGeh2u/sI//kZKTxXrhHbAaX87kv4uiBRQ7y4
	8k/UovoM/+Je+TH4F82k20oz+MHiXqNGjBHS9to91G7NXPSZcV4nmyuH1im4PmqVuY73Acq0yQh
	WmRe02ghOqa2Zy+hh
X-Received: by 2002:a05:6820:4df1:b0:6ae:33fb:4546 with SMTP id 006d021491bc7-6ae432828e6mr18327057eaf.9.1785800934333;
        Mon, 03 Aug 2026 16:48:54 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f60ea539sm10452201fac.8.2026.08.03.16.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:48:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v2 0/3] net: mdio: support dynamic OF device
 changes
Date: Mon, 03 Aug 2026 17:48:09 -0600
Message-Id: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auUWTswRlqMVxEXaTLVETKRJC2V0
 rsbdfnzeN8GhbNwgUu3QeZFiiRtYQ4d+IfTO6OE1mDIDHSmE5Z5jFIxBkmYJgxvdVE8LgYt9QN
 5d+ztaKH9X5knWX/2FZQrKq8Vbv+lMU/29UvDvn8AfQlK64cAAAA=
X-Change-ID: 20260803-submit-mdio-of-dynamic-v2-90560ca159b9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

MDIO buses enumerate firmware children only when the bus is registered. A
later devicetree overlay or status transition is ignored, unlike on I2C and
SPI buses. Supporting live reconfiguration also means that population and
removal can race address scanning, PHY attachment and bus teardown.

Patch 1 factors fixed-address child registration and legacy PHY scanning
into helpers shared by initial and dynamic population.

Patch 2 serializes MDIO device-map changes, reserves addresses while
registration is in progress, and coordinates scans, attachment, removal
and bus teardown. Dynamically removed devices remain pinned until bus
teardown, preserving the borrowed-pointer convention of
mdiobus_get_phy().

Patch 3 adds the OF reconfiguration notifier. It supports fixed-address
PHYs and generic MDIO devices, scanned PHY addresses, and Ethernet PHY
packages. It also preflights overlay removal and rejects removal of
attached or in-flight PHYs before their firmware nodes can disappear.

Build-tested on net-next with arm64 defconfig and x86_64 allmodconfig and
allyesconfig configurations under W=1. No warning was emitted from a
changed file. Runtime-tested on Allwinner H616 hardware with
notifier-driven addition of an AC300 control endpoint at a fixed MDIO
address, 20 relay-driven cold boots, 20 complete MAC/MDIO teardown and
recreation cycles, and link traffic after each topology was populated.

Changes v1 -> v2:
  - split the generic MDIO work from the ACx00 series
  - rebase onto current net-next
  - move touched declarations to function scope for netdev style
  - Link to v1:
    https://patch.msgid.link/20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (3):
      net: mdio: factor out OF child registration helpers
      net: mdio: make device map changes hotplug-safe
      net: mdio: support dynamic OF device changes

 drivers/net/mdio/of_mdio.c          | 508 +++++++++++++++++++++++++++++++++---
 drivers/net/phy/mdio_bus.c          |  14 +-
 drivers/net/phy/mdio_bus_provider.c | 141 +++++++---
 drivers/net/phy/mdio_device.c       | 235 +++++++++++++++--
 drivers/net/phy/phy_device.c        | 102 ++++++--
 drivers/net/phy/phylib-internal.h   |   4 +-
 include/linux/mdio.h                |   6 +
 include/linux/phy.h                 |  18 ++
 8 files changed, 908 insertions(+), 120 deletions(-)
---
base-commit: d661abdc30c254649c32ef6e0aa1e621e04ff0a7
change-id: 20260803-submit-mdio-of-dynamic-v2-90560ca159b9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

