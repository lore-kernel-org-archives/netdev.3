Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A34189DD
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629958; cv=none; b=tHmNuOSsqUZjQIfKxoBEaol3hVbse2WJzdTVIsrPbfOp1P8hmHrhPW0C2REqSF59y+2j40nUE8fXarkGJBJrW/M0ArdeouRmVgSsSP4e8mlvHkdb0Y+mV7q2cCWjTX/996ExKn7qMAV5uggndHum+6FLxA/t9Dwb5tbCcm0SF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629958; c=relaxed/simple;
	bh=8rU4lcGem9r8npg9voyJwgRjQfcdPrmgPfj8qzzKnnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SR8g61D5QPFvhACKlT83KA7JsfcKe6APYfEbYtnCOk0lgLthX+iXxts9Ft1g7NSlqDcdadEJuUIqDshE7NoY0HIXv5laCsjCOCa7MJR5+Ma1LnFuvSruCxYrUjfgTkCGAkes7gepHGfznaVaTYoMU88ipcTEQhsi/DcFDl4X94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b001cd92bso319253f8f.2
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629952; x=1792234752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pdKVlCj4REX0NWkQYtOCVGuCUyIjtnl9DbGH17gD2u8=;
        b=IA05MBW2C9Zax/oXcRUvBZTJmDdG7feGAndb76aorcItoSX+90FMEc//iZD/wTJQjt
         b1+wALcShvd9x83b+qXTztzBHJ4zSUZhkRW8orxQxAMTrdak8dAHJZqjItXcw58ojZ7g
         TImozTjjjZXSl8jC46HOlTM6bktWS0gVzlB4HKo1KIooHp6L4eQmqDHHmacdCvNvJxDi
         Xu8YudFOZkYPG3/T1Ii1xgnc9VQgju7SY8lmkKXReU+70du5h4Ha6cAQtzA6tppjPLf0
         Iao2IsPZ5wkE9CTXf4lo22AqE/02cif0Z+oz4gW6/sXQRFxY+1vsVQfR0bNNM+GNRlWe
         1ijQ==
X-Gm-Message-State: AFq9FYIE8Wj8yqJCiMhmy648cZ1HkvrQTOmMS9Y1oDBW28FnrtKAViyg
	uEUQBjD6/1k0H0baKCgeR/UC+RTMEqqLOPxisV7Yy+8LptDjJjvTvg+q
X-Gm-Gg: AYBFou084WjBUI2CAJoqEYc6JcPlje2OtIvhiEB9BfdYHK0twvjDeioGci0/QMDEbYg
	BtVnwChL9U1XfPLoF9RsmJN16O2dcM/Whw0+RPbPp6em8Cndg61blo6oTDTUho6fDxg60ZtAspk
	nJZPSOUEnHChZV5FBvlGWkzeidbQ0LlcHeXgnHTZsMWKsXhXPU3RZ5i4FsW28fgyF519+nh1rXi
	2ea6peGB/5ky4Vkm2/UA4YodNOdy/ExoyFQlOxoj0sC3rjI5uuOXGJMknAi3kCUyJ+twzmxZphx
	MDncvevsOLnOAh+PhFtAK9uPL8/Yr4AI5kkeFd9d697ejkFdziTMvny7KeQZFmVajrzhcRhoRIB
	h8h8bctWEwaxHZ9lLglm0lGe9cjX886TiFp3r+TbNwe2bXz0rabbySKa3OiuJOUnZj+PceToSIZ
	8Mv67+PJb5Cb1fSE+QRtUpdx8FeMxSq653y5lOvrypTBMh4B6fIelF4A3ONEwGTAnMYGBIoFYfr
	cFbd7R6AvqON7ifIJ6g+HdmfthMig7RTcQ=
X-Received: by 2002:a05:6000:2dc5:b0:48b:2a1:dfe3 with SMTP id ffacd0b85a97d-48dbace3b32mr6883381f8f.41.1791629952539;
        Sat, 10 Oct 2026 03:59:12 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm8709526f8f.57.2026.10.10.03.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:59:12 -0700 (PDT)
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
Subject: [PATCH v3 8/8] dt-bindings: net: ethernet-controller: tabulate who adds the RGMII delays
Date: Sat, 10 Oct 2026 11:59:00 +0100
Message-ID: <20261010105900.247342-9-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010105900.247342-1-tanure@linux.com>
References: <20261010105900.247342-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The informative section explains in prose how phy-mode, the delay
properties in the MAC node and the mode handed to the PHY fit together,
and says itself that developers often get this wrong. A reader has to
work through several paragraphs before answering the one question they
usually have: for this phy-mode and these properties, which part adds
which delay.

Add a table that answers it at a glance, with one row for every
combination the properties allow.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/ethernet-controller.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1bafd687dcb1..bba27a9feb61 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -339,6 +339,24 @@ additionalProperties: true
 # has added. Failure to remove the delay will result in a
 # non-functioning link.
 #
+# Put together, with the two properties in the MAC node, this is who
+# adds each delay:
+#
+#   phy-mode    tx-internal-delay-ps  rx-internal-delay-ps  TX delay    RX delay
+#   rgmii       -                     -                     PCB trace   PCB trace
+#   rgmii-id    -                     -                     PHY         PHY
+#   rgmii-id    present               -                     MAC         PHY
+#   rgmii-id    -                     present               PHY         MAC
+#   rgmii-id    present               present               MAC         MAC
+#   rgmii-txid  -                     -                     PHY         PCB trace
+#   rgmii-txid  present               -                     MAC         PCB trace
+#   rgmii-rxid  -                     -                     PCB trace   PHY
+#   rgmii-rxid  -                     present               PCB trace   MAC
+#
+# A property for a clock the PCB already delays is not in this table.
+# It is either the fine tuning described next, or a mistake the MAC
+# should report as a fatal error.
+#
 # Sometimes there is a need to fine tune the delays. Often the MAC or
 # PHY can perform this fine tuning. In the MAC node, the Device Tree
 # properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
-- 
2.56.0

