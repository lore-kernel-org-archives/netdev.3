Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816478;
	b=eTPVfrv8IUuTNImq+MGYtDJZM9/scpWyDKpi/uDGMTQmhTGm0o/psjNx0OpIfbHkd9gY
	 4IDyy/n0jy88GWfuLRLkk4R73QodZQQXQf3Y+8NU9k3gQt8qHhVe57QtVIXnZ4r2PSPvl
	 v+IxSR8iqJbr6gR2lgrrxJ11D6tZWNkvStJAQof8nma1NIgrdIoLeGOtV63d5ZZYz06Kd
	 3n3onfpmGze7Q7JAlMk47ASLpEdDpOvmtCTsrIXiuZwmYbPSWftIM04j9uDc1XDbOiS9D
	 QJla6D5GTZA8DgVrx2uhxpowhWCj6ydzmqoQkZx8ZZsdReUNDPmx97WJD2q06n1bJoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q+kakf3+bGYR/XpLFDDkxjLybCV6XrtHH6WOIPQu1A0=;
	b=Qn5a52Xz1bxUNwlAKRef3W1RFl3idkS1/pxaqrxBuXYjMrDSc2Z6nYMLC9jm8CQcJqwB
	 //g/1Vb7Y6glQ7wSCH7E/a2d9QvOf4kRE+CB9J5Y809AzJmezltQ6MofF0z6IpUFfHhYu
	 Nk8NrOXxFSLIGjf9ljxR7BDrkBgB9o82reckDo/1M1hJvtDANAXRKFn1wUaA2YrCa9M6B
	 HvvTWLUzyQ4zZ2XzI+Ytp8/c0Wb9SuW+vO9ZOQk5qEeqhDgyeANnArgbBEG5eInWvLOOR
	 MRgu3Nf26qqrvVM7GKFdG8yXQrRw7Ez5KPlZrBnXfmqXX/NHT2EASXmtBYZ+7PBQCmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAJJNu23;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB926082BC9
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB926082BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAJJNu23
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso751042f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816476; x=1794421276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+kakf3+bGYR/XpLFDDkxjLybCV6XrtHH6WOIPQu1A0=;
        b=iAJJNu23CPWLdbMHHLohwld1D5Iq0H3WizJY08Cj5VAeuOddC9clsyvI7rB66WUt98
         dy6pTFjIawIbQIbhudn5TDxpFBV/fjcvwhGzl6Ee+3T4pAkxhVBxVbcAd1S/vOg9Bhln
         PzanBZjK7SGNdSpnWfovET65qjh9FQIPy3xlCNZ1L8qUKcx1KvQCkeuwd0RTojXoaAtV
         ookjBWFVN8Hxo3LQsWXifYUYHasJar2ogNLEvjtUkghFlDVL1vv1Ya5FiU6cJI//V1yH
         ICnj5RnICtljg8BmGifR2hHlT80ahfbRROT6t2qE+Cihd70iIlsd6eVmkHYQykUDJ5YT
         racA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816476; x=1794421276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+kakf3+bGYR/XpLFDDkxjLybCV6XrtHH6WOIPQu1A0=;
        b=1kK9HtLGgiZZK5/LKBTCPVSSa0rp0+m8aYjMyN/LfYWrsbYTjGE87EI/mf1pHCqTM4
         jS4wocFT4YoELAvVGScRI2BQ/03vRtCRbkSDo5Mp74p1GahSCt5S4L5koGuqhcX1bCz6
         7d4zdsXlUF+8/AhIqYC2VsqXR+HI30biKGbKHSRW9pBb2JqPbe+W3Nx33VTEiWE7o1D+
         AJ3OAO7vWux+18xQcHoWQDEYmMNk7lk8SdiN1w/tbydZfRDAA7myk1tqY7g+IUX3hrlA
         FHIX4HuzJQQZ2IcFsaA/7bAa6s+c/k7KtbO0enJJFOlXAn1XQfTGWouwRhSOPiW4wNaY
         rLzQ==
