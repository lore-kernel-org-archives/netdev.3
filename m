Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D945041C
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548595; cv=none; b=c6FMPcytyh4ykZH9BxMw5an8gFU1Gh42DydMnG6ym9JG5JzziOwMXsFqidmON1cDxV+zIv1srt2MmTKvIRNO2u0SP4edv07EO2hbA4aYALM5xw5pNRfrOtPF3gAmrw2Rx3G6zGkajMDQwrwMwQ/rd3YjxqyonbAkcpwx2P8+DLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548595; c=relaxed/simple;
	bh=UNJv9lvrdAaMKo4znGMIdBsuP3iVdeueDxYAlJd0x+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTZanVojjlZo56Pv3rWtbjj9e95k+ZZBb9q77oe/cTDMYmkA9gtjW95lXXZBBhrmqFzuW7/viuOvFDqI45t2a41OC8cl0ARXqXK1yS/wwpszN3jNYIX3dz6wdH4AgUwCzo82wE/VKGzM1UZO10GtMtm51nY/qS5zKpaNuK/DnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=I1/+rlfY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="I1/+rlfY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso11997535e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548589; x=1789153389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tu1Vd9Fy3KvBC8Ugis84GLswT2AxZGxIE45TX7gUkfY=;
        b=I1/+rlfYqhrOBqqk+5AUuj4SRBYZ8fZTB9H/xYRafSXUTtlOcA2pF0CU1oUsscUZ3q
         kLMO2op20yg+jNd2Ak4R7fA06woK3Fnkjv7AWYIdBJZiN7vNbOzlgK8qEffbixiuPuKd
         pxxN/2D2ZsNiziPlgy2MzfojhcFX+P/dEcTje556APW9swPeMOaGKKSeKLSSi3fYzWID
         91Y0IPBwI1t1FaO5RPrKFEb24qX7wQk9qMpuryrkSyLZ3HtNTVMzIl64hKDOb5T1KMGK
         veTexRm4EkTSPoFD4jkwOojjT88zcepaBE63QfShn6PszNKhWUaCBx6AuNSgh9UTYf6c
         Nk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548589; x=1789153389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tu1Vd9Fy3KvBC8Ugis84GLswT2AxZGxIE45TX7gUkfY=;
        b=bsHxdslfa2X1lXzZhVGZJ1FAi9TaW+raKI2Q9fwhCuMe460AZyZA3+ew2ccxjpX+6h
         vJZtJWR+Uge0fCYzRfv6WPs6wYzfNWIU05K+fS4QRCNrNZ5rhgOtKfCqIAHISESJ/dWt
         cgPIV/6Wf5T61qayJhBbZrFLc1vhDlqyOyKTqEcQQ0XBjJmo7LhDmM0o2INqgvZWYTfz
         EDZHQxrrWCIXSQk96wze6RoOA2ufTqwH9kMesU0YmDlG75WyLCKwOci1zSCC3Qs3V6ZK
         /4fq9BSPS3ZJTEzpALhWwlZj/dGmEVHxw/jS0hqDR+7yc7ZmbU9X/7ppC6vQhKgPPkgZ
         d29A==
X-Forwarded-Encrypted: i=1; AKwUvByefzQl0nA7ylGSm78CA4NLygholKMdnDvQ2iS85mkbYahTZ/F27A2R3trkxKgGvp1rMDEdaGA=@vger.kernel.org
X-Gm-Message-State: AFuF++k/DRF4o3n/l5CXg8Rg/NXqHQ/JkGbLceQk+1pWKz4fDmsYuil9
	gsaHinWY+X0RYILt0kPvWrJh1QIv7EPteiI2trXAibYSBa16xYTzZBcMXoRVRaMyc9sfctX5oqI
	p00wxOXThJA==
X-Gm-Gg: AYBFou1L7LLyMfNOOX6vWDsWlvTkmwFR5BBPi/1hbliQ48cn0wZIxKBFYF7pvWFs7GE
	ILehdS4lVs368e6axiZNBbL5Xuk0UaJrK3EaG/k6Z/rGvTyjpMKgSRxO9/eyFQ9Z2MWitSxrvTu
	1jO5msh7pe08JUv55gOR1cY/MwDr4yYLV1co6tYvnYO/+iTloDcTp+8Yge+N9If16EmvazbP9gC
	kf9ma5Dw+Dp28YqAUhH9sqfvAXQfpbjx6FdfpDmPo7Gwy3CmTVAr5HgsmedeHHSarhD56s1MxCh
	dDCY/36t2q2DDpu61T5nKTGidCS11mVg0EBPqVgQ6lWk4I1tZ7tyudHIwc00pU4QJHgq2EbhsNA
	0ynB3k9ituINYEJw8meKBZKeA04gVVKgUDt+3MWnVC2drbvZvjpQFjFsnJdvhB+aOtcjrRYOLOn
	Btd/ExRwwkmbexu2HmtZRmL/qox5TaeFETxPDuBsk=
X-Received: by 2002:a7b:cc91:0:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49cffa00196mr22006655e9.6.1788548589176;
        Fri, 04 Sep 2026 12:03:09 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:08 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 02/10] dt-bindings: net: ethernet-controller: add phy-needs-host-firmware
Date: Fri,  4 Sep 2026 19:02:56 +0000
Message-ID: <3d0ecd9c0bcc28fbbce6f7df2b6995f2e8c78431.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port can reference a PHY that cannot be identified or driven when
the controller connects to it, because the firmware the chip needs is
not in hand yet. Such a port is dropped at setup and stays unusable for
the whole uptime, even though the PHY works seconds later.

The flag declares that the PHY behind phy-handle is expected to become
usable only after this controller has probed. A consumer that sees it
keeps the port and connects the PHY once its driver binds, instead of
failing the connect. The prefix names the entity, like the other
properties here that name what they describe rather than the
controller; a PCS needing firmware would get pcs-needs-host-firmware
by the same rule.

It sits on the controller here because that is where the waiting
happens.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 .../devicetree/bindings/net/ethernet-controller.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1bafd687dcb1..ce4a7a6f605f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -108,6 +108,13 @@ properties:
     $ref: "#/properties/phy-handle"
     deprecated: true
 
+  phy-needs-host-firmware:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The PHY referenced by phy-handle runs firmware that the host must
+      load before the PHY can be driven, and so is not usable for as
+      long as that has not happened.
+
   ptp-timer:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.53.0

