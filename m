Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D313B8950;
	Mon, 21 Sep 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987991; cv=none; b=RscOmI1trq6Xy4+AwisTxY/Wnpb3zVA3d8kLa1XXMa08GRm49XxpA+S+vLEP4obKk4QBzXrIRtrrX8R9/e6h4qOMY2avhgVNClcSnKeaZ7Oxxnhojlk3ceWPxVZDpqQHsSVPAZDnJoDhnzMbVXlWHSbh3+UzOAmgpYMXpyKo9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987991; c=relaxed/simple;
	bh=RrJGYdKkxTQlz72pG9pht7EpKJzAaKC1XCSf3BCO5VM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DdUzUxWltzql/osvIKVdkeRaMaFWQ8PC8+vE0u2FtV6nLM5qsI609w1Xun+L7F5xM/J/dhXvNxWzJy+dKvP+UCo0yoFcYN5CrLFXEgmuJHzJbo6iGRZaW7a/kIgRX4GE8DcC9mHAXFAqyeOTXBmVYwtLna+Np0c8xOBSs1Ftj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=lQHFfhIm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="lQHFfhIm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D992F3EC3A;
	Mon, 21 Sep 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789987981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KNCZjlfW/DFoOfMy9njTLqync4si8qX2FR/TAuNZUXk=;
	b=lQHFfhImy1Au/8yk3vhs3EWoZt9wL7WnsJjhdSChXLGI9AX7jVpQ7YVO6Ve/svqkwtqd6m
	NAf/QAKZCgeVo6NUwXTCDk5JMDm2DjwMZ4Kp2gfFDD8zWhZ57FVkTOhhEeOJjgB5aKJALy
	u5+MDCsrrU5/1Vd+8RheiqUoZ4vimzfELtM7KKAz3gBnVrVj3f1sm1h34PgzMNd/8UU8ma
	0mXEnNyea5RjO+ecIYSDWrZThQTzrx6e7bHdrtA/xaZCowT1EWpHX2TIVVIalP9tNUUU6G
	laPUjfhHE95hQCpersHkPT9tgg7Jt7xMV7zZ2rQts8UuPp70NMfN5X/fZnbYDA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v10 0/3] w5100: restore GPIO-based link detection
Date: Mon, 21 Sep 2026 12:52:48 +0200
Message-Id: <20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAMsWoC/4XRzVLDIBAH8FfpcBaH5WMBT76H4yHho0Vt0knSW
 O303SXxYMZZxyPw39/CcmVjGkoa2cPuyoY0l7H0XV2AuNuxcGi6feIl1g0mhUThhObv5bNLE38
 r3Svfn0rPrcesMETQ2bNadhpSLpfVfGJLtEuXiT1/n4zn9iWFaRGX7KGMUz98rO1nWCv+bjQDB
 96ixBx1tiG0j8dmOPbTdB7va3JtMcv/EMkFVy1EEZwVWRkKUVsECURVxCgZdQNaOUEieoMAEIi
 uiI4m29g4ZxpHIWaLKAIxFWlCfSpmqTUoCsENoqib4IK0KWEwwSMmCrE/iCcHayuCPgtorahKp
 hC3QcAQiKtIBKtQSm11CBTit4gjEL/8jlHLRKKLGH8jt9vtC4J8s7b5AgAA