X-Forwarded-Encrypted: i=1; AKwUvBybD9QPMqj6bhxlYauuUX/xiEMAyjvVGzzEYXMVqNSmdixqBP1SaBd+Wv0So6dFAjGQ7r621HI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m40XWZfFywYuGbgquBid7Aazuf8cKa9kwKRw1CgUckUoQ3eeq
	ZFxjT/sNNskpYWH1tyzEJpK7gx+y8HCkavPpJKWLOak9SL5p+hAJU73R
X-Gm-Gg: AYBFou33OKYVwSmiLRHkWEiiWJ7TIzl8panAGAt+jbKutaNJ1vYt306Z1xYCUD2ZvCW
	ipGdM2+7jpsdT3BKjX18vdmbudayJza6z4joHdpPgck1LOOAwVZKYGUDh7/2bVM3gZX+KIMESJJ
	lQKWS8brBxOKgBMy2LgwL6ZK4feK7wwWYeduBiCcWPBKhecB9bw494h6cUql+XduybAHNfvvke1
	T8toinVpMACWuHkLD+KqRRr0Texr90DwMSkQbPueUomykFwVSxPHq+rT/PFpSy7lTRmyBjmatpx
	5rQih1VoLn5yj8UuNbubYgVaPQIBX1mRn3Y6MuRHJFDma12MnN3JGSFeM69DTuprOtpgvgg6Nwm
	8YJgu3hnS32/ebURZuhOLwbrnncCMUMoJavmNEsUTqWYpn1VszzvvmkBHcQ6fuhXZIyG4MlwzOE
	0UHpO46TFmaMZt3VvxIGZOAi0r6n1gljssEluKJPjZeu9CLiybpf8QSAPt43I8B/sLnTDP5GHHd
	f3RufRb9WRLfr4/e25uvueGRTUC54/9SMSngJhe4WBNBWVpbDkoaMSrcsgOR3kjWx1sfBpSjAW+
	Fa88WPUfhSraRYI9gLPiRnwzVqyxwbDjemlU9sa3Mj9cggbm/rpLuP6dGrCmmnWyPHpQ3uHcUJM
	l6RUCFn6pSeOLu4cTs+ScwaMODx5d/5PLBxUe8BWgIZLWs2qxKYn2rwvgUcs=
X-Received: by 2002:a05:6000:40cc:b0:48e:5ea7:b1b9 with SMTP id ffacd0b85a97d-48e6e30543fmr40091601f8f.31.1793816476315;
        Wed, 04 Nov 2026 10:21:16 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:16 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 04/14] dt-bindings: net: dsa: renesas,rzn1-a5psw: Reject the "ports" node
Date: Wed,  4 Nov 2026 18:20:52 +0000
Message-ID: <20261104182105.1102555-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dsa.yaml accepts either a "ports" or an "ethernet-ports" property. A
devicetree using "ports" therefore passes validation.

Replace the top-level unevaluatedProperties with additionalProperties
to reject the unsupported "ports". Also explicitly declare dsa,member
to keep existing devicetrees validating.

Also Add ethernet-ports to the required list.

Existing in-tree device trees use ethernet-ports, so they are unaffected.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- New patch
---
 .../devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
index fab6aa6237e9..9c477ceb170b 100644
--- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
@@ -45,6 +45,8 @@ properties:
   power-domains:
     maxItems: 1
 
+  dsa,member: true
+
   mdio:
     $ref: /schemas/net/mdio.yaml#
     unevaluatedProperties: false
@@ -73,7 +75,7 @@ properties:
               phandle pointing to a PCS sub-node compatible with
               renesas,rzn1-miic.yaml#
 
-unevaluatedProperties: false
+additionalProperties: false
 
 required:
   - compatible
@@ -81,6 +83,7 @@ required:
   - clocks
   - clock-names
   - power-domains
+  - ethernet-ports
 
 examples:
   - |
-- 
2.56.0

