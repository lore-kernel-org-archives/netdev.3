Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6445FFD1;
	Tue,  4 Aug 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866312; cv=none; b=aEON8MiHUZwAAXGosKVkoWjdPtovmqooK9f+29cBLD7Y01bb6DXvg7/i8dtEAxLBlxX5QHX5NHZEkhQ0GVYzqbO+T9pWRt8I0pERuSbmyeoZfw7vFITztukvZthVmByODG/8PrkUT7HgWGrtRqqgkftH5e9P1gZEdYkQ79dGgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866312; c=relaxed/simple;
	bh=mJZU2WoUBytv26h8J+oRK/kVN+e1o8UnVnMWNWUApmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ATpWTHJIUmgTXoPvdzaHqBkgmQaxpGb/rQEvsG0sfyTFS3GSZMv3qroPUB8G+Osah6xxNun/EefDtk7WsTxwNQ0QR9KicpbtmPF3RESyxMmdm9CN/WAAPyGGOSGN/s5JUnF3hrJCbGhxshPQbooApz6waqcrDazdjdAmfzZCPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=a8j1tS5k; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="a8j1tS5k"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 10BBA581722;
	Tue,  4 Aug 2026 17:41:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69C823F55D;
	Tue,  4 Aug 2026 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785865262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C/3hwSUbVXmVIoktQATY3b63u+4nlf258C0oF+Fy840=;
	b=a8j1tS5kuxF6zJzqqk3GP2mYY9B/DSFsTKonFkkyDGu27XaLSWBhaVd/rCZPvqtTbu9HWx
	6MEtIoouMRxxAS7ioWstykBFlYtGIAQHR7kb7sNnR/xehZORlNUtvWVFg6KcXklxZAoZ1a
	H9ehUiMBeX5/85N2WzigchsULKtnoykaqEZd0WjM2dOy+BRR7KMhsSmzPTTeK6DdKxZcGP
	jr0y6TEVrqJRfhfeCjG/53myM8sy4SX96+Iwpv5d6OMnUg0E9J+IHl+22UtKzJgZLTvhjt
	LWQGFpacSXfk7b1eYVoG+d6/OpCUgzb2wPoeV6V6yftQPZCUOsvIJTa8NQzc1A==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Subject: [PATCH v2 0/2] w5100: restore GPIO-based link detection
Date: Tue, 04 Aug 2026 19:40:55 +0200
Message-Id: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACckcmoC/32Nyw6CMBBFf4XM2hpaSRFX/IdhAWUKo9KStuCD8
 O8W3Ls8ybnnLuDREXq4JAs4nMmTNRHEIQHV16ZDRm1kEKmQ6TnN2JM+BgN7kLmzbiTL8kLqk1Q
 tz3QBcTY61PTak9fqx35qbqjC1tmMnnyw7r1/znzz/uRnzjhrpJC6zXSuVFMOtRtsCJM/RhOqd
 V2/bcn53MYAAAA=
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
X-GND-Cause: dmFkZTGd2becd1qreqhUDsJWwEf1z6zxw1YOK5bOHw/QGB5mjuuQKxd7AZsVYdVybhhg89vVJCUUK+d1Y9gOXvgkZ+KqkHVLWriCbjfYM9yzwLJz2MupHGS21A/wCj3/s18uIGRg/Ih6d7LY9H418XA9+uGijkJmU9YfkwE2SGIGXPMclXgvCVIGY/ikOTORMuMrJQD1Ao2PgDE5dAC8OkJfZvUxCOCkbyd2Lb1IQADl1NHvSOrBEltp3y6SIx7e2d74Uczdn/JrXeBCu9UJbzrEdsIQ+eAtLJf072mJCy6chOkI7xiy19DJEmng5DujvL3e1WTCnTvULCAktkyYUICE1KC/VST9cLjMn8dE/9yeMSd8ee9sXPLr85dBd91FhjKcMTZGSLvuleazfNF1SYgORurQUcO+iVG1UTll7z4jMMF6DleILYOKFpT9ZU2Qm5N/XLu0Pyogggl4653G4eiIiSPF+qeT6JKlDFZ/duTesUmpvwOI0lYw6vUilNdY1pLnSK9dqCcERFRhH96ynB3HmXI47A2Z3qYYGPxr/q9/Kseu7GX4OlbRRIAXl4B3c4h+XtCs7+TtmDeYVZn0taseAZk9mvtPu7fNSprJR0jC/OVYyoGFBjMwp2ouYOOvd9hrk3r0ry3L1VMMTPATcolQ3RBishoCaG2CCkmVNaZswNTTgQ
X-GND-State: clean
X-GND-Score: -100

Hi,

I am using the W5500 on a Raspberry Pi and rely on the link GPIO for
the carrier detection.
If we could bring it back, I would greatly appreciate.

Thank you!

Arthur Crépin Leblond

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
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
Arthur Crépin Leblond (2):
      w5100: restore GPIO-based link detection
      dt-bindings: net: convert wiznet,w5x00 to YAML

 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ----------
 .../devicetree/bindings/net/wiznet,w5x00.yaml      | 103 +++++++++++++++++++++
 drivers/net/ethernet/wiznet/w5100.c                |  71 ++++++++++++++
 3 files changed, 174 insertions(+), 50 deletions(-)

