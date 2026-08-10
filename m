Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3E3DA5AF;
	Mon, 10 Aug 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364149; cv=none; b=HBU9uapcVrqF2yw161MSvNsBnz8jWMEI1aE2Dn/3TawDPjZHLfHmRzCbVZUEMrLO0qOq5vj0QXTQi0hc8CfuBX5kPJLjCjXwWUTp2Fz6F/Gp08/nodd4qUOMYDkgN3oTMwI/CCdjg2CHyTc1nfQqcd7E/IKNFhsTq5Nu0bLRF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364149; c=relaxed/simple;
	bh=M1FEvrydZ3cAT5N5FfbTHX7UZCogZ/FJ8FFgL2S3Yl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtqFx1ImFllw5peKdtAGS73GewG0TkSZ+ik/4sYJgUaW4rsIW3l2RnOPqSWnt2tpWPF4SqA988nMQLTxsnKa6L2npQxzLVAEXAB9Hyg/Ka24IpGoCs7WOSSwM9Nic17o0/tuwOe5c/4CzClYiXsIygp5yBV0QRZrKh3xf4VLB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=UeIEk5zM; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="UeIEk5zM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB833BFA89;
	Mon, 10 Aug 2026 15:15:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786364144; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Hf3hq9uUQWUEz8YvFbiRVgRTtJAkRTrXQ6MRYpIYIEw=;
	b=UeIEk5zMajwNW4r8+weqNaNRWkDcX2R+4atx7y05y44m8kQkfK4J0lgfbgNpBSgxIOE/jV
	gDX1GEexBCpwzJ1mllZ9trQnv7mjFLGJ5ArO7FYqnWxcbizrpnUzbZUk3l4/W+JN6pNUHw
	A1dfYLT8jDIf5gCCTsbiP275HG8GFp6rJOEfjTneZqocPnbC49wvnftdmeg2iZiEemi54O
	CwwgmNseusKz7usvNoa7dhbEzLG/lX2EawL5RONj0oViXHKOWq94hFMdHBMqxsaKt8rDaJ
	kK2UbRp3MYteDJoxE6M5iE4S/1fJ9Xedf4jtwwwqxtMLmUy6+wuaHyb0Mv5XNQ==
From: Vladislav Leonov <vlad@zlab.su>
To: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Wu <david.wu@rock-chips.com>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 04/25] dt-bindings: net: rockchip-dwmac: add RV1106 compatible
Date: Mon, 10 Aug 2026 15:10:55 +0300
Message-ID: <20260810121121.210040-5-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
References: <20260810121121.210040-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add compatible string for RV1106 gmac, and constrain it to
be compatible with Synopsys dwmac 4.20a.

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349..65eee45f7d7e 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -29,6 +29,7 @@ select:
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
+          - rockchip,rv1106-gmac
           - rockchip,rv1108-gmac
           - rockchip,rv1126-gmac
   required:
@@ -56,6 +57,7 @@ properties:
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
+              - rockchip,rv1106-gmac
               - rockchip,rv1126-gmac
           - const: snps,dwmac-4.20a
 
-- 
2.47.3

