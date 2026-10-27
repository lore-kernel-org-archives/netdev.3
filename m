Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793095477;
	b=F7zYyGxs96HUOU41j6JY2I/OYX/fEBq6ZnBha6Pdf0oSghmLahXq6Nivgi0fFnL3xCJq
	 K8c9/vlWNTa+eoyE3I0RXt6qOfLT6bs8Xp1jODV410ogqJGe89ChM9wqIxH7NYqcxsQGI
	 VsYRTVILpq48Oj54tdIjKJHqUOoOzvIOCT46ishE9RwQUTiyxeszLsvL8FV3X4F3R1/Iy
	 QwDAeBofBL2EFm3XLSEwnDg10gfXJZDzX+jEx2GuAmgHTcjcxqGDxaSJfg6/+vcUxzJaQ
	 wKaew1gzR6tqnWD0eDaX5lnKr4dr4tgvo9Xe+TbYDM7cCKqa6ua9GeqGPbFlyhFOOxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095477;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=/D8Jw2oxEt/BBDcZtcM/C7+sByqqhB8HaR7nW4XlFv8=;
	b=hDWT4Q1pto4F3O+1cg4Er+4P13Jtdtl3laphUDQgG50Vu3ioMrEH4WKy2qVIDakN6ovu
	 4MVitJ+81gJdek1X47PxjOX8kHStaIKW/t0MWWKN8Lty6EbmJ7s/BLlXLgIt5+XPEDIoQ
	 QFNV4uqho7aFXiWEZESUDINtBpWaVAuuomoo25uG1JTnzSx2ni2rOdjDZTvfz1XQzSFaQ
	 Rck5PNOnVRnEg1hnu6nJkGRBPZwumETHJMNKZXLFCWzkX4cDwc7JSXraWFIq6A5PMfJSj
	 oL2IZU4J/LcYkOiidEVxH9zfPybm5QIrxGpVVDgYFWdFg11PuOUCdPnN+23Y/uDwhGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NNlsdO/H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2A606A31A;
	Tue, 27 Oct 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNlsdO/H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793095476;
	b=VZcE5k9qFY1ypybZMV2CS7OpsHZYiswHvH2S9oeNrdLRj72HgORbVuPD+4BruUC8LoGF
	 EF0tyjToRYc85Jtwv/6MGPGYIaAYzY4rFtYkteVFGte7kMvpmXWbhbRwUMCITC+9bJ03j
	 V4iiu4J8yQWzZcBDQC6hFg/4BhCtTZTMeGmAkPrDbmNHz9UzXmI1SOCzjtCrTplDpz5YR
	 zA/HOnt2xLwYKEOR0ephxM8jr1YN8Jo/aZULYXMG2Ytwo3CT2/uDtvLzcbfAt2IJGCtky
	 SCeshJZhbr2m9HZrGq5VZCXz+APnacpTwI+f8Z+qTaTgIRxit0k0RwIHELOmT243Qkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095476;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=/D8Jw2oxEt/BBDcZtcM/C7+sByqqhB8HaR7nW4XlFv8=;
	b=mAEYOm1I4wYLsirw8I5gRj3IlggM4KJrN7Rdu0ZJINRTqRuuaiNHmU7Pp2i6eGv+dqfv
	 OFAY/dA917wNkWkpRNoNvB7jDGT8fzFp1RXoiTGMi83utxknwOTNT72izxvQAbHm3WSMQ
	 ESEK+fIa2H8FI1GpTr9uXhMvCTOrhk316iWasuvZ7lXADcjr+da3+Eo3MOXRAzVrLhURk
	 Rcp/PVoOeZaGeZhMvK0nF8Vv4eKVVz87ct0Kq/ItDyUxLZ8C3Dd95q2aZ8hceg7KHpE0B
	 1ksBM3nZ3mPBHgHcucmFeeFVjHZ/sHyifK95aQN64lmn7RCxWk1/C1+y3ZacU5kmc8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E0AA11F01825;
	Tue, 27 Oct 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095476;
	bh=/D8Jw2oxEt/BBDcZtcM/C7+sByqqhB8HaR7nW4XlFv8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=NNlsdO/HtM0gTl70C8VCD4RbZTwzphuXKd93AhUOVDsn20JU6beyqPmqm72l8g1is
	 3bWC2pMObyPAuyObrnFgdkTaynsffKtga4IJxdXgOiG4/JounRy0sWD1Zv8TEye483
	 OwCJR2RBLgu/dcEwqdHPN1gt0lV/Aokao/bBstjAEhxN5GfZi64k7X1gxWTW8Gce3x
	 wXI6Qb0GsRlCjmQvszSKgsyOECL4Xp1BGuBpSOKcOGgzofp9JLJxGr5l7nPZX7VAcf
	 VrXjf+EJ3JkdIGfpcoCrzUa7wbTjG/WBgHAekWnmWq/Flb+FkXTw4MvC87JehJt4U9
	 Y9Y+V1bcBUzvQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6455D45074;
	Tue, 27 Oct 2026 10:04:35 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH v4 0/4] clk: rockchip: Add RK3572 clock and reset support
Date: Tue, 27 Oct 2026 18:04:27 +0800
Message-Id: <20261027-add-board-ok3572-c-clk-v4-0-d4152b4fedaa@qq.com>
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
X-B4-Tracking: v=1; b=H4sIACt34GoC/3XO3W4CIRAF4FcxXDsNO3Tp4pXvYbwAZqjUHxSU2
 Jh997I2bWxSL09y5jtzE4Vz5CIWs5vIXGOJ6dDC63wm/MYe3hkitSxQou4kKrBE4JLNBGmr+jc
 ED363BWkkBep7DGREOz5mDvF6h1fr71wu7oP9edKmxiaWc8qf9+XaTb2fEfxvpHYgQToZaOit6
 piXp9OLT3sx6RUf758+WbEZRjozDEo71n8N9Wjop4ZqBjnrglWGtMFfYxzHL6m/bGhPAQAA
