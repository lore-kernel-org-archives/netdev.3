Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743416;
	b=BkerrDqWMMesFrE/o7jjhXl6kHdWizUAaDdiQr9RVHqFLIoG4YWg9cWMg7DAivxTvpoD
	 PjqC/plipeVG8jY5Ktb26TGnc5tZQ6nwGGLfm0fiTIcB9tiVr9XGu8CH3RbvpKfV+HNES
	 zeXCdyL12bibYbeSnVN0eV8OyvyZHRWTr4maT28nhDjcyijCAwydPgbMj9qnAFQm54XJP
	 u3Z6SEURHyME58TvltTz/dWDrNrLsQWar+hzi5ErE1yAs+qYHyslP48EIj+aQ54shy5WR
	 3+suMbg/asCPWYRFXVwfnBI0oxsYveP1LwwIEFhP5kgryCDktVhe/K0kzOjcTgwwdAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743416;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+1nnuCfUQy069gqVjxq3B5t30dE7pAVScb+d3Nqx+qs=;
	b=1Lp34K2aLzIaSrj7OJahY5hOTAdDlfIV3iQoyqJH1UV7zVPn38eRYYQL9yBYKSr1FKKz
	 nvFO7vcBbKSNuzYK9UK7HW2los3X7bhqVOewt0tHMfI0dzS8S5wNZfCuR/adQsnnNYtM9
	 TgkMGSaRwuPO9el8yzURK7+y4yaOdAhFvqpAnU0gB9p3YQxHNpTTqczjmiqGa6g7GgsPR
	 HUjf29eTPKty0alvlfMg6PAYTeyAB0UCxDHgmU5aic7oTO8/7O/DxYqT68qziV8G5+cFj
	 FIqx2NP9MSpMIgoEp/sb5V7Xs7omE0I9eSi6FyAiEosVK9CD7i8yd8tuU4r5DSxSxVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=PCuCdzIV;
	arc=none smtp.remote-ip=212.227.126.187
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D5606EE85;
	Tue,  3 Nov 2026 22:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939D5606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=PCuCdzIV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793743402; x=1794348202; i=jonas@jonasjelonek.de;
	bh=+1nnuCfUQy069gqVjxq3B5t30dE7pAVScb+d3Nqx+qs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PCuCdzIVSPYgxkWWMHHLsCjUgAYO3etqYUnCfrorg0tYekwDNWP2BkpGWiTGs5bv
	 bifdz0vXFr6rhGb00xwNujJzyp7mjuHTZUkQq9r8ODpeDT0Rpv6dqoE8LFLzcCKGl
	 K8Ag/VqmyQOEOPA76XSqjqnVgCeKkMxnpnJmTj31YgJ0RQ/vPWmDtZIH4wTQiSjDC
	 ZlLYCd/8JDiBH/3aZXH8BJvP6f2wC0dMpI0QcROywYJSvvPJIeSUaz8rAx8pyS8b/
	 rYtLfANjYGRvCscHyy0+FHQEyLNb7iQ3LFZXDZs+G2U6/3dvUdN6vPKa8MHgJpP0t
	 bqaNGJ5CM2VJ6bVhsA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M2w0K-1xNG8U1pHg-009NOr; Tue, 03
 Nov 2026 23:03:22 +0100
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
Subject: [PATCH net-next 0/4] net: pse-pd: realtek-pse-mcu: establish power management configuration
Date: Tue,  3 Nov 2026 22:03:08 +0000
Message-ID: <20261103220312.860629-1-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
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
X-Provags-ID: V03:K1:Dnta2dm/zfJx1MKj3j3BF9ZXHN9IGzHpz+HwwdXmSLCghfJVZ0w
 vLnkTzjw79cU4oC2YcSkkcOqrfuc3NHacJLWJFROYCSDlpGblnVi/SFXVr57pwI8kCMwvvr
 n8VoKdA1VTtm0dxVE2VH/E8pa742zh7hjB5hpO8dkywqesv0x/JZ97g8lChdNX9CqYJAwvP
 b4SAwss0Dt2wmdTBUR2AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PS+vC1hZKTs=;7iDw8YqDZOdgM6LaPq7dgTf8Vm0
 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
 js38rOAK

Realtek PSE MCUs may start with a power-management configuration inherited
from firmware defaults or previous host configuration. This series
establishes an explicit configuration during probe: dynamic power manageme=
nt
with port priorities and, when a VMAIN regulator is provided, an aggregate
limit matching the board's usable PoE allowance.

Program the budget and select the management mode before ungating ports,
with managed cleanup for the supply enable reference and budget reservatio=
n.
Remove the conditional global-disable cleanup so independently powered MCU=
s
can continue autonomous delivery after driver teardown.

Validation includes W=3D1 builds and checkpatch.pl. OpenCode assisted with
review, implementation refinements and drafting this cover letter.

Jonas Jelonek (3):
  dt-bindings: net: pse-pd: realtek,pse-mcu: add VMAIN supply
  net: pse-pd: realtek-pse-mcu: configure global power budget
  net: pse-pd: realtek-pse-mcu: avoid global disable on teardown

Russell Senior (1):
  net: pse-pd: realtek-pse-mcu: ensure MCU does dynamic power management

 .../net/pse-pd/realtek,pse-mcu-gen1.yaml      |   7 +
 drivers/net/pse-pd/realtek-pse-mcu-core.c     | 164 ++++++++++++++++--
 drivers/net/pse-pd/realtek-pse-mcu.h          |   3 +
 3 files changed, 163 insertions(+), 11 deletions(-)


base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
=2D-=20
2.53.0
