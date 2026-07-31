Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBD44AB72
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515449; cv=none; b=pDUa82YOnyoCh1hFKq6U6YbsHVWS8xp3cx/iHZTRN+iw+reaHVyl0N+803RvjGy+psSpqmi6o4a+7fhWahugzI5tFXMvXifB+UE3jTlv7AxF/Uqnbg1ux50kt9siGN6v//5CfMKE0yAgdwj/VsGkaq8O+/J0TYDwWGEVaIva8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515449; c=relaxed/simple;
	bh=w35lwaZM5Jhv5tWlfxuQgAkqn1ey5k+A/02M2sV6IqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ikp+9Hr+jJ8q9tD8G4d3ey9k6MVH8LTpYputUsKbPMp559hzArQusdrsDb7SNKaOnfUNS5J182Ftm69ceYnEhuXY9/neqzJbIJFTd8r9WmkijRJEwGRppKElvV3eg9QeGeysJwdZuFYyoQ7ERDhF+yvZYW1Vb7TTR7QYaRTPaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Awsyaxfi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Awsyaxfi"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so609109f8f.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785515446; x=1786120246; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B01D71Y0rA5zgk1TYOrIFEwTDt7QQ32kG9Mc4Wkc7Jw=;
        b=Awsyaxfi3zyDGyTgYhX0zFV86wpnDNb68K8rwbrQ5ZxVR8w54qnBlQo9UMiutEU4L5
         pHSpDfnWh8/sM0PPqq86haNWdO9zOamICgDFYJ8+xRAIi24JqN9jMWGny7LMLC/nvS4X
         TAw93zJ9wtOG85tW0Ja8bNtpqUYv+SWSbQ+WM5EDpTeCf0qJ/+4vVrriukVTgOfxYmY6
         9HtuWM9ttAAZ+MLWkfc9ow9yGMg3IbIbEHq51I+dDXtXBA+ow5NpjqWUDRx5ShWqf1IH
         NeqVOmZ1l3cYcpEEeqGtWxVob632yvDu6g15p+pQtCudal8ikYwJ3JcJa+FSZVvvKBtz
         GV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515446; x=1786120246;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B01D71Y0rA5zgk1TYOrIFEwTDt7QQ32kG9Mc4Wkc7Jw=;
        b=cPeSejjhsRMb9HoFX5f8v92FzQxOH6zEX9skK8kofdxpau3PAE50LHACUcA8qm3RCH
         T5lV/7ReiAyBr7BGxOiF/deL23heVJcMW/ZIP2PM2rRkVg7CQ4QfNxaJe7+PHQIye/21
         7srFja79yEa7Z/9959b7nwgUBKirJcJU+LM+fizYt3wPJZK1cvJVcmIlq5+qTR92G+QH
         9DbhS2FZcdf4s3U7XHfvG3z6wYd33lqSxkBmgYmCp67VBMoBZANhVvnsnnT8PmcpSvbu
         yq6UgkT9Q4ZCh4O/g7FeOEgOMF+9RgzR7+DWxEQu+m1T4X9DV9j9GoIDBhqc/CfmS2Bd
         DPLg==
X-Gm-Message-State: AOJu0YyA0ChYuzPq41iarjEJ8Tp6xAQdq4rfL/2pUSXaqVPTvyHLC1u1
	LNM7lcFV0POvoyuYb2CgOCZtpGMWpMtXtJb2ZACOO93Tpz+FGFepUIDMcZ/SHFDMLwiUyBFYYx3
	sDqtP
X-Gm-Gg: AR+sD13FeUTSS7XT5ylp7eckckUISjmCmsclQhg9i2Okw57L42CJLkZQEiGM/lVzBLY
	cTnDmCVrhYE2HiIqADPe8iQJDtrP/6NvjtEnrxozsUhpn7XXTGmV7RJqtRgMXitK+6JymcgU1v0
	BX3ibNoOLdAZoJktfb6P1xZhEb57xIu/xFzTgmC1pusZAubfF8wZRv8CWISobchnKqOhDB7XLBf
	njzf9RUUbZcN4gMT+m6wHvOxr7r2h7+5GtYw+JwppNBajDyB2pqIbGI/3LvnnGN8+EODQcuSJMW
	Zjr8hLeRpsiYYAeItCk5wjs7Y+Dpmzfn1N1QK4qYS0Pvs/cQIotP+y2Yye6NUmC5vXISNS2g7sS
	YAhjoYhuc9WNphelrvUirz6dnJ/I1Ocy/oXi6JNb/O0PqiDEKrjm9YaATKFdvpQeRJzDNy3RimL
	xP1pn1Od+8TtNN7qeXAToA6OlOQ/UFJHKFg2W8WE2LAS2iQSCqdBw40tFN5Q==
