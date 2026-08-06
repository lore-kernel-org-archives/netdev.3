Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0A30D41F;
	Thu,  6 Aug 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028427; cv=none; b=a8daNuIkuPRKWvUR0Syj2YVYIbMbDS1Od0uVAYy58knLskmFtEtRCA60cfEiJAEcESZ5dQQxzkNuZn7w/gYeEPYeIvcbYPQ14JciZzgwWOE75KGBkh60u5g3MAumjr6QjEk/X8lElKjPqogCp3PLilrh+gUVnzhO85ly0ME6Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028427; c=relaxed/simple;
	bh=/k58kwK86VW1y+0UtncjWAe9oy6ZE0qOCdCdYLNAA+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cqz2vhix+wwIjQSYWxF8Bf0d8dUa9lvr78nLrS5czQnYyA1wG6lB3lirL9/i9icpybChjajCeEbNN5yvpmNPncCJfzWXSrBOqqRnNWQm1nGvJtrRHG9U+FTDMotazKnIZK9U/lksD9hhO1b+0TkVHELfV1KDf8QiTURCcEZIJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=Eux5Bw/C; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="Eux5Bw/C"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52C693ECD8;
	Thu,  6 Aug 2026 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786028417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=clMVC5LUX1+E92dyP5cXmll/qf/sq/hBpoqOSLqsYwU=;
	b=Eux5Bw/CYu8AkfOU8I7JAvvyhugXCqVKOWW8JbkiL+iRpLqshq6RbKtd2UoPpZFwIoYACk
	d2FmUzBBMHrL9TgchXkpPbyJ+kRVh69FZOTPtajl47Thc9Y2qP89mzNGZelhejyAie7/0p
	eboISxY4P4ofcJi/ZSyC1b8FWG26zTPsdN1dT1KyPrnouCSoOzbXRhKthJEbz6JQBvCAcX
	ZLiVCIuP8ngN+dOJ9I3A6gS+uvxrBzuxSNR/59RbS3CD20BO+c40vZllp6Lrx03WLVZCmv
	g+K47Zh9YzI+/eUxDHTfm1efwunpQRb7A2g/BIwCB4RzphAA5hGkeo0kntBbkw==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Subject: [PATCH net-next v3 0/3] w5100: restore GPIO-based link detection
Date: Thu, 06 Aug 2026 16:59:59 +0200
Message-Id: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG+hdGoC/4WNQQ6CMBREr0K69pu2YAFX3sO4gNLCV2lJWxAl3
 F3AnYlxOZmZ9ybilUPlyTGaiFMDerRmCfEuIrIpTK0AqyUTTrmgGU3ggS+jAtzR3KDu0EKaCx0
 LWbFE52S5dU5pHDfkmaxTo8ZALp/G9+VVybAS122DPlj33OwD2x6/RQMDBqXgQleJTqUsT23hW
 htC7/fLclMM/B+EA4W4ZBWVWUp1fPiGzPP8Bkdqe7EVAQAA
X-Change-ID: 20260804-wiznet-link-gpio-796f36cd14f9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTE+BoCGVM/NeU3q/LOw0ka76dXK29SFJ36BkUjZjsCEF+PhQko1N6OK/41jpMuOrK6fHxyZMgEml5suXcsakV1EpqzTA/WrdXMGD1Epf3KydaVijP8UCpXZMk5LyZ9V+BmDwkvVCfKZmBlx1YCYwgbwhg6JsDrmHwb0N22ipTSQnm+xDr3A7Dq41+vV/h/G2BPF7ERv+lnRa6QsF3L/RmljbxYRUpspuen3TcmSn4eXqW/PBbYFFNZ7EsJ6xGNHW6VYGpVFKRp8BFhFMnCwVZM+8f+2P9dMDS0JrZeS5Cy6bobH1xhyBWSj5A6XMBo/UxTeB5spJQ7vIrcGneGA1UwEUasDPvPdHNvxqYm0WElFK6+heK67vPExPMqQZc5scufsNVQurczPFouUzEuDFsjx3Dkn9JpxBcECu8JjS6/5MRDLvbkQ//J5GjQ7alrVdiHm1gnSDwdflTTRx/KCMpuF2obgQAuZvmhi3HJEFq6jvSknQSa13e1pXDR3x+hGmPTCEJ12d8oRFLbJYzLwh/C69O+w1BfW/aCcfgC7zXgYYghkAf7T9yDMUWnCN03leEj6wIpTowIIz7CsxeGwIw+yAUXqvQFm3Z+l2vOpAU/s9pcSFS68D9ZLacdt3LxjT1aatCpAKSNNi0O9I0JXIwaucuyayh5f0J+40fI2JiaBrQ
X-GND-State: clean

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

Arthur Crépin Leblond

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
Changes in v3:
- Change cover letter
- Fix DT binding errors
- Use the Link Status bit of the PHY Configuration Register
- Use the LINKLED gpio binding for change detection only
- Link to v2: https://patch.msgid.link/20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net

Changes in v2:
- Convert device tree binding to YAML
- Use devm_request_threaded_irq instead of request_any_context_irq
- Use devm_gpiod_get_optional instead of gpiod_get_optional
- Call dev_err_probe on gpiod_to_irq failure
- Remove link_irq from priv
- Use a fixed string for the IRQ name
- Remove empty new lines
- Link to v1: https://patch.msgid.link/20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net
---
Arthur Crépin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link-gpios
      w5100: detect carrier state using link status bit

 .../devicetree/bindings/net/wiznet,w5100.yaml      | 74 ++++++++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ---------------
 drivers/net/ethernet/wiznet/w5100.c                | 70 ++++++++++++++++++++
 3 files changed, 144 insertions(+), 50 deletions(-)

