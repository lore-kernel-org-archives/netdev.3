Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409668;
	b=ra6hqelMDYeJkpFpJnRidOZv+YXchP1IUDkM1455JE6HEtkoK5MwYzRRuJ5aoNLB2kJT
	 mv186ReePxPyaIlRw4iOll/tjda65FqDzPBvjgkx9hCuT+yCcDDpRUK5G3ACmVS4GA6P4
	 iFxbiM/eJgVKn8p6xK2k/ik9m+JNEbxFx+zpU7XHdN74XYw4ScCD43NFtVS++aZFBKY4x
	 DVEROwFmfYe+O/aVvu04kC5comYcjXCVTYAqt5VxNunQTSaERpGIx+3cSCP9PwoE+BVqL
	 fte3E6yq9jKcZZd/oTd/sCEitCzrS/W/4hb3fBdxuVzeTUyySmpUjb3+TadO4L07cQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409668;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=gHnVCEKxdsmaK16E0lZXeSP6WMsz+23TB2UbsGIuRSc=;
	b=dNlw1/yTF/sNcWPVEW+/TDBT43qea5YCZv6oPOn144mXYWt1DhYIMzMyo/61NoBgNBQE
	 QZxYdcvTjWB34zHwgnJgGoH1EtZTqOmQPrQEzg1gK+Sxg1mFxW5RI6TiPLy4wVqaod8d5
	 PHS5x1b0iYVgOT5qsTqsir2icG/FnKzdoiEmTdqU6n7hV8GX4nVMO6nrwl7iVVHJTqsg3
	 obBNWc6EYN8MWH1unHfEGUKMPiSgDnQalWFoq23ouqUsBCKGUXi5KumpHBFf8f9gW5HTC
	 gCOOz4gAbM6KIJCmTfdTbScHXh0EDB7jdSYe6FJSNw0a/oCThUsg9y+WjPWrfVfKDOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iLq3+/1p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2780606A8A5;
	Wed, 11 Nov 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLq3+/1p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794409668;
	b=woXEiSSDEiAntI8hPpRkaw/TE1r+CrBcvGyv60PiMHaUKDgE5sIXleDHIDFxn1xfjZDa
	 EXhZ27OpCxR6Q3QqB7kxnuffTxN865B1A7cDLFYYHxi3YWZwaUrX2jh1puMFfcUfxqi/p
	 oa9e2+8O271Mc+GeGLjB9FtG0T0zDbQiUZjw+bYir1Fyv2pg+4V25EwuJyMiQByxcIMSc
	 vpo0k7Z3g0+2T07bN3zWwutZN6iVnl+OuBAxoZu4LA+CaimEaDgixf+9OB5G8sEUi+9xC
	 ldoRp+SZzfwyM8zdoqkoumljS7q75yp76sIi7MWAioD5pmikzOeUXu+hGBPkR/tCiLA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409668;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=gHnVCEKxdsmaK16E0lZXeSP6WMsz+23TB2UbsGIuRSc=;
	b=QUEkZSw08KU1ch+/+l0YFhMds0XG2CUgSv1AEjmSCSEbtYTEnk2WZh4K7pEJZtNe6FqQ
	 qXhsOFvrgHVIDzbRnMb7WhyjyY2CeVy7ON7OtKnS7nBV0E3pbAdwXPbcr1Qz4qU+7jJQq
	 lLB2W6rXJ5OB0Wncn6wVVq2AJ8zqrsqUamurCNlUVvJ1yG/imGFL9GxWU3GAQD8C0cq2u
	 uVYzbcQHWt8+Ip2Ktm5ocCk2JWdMs6YC02ZVYX6Rb9n/75m6M+0MZc65SE2QlnrHnD6Jf
	 lyAjvo6ZN6ASAEWpp/adxPgAVMyUhG9GPHwHBZkI9LZa78OH7gmol0zIzaIoVp3zUNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8B7171F00A05;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409668;
	bh=gHnVCEKxdsmaK16E0lZXeSP6WMsz+23TB2UbsGIuRSc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=iLq3+/1pV3CNPflvY83XGiRAub/ih19w+fmO+Yf0xUd0Cy3mzD2+RQ9Gr0qnO2x26
	 DAKR3zzYblFoG9gMdBfP6Er3VAbPPhXOyk5HabWyKYaFLyiysOfPOjCU3fckPta7w3
	 CiI5Dt/1A49QYHeueYNY8OrrcVjP5w/BtPl0CUN2VhP3V86LoLnvwWgZlMh+fDDMK6
	 gIeT0jNdvhGa4KnrGZPPtuoULSo6TKDXHjQUqLoGrPhwnpOcqZ5tYij9K+hIzY2wAW
	 cAPOalDQkREuZyaHAktY8y6U0uKrQ82Au+0RUc7Y4e6zIxwV7fRcfMlZLL+Fij2R5e
	 cPhmoT6KqR7jQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D190648FE7;
	Wed, 11 Nov 2026 15:07:46 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Subject: [PATCH v2 0/4] arm64: dts: qcom: Add Samsung Galaxy M52 5G
