Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1A1B6D08;
	Tue,  1 Sep 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226112; cv=none; b=qXIkPlMEblXBPn/oMpa82TxNSMYJIdvH/5JRqg+JeSRMY8aO3/yZZAPJk4pS0PRtmv+v+I3jwJeOq43SWHAoo5MH6tmC88YknDfIFSV842p7ZtJ3GhDqJg2yUWeU4yWYJnl/rch8R4D4ia3R6UuU/DxPHBQozqBYS+W4gpTLW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226112; c=relaxed/simple;
	bh=0jp2oZepn59YrZNO2xcX1aONGmEQ6d4WQrTT8EojDqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5gsqC9lIorUmb4B3xzyARiliTtN/KNyRF41NQn71nI9XRCe1fGRh5Opu4uCBSSKCRVYz84ZVxYwD79FPP9nhp0qR9eO3ysU0ra3J7ONHXxPp+VAAV71npy3AvAkQ1ue6DzCsStpIqn66l2yIG76Y2LmoUgBUGyrGmn8NdJD0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Z/ylyA9f; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Z/ylyA9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=oPMus4f9khSHNl1xw09P4WveQB8xHvT
	B7gEdDUV7WpQ=; b=Z/ylyA9f5pgkAAy0cwkORuyhy9gvseii4BR7mryOIBONoc5
	/eRWPMcJJb05sYPMPtTg1CfHznwsWxDTxoy8RMi8FPOd0c0nYkI7T0bl3FTPuPb4
	hyvqzxnoZTzwS2w5/kzB1iSNq7/iF/zxmn5/g4tRDYseaqdd4Xvks3Bq2mZw=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDnrwYZKpZqvx0AAA--.111S3;
	Tue, 01 Sep 2026 09:28:14 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Tue, 01 Sep 2026 09:27:30 +0800
Subject: [PATCH net-next 1/3] dt-bindings: net: snps,dwmac: Add UltraRISC
 DP1000 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dwmac-ultrarisc-v1-1-f19454814bcf@ultrarisc.com>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
In-Reply-To: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788226062; l=785;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=0jp2oZepn59YrZNO2xcX1aONGmEQ6d4WQrTT8EojDqk=;
 b=swpM4mkNje6FrBe/Y42aTJnG7N+b+zOwukSJYSL0BrXu9sLp6Ql0sLpN7pTjBKYOvz2sgPFmw
 /kk0czpC7YSDiCYg5Od96KNoiP28lcujNMVMeYjeaQlWPXVqTnQkoUh
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDnrwYZKpZqvx0AAA--.111S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW5XFyxAFy8Jr4xAr48Xrb_yoW3AFc_Aa
	4xWa1DAFWkGFyFgFWDAa1xJF15Jw13uF1kCw1Dtr1qy34Ik398Kas3try5ArW7Cr47uFn3
	uFs3JryjyFsrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR3xhLUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAREWqVJKMAFQADsv

The UltraRISC DP1000 GMAC is based on a Synopsys DesignWare MAC.

Allow its SoC-specific compatible in the common DWMAC compatible list.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..2ed4564ae99d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -119,6 +119,7 @@ properties:
         - starfive,jh7110-dwmac
         - tesla,fsd-ethqos
         - thead,th1520-gmac
+        - ultrarisc,dp1000-gmac
 
   reg:
     minItems: 1

-- 
2.34.1

