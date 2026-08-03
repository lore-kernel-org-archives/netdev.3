Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB342E8E6
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790220; cv=none; b=OA5yv6Ty2Ej8ZfbGW7ofYpNJ3BnOLWDiQeBACzefIscxAle7z23NgD9B82T8HNoMcwJAE7MLgIYWv9zrEMUUhwgUJ3+oB3YurHmPqBhvNbq/ClkNegF0oA7dL0rQfva9Fuv+HJ4Pxq4VS5w8uRGCsak0Tauklr9Ybpbavq9bs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790220; c=relaxed/simple;
	bh=wZ1N2REpOJJNPxLZ9GguARRcKMAl5kI4U1va3fafSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcWQIKr7QkjtUV8hZ6xb8KgaMWaujh/0SfpU6bn12fZ4hOgdEJQtg/h6zU4TdmRaiHXTULca9uxO1yerGU89dVoVU49vmOggI/2wXCVOXPFy73djBtzjfGiioXxy4McQ23swTxlc7k2D0QK5hFBenG9M2h672RNwEYq/HOw7b48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3Poe6/S; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3Poe6/S"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e7109321dso2240633a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790218; x=1786395018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gsxiDzL0I01ABFBzvuI/N7g4tWws5xrBk47m3Bu1XsM=;
        b=d3Poe6/SCVzVH66b7Ra8rqXkXtBg2L3xIicd6+NbV+9zhx4TRLixENlkFBPUiHp3Wi
         NoRPQice2O5wcxd0Y7sCpubqlu80zrBCK+Qt2Lmt6I/yq3GpoBVZX4Gck3f00ROfRRdl
         ay7MQNZjevt5zOlrqGWsnywXYpuXjz2FzZ5kOYRa9Kvq22eHx+hboqq7bkWWR4Y7rgrz
         kq6RaoUcG8e9UOC+f3vlVaAiK6bkcmC8YsfLkwysD/fVbZKWL4HHLEw6fhSyFzE1P3fF
         istdpNUCUZc5M56AIcBzXSKHpp1tshpRtEIZgZk43cHYgCGh0cbDRhEYoKZZM7XeZjj/
         g/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790218; x=1786395018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsxiDzL0I01ABFBzvuI/N7g4tWws5xrBk47m3Bu1XsM=;
        b=I/ZLR/+zJO38q6fsISTZ+qNds42v+ip3YEjvLoh0halZ6nZRyYpA982loauh61MAMD
         JYz+GLtaMChnABQozzNnRj6GsyO/0o5IQZHjNju7ojL/v1LKiVhF0iqSAYX23bjBDUOJ
         5uh37V1dpuxQCSsw30ij3sDg5+4WFBUm7ZX8h/oL1s3j/58Za5KFr1LDjOC26LJOopQ9
         5fOiX6bJlyJR17FngmOFfU5hynibw24PzKa3B0fjzoDh2XGB4SztCoyxscuItIhNwUgV
         qWdaNpbs93dzv7X1dugo3bdZ22nIJ5Lyt6zzpHbEtLyEd3+p10uwgTh0b0xOvuOF3kZd
         r5+w==
X-Forwarded-Encrypted: i=1; AHgh+Rq6EUBH6zGKDrJyVJTUja0WX3wzcGufQAF7jEK7H84b/q/QnbaMcPYIigbvDfz/Qzb419vO++M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnM2APBw9WZzzdxBq3xrGPerur7xQxQiMcPn2Qy2QGxdXpnwjL
	ZN4mOxT2WY0CXWp70Xs0zwDispe2hydWxDvQZ9ChVEwOvY9P3lhY2A8K
X-Gm-Gg: AR+sD12qfutjrR9QRG+HI6slijfn/KA3RAktAyrp7IjeBZBhlUOLk3WTLTBwat/XGXZ
	gTb4tI2mrzs2ZNamFapildqyFnvd2zT/gmdq02+56D9TPSkELMM3Ij8PFoLRyxtiHZ1R+2Hl0xv
	HxSDNoCdxr3YYB1pH0YwVsgRPvi5AkgBCR7+qxVK5Tq/bO9sJCq2eyhurxBLd2Lew5EwS5mLlab
	3z7hPxPpEI6IxaF1Tdhkx8F32a1H7eEA3asVsm4rJ8dygRv+HXCeCG4THMahV+oI0MwRkaj/PeI
	Wc7TkgjXmKJPOteo2r/YbiW6ACz5/3dMLILvgSqW+vzjKbbAUT3yhMMh/TYlF5ELzZHvFsLWSYQ
	5ml9MR//P2qZz/SvUEo4/gEBjC+SZSq2piukj3tWSaQEqIK1/uhOWQoI458inwEsF56TA+Qpg2x
	xRMN+JoJSTAtmOn6FUkEFgg/crH8fLuf3ZjOLRv6EMaovs7EUhp7Z0CD5pecYx+RV4zjJBswDQI
	d+Y+ng=
