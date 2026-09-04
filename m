Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B401FC0EA;
	Fri,  4 Sep 2026 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525384; cv=none; b=XxZMJ1WVb8Ap5/w9MROQFM9zQb8Zmialo3GVSkKgOEDwW7xz/BaSArNzmMooH/PXbGcYubCXgeQnmoSalqR01K48I9OMwY9CoqaAI1RVQzJzWuWN70PGGtkP8WCGSJb26CiNLR06nCuAHSSQoKSDDbAXX3Nb/tvQFaWAfAz3lBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525384; c=relaxed/simple;
	bh=ou540b36wgxIFFDshUYa45c0uA1r7r5PaqF8iDjBaEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YBf9b+ubIEqyaFWcvK7yN8CxqF+bZ51sT9BcWOyaufVxp9/WCALoPycJ63yCMWrkhoMQ2nAGNJS/vyDIZEQm9LKadToAyYMAOFqayda/00CRVDF8WJ5WKnW/2tgTg/8KzG2iqQdy2vbjh7+HdPDXr4Oy6UU5Yi0FhojEa9jWAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=TNLIOOHt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="TNLIOOHt"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 067693E95D;
	Fri,  4 Sep 2026 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788525374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K1EjrFVu4O9teuB6km71Nkaxnc0sngk2FX4oBosuhN4=;
	b=TNLIOOHt5gM9ZmCwCPS9QoNYo8GMZ+NFQwxa+aMOy+3gCeHb6jy9uAusKONsIg6G1r787Z
	c4nIg8UdvaemCHYn9d2upda1RAe82m13yKHjE2IwYvXT5ycGYHlN1z67FpChBnhmyvTKrO
	5VbFfP5XHSwR3ohhmaQsE9zdIyoRzR8cEMfQn4n7l2BPXXuyanU53LhX0uxjv8gRV3ZR7C
	jag47iWhSQF16hM+EOYleA91V84VepTo5+/rhjooRqJg/kq4ZaIVyXlG5ewU0rdOhAKmBN
	9jY5DqWSlveABQx/qgzvPDNRXjlOaVyp17TIGjkgE6hnMy5DS7GlV2gGpSwLwQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v7 0/3] w5100: restore GPIO-based link detection
Date: Fri, 04 Sep 2026 14:35:57 +0200
Message-Id: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC27mmoC/4XPTW7DIBAF4KtErEvF7xhn1XtUWWAYEtrGjgxx0
 ka+e7G7sSqqLke8+R7zIAnHiInsdw8y4hRTHPoyNE874k62PyKNvsxEMAHMMEVv8avHTD9i/06
 PlzjQpoUgwXmuQkvK2mXEEO8r+UqWaI/3TA4/L+navaHLi7hkTzHlYfxc2ye+bvxdNHHKaQcCg
 lehca57OdvxPOR8Tc8luVZM4j9EUEZlxz1zpmFB6hoitwhUEFkQLYVXlitpWBVRG4TzCqIKorw
 OjbfGaGtqiN4isoLoglhXToUglOKyhsAGkbWfwIJ0iOC0awHwNzLP8zerI6DRKQIAAA==
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
X-GND-Score: -100
X-GND-Cause: dmFkZTE8MBYIzNAxnKVvFgMYG2KBNhoWuvYqKJThqd6hsZY6WnnuLzIjxGcmr5ZvQOh48Nod6E27xEKBpH7J00WVujmZwxs+M444dcG1CDAUvaIfcBitSA/P1aJ/f4kPnoxMH54iektaoErTOyxEAqEquj+IBsjJnbnPZTX1fapSxkPZTVRvflDiZm5gEcWGAuG8ZRHh+JXGrBbojgHAsUC4g10DbjrClqdzarloWIZp6ZXQFpOWxKYbge9MLTiJ3TVUgavAdcUQ0eoHlgVHlhPwVRl7+TXzcomFrC34vo5ELnv7lPZ6qwJg/wdqeWwoeElaLe5RyUZPrLpuAoKUl0UjWDcbtHcHG87YAOuXYFuA86REamu3/qUdRDmN/Row5XvYYJCiG6o0DFA62LZyOwVr0WbXFex0N4B4mCZEeMmu72NPewmQ0EpFq+IXsRaPybsjVJy0DxHYB+n0CLOiFtv1s3yhxtzSZO2mgKAxCcOPPaYSBahwKiDwqGBkqS88F7y4SWJgI3EfXU6r8D7OenewvvocLFN/SsU3SvVPihlmRjTOu9Pj2CrZkvh3j8XNfjbxEYFwex44CuIAR3GsUtPrxQyEtkVBy3mAIPbp9EatvAvoEIYRzQTEATTZwJrP1/IxkzBLYwksmKGN5vygCqTgbIFc7ludrEH3dLpo2+CfjxpA7w
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

Arthur Crepin Leblond

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
- Link to v6: https://patch.msgid.link/20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net
- Link to v5: https://patch.msgid.link/20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net
- Link to v4: https://patch.msgid.link/20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net
- Link to v3: https://patch.msgid.link/20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net
- Link to v2: https://patch.msgid.link/20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net
- Link to v1: https://patch.msgid.link/20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net
---
Arthur Crepin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link status interrupt
      w5100: detect carrier state using link status bit and optional interrupt

 .../devicetree/bindings/net/wiznet,w5100.yaml      |  71 ++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ---------
 drivers/net/ethernet/wiznet/w5100.c                | 123 +++++++++++++++++++--
 3 files changed, 183 insertions(+), 61 deletions(-)

