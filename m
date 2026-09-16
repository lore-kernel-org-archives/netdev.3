Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E683BAD81
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528110; cv=none; b=Wfb+BPfcyl5Cq2Gy46Q+MBfvNgfOYYMP7rXYD8oDw/D7RB/qwf2pmaDb3jno6gVhG0OE8nx65s+UG7l7V7mvGuDHeWA50OO49ypOsCmSRZA3+eXE86RdyaYDqCIuse4ww8Tbcp5FUy8Hsuaf27rhJZ2kcMyo9WSxzXQXFDGPs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528110; c=relaxed/simple;
	bh=BzeM2wwKwRHzaqQoq07OCW4sqSwwDLJ+43BF/yaIJkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kU2oFSDKRWSOLCa40DA7UgbVbRVoR85oSB8XkaKJ5RpxxOXG+lqte+YkgGtoVbKrVVYLEW+2deD6amBfmL8L0zpI6LNtDmPSymwgHMSgSkFu1mGzuSSmwmRt8TqCLmM7ZFXPyQUDQulzzdt5PG3HwhrIDGK44qP2vOGnL6mBBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB4lTQIq; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB4lTQIq"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6bff4d6504cso227910eaf.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528107; x=1790132907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AxECogFnkMA6SSiFQYeE519yjpa6TKSl2zEHDB706vw=;
        b=SB4lTQIqXQ5CbZIroa8E+mHZSiJOCGHcdj35RUrqEpV7lACip7VV1vMAMSxWxVjGsa
         9EMshe/bNVatZ3a06/8SlLRaT/h91/NjBxfoJdTIJ3Cwy8FoMEkmKS4/GxrqcSK1/1p8
         prvz02RNGQPLfennL12R0nyELlMqDvHz2Liyswcs76BFTnpzB4UH+t8Q+L5g4H2gaIFz
         vfAzm8eCcJpiJLTrZmj27FIFF8EK2wNTml05MmUVleORX2jsllhwr3oEPnU5/3fUHfnv
         fl3Bb7dG6F/rUqJsugQRFdtaXhvES3EJl9TsSt1SewC6YVhAR9fS7kbCgH0AGsCV7Tdd
         TXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528107; x=1790132907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AxECogFnkMA6SSiFQYeE519yjpa6TKSl2zEHDB706vw=;
        b=2l4SHqwCiZjlC3t0mXprgX+em9DgQ3cfQwlNkwhelbsZ0tK0YHIHpWJRLSOgDJQN1S
         ZdG0pvsgOgKsOqYWcoeRMHDrFrATpFIWzJSwcsyIX3cpmu2um1FFbX5mFPYJHZOuk2bW
         62kvs6WzZk01Ixv0Sfhxl1OWRR9B4WN3UfcSdhvQ8Wqcbi9YZoKGSWGJg+wXczIpRGZr
         6CvK28GUBois+lxGlxZc/vbagMqIPIjXpe1RRTGiUNirvdGoiHKJsoXguumuUdQGQUA3
         1wZZNlaAcS3qTUV5InWVuRqtt11M8ADXB7lQWA28Kfo9U2lKBHtu+D1LpMLnq/91aPEx
         XujA==
X-Forwarded-Encrypted: i=1; AKwUvBzykjL4XoG9dPAFbwohtffToBIa7jr3Qax2DPO45vMl5H+OPw7EJoTd6osqzWkdDwdlWM+/N1o=@vger.kernel.org
X-Gm-Message-State: AFuF++lrD3uowRr9jTrbzRrnA0cxQzZvS3cMv7gjXQNftJAvRl23ueIz
	nF76ZeR7hm21oYfky178T30sMt1Mwck5zDILWQZUkbC6rbVXnNs4UVdp
X-Gm-Gg: AYBFou1LfYpiBcaQjdC+3gkKp+oOZzAVcZg6jWP7+XuA5pA3ouEphLavii4MKeZHGvv
	yaEbNhCBVsmUrcaOd6ekXmEizRHn8o2zUd0Fqp448GkuMjFKoTXn5lSHuk9zMY2G/f22bxtjJ/v
	BQeL+lbtQ0yM0UlqIcY1FfBfDqlZ9zDDbEFelzKc0cRd0l+zX8f7j8BiZPKuvjhiivRFO3tPTWo
	WVc7lIuZ1lq9cVnYnTunfqaXU7lkpUY13wQA8+q5hCuyV5ClHG0MaEhaqUU51aKDfRkoJrOZHaM
	eH3PL7PKq0xXbk/fAsB6UrPSEieVey4bbBk62STIBmsO25qgghipGORdKKvEEAde5njC9HdPUrk
	+edljyIwhXhWiVpUo9sJvgY7FEMXToVZ1xLXa7dVUtNad4nKFshDKZ+Gy/jqdN9vTrgjnyxJdEM
	k5Y8+87Bpb7Q3rtmGgY8CxziJHaCqEwuojF6O0sqX/n1K/sGmDF4s/VS+zJtR4m473H75U0kKu1
	jvBvXH46eLbVsTYsphmc9NnfSyk6KB5/d5rTXuYT+TQ9FTykUeBrOY9F6KC+2T626h0OF5O6+Xq
	yNrq/AigQlc4EuWLn988mVquSfW/LByP1ss4E17AZwv5Hqz/y+KYD7ChfbTliBZ/RDsHh9GGzfC
	J4E3nwJ+YugkQXZqZOCH3ZzaCuQwD0/4l
X-Received: by 2002:a05:6820:f0c:b0:6b1:6636:e919 with SMTP id 006d021491bc7-6c7d1cc53f8mr2704731eaf.11.1789528106832;
        Tue, 15 Sep 2026 20:08:26 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c7a677b3bdsm1718078eaf.6.2026.09.15.20.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:08:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 15 Sep 2026 21:07:41 -0600
Subject: [PATCH net-next v2 2/2] net: stmmac: sun8i: add support for
 Allwinner H616 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-submit-h616-emac1-v1-v2-2-322b32e40eb9@gmail.com>
References: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
In-Reply-To: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. It connects internally to the
co-packaged AC200 or AC300 EPHY and has no external PHY pins.

Add an EMAC1 variant using the dedicated register and enable only RMII.
Leave PHY initialization to the PHY driver instead of using the H3
internal-PHY controls. No RX or TX clock delays are configured for this
RMII-only variant.

Co-developed-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb96233..e8f86df50060 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -81,6 +81,13 @@ static const struct reg_field sun8i_syscon_reg_field = {
 	.msb = 31,
 };
 
+/* EMAC1 clock register @ 0x34 in the "system control" address range */
+static const struct reg_field sun8i_syscon_reg_field_emac1 = {
+	.reg = 0x34,
+	.lsb = 0,
+	.msb = 31,
+};
+
 /* EMAC clock register @ 0x164 in the CCU address range */
 static const struct reg_field sun8i_ccu_reg_field = {
 	.reg = 0x164,
@@ -143,6 +150,13 @@ static const struct emac_variant emac_variant_h6 = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_h616_emac1 = {
+	.syscon_field = &sun8i_syscon_reg_field_emac1,
+	/* The co-packaged AC200/AC300 PHY does not use the H3 PHY controls. */
+	.soc_has_internal_phy = false,
+	.support_rmii = true,
+};
+
 #define EMAC_BASIC_CTL0 0x00
 #define EMAC_BASIC_CTL1 0x04
 #define EMAC_INT_STA    0x08
@@ -1278,6 +1292,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
 		.data = &emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
 		.data = &emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-emac1",
+		.data = &emac_variant_h616_emac1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);

-- 
2.53.0

