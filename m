Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F83C4542
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818083; cv=none; b=RKvbAxK6zCbiJapDSZNTDujHnBVKYMgW3EGDPKEVe58ADi5sxIUEaCiS95Nrhj0HZyDdtwXPBHtS+Zacc3WB/8rpRz3JGqfwCStOMKIdoSGOos6fmjMuYYC6naOI0cXd/rFyAyD0wnMbKqmzy7gUDtXqquTxXnDhjoZHTFCjpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818083; c=relaxed/simple;
	bh=N2ns42t2lkowA7Fk1OVBdhHQEf1nFZ75mrokscC9jI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAPx5iSSw9hkbTfXpHkfI2/WJXLG5ost5sjravB8ZcQ9vspUoXUHAsaGVdVE0ywtK5GlU489cs3CFain0dKqFoeRemR5Xw0yKKxa4uim+ufWM94fKP2qPfxIyOQHFEcKuRN0QVSu7uhXM46t1vRtumsFxatglJpt82h8EiB2gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESc7aepS; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESc7aepS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8706dfdcd4fso48824477b3.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818081; x=1789422881; darn=vger.kernel.org;
        h=content-transfer-encoding:f:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
        b=ESc7aepSBuly/9ppsfLYBRYJLWl3bY6U3Zqi8NERXRZXHTQtkmGORKatwI9JFWodCT
         Jr2Upbd6VVDQnbKS2KEl5dDCWsTK7KmSNUi0u0yO9qqpIvtEEt4I3c9lVTF+NT7Y/hte
         ypD97wM1OKM3oE2v3b64UPmW7wUc6HuxTurJaqolOZ3ulgLDMqfwu0yly09DormaVeIW
         6UmuFZqQIC/anicxTFgsVJRT3iFJ4QMpqQE7lvu7DlDIhTMWRxE0PoQryv2K0VzakQ8Z
         OZrhwaDI3b3kR633Qp6SmeuupwQkm5/h76TC5KzPQxN0fyNOnkcBcPMSUv7gqCehx+TZ
         sKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818081; x=1789422881;
        h=content-transfer-encoding:f:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
        b=Xp4lmOAbANVz+LZXfnzkEPBJTNNcJCasURp1SfPtpJ2Zhq1jzF9SF3YruHNOYWvLGZ
         Lu076pwsTRCIL4WNzH/KJEAikJ6VuaoULINyPLTMi9h7nRkkCqnJYMIqpL703MGt5YLY
         0m0c3bwObWCbD5tN/aKsaIm6gpRcvbggClWluhdPxJX4UGF2yT97lTrfHr+nkIK/czhK
         Z+PkOPC71KEXosd0iXnu2gH2AtkB6o609ZNrmjmJkwPRmRcjhRcSBs+nv+485AGJqaGx
         5LP98YCfFMD59z+OyliAuOf6vxvW/S/v5a8muMmzk0mRXZVw1iwTtCY3MyqcW4UhHLly
         vUkQ==
X-Forwarded-Encrypted: i=1; AKwUvByoHavpB8Z8lh2YCyqoo4tVX1qlGHUqYIzoUY3ytdoHvxJmRA+Q0w8xCSKTk2SOXj1d5NL60Ww=@vger.kernel.org
X-Gm-Message-State: AFuF++moilkkQpfb7FGW5MFplTvXF8cB+GtrsvEYuCk2KeoLQGhomg6D
	z+QDo7Lr1lgKazCNzr+Pfz9ySoRP1FQMLEWwuqwc7jUWuPlSJbNOYphH
X-Gm-Gg: AYBFou3iPGGgFsuEllQNSNfUP4BdJRQzqD60Ah/KyZjkqFL6ZWTiJLr4KeqlbZIokNG
	CbXHPZm6Dh27SuCb76BT/MPrv26t43FAddbB9nBWyTLdD58LBnsDo1cZ6GIFVLCv6j7mFieUfsy
	a1Z92Oicoj+Mq2ENHyGOjKjLXTUjJNhBCVGzjXNUbepCZgYK3yiR42AAT0kxsgQZYw8AXi4LHnJ
	m8ThF+b58zA7kHSzG7glxzh6I6YZPuwpPrPD5zp8Jao8VYENBiKKAJbNykK2lQ6xFvn8W+6MrIv
	3BQivZNxaZDy6cyuAgieoe+Eg3JvUAEtUJe9/LioVav17Bz9XfjAcprTbNXEXPngSMk/575f58t
	Ymvc2DivjHti4HtxhhG8Ah5QO9jZvEcraBLc2F9wV2rWl1HjG5hbyVMaQ8hSJg1X8KSKtOgF0nA
	iQ+qtZgOad7FUvHJW0upwIDT6HZO673JWzcLDCH9zoBBoBBmmx+hSzYGT95EjVmrDJnd5Yv/Kk6
	jbOJCES69e38631TQ==
X-Received: by 2002:a05:690c:c509:b0:873:5bb2:6c21 with SMTP id 00721157ae682-8735bb26f1emr64757207b3.40.1788818081486;
        Mon, 07 Sep 2026 14:54:41 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493168dasm78139017b3.11.2026.09.07.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:41 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/9] linkmode: better use bitmap API
Date: Mon,  7 Sep 2026 17:54:29 -0400
Message-ID: <20260907215439.409858-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
F:	include/linux/linkmode.h
Content-Transfer-Encoding: 8bit

Several linkmode users discard the return value of bitmap_and() and
then call linkmode_empty() on the result. Propagate the return value
through linkmode_and() and use it to avoid redundant bitmap scans.

Add bitmap_and_and() and bitmap_and_andnot() for callers that combine
three masks. The new helpers perform the operation and emptiness check
in a single pass.

Yury Norov (9):
  bitmap: add bitmap_and_and() and bitmap_and_andnot()
  linkmode: make linkmode_and() return boolean
  net: amd: xgbe: use linkmode_and() return value in
    xgbe_set_link_ksettings()
  ixgbe: use linkmode_and() return value in ixgbe_get_eee_fw()
  net: phy: use linkmode_and() return value in
    genphy_c45_eee_is_active()
  net: avoid copies before linkmode_and()
  net: phy: use linkmode operation return values in phy_device.c
  r8152: use linkmode_and_and() in EEE checks
  MAINTAINERS: co-maintain linkmode.h under BITMAP

 MAINTAINERS                                   |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  9 ++-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  5 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  3 +-
 drivers/net/phy/phy-c45.c                     |  3 +-
 drivers/net/phy/phy.c                         |  7 +-
 drivers/net/phy/phy_device.c                  | 14 ++--
 drivers/net/usb/r8152.c                       | 10 +--
 include/linux/bitmap.h                        | 32 ++++++++
 include/linux/linkmode.h                      | 21 ++++-
 lib/bitmap.c                                  | 46 ++++++++---
 lib/test_bitmap.c                             | 78 +++++++++++++++++++
 12 files changed, 188 insertions(+), 41 deletions(-)

-- 
2.53.0

