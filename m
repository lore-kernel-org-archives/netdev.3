Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104647F2DE
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146641; cv=none; b=t/d2NQrERiOH9lNOzTMHO55QD2m/CNGbaMhV4CNcZZj/wwPuJjS4msTpWChTAa+VO1kLNmqmqyrs6fdVCgDd/JhYLIf2uPWA0A+1OtBYkR0dAKQ++mruW5FKM16BDZ6d6E5i1vhmZfwfYxvoR+XE5ef9q2d0ZUSS6r+q9tDQHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146641; c=relaxed/simple;
	bh=pPsEz//R/5mbHWtInqzwe95ndZ3s89rfdZjnVNEV7dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAK+rodW+MGUdvFXVQAgNcLOVGHwtOOcDiLZvMRv8/L1kB+CBShLJGvpiJr0OdXkT/9S+EzGRM0NOv/lRNz6sM+YgEBot+NTP9bkZ6g7G+iQrUwzNtcq9dQvFw3La15yLtf2N09bhhRhhhZwnfN5iCmeYtmo8m7Fzezy5wGbGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTEtB5ca; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTEtB5ca"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e5d08214dso443810666b.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146638; x=1792751438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7C5jMvL4BZCrVCkE7uNmOmEvbc8VSHqIMhSM8aawM+4=;
        b=NTEtB5capZ7FtNNyF7UTSqjAmrQFWzyr1B8sirz9graw2dDwxkKRuoeBUbPGeUZS37
         4AXtoLWb9QWtjp0xcRDX3UpLkLpbmGGGNUoZLb5n7Tf4gwdiUaHHZXMOcgt1AEuG3NNY
         1EGjHW4Dchu9NiGpwV6uzy2SbCK7+cDjXksIsIUbc+cSE2kgNpkiENRralDvfAQWOntU
         ImvzOTDE/nX7UqXB8/jDw4hPy22DzV7VKouvF6SQhbx5x3ZjbOdmeFjfNavTzO5piPU+
         T/HVnKxrovNDYudoZ3J6EMQA/eci/HB5T2TiB9LXQPrbVif4EytHi1qJqa+zYKjHhyfx
         scaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146638; x=1792751438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7C5jMvL4BZCrVCkE7uNmOmEvbc8VSHqIMhSM8aawM+4=;
        b=sGxre/ygmIt+rwOjDwNPyGd3s2/RYJeiasGV6U5OVFUa374iYj6Ot4rQaS5mNuv/pX
         z2IvNwG7SfSPy00UhonyDq4+FJYGmaIer28CGiyAWuIxYijJCXcdlzjl9zB9uz5gzJgc
         vs63LWA0zRPIptVlguvZFUQE0XYXL6VYBl4ZZjIuwz1tBwCAMKlj2gJbhkQxACB1ToOu
         1nJqtRhl0K4aO1AvxUPVnRLCJNmL4HtkbS3ptlUavgmK4qQQvPlJmqyd+dEsbQ4t9yY0
         tL36BJv2h989nZxnqtm6E7VK0v0j3IgOJ98nFEKxNIfxnCpHU9WO0L2w+ulwNtCbboBL
         OOog==
X-Gm-Message-State: AFq9FYKYmunI5Ab0qzptXWOS7UPvfAraNMkGb+C29RkKDnJk5r5tflaQ
	Y/VBpUUjaRjINWpMRNuLxtexIq+/ZyIySs91HEGLb+4pA9IyQuLTJWdE
X-Gm-Gg: AYBFou3pc8DYUlTQTD3V68MIC72/HCk2aV+H2jgKrn3Yw1KVm6Dskn3LyudbXNQHH5J
	ltnXB/xSozbo0hfCjytBT01xUG1UzboEU+2CX14TgNeUp4GxZ8JX3zRjSBFMt6XhiOij7tL8bvM
	IuKcO2S5EcqC9BppCy0Jtgal4cpXR+amYLgYScdQ4Dcxj47LFnm2xlr6xxgV/4mlfHuQh/aC3qJ
	pRUz6zNdlAdbqH5BuFAgwo9H9ZpbXRUJLAqLvKTCA6JBOVtU+pIUyaPFlbdjlzz0xTTPtMGdHqy
	Byt0SFe3vX9k20mOh8vmVDJcC7F7PQsS7Xs3NQciWvMZSnHHi8nCyLQXVFtbwfNRSYMhY0pDn8M
	co4r4JKE4W0V7h6utb2YXcWJ9PBw+7OTbYA6damTQLJE8Cf5drFoywP/wjWXD6SfFLo24CYzphz
	7VK2ynqLnngI/QYUHD06c4m3lDydHOoJiK63eBZxxeinyABk+9H9yJAd3gwqowOrwSUx4e+DfpP
	SgNxPMDmJoK
X-Received: by 2002:a17:907:9411:b0:c2e:3464:6e36 with SMTP id a640c23a62f3a-c31a9ff9da2mr1920745966b.41.1792146637456;
        Fri, 16 Oct 2026 03:30:37 -0700 (PDT)
Received: from localhost.localdomain ([193.107.16.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce133sm60613866b.31.2026.10.16.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:30:37 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
Date: Fri, 16 Oct 2026 15:29:34 +0500
Subject: [PATCH v2 2/5] dt-bindings: arm: rockchip: add Forlinx FET3568-C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ok3568-c-v2-2-068d68430e6d@gmail.com>
References: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
In-Reply-To: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Yashin <dmt.yashin@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146625; l=1181;
 i=dmt.yashin@gmail.com; s=20260930; h=from:subject:message-id;
 bh=pPsEz//R/5mbHWtInqzwe95ndZ3s89rfdZjnVNEV7dE=;
 b=4huMP0THyaTfkAsa/Z+xPB2qx+6GFhboW2FltactI3p9iSfU3lYO2xAjfuB9+FMcO7kUieeHH
 l2JDbETJyivDuimoNKHkJiyCmq2Wn3+4BD3xvC2ez4gNDyW3iWzZIMx
X-Developer-Key: i=dmt.yashin@gmail.com; a=ed25519;
 pk=vBe9jaaOEH5bQEvfzb1tWOlz3AMIcXCu/GL/CdlwJco=

FET3568-C is an System on Module made by Forlinx based on Rockchip RK3568.
This SoM used by OK3568-C Board.

FET3568-C features:
- Rockchip RK3568
- DDR4 1/2/4/8 GB
- eMMC 8/16/32/64 GB
- RK809 PMIC

Add devicetree binding for Forlinx FET3568-C SoM.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index a799bb843f74..30a6794861cc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -324,6 +324,13 @@ properties:
           - const: firefly,rk3568-roc-pc
           - const: rockchip,rk3568
 
+      - description: Forlinx FET3568-C SoM
+        items:
+          - enum:
+              - forlinx,ok3568-c
+          - const: forlinx,fet3568-c
+          - const: rockchip,rk3568
+
       - description: Forlinx FET3588-C SoM
         items:
           - enum:

-- 
2.56.0

