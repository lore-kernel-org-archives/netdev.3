Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284666;
	b=dOfkOxjMXjB9pPYx/PLZAwC3RMDOOd2UDHSya3zkcR0DrTPCEq5/r8C7KwTzwZU2o2E/
	 AppFtlByZF+me0a47Cwo404E3RSVzsLJ3SlZ90RkC6QAgp2hZA0XP2P1jm5l/0VCqc3Jy
	 i4T1yYuH8Lr21doo+8pxNrnQFpjuVcLrZvLip57cxHJ8MZG9YeEJ+3qPsbtu24/SOHofn
	 WgQi37UVBuVmrDBh+i65n4ZhAE3vjQ3Rut71lLq0BvpV6QVEQaSL6gY9jIlu/ilQ2rOMN
	 R602wBz5PHg0Gzk6d6eBO7xjH58e2GJV8Iny661ATb2dgdjXCLBuNpns0X0//tY1n8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sB+qucsTWzR2GT3huYaY7Vowbb5pb353bAlTMET9Yqk=;
	b=UzL8dzc7q+wM3TnCd3a/n5goz2mJsOwYDGcngfKQzddYm+8X6XNnFKHJVXaYTciZlf/C
	 BmrHZ6TrznmSiMXT3PCfW1OhP6ewarqPr8/kCzc5F5qU8hykqpElWwoLbZ3jdW6kkBnw8
	 WSWhAUD+BmbSTqCObRx1vGRswcpyqnFb47dTyLTPZ+7c4DGp96h/kjgmouw5XO9YiX+ic
	 vKQuQjWtv1QdHyCiLUIdbw3u/a0dw5tVAF2dvG+32yESQMOeQ/1V4dh8QmL4vTkxO9Cdh
	 vtasNXJNfAx/h/AMZUpWmorlwddpIs5WJUZWCO4Oeu92waMVgOs57gYTT7QLkj9VUGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mJf5IPRp;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB0606BB1F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BB0606BB1F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mJf5IPRp
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b244fb7fffso2027536c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1794284666; x=1794889466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sB+qucsTWzR2GT3huYaY7Vowbb5pb353bAlTMET9Yqk=;
        b=mJf5IPRpeaMDArP5CRv1jYoN8QYIuoED7cK4e36mKkMDZUJhtn9XjLxGqOvKlh/SvJ
         VbeQ9L1UfiPTr+BZzPCl/sSLBpZ4cfuPErh/REXC37hTMfn067KmiQRjFcsHiwT94ONs
         YZxIjN6BmTxkAZyOOOKxnbGLVMahhWJCE/Ckn3OIstyAkuaAmDUHOQ7HHf8x71jbOqTr
         UV6l0LBgb2nvl2YKJQKUaulw4XRs4f1CT0SZP+Rfs/LzZWtkgDEU27EyHPOWc6MwDMCD
         APl8f6QQ8seEjyP8Rx60FNNuKn63F5bEiAsG0K3rn/6WKIHG2qhjOe3IQNPjW7fr2vIn
         qVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284666; x=1794889466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sB+qucsTWzR2GT3huYaY7Vowbb5pb353bAlTMET9Yqk=;
        b=KCqlAfDMlp19hXJqJREmQPu0DUQZxh+4T5b/DSXSgWwODDdAZ713Go22upcq9Sl1rV
         Aemo+iJSA25Tm7nnKfp1z6AVDG0grxnoC973NAmYgGrWDRXL8YfYpaElCH/RA33Xzuts
         v68E00bGFEcvZEuMPo+LFcRuhm8bQnerT+/bLUqmTdi8cs3Ig3DVbtij938hv4MTxf/w
         xzOfKS0yZ/tKiwlA/BmyJb6QYiSNC8GR7XIBRWEOqIpTrCQ1Ok5zMKdiSbe6EOfuvp9B
         ZW6En3h0CrAh1/UYvpqG/3D3Pj9vMIqpCDiU5s0tQfUGWGA4Pj8ZGc+ywTlHAaU4bZNO
         gGlQ==
X-Forwarded-Encrypted: i=1; AL+hErHxI/yC/vk+m5t+jA5x3ARmHoHPeGi6Km7xCDwb4HBC44UCfKs1SmafU0pL7FjWO1reeDX3hfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z91VWGyj5CvlZj1fF8UfG0NosDlpy0mQfViFEULPkYaDLz7xiRb
	BWzPr6UfAyXEt9vW8ZHosiOBGtUw9xbG4EK5YZJOirYvRk5XI5uxzt/1qRsms8lDGw==
