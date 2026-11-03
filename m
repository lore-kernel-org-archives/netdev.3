Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743424;
	b=TM8W5bHtX4IDDBLbxScBTspWsuB0G0h93fVDmrVz1KKElSUYAK/r1c00xIuGOatCNU5a
	 ynu90Dp6VINuYOCgb+pjo3YJ8eWfZ5vUwmHErVBGxs6iPH+AHUuvWomisXT4l8mvukCkD
	 wx+mBAYo4TVOAP+IgBBqhtRnDr2FkOnLKUsZkEWU6RA3wpazbpuVLvvbORids4Gg9mqzs
	 6pvtwTqDvC5k3gBRfSRb8rQKvKRnWw1vtqHf9ffEi71zsCoAoqGVOQNaJPwc31emXlmmR
	 TqhUwXw9fIjr/P9Ng+FnXosaoRTyQMOK8TAPousLM6aAcMYO16Xq2bPrFyrMIhaF04w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743424;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=jf8hL3+yrNWXn3sUd5oc5BYvo2c+I5ZW2JUQhRAUzew=;
	b=OzlQGyZVJMrqsRkLY/n1SOiC1tx6I8s9vDgDbrRFanPcW9jTi6y/cPDGGZtbgtUjwmxa
	 o1tIU/LMbgAB9/BmiQ/TLeM74YON3GmxiF80ZPA2RKzfKpXAieyYJpWnoinch/hnbu3aH
	 lRWCEuOHqAGBbKQQyoRBnZZzLizG+/vnKORwsPVGznx4amEztFQu6hQO4caFIQHh2Ve1t
	 Uo2DYZA4USats9IXAf78aDBVrr2GKNnDmjnxJOuAGCiOR5dyJUJu4AfY65u+MUzz79WJv
	 zjxeuZ3eiKUPGwnLhWyn83BzYDye4dtk57Q6ym9+Bdjy2tW+DGOhAbZgsdgO3HdKxFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=Q5UGTIxR;
	arc=none smtp.remote-ip=212.227.126.134
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673206082BDB;
	Tue,  3 Nov 2026 22:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673206082BDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=Q5UGTIxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793743404; x=1794348204; i=jonas@jonasjelonek.de;
	bh=jf8hL3+yrNWXn3sUd5oc5BYvo2c+I5ZW2JUQhRAUzew=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q5UGTIxR2QT0mPZ70cW0TzfB0AAnuMMEwx8aYivjl1BpJp+wAThHlqK2UxZsjT1a
	 ltexDM6ZcRVFEFnbSdP9lbGC8XhMXYgnMfVfZBNOoOLIzJaVs2ujw8dtgYajSiXTb
	 CpD1nCs1IOu0igpqJIMVVmYHdcYF3KwHzqHWTnw/u/P7J9zhS+LdAfXk/xEPJZmtS
	 73D66jllne1bwIGr/xiDDhdiy7A9e0nRPoufVMJmBCBeQZGAhtGz+ns85WEd+T8iO
	 KVWbTdVJCEQn5GttWrISOnoE08QB0OBYRew+hO6chRx6UqijCCkWAWkXvPha7V7hE
	 ho7do+78pee0lh38zA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MIdS1-1xLMSH14sP-007Seu; Tue, 03
 Nov 2026 23:03:24 +0100
From: Jonas Jelonek <jonas@jonasjelonek.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>,
	Russell Senior <russell@personaltelco.net>,
	Jonas Jelonek <jonas@jonasjelonek.de>
Subject: [PATCH net-next 2/4] dt-bindings: net: pse-pd: realtek,pse-mcu: add VMAIN supply
Date: Tue,  3 Nov 2026 22:03:10 +0000
Message-ID: <20261103220312.860629-3-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103220312.860629-1-jonas@jonasjelonek.de>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dQjJ8SRBo7ikFFOBkfsfsTVUaeOe3ecOmXAFHeBCor9aqizi40p
 Js5wxLdQb0mG73kFgzsjsr+zLXiK9HE4OftAKob3NiZL7k/9xL/R99FloOXeDO7x+sbh/KE
 EcZFa0WhT03ucqQ6nO7vghPXKzdEHNzFZumZPuQFBhiMTZLQ3aoILDgIm6+pbF20wRvrzqP
 ZIZRvgBdAYlFJEjFbrXtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UrgF5Jh8Eos=;8K0jGZt5YfSNWb+6MfPsIQ11RTq
 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
 D90JJfnaGjkRdOPmxdjSLYv4AjX0Kg==

Describe the VMAIN supply at the MCU controller level. The rail feeds the
PoE subsystem as a whole rather than an individual PI. Its regulator power
budget defines the aggregate limit programmed into the MCU.

Require a finite regulator power budget dedicated to this MCU, representin=
g
the PoE power allocation of the system.

Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
=2D--
 .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-=
gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-g=
en1.yaml
index 526f8525bb4d..82288bb57b33 100644
=2D-- a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.=
yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.ya=
ml
@@ -92,6 +92,13 @@ properties:
       asserted.
     maxItems: 1
=20
+  vmain-supply:
+    description:
+      Regulator representing the PoE power allocation of the 44-57V VMAIN
+      supply. This MCU must be its only power-budget consumer. Its unclai=
med
+      power budget is used to configure the MCU global PoE power budget. =
The
+      regulator must define a finite regulator-power-budget-milliwatt val=
ue.
+
 required:
   - compatible
=20
=2D-=20
2.53.0

