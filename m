Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AF3EFD07
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920149; cv=none; b=ZxjukeHufVcGjnsplKHG8E+FBELBRVBVBby8uS2rAWhVI75opJoKvrFqTK7X6AqZ6r6gut/fs9A4AcHVLDnn3zaQwRVRX7iYVmFafbjT4sTb8lZ1N/s5h+K0oRp/nH1WYiCdjz2GoCRV1f0QBKuBjfcL75yiiodpmqRIthOeGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920149; c=relaxed/simple;
	bh=tBuHJhzyR1hEsYiEvM9jD9sksOaD5cSYtrYtChto41o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ0VGhZshafIT3UdXtFqPx7xnQ3W5gipDJfTThUf0A1oKhJoxaHp52Nh7mnkveGOja0Vg7TZOsRf2NObzqp0FuOf+JvKixdD1dnXC6tVRY98WchE61nGV0j811crYCAhtXWDEoGOc3omFKQrxDTfU1leC+5ju4LOf/RGQ66jPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtSTuQmn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtSTuQmn"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39faa67fab8so5480331fa.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785920145; x=1786524945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1H1aAxnj7afVZ3zqJ198w7ntS0lziu9NK3yGPDspD10=;
        b=EtSTuQmnos/6pYn9hqVY2iiCSq3mOmk2xzbekBsX2xX+ulUw5dQKP047q1kbtx0r/g
         Xop+L5x8X9txPLFCvTJ3JciioKIXET0hkgcT3osGau1xDTcBobfxruLej9a17IUPBP4w
         QbxTYi+9gCQrDQlY3bi7r8pWY9xGDbLaU8kFRcUtZdzJLf2gvBjwmNbAfIPi9D0qDgcc
         xx0rHlqafH/PmznNcMousCf3yrCECFtrmMe8KQJj84VYRpSLPkXqRv1BNZbamuM3s2mT
         nECbKWKVEoSZ9sVsZiz/FWcUKk0qpKPBlKQO3IMVFAejplzUbMCAczBdhTAj3NWtAlGX
         IRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920145; x=1786524945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1H1aAxnj7afVZ3zqJ198w7ntS0lziu9NK3yGPDspD10=;
        b=j+nIQHtnz7q21hgufYBiKPKZ0poZTN92Al7BF1r09F+fZamHF2OB3p7TQ+bnoMhlI5
         xbbQ5Uv+52v8lK3Z7Lijksr4/NdbSHLz86a7gFWde53iQlCd1RlVBxNVH4bMu0zI+PMW
         8WbUTNSgL/bXn8O03FHBTe67wtvNmpEp/iiXgzpCYXapwzk2NzGoE4El8RGl3sFPrE9f
         U9DGOGN+h5yqBkWGf5gfSTXeVSa+tifdzPmX1hdzf+8N3Wdu1zZPe8u+GyzBTVsDP8RO
         +drT3W4coE2AV1Qzh0+ZZwA2kkMSPFkhkOhdVibezS2mucUMwwRKt2zQzweDA0+mOtSO
         CGvA==
X-Gm-Message-State: AOJu0YxGZVOIpROzXX+AXGKhmWg+3SrkzzD2yHNcj3DYEO/ejnygyRlS
	RXBJ6uK0BQqRbqwm1kk1goe3zfjVlpNPym8uV0qwZ9Es8gb/3xidl4DTHUE05g==
X-Gm-Gg: AR+sD10eq1B3XEhvXSNsK/aHJm+PTKM6jfS0j1JGW51EH/1K5vZKsUOUEwcrqYVa8ub
	UaFttjzSDaOPsY34XNlr2/PxholCxeGeudrpbU+YRqzA4fD4D87ZSR6wuWwePlABB6OyYGsCbek
	cUVUUD5nl0EfUUUcRPiMp5rD9lfC9lRd6vqAOCwMHxpujCce2snmzqnBrTezfh+GdNSaV4B79Qs
	jE1DF4khckTjAkDJcC++ixl3iwHTn1RvV4rsThieARjFY40jYXYVDEJjTHnolj4q0hAnowDBumL
	5/fnSVJ66IrGgwuZgpagw1diIWJtq5OO0ffTEHCP2KLJksIMu3rYtyjQRtlXwSRQ47xynSg6afY
	So+s49y+uWtm6BYj0kztOqIwlVvwK2uPlWQvel51NQu38WMd+l+ewv0gzsAFfV19xcKVxyhG1vb
	+8UCNd1topLANR0+SM06yUMVXeaheGVXrrJOgHunYn33qLAu72P2T8acfWyU4Xng==
X-Received: by 2002:a05:651c:1586:b0:39e:ea4f:4202 with SMTP id 38308e7fff4ca-39fbb262b33mr5974851fa.31.1785920145074;
        Wed, 05 Aug 2026 01:55:45 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fb9a152aasm7470471fa.21.2026.08.05.01.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:55:44 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v6 1/3] dt-bindings: vendor-prefixes: add Guangdong Dapu Telecom Co., Ltd.
Date: Wed,  5 Aug 2026 11:55:38 +0300
Message-ID: <20260805085540.452260-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805085540.452260-1-a.shimko.dev@gmail.com>
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Guangdong Dapu Telecom Co., Ltd. [1], a manufacturer
of Ethernet PHYs, networking and other equipment.  The prefix will be
used in the DAP8211R(I) Gigabit Ethernet PHY binding.

[1] https://www.dptel.com/

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..f8efecb560b6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -457,6 +457,8 @@ patternProperties:
     description: Dongwoon Anatech
   "^dptechnics,.*":
     description: DPTechnics
+  "^dptel,.*":
+    description: Guangdong Dapu Telecom Co., Ltd.
   "^dragino,.*":
     description: Dragino Technology Co., Limited
   "^dream,.*":
-- 
2.43.0

