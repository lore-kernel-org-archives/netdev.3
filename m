Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792997821;
	b=zY073lW7X3yXI2FkCDNdjx/WhHqpo0v7f5eiXAghdhBw2nyK22tczNtSWnFkzLB56r60
	 YRt3EgatOEjwwjieJP96cURxMTaN/adXfixo+gUdIkWJE2oz7+WC3URIyWKKqsHO2NWqO
	 mEN/VMIZCf7xzNdOBScESETi7iW3GqdblhRJpQVwuR4DTbFnkbIXAXfTudQIyKaVL9xYo
	 zyf2Te+Bks9xDZXpIqJk8UCv0RNnkGXTDwb+xMR7P6G3RDZcvIU1HWYr0ONCjGIT2tR8X
	 6lYIW6myLcy6dp4l+cLYEYPSIiH4tS8hDzSnt6JF8eF7nYgavbIDcrqsygxdj+X7O/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997821;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=qRd1+nyemSJLRnKKGdUcbSH6n+LYGIu1njS8JY4H4j4=;
	b=LkpxQZiJMNkVje8GpAXLEDuiYKyCNMQQ+NzEqhF2Rtb0S30k4429iMOigdojyO8jqh63
	 Uv8tkkEyESoRV9fxRMSPgSW/85KGDLOooX3nBMf7Bef0Rg/oBENn8a/LONE3iasSttpGc
	 QHeXnckGmJSEHx8+2ikFDn4YyRpVcNnnq8tEhfTvhdcmv46R7t5bVLSygjSTu1Mo/mSve
	 rLA6ZJliwokKZc2RjWoTt+/8bgyv2AnzFcRolhSLqwtZxZHd7VJsH1jxjeoyfo9AfXF1A
	 lgWFWJuIjsTMWNSeCTozuNz8Zd2SX6tYsNMaVFsp4wsMazgNwURJVYAznLogggUajNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQy1X3TZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71CD606A31A;
	Mon, 26 Oct 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQy1X3TZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792997820;
	b=F4lknio7iVFp9UQ9h2LLz3Ka8NyWPcvHRBZIUVwAv8ab/rq/zJ6H6Ba9FSQTeVMi8fcS
	 FqUjCN+roGmxCJl3uh29sx+cXwM8ujCADoBiCIh3zYXcyICHYeXZ/bfm+EmEVj61EF4TP
	 OiWcEZsJXD6+KU/dFnhFe3p3u1NPdnndXSgG62ZIgwAmr+f1PHAoHJAfRhllrbbp+y+71
	 4u+yG7xbm2xXhQje4hITmxzOwA/NPxWhIUOnEO8v2YQ6zuxY7uSNL5XjlbFdIf+29dBGi
	 d65RPJ1//HaBUeXo1EHOK8yfGM2AINXULxQqgjZEvpHUBeuwe5VqZ7UnKIDy7aZBDuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792997820;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=qRd1+nyemSJLRnKKGdUcbSH6n+LYGIu1njS8JY4H4j4=;
	b=CjMcLP7ef6DiGAKIP8tAyM5FrOCiCidt24SlgS5MGFJQaDoBpB80P7mhIIXHWzgRdgmR
	 x3Hef92Sg7+iarj9/tN5uRfHT58wxmgJRNdxQKeYJ6T90jMfbjPpV7zZJna5DIuNliSy4
	 Ivt/qE4Et84iXYa+x8IJqYPIBK0GaHF2kaIvJwqLNiyUP/tfzFCqFn7K4cwxYWV0fynN5
	 AtEfOWxFTfUwyJfgutaVpFQ6b18BbJQobT8aEPqH5eAjdqJ4nsMAMSabIFlWbASHBd3DK
	 2XxGXW6WxsROmsPVABTz+/VZoAOWAMBsD76IzvpucvgllhJ7cIU3TmbqFSbXoiKPjwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7CD5E1F01825;
	Mon, 26 Oct 2026 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792997820;
	bh=qRd1+nyemSJLRnKKGdUcbSH6n+LYGIu1njS8JY4H4j4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DQy1X3TZFKOOV/dfS56YoXIX2AsjDvZaDqgC9RdCj5N00ksQGgzxuAehJkUpErHAf
	 7MVbAvcqG/kg0eFR1kHzYElVzb+ns27E+9PEBgilELpQc/C88aAyeXhxhubD9MOg1P
	 OpWNMSFi7Bc/RaryBe6MNfS356WBKtLMNX8t/7NPegoqyIx3/c1szLLmezA1b6c0uJ
	 BmzGYmWtD9zK9u6ylb3NdKE6DA1au1Gu3CUuZJ9qnWwnsmKZYk33PYAIjGk7TkRZxY
	 s2nw4LDr1/tcPg69YTlJhcrhMYGxnD3ufF9D9kfYtgQ7BrplGJGQ7SexjB1wyzp0cK
	 39D5mF49r71Vw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D490D44C37;
	Mon, 26 Oct 2026 06:56:58 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH v3 0/3] clk: rockchip: Add RK3572 clock and reset support
Date: Mon, 26 Oct 2026 14:56:46 +0800
Message-Id: <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
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
X-B4-Tracking: v=1; b=H4sIAK753moC/3WOQQ6CMBREr0K69pvSBgRX3sO4oO2vVJRKi42Gc
 HdbjNGFLieZeW8m4tEZ9GSbTcRhMN7YPga+yohsm/6IYFTMhFFW5pRxaJQCYRunwHa82DCQIM8
 d0JoqrYqCaVWTOL461Oa+gPeHV/Y3cUI5JlpqtMaP1j0Wc8hT7y1hvyQhBwpUUK2qouE54m4Y1
 tJeSKIH9r3/ezKwyKipqKuKlwLLD2Oe5yeMhhr0CwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792997816; l=5495;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=z+PAMzWHcuJVVVclopxlGF5C09sfEoJbDIpJ/atrE0o=;
 b=+Pa7rSV4yxi3LYxuSQ4HV5XM+tzjxLNHGCLs7YsEbFlzIhquPSKg2A94jjo3xt8qH+fMuRe3n
 2pbTtLlJZwIDMdmp85BQfy3rPsa8+ULnYNQtbjEMxJ/KB76lb/t0fJt
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

This is one of the subsystem submissions for RK3572 support.

This series adds the CRU binding, clock and reset IDs, an internal
Rockchip 24-bit fractional divider helper, and the RK3572 clock and
reset driver. The helper precedes the driver that uses it.

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
Elaine Zhang (3):
      dt-bindings: clock: rockchip: Add RK3572 CRU
      clk: rockchip: Add internal support for 24-bit fractional dividers
      clk: rockchip: Add RK3572 clock and reset support

 .../bindings/clock/rockchip,rk3572-cru.yaml        |   57 +
 drivers/clk/rockchip/Kconfig                       |    7 +
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-fractional-divider-v2.c   |  354 ++++
 drivers/clk/rockchip/clk-rk3572.c                  | 2007 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |   61 +
 drivers/clk/rockchip/rst-rk3572.c                  |  739 +++++++
 include/dt-bindings/clock/rockchip,rk3572-cru.h    |  559 ++++++
 include/dt-bindings/reset/rockchip,rk3572-cru.h    |  713 +++++++
 10 files changed, 4509 insertions(+)
---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
change-id: 20261023-add-board-ok3572-c-clk-090dfd552fd9

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


