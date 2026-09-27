Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59441F37D
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535151; cv=none; b=bg9kkMfW8v2CL0x5J18oP8cHzB9OzaidDEPQNcs490V36NPv1dWg3dE9cIDXaQIzMqtPTY3qH2zBLfaVZUTnjNwDWXouJeU8dUnDVPBk8Ws43wR6l6Tpb85LD0hH5NldICc2kx0m88yZjnUg7dCWrFXBl1EtI9/iIArTFg2GmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535151; c=relaxed/simple;
	bh=n24BezsvECn7GRjO7lY7N/ekiG6SYURBelnbkjTyEkg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m9eJqY/xQWaAbjDph+h7SHFp3hbyACqRVPW2ss4pLrhD00orgs5pK/Pl36KlYid07SomC2RuHzQ/IyHC+3IcNyJfCvVDIX/n8c25dE7fG5U9UAEZgsxHasoZbSe9zUjAjqHFC1Y+5Iv/iPJJdN7lYqNFFPCrjGO6G6FLnVGDhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHBLX3Iq; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHBLX3Iq"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-49172f18b40so1458568fac.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790535148; x=1791139948; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lckP7hj0eg5D0nk/YR1XaBxbluMeeizhLnEF9QtDWMM=;
        b=iHBLX3Iqve6Yny6FLt7J5+JR+uJKHCmALSNz4BwGWKQpv1rYcdTRfJKCn6HFb2t2Ql
         2T/MOdsElPyqmblhNLbhxlI3phQP4tJbpoMMB+8Zn4aLTfAYxCPQhbC9a8T6KCJz4WxG
         ML8UyjFnQM5mZF9zOjFhhKZ4wHYDcuPArDOUM1OxVQkrOXVek8DWJJV/cIDZ0SdGQrF0
         h5MlT9RV+vrSCbSiQXErC/b7QrjCA61HxrhsFfPhxQJ4AlbCONlpYYjlYMApEFVJ20Na
         tRdKwQwAB4hzLzbxfPGRTitehd9HHdwaT8r9ueVS6gekH0biC5EtFbIs5pnaFzO1rEAk
         h+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790535148; x=1791139948;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lckP7hj0eg5D0nk/YR1XaBxbluMeeizhLnEF9QtDWMM=;
        b=nCY5G2JyHdXsb+kr6o4YrXkNhUCQrRxdVcVop6a0vS0zUgj4ve3BseXT0aBFn6A0EG
         kjUHImx6ANziwDPgWgWMPQO0/P7ZR17V1Da+xUg+y81Dwvgh57f39HygW3GXugGM/0mb
         RVRZ/IsV5whf7iDgZyiFdhHLe626WCgc3tqjdVsJHfI45nrZcFEHAaTuOKYvWp3iFfkm
         AcWUg/WGQXTMExLxmJ3TXlahDAe9PnZ8L/XnHIyTmA09VkQdjO1AFEVIbOJcDR/h4tKo
         vAOc7X9cqXVdtJ9JRlSy2naKfF7sco75b1DYNPdVbU8OTSR0i1HQCwh2ISvq6d8k7tBf
         JuMA==
X-Forwarded-Encrypted: i=1; AKwUvBxZpby/m22uZ7DC3vhJMHylrtvaP7aMNgyWj4TICeRd7jnVB/MtS3HgfopuYS+Rxk9ZonCWEwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU7KaaGHvXOIeiWOb65Ik1fuGgT8jji1nDhH7M1Lek//HWcWtI
	7XK/YGl77fsyq/Tj+3JKgShM6FhF7jdzdxOunvlswlx3q6NMKpXl6clI
X-Gm-Gg: AYBFou0miIWBADKWCUkFzR9enFrcJwGC2yUP2hzhi5Rfq0tONMJAs5z5M8+hgUZRDid
	rAiD/UziDSJEB1M/TvBPUCTlxc0LLcv8d1kiNxM7cVOIdE5nQL1PeAsjUejHrj7bQ01QU12ScOy
	O/jc2HHaaYPC79hCKzjH9303x1tt5h+G7t1xhX+gijr5Yh2hcEPH/yr126zj9gASmIepGGjwK6J
	pLNIzTYpyXA9Gci/Ew6oSgjFCbrmBPqJ7SDuAhTUcomjdTf79RJw9WYR4bLXaIqOsM45J+BSgS+
	4KKTCjo+7hAUK2lXrQklsZKOVz1okYTPAKjPgvw+IOAjZeNTwFTy4XAUYxRwmuznwzTQGn+lzFG
	2j13j0J8Xgnkyb46IW+NRQFATbQCNzJigeH5LKveVbCU+PMS3zAIQpo95+k/YNbg7TdcPflnD2g
	rbD3/+U8LCwSvMV5nnl6/YxrpLqOdY13VmGRg6r+1kImCouTCMLpwT/okY7PPg3qodjINV0n4q3
	p++YOZGkVYVdP1F7TlGE3r4RhqveezkBEFkZOGAAd+PJpNAy+1mdI1YLt2MZrOnVKtT7eRdJviM
	7ftfLMcngf0sK9HNBKPUTgJXhJ+3nP/yXzo3hweqghQimTRS+ZwnGf4dePMtNTFyOj7CoCjpkm8
	hSpUleO1IpkQayfQWoXeX
