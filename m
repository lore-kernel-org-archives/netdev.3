Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66B40963B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519449; cv=none; b=lJ8Eilw9bQYkw1jjYSVqeZTeW4EA7dJSG0GxnItJJ7O7BQ8qYKTIY6DbRHiFlkWD9FlOvGXPCnOL3xKrQFxl3s4Uy8nRNS1m1hlLgbxFnwbyYc2iQlFwyRjwzgWKLmTk+/+k0WnICPnJcehSmsm9eOcTV1dIgqr2koq2kgxPm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519449; c=relaxed/simple;
	bh=pbYzAD/lWC4Pz/OEGGhMlNyIqjw7NhBwS4JkwfMVbT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrzM3Y/AAQeM8uonwvuYvm7PmDp09wiHVN0tYxuAbOxK0NYV4/7c/dNEI1yXBFKmXOShqLSzw+zNhagVUOkMmuqcwT3Yd4dDF1WPpdOnbNqGWAdVw7hN9nARPyCc/Z+RG7+8lI4r8D8QRBUUs8DZ6PTXj0bYbZswjLKv8HyOUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK6invHP; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK6invHP"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4863ee8474eso1976342b6e.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519446; x=1781124246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6hcdyukWIpCgZ6HyRZXaSSsQym/0U9vbUF5hMDBmww=;
        b=fK6invHP9bbLrF8F2Xv95Jbgmo/EccDqmfqiUXHrmNB4Tk0zDXsGPvzyoj4dC3opCQ
         I0IH5woOXsoBUvvilrVP4maim/njkUH5ydbPDPwnC5oAYKrreUD2WO3Y+CZefIy5l8qq
         ZT0p6wcZWpIRb8o3KYS6yRU7+IOeUXuadQxV/npwmkBJ5p2DFNXAMwFX0VBK8EjOGAKQ
         CRBrUjr0BLZitw5ktHq5Iiq4NPRHfSa/wFQoEBwUZ/PVGkdY/thcRicX9bpw653Kf2zG
         WZ1OCZ8HNDpB2w/VWeUE+iyzl0ekEGl8PaCzUw6rSm8HMJ4s3OU3uXlrH3T1ckCqzsGw
         YuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519446; x=1781124246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F6hcdyukWIpCgZ6HyRZXaSSsQym/0U9vbUF5hMDBmww=;
        b=CNvWipEXloCQXwT9a9Fq+xNZn2H/YmXsGyDeIWB4rQqW0vKglD0XmpPsF47XzY6a6I
         lL/+IJ5f0CKbMiNa1Okdnbe6md2UNLdRn8MvOfCKvsoKwH9fYso+5A9FcgKNMeJ+GNp8
         oZ4j2h1W/8pW3KnwK9Jf6IbUXqg3ncDxVkqKQbueQMqPWjzBhYGECa3JxNA2XY+jkGRC
         09YVFLoJTWymm21r6vK1vftfOppV3CvNo6dl3OZ8Y7EgKP7rQ7g5o68mC8PskdyjHMTx
         9uxyqIaWuedRmTY+ReCAgBl5Vtw/iUHAnSHrGiECYmVzCytqboEy+iXtjrX2toZ1E50m
         me8g==
X-Gm-Message-State: AOJu0YxAMxg1/NL2aL0CByc1mGmgEuJfMLlv613v6TySfXb6eR+O35JB
	+QUnxyBJvip7xM3Se6/Pj9xxW2Xm12kQhVzjw9+vU9vkD6YxY0mk8EoP
X-Gm-Gg: Acq92OFEDjnkaQoDLPt1Y5O1wkc7FI2Gd/a6UHg7dJGVAo41cmBveep+QpQihAbGRW+
	HOxeCV5OSmvgJ0C48YiPqk5PEuhcG1calvsUNMooswCiUHfSquVN0r83Ot13atBKmg40BY4np6k
	CgeNYaPkIBgF7cxOYyHSKg74PC89a5kIH5VbKND62DRrJXW4tmEc0gciHWY9pM92AWVj0GS2EAp
	zwPHN4UQpL9UjR4IKNgXQbHeiV83TEr9qE8Iy6gHheOoT51SZS/ZABMjemzVYcX0FuBnbtfaZl4
	Qt14aPqvXnJioj8FoXAnpqINevo2SiZHhtKSAmaHyimvYM8scDTY+DRgBRnaMiHLF3Gv4rZ6C5G
	DGOZ1YpBXTBSDJPVDb+pFrJRrC1alETqrWQApLoiEx5WIQMgzS9mpLp5QOB1GB6hJUymx4zTtkZ
	Z7VlH2N11YqHI8vFtv1p+gtydgp6R7DWXsKvWysv9hG45r+gCe3Q==
X-Received: by 2002:a05:6808:3442:b0:467:15ad:9de5 with SMTP id 5614622812f47-4865aaa8d0cmr3200764b6e.13.1780519445730;
        Wed, 03 Jun 2026 13:44:05 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm2667962b6e.4.2026.06.03.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:44:05 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Wed, 03 Jun 2026 15:42:19 -0500
Subject: [PATCH v2 2/4] dt-bindings: media: remove obsolete rc.txt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-remove-redirect-stubs-v2-2-c8c19876ab64@gmail.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3

rc.txt has been a single-line redirect to rc.yaml since
commit 7c31b9d67342 ("media: dt-bindings: media: Add YAML schemas for
the generic RC bindings"), which introduced the .yaml schema and
reduced the .txt to a stub in the same change. The .yaml has the same
filename in the same directory, making this redirect unnecessary
for discoverability.

One file still references rc.txt, forcing readers through an extra
hop to reach the .yaml. The stub has not been touched since August
2019. Update the reference in hix5hd2-ir.txt to point directly to
rc.yaml and remove the stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/media/hix5hd2-ir.txt | 2 +-
 Documentation/devicetree/bindings/media/rc.txt         | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/hix5hd2-ir.txt b/Documentation/devicetree/bindings/media/hix5hd2-ir.txt
index ca4cf774662e..f777c2707e65 100644
--- a/Documentation/devicetree/bindings/media/hix5hd2-ir.txt
+++ b/Documentation/devicetree/bindings/media/hix5hd2-ir.txt
@@ -11,7 +11,7 @@ Required properties:
 	- clocks: clock phandle and specifier pair.
 
 Optional properties:
-	- linux,rc-map-name: see rc.txt file in the same directory.
+	- linux,rc-map-name: see rc.yaml file in the same directory.
 	- hisilicon,power-syscon: DEPRECATED. Don't use this in new dts files.
 		Provide correct clocks instead.
 
diff --git a/Documentation/devicetree/bindings/media/rc.txt b/Documentation/devicetree/bindings/media/rc.txt
deleted file mode 100644
index be629f7fa77e..000000000000
--- a/Documentation/devicetree/bindings/media/rc.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to rc.yaml.

-- 
2.54.0