X-Change-ID: 20260804-wiznet-link-gpio-796f36cd14f9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF6b6jgYhyLS1AMsjs3SUF00ycLJG+3ieVql2Kn6qdvxDGf4rTyaSbhAqnwuGsjZ+WJOX/RpUHNPAXw8XKKkZ0KNTXxMTbyh1ZPeLZ/qDIQ7zQj799wFeDFqub8XcxckvuSUxxiBAdBRkbrJE9XHLO58FjG+8nOB+AxI++RzKQrqnmKb3pZEkkmHAA+2m/ZbgRJ7V52Z61a5S70xs3cs1YT95mw5ihF7Av3KbXYeMtfVUMvj9MBJ3vXM+JI4uGUtG2RywLSdFAKmgsJkJo7zgM5jDRsCsm02CYlSfELfbPydAL5xfFMHamzz8rvCADlcg88DIPeXJBwoVlZsuzk2jv2pWUUTvpJCI9sT8v1sGHObRWXCPYv64Pq+NTyZuMIluS5qLuJGEOADqIJYWBO5plZE+rY9LVIG2E43POFlBK0xrH0RNDLaIDE898yi6ucoP9He2T7Ktk1XF46D5F/+7FFFO3JsPwKWdOzYBPCRPx8OUfGf6RRfbOhy3Iuh1GANa89Hfgg3+xKmbtWkJpHGPqTBlQda7vwP+ZicY8LMmHEA/oJKjE1dmF9/Yea9coMbpNFrOoUVhoRMuZybAcOsETdP7/8OnB3uYhiwEXHGFvaZj46sAp7GXo2ETbgPm36hwfQgcNo4mE4IRPlqcXwGkl1QMa7kDc5qUofC8tllUPKyA

Hi,

In the previous version of the w5100 driver, the LINKLED pin could be
wired to a GPIO to detect the link status changes via an interrupt.
This only works on w5500 as it is the only one documenting its LINKLED
pin to hold the link status (on w5100 the LINKLED pin is changing with
RX/TX activity).

This series of patches is bringing back the link status detection on
w5500 using the Link Status bit of the PHY Configuration Register.
Additionally, the LINKLED pin can also be wired to detect link status
changes and read the register in the interrupt handler.

Arthur Crepin Leblond

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
v9 -> v10:
 - Address Sashiko review
  - Always schedule the restart work to avoid atomic context
  - Move netif_device_detach before disabling irq in w5100_suspend
  - Flush rx/tx queues in w5100_remove

Link to v9: https://patch.msgid.link/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net
Sashiko: https://sashiko.dev/#/patchset/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net

v8 -> v9:
 - Address Sashiko review
  - Rework commit message
  - Disable the link irq first in w5100_stop()
  - Call w5100_hw_close earlier in w5100_stop()
  - Flush rx/tx work and cancel restart in w5100_stop()
  - Call cancel_work_sync() after unregister_netdev in w5100_remove()
  - Call cancel_work_sync before netif_carrier_off in w5100_suspend()
  - Enable/Disable main irq in open()/stop() and suspend()/resume()
  - Check the number of irqs defined in DT
  - enable the link irq after checking PHYCFGR
  - Ignore fwnode_irq_get errors other than EPROBE_DEFER

 - DT binding: Simplify the interrupts description:
  - Describe the 2 interrupts in the top-level properties
  - Limit the maximum number to 1 on non-w5500 with a condition
  - Somehow only adding minItems in the top-level and then describing
    2 items in the if block led to dt checks errors.

Link to v8: https://patch.msgid.link/20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net
Sashiko: https://sashiko.dev/#/patchset/20260915-wiznet-link-gpio-v8-0-d173622474cc%40marmottus.net
Clashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-wiznet-link-gpio-v8-0-d173622474cc%40marmottus.net

v7 -> v8:
- dt-bindings: net: wiznet,w5100: convert to DT schema
 - Add a myself in MAINTAINERS
 - Address Sashiko reviews
  - Change edge-falling to level-low
  - Clarify the spi max frequency for all devices
  - Add main interrupt description

- dt-bindings: net: wiznet,w5100: add link status interrupt
 - Remove Krzysztof Kozlowski reviewed-by tag after Sashiko review changes
  - Make the interrupts property conditional

