Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FAD411F83
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807165; cv=none; b=OZGxKUlZvLsfKATO+HeT5+1vTL+xNYzEn9vIazNnjkjDWoJwFitiUyqMzg+LwSqRh+wjmYoKPO1h3E5gheiBwNVBEnjHNIXh8RfBC4PHWduYYJDCbWzV6XvETTnQ0zn7Mj2ji9iKyZvtGDMO7Iyt+ag8YwRS3jGANx+/JcpsAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807165; c=relaxed/simple;
	bh=1ZKsmwhzjd0+CZKksbja61c9gxXZzOLvYNTFmQ+X0AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEsHnB7+BgKrhUIylAI6gc2TNv9nePIiWOPJTl1hmGZRupiKnGrrPYtCAOSpgPX20FQ7344N4Jew9smtUvncGfTtdzayyxBz6BgiemBa36m+FGvkPJ3bl7DUwvsHEOmW+KdIH+OURmsr+r63u3wZfPwRaXx493mxEkfXRW51ZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KH2sxXNT; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KH2sxXNT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so34961235e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807162; x=1791411962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ2CI3HUMCjNAVkBXSDeX8OI6aVqzPbi2J7N9xHi8nc=;
        b=KH2sxXNTKUS2GcPCF7OC0pr2B3Bov9L5Q1vuiP18eI9oZlIIdBKI6AGfeY67lbjANX
         /pon4Jku3o01KjFrMSN8nxK0wNYanhDaARZb3uohE3xefwEE9/2dQd7XAN9h2FDSFmaK
         EFOCbwekFLGT0XOhnhXR9FJuDX3P2HpLW3Km2zePsqHvWsydqaVBftSjGYFSED2oZ0YC
         Z1xR5VKU2SMLkWV4mw4uCxsSQteo5nNvG055NuyxTFEYtJyOW3U8+3t+QICfI41302xv
         P4Ee7x1fC0M0jCycBxchaZ7gUUIYp4Y7U3UE9Y0kKfvxAkbr7PB9U6VFQXkdZTdTjNir
         2foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807162; x=1791411962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ2CI3HUMCjNAVkBXSDeX8OI6aVqzPbi2J7N9xHi8nc=;
        b=ufjLHpVRRD752o8pSm5ln10etRvXIDty1GWcxxTC03fPscfv754iG+KXS5q4NJjow2
         sWMkVXy/kux9qt5WRl4QCNj14kY+ewCL/j4RDRpoA8jIPf5Vegs+wtkTuf1BSxwa34lO
         eO3FfUXMhCLIpRyu5yisemLl0GZc5OSwc7fRM1Tqsf93sBr5wmQs1VY29dUdE9aDiWDn
         nP0Sp9rrFEmrfMT3cm9FgODiFnxRYD6CQQCyshP/pMNbpUyGizO6pdDkuiPlLEc3jJX9
         SkSRRNdKtdSs3khWYgQxEXZBQAS7YFkoDlVrF114rJod/Hpf7VsBGpx39kGzr5pZpxxl
         xzdQ==
X-Gm-Message-State: AFuF++lyAzqQg/wL6m3QzmvDjvOPd8AER0n3B2mu7XtGxL0Cx7311AV9
	X8soWS26vrfe1dWAzNn1rAqenIdu50J5c4TIlbboHB6znW7NN+k0xSDrwbETg0RZ3zfFw+X8V48
	x4dAb1y5xDDfthXYGNnNnbeRk81b+DERSeM9isM2IzHRsmXh1EQnhrHxFmD/FytwJw7U=
X-Gm-Gg: AYBFou22/yZbvQNuwWh9a4gYzcl/6imr96CpWWHAHM7vGIfaxIRk/WDmxOFu6Q1IpxE
	cZ5UF9UpsqKY/yK6bO9FoRaBmBBtPs1yoY0FVpkF0KC+2KvFJ71+ETbAtLyEs+s2oBJvBF+MM/L
	ATCiz7dYF0h0OGQiOKrg6l0vzC2aiLIXbpWYmYaXLNtPxvQ9aH/so4BARGwm/XSjTE7UbAx0/GJ
	WnriGyxTwx3yFQVuZtu5E2221b9EBqNf2Ecv0kCjtZm94yHrWOj5KnMzCovPzAGF2XNCJergfJl
	4xVtsoOYjoiRAFENqiYRlnqXe9jKbz9cPJAJpScG8hLtLVlFmEfJTn2kulVYfuwZzb9eIu83fdi
	scPN26MQ4gKzSiZyl4367YpyYpL3Oz/sWxXt+MPAE/cfMTbLm/QHk2upCsNE7UACmPkl+WzmCki
	Ud4G0SMXdWgJWTU3RdeoQbiPAt6s0JsMcgNghHf2nUiUAAKd9IWtDIcTfDDEQcAa6Tr6LMGK2Mu
	WYa+dtpNz/kwicWSCiaKCZyOQzuYmk2
X-Received: by 2002:a05:600c:3486:b0:4a0:1d2:1a8a with SMTP id 5b1f17b1804b1-4a01afdd2bbmr33654615e9.16.1790807162162;
        Wed, 30 Sep 2026 15:26:02 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:26:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 7/7] MAINTAINERS: ovpn: add Ralf Lici as reviewer
Date: Thu,  1 Oct 2026 00:25:41 +0200
Message-ID: <20260930222542.3839327-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930222542.3839327-1-antonio@openvpn.net>
References: <20260930222542.3839327-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ralf has authored 39 of the ovpn commits merged so far, second only to
the maintainer, and is already involved in the review of most changes
posted to the list. Add him as designated reviewer so that he is CCed
on incoming patches.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Acked-by: Ralf Lici <ralf@mandelbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6de1ff058db6..f7ca3177fa27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20523,6 +20523,7 @@ F:	drivers/irqchip/irq-or1k-*
 
 OPENVPN DATA CHANNEL OFFLOAD
 M:	Antonio Quartulli <antonio@openvpn.net>
+R:	Ralf Lici <ralf@mandelbit.com>
 R:	Sabrina Dubroca <sd@queasysnail.net>
 L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
-- 
2.55.0

