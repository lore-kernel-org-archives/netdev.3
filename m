Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B2376A0A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752265; cv=none; b=ae9koTJj0BHIAAFuV0y2zvPOxgPUJfwJkMLnhx3p3xfoIjTxDNKISvbcE2W/00Zn+3qBd+hUMq/J6Bv6S7ueFGU1iAZdezkegiu1CbHUCp/MzQSfIWN7cHHF+/XwjbIR0OhPPYoXrknr0RgBguRAWtl3ykY9Ni8awm2+8DyWubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752265; c=relaxed/simple;
	bh=mdK76CmT+sB/dQ5ZJu5idZ9uOc3wWirMdV42A93LRnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unEqqgl41021mA86cR2BSBwPKqhUlBIP6tiyD5afGS2blTvqxS20LaN5brluMEzJzOMRiMs9d+bCqF84JZXhArd6+m0tUV1H0uSzSwjlZ/Vr95bk5BAoAbGiCtDPCJ3i2KewCG20lSn65r8GwVuMYY8Ni7c4zDnj532tXdsG2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO1GDl31; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO1GDl31"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3423041a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752260; x=1786357060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugGg4EQGeqEihDKrAN4SwKwxBN4TCJS1gjxrloyykU4=;
        b=iO1GDl31oHaQv7+DoivVv9UodxIwA2+wjHJ8oDKHHd3Dx0c9hVVreQhNLsZX1MOEkQ
         JsuRu/nB7VKIe3ikgW/bHi20lh5trydiEKgwvK7iHIGAMzTW4SgBt/z4TCyTOBmC4W4K
         /p7fAJO1RfEDtfvRVS3orWa2wwOwCSkV9Ggg9uJjkqAumwz30eDX9nnN/CAa2xWZdKCY
         MAaMuYg245EAtAOoi0cNlkA84nTH60eSmoul7XTcj6lTQpACrgqSMDHSD9lXZM3lDmuK
         kPUC08T9CTwyW3xikhDFoHUTMYhWnRDYoG8qDB7MR0RTTCJLDj/0wfEEj3VtitUBhuPX
         0C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752260; x=1786357060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugGg4EQGeqEihDKrAN4SwKwxBN4TCJS1gjxrloyykU4=;
        b=rTEkKnVsOMeH/LaKjRgQolb9kvtl6IMbRM2ZqCYV46qORkVI7zt+pd4UxNgGCy8HzW
         URlGTOfjxouOz7zzzpQJWfB0zdRhQju3DHxUd3722KqyIiKWQTHsQyp7hANA5Oc4vTdx
         TvJ20NixeAs2eO7Z+zbKcjvIdvqEZi12vlOrEp/fwAw4qQJY0VqYzaZM8IfQiohS/Usd
         XIzCDFN4Ik4vbwdv7UyAruOgnNnCrsG/wWWtiWWx8BNU89DvuRiqBMmVlM9V2MH6sW3h
         pbxUwdnhcAv/Z/hcm/CgypKSjy7X8AKLyOnKyISULlA/ju9sGrhYdL7yEY3UWJnn55GE
         BRzQ==
X-Gm-Message-State: AOJu0Yx1/fAjmN8SZDScvHKiP1krsdILE6uklTqC7WAsHrKptqqA93N/
	R492bZBpk1x0uxrXGMfVFtWJFmdeWlTrUeK/l6UU7KtqP4wRzrbcuhhgQgyBLw==
X-Gm-Gg: AR+sD11kBBW6jvuWliBpW+0amBlN1J1ZpHma9SxH7Q9OL4ccj3ZCMIrM+yeIbNtFGYj
	mD2UomRm1bohvJUXCyhC920TGRXCS6DU8ZcPmtBmb89KSrHR6ENpWb/KOQ/NWrtSdTi3wiTje34
	nD+gHfodRdfRgwavx9T6SVMldz2VvcQof6GGoDbHm9Cgmor3oI4sHJWTPaQk4STluoSVP0g7lO2
	hkP5wwlxrJCirTdUy4Bq4/1xgv60o2LsAD3rP6w7DuRsfr1RL3Kfqhik9o3ZUKskhkLSpxgkvB2
	twSwEvjdcE11FosPk3LNIMXA+X2e0X7+MFA5vGvxCnbVLT2qb8/qRM3tnk110/is13ioK669Jc2
	ru6cMSYXIQs6WwwvXaTxEMxsLgWebVKLtrpxio2QKGUvdkPJC1PFGTkAcghVJuUyoniPKE3KrOA
	ipGFnT174OVcvSkRhearZe0/zMD6Usrl05eePLmTwTK052HP/611O3Hv7Ra4wTxg==
X-Received: by 2002:a05:6402:44d8:b0:6a0:567c:c2fe with SMTP id 4fb4d7f45d1cf-6a0a7ce217amr5861015a12.20.1785752260122;
        Mon, 03 Aug 2026 03:17:40 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6566b3sm5355731a12.23.2026.08.03.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:17:39 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/3] dt-bindings: vendor-prefixes: add Guangdong Dapu Telecom Co., Ltd.
Date: Mon,  3 Aug 2026 13:17:32 +0300
Message-ID: <20260803101734.270821-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101734.270821-1-a.shimko.dev@gmail.com>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
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
index 396044f368e7..c3db857b9837 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -403,6 +403,8 @@ patternProperties:
     description: CZ.NIC, z.s.p.o.
   "^dallas,.*":
     description: Maxim Integrated Products (formerly Dallas Semiconductor)
+  "^dapu,.*":
+    description: Guangdong Dapu Telecom Co., Ltd.
   "^dataimage,.*":
     description: DataImage, Inc.
   "^davicom,.*":
-- 
2.43.0