X-Received: by 2002:a17:90b:4a42:b0:38e:3a8:2374 with SMTP id 98e67ed59e1d1-38fbc51610emr9556132a91.30.1785790217545;
        Mon, 03 Aug 2026 13:50:17 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:16 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 0/6] ptp: ocp: Add R4006 and V9 I2C peripheral support
Date: Mon,  3 Aug 2026 13:50:05 -0700
Message-ID: <20260803205011.1249-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R4006 and Time Card V9 place an I2C mux behind the FPGA XIIC
controller. The current ptp_ocp driver exposes the root adapter but does
not describe the peripherals behind the mux.

This series adds the generic infrastructure and board profiles needed
for existing subsystem drivers to bind to those peripherals:

  1. A binding for the Lumissil IS32FL3207 18-channel LED controller.
  2. An IS32FL3207 LED class driver with individual and multicolor LED
     support and per-output current limits.
  3. Software-node propagation from an I2C mux to its channel adapters.
  4. Validation of the fixed-width EEPROM board identifier.
  5. An R4006 profile for its sensors and GNSS/SMA LEDs.
  6. A Time Card V9 profile for its BME280, BNO055, GNSS1, GNSS2, and
     four SMA LEDs.

Profile selection is deliberately fail-closed. PCI IDs are shared by
multiple PCB revisions, so only a validated EEPROM board identifier may
select a topology. Erased, malformed, and unknown identifiers leave the
downstream devices unconfigured. R4006 identifiers are matched by their
R4006 prefix, while Time Card V9 requires the exact "TIMECARD-V9"
identifier.

The R4006 BNO08x is intentionally not instantiated because no upstream
driver exists for it. LED status policy remains in userspace; this
series exposes standard multicolor LED class devices.

The EEPROM validation patch fixes a pre-existing out-of-bounds string
read and carries Fixes and stable trailers. It is included because safe
board identification is a prerequisite for the profiles. That patch can
travel separately through the net tree if preferred.

Validation performed:

  - dt_binding_check, including YAML lint and example compilation
  - x86-64 and arm64 W=1 builds of the modified driver objects
  - strict checkpatch and git diff --check
  - R4006 addresses and LED routing exercised with the downstream
    implementation
  - Time Card V9 BME280, BNO055, mux, and LED-controller addresses
    verified directly on hardware

The complete upstream series has not yet been boot-tested on an R4006.
The V9 test card has an erased EEPROM and was intentionally left
unchanged, so automatic V9 profile selection was not exercised. Its LED
controller responded, but the outputs reported open-load status on that
board, so physical LED illumination could not be validated. The test
distribution also lacked the BME280 and BNO055 modules.

Questions for this RFC:

  - Should IS32FL3207 remain a standalone multicolor driver, or be
    integrated into the existing is31fl32xx driver?
  - Is assigning software-node channel children in the generic I2C mux
    core the preferred representation for PCI-card mux topologies?
  - Should net-next carry the complete series after DT, LED, and I2C
    review, or should the prerequisite patches travel separately?

Changes since RFC v1:

  - Correct the documented PWM resolution and support standard LED
    startup and retained-shutdown state properties.
  - Use a named I2C ID initializer and fix MAINTAINERS ordering.
  - Move EEPROM validation into a separate prerequisite fix.
  - Select profiles only from validated EEPROM identifiers.
  - Rework the R4006 implementation into reusable board profiles.
  - Bound asynchronous retries and serialize topology population with
    controller and mux driver bind/unbind.
  - Avoid repeated managed allocations during retry.
  - Add the Time Card V9 profile, including the second GNSS LED.
  - Leave the I2C mux software-node propagation patch unchanged.

RFC v1:
  https://lore.kernel.org/r/cover.1785684064.git.ahmadexp@gmail.com/

Ahmad Byagowi (6):
  dt-bindings: leds: Add IS32FL3207 controller
  leds: rgb: Add IS32FL3207 controller driver
  i2c: mux: Propagate software nodes to channel adapters
  ptp: ocp: Validate EEPROM board IDs
  ptp: ocp: Add R4006 I2C peripheral topology
  ptp: ocp: Add Time Card V9 I2C peripheral topology

 .../bindings/leds/issi,is32fl3207.yaml        | 208 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/i2c-mux.c                         |  55 ++
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-is32fl3207.c            | 580 ++++++++++++
 drivers/ptp/ptp_ocp.c                         | 871 +++++++++++++++++-
 7 files changed, 1687 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
 create mode 100644 drivers/leds/rgb/leds-is32fl3207.c


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.50.1 (Apple Git-155)
