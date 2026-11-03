Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723839;
	b=S1ER3SXAAZDBRBusW7B/QlEmDeDGauiD3yN1z1F79D+SkhNFobnJf958ElVQ+0qUiIBn
	 ElRZ6wiCnrAO5oZBqZTg0Q3aRU9I7B6lM334bavoz0LGhGD/Zxs37v4WTKzTQ814HLogj
	 mq5n5yFaR+h4nzT0e8ABO+ODIYEdqYqctxPFCqIxjfhnrriEPHDZqk5uWJKlZt15iJpHQ
	 PolR6kP3D6VQuGgwJ3PQWR0EYkOroL9F55qI2ubmoBOcEV2Ygmj+rwJcLT8n4kuo0s2JG
	 askSJ60spTwXQWNfkUJbTHMFvChzMfUGxjDHfYCXvvEmpBjKNFPN1H7WPnZZGAd+95g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723839;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Jpxt/nQGal/nc4TuRsev6IcXoTzVp5Y6wAOXrs7jBpA=;
	b=mFQV7VEh8CXFkv7M7o+QXYHDf3RTZHJ0CQjZAYH+EpRqKqAMDGtPqRKmSWa18CK1PkmG
	 48trnGtk4dpMNtEDe8NO4RwU7WC937rFwxkNDP3xZMhrhKgjP6y88Tu9y2qkOCEn1yL4A
	 /rc6ziy7fE9TXEYZLKYiaeR605PtjWH8xon7gVM6N6mJJT7pKkLkyyadNSfXqcYAl1HIL
	 UrSfcnybho1aOZ1UR+kiaGwg1Dzq0UKAaTR17isfSnkvb/jGcSn2arz0gaR1BgRE1gED0
	 QcMuIk+KG4Nu5WVQDcdgsxsfMQmJb6oP+Q8qiBHAC9auMaBFNdPySD7QK46fkkp7w/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E039606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E039606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e46e449e8so2691863f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723838; x=1794328638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jpxt/nQGal/nc4TuRsev6IcXoTzVp5Y6wAOXrs7jBpA=;
        b=YtY7nALDpT9YYMHlprxg3rBsuKAn4vl22lvIGr9UrRZqc88R5EK9WxdQ+b+QjCxgdc
         BrmklGIwFlxlCzK+EPurQEVA+XbHouOlKp8tS7ydRuCdRyU05Y5Y/FPf4QSkS3B7oySx
         E7smOtlnf8mzmqlCVbJrlxyXj7QeM1GwRHqoVLuk825XGWyDkmRfVVnE2F+h/yP5IM1A
         6vLabqbLzS5YkPm5BGhbfK446nJUbrK9H56AtkW42nixtfbUe/UcA7UoubwD/UfJAKz4
         jlpcfPRlq+1udDFUA73uZvtMIslyL3/iMdBw74TWtaCurDNZL86d4Y11vkm0hYZwQLGh
         FXig==
X-Gm-Message-State: APuU4Z+t+e3O42OdnZ4rNRTAyMatRdlQn0V1SuomzGQyssf4i6MmxDrs
	BCFn93rEtuXkJMpVFNh9CVlmm3CrpCiNRrME3I5w3Q0kSZUTYJmuLlme
X-Gm-Gg: AYBFou1xw1klV6o77T0R/H3os4f9L8XbX1LwfleEun2eewdaCn1GiT0JavS5xbKbCfg
	nTAd240XD1Bfuh8qRyFoSWIqJlqpHqCurfHpfEXKoW6jqpEWg0XpZjC+BwZ3qm9P13MhsPSWGyb
	5zW0jrOOAuGGGp/kI1sPAmWauBlfrEnClzm7yFS8e7mCsiSwDCeaVqcI6lkmKPM327F14NLYBW9
	3XK1HYJy2GejHaXKaKwbuzgn5tEI+9LpQKiOb7UMe69DlbxVUcEu7vh/BG2vFZthIU4Q3jL85Ua
	M8Z/LjSZKS9HlK3iLd3LrxNM/3ameYD1RXL84G2BX6Kq6MX0Kjjd0tt4FHwaYWYJfWs3Y0KIaOi
	smC1Jh3OQV2n9mrjENAwoCsP96anrBxUScxFHxz2j2unr35mwxuSZiikyDVN28dvt4yLJU/ph0M
	tieUMzICcrZS3+c0VOI51oZ8yCsWtX6fOsdz+L7F7G7YvNP3JtHfi3EvSM1p7kj7fwsvyjickEd
	RpEx1wVrlBk2OlNqsVt9HT8DR36yEggpmOCzLmZpQQQKN3h2cwmYBQgErUx4I8p3wJrVe2jk0ps
	lSlpN3qP59gQwG6ocHqlCv1TPY0+H3sxPFSF/RS6s4CCCspoxBrs0+KCaem/OdKYmz7KWkH8uIm
	92NaFEnkmUTyVNNb64sLyu9ujTA==
