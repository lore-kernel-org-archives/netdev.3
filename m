Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD37B41A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884307; cv=none; b=Fn5p4utgc5evyZjEAnOjoaOORm5qaLM7oKEWuOSpART4hmSvx849sOrq9+2N2d2/rgUldve60mNfSEEYDddX1dy5NYwAHbwprndiNJnEQw9jDlfn0u6+jDSKoC7fr/6TnrZpSyM5QNWJm6kYPVMc5wNUv/Z+DRcGu8jYXF6dQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884307; c=relaxed/simple;
	bh=Y+8lSDEssiHEtct3vm6mBuQ4c6bTHVM2kVdeyUoO3ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eub1uaXD4p9E+Bi/Rif+WIqGECzFGk3oemhPrx3wt2RgYpxhX/bsOJQkMExIrpKLrrmaCh8dTxb0eLA0vABdghQhRtmFMJdcWotqKEapWQSbtBbpXAz5YQQ7YhJfrAsn7yj3MtsAYPdN94g7ZKyfkj/SlezvNygRxXVmJ/E4ZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFJ3ZoIR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFJ3ZoIR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b886fc047d5so772938666b.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884305; x=1772489105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHK+3jyoHNJV2FbjmJS+D8CEWo+rq8MXAjvGR0EeBTw=;
        b=UFJ3ZoIRyv4en2sqprK02oU+yCwWgu6+bDh6CBbhCUhbJP7iLREE+/y//yx1hPguxo
         QNWGv9DRzLapiEAbvRT0ep7E6cBalF3FfgZriUA8o3+oaI2tsnygNBOnDXRRX7shYDvV
         3mhNsV+Ssb+jst/urHnbkEj3W/LbD3WIkTbahym1cP0JOLHxz9cfGkhJtca2Vp3C6Rcb
         pj6rZMF0tQNMujoGmLKfA8euKjXXcbYbLGwbgzxV6lifySYYWZOjrVupoj1nN7hrag5/
         eZwmIPxyKSNuFkHfVrDoGJEuru3guHV9jLCiBsocrRwkvBvFlJEfkrvR+XhgH9lMMweF
         UU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884305; x=1772489105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHK+3jyoHNJV2FbjmJS+D8CEWo+rq8MXAjvGR0EeBTw=;
        b=NfQMfhegbt9eEtofYB/WeTGjyMeFm11eiZ+xl+0O8yaeeKTg8MWZLbjUemIHNdX//r
         eln+NW1ljILlS2zoaI9PlFulTmGm2YjtEomkG+8kz5LaeISGbkVNs8zmW0nz0ZUSPu6a
         PN/OtC4Dxd+yi/3QmRkYSgOCiUR/MtsfqtmKMLRnGEZ2MVVND0UtgQSl8W8HhxBQlMGe
         V33+UB6SWR47Gbkf0u55oOQrrqRFRXoChvN3ZYwupee0zdXOA3kk6HqcDnAFUwE8AIwi
         wt+BINkBFRTnGmYwMW1mPt+3ensi/jrbdE3P4MMY5OE3G4/ktWCSdX0+XF2fSQ6055ER
         xGpA==
X-Forwarded-Encrypted: i=1; AJvYcCVCAASvg5DktNLbS15HxvoOXatGDw3hHPfP6p+mU05jjwqQHC5kGtpJuaAjjH/kK1eBo9NT6fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSv/pkrll53HxR3Rqje2Cfe/c89qckCrTcCXC1Ts5Q0Ei1/Qc
	QDwRKY18tQVvTD6O+t4m18S8Z+ydm8AO4k21Q8Fta/J42gtJrf6G1eER
X-Gm-Gg: AZuq6aLOdRaRKFCTN9WHB6AEhCJIgHuZIbf5bQWOxaShD99uMNhzI5FM3r797t35qCV
	Ag8mqxVr8P4K7fPa2VX9Y5486NZ4QPSPaIu7whSimuJWbtOkP8zgq47Ey9OACrNjTsHt+T2Zx8v
	6F4tpnUpG/ODFBfshgRFfK7SiyEBXCFUvpcJiWJI5cvwKx+3fpBUuJF9gZrcqNJvsLtBSr8Xpag
	m+jf5Dx/Z26HOC6241P6f7Z+uHS4O4nR3Djd2J6gLknyuZSjx+r7TiD3Hqerxa4ddTFOpEWBBwo
	27wBidCKAzGK7hAdUO1HKWDGRB51DdzqrcoTAWIXIU5kkIoaXGYed3+bYPRy8eTL4ljcgysR+zK
	H4GmidRQcosx05Lql1UjufcZ3G5o7+pS8QJyUhBVa3mugRHDTamIOSvdZ4LRq7o26YagAxrwPED
	rvP0VAutGqK+RZ0QeL3AX/fYi9bnktZdtT5BMbtpePZwTrpqw4T+ji1i/YDxcDRYhEvbdG8iqOF
	gJhjAQfRwfwxKeHliZQuIcYU0N2NnujnaOAzC4585cwZN8sZ5RwKDJpxH4buPxz6hiWd44=
X-Received: by 2002:a17:906:66d4:b0:b8e:fb1d:9eba with SMTP id a640c23a62f3a-b9081c1c4c5mr454821166b.54.1771884304829;
        Mon, 23 Feb 2026 14:05:04 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (230.86.12.34.bc.googleusercontent.com. [34.12.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084f191b9sm359394666b.67.2026.02.23.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:05:04 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: add Rust reference driver for ET1011C
Date: Mon, 23 Feb 2026 22:04:59 +0000
Message-ID: <20260223220504.2102-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a Rust reference driver for the LSI ET1011C PHY,
following the pattern established by the existing Rust Asix PHY driver
(ax88796b_rust.rs).

Patch 1 exposes genphy_config_aneg() in the Rust PHY abstraction,
which is needed by PHY drivers that perform custom BMCR configuration
before calling the generic auto-negotiation setup.

Patch 2 adds the Rust ET1011C driver itself, implementing config_aneg
and read_status callbacks. It is a feature-equivalent port of the C
driver at drivers/net/phy/et1011c.c.

Artem Lytkin (2):
  rust: net: phy: expose genphy_config_aneg()
  net: phy: add Rust reference driver for ET1011C

 drivers/net/phy/Kconfig         |  9 +++++
 drivers/net/phy/Makefile        |  6 ++-
 drivers/net/phy/et1011c_rust.rs | 70 +++++++++++++++++++++++++++++++++
 rust/kernel/net/phy.rs          |  9 +++++
 4 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/et1011c_rust.rs

-- 
2.43.0

