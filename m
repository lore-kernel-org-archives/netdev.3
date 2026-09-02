Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DC3EEAE5;
	Wed,  2 Sep 2026 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338859; cv=none; b=P/yk+NPp+R/YmsgI+r564Iss6Yuqld1m1lJyOP/xrT+jC/nrdYxFVpT0ayS61OlLdDeauoym2hST0yOusjGVWSz4nxsIFSQ/48qAInsG2mLIkYEwU8HLVK0c0rdlNsFwLnKwv0jHJ5d7W9hbN+Ej2vtoxhJ1KFOS2+lg6XBYF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338859; c=relaxed/simple;
	bh=T2U0BhcSuHwr3Q04Oax+Q9cAEyg+8M3IrVjIN1pHo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfDi8GHjxdvyY9T6wTJbUbiIFcgmaqzgwAVgxgyORfzniWyISN49tzBiK831cj+UDBCKC8mqUNGUWT0a7eb2t3HHT6Fx4kkAkiLiuYAZedX9RWnsuRQ5cPiE2RgcQcP2698T09J7DQJ3qkSmJ4EMfbnoloFLPYXV8xk2+YX9O9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=oybeRazx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/e4GD/B; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="oybeRazx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/e4GD/B"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A5018EC008D;
	Wed,  2 Sep 2026 04:47:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 04:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338857;
	 x=1788425257; bh=J+UiB0JQF3J734EIk7xL8AfWMjHXBByPW0qfltoR+18=; b=
	oybeRazx1K7GB+Ys7rCm3b85fXiVvxyPZBdHvD5oHi/3Q4cK80praDdEs2s9CZyb
	avQTVdDiKYuf3PgSQRdpZBQZgqRmgtbXWQDZIewqbbdNrlNaQiZ2MpNWlwEv17Ca
	L2ZD/rJ9uREJUBpUXoGqTcrd/rAKwW63xnBsoAS9ntR7BxaZJxZjug6pPMuvTFhg
	OlKJvOkl/rq9Mdne4GCGieCvHhVdUmM15QvFQ6/GGB4Zj75T++Is6iZDuV4rK9tj
	Uc3AWPrGY4iZ2Yr9n3CijNVUtvxKhZeNGURJzIT4X4nsGOtOs3TPuvwJpQKI8PBP
	6WqYzocgZiRFMcyyoVYkLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338857; x=
	1788425257; bh=J+UiB0JQF3J734EIk7xL8AfWMjHXBByPW0qfltoR+18=; b=A
	/e4GD/BORpfQB4yb5RokTm5vRP4BIID98/EG9aPs1lCFOwuHWyFwJHnoiU9hIknk
	G0AqW4vbkzuBzpNkRadZfKKO5/kQQ8hiatBUTuLmybxAQP8nJq7CtCseiOZvr6pZ
	XnMdscUq/YoxDFHhDgjJovT8St5qpvJbwebbVv9fLqxRqKJLuMZGdbUjLHaaNrd+
	tSq3qaTn+dc3XTubEuclES6/qDb4xWUkDKkw0XUu0hN399W3w4MTYg9zyq3v6WZN
	10uvnekjv9+D0CDHux9lCZIj+8DVrb+9/nbkz+8qKuHXngbxkQkgpv3hS1lS1ZEc
	gcl/InPoDnWeTzpdtE+8A==
X-ME-Sender: <xms:qeKXai_icMuF0yTJbDZcbPJYArTxaOUmhE-hBwm6fiatE98iTo_uIQ>
    <xme:qeKXah_AUHTgROJTpoMCoRUNvkSDHZk9iM3LE_EuHUbnZ3E5xfC6KLNEOuWK5l-IQ
    DAOx1fMuWchd0g-jozPZv5cUwMCad0bubijVPHC1gCwlpuXZuZe49au>