- w5100: detect carrier state using link status bit and optional
  interrupt
 - Add myself in the MAINTAINERS file
 - Address Sashiko reviews from online bot and locally run
  - Add a mutex to synchronize the link state read and interrupt
  - Return last known carrier state (netif_carrier_ok) in
    w5500_get_link on SPI error or if the device is not present
  - Only set ops .get_link on w5500
  - Check the netif state, disable/enable the irq and re-check the
    carrier state in w5100_restart
  - Cancel the restart work on stop/suspend
  - Only set carrier state to off in w5100_stop/suspend  when a link
    irq is present
  - Warn on fwnode_irq_get errors for the link irq
  - Free the main irq and flush queues before resetting the hardware
    in w5100_remove

Link to v7: https://patch.msgid.link/20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net
Sashiko : https://sashiko.dev/#/patchset/20260904-wiznet-link-gpio-v7-0-69f01b70c96f%40marmottus.net
Netdev Sashiko : https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-wiznet-link-gpio-v7-0-69f01b70c96f%40marmottus.net

v6 -> v7:
- Address Sashiko reviews
 - Propagate spi read error to the caller
 - Do not change the state of the carrier on SPI read error
 - Enable the link IRQ before reading the PHYCFGR bit
 - Call unregister_netdev before reset
 - Update commit message

Link to v6: https://patch.msgid.link/20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net

v5 -> v6:
- Fix DT error: use minItems
- Remove conditional properties
- Put back the reviewed by tag from Krzysztof Kozlowski from v4
- Revert to the reviewed v4 version by Arnd Bergmann with a few
  changes based on Sashiko's review
- Address Sashiko reviews
 - call netif_carrier_off in open if there is no link_irq or  get_link
   returns false
 - call register_netdev at the very end of probe
 - call unregister_netdev before destroying work queue
 - handle link irq probe defer error
 - call netif_device_attach in resume before re enabling the link irq
 - disable the link irq first in suspend
 - log netif_err when PHYCFGR cannot be read
 - enable link irq in open
 - disable link irq in stop
 - free irq and invalidate it in remove

Link to v5: https://patch.msgid.link/20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net

v4 -> v5:
- Remove gpio/gpio.h include from DT example
- Make the DT interrupts property dynamic from the compatible one
- Fix DT bindings errors
- Address Sashiko review
 - Read the link status register only on w5500 instead of checking
   link_irq
 - call netif_carrier_off on w5500 link status off in open
 - enable/disable the link irq in open/stop
 - enable/disable the link irq in resume/suspend
 - handle link irq probe defer error
 - register the netdev last

Link to v4: https://patch.msgid.link/20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net

v3 -> v4:
- Update interrupts in DT bindings
- Use directly an interrupt line instead of gpio -> irq
- Address Sashiko reviews
 - drop devm_ on request_threaded_irq to avoid use after free
 - disable/enable the link_irq in the suspend/resume
 - only call netif_carrier_on|off if the link interrupt is present

Link to v3: https://patch.msgid.link/20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net

v2 -> v3:
- Fix DT binding errors
- Use the Link Status bit of the PHY Configuration Register
- Use the LINKLED gpio binding for change detection only

Link to v2: https://patch.msgid.link/20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net

v1 -> v2:
- Convert device tree binding to YAML
- Use devm_request_threaded_irq instead of request_any_context_irq
- Use devm_gpiod_get_optional instead of gpiod_get_optional
- Call dev_err_probe on gpiod_to_irq failure
- Remove link_irq from priv
- Use a fixed string for the IRQ name
- Remove empty new lines

Link to v1: https://patch.msgid.link/20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net

---
Arthur Crepin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link status interrupt
      w5100: detect carrier state using link status bit and optional interrupt

 .../devicetree/bindings/net/wiznet,w5100.yaml      |  88 ++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 -----
 MAINTAINERS                                        |   7 +
 drivers/net/ethernet/wiznet/w5100.c                | 227 ++++++++++++++++++---
 4 files changed, 296 insertions(+), 76 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260804-wiznet-link-gpio-796f36cd14f9

