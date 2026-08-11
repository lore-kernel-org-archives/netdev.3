Received: from out-2uec-a122.jellyfish.systems (out-2uec-a122.jellyfish.systems [63.250.43.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E042F6F6
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485730; cv=none; b=th5hvStDdVwhFG96tkf0R272CjeyVF4gmrkYoIZGwgchzdXrCObnCsBqNfZDltC6MObaXCRnqcHc9oBv9qASXrbapCk6f6ViipNy8x6nKvy1aRDhKY/GGO2dqcwDbzsWSqi0qWqdumWVKjB48ZtgvkE+o49fOKslBO1EzJ+dAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485730; c=relaxed/simple;
	bh=ztvrrkZPCvbDggAczBJt4Z3LvULEpa3mssQRsxLsEG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8AXQxNZq0ybClRemaQyMud4R0hIKkK1GDQgGBm57tv5m8O93BzTZP3qZOmoiRwV8aKwoFEd9REgIMTRsIMLuHHMUqdLanpqQt6NgNKbv4KlYslTVKX+VEhrF/VcpcotzdgBDhkqsJnAq8wrePWeGM8vthzmHTYiewL8I6wK0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hKQZJ2Jmcz8sWS;
	Tue, 11 Aug 2026 22:01:44 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v5 0/6] nfc: s3fwrn5: support the S3NRN4V variant
Date: Wed, 12 Aug 2026 00:01:29 +0200
Message-ID: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

This adds support for the Samsung S3NRN4V, a later part in the Samsung
NCI NFC controller line the s3fwrn5 driver covers, found e.g. on the
Fairphone 6 (SM7635).

The S3NRN4V differs from the already-supported parts in three ways:
it ships with working firmware, and its bootloader reports a hardware
version the driver has no flash base address for (so the firmware
download step is skipped); it loads its RF calibration data through
a different proprietary command (DUAL_OPTION); and its reference
clock speed is set with the single-byte FW_CFG form the vendor HAL
uses on this generation.

Patches 1-2 are preparatory cleanups from the v2 review; patch 3 adds
the compatible to the binding and documents the PVDD supply; patch 4
makes the driver enable that supply; patch 5 implements the variant;
patch 6 adds the Fairphone 6 board nodes -- included so the hardware
can be tested, per David's v2 request; it depends on patch 3 and is
expected to be picked up via the qcom tree (linux-arm-msm) once the
binding has landed.

Tested on a Fairphone 6 running a milos-mainline kernel: reader mode
polls and reads ISO 14443-4 tags reliably, from a fresh boot and
across driver reloads, with the calibration files present and also
absent (the chip keeps its stored calibration and still reads). The
v5 changes were re-verified on the device: tag reads, with the
version-gate skip taking the restructured exit path. The test kernel
is v7.1.2-based; its net/nfc differs from this base only in the UART
transport (nci/uart.c), which this driver does not use.

David, the calibration scheme follows our v2 exchange: fixed
chip-scoped paths, with a DT table selector deferred until a second
table set exists. If you'd rather have the selector now
(samsung,calibration-variant, or the generic firmware-name), say so
and the next revision will add it.

The two questions we put to Luca in the v2 thread (calibration-table
variance, linux-firmware submission) are still open; nothing here
depends on them.

Changes in v5:
 - Collect Krzysztof's Reviewed-by on patches 1 and 3.
 - Patch 4: drop the redundant regulator-framework sentence from the
   commit message and state why the uart phy is not converted
   (Krzysztof).
 - Patch 5: restructure the exit labels so failures before the
   allocation no longer pass through kvfree(), drop the
   update-announcement print, and log success at dev_dbg() (all
   Krzysztof).
 - Rebase onto the nfc tree's current for-next, which was rebased
   since v4 (the nci parse-hardening and data.c commits v4's cover
   referenced are no longer in for-next after the rebase); patch 1's
   referenced commit id updated to the rebased tree (777fd2dab446,
   was 9739e07fdb29).

Changes in v4 (full list in the lore thread):
 - Drop clk-req-gpios and the driver's clock-gating machinery (A/B
   tested as functionless) and reference the buffer the chip is
   wired to (RPMH_LN_BB_CLK2 -- Luca; verified load-bearing).
 - New patch 4 consuming the binding's pvdd-supply.
 - FW_CFG from the ->init hook and the DUAL_OPTION upload
   version-gated on GET_VER, both matching the vendor stack; board
   DTS style (Konrad).

v4: https://lore.kernel.org/20260807021001.239389-1-jorijnvdgraaf@catcrafts.net
v3: https://lore.kernel.org/20260726222405.153008-1-jorijnvdgraaf@catcrafts.net
v2: https://lore.kernel.org/20260705190621.128257-1-jorijnvdgraaf@catcrafts.net
v1: https://lore.kernel.org/20260703202601.78563-1-jorijnvdgraaf@catcrafts.net

Jorijn van der Graaf (6):
  nfc: s3fwrn5: drop of_match_ptr() from the I2C driver
  nfc: s3fwrn5: use the "s3fwrn5_i2c" string literal directly
  dt-bindings: net: nfc: samsung,s3fwrn5: add the S3NRN4V
  nfc: s3fwrn5: enable the PVDD supply
  nfc: s3fwrn5: support the S3NRN4V variant
  arm64: dts: qcom: milos-fairphone-fp6: Add NFC

 .../bindings/net/nfc/samsung,s3fwrn5.yaml     |  19 +-
 .../boot/dts/qcom/milos-fairphone-fp6.dts     |  33 +++-
 drivers/nfc/s3fwrn5/core.c                    |  34 +++-
 drivers/nfc/s3fwrn5/i2c.c                     |  26 ++-
 drivers/nfc/s3fwrn5/nci.c                     | 178 +++++++++++++++++-
 drivers/nfc/s3fwrn5/nci.h                     |  23 ++-
 drivers/nfc/s3fwrn5/s3fwrn5.h                 |  14 +-
 drivers/nfc/s3fwrn5/uart.c                    |   2 +-
 8 files changed, 313 insertions(+), 16 deletions(-)


base-commit: 9f69d05b5a85c417c73fa2d5c7a2d507ac81cf4b
-- 
2.55.0

