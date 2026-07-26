Received: from MTA-15-3.privateemail.com (mta-15-3.privateemail.com [198.54.122.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044F3E317C;
	Sun, 26 Jul 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104674; cv=none; b=aA63T/W6mp1o/aNORIN83UInzoxtWrFs/e6roYPbUfWTlOV/KAw57L6urhOxIniJNySXvXKH5KCp2lDIJws/mjPD8B5wpzMcL3pqQ5L+LbcU9ZFZinHziW/DGbUxeCuRDrC6B082sMpW6QVbByiW65ICv4hEpbFsgAlAhqw53lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104674; c=relaxed/simple;
	bh=/iQPJn3NQLLdPAX5ZuZSkiPiN+/IQGbQg5FhX6r96GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEO9XRDQ7HdxIcT0x96tpfaSoGGjEFxaGjYOY7ZNqiJSU0yMCk3dIFv8ri0hsjJVS2uvkZML+lANOWQcrEIphdLccWfHq7Y4y6GC3xETWmdUKv8LNk0FziG+clQpFVahS0cLxOsTvX145KFnrpmiWWmfEK4Fy/Ni8yxibyFqWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4h7bqb4dDRz3hhTF;
	Sun, 26 Jul 2026 18:24:11 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] nfc: s3fwrn5: support the S3NRN4V variant
Date: Mon, 27 Jul 2026 00:24:00 +0200
Message-ID: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the Samsung S3NRN4V, a later part in the Samsung
NCI NFC controller line the s3fwrn5 driver covers, found e.g. on the
Fairphone 6 (SM7635).

The S3NRN4V differs from the already-supported parts in three ways: it
ships with working firmware behind a bootloader protocol the driver
does not implement (so firmware download is skipped), it loads its RF
calibration data through a different proprietary command (DUAL_OPTION),
and it gates its reference clock through a CLK_REQ line that the driver
must service for the chip to be able to generate the 13.56 MHz poll
carrier.

Patches 1-2 are preparatory cleanups from the v2 review; patch 3 adds
the compatible and the clk-req-gpios property to the binding; patch 4
implements the variant in the driver; patch 5 adds the Fairphone 6
board nodes (it depends on patch 3 and can equally go through the qcom
tree once the binding has landed).

Tested on a Fairphone 6 running a milos-mainline kernel: reader mode
polls and reads ISO 14443-4 tags reliably, from a fresh boot and across
driver reloads, with the calibration files present at their new path
(load success verified in the log) and also absent (the chip falls back
to its flash defaults and still reads).

Luca, the two questions from the v2 thread (revision/SKU variance of
the calibration tables, linux-firmware submission) are still open;
nothing in this series depends on the answers now that the variant
property is deferred.

The series is based on the nfc tree's for-next.

Changes in v3:
 - Call the DUAL_OPTION payload what it is -- RF calibration data --
   in the driver commit message, comments and log strings (David).
 - Load the calibration files from a chip-scoped directory,
   samsung/s3nrn4v/{hwreg,swreg}.bin, instead of flat
   sec_s3nrn4v_*.bin names (David). The samsung,calibration-variant
   property discussed in the v2 thread is deferred until a device
   actually needs a second set of tables; it can be added compatibly
   on top.
 - Request the calibration files with firmware_request_nowarn(): they
   are optional by design and the driver logs its own warning, the way
   ath10k requests its calibration files.
 - Reword "S3FWRN5-family" in the binding and driver commit messages
   to "a later part in the Samsung (NCI) NFC controller line" (David).
   The binding change is commit-message-only, its content is unchanged
   from v2, so Conor's Acked-by is retained.
 - New patch 1: drop of_match_ptr() so the OF table is referenced in
   every configuration (its __maybe_unused half is already in the nfc
   tree as commit 9739e07fdb29 ("nfc: Drop __maybe_unused from
   of_device_id tables")).
 - New patch 2: spell out the "s3fwrn5_i2c" driver-name string
   (Suggested by David).
 - New patch 5: the Fairphone 6 board nodes, including the
   pvdd-supply the binding marks required for the S3NRN4V.
 - Rebase onto the nfc tree's for-next; the new of_device_id entries
   follow the style of commit 179851e63fde ("nfc: Unify style of
   of_device_id arrays").

Changes in v2:
 - Drop the -i2c bus suffix from the new compatible: it is now plain
   samsung,s3nrn4v (Requested by: Conor Dooley).
 - Close a race in the probe-time CLK_REQ seeding by reading the GPIO
   level under clk_lock, so a stale level can never overwrite a fresher
   state applied by the irq thread (found by the Sashiko AI review of
   v1).
 - Binding completeness: document the PVDD supply (required for the
   S3NRN4V), add an S3NRN4V example exercising the new properties, make
   clk-req-gpios depend on clocks, and describe the CLK_REQ pin in
   hardware terms.
 - Rework the binding commit message: justify the GPIO modelling in
   hardware terms and explain why no fallback compatible applies.
 - Add an s3nrn4v i2c_device_id entry carrying the variant so both
   match paths agree, and describe the of_match_ptr() removal in the
   driver commit message.
 - Reject malformed calibration blobs (word alignment, single-byte
   section index bound) up front instead of failing at STOP_UPDATE.
 - Handle gpiod_get_value_cansleep() failure in the CLK_REQ sync
   instead of treating an error as "clock off".

v2: https://lore.kernel.org/20260705190621.128257-1-jorijnvdgraaf@catcrafts.net
v1: https://lore.kernel.org/20260703202601.78563-1-jorijnvdgraaf@catcrafts.net

Jorijn van der Graaf (5):
  nfc: s3fwrn5: drop of_match_ptr() from the I2C driver
  nfc: s3fwrn5: use the "s3fwrn5_i2c" string literal directly
  dt-bindings: net: nfc: samsung,s3fwrn5: add S3NRN4V and clk-req-gpios
  nfc: s3fwrn5: support the S3NRN4V variant
  arm64: dts: qcom: milos-fairphone-fp6: Add NFC

 .../bindings/net/nfc/samsung,s3fwrn5.yaml     |  65 +++++++-
 .../boot/dts/qcom/milos-fairphone-fp6.dts     |  49 +++++-
 drivers/nfc/s3fwrn5/core.c                    |  41 ++++-
 drivers/nfc/s3fwrn5/i2c.c                     | 142 ++++++++++++++++--
 drivers/nfc/s3fwrn5/nci.c                     | 121 ++++++++++++++-
 drivers/nfc/s3fwrn5/nci.h                     |  32 +++-
 drivers/nfc/s3fwrn5/s3fwrn5.h                 |  15 ++-
 drivers/nfc/s3fwrn5/uart.c                    |   2 +-
 8 files changed, 446 insertions(+), 21 deletions(-)


base-commit: f0054d864e6e734add71e29961f5ae15211ad24d
-- 
2.55.0