Date: Wed, 11 Nov 2026 17:07:44 +0200
Message-Id: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAMGE9GoC/23MQQ6CMBCF4auQWVvTGdFQV97DsIDSwiSWYksaD
 Ondraxd/i8v3w7RBDYR7tUOwSSO7OcSdKpAT908GsFDaSBJN0RZC3el7S2GNQpqLtpIq3tdKyj
 /JRjL22E929ITx9WHz0En/K3/lIRCih5VYyUpJGsfo+v4ddbeQZtz/gKBjxXKogAAAA==
X-Change-ID: 20261104-m52xq-dts-283ce0fcbc49
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 netdev@vger.kernel.org, Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794409665; l=3039;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=XfNua7PAV4kckWXtmCx56IqauZbV+Xj3aih6wYA69X0=;
 b=hlEHBlU91uiogwNELsRP1uTsAlQH/qJAfSeJKUVyPS7aTgJKc/kwJW15queGzapffIldwXd1C
 qNHldpxRX87Cd05qWSEa7vqMolfGCelWeAQ+1HzFvdauVKW6LhZ2Fry
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com

This series adds initial support for the Samsung Galaxy M52 5G
(SM-M526B, codename m52xq), a smartphone based on the Qualcomm SM7325
SoC.

Tested on next-20261030 with only this series applied: the device boots
to a postmarketOS userspace from UFS. ADSP, MPSS and WPSS come up, WiFi
connects, Venus probes, the microSD card is detected and readable, and
USB peripheral mode works in both plug orientations. The kernel log
shows no errors from the nodes described here. Bluetooth, NFC, IPA
mobile data and the GPU were tested with the same nodes on a 7.1
kernel.

Not included yet: the display panel, touchscreen, cameras, audio, the
fuel gauge/charger and the USB Type-C controller (SM5714). They need
drivers that are not upstream yet. The display works through
simple-framebuffer for now.

Notes:
* The stock ABL picks the DTB by qcom,msm-id/qcom,board-id. These
  properties are left out as required for new SM7325 boards, so users
  add them when packaging the boot image.
* The reserved memory map follows the stock device tree. The removed
  region is larger than on other SM7325 devices (0x5f00000). With the
  common size, the kernel livelocks when it touches the memory the
  hypervisor keeps.
* Several regulators need a fixed voltage or must stay always-on (UFS
  VCC on L7b, the ADSP-managed sensors on L12c). With the stock ranges
  Linux sets the minimum and UFS or the ADSP fail.

Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
Changes in v2:
- framebuffer: drop reg and unit address, memory-region is enough (Konrad)
- dt-bindings: nfc: samsung,s3fwrn5: add pvdd-supply; the s3fwrn5 driver
  enables it, so the NFC regulator is no longer always-on (Konrad)
- enable qupv3_id_0, it holds uart7 for Bluetooth (Sashiko)
- reserved memory: drop cdsp_mem/remoteproc_cdsp, the ADSP region covers
  them; replace the overlapping video region with camera_mem (Sashiko)
- Bluetooth: fix the vddrfa1p2/vddrfa2p2 supplies (Sashiko)
- NFC: edge-triggered interrupt (Sashiko)
- raise the minimum voltage of S1b/S7b/S8b to the stock levels, lower
  values starve the LDOs and the touchscreen loses touches
- Link to v1: https://lore.kernel.org/r/20261104-m52xq-dts-v1-0-b198f02912ff@gmail.com

---
Asdlerto Korry (4):
      dt-bindings: arm: qcom: Add Samsung Galaxy M52 5G
      dt-bindings: net: nfc: samsung,s3fwrn5: Add pvdd-supply
      nfc: s3fwrn5: i2c: Enable the pvdd supply
      arm64: dts: qcom: sm7325: Add Samsung Galaxy M52 5G

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../bindings/net/nfc/samsung,s3fwrn5.yaml          |   5 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sm7325-samsung-m52xq.dts  | 839 +++++++++++++++++++++
 drivers/nfc/s3fwrn5/i2c.c                          |   7 +
 5 files changed, 853 insertions(+)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261104-m52xq-dts-283ce0fcbc49

Best regards,
-- 
Asdlerto Korry <korryasdlerto@gmail.com>


