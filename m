Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5E149C7B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239465; cv=none; b=UV57ystQAyVaaJ8rXdy54C1KsZxffWRl8v7VeZSublYx9WlmGZlxBQSJ0hFwjGpesn5gIjJ6i/qecVDDbRVxdXzdqoxPe7r4oM5PzSlxnd7kY3gCRUiJKb0IcD7/HN3AcPczFGrx7RfonOl9QomEIISfPQrBzstDib8wsNXWtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239465; c=relaxed/simple;
	bh=Vpg12s5aCfYhqiZT0MliutjEHvX20bbyVe8NFEbpumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+M3fpZeQKrHEgmDo7HV2CMPfZou+zJYijy1ayfXVQ3edGLWPyfWRhKf+AjaxvNFaosOzKpw+x67IW9619dFCFLD1rDETOQUUf3tDQjS/F+Y8C0oFA72jdVnAg88ux4wEGopJhELMqP06dRUaBs0yLXghAPXz/3b7DO8Iu1M40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXBlHr03; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXBlHr03"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a854dffb5dso166793a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791239462; x=1791844262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=kXBlHr03nLR0+jE4+yYiWsUjVXmiPb22fXkSWaF21mAiymf38ptMHN+lfeZoGr1izX
         xi7Npxoyrl1nNNSTVtT9EBl+9VKgAF6JdSFDI9+zIzrD+K35GKZiwEn6G9zTY0/cM9C7
         AVaY13ybuOvxubmlLTaH7MyHYrVV70WtDyyFEn7lzPCAQf95fhT2w53ppoZmc2iM2Wnv
         waMnC/pPqU6o68o4arAvQBHi9QjNBzhtPPQZgBlcXeT+HaLSIXe4j/CokxQJdX7Nd9w0
         PP8kio/cA4k3X3HWlZm1oIvbC8i2BWr76aCaFdCnN+qoI7fAqImFGRwxdrFbGyId3GuH
         8lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791239462; x=1791844262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=m4RNryAbAF5W4aR+5hZ6IK6qKYzP2BeGH09D9bmHwDNZjiBast0gI6B6ElMW7jmjjC
         CCV4+DQBE4qNj2++rHoOp7oEYB/mpc8jpkb9x3UAVIOoRQT64vQWO+9UAthBlUSJot74
         BoIcDPUv08m+2nP6t3tNtFRGAMnWpRv67Sv/ljzYDoTa26ns+Mt7zfO1fYnxdcPXk8Uk
         r+Dv+8ZM/nidO6lzuyUnPTvK56NgLbVZZWvnqqfoHDxvbB2aYSP9pJ53+mbsc/ewgr5x
         AArOTQWNTGrukB0ZvXj4hIQ3WGL5n7mMrIBs7Dy8UxbBAqc4OR4Rq3NnvzszXEOruqBC
         K8bQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV3WOw+fwfTRWUS8BO+Vh4KPZjqu8jpo++zjaNQakQdZD9sOZscKcrLlqCY0cdRU9llHahCzg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrd+xFEASBEe0TGpXRv2jV+LgBB0glsG9vGiqVmnnRm4dFFrdX
	Lqgr/XeDO3HUIQoAnzfmi7YhLpv1FoEBINcfzAa4feS0mGIWuPfAhNlK
X-Gm-Gg: AYBFou1BkQz6YUZua2q4YKm6LJ4SndSJTiNIJowjCTR18rJgzFZgcQgaHaBv/3H7hIO
	yCXDxtFmo4uNS6lti1OTjMv5dlmBIiQDy17ePdZO7felLMxg+7m4wXRNdeMjmUdSXEdGg6C1MGc
	zYoMcbCmxNharZIhcZOPynSnhRpkgcHt4y66uaWWwRr+LfQkdKC9kg8KgxreyvU5R2zOGI44WGZ
	VWeK/UcICROVV+b4H0ZYOKPhA5weB54FWUVjm+Ci0rqs3EcmqL28e5dZqPuSWaxVBlpTqXiP1pt
	FWvD5b95SrfvKuLBqO4K/mWBfkibmF+njWuhYxvXBFI/lDWE2mzXsYIYdkV/4TBRqbuaIJ0/kcT
	ghjV92WyNr1NI6kg5V5pwXaG1L+86Ud3Hb0/mQddqPgLdGYbH6H1xHvGhleFsbXQtCpWuZ2G3O0
	GBi5povDVBuJtpm7IcqHMLJKAxGG7LdRiJ8XZz1jQves8GACzV9SLawMmwgzxgxyqi6yjh
X-Received: by 2002:a17:90b:39b0:b0:3a4:c538:49c with SMTP id 98e67ed59e1d1-3a6ce846cb3mr9080240a91.50.1791239461527;
        Mon, 05 Oct 2026 15:31:01 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5f05321sm13203705ad.78.2026.10.05.15.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:31:00 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v10 4/6] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Tue,  6 Oct 2026 06:30:06 +0800
Message-ID: <20261005223011.1124347-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005223011.1124347-1-coiaprant@gmail.com>
References: <20261005223011.1124347-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip GMAC binding needs to describe the PCS reference used by
the SGMII support added later in this series. The property will be
parsed by rk_pcs_init(), and a missing phandle fails the probe. Add it
and require it when phy-mode is "sgmii" on rockchip,rk3568-gmac, the
only SoC in this binding that has SGMII support.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/rockchip-dwmac.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349c..bb7540e838033 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -120,6 +120,12 @@ properties:
     maximum: 0x7F
     default: 0x10
 
+  pcs-handle:
+    description:
+      Specifies a reference to a node representing the PCS device
+      connected to this GMAC. Required when phy-mode is "sgmii".
+    maxItems: 1
+
   phy-supply:
     description: PHY regulator
 
@@ -159,6 +165,18 @@ allOf:
         clocks:
           minItems: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-gmac
+        phy-mode:
+          contains:
+            const: sgmii
+    then:
+      required:
+        - pcs-handle
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.3