X-Gm-Gg: AYBFou2ckfOAEnR6zDmb38a4O/FSBqQhWb7sZgRmwlmpmSKLHLpKub4TET2zLzR8RKC
	MAxXk3HEry0kxD4d6e5SfSi39WMgWD8BZnG9r/1A5DtIBdH99yKrf3tkW8f7gbBaEBhwm07dzej
	ByUmiX9j0YVTuN4Y0yfdOu3XnAcCNsHtP2qsBBJN6On81AZPLYc1bdd9ns8thZMiPcbaKGpaaR6
	PUaY73vkgDxbHWzcT4oa6mi5zK33o9dMX4icer+2BDzoZnAhXWjQ9xY04n8nOv7oIW2l4HBGI04
	op43f3Wx4+G9OsEM4EuI9M+HoDtXyXjIOJNkFSWHrTfcjMqW01c4UCFUChk4A5BHGQkKRDzHGbV
	2mIjnqqGLja4zMVcpS5MpMa9orY9t2P2pJXFu0y5JJXAmccZ8nwx8t6i+ud/AX+TXCkutSDq3eI
	tpiV+ylCr3ouJTdry5LbbkzEzB4t4pOm8bNQJomF8xFwNbQMDCUmUry46crqbl0lSNbnk3O2pE5
	wG/RBXqYV7X03+1aDz+oI89xEZhVIsw1liFBXpaj++7YS/BhBIZk3ZhdddONLReDeJ7pHLvMDM5
	LsVLRrxOA2O55cQYfaSnJwYzoasCYjvnOXu02p2c/He9ssxdtFqEqA9ZykBWJK+YqjBNt9Xfr5q
	BrLI/1E7Xvpf1c5gH
X-Received: by 2002:a05:7022:927:b0:1b3:a22c:7f68 with SMTP id a92af1059eb24-1b3b60094f5mr2444679c88.29.1794284665400;
        Mon, 09 Nov 2026 20:24:25 -0800 (PST)
Received: from cantal.lan ([58.136.75.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe32276sm3116950eec.8.2026.11.09.20.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:24:24 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Rahul Sharma <r-sharma3@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chintan Vankar <c-vankar@ti.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/3] dt-bindings: net: ti,k3-am654-cpts: add ti,gtc-push
Date: Tue, 10 Nov 2026 11:24:02 +0700
Message-ID: <680b4e98af630c4759dbdf73b53926ec5f87fc3b.1794284248.git.jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794284248.git.jjc@jclark.com>
References: <cover.1794284248.git.jjc@jclark.com>
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

The Global Timebase Counter (GTC) of TI K3 SoCs is the system counter,
the one the Arm cores read as the architected counter. It can export one
of its counter bits, selected by GTC_CFG0_PUSHEVT, as a push event
output, and the Time Sync Router can route that output to one of the
CPTS hardware timestamp push inputs (HWx_TS_PUSH). The CPTS then
timestamps edges that fall at known counter values, which gives pairs of
CPTS and system counter values.

Add an optional ti,gtc-push property giving the GTC CFG0 syscon and the
HWx_TS_PUSH input the push event is routed to. The CPTS driver uses this
to write GTC_CFG0_PUSHEVT. The router itself is configured separately, as
it is for ti,pps.

Signed-off-by: James Clark <jjc@jclark.com>
---
 .../bindings/net/ti,k3-am654-cpts.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
index 3572749147fb..7bf5bedc2b9c 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
@@ -101,6 +101,23 @@ properties:
       The pair of HWx_TS_PUSH input and TS_GENFy output indexes used for
       PPS events generation. Platform/board specific.
 
+  ti,gtc-push:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the Global Timebase Counter (GTC) CFG0
+              syscon
+          - description: HWx_TS_PUSH input index (0-based) the GTC push event
+              is routed to
+            maximum: 7
+    description: |
+      The GTC is the SoC's system counter (the Arm architected counter). Its
+      push event output, one counter bit selected by GTC_CFG0_PUSHEVT, reaches
+      a CPTS hardware timestamp push input through the Time Sync Router. With
+      this property the CPTS timestamps that signal to provide hardware
+      cross-timestamps of the CPTS and the system counter. The router is
+      configured separately. Platform/board specific.
+
   refclk-mux:
     type: object
     additionalProperties: false
-- 
2.56.0