X-Received: by 2002:a05:6870:8893:b0:47d:4a10:7303 with SMTP id 586e51a60fabf-491e69a95d6mr11172874fac.31.1790535147641;
        Sun, 27 Sep 2026 11:52:27 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-494877590e5sm4489452fac.13.2026.09.27.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:52:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v6 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
Date: Sun, 27 Sep 2026 12:52:18 -0600
Message-Id: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OS07EMAwG4KuMsiYodtK0mRX3QCzycKdBtEVNq
 AaNencyhUWpqITkjWX7+31jiaZIiZ1PNzbRHFMch9LohxPznR0uxGMoPUOBWhhQPH24PmbeadC
 ceuuBz8BByVrIRqF1jpXT94naeF3ZZzZQ5gNdM3v5nhThlXy+q/fdLqY8Tp/rBzOsFz9h1d9hp
 QQHUwUSzkHb2KdLb+Pbox/7NWLG/yBYEInoJJIS5MwekVukPkBkQTR610jQBMbtEbVBUBwgqiC
 NVHVoCcnVYY9UWwQOkKogNlitgYKh358sy/IFvL5sgegBAAA=
X-Change-ID: 20260914-submit-h616-emac1-v1-143703842abb
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: Alastair D'Silva <alastair@d-silva.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a separate
system-control clock register at offset 0x34. Add its binding and a
sun8i stmmac variant using that register. A distinct compatible without
an older fallback prevents the driver from using EMAC0's clock register.

EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and has
no external PHY pins. Leave PHY initialization to the PHY driver instead
of using the H3 internal-PHY controls. The RMII-only variant does not
expose the RGMII clock-delay properties.

First move the MAC software reset from probe to the DMA reset callback,
after PHY initialization. This lets the MAC and its MDIO bus remain
registered when the PHY driver or one of its suppliers is not ready yet.
Mask interrupts before requesting reset and clear DMA and interrupt state
even if it times out. Keep the separate H3 MDIO-mux reset sequence
unchanged.

The AC200/AC300 EPHY driver and package bindings are already in
net-next. This series separates the H616 EMAC1 MAC driver and binding
support from the earlier combined series. PWM, MFD and device-tree
enablement are being handled separately.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v6:
- Add Maxime Chevallier's review and test tags to the MAC reset patch.
- Drop Alastair D'Silva's cover-letter tags from the binding and add
  the binding reviews from Andre Przywara and Krzysztof Kozlowski.
- Link to v5: https://patch.msgid.link/20260921-submit-h616-emac1-v1-v5-0-ada661ed9e9b@gmail.com

Changes in v5:
- Split the three generic phylink/stmmac recovery fixes into a separate
  net series, as requested by Maxime Chevallier. Keep the sun8i MAC-reset
  change, EMAC1 binding and variant in this net-next series.
- Add the originating driver's Fixes tag to the sun8i reset patch.
- Link to v4: https://patch.msgid.link/20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com

Changes in v4:
- Add a prerequisite stmmac core fix closing the interface after a failed
  MTU-change reopen without repeating DMA, IRQ or NAPI teardown.
- Close the interface after failed hardware resume, and let phylink
  finish shutdown directly from its suspended state.
- Retain DMA and interrupt-register clearing when the sun8i MAC reset
  times out, and return the original reset error.
- Link to v3: https://patch.msgid.link/20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com

Changes in v3:
- Add a prerequisite fix moving the MAC software reset to the DMA reset
  callback, after PHY initialization, so delayed module loading and
  deferred PHY probes do not tear down the MAC and its MDIO bus.
- Preserve the H3 MDIO-mux reset and propagate hardware-reset failures
  through the normal stmmac hardware-setup error path.
- Add Alastair D'Silva to Cc and rebase onto current net-next.
- Link to v2: https://patch.msgid.link/20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com

Changes in v2:
- Drop EMAC1 TX/RX clock-delay property support and keep the existing
  RGMII-only delay descriptions unchanged, as requested by Maxime Ripard.
- Clarify that EMAC1 connects internally to a co-packaged PHY, not an
  external PHY or the H3-style internal-PHY controls.
- Rebase onto current net-next.
- Link to v1: https://patch.msgid.link/20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com

To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>
To: Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
James Hilliard (3):
      net: stmmac: sun8i: reset the MAC after PHY initialization
      dt-bindings: net: allwinner: add H616 EMAC1
      net: stmmac: sun8i: add support for Allwinner H616 EMAC1

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 13 ++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 69 +++++++++++++---------
 3 files changed, 57 insertions(+), 27 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260914-submit-h616-emac1-v1-143703842abb

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

