Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED364F85C8;
	Mon, 21 Sep 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013090; cv=none; b=fTRH1wexfJjta5Iqfk2haEosPvYWVo3XHM2zQdrd3EGKimJ/h8Dbr8jbF8uy534bQhrG8T7oLC9DX2Jp8xVaP6uZpPv9EfhasLHgXJZOx25T1QUC2E5yXSgw54Fk3qUrkLFqXNZqyQ/P6Yk8P0b1GaqFnoEx0MQpxWMrNctVaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013090; c=relaxed/simple;
	bh=T2U0BhcSuHwr3Q04Oax+Q9cAEyg+8M3IrVjIN1pHo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2SAi/CUdwR7EbcrFvAsAbyg9NjtaG16RKCLW5+nHORcYWn05h2blp1m1ix4KCAGjAEa26QMMAe6QFByYJy/XDC3e3bOewq1Tp4Ylrt6Kbh4syWItWYO/ne2qsHAga+4+K2JeEftpbVffTz1kXQLcT2gp2UAYdPGE9ZAia77gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=AxzdnXSS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjEsukt0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="AxzdnXSS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjEsukt0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AF70B1D000C9;
	Mon, 21 Sep 2026 13:51:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 13:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013087;
	 x=1790099487; bh=J+UiB0JQF3J734EIk7xL8AfWMjHXBByPW0qfltoR+18=; b=
	AxzdnXSSNxjN2NmoY43ImzMu7bQyhgIcuJU6XH9CMqVcX7Ugx6NZsCTo79B13xIk
	q318bVu+3YmuUu//busjQ3I65rYR4PbkUyDW/ToteMUCOdgqHwELzO04t1jCICWK
	vmB5mKzT2h8ZgWKZUd9pSgMc0BvfL1PiPpCUSSQ7rmYBWBrkXra7L2hkRXBw0BbV
	+ZVuq5iVJUu6UwFxnhb3Jsm9cR3Pi7Z0NknhJ7Dp+P5NiLi5M8UW91P9puyehBtB
	lao+q49c4szhG+tB5bIx+a5ghQ+Fvlj2ik0SSc3zTZxhYDdLF5zdqeyHqP1jQgXu
	VkKAjZ1MKOoZyjsv2GEQ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013087; x=
	1790099487; bh=J+UiB0JQF3J734EIk7xL8AfWMjHXBByPW0qfltoR+18=; b=F
	jEsukt0QjfIMRSinM+HyaYXubqTmMpCIupir0wQhav/C9zrzwdz/HOFTQ5b9ivac
	fh8BFiP/KWJKkF+fdeU+vqWXdrbG6EFYWILn1kiUboECMzazuQu73pXJC4nA1D+p
	j1tABmqFv1NrYAzA5Lcvw9v5IHGxjJOdKcuEqDTrE/3cMvNz14kZVXgGivNoaXsj
	6X23/xdbn9WNkYEyfEKgn2HAvLyxps+qDzu0CgkJ9gkY1tZZoKMOG0pDpId0BrXs
	8WW8Jmqdd8VMd/vGyGUeD+dN3NnpcHyV5i4+ILeLMQJnK7Ls4ht1lVBLTR1EZgcy
	iHvhQGqJLQ3IE6/MHxEIw==
X-ME-Sender: <xms:n26xah-Y8CENxsz2pjgv5DPstYQfyzP_b4iwzvcyDWp-3kCaBtIzPg>
    <xme:n26xakGJIw5o-JB-LTWUZfXolrUOHfXkdlHxKSdh71q1BWq4TDVKpkQ-J--plQm8F
    6_o-nBsg18RlRpcyiA7hfMEFVb3rlvTT3PZNDBAsTy2-39AiZU_xeRl>
X-ME-Received: <xmr:n26xarCPyVOViAzBsqt1qXIVK1aDRB2pTcUUBMLExGz9eA08lIApch_nISXMKKJlxv2ACUp4RnW48gNyq0Vnes5maXuCXhs>
X-ME-Proxy-Cause: dmFkZTGx2PI0DCnFrKcjMpN3OXygpnBESiscvY5kHlzEb0x0+o4FTTZEJElp0ZbKiSJAfr
    9qumY/qqho/hgXggk3d2wfNQkjmBj+lpobCkXWUqdRsAj8XXkUiqQjcsx1q5D9Wr9zaWI8
    X64FUraMSuaqcvyCi5Zhye9Uarla6wOm8gh9JnIMF7PxnXg/ryhWze3tQalyHbFA0/PBOJ
    jWU1l09x6SyhF42n1BsmxFmPXUpPQUV4hYfNI72sJwVWpwxhsveDqh2IlreCDI9lzkEkLz
    JR8n209yuLfW1Bux0fdKAeNpBPQErw7/J0JR/KE7EW2jk3BZnTl0MVG1vEfIko8Lm/JpGS
    HcyvqLICVcow4hLwxbxVn+KxJjy48Kqn/mvxkBPm2CS72PEt054suqZgInHcL160za235/
    T7MQ8T7LkSWxqB8kEDIt1eZAQeXaPejcLmpqWUHbQ4wFPSDCsJpPk9tybTS0uTo32JIjOh
    wWzt5vnLAz6VAje9LEM+xiqJpO8BJzZUeFJud/tBWBvKg0wz9I9wBaUiQwIr/GUMghOeyY
    L1JMgDHc76L22MZZKuZ9vhNCZsByAT12FVI8zXTGArMiDCmFxKqFieIBpSvxwHZ57DtYVe
    /OST2Njt24zVfqN82mNN793UXTWYuwAmyd0uNuIo2p1SViUVnAO+2z1YiacA
X-ME-Proxy: <xmx:n26xaonkhZrq-Aik0VbWBGn7r6eLMRlrWINWNMRo3c6AEtIga3k_Bw>
    <xmx:n26xauSFa5ylRzjaDR-QH0uIXSaCxQHkOJ4ZhJx-xvthmvGtyv_Ykw>
    <xmx:n26xakKOUSTpWB8l5Ra-TfD7EHo9_E50MLoiw8LULlRn8brWR6vjcQ>
    <xmx:n26xas_rGpwsrrpYoqYRgNgPwcxhtSFBFArWZMLJ3kB5CeLh_v7__A>
    <xmx:n26xajn89vr8Elld_NUpWnktVY27erSFLYG33p0nKsQnYaLvXnUDXf_O>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:26 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: paul@pbarker.dev,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH net-next v5 09/10] dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
Date: Mon, 21 Sep 2026 19:50:36 +0200
Message-ID: <20260921175037.4084310-10-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
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

