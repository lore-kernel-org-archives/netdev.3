Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D542123D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290864; cv=none; b=psYA0lLKNEsq4C9Ha+PW2C+dCtXL1ehh0UiuAebWEWFl7cxCNHnrOOBTVo+fbhLyBe69tV/P17h3pVvYmtWKEtX/bSfnr74TNsI0UXInfYW9xkH3DbBPQAdgTPrwJZVWFUI9E9IguqpVSAeTfY96PBY5zEMvEbw3l+6nqGlVDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290864; c=relaxed/simple;
	bh=j6mlx9CPkum7bpd93df0KuA9wXWsuLKzELZc3PzmjK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9YIdzWzmlry3qJrx6s9CJQ99b0duu0AqO+A/vUNgc4XrIgs7YAxc8ueQnGPsK1p1IPVCmK0gJ1q0gXOGr5q1M6hDTup43yhIzfcB8xMYcvVtMn9PxPP+GqzqraQOGiG7VEGTh5veVn0znXaq+q2RJ2Ckb+xSQ0icKZfefmLor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=dBtWmZ0k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="dBtWmZ0k"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so13195695e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791290859; x=1791895659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URnF0WpPNT76iwwx4OUHbknNShXeDW8wlFWgezHCYwk=;
        b=dBtWmZ0k8CwfKgtLEQbpYwUdconweRIQDnJ+hj2SlCqykC/27iUMZ/xGWduTT7Hpx1
         lIvdnTPRsn04NtXKqJC0nVlU3CiJZisPz7RIxtuVoDKHdyyAMS2y6lf5X11zsXbJNzpb
         fFMDOc7TWbjrHSCE2Eyq5kvgawoi+6S6sdSnqqIbRTBEkaftmh/J17Ca1fQ1JEdrzGE5
         AD/palnI4ZUTfoVRcTlKwSRBGjIXy1kar1BjW/eTUIhtnlPKX2z+Mkee5o5/ucI0/M+z
         RIkNJlKxsRrfrlsUuhvx2nBbjPcz+9/38Uz+EZt8uHUbobDgMSNV3EbESX31+UIaYujh
         2B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791290859; x=1791895659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=URnF0WpPNT76iwwx4OUHbknNShXeDW8wlFWgezHCYwk=;
        b=1H9WpLP8YpGE1c2/C8ezhT6aI/s8/EjS1/2AMbw4lJhfYX36J03Y7M3WLOtQPGSHlb
         DclIl6i37CqVpKl3yR/KJx0rqx22devcpxh1C+W+ZxQKGUogwUfNrhqFwfGK3C94bBfN
         lJTifc5HaVzBJ4zWQQ/M503hIuwBi1b5CIrIFUthE0rVgNVbKxBnNmDvDpk6UZCvOmkP
         DAV0p6GpzY9zTvNuqSp5NWIHt6o+9xVJ1kx4qwDJd96hfc1BFElj0xxEa8quOva1EYik
         PwHoNCgFcCKMHRSC1laF0Xa5ioX/6b9n2VIlg/CfBTz0cC+nyqMoAYbyjTtMMyysJRuz
         +X9w==
X-Forwarded-Encrypted: i=1; AKwUvBzaFze5WfaAyKzZ8fmeLFjfv39dlBjYAToUZ/FjthUGqrIu67CHTlIw5cz5B//U+RK1CGp23Ko=@vger.kernel.org
X-Gm-Message-State: AFuF++n2VnPOpwkV0wT6MgmDSRiD77lSKnWRYTtgF6sGhEpkbDwmF4PA
	SX6nE3FiKPWQqYdmWEypIOpSRoEpex/kvhUmmHlDdDydBrqKGoK6Us1K3wSI92LQ5jA=
X-Gm-Gg: AYBFou3dD4xcbu4IvETzZ6NMIilctpNdzCvpyhucHvnKHnivj+OBJWlmpt/UMacRNZa
	Ywg0KoVwwYNiPGQYl+wYy3Lg1z2EKLKNIwOWKW8PJvivitXxiNd4X3dkD1qRXDiqlsajD9637pt
	7tTdqhKx0vrVmybrvcKu1ocHTMo12p4ftfHnNtltWdMwidudCGkN4Ij5XlXbyoCvRYbraM6+bS7
	Xo0SQh0o7ftGEiP4UcEDYXMJAoGKd2VjgEwmqj2oZ3EWIcb5DTRFvUn0j4PyPeLZv0CVxjSgPGf
	UhOQmK1pG2q1YSbVEMZg85a1nUsvo3/edEkQrsqSJnnD7/mPrvnTH5dXSLjFCq779m22Sna/Na2
	feCkzY+4CqM29WxSGog0l+KokghmshD87U/pWwzF5cafqifU5FemTFP+PNvH2KKIH2lH1sziGx5
	SkxeX1mFK5oU/Z9Ip4YxfG3pJ1zKFKtHUFqMoczdxtfQ3owNOIuA==
X-Received: by 2002:a05:600c:4f81:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-4a17b53be50mr23583605e9.10.1791290859097;
        Tue, 06 Oct 2026 05:47:39 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622b4685sm9722003f8f.41.2026.10.06.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:47:38 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v6 1/3] dt-bindings: net: ethernet-phy: add needs-host-firmware
Date: Tue,  6 Oct 2026 15:47:29 +0300
Message-ID: <20261006124731.1528963-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006124731.1528963-1-f@lex.la>
References: <20261006124731.1528963-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY can be one that the host has to load firmware into before it can
be driven at all. A controller that connects to such a PHY at setup,
before its driver has loaded, gets the generic driver or no PHY at all,
and one that connects only once gets no working PHY on that port for the
rest of the uptime, even though the PHY works seconds later.

The flag declares that. A consumer that sees it keeps the port and
connects the PHY once its driver binds. It describes the PHY, so it
sits on the PHY node and needs no prefix naming one.

firmware-name is not used for this: it names the file to load, and the
EN8811H driver keeps its two blob names in code, so it would only be
read as a presence flag.

The need is not derived from the compatible because the knowledge that
an ID needs host firmware lives in the PHY driver, and that driver is a
module not yet loaded when the MAC connects, so it has to come from the
device tree.

Found on a Keenetic KN-1012, where the EN8811H behind lan4 has its
driver on the root filesystem and the switch sets its ports up before
that is mounted, so lan4 stayed dead for the uptime.

Assisted-by: LLM
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v6: none.

 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index df50c4c33d76..ab95b9a5d95a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -215,6 +215,12 @@ properties:
       used. The absence of this property indicates the muxers
       should be configured so that the external PHY is used.
 
+  needs-host-firmware:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This PHY runs firmware that the host must load before it can be
+      driven, and is not usable until then.
+
   resets:
     maxItems: 1
 
-- 
2.53.0

