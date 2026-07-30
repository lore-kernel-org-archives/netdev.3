Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13813B3896
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407114; cv=none; b=qEytnlREiYdtCEBUEh7Yclk57WXTYnmwgdXOy+ySsLGtUNEpaIU+RH4AczGZJU/PRh43h4fo59v+AbmAgJWiGgI//kSVHxgqDEl13IOlaS4bJAYzNVWuSKQ5LpHSab/pjAxAdvOudvXBC1cUCQpLQTSKoeZ+t8s9mwE05Eiipj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407114; c=relaxed/simple;
	bh=cGQiwLSUELO0BNhj/eBwOu4S6pqC+JNa5ROeFabH6JA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJdZqBwOtwrGqyW8XqHnfW+KnBtx/YeuTpFbgmNj9JZXz9cXH7XpPshlU2aDsd71WORufCyZ0wfkkOK5PNEl4TzO/QTWUIK/jNgEtDq9HDuoY4nCqBCdM/Ik3zR+g1XFPoz2AzVbY8GQkN/WozOfw1EHbkRco2wZfuUWTvH8QrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mORI/7ue; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mORI/7ue"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954dff6536so11666335e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407111; x=1786011911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IidZjb6Sk1gCBpTKPlKzd/sIpZV6ZnvffkT6vIVNonY=;
        b=mORI/7ueAY1diC/bzXyFYdlU4vYtmL9Tpg/SaQRlFH+cstNHYGw7Cj+D4mf/e+xvvs
         ZY/URyKYx8+Z+z2KSxQ0cbYpOSxDdVCZI2hParrCAg9SmvMd6bxnFKvd9rov7s+iQQ6E
         jXAAca32j60NsED1Ay+Zcvy2NlccorwOuEO+fInhANV/nbjeke9uQIQtbTZRlpxbv11k
         q4OawRjnN4tbd4JEOzzBoozmaRDW06ehEdK5sQ00xNRjabJZqznfZh3MFk6jYrSO5gHX
         LTMBcazIhURIs2hUdiqDGHpOyZPalGnnkX4tcEAvh4cFWDiqj1lcURy2hR2Y1uJ5naKj
         ZJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407111; x=1786011911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IidZjb6Sk1gCBpTKPlKzd/sIpZV6ZnvffkT6vIVNonY=;
        b=NuS+RpyvKDzsv7ieeAngG9boUYC+1x0+gpOEnxl8Lnlx/9yuwgzVpqulzklhjrJCHR
         J8/75KgMjniRtZ7dxlYF10rG5npRAZJ88wA3MNAgx3MtXjEkrF4Kd7Znv0Vm4MhesTkP
         DuGYHbIyWIsZATUc+yZ0j024VV0p2HgMvbi/VHqEy3Cj4habKqPKa9T75mY8uM5ZEUCo
         u43HDS97AvFrVjmENLCP9yAknDEEe6TzF4Q3ThXBgZImBqu1O+rIqm5w9aTsbbsEKyZo
         hIiEqMKdK5EaBGfc5D/IcW27ZWXsik53vu+xviIgvnuYt9GLUmn5B0uJYAf0XzTNXCTq
         evaA==
X-Forwarded-Encrypted: i=1; AHgh+RpVC4YQMhGQXSXe0km7X3KTnICJ2YMz2cZjYTqFmXvTLPvtnSDIikcKbstqFIo0Yq7jJv4WPQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpxObIxhdsg74xUcNmucK+qD4cMS17dnyrk0mTLDesaGv/YQO
	s1nCNZnBAhPje6Nh7ubTx/YK8xrPTXo3/PgQUU1m07S18m6yD5gtzgKT
X-Gm-Gg: AR+sD10yflJXg6eQaA05vbHnjVQrGzkBa1WPna+hARM7IPK8fhGXomFbVzBu+PWsEC3
	uvhLs6tejIM9L5wYgycUnfedUEHESustxZtGl4pPsmzb7nw7x5PSG0tv4YzWhoFOPpi2rNFd4aI
	PROr9iL2Ilp/f1ugUIecr9ms6v0LgJWUjhevSjSZyP3dG6aiLrKmEZsQzQn1ITqm5CtVmoqLSZ0
	OLOa6cWYW/NJNsiB0NRnuTQUC0E8ZqVJDgGXl9wd/ruSYRhKTbh7mJ80iYucdhm/AjMui+yfHLm
	j0nrV8hnKfLS1Xp3ZM31Z7nPYOHnvKzP9HdmmiVBkJb89AG1Fvf3kZZl+Ik6MPHwtv0Dk8WqiNC
	X/ko0bK/ip4uyvx8mlsWG7ld36Ny0Jt/lQXU+APecfdA0AIv2W4VAiJFNkGGPGZG1GC9hGmvcIy
	9Nj8Is57RUuF0QH9RQRyXRC4lrU5irSgyJpQSSWhm0MeWvaQ8RIT+lO1uMmMpKRD51Jc0FpNqu5
	M61FmOMDxH9SybMdS1edu1F6B1j/dqnvsljcwBrdtMQVFu7KYIL6g==
X-Received: by 2002:a05:600c:4fcc:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-49800ea1af7mr28621295e9.22.1785407110623;
        Thu, 30 Jul 2026 03:25:10 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-11-254-126.retail.telecomitalia.it. [87.11.254.126])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm44720295e9.7.2026.07.30.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:25:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v10 07/11] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Thu, 30 Jul 2026 12:24:18 +0200
Message-ID: <20260730102444.1967900-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730102444.1967900-1-ansuelsmth@gmail.com>
References: <20260730102444.1967900-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17b7b143c4..3ea995241522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9697,6 +9697,15 @@ F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
+ETHERNET PCS SUBSYSTEM
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/pcs.rst
+F:	drivers/net/pcs/pcs.c
+F:	include/linux/pcs/pcs-provider.h
+F:	include/linux/pcs/pcs.h
+
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
-- 
2.53.0

