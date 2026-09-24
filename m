Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D334071E2;
	Thu, 24 Sep 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243322; cv=none; b=F43XMpIEkvH8c3XDdN4Dwhr7buofkzfprC3wjRkDA8Pq/Vp6Di+Rv9i3ZNyZMzclL8U+iMfdKmI8h1d8QVu9hgeCS9vw1HWka8hKwODwVRd/UanNkygeq/wzk2mWW586XXrH6fbGIlEhp5J9xcnxMTVvOz9lqGkfPAVOTerkWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243322; c=relaxed/simple;
	bh=CjI7fXwjgnzYyfKNDaw8QOOEwdivAzuEa17X1huO9xg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m9GcIs732iNy4Wz/ABOb97BcoNqqnM6X1h01YIRGFl3R1/kGhemuQsOU5lrAMf+a+mbxzFNpn92bZfiJRSEzd4FIH3g1nttXqrJdcbS16EQKMnNSwV6t95qGvbEi0m1aTnBAU16v+L5zeWp7qP5YGFG0JQh8o6rHMaIXmqzN2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=JAXAl2Sh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="JAXAl2Sh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 288AE3E970;
	Thu, 24 Sep 2026 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790243303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bvz/1zAYVxyHogqLQS4mz6FLWzyoWiabM1YZOdYvYII=;
	b=JAXAl2ShNRluLT2AqyeVj8a27ksooobkah/g+hndTxgoakuE1efito1doksaDxbbAUNdJd
	uLOmafHop7Y6XV2u1yfC2TK+fCg653GnfqhAEUI9JzvzZjkADpgnLWuvL5xxBqQ8dcZFYq
	8X1G4lPeBzL5UrWd2ipQGa8yPGBe7uPp+o+XHuD5pWOUbe3XC3SatoE3vCVCRPzHkooSaU
	pVsDeM7vLRqY1pgTzQ00oCXd4d6Fvm3xd4bLp13tFJon6jjs2H50sumtqgxGSteLisaMR8
	UictbWKC3YFuvbsESirQrUx//zF7BSM68H4ZvEoou+FPRqfcWIt/iCCVsx5C4g==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v11 0/3] w5100: restore GPIO-based link detection
Date: Thu, 24 Sep 2026 11:48:10 +0200
Message-Id: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrxtGoC/4XRzU7DMAwA4FeZciYozo+TcuI9EIc0P1uAtVPbl
 cG0dyctBypkxDGJ/dmxr2xMQ0kje9hd2ZDmMpa+qweAux0LB9/tEy+xXjApJAonNH8vn12a+Fv
 pXvn+VHpuG8wKQwSdG1bTTkPK5bKaT2wJ7dJlYs/fL+O5fUlhWsQl9lDGqR8+1vIzrBl/F5qBA
 29RYo462xDax6Mfjv00ncf7GrmWmOV/iOSCqxaiCM6KrAyFqC2CBKIqYpSM2oNWTpCI3iAABKI
 roqPJNnrnjHcUYraIIhBTER/qVzFLrUFRCG4QRXWCC9KmhMGEBjFRiP1BGnKwtiLYZAGtFVXJF
 OI2CBgCcRWJYBVKqa0OgUKaLeIIpFm2Y9QykegiRgoBsVEkNRQQC+Os9rZu2Xr5m7ndbl9YAxf
 9QAMAAA==
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
X-GND-Cause: dmFkZTFls13zzgmhjSyx1VgXOB9jW5nG0KTPDt3ZHstJwYdTwHbSXhPPjp8O6DtWp+zmhGMn6wmy1kwVMO+TO879Ij3htW+PqQWk8eu87obLA3Kd4WYMrLISj/LrEZmnggQg3VZ9xgVFHSh9AODZWfHJK6R8sX0ms6R9le/nbCeJtiwXte3rtyBKH76tRw+jIq+jGBEV26QBXKDDO7YhQy9A23Lq83xI6Girp1olmN8zLG+3njM/P7UH3Bk8T/AjKeBvN60i6AN3LXNOIeATcKw6rqc+ZGTY+IdWUN//6atyoxRjUpraruYmTpVEnfPiwryaRum9XPyKtHiikdD+UqmFC56PqaFcJXz0/HLdnT/JP/WQ06gDyZMNKp4MCEV+E5zMf5Iyle834cGcY9z3QrKxRN6x1G5p0T+XCvYEaCfeA3l48y0FceWYGdEg5nJk4VbLzNDrfl8ShluYZsAwi3eoOs9ZDTyCRL4V4rje8KENn7zQgkCRRqzj75QtcGlekMliOBdpmVCPVZOvYie+tt4B7zuwO7UDVNTAc3pIrhuXaR4EL86aR4TUUYjnRqyJQSHfy7CRxCC0dFxJxdVjiud0AYpP9tAnXcXgR6axMC7TCNOvY6zShEoBmq3yz8f6YN2imdLnpUA68iojG4bpdi79n/Hel1Gb83+KeQeyC2EGpX12VA

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
v10 -> v11:
 - Fix line over 80 columns
 - Update commit message
 - Enable the link irq after reporting the carrier state
 - Call w5100_hw_close() earlier before cancelling/flushing the queues
   in w5100_stop()
 - Call w5100_stop() in w5100_suspend()
 - Call w5100_open() in w5100_resume()
 - Issue a reset w5100_open()
 - Call netif_stop_queue() earlier in w5100_stop() to avoid race
   condition
 - Prevent w5100_rx_work() from re-enabling the interrupt
 - Add a retry mechanism when reading PHYCFGR
 - Protect netif_device_attach|detach behind a mutex

Link to v10: https://patch.msgid.link/20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net
Sashiko: https://sashiko.dev/#/patchset/20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net
Clashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-wiznet-link-gpio-v10-0-5874a7a147a2%40marmottus.net

v9 -> v10:
 - Address Sashiko review
  - Always schedule the restart work to avoid atomic context
  - Move netif_device_detach before disabling irq in w5100_suspend
  - Flush rx/tx queues in w5100_remove

Link to v9: https://patch.msgid.link/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net
Sashiko: https://sashiko.dev/#/patchset/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net
Clashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d%40marmottus.net

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
 drivers/net/ethernet/wiznet/w5100.c                | 234 ++++++++++++++++++---
 4 files changed, 299 insertions(+), 80 deletions(-)
---
base-commit: 528de6832b2194ae0b1d62b0925e0ac6cad1087c
change-id: 20260804-wiznet-link-gpio-796f36cd14f9

