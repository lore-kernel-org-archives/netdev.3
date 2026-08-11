Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681845A294;
	Tue, 11 Aug 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464321; cv=none; b=EdieHT36xBaKbhWYHCroinklAooU5p/oWetzEFbFM2gu/iHTcEAjAG2Qr76nAS00Ea9JL2bRRHMLE5HGKRo485StDGAkxdVXTgReMJ2HopA2jMo09Ly1/XZCe0PUWB1KD7ILvxJ/XDARWosYI1O8tA45Hv9sQxqsHbanrwSClmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464321; c=relaxed/simple;
	bh=2qs+hrzguVK0nqLM1BWqS6U4g6GEKgQ9AWEGhV8qzwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkFtNwQPm7d1uDofuvoRg2Zxx/mQ8YsqRHgrQGKJEUYRk5y0QJLACOAHgLh7Vc4+/coAnX4SXydvX1gO1DPCKz77kYHE8wjjbGupvQoxYa7Ur2n+z5RxI+y+iFyHzBiUrIHXAXu5OpLIWFjh1uRUcQvMJXKaEVPrmQv84h7DwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=kuJBcJe6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REL36VNT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="kuJBcJe6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REL36VNT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 44F1FEC01EC;
	Tue, 11 Aug 2026 12:05:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 12:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464319;
	 x=1786550719; bh=seyJdsO2WGpvFKsb5tM8GxoKEIf19AFzcB80UIKMPhk=; b=
	kuJBcJe6TMAGdWaOIikSJmNr7Y9x9IocoOr0rMMb9qmy4dAMSDeGm10nGydoF+bs
	VwOGQN02fiOaHjWfCLlSTHRnT+QSatcosxOO3u9dC9hT2VdziwU9ff+tnd0CkOS2
	ur7y5E9C+LPqwyuAgbJmmJnrbLP69eg/ML2nryfCOxiHPOUWb6ODPjSpsG7JOIBk
	1UHzo4WPzR4XmExq8/ngxEDuohN6tdc61UG57oFVQMS2fV9cCMnaNjWHIPqusRDj
	3BiUfBS8uLBjg9rI/1MfxIuPGGHrUeAstfrJbJkfuCraxWiqvk7Xssx3VcPWxF0R
	Q5l4GoJ//DmLAWM6tZXGkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464319; x=
	1786550719; bh=seyJdsO2WGpvFKsb5tM8GxoKEIf19AFzcB80UIKMPhk=; b=R
	EL36VNTQGI7n9EBBFhleLd1rNbb7+SVIn8JbB81zP9AEEbGXI2ajx8mBnTa8X+tf
	xwe05rw6vBXoYg6W2xsELB9yCBoyNfV0sapgKE8gEuhB4084blQ5pCx030ptEo5m
	vafZywWV62ZOHWFGfoVRAH5UNJL3LzfaYe7hBvwiTXh+aH52MDLi1P57nibN0wG8
	41bkcr+nMhDOmB4+REjXrc/f4eoNYxgk0lnwGcUz0v/GGKJD0P++bfORCK7aA+Na
	pbMN4Cc//mDdKRzGMuEL6WxRdxu1qqLXgty7ylPOOJ4BxfTqUc8dZTCkxmhcjnNL
	9k4l0S91ufbwKgEkN9Wrg==
X-ME-Sender: <xms:P0h7agajRNbLrEGLR3l8LMlZZIyDiqEVQbInuS6cQ1dDHnyUmJ1KfQ>
    <xme:P0h7ag7t160ddiAzrZN3wQjUAcJMY1BerI8711m0dJl8UqQ2uF3tjqO-tqvPdr6Sc
    VDFOaOETNSBYrVvzWdpVNRGfGeFslRVK1rLcxGUt9J-3SaE-wS06g>
X-ME-Received: <xmr:P0h7ajQa7RL4UYyzkTF5Yzn0-6PxYefPq9R-t10L4Jw6HZY-jkouZ8I_8_5YJ63ROdgrU74vNNTo2AzMpZneKTh5jtrfTjs>
X-ME-Proxy-Cause: dmFkZTEvybp+fjvG2kkP67oA2g09NO+RA+d/IaJ6DPiQy+f1TXFVvFN/PtP8GAKCRgrLXc
    JH0YElAHzDzy54s6ld7p7+ltlCLNMUbNDrPpQUYd7EuOR758DHRRZc//tXv8Rnf3A+5b/C
    UP3V7rirPuvI/zqoe75wEmftOnm6v55qJAxmgVF34yCCgiN5Cch1MTYW938rSqwZVq7ZdY
    tC/aXto8TcN8NTqWxNguEptHr2Ea1bSiEmDH4WMdP38/xO+SPxZeVRZ9edyJg5jsOmsk8m
    dOTpIF8YkNSnSO5maV4c01ZGq7tJzJnBMA/4RZolL82lthbAdKjxw6B2UkneH+Emq5QAH5
    a/ULYKrfCcH1zVxNgYMJdSfNA3tdkvMDYHlc7CNRRm2cOQdz9HiVhMmBs/chSmj8S//+nr
    /UzG2tRHhoYnUYhV1U8MajWaFkjX7nM7D2m67VYjfOCfMdjCqOXlJUr0SHyjvFF+AzvVRn
    FjkgMgWfKiwnXMtCz3k2RNFBLK1AYEZkr8D/ncN+Lk8WJqC+n0ppr9MG6NS3IoNzpjovo+
    aTa+3qV33cOAPRt/5MJ2toVDjwyS5r13eUZuBdt7S24RYMPZZ1Tzn5c90mI+9qPx3ycwSJ
    cIOWKvx4KVxMszxIbsOBztZjBysAmdcD2v/8NxEkbInmxk6NgN70RfoAmC/w
X-ME-Proxy: <xmx:P0h7aoufJfABE1CDsYWNfj4pSKtdbyB9hZkZ_MZ1RDS1dOSNIEF_Ww>
    <xmx:P0h7ataGdq_taUE3MJmQna-b_OQkIF2h1RMfu5CDdHvZFLP5p_I9Mg>
    <xmx:P0h7aq-2iSk6zKKe6hqB3PagmM-q_KPwuHwhl90U4FfNcvJBEoZzcQ>
    <xmx:P0h7ahpg-6maFhIep3LBmTktkMpwP0c19NLP6jYU5rvHvjH5vnjs1w>
    <xmx:P0h7auduB2tGAUVmkgL9-E3aQeY1rv0B-c0Wmy5UiTNyrjPmAgWCWDlY>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:18 -0400 (EDT)
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
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v2 09/10] dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
Date: Tue, 11 Aug 2026 18:01:59 +0200
Message-ID: <20260811160200.2049987-10-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
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

