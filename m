Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9A26F288;
	Tue, 15 Sep 2026 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459586; cv=none; b=X4Ueohc/uouvRng02uAVM1QtW9ryoa3EEirHMsdCcjYucpVYzxX6GdNsJ1GwYuwpOOOJ9ZyLi1UtI+2K9pxLKvfu7fWKp5F82FpmX29XT+so8uI9jwLdkvxUX6gOnJcuea3A5MlkHjdA7vSFB9kH+7EnrVizIL5iT/k5TtT/ceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459586; c=relaxed/simple;
	bh=UU0C32StnmcZOmS56b0hIrUs1r6rNmrUSZ+lRJl/HmQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mYfwHlQUemhbdZ/okegKFWofb2ECWf9YKu533LnzPtYoI4BC4xLb/8JDyDQtAZGaWnvC/fwOVFYR5QyYwDgY78iBoRqdAmHblc9URvhAt4aM6CR4EuYZinoXF6B9EdLAl2qmwteDc2+bDjZKbmVgMCiopy930v8+6FHNfVUbYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=LXantVmz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="LXantVmz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EA0B3EDC5;
	Tue, 15 Sep 2026 08:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789459575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYa+Xp7+0OhWxKPAeNGbQ8TsgkzfpTwSxc+u7sC95co=;
	b=LXantVmzdQRKAyMxL3XVTXIWeJsGrZGGkma1L62WvRDaQr33uTA88YMUpk/TapnmFSaWrH
	ryUMYn/b1iSq5GY14II1T7/rrFYUN4nV9P+MQmFSRjVU8DtGdWqbs8eDEwXXELnGzFzKvn
	vv1SKHYUWpIjGbwVsrGN0nLoURy6pm2yvCdFMdZcovKkLGVOTpWre8S25dMuDMlnd1MUmw
	pGMsaxNI8L+jgYipl/pzPWNceXcBzy6o/Y4MtDOM/X+aDMVhGJJXSO359v5Z93G00NiWq+
	zPXaIXq4lnmYFBvWtfJ2wxH4fRBFk14dp41vk+N0SGhLmoq1ji8Ym5HlkTigFQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v8 0/3] w5100: restore GPIO-based link detection
Date: Tue, 15 Sep 2026 10:06:01 +0200
Message-Id: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGn8qGoC/4XQy07DMBAF0F+pvMbIz7HDiv9ALPxsDTSpYjdtq
 fLvOGFBhIxYjnznXNt3lMOYQkZPuzsaw5RyGvo66IcdcgfT7wNOvs6IEQZEE4Ev6bMPBX+k/h3
 vT2nAqoPIwXkqYofq2mkMMV1X8gUt0T5cC3r9Psln+xZcWcQle0i5DONtbZ/ouvF30UQxxRYYR
 C+ics4+H814HEo558eaXCsm9h/CMMHcUk+cViRy2UL4FoEGwisiOfPCUME1aSJig1DaQERFhJd
 ReaO1NLqFyC3CG4isiHH1qRCZEJS3ENggvHUTWBAbAjjpOoDQQtQP0jU/VlUEukioVaQq8Tcyz
 /MXt5tYPW4CAAA=
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
X-GND-Cause: dmFkZTE8fWi5zv/QCllA7nxKJSW4r4Y1wPKHmrL73BTozW5Nm1AIw1swA0Zca483q7ZSmlPGTOsjKrfevEC/wArZ0BuDqsg/tRKcMFnMHW/GptC6WR2ObCXrNzMn0r3RE2MosB0FV+NNan4GKmc8uq9bLxBiULu1xpXGV1mReBvjcCVVczFpMRHAAymmUo+TEl2KQvY9nlyJELX0dvcuNe9DUL1i3K36J+asYsmunsNX8VKQVjWZe4Ffjy4fj4DccEeYWN+AWszURLAVK4xg8JeLqwOsE3ynSWi1QyaDtDT01ayakpyPwFkZq4HjATbzxMLdFjvvb4LCbylJRNYqyMvyigq1GqbzMJe0MbFLeyrcZGEiUH34dbkc97g08qJ2R5fXs83NiTPL08teqbY/koMHHtvyAZmBHy0B22WT1tVhSTauJky+jmYS4sn1B45AaVtV4DblADif43Qbib5U/LMnAIGx7ORKniSvPZ09Z3jzK3O/iy1hH4biIlaAClwSIGpgogfJWVK+VlgmqdMrFO1fut704mcBci0lTJfTgdc4+hv01ANekjXyhl62hyRCJoyanAuTYeNEoYdO8yqd2rPHTzvZigacLKVQWwJEbFUEa40gw8t2YCjq7c8sdHq3OUbqOlGiMRIGKwB+SJnwJBzeCDl0ynVFwGHwqck7ggtmvXR6lw

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

 .../devicetree/bindings/net/wiznet,w5100.yaml      |  92 ++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ------
 MAINTAINERS                                        |   7 +
 drivers/net/ethernet/wiznet/w5100.c                | 192 +++++++++++++++++++--
 4 files changed, 272 insertions(+), 69 deletions(-)
---
base-commit: 272a65db243bfa34b9277632830e0e06d7e3518e
change-id: 20260804-wiznet-link-gpio-796f36cd14f9

