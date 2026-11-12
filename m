Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504351;
	b=vaDKNKSG1LqvvvRT/VnVEcbn0F7eEeFbJiTJISrUzROWMHMUtCcrymB4ktYqf4EOBYyb
	 U5iJb5QtnqefEHziyW5kHL7bJb7gMiQRi+44CyzZmt32uYh07eR4jddJFShRjiTq+w+Ry
	 6i87mN2453UbfEQ2rRZEfP2ITJEM8YHVq0GKRm5tgUHwcIOyXq9q6SPYtbIogD+OJWwtz
	 aX2PjcUrroLvk+tEHWnek7DGNi3tt1bt7ihFJdU41TVWPnW0DCfa9Zr5n2rnIj3DPeg/Q
	 Q+COLyZhoFe0D2/X0o2sOIM7YfrdVsU14O2SLsYhKu4QOsr2RigL4xq5nfI6hv4vyAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504351;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NIrFK24odepEzsKq8775JoP2Ppb3xaqNwDlitT4776Q=;
	b=1x66DG0zkCIM/5MbyyHaN5F+b5ZC0joIXnXDdw+1SQtWW/zPAFFdQfaotJ5huerRO1wC
	 2ot5iAkJbl3bPmkFfTUo1YAprfXn7k3SzoZnmLl/Y8fu//Ex8zL/wvRijnTTwr8rRVXLs
	 6QpOq5AgF5L/eQIBnDeL3hrgbhOWX+vY3qQadN3O6my+kS/qKGb+MhIgB8cBdzbAvDC3q
	 YQfTv5IubB8v2cXRRsvzaPC9AasGM82n1NaqiQ9l9KikwJ+QEL2BP59HaRFAoyS/Ib1pU
	 tvK6McJISXdQBEBah++FPoghDtJkHk7PfaLo96AARvBJ7EFehSNctXMYZTe6+Dg65Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bp8E1/vW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45778606A32E;
	Thu, 12 Nov 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp8E1/vW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504351;
	b=3tH6fEr11rsVTo9EBj9rIEUKR32SyT8VEzbxBx6yJ6Cmi7z+ljojBGBRgZgfOhFe3Xux
	 1Fgm3H3wmYClvfK27hHut5F8rNNDWIW0gXpyr2UtuJJBygkkrFsjk65hrhSXcMB7k4SmM
	 Rk//U/HYQzV1HDnEwyaO2b1/HPrxBdYhJvnffiWxCXavqtu/Ze3rjcM1syztG3YuuFK5H
	 hZPI6ZWccklWC52CnV1fUEHVgWjX36dhbbzv8FTWaqp3cP4mDWM6kU/u/pNx1YcvHY+ky
	 DJ86ZK+ogBl/iobqOfsH3Xvm1WDIfqultpnbDV8+Z5dcZWzmSW3e3til3SIY4G3U+tQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504351;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NIrFK24odepEzsKq8775JoP2Ppb3xaqNwDlitT4776Q=;
	b=FXE8dw/ZYVkmPiWFW9k9Pc/54Pu3/IfXtRWPu2vRb3NzmarBxEdB8k5m3Kx6aUUqlXYc
	 C1xDU+cYcFzeHA0wSLDB4FxnpZ+rUDLos46rjS6lkdltagnn2m3wGv36aT9l/rXkgqvfu
	 ahRrKHVJacegLItCMHqnv8/aRU/7RgmBdMa3dVBTMFvo21TvB/kznay54vcXzZYu+oSHi
	 tstjxycHogZFp//wXbyvY+HgzepRQhLtRi7NfMDfh3v/rrIHXXKyfkHYILnCBzjjyNf9q
	 BSCNiVgxt/zDoVOEGHdQ/2eiX2Hi/2KDY8XfpMloIiiZaz4gymkNF8mobl+MBuEv8TA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 240FA1F000C4;
	Thu, 12 Nov 2026 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504351;
	bh=NIrFK24odepEzsKq8775JoP2Ppb3xaqNwDlitT4776Q=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=bp8E1/vWEXhWem9ALBZTa89HPSo3JUtY5v05p39wHD7sYLn32N6rnDTtAj/MkVZ2b
	 aoaQZu3lIKFf055KHQhFN905L3XMgS2uycHuX1ZCwMqNAJo8N4g99JhxexaGPHDCa1
	 R7IH9XNaYppwNfn8I6ZPTyyc105Qc7aNj+nnPhzIwIkiVYtN45bH4hphBq0W8rhi/2
	 2ZFXSGqcVaZpUKRrIe2vo+xTftBhOzL+OCONEuZIJq85Mr61HbikxYu1Xh5Z/wzDV1
	 7VgMcJMWUdLYp12MnhmpZRI93q95ozxcF8dj/AvDQXkNeI++TQme46S4FWQxhR8T6A
	 vNPHEYYY6/72w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7491545A78;
	Thu, 12 Nov 2026 17:25:49 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Subject: [PATCH net-next v3 0/2] nfc: s3fwrn5: Add optional pvdd-supply
Date: Thu, 12 Nov 2026 19:25:48 +0200
Message-Id: <20261112-m52xq-nfc-netdev-v3-0-725a61ce4148@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAJz29WoC/x2Myw5AMBAAf0X2bBOtqMeviAO62IOibaSJ+Hcbx
 0lm5oFAnilAlz3g6ebAhxMo8wzmbXQrIVth0IU2SimNe6XThW6Z0VG0dGNdtJVpJmOssiDZ6Wn
 h9C97EEe8FGF43w88qg5dbAAAAA==
X-Change-ID: 20261112-m52xq-nfc-netdev-709568b66d1d
To: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504348; l=1231;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=FPzxZu2nWQWrhcZEqMnLi0tLkX9iDWIfqKNtKI9gkAw=;
 b=gW9J7ls4k0dEC8Q5IvGh+B9T+zT1xb+yXjtYd6yr7gOL8mQ5eU5z7mcN9UIzDmToSCjxzav73
 3knriemU/c+DKtD0pXO/wE+34P5h5QQQNYha+Pnh0PIGoiKfIBL6S2S
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com

The Samsung S3FWRN5 NFC chip has a PVDD supply pin. On the Samsung
Galaxy M52 5G (sm7325) it is fed by a PMIC regulator that is not
always-on, so the driver has to enable it. These two patches add the
optional supply to the binding and make the driver enable it before the
enable GPIO is driven.

They were part of the series "arm64: dts: qcom: Add Samsung Galaxy M52
5G" (v2). As suggested by Krzysztof, they are split out and resent for
net-next. The DTS patches stay in the Qualcomm series; the DTS node uses
pvdd-supply only after this binding is merged.

Changes since v2 (as part of the DTS series):
 - sent as a separate series with the net-next prefix
 - no code changes, Reviewed-by from Krzysztof kept

---
Asdlerto Korry (2):
      dt-bindings: net: nfc: samsung,s3fwrn5: Add pvdd-supply
      nfc: s3fwrn5: i2c: Enable the pvdd supply

 Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml | 5 +++++
 drivers/nfc/s3fwrn5/i2c.c                                      | 7 +++++++
 2 files changed, 12 insertions(+)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261112-m52xq-nfc-netdev-709568b66d1d

Best regards,
-- 
Asdlerto Korry <korryasdlerto@gmail.com>


