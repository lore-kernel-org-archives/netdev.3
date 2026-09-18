Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0E4EB847;
	Fri, 18 Sep 2026 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744450; cv=none; b=VNucBEC3cgx4uJmu9eLZ8ncaKwKWkughy/7/ijWCBfWPKbbDzt5MRVP3giXPGzXBOSCMFGxU+XPxcnKZ3kN+eZy8bXCmpE/blDkPUCNmFRK4+sCV36dZcOXteHz6xRVpfMseIk5jv/x+JZFNCbbm0a5iCzEpy2k+92K4zNellwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744450; c=relaxed/simple;
	bh=ISccSyJukB5b/2mH/sxrBdNv502Nd8IO+LlWiR5BHwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tMV260Wxj8N6Ktux5TAKnMTAnveUzsFBm/kVbDOQ6z77YlHSVjp/oGXFxhC+zwuy904LX7h80GrAIMwAroUzORbsbfF4B8ZtU9940var90de9S6HEc+ZOSJXyDclXU7dcnudvWmwcLQdlQcZF3juiD4ZmKTxI3um/jZ8bkOO9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=kVdwR34T; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="kVdwR34T"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3458A3EF90;
	Fri, 18 Sep 2026 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789744444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7bJKE7ivEWVLmt669qOHE1oWBllitD5HhFf4FomBzg=;
	b=kVdwR34ThI5tkVrihDG4x8+IvP1y+mydnR5AFNc00CrmYkW/daf73dfgvdGZ463FRNU2ia
	DMInhmDuV/c+I6oA+56s1enqDmAkO/pymylzdZYO3rsJeFHjAhXuPqPF9et6hsHm1eS4gH
	qN6BNQEE9hQ4hgColc5DyfpecltqOy47S7nu83SpdgKBBDMlMNR5oTyIGVBcYR8kscmQ8C
	0bkRrODJJWGptJrmlzphj3uEoRTuVmRUxzo5xfa5d3JX7dpFt2rxNJum147qEUWD+HwggY
	x7ed6Jbva0R72BRGgK62XligKTjO3UIMBzZTBaFpDNQolVAT5FjAQfLpauSUsg==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v9 0/3] w5100: restore GPIO-based link detection
Date: Fri, 18 Sep 2026 17:13:52 +0200
Message-Id: <20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBVrWoC/4XQy04DIRQG4FdpWIvhegBXvodxwbVF7Uwz0LHa9
 N1lxoUTg3F5wn++H7iiEqccC3rYXdEU51zyOLTB3O2QP9hhH3EObUaMMCCaCPyeP4dY8VseXvH
 +lEesDCQOPlCRDGprpymmfFnJJ7REh3ip6Pn7pJzdS/R1EZfsIZc6Th9r+0zXjb+LZoopdsAgB
 ZGU9+7xaKfjWOu53LfkWjGz/xCGCeaOBuK1IonLHsK3CHQQ3hDJWRCWCq5JFxEbhNIOIhoigkw
 qWK2l1T1EbhHeQWRDrG9PhcSEoLyHwAbhvZvAgrgYwUtvAGIPUT+I6X6sagiYRKhTpCmph+gNQ
 mUH0Q0JVHFgTCjh/W/kdrt9Afc6PtSzAgAA
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
X-GND-Cause: dmFkZTFvDdygotnCkyDQ+j22Z9K+lQp6S627A6pJ5gUNuN13UeS76/llvHTj61I8mobFo+8f2EbQuRGEQo8z5yXQLMp2QU9ZWdHmfkdqVMq3BzZeSUDN2C+YR31od+Ujg2k8SioCSoHI2X3e/lU9zCznktRoPO8cNM1njHBpx7d56aldWXRRB1F0wUwa0rU3utr6LT1eCF9Mjxsq5ElBM/rtUM3Hvix3nWSWZSClPjumiXykUrqwxHEXie9VcqhPIKb2wtC7LXfgUDJ9KYcHSvCJx5Vn21J3OQCE0WWZcmda3+F7Qe3iFvFZ2G3lkO9Yyk0QsVWuOsEyJUvGWmeTKi5DSXvxIx9rNi1qHFJrER0U8liOnpi4HoVXGERpIpC/QJus4WX8GHanVMQt+mMYkdOXK3wDzmDDktBDoDsBQehveC+H4jn5NJSfjmxUsVXDRKmqlMKcMtdx0rk1Bq8f0im96xjce8X68BHKoBlOyLiofRb/XdeVw8koWT5/m0yas3Adv9H7syhZcP6rBAGpOIwE+dw2ojSHi1bBZLX+1M+Iu2e0Qz8bZj2oCwxIi2RMygIULlBxWQMuSR73lXPh9Xj5+JiHW0RKGbWXRt+tSNdXngtOq7rTm4iT7q+9ptTpAyodrRGglQiCD2uYcnphp9cbboVFMldhrVX03xLfHroOmchAeQ

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

 .../devicetree/bindings/net/wiznet,w5100.yaml      |  88 +++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 -----
 MAINTAINERS                                        |   7 +
 drivers/net/ethernet/wiznet/w5100.c                | 220 ++++++++++++++++++---
 4 files changed, 293 insertions(+), 72 deletions(-)
---
base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5
change-id: 20260804-wiznet-link-gpio-796f36cd14f9

