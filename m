Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260F5678C9;
	Wed,  9 Sep 2026 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975086; cv=none; b=Te9KJDUt+dHq2A7dTPRCVnPEhXSw1lkUoHAJk3MLN3ODglQVC1EMyrRWzlfyWGqODmZTrtz33FLf/A5YF9708f7I8hzCXQAD0bF7Ns6AGQz8KgJhLaLWY0EfS+VkdPhOx1KSYIjJgsNGuOtk3WeMBnOZv5AkGHRZRZS60s+xAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975086; c=relaxed/simple;
	bh=T2U0BhcSuHwr3Q04Oax+Q9cAEyg+8M3IrVjIN1pHo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAyHUajK2Pq4AL4yGf7gCl5pb5seJRpAScT8A/EQOy4/C73b4RItOMzay95zNPcKwFVAYfYpjd/iSv04hjHdO1rdNfQxn22a7yrrezLtHfqHxQDBTfgw5Z+lgIAiTIlxTBESEk2fag5H6lsJVTi+2XucWSkq1yp1yZh1eLVVpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=zwg2ydvE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ei6VKWxD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="zwg2ydvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ei6VKWxD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 797967A00CD;
	Wed,  9 Sep 2026 13:31:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 13:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975083;
	 x=1789061483; bh=J+UiB0JQF3J734EIk7xL8AfWMjHXBByPW0qfltoR+18=; b=
	zwg2ydvECnUvMht9hW8076PWjx8woNgu29hvuYB0ZbS/J7xyAM4nrk1nO5Sycvu7
	UVRa4PnEKHFDnZKI9ym9TFGmByvIjE5j7Z6qhg3vnW5zdToRtGsxJdNw1D2Y4a3r
	O0d6+pnUzIbdoJ013Sm8eyCDTqQzMSxEMdCpRZ+ErYjyGkA9wlnSXAKOrvxAuk67
	VW9X7J/hqklxiBTq9V+wvwg0I1ah4KAKClAO1uL0tHDsc6OG+5f/wnkOj/x+CLqw
	PP2X6bwdtlBPzWUcWOTilbJ2Mjk5yJZoai+AkO7OiEb4qJZ4EqaaNESu0M8nFRNS
	GU2eQCD1MC08Yf8oKbD0Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975083; x=
	1789061483; bh=J+UiB0JQF3J734EIk7xL8AfWMjHXBByPW0qfltoR+18=; b=E
	i6VKWxDNbjUvSwSiuMaKJ/IquayiuRs9o4QTkmdNVDt6gRM9cJPg3VbavKHrGWPf
	n4o+zAdUorDRcA9Erx5vOZG+Bm8Cssbfkm3MBVpHV4E+4ZiM45NZTV4J5C1XUuei
	kSbLa9pbB2VRu9zWtAnPAtf99kweTC5gEmBl4yeF0tTYCxKDEQq5iVG5tqKkHQFI
	9VQW9jUqDPJ/nyuB6JSOuO03hYqd81DOi844dl6BSl+jbD1kSfuKw/1cepihTJZF
	6mpdC9OoONEWwSs4sr2UR0ZjhgIfyB8U1ftpmSCpmTCz8AMkHJV+PFrTbbPoJOpF
	DTVRoP5VObIHdy2WHttuQ==
X-ME-Sender: <xms:65ehatdukLV6IRgDpnkCnpsS6wp17FP5asBms4AgV7PD0tB7-mji2Q>
    <xme:65ehaplFuwVZs6QCQrMKOufGw-A5JBuUMqPWOd_gpenuMnWlzlU7qYurFQXrqhRMg
    nrTlw6A5W9K3c2mMQXXI_oKNi8XJU6jsScqWXG9lmKlMj8sBLPyVHo>
X-ME-Received: <xmr:65ehaijRuwNG2vSaDYXqQCTxtYkU4ofDDinJVBmRjwMQGNQPe0WFWQIPx-Qw5PJOFKPmyuu0wFmvwCKzXgK1lXvFL6Pkjgg>
X-ME-Proxy-Cause: dmFkZTFXqFEZUnNCVBq6maUL3v38xhhrAf8GAtK+/CXoS0IWijgVEgLNpLnHNVjDlGVlDs
    v2hY7tvTUbKhcu8SwS2K92TuSoyVhqa+KWn7TC6YbQfS58BAB1nv1N3sqsvMkLmGhALYbL
    GyU/ctPmiWnfMzWE8wrxRbe9sTQmGk8DZ+5fQDhWfC3F0u2qvNKhnxBTgXb3k+4T0J4Kb7
    XcVCeXE4LdKjTMQja3Cq0gf9GSuSItpIgO/ZpzH/36Riyo8o4Ec2R4ehjDJI06WvqmepHz
    urjDsXPLML1i71n5LV4ZtIXVzc13eMh130tNZs2yEAFcsipzsVFrm5VzV+UdoUyrm2CASt
    s8IzLjb/0PL1pQuo0yz6LLG/esGXiuKPxw54fVjVjk4ROjQeeQV/amrSP7irD9jug3BWtg
    yjr4WLPdia/H5KW+8GPjV4BtKJKQRo+yCEIXUxyUJPTa6/am5BbgpoCpvovedAFxCnVFXp
    vKK83Txzslf9yUG2/NM7gjRjNJccpf8/Izi7pmG87DEMZuE+iceiHKbVdSU8IJ/I7pCjhN
    mzJm1cSTrNsy9/L0PvRRIZ+wUfatKoY2OB9g2vhLTzsh0SLP/inewHneZhUWei7g1rdNfz
    Bqp1TpijQrEBwyEh1EMqvnEIgGRqceBOUhuMiA7LHqO9Ly7fGw2QZ3RkJY1w
X-ME-Proxy: <xmx:65ehaqGUHZYYr88gPEa9vbfykHyCt7gFIh8Qw3pvIV9t_boFvombVw>
    <xmx:65ehahwQVyoObnu1xiJQNz8oJX4itMtO-BVoP1QQsTI2oEuFJ_4IQQ>
    <xmx:65ehahq4aStfk5dzkjY9XKXIKKKGyRuRqMg6wfa_LLBCJUrpqypnHA>
    <xmx:65ehasfMHDonSYkdiHN6uEKUqsEML3dOVR18WxpEc0sJDt4aAHizZw>
    <xmx:65ehahHugwwYcV2bNimyh0ZKgZ4CIY10_BkxM0usI9rmcPdOWDUjPMXB>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:22 -0400 (EDT)
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
Subject: [PATCH net-next v4 09/10] dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
Date: Wed,  9 Sep 2026 19:30:26 +0200
Message-ID: <20260909173027.2201560-10-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
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

