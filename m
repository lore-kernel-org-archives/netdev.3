Received: from out-2z4y-a131.jellyfish.systems (out-2z4y-a131.jellyfish.systems [198.54.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858A156C6A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068962; cv=none; b=ZeWxfyOGShZu1NAz03TBhYpztbjGOXSOlmTR055WyJJhYnmctCl6+uj7L7eZAvYCElUG29uLAhKYWKLRRpJe+le0On5LYTm8B3V1HFytH4UUdLBygrtzk47I5a1ztfqjZnM4ShbxilykxpXm4N9LLMQnRFw4W50C61f0TD1g99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068962; c=relaxed/simple;
	bh=J6FogH5i499lOIL5Kq+DCw2l3mIPyXEqJA2ZRS9XqH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goZmP/ZGVjEd6umE2X3kuNbFHGi5X1JFM+SKyWrzesvWN4TCP8OT0IvI+tTFC3T8znI+3JW2JOk6dsU+2lXc/wDI6ZQOyMdu/Xi05n3aUg/SlHb8ur0ACbjqZMnOTsp9nJroE/X3tk0Rs4W57TM60op2STQ23dfb7XHQosoO5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hGSKw3ZYmz2x99;
	Fri, 07 Aug 2026 02:10:44 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v4 0/6] nfc: s3fwrn5: support the S3NRN4V variant
Date: Fri,  7 Aug 2026 04:09:55 +0200
Message-ID: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
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
absent (the chip keeps its stored calibration and still reads).
The v4 driver and board nodes were re-verified the same way. The
test kernel is v7.1.2-based and predates this base's net/nfc/nci
fixes: response/notification parse hardening (rsp.c, ntf.c) and a
data-completion race fix (data.c), none changing behaviour for
well-formed traffic; the rest of the delta (a conn-close leak fix
for dynamic NCI connections this driver never creates, LLCP,
nfc-digital, the UART transport) is off the NCI/I2C path this
driver uses.

Luca, you were right about the clock: the schematic net into the
chip's XI is PMK_CLK7_LN_NFC. On your "always on anyways" half: not
quite, but not simply our vote either -- v3 voted RPMH_RF_CLK2 and
still read tags, and only with no clocks property at all does the
chip stop activating tags. A clock vote is required; what keeps
that buffer running when the vote names a different clock is not
something we have identified. RPMH_LN_BB_CLK2 is independently
sufficient on hardware. The two questions from the v2 thread
(calibration-table variance, linux-firmware submission) are still
open; nothing here depends on them.

David, the calibration scheme follows our v2 exchange: fixed
chip-scoped paths, with a DT table selector deferred until a second
table set exists. If you'd rather have the selector now
(samsung,calibration-variant, or the generic firmware-name), say so
and v5 will add it.

The series is based on the nfc tree's for-next.

Changes in v4:
 - Drop the clk-req-gpios property and the driver's clock-gating
   machinery: on-device A/B testing showed the machinery has no
   effect -- the chip reads tags with the clock gated on CLK_REQ,
   with it left always-on, and with the CLK_REQ pad described in
   pinctrl or left undescribed. The S3NRN4V uses the existing
   always-on clock path.
 - Drop Conor's Acked-by on the binding patch: clk-req-gpios, its
   dependencies clause and the S3NRN4V example are gone (rationale in
   that patch's notes).
 - Reference the buffer the chip is wired to: RPMH_LN_BB_CLK2, not
   RPMH_RF_CLK2 (Luca); verified on hardware that the reference is
   load-bearing (no clocks reference -> no tag activation).
 - New patch 4: enable the PVDD supply, before any pin or clock of
   the chip is touched, so the property the binding requires is
   actually consumed (flagged by the Sashiko AI review of v3).
 - Send FW_CFG from the ->init hook, before CORE_RESET, matching the
   vendor stack's ordering (v3 wrongly called ->setup the earliest
   hook available); verified on hardware that the command is
   required (without it the chip stops answering RF_DISCOVER and
   never reads a tag).
 - Allocate the merged calibration stream with kvmalloc(); reject an
   empty blob pair up front. Abort the update session if a section
   transfer fails, and version-gate the upload on DUAL_OPTION
   GET_VER -- both as the vendor stack does.
 - Declare the calibration blobs with MODULE_FIRMWARE(); log an
   actual calibration update at dev_info, like the legacy path.
 - Correct why the firmware download is skipped: the bootloader does
   answer GET_BOOTINFO, but reports a hardware version the driver
   has no flash base address for (v1-v3 said the bootloader protocol
   was unimplemented; tested).
 - State what the FW_CFG selector means: the vendor's own test tool
   decodes 0x11 as the 19.2 MHz reference (v3 called the encoding
   undocumented).
 - Board DTS style (Konrad): interrupts-extended, grouped -gpios
   properties, one nfc-default-state with per-function sub-nodes, and
   the two node comments dropped -- their surviving substance is in
   the commit message, the CLK_REQ half retired with the machinery
   (also Luca).

Changes in v3 (full list in the lore thread):
 - Calibration data handling reworked per David's review: chip-scoped
   samsung/s3nrn4v/{hwreg,swreg}.bin paths, "RF calibration data"
   naming, firmware_request_nowarn(), calibration-variant property
   deferred until a device needs a second table set.
 - New patches 1-2 (of_match_ptr drop, driver-name string literal),
   new board DTS patch; rebased onto the nfc tree's for-next.

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
 drivers/nfc/s3fwrn5/nci.c                     | 179 +++++++++++++++++-
 drivers/nfc/s3fwrn5/nci.h                     |  23 ++-
 drivers/nfc/s3fwrn5/s3fwrn5.h                 |  14 +-
 drivers/nfc/s3fwrn5/uart.c                    |   2 +-
 8 files changed, 314 insertions(+), 16 deletions(-)


base-commit: f0054d864e6e734add71e29961f5ae15211ad24d
-- 
2.55.0