X-Received: by 2002:a5d:588e:0:b0:48e:6652:fdc9 with SMTP id ffacd0b85a97d-48e6e4f54f1mr28922601f8f.17.1793723837259;
        Tue, 03 Nov 2026 08:37:17 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:16 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Add ethernet support for the Amlogic T7
Date: Tue,  3 Nov 2026 16:37:08 +0000
Message-ID: <20261103163715.385394-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T7 has the same ethernet glue as the G12A. This adds the binding,
the driver support and the device tree nodes, and enables the port on
the Khadas VIM4.

Two clocks are new. The pipeline stage between the controller and the
DRAM has its own gate, which nothing else claims. The glue registers
sit in a block gated by sys_ethphy, so far claimed only by the MDIO
mux, which probes after the glue is programmed: every write to
PRG_ETH0/1 was lost. The T7 node lists that clock as "pclk".

The delays follow ethernet-controller.yaml: phy-mode is never changed,
the PHY adds the 2ns, and the T7 accepts only rx-internal-delay-ps, as
fine tuning. Its TX side is a quarter-period phase selector with no
small step, so tx-internal-delay-ps is not valid for it. The VIM4 is
plain rgmii-id.

Tested on v7.4-rc1 on the Khadas VIM4: 940/941Mbit/s with iperf3, no
CRC error.

Overlaps with Xianwei Zhao's "[PATCH v2 0/3] t7: add some nodes for
Amlogc t7."; I will drop or rebase whatever overlaps once we agree.

Changes since v4:
 - patch 4: the old delay code is left untouched; the T7 only gets a
   callback of its own, and the probe parsing it shares validates the
   RX value (Andrew); no NULL check on the callback (Martin)
 - 0 accepted for rx-internal-delay-ps, the T7 joins the G12A list
   (Andrew)
 - comment on the deprecated vendor delay properties (Andrew)
 - the MDIO mux and the on-chip PHY bus start disabled in the dtsi; the
   VIM4 enables the mux (Sashiko)

Changes since v3:
 - phy-mode untouched, the PHY adds the 2ns, rx-internal-delay-ps is
   tuning only, tx-internal-delay-ps not valid for the T7 (Andrew)
 - 0 dropped from rx-internal-delay-ps (Martin); vendor delay
   properties explicitly false for the T7 (Andrew)
 - init_delays callback; patch 4 renamed (Martin, Andrew)
 - VIM4 without tx-internal-delay-ps, the PHY TX delay works (Martin)
 - Meson8m2 moved to the dwmac-3.70a list; its boards warn in
   dtbs_check until Martin's dtsi patch lands (Martin, Conor)
 - the delay table in ethernet-controller.yaml dropped
 - Martin's Reviewed-by on patch 3

Changes since v2:
 - T7-only delay path (Andrew), PHY mode from
   phy_fix_phy_mode_for_mac_delays() (Maxime)
 - tx-internal-delay-ps checked against the hardware values (Sashiko)
 - vendor delay properties not valid for the T7 (Neil, Andrew)
 - no max-speed on either PHY (Andrew); VIM4 PHY interrupt on GPIOH_6
   (Sashiko)
 - the T7 node owns sys_ethphy as "pclk"
 - no longer RFC; Conor's Ack dropped from patch 2 and Neil's R-b from
   patch 6

Changes since v1:
 - the driver honours the generic delay properties; VIM4 moved to
   rgmii-id with tx-internal-delay-ps = <2000>, Neil's R-b dropped

Lucas Tanure (7):
  dt-bindings: net: amlogic,meson-dwmac: list the compatible
    combinations
  dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
  net: stmmac: dwmac-meson8b: add support for the Amlogic T7
  net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on
    the T7
  arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
  arm64: dts: amlogic: t7: add the ethernet controller
  arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port

 .../bindings/net/amlogic,meson-dwmac.yaml     | 88 ++++++++++++++----
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 23 +++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 90 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 61 ++++++++++++-
 4 files changed, 246 insertions(+), 16 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

