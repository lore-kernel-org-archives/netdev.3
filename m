Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A111441626;
	Mon, 17 Aug 2026 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997125; cv=none; b=KehlmE+bUWhflzj6u9v5J9RTh0kN6lHdRwbCuWCY0hY6NyQMQrCpq26+sQEIbBlLDyBrgqSg0NEzLh364Za+LaQDa6RVIJrymTxU86fDbVRQ8bJtls78fOOi690Sd76auGZ1IYqczbkytOR7NPcH+I7emNIBPSE5lte1dcAEoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997125; c=relaxed/simple;
	bh=DAtbEGRdZstxOapXS02ws98SEPjjOQ6uLuUqDWHlK8A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ay1rX6o3TZ7rB4H5pocxMsg2eGVjG6ECgYXyZ/wrF9X6N7MdJFX4LatojUwEhDzH1SlXqClfQlJBcIzr6e0JfL9SedjKCVaB8K9P/53i049XlzHdKA8f1Yr1tjnFouAnnTy3X3bCT14VZ3Ow6dbaKGJ0p8TDlyUG3WUXbWaKAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=I63cFKe1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="I63cFKe1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786997116; x=1787601916;
	i=markus.stockhausen@gmx.de;
	bh=DAtbEGRdZstxOapXS02ws98SEPjjOQ6uLuUqDWHlK8A=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I63cFKe1yHaa94wOHLwOqiGOKyVMBk8vkKLiBMjKvGlEEX4FLUIB4TEJFFz8C1l1
	 AFIEcfe/EWQM/arZFOnu5DKone4Zw76KudPhbgUPN7Q0bvQE9KJnB3h/PsICc5VmB
	 GTIOMdaMFgZEGs2Yn3I+o5I9auIDDLPhnunmKx//p1s5yXt2gjAqbyZvgLfPRnQf7
	 31KAF6z9F52fDQXgKOsG4nz2tCIZk+DEFT8PyGJBctH+ueHOEabdtCe83T2+Oe6pj
	 qJ0/qnSg3KxI/uFs+c85vhXM8rkpz4LDeel7ePEb1oybjRJsfCHBAqyR6BD8MEmcr
	 FnbVF2m5BEf+BKXVqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1wvmSz1b1t-00GWr4; Mon, 17
 Aug 2026 22:05:16 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de> <20260817162632.1208891-11-markus.stockhausen@gmx.de> <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch> <070901dd2e6d$f5b70c30$e1252490$@gmx.de> <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch>
In-Reply-To: <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch>
Subject: AW: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
Date: Mon, 17 Aug 2026 22:05:10 +0200
Message-ID: <089001dd2e83$b8957920$29c06b60$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGRKDnP2yh8sOJ5M24BwCNtDMK1QH1jg89AffL5+ICqsGtjAEuNNjXtRJImYA=
Content-Language: de
X-Provags-ID: V03:K1:Iw/9nv8VYd/W8nj+l49bTjwi9HFzMp2ddB0LxKVdTSYaQ7OQ4HU
 mL8Blctzgp/TAdhTnKdZLdP7NG5DUxSLUjaBZJ9nScNXgQ0edqbKx2HwgQv+4tKjZStUEQM
 hnloE51BtCl/Lmn9ItEDKTY/NB7N3y20xAjA/qoAMmp81mzuUgDFVYrCFDTD5MdxuiiTxxn
 FebSUxWK51bLXh+S0qs+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F+4JvPQfvXs=;XCWYkgnwcvb8f0FeFD2PcX03YQx
 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

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 17. August 2026 21:35
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
up C22 and C45 space in parallel
> ...
>
> > > And I really think you need to block C45 over C22, since we know it
> > > will go horribly wrong.
> >=20
> > as per your guidance I Included that as patch 3 of this v14 series
> >=20
> >
https://lore.kernel.org/netdev/20260817162632.1208891-4-markus.stockhausen=
@g
> > mx.de/T/#u
>
> Ah, great.
>
> Have you seen these fire? I would expect EEE, on a PHY discovered via
> C22, to trigger these.

All downstream 1G PHY drivers for that platform use dedicated=20
read_mmd/write_mmd callbacks that run __mdiobus_c45_read/write().
So no warnings during bootup.

 Markus