X-ME-Received: <xmr:qeKXaq2b8Cu6gmdEd7dtUTZ7epVost1REV8VE06TqNR_Pan69dc4jdMhdBQs43VezJcalo3YzDU6A8EfOMXw-DyKrrC6UnM>
X-ME-Proxy-Cause: dmFkZTGcgouwTvnsBVtGpNiGksGRaOMOsvVCsb68YI29oYxX/TNQSqk1y6eanJU4idMVG0
    iw2/QhYuXLDa6Ldg8xgiv8ikwgZeaLYorn5+MTUE4D0dq+0Dq8PKlVpChrufjFz0GhGk09
    0KocQa9NdgqV32JIYxQl4AuzWhSdoA0JLH2diCf6x0gXMI4toKSMd4aq2nRESdNjiDNvA3
    /0hbZaPwHzYdGm679+XYnGvw9/L+Wg+iYHOtjGptoT0iaYQ+0NTO+pzpZIDJZpmgH36OWv
    WwNVXCRD1hnz2mMZeFdnXv1ntCVbMW+v+UT+r4+XcxU+EUnQFasWSyPn3bdlEbvBzSZJfv
    4dcqUhcSRNaFG9tJhZzXh+NoiEyitrom1XxuUg9FxNNtuMSw27U4x5XOBwpI8M2GUg6qIK
    2Zjmv0sAXYzk0wpgSTMmLX80vX2X3z+lPNYKRcQYtYopx75/+daDALCCaWnjd/GEb3jPvE
    kLqeBTEVJZ+bWnf4D9py6fpu6vkvR5iY+J36riJFzPDQpDGxaFsoIsu2TydLCGkXO+x3+z
    b//M7588cb72ERB+4s1WJbJKB7Wz0pAzTlwBkFUK0cT89TYcwMWExX5YoAoLcCErZJwSfb
    4S4bujLlOfrmSa3JyGfPaFOzS51Zx4asp2HjoSPWntl8sI/CrUmxkMG/XHTA
X-ME-Proxy: <xmx:qeKXah-OnecGeSDkD1GAABx_DVVZOIO0qZQP0K4Y98WB3M_tOcTu-Q>
    <xmx:qeKXarelpUXj6KUuS0PItJJ3LukSh4K0cZrdMYl2mcgzjZv9_M7PFw>
    <xmx:qeKXatFHIc1DkcQ1t4_vuT2Os8D6vfM0tyU4pG3qWrH8GmqH_z_HlA>
    <xmx:qeKXagBBcbmXyUBy-X9Jd0SjC7qk26QQ9njjqvvW4_QIIPfQzSsgyg>
    <xmx:qeKXalIPmAPsTGWlZ-TwnAd62C93AnTefAX1EW1hVxdm18uwR9UXFlQO>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:36 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v3 09/10] dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
Date: Wed,  2 Sep 2026 10:47:02 +0200
Message-ID: <20260902084703.3228504-10-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RAVB module on Gen4 have no gPTP clock as part of the RAVB module
itself, instead it relies on an external system wide gPTP clock. The
gPTP clock is shared with RTSN on V4H and RSWITCH on S4.

Add an optional phandle so that the RAVB driver can find and use the
gPTP clock. Ideally this should have been a mandatory property but for
backward compatible it is optional. The RAVB module is capable of
functioning without it, but can in such cases not provided PTP
functionality.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
* Changes since v1
- Use generic ptp-timer property instead of vendor specific one.
- Improve spelling in commit message.
---
 .../devicetree/bindings/net/renesas,etheravb.yaml     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 1e00ef5b3acd..fad002492421 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -97,6 +97,8 @@ properties:
 
   phy-handle: true
 
+  ptp-timer: true
+
   '#address-cells':
     description: Number of address cells for the MDIO bus.
     const: 1
@@ -305,6 +307,15 @@ allOf:
             items:
               - const: fck
               - const: refclk
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,etheravb-rcar-gen4
+    then:
+      properties:
+        ptp-timer: false
 
 additionalProperties: false
 
-- 
2.55.0

