Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31433D332A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271330; cv=none; b=sL55SYoOzFBoMukvoZgijCVIvEZ6KTXzGW7XJrVHCAtcZxbWFkucVknzq1I/0+L7BaQJjTgU5iPU4NVBHraK67CtdYSXdXeS8fG/HmRt85MYt0Q6VMvrSZEgu42YghRUKZ8ZMdWWfyDyR4xmcBMsTKurEUSIydiNxceA5V92IHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271330; c=relaxed/simple;
	bh=KD0Xxqp9c+WKHaZRv8teeIbNeaFlH+GFSE9b+VzjtQo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcz71WiFhukl3CxqngQjbZfDfc82Ay8nYVb72RHVKu5+mDsEs+GCkoKEncJ18ltxeYD08Lv8htLbgWtzN/mGU/g9gL70qazP59TfRNMHNsQFeU1AJALRJmZVAmWcCYmnIsfUX/40Peqtnk2NYZe9yGy20kBHBZjuNvJw3cEVsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMpWP/vS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMpWP/vS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495437bb891so8433645e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271323; x=1784876123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZdXEh1+v5JoWmC/SQYTMdZgOF636AdT6/MfmObt9bDU=;
        b=IMpWP/vSXDY2iFCz/yQj9ql6sHdtePJuSJ5YQLGmx0XmJQWVHK0jWQzy7wzCuUfVA7
         RFpYrJUfGavDvxYFHGO1Wcwkvuw3r4c4Z1tirk6dju1+hGzfIIj0ZYuHR4Ykllrc3Oog
         9RAr0bO19iyEncL0Y0Tad7IPgIoTsb0IQZzH33EcNG+kYeJzKCG7fOZJfo4pwLUsAd59
         J+sABumUnFKJiHFEqsP1M0hcQ2nwDWayTNZJUDJsCDWeZiXiJUz4tIMvKkgV52YRZ628
         2cLEBNiivFJrTWAW+KBMXecpoAiuvCqPdUzv8oWwSUF9ol+NGEQnhd15/bpttCVMeOJq
         J0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271323; x=1784876123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZdXEh1+v5JoWmC/SQYTMdZgOF636AdT6/MfmObt9bDU=;
        b=MgaQnTd5hUhLdxq9iAxY47mfRX0pKR2nJ1rbrEdjT5oOuO9j50SqjIgB9llbD1Lk0M
         zF3lR8i+4BGAaklTHABIXCy5GB6cKn2aYD1BaCM1jUs5RopsPZh5Svfk/zBPJOuhHcKh
         e63LkmcNPlugcSaz+RkYiSCn9DaZY6v+obmugSymwgk7fwLzFPgoNVV2hpauIWuzZOBe
         4sLSLddtMPJRnO6HEYgX9y4PPocy2LGj0l5mG4DnSunMxHLxyMnkUdH6/q3Jq7DxD7iM
         N4MYWKrzxE6MUsqFAeL0zZyRu00eZRbDvyvLmSzQM9jNp/uqU0dG0EJQh6l5MCh0z4Ul
         xJ/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpV/GwKZDvpsySofTRAa8NV0HtOQ1Si4J0pHFsjeQVSnCPWk/DpVfLRSqKEBZCS3pQvx9OKBBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIwpyoowQkwZTtCpGRVCAx22QNmu+0y6icrMIwONHtBYpTY4+
	xVk/2nU1TOZskBORPAMdCN00k4QWq8ngnp2XSmjUno7f40o14G38Hzrx
X-Gm-Gg: AfdE7cnPnEZ3hqt/3TV37YXGeHbpXZxTNkrCIAs3waLYputwbb1eFJdyXvY5tkzk+p8
	Tbx4U/2KStb9799hluX8KFxogq8tHsT1R+5n0zGR1zea/NGjgNY+ySn+dEPO9FUDjuPOsg0n73M
	bFMSQfgpq3v9JXGzf0/IOyDPMbICpHW5OO9liOvKNkZj6fnJYfho5TKO20akN/GsIX80hhO0XOf
	fIcUe4qgHqamz9yBSAHmFH/YnBUuGfoTtNWZf26QtL21eP2uRpCukU8Q14MCHgN2vUMMZzwplag
	VJLKxA4IvBum93p8GD8qtc0hR0RYEIEDyi1a/mn1pRLQSQ87hMjV+EjQqUSni8/VZ/MYWBQc7WT
	/A/Y87XMb+kfOyEiv1RMtwGNiSYsbOoF3Ay5mxU17/qk7HiM1XzcjnvDBOt2KeYW1S2jt//8auH
	bGrvRNkRW4GgsBmEtG9hNsm4yYqbepJ2lsnIcHueubND/kIJjMZ5+w7rhKWBHlUFRv4sBuZg==
X-Received: by 2002:a05:600c:a210:b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-4954a341bcdmr7407915e9.18.1784271323320;
        Thu, 16 Jul 2026 23:55:23 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm24260835e9.0.2026.07.16.23.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:55:22 -0700 (PDT)
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
Subject: [PATCH net-next v9 08/12] of: property: fw_devlink: Add support for "pcs-handle"
Date: Fri, 17 Jul 2026 08:54:08 +0200
Message-ID: <20260717065448.1498335-9-ansuelsmth@gmail.com>
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

Add support for parsing PCS binding so that fw_devlink can
enforce the dependency with Ethernet port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de0..91c3e3931fa6 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1415,6 +1415,7 @@ DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
+DEFINE_SIMPLE_PROP(pcs_handle, "pcs-handle", "#pcs-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1571,6 +1572,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_access_controllers, },
+	{ .parse_prop = parse_pcs_handle, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.53.0

