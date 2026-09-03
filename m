Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6124A2A5B;
	Thu,  3 Sep 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438109; cv=none; b=mPsVVOIHQRLFFENySeEdOmDKzrzelaQ5RekNy+p3ekZXcxqpGtxGcOL8o88YxSxL3vayMHZi6IcsCfMF9tCvwazT3I9b/ahAB+ommxkkHQpa70lDSqRgjwyy3gDoZWiaz+GGOZmXfaAxMD5QgWnbWki24S1u6Ls8b5gVnhk5s/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438109; c=relaxed/simple;
	bh=lAePonxIpkG/pqUBRucrGjS1wGgdOsrQoD/RviOefIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug/9L+e32VSlQdzxO4w/9RVsXlCTMSuGUejYofJc+r1UUpQ6h3tIgWwGa8WrO6mTgdHiZZYsYqv9DBZRixOaROICnlK+ElgvW/J7WnwGA0wdpcofVYbFIdkYSZWqB2MZzjwKZvGa+Jt0Pns85XUpfBR2qCZdJ1hVn8Tk3N/sN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ZZoIe2Yp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ZZoIe2Yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788438094; x=1789042894;
	i=markus.stockhausen@gmx.de;
	bh=rA6UdZRBoIa/WM+l/ffAUGZ9lX2TsBk8lQxbQwW7EZQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZZoIe2Yp4YiJ1zhtKolDmIjca8u7wi+d6PYqhXaMXTer2lzdDrlB/f+uyPZVIvV2
	 eug2IU4lcNhVc8QClWVV4sJcfJenfyGYaP1P+AgclXiVbKorE5/cm/kSeqaiHKc4n
	 mP5QSSGihq/pROEzMJfN82fXvvtKoJNLLsuuRMwADO8Ea8ZNV4FleocEPnOxI1Gzq
	 twfv72EnmPwAlreerClqB6+hsUUkJRGgCk3w8nY6oe21LNyTwexVdd/OflnlAy8Wk
	 CMUAye8LKfwqscjlu3ANvf6L2F1CMEUmdhoNkSSgOMFskMs5f/QmrX+F63qWCWm6y
	 kr/djOYIsYmAHD2bbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1xGLVq05oa-00MNAj; Thu, 03
 Sep 2026 14:21:34 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 0/3] net: mdio: realtek-rtl9300: add bus frequency handling
Date: Thu,  3 Sep 2026 14:21:16 +0200
Message-ID: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUovPCUGSiyMy3AL5XCErRcLNjJe0vwRmPPKijL/NGDKcHMJzFr
 bHHgxxUzDPGoIIwrBNnFwms8dU4lZVJ9FTPydhKZoSm8nLjWCEvk81yfqO11BHAPkhSvXen
 2ERD+0ba2eCONC/YjLtDp1mmAD2RHUPSmiQ9O9PmNYeBgMzxdRX6QEK67q7D+caUQbozZxA
 2gUqRaV3ky4b+5JfttBCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ddNccfaY2HM=;M/keAeLWl7t4xrqYL10w0YEIQ7l
 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
 oPUOG1Q3CLw=

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

All of them support to change the bus frequency of the 1-4=20
ethernet MDIO buses. At least to some extend. Enhance the
driver to support this feature.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>


Markus Stockhausen (3):
  dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency
  net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"
  net: mdio: realtek-rtl9300: Support non-default clock frequency

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  3 +
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 77 +++++++++++++++++--
 2 files changed, 75 insertions(+), 5 deletions(-)

=2D-=20
2.55.0