X-Received: by 2002:a05:6000:615:b0:47f:762f:32a9 with SMTP id ffacd0b85a97d-47fd72a8f3fmr672008f8f.12.1785515445887;
        Fri, 31 Jul 2026 09:30:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d00b:bc94:65a:a73d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd456262bsm5900050f8f.17.2026.07.31.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:30:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH RFC/RFT 0/2] net: stmmac: Add support for Allwinner A733
 GMAC210
Date: Fri, 31 Jul 2026 18:30:25 +0200
Message-Id: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHNbGoC/yXMzwqCQBCA8VeROTe0f0iha+ADiLfosK6TTdi67
 GgF4ru31fHjg98KQolJ4FiskOjJwlPIoXcF+JsLAyH3ucEoU6rKanTj+OIQKKGrrMXh4TzKEuO
 UZtSl7XrSyuuDgSzERFd+//QzNPVp39QtXP5Dlu5Ofv7asG0fT1HmGogAAAA=
X-Change-ID: 20260731-allwinner-a733-gmac-support-163bde10c152
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=w35lwaZM5Jhv5tWlfxuQgAkqn1ey5k+A/02M2sV6IqQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqbM2wWoLP6AQ9cI4VA8q5m/5+1cKrwSXpM2W6M
 e/cJohJsgKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamzNsAAKCRDm/A8cN/La
 hVL6D/4331XwVduIAIJWF+PeOpvRZZDsSD9BtI2hgcNm6X2vDunqVGtocqmr56Jkh2ndnuyheam
 AFy0FMb5r1OfNFGb4MM4mA06458dALYQ1wwTE2cJm2MfDm84tsnEs8wZE6Q+4FJfOalOsTvRJeA
 FnZq8tRRhMa8DwM+lqd8jiRwOrOWoEXqZWh/6GAufDFGT3Kdwsff+h7hBT6D2SYixP9xdOHjaMz
 hEBBm20A+US5YRsSqVpNiplu5yQcPU1yjOoSIead3uK7OW7L/fcfkYraoH+R/8OTrneEMY8l4si
 TobSWyrQJYZU2N9pASoqLqHs0YECoOJ64Ip6U2LAv0t5PzG96h9tVr0bpSUfBcaf39VwIKfA3ys
 dD2ewdOB80Uz4FmanIWRFHcQRlbLFxvcy/4DQzDjIShGbrbo5p5Wrztv0vf2phHY7lDlUtTTLwA
 Tz5u/7zqA0l3ElKWPlugOpTWx3lOmcOcuSY1kKb//Yn5oiv4omwKcMN5PYQZhy6gygtDowA0uVT
 dAcbNSws2YqesuL60imTCz0PgGcWrz3yQV717FFKg7rSdBodLwXwA9D5M0pvaccOmz+SQgzxAMg
 E+7rQnDLEnEiSIGlV+warlyT649gI9lDTHgmDPStcy0IR8EawQlVN+SMzvFSm9XG9AKMlsVxJ24
 Q1BqcpuHSlezGCQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 GMAC210 is a DesignWare MAC 5.20 with an Allwinner glue close to
the A523 GMAC200 already supported by dwmac-sun55i, but with a few
significant differences:

 * The glue configuration registers are a dedicated MMIO region of the
   controller instead of a syscon register.
 * That region is inside the controller reset domain, so the reset must be
   released before the configuration is written, and must not be asserted
   again afterwards or the configuration is lost.
 * The DMA channels have their own interrupt lines.
 * A PTP reference clock and an AHB reset are needed.
 * The controllers do not require a power domain (AFAIK).
 * The TX clock delay value is 5 bits wide instead of 3, split over 2
   register fields.

The DT changes for the A733 and the Cubie A7A board are not part of this
series and will be sent separately through the sunxi tree.

Tested on a Cubie A7A, RGMII with an external PHY on GMAC0.

Full disclosure: at the moment there is a problem with EEE/LPI while
testing on the Cubie A7A. If the device stays in LPI mode long enough, the
link sometimes (but not always) goes down, coming back up when the device
exits LPI mode.

I'm currently working around the problem by adding the following
properties to the PHY node:

	eee-broken-100tx;
	eee-broken-1000t;

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      dt-bindings: net: sun8i-emac: Add A733 GMAC210 compatible
      net: stmmac: Add support for Allwinner A733 GMAC210

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 130 +++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c | 145 ++++++++++++++++++---
 2 files changed, 242 insertions(+), 33 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260731-allwinner-a733-gmac-support-163bde10c152

Best regards,
--  
Jerome

