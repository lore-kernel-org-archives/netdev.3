Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A53D812D
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271327; cv=none; b=NNTrUtnDJp6K4o2B+NmI8x5L7OUKGoN+QatqoZLQHCCUbpYZTBDve91/0D7hRoW73QNZb2QvHoXIY6oUVYk9FJavSvWAWobfTki783STbK8Flah47/HBeqiRw36nW8R+T0IHoMMRNXkTTZtp0gfiuTXrXlF6xcn99OH+K/oEmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271327; c=relaxed/simple;
	bh=rSkcPxlDmospi87HHpmbrQ+oifpV2RxCLNsblYdSW/s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8DXrebU5eE32omO24PIWc7wIROnpJeQiNs3JVk1kb8fhx6AXH5d/XsfKJ8n0g032gtAqd48v4qkp1SzzXvnW89oi8ScT916o0XwDjklCB92UgWPOYqRAw+kU+BMFDjKcfxX7TenmAfw5QgbpdAx2gnYIjGG1MLXS5lgpMz4iG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANC7Rflf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANC7Rflf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso43364885e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271322; x=1784876122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RH5Rm+VqeCudjfRml6HtxpQ7RLGC9UFpnfUcRZ/Bi4M=;
        b=ANC7Rflf93ySjwIQE8A4G7NmOn8y0cSY4oEQ0a+yp+EEw4+hbR2YBPp/u5GVcdWRoG
         tu8xX4kRotvENx1ZBkVujMVUDziSfaOVo/xItVWfCUH8mIaCy3xXfy+BQJHI+51pfpt0
         w3+i54XLhxdusWbMos9UrXnQhI1C9eCiregdXVzE2PxMe5xjNmc75E3Bgj2HB8Mh+WmD
         DtzKVvpG67v+6BRaIA1tYLAHK3sYY+cKb/YtkQ5jLHTj1MZe+xX9KT4LlQMaNKLSylpJ
         0a5vOVHWHh1TfPNeNgV4tyAlbwXzXdDJTV0IxR/6SEz28bfnA7LeznPAg4B6BsCgyUyE
         72Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271322; x=1784876122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RH5Rm+VqeCudjfRml6HtxpQ7RLGC9UFpnfUcRZ/Bi4M=;
        b=fAipOZ7YDahu5Grl8dFZwfibtNeBnesjYQeeatFZ/9UluDWIVNFpzCskYV0aNNKwGk
         +pwr4Vw9F+qoHvk/khbA6y0feoTxyhBURWqadJGsYSFLIq9PtefOoPVgAiIgxCYX+i03
         nqWSKYXA63PHkOvWiHUo1HFIRtonYcrEFvhrFigVkLrJgQ+quAODszqCZ5Cl/6u17iHI
         wjZm1WXMQshH5F2HdxaaXRjHM+PZ5jun5DyMsEe65Oke7E5cuzhJgcx3xPvPibE5LRK0
         hBxGDNSpWc9HK+tagAaS5eSGwCL+6DGvX9xVU54FM0/9KIzPzyadKnk50K3Mz7TNnfHc
         k2Hw==
X-Forwarded-Encrypted: i=1; AHgh+RoBw2pnuadNTL5F8J4sGbujB7VhY6tO3Xt2rlGI5059SJ3PwpYSpmGqR/4UFG3NMesBfmNK9VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIKPDYBZfYmpQ1QZH3s2ceD4dbxgPvuX5CBYdZsD3UEHRMf80
	lL+F+ShfRzy1MnBVts21/EmYt1L1E8NmyLMxteKX8gBZStltP+rvKo9L
X-Gm-Gg: AfdE7cllD+5x1wmozOnmR9POL0ZE3weBNjGaQYH1fFwroGOgLTwlNz/q2Pi9oMZ+Sc5
	4cyq1me95OYh2IyWoroUy78U/lF5loXD4ocjft0iYyqJ0vCMBkgiZ8eS5NINs6rTIQ1IdjEwySP
	heBfzo2URzowGUuC80uH2f/H07pa8ryui9sBlb1Z61CPCPbrl8U/AUYyMOgTyCBYaI5o5rRAZKw
	tWuCi/ELc8fx2Ouxlc4ljhO8k4UkKY5v04r6M9m4sdedEYxSI4ezZlD/LBV55Nqu8mjjNDRBCz8
	OZ/ooCq3Ewh2I75nZtA3rkON7yY3Rgd7GIWgriU94Hb6Zvtw4YUpaARLZSlPWOWW0yNuYxF/Qih
	A8dRuoJIgFVfLJwby+DEhK4DiWnFxkdxMhbcfmz/wTo/Ul9xQhZSTBmSkscPYY57e+ZCgnxhr8r
	+TYrcM8eJxFufxof5dbWKCzGnryFDLvBSU/EncFh3sj1zQHuG3h+8iD9/EqdBr0Z0Wwac4mg==
X-Received: by 2002:a05:600c:574d:b0:492:4a50:41fe with SMTP id 5b1f17b1804b1-4954a405e58mr9272335e9.22.1784271321433;
        Thu, 16 Jul 2026 23:55:21 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm24260835e9.0.2026.07.16.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:55:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v9 07/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Fri, 17 Jul 2026 08:54:07 +0200
Message-ID: <20260717065448.1498335-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717065448.1498335-1-ansuelsmth@gmail.com>
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
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
index f3218abefd0c..51704a90ca46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9682,6 +9682,15 @@ F:	include/uapi/linux/if_bridge.h
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

