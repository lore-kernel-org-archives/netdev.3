Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A4442397
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361592; cv=none; b=emuBXNbzDEMctVQ1E4UWuKnOlEzqShLMFbtm0EiwwVD/lGiyzAXrT1aSyetNIMYQO+5iG/3jbKctKPysfiQkmtvDIBnSZtwaBLmQTlMBV/p7E4uOhZTtbq6DU+PGa3B5RjWLyhWTswhDy/RqOgHcshlB3jHu+fTc+qd04Q3KzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361592; c=relaxed/simple;
	bh=jV4OzbU2f3KQRrFlwjDb/XPZqUZlJnIHXEWJ2uji73w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdPrL73W3WzN/iv/YbxrjwIHdK+rTDDsJOnxuv9yFGj+ALD37UpVlU5pYSs9DWOid3gOtGYZVUrUYVwKbiFlFv57S4HKV8lGWy7v+Iw3xYmFRNYfq06J8trrEEZ7V/gJjffRuqeCkL8ClEUJZIA1B1/RDc6ZetAV5UYi3bsWP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3779937f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361589; x=1791966389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBaPp0u4Tgsx6RoTaJszoIAhk3SQlcR8pT28TWFVYik=;
        b=jt7H3896JA3w2HflmVEWXJqcSVRLqR6KybcBDbgdcxg+XVfvGfKbMmQVoJFlKWuV+D
         9RWYVgY2ZwIe85rsvN68OhOdQKqor9qseqAK44n8uq8lTle7oOlJ0DLhx3TqAIpl0CS5
         icHYy6wmuN6hFhe92qdBwQx+6IGA3kQb9niaarGUeRjY/um0gPCuVdD6xCPqI7qqyKyr
         /t1zLc0EYOXtENQIugK6SKYIioPbQqt4DSRfx0VQ+fjKTTmx8gWHWVBnbZVwcC4LlUMo
         R3jkgv+ruammTBBUhGwq9p8JDomh62fTeCNAxly0wfo0Ev4sM7Rnr4Px5ZviFs/6pirZ
         QMIw==
X-Gm-Message-State: AFq9FYIbf/TzVSbkM+0h7wBvL4P/v/Wsu15NZaT7C+Pa/kgEa5UMzoRk
	63zMLiRQ3sY/ySayyHiu9NeCM4eX0rS1t7kD0rP9K1W7jNDMx4NOh/FG
X-Gm-Gg: AYBFou1WjodBOn8laoZkXil/FRDTDY7DKswC4q53WLOLWvypeZslEcO9z9BV2F3NS7E
	bBthiZ8mJM+EIF/kD5jo5v0527Dxc6EkIxc3DNpEduj46xnUHsdfDlPjuRIu8BQ62dCygxcyEVt
	KGWr/pNfBdaoEqkt5BegkO0nXsr8pvaghjDm7ULKBwCZupLP0NHpomk+1TlOuAThL6GcNuml0av
	Zp9w+87dIHcts0FqofkuPzjHZXVfJew/FavrLBrIx2XdZ3K+1wYlbNPNB23xgxsdXHTLBlRGZ+D
	3CYCCo16SZ5Ad43NGjwJ8esvZnRHkI1ZwdGngc9z6HNdFSuDgzPy4kVf5/R6an8XMW4Qw7q7Yy+
	cDxgAO0YC/3FHa7zmrZG9+QrXLefITNSScv6yKx3xktQICQ2/vhjt6rU5CGE79hqFQlnB0LXsTT
	493iF7loEj5KUzlyk9UBkHg3nHQNDRn0fXTwM1NwpZDetHFTUtV6vV6/HcggI3iQRoQz2SLN1Ds
	ZWi2sNkPuBKEkkT6fnaOT4XkuzSxpzbiSHXDtSxOp/95Q==
X-Received: by 2002:a05:6000:178e:b0:48c:5358:f999 with SMTP id ffacd0b85a97d-48c7289d900mr2748455f8f.37.1791361589094;
        Wed, 07 Oct 2026 01:26:29 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:28 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [RFC PATCH v2 0/7] Add ethernet support for the Amlogic T7
Date: Wed,  7 Oct 2026 09:26:20 +0100
Message-ID: <20261007082627.63807-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T7 pairs a Synopsys gigabit MAC with the same glue registers the
G12A has, but nothing described it. This adds the binding, the driver
support and the device tree nodes, and enables the port on the Khadas
VIM4.

Unlike the G12A, the controller reaches DRAM through a pipeline stage
with a gate of its own, sys_ampipe_eth. Nothing else claims it, so
clk_disable_unused switches it off and transfers stop.

v2 changes the RGMII delays, after review. phy-mode describes the
board, not which chip adds the delay, so this board is rgmii-id.
dwmac-meson8b did the opposite, and ignored the *-internal-delay-ps
properties. Patch 1 fixes that. The VIM4 needs it because the RTL8211F
transmit delay does not work here. Boards declaring neither property
are unaffected.

Tested on next-20261002 with "clk: meson: t7: keep the memory fabric
clocks running" (clk-meson-next) on top, needed before any DMA on this
SoC works: 935Mbit/s both ways for 30s, no CRC error in 2.59M frames.

Overlaps with Xianwei Zhao's "[PATCH v2 0/3] t7: add some nodes for
Amlogc t7.", which defines amlogic,t7-dwmac with the axg fallback and
three clocks. My board reports Synopsys ID 0x51, DWMAC_CORE_5_10, and
does not survive the clock sweep without the pipeline gate. I will drop
or rebase whatever overlaps once we agree. Patch 2 is the oneOf rewrite
Conor asked for there.

Changes since v1:
 - new patch 1: honour tx-internal-delay-ps and rx-internal-delay-ps in
   the rgmii-*id modes, and pass the PHY whatever delay is left over
 - vim4: phy-mode rgmii -> rgmii-id, and amlogic,tx-delay-ns plus
   rx-internal-delay-ps replaced by tx-internal-delay-ps = <2000>.
   Neil's Reviewed-by dropped from this one, the change is not cosmetic

Lucas Tanure (7):
  net: stmmac: dwmac-meson8b: let the controller apply the RGMII delays
  dt-bindings: net: amlogic,meson-dwmac: list the compatible
    combinations
  dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
  net: stmmac: dwmac-meson8b: add support for the Amlogic T7
  arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
  arm64: dts: amlogic: t7: add the ethernet controller
  arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port

 .../bindings/net/amlogic,meson-dwmac.yaml     | 77 ++++++++++++----
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 22 +++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 87 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 65 +++++++++++++-
 4 files changed, 234 insertions(+), 17 deletions(-)

-- 
2.56.0