X-Change-ID: 20261023-add-board-ok3572-c-clk-090dfd552fd9
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793095473; l=5839;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=8trn1FKXRc/Z8uopivV1JhZgRiQfUeprY/VzfStCnT4=;
 b=+QB4V7LLaKfSh37JANKQhdHd2LUTlUTJk92+cz3V6GY4Tg4+bQlxht7MKWefnfuYJuJ/eD65E
 WJAkauDncbvAGclC6HzjaTfLQ2OUzVLeebJv9qZ4B8O2GXEJhYv2YHc
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

This is one of the subsystem submissions for RK3572 support.

This series adds the CRU binding, clock and reset IDs, an internal
Rockchip 24-bit fractional divider helper, a composite clock macro with
mux-table support, and the RK3572 clock and reset driver. The shared
helpers precede the driver that uses them.

The RK3572 SoC has eight CPU cores: two Cortex-A73 cores and six
Cortex-A53 cores. It also integrates an Arm Mali-G310V2 MC1 GPU.
The OK3572-C board provides two Gigabit Ethernet ports, three USB3 Type-A
ports, a Type-C dual-role port, eMMC, microSD, and UART.

The driver provides the peripheral clock and reset trees, including the
three audio fractional clocks. It obtains the PMU0 GRF for the AUPLL
reference mux. CPU frequency scaling is controlled through SCMI; BPLL
and LPLL remain enabled for firmware use.

Testing was performed with Debian 13 minimal and Linux 7.3 on the
OK3572-C with the FET3572-C module. Shared peripheral tests were run with
the system booted from SD, while eMMC validation covered the complete
boot chain.

Passed functionality:

- SD and eMMC complete the firmware, kernel, and root filesystem
  boot chain.
- UART console works at 1500000 baud.
- SD read/write and data persistence checks pass.
- All eight CPUs start; CPU frequency scaling and hotplug checks pass.
- Both Ethernet ports obtain IPv4 addresses and pass bidirectional file
  transfers.
- All three Type-A ports pass USB2 and USB3 enumeration, data transfers,
  and reconnect persistence checks.
- Type-C host and device modes pass in both plug orientations. Physical
  reconnects correctly select the expected device, host, and device roles
  in sequence.

Stability:

- Repeated cold and software reboots complete on SD and eMMC without data
  integrity failures.
- A combined CPU, memory, network, SD, and USB3 stress test completes
  without a crash, lockup, CPU offline event, or thermal shutdown.
- Ethernet error and drop counters do not increase during bidirectional
  network tests.

Build and checks:

- The kernel, modules, and board DTB build successfully.
- Strict checkpatch reports no errors, with warnings about new
  MAINTAINERS entries and the RK3572 Kconfig help text.

Untested hardware and paths:

- NPU
- PCIe
- GPU, video output, and audio
- CPU rates above 1.2 GHz and voltage scaling
- Other low-speed external interfaces

Some files in this series are derived from the Forlinx OK3572-C BSP
Alpha1. Thanks to Forlinx for their support.

AI assistance:

- Codex / DeepSeek V4.1 Flash were used for:
  - Reviewing and adjusting code style to follow community conventions
  - Automating tests
  - Collecting data

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v4:
- Move COMPOSITE_MUXTBL into clk.h as a separate preparatory patch and
  use it in the RK3572 driver.
- Link to v3:
  https://patch.msgid.link/20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com

Changes in v3:
- Close the reset ID gap while preserving the register mapping of each
  named reset.
- Check fractional-divider scaling against the actual field widths and
  reject unrepresentable compensated ratios during rate determination.
- Use signed negative PLL coefficients in the RK3572 rate table.
- Drop CLK_NR_CLKS from the binding and derive the provider size from
  registered clocks, keeping the existing clock IDs.
- Fix the indentation of the CRU binding example.
- Link to v2:
  https://patch.msgid.link/20261023-add-board-ok3572-c-clk-v2-0-90b98836be6e@qq.com

Changes in v2:
- Split the original RK3572 support series by subsystem.
- Port the vendor 24-bit fractional divider to the internal Rockchip
  clock helpers and adapt it to the determine_rate API.
- Register audio frac0-2. Keep internal SPLL factors outside the DT
  lookup so PPLL retains clock ID 0, and remove the unused xin12m factor.
- Link to v1:
  https://patch.msgid.link/20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com

---
Raw dmesg: see v2 cover letter.

To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney+clk@redhat.com>
To: Jerome Brunet <jbrunet+clk@baylibre.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Elaine Zhang (4):
      dt-bindings: clock: rockchip: Add RK3572 CRU
      clk: rockchip: Add internal support for 24-bit fractional dividers
      clk: rockchip: Add composite clock macro with mux table
      clk: rockchip: Add RK3572 clock and reset support

 .../bindings/clock/rockchip,rk3572-cru.yaml        |   57 +
 drivers/clk/rockchip/Kconfig                       |    7 +
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-fractional-divider-v2.c   |  354 ++++
 drivers/clk/rockchip/clk-rk3572.c                  | 1981 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |   83 +
 drivers/clk/rockchip/rst-rk3572.c                  |  739 ++++++++
 include/dt-bindings/clock/rockchip,rk3572-cru.h    |  559 ++++++
 include/dt-bindings/reset/rockchip,rk3572-cru.h    |  713 +++++++
 10 files changed, 4505 insertions(+)
---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
change-id: 20261023-add-board-ok3572-c-clk-090dfd552fd9

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


