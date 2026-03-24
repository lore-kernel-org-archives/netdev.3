Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AA37A48B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367594; cv=none; b=L0zyExu2gXCUafADL3Ez18Bht+nQ+/0iYnc2+V2MCpEoMjaN7CHI304jYU/axWucRSdbB5sLNIwe5jLXmr0g0tOPDoMZPkJ7Fj7oMPyYpKLj7hgIOHrKkInNpvUYcJycdZY7JmO7Vd2B9PkXhMyjOfx8CYbbwp5NMg8F0KW8ZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367594; c=relaxed/simple;
	bh=LiIV+5XNglCPPMFa9iO5svn7RW5PZppPVuZK2KTD5ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJWf+EKHw3xCZ5NE6oqHOScY/24Y3r+2RKa2AmMp8NhvNTAS8rOePkApS8bFC9/+KCkwWTPYYdwlrSc/WPbUmMK0imQmglwo1nV2bbrba3CqeffKiKLMjStiWQJ8p3Pmu28TShlbF55b424FhoMVZCsIv/+HLX9pyCwR3q0axFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWCLTzHO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWCLTzHO"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a27bfadca9so6571971e87.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367591; x=1774972391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhxZ2/HJu4L/xAHCzTO17lW76yrB8+9Q275K5Y2NCLM=;
        b=OWCLTzHOWwZYhtGrUxkEwsLwzRb+O1/bvl8BXU75QEcLyjgpJe/hQ5Kq2fGCOVEerV
         dpeR6o/dyrjmhxfO3tnMVqNRwFWctzyb/8apPI7zqeoBL2qxOigKb+EcOU7FjSJvhzQx
         V/aKy5WEVL31xh1DKbIe8E4vNUlA0KmCZRrRbImLWvI1343kkdxlKOgQF+nAy+eUASqd
         5t8Uut9y8IocSoW1HFHhxzUGpoxGy1hE2YYTo6gmJ1zfElDnvFH7vJR1IMWjUWacth1V
         XfXVQZAqUjGaEv7NpHtPDPg35jtOQwBXKSI66pVmXhCkseHTzfXlBEiYTITGa7yUWz28
         zDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367591; x=1774972391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhxZ2/HJu4L/xAHCzTO17lW76yrB8+9Q275K5Y2NCLM=;
        b=QepbV0DsaW5uN+DO6md8DFQu/ttSwiEcsfRIe185Fk9Cw4/2dvJDj/zZ9kmGD0BDOI
         F14ar6u4fXs6XRMQUFoVM/zeNc6UZXZKkKHiw5fT3j7yehTvDV3RC6nQbF9Hojv7dqrR
         KCMuyclpzShOg5adxMI9Y3O1WZnKOwtDD+Ht5MUXKuEAFRqoUb4+VUoGvXaGtFs8nehI
         fK5Y0FVkQzUx6znE8gWaQUeAFV2EvD0QloyRIpQvoZGWk2q3j0rvE5Cy9e+ce4/dMQbH
         x8mhxrZOwkPAOba/+j7EDCC9YbTNiBj0vmXwrFKPaIOdK7LFWBrgGDsNmTPm2d+BKDks
         UlXg==
X-Gm-Message-State: AOJu0YylBS/3y5pMNRJVgvQhTkhXF9KfvVhTRwCh0ydT1SWU95Rx6VjD
	H8WFYiIwvFW1Li1Mm3b+lErX+s8Uq7R+nHNzTF8vpdY/1O9RWBVg/TDwvPHq2lE1
X-Gm-Gg: ATEYQzwvSWFiiAloifc1PiHhmTkTN0mbbcV7yTIkSHaIrPu997Da8MZeczaopxx0SRE
	bz2+El2GyW3PHZTboqjiiwHJ4YGYIwR+/i9Cs3c7bwx/310iGtgHkp+SEQdctdcSqkWSdp5ya3z
	p/hOx8qG8fH2rvR8+0CriIdjUW55YUqgLT6PX9Xx5sVSrTde2qCHO/YvLy4tP6F0TC4y8LzlM0U
	TRq+rMAas6j+fD5Sa7o0uydDTD4gmi5B/ISVs2SEXMH73cO9qUABvfppsZgjNnDpxOLh6233+WF
	oaSmi0VXG304Dt4SRpTEuyLKhlPIapc/LdTedE7m2fMqNQrQn6uMDW2KOGtb1pYFnFWmUO+aZj3
	zwrpDiebMhUM0CR7PsO+fyT2NgoopcBPWh6PS0zbUFZliTzShUs9EDcIJRN4X+Q9KhbwasiA/Ta
	CzqYn20vHFWROy3RTmUHjk4t9od4uroF8oYWiN7HG+ce3tTIaNMz5R7HPO15cO43/IKl3+nowsZ
	4YJ4s1LRoomARcBwA==
X-Received: by 2002:a05:6512:3d10:b0:5a2:851a:264a with SMTP id 2adb3069b0e04-5a29b97ecc8mr7788e87.10.1774367590545;
        Tue, 24 Mar 2026 08:53:10 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa7cd0sm32567841fa.32.2026.03.24.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:53:10 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH net-next v2 0/5] rust: phy: extend abstractions for real-world PHY drivers
Date: Tue, 24 Mar 2026 18:52:44 +0300
Message-ID: <20260324155249.15098-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the Rust PHY abstractions in rust/kernel/net/phy.rs
with features needed to write production-quality Rust PHY drivers, and
adds a Realtek RTL8211F driver as the first user of these APIs.

Patches 1-4 add new Device accessors, register manipulation helpers,
driver callbacks (config_init, read_page/write_page, config_intr,
handle_interrupt), and interrupt support infrastructure.

Patch 5 adds a Rust RTL8211F Gigabit Ethernet PHY driver that exercises
all the new abstractions. The driver implements RGMII delay
configuration, PHY EEE disable, paged register access, and
interrupt-driven link detection. ALDPS, CLKOUT, and WoL are omitted
as they require per-device private data not yet available in the
abstraction. PME interrupts are not handled for the same reason.

config_init was previously proposed in an RFC for the Rockchip PHY
driver [1] but not merged at that time. This series re-introduces it
in a form consistent with the existing vtable infrastructure.

Changes since v1:
  - Added cover letter (Andrew)
  - Fixed Subject prefix to net-next (Andrew)
  - Added RTL8211F driver as API user (Andrew)
  - Fixed rustfmt issues reported by kernel test robot
  - Removed RGMII from interface() doc example (Andrew)

[1] https://lore.kernel.org/lkml/20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de/

Artem Lytkin (5):
  rust: phy: add read-only device field accessors
  rust: phy: add paged register access and bit manipulation helpers
  rust: phy: add config_init, read_page, and write_page callbacks
  rust: phy: add interrupt support
  net: phy: realtek: add Rust RTL8211F PHY driver

 drivers/net/phy/realtek/Kconfig          |  12 ++
 drivers/net/phy/realtek/Makefile         |   1 +
 drivers/net/phy/realtek/rtl8211f_rust.rs | 140 +++++++++++++++++++
 rust/kernel/net/phy.rs                   | 260 +++++++++++++++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 drivers/net/phy/realtek/rtl8211f_rust.rs
