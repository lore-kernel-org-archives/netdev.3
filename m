Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990302264A9
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295144; cv=none; b=PQEScOHF9C77R+AVI7kvwSg1eCpvha/tlxULZYEJvZ5AmES50IhuH06OOtBofeynamT4Y546nGJJ8GVA5IKlVZOkhIPWz0bFxXNPJyHWV3NqUPLfC7j8Q5v+mTon5/A8a8eaXlz0KdMSw9VZ8Lo+2/NNU7X1jqrM2zSD+AE1Djs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295144; c=relaxed/simple;
	bh=MO4DCzOiJvahncAwtOSB6K819MkQDQH4Q0Oaw+W51tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLA7UaIfREdDg+7xC7rXAFXXf+EC8Ggh2a0W0pIbWjEDV3u2nQk8NvrO2FXLOnwZDdVU0Zben56vFAvU+27gooxim4RU3VTKkpADr5cxE0DWHIF4DHkhjLbH3JzXhfiDdiBym5ik5SnR34bU8rm/1IAuT+5VIAqt2POBj7ueJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=MhTl4yyV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="MhTl4yyV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4887d3c59ecso89115f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790295138; x=1790899938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekkpP5b06Snvbo4ruQYW5bvGILgj8Lx5k8thlgPN0w8=;
        b=MhTl4yyVl5ha7wKP47uPI7ljVaoa7qGi/LbXWE1L1mcNCAEuWVqn4IFjP25b49wGYO
         epGOQtJYcYRM3womKWf8OmkScAWCzkb0oygVXpgXOnbrENuBUuW1uWf2DF81jLZpfNmw
         mc7mYdx5z3KRBtAhcUNbPQKVFdQKVgi4fNuLLlh7WRxSQiou5C/eYbwSgEw/LLH1hrYU
         WT1ZW82d3/fo3oNvz+bTr0dUAi5meTAPXCict2Hdi0NbKAMzsOH/Kj/omxUiGt58Xsnb
         m/wTNZCLxLJnDbbJHPq3iI7ssJdpdmzOx6FW/a+ma5RpevlbmIL/2Ee19DxbwzewF8M7
         UOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790295138; x=1790899938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekkpP5b06Snvbo4ruQYW5bvGILgj8Lx5k8thlgPN0w8=;
        b=N2reczi42V2ar3dnKpxRvmUpP0zFDw+DqVqukRpwKTIl4lyd5GFMqO7EM/bBjzvNxa
         ZNNZ1q7dmGoGAbJEqMmgf8TIW91FIQUedelkrsjtXHtyHD1O1D/req8YNV9xmS+6tpMy
         0w9Gg8LiurgIdjQNbvvlF4XoICf6HzZVbxDSpjotrlrrm8OAKAZekWw4sehZ54UQPIfH
         1JbQ47lDqYMjTsCCWdvoSnUV8bFxiOjaU3C8lqVMymA6pl9BSSRXEXCFL36GAVyZPfl/
         QpV3z1kx2lTNBmgvOHG8ivQR/Nhb7BSD/oeWPApdW1lOMZ+7ZeBC9U4Q3iSSaK5jpwSE
         gX0g==
X-Gm-Message-State: AFuF++mtoELPIsBYnLGVMTh/pth8nGlDrSbOHleSjm/urFeRwf3t+2Px
	Lybmf3OvxPYBBrgJ8lYhNoPb1HvLPYNJHxJdRelQuvY+xylKI/k4Qj3euiWYlwqH+G40Xg0q5pT
	okVHYMnLysw==
X-Gm-Gg: AYBFou3cy+aYdCl9HbMjVOqmI/bWzVgQx9eY3pUUuSJeTTXEWWrNSdFjKwMhFYQ2jg8
	KkuvJuGRSinlF+I4YQaBsRWJ3cpCA6mGUiOVF5u0MWojQIbu4oP+8PpE+CtoS4YAKsOIHkvhzXc
	iFMVaRLJDp8WReSPjUo9TtR2KRQs5ARpv+601UL59nqgtfNEjBLTiDI0OoCvk4cnufuNUjn3IWM
	Dpc43oNWT/oA7b4UsT8boiCBMQugPUpi/F87Y3KKD0jCPuvK188r475YPJHd4KHlM2vg0TcEznY
	XDgjeBVBr6MX/AKICVD0gEMu3joU4b3DnLkeISEYiYvssMzZr3Jf8raDiwpHPfHFHRO3tHynFvl
	ImIRgceaUi0EokmrziVWwojnuIvvxoK25AFpHnO6PoqaIM9LvMe4NZcffYqmv9sDfCkb5/5UvIc
	n3TFOT/oLKDlWEhaPdViJFVd2OcrH3zo8h27/P6fMphjRON4GCoxzjvIncbQ3i
X-Received: by 2002:a05:600c:2254:b0:49c:f13d:ffed with SMTP id 5b1f17b1804b1-49fe845cbeemr50823335e9.17.1790295137252;
        Thu, 24 Sep 2026 17:12:17 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b9aesm2331621f8f.5.2026.09.24.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:12:16 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: add needs-host-firmware
Date: Fri, 25 Sep 2026 03:12:08 +0300
Message-ID: <20260925001209.2334139-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925001209.2334139-1-f@lex.la>
References: <20260925001209.2334139-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY can be one that the host has to load firmware into before it can
be driven at all. A controller that connects to such a PHY at setup,
before its driver has loaded, gets the generic driver or no PHY at all,
and one that connects only once gets no working PHY on that port for the
rest of the uptime, even though the PHY works seconds later.

The flag declares that. A consumer that sees it keeps the port and
connects the PHY once its driver binds. It describes the PHY, so it
sits on the PHY node and needs no prefix naming one.

firmware-name is not used for this: it names the file to load, and the
EN8811H driver keeps its two blob names in code, so it would only be
read as a presence flag.

The need is not derived from the compatible because the knowledge that
an ID needs host firmware lives in the PHY driver, and that driver is a
module not yet loaded when the MAC connects, so it has to come from the
device tree.

Found on a Keenetic KN-1012, where the EN8811H behind lan4 has its
driver on the root filesystem and the switch sets its ports up before
that is mounted, so lan4 stayed dead for the uptime.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index c3ebb3af8b52..73827662ddce 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -215,6 +215,12 @@ properties:
       used. The absence of this property indicates the muxers
       should be configured so that the external PHY is used.
 
+  needs-host-firmware:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This PHY runs firmware that the host must load before it can be
+      driven, and is not usable until then.
+
   resets:
     maxItems: 1
 
-- 
2.53.0

