Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B0489FD6;
	Thu, 10 Sep 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051339; cv=none; b=eYnEnl+4heWhRf/Q7ysGi0Ln5e48/RA+l/4SJvlakkt/qMUc/hsHPz+Q4tdP/SwHsuQZvnKTNooIqx2LyODTqjk2wOMI0MoYqHiDVvYj7B1/uiQlePhXagrSUF9NH2vtzoioNc80rx0mYLA635Drc+ZNMiRWu9kNAKFdD+Sd+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051339; c=relaxed/simple;
	bh=qPqjuUdASs9Y65n69OhxSNlg/J55Ht5KUqLO2cTCHVk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fXqeOcOlgCADZvnLrqbRJY9NH8/9p4Ny+72cXQrLkIDhAfLn4r0AwPh0LiLsajnrAUZvmhOsaVNVdOHgOI4/UMuZMDtMJ8zSCmrAntK4hDJWB6/ViRtbocCq1lf6LxMUaznuWHaRbSiSLy06FFgPYQ+2ahmAFNKh3LE4FbupJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j22MncXL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j22MncXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789051338; x=1820587338;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qPqjuUdASs9Y65n69OhxSNlg/J55Ht5KUqLO2cTCHVk=;
  b=j22MncXL8gq3H0/OpbAYkFuxZhAYpw9AyfSfIKgrGhLRtqMaQIYHFId8
   NoXxtWW4qRr0K2v/0JnEQHWeSUIgVHWlcZEPCVRCmG+iFwTSLFRlaWvIj
   r8O88JHe1LaCRRlaGqiEwP2MLf/Ri0PzTGoPkGytwK787wTqhnNPqi21c
   lmLKqr6jenNePLpRjo4eXU1cj3B/2o74qIOQfJCCbc1TtnLEurmvIGVXR
   SE0Au91JJFLaj9HULcx1w3Mgo6dV2wS+K6QEBJqcgkHR+OwKxoOaxEOBO
   u5iH95APwNsBaQbtGzu9zuhAJqaFWwPrM2LfZaGJg9OBc/iaZphHv+Mjm
   w==;
X-CSE-ConnectionGUID: ++gFX0kJTeughVEf/8o8fA==
X-CSE-MsgGUID: 9SI3P4RTS8GgOmBtetQaKg==
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="63425380"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2026 07:42:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 10 Sep 2026 07:42:16 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 10 Sep 2026 07:42:12 -0700
Message-ID: <5ee1b3f9832621686adbde94324e7b6350254f37.camel@microchip.com>
Subject: Re: [PATCH net-next v12 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Thu, 10 Sep 2026 16:42:12 +0200
In-Reply-To: <f745c884-ecfd-4dbd-ae33-6b713f8ab73d@lunn.ch>
References: <20260908-dsa_lan9645x_switch_driver_base-v12-0-2d6aa59350cd@microchip.com>
	 <20260908-dsa_lan9645x_switch_driver_base-v12-2-2d6aa59350cd@microchip.com>
	 <f745c884-ecfd-4dbd-ae33-6b713f8ab73d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 14:59 +0200, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > rx/tx-internal-delay-ps is used to model a direct MAC to MAC fixed link=
,
> > using RGMII, where exactly one of them must supply the delay.
> > Documentation/networking/phy.rst describes plain rgmii as the mode wher=
e
> > the MAC or the PCB adds the delay rather than the PHY.
>=20
> This is not correct. phy-mode 'rgmii' in DT means the PCB adds the
> delay.
>=20
> If the value is not 'rgmii', then the MAC/PHY pair need to decided on
> which adds the delay, and by convention, it is normally the PHY.
>=20
> Where it gets interesting is MAC to MAC, which you do see in
> switches. Using rx/tx-internal-delay-ps makes a lot of sense in this
> setting.
>=20
> The binding itself looks O.K, its just this commit message text which
> is wrong.
>=20
>         Andrew

This is exactly intended to model the MAC to MAC fixed link situation.
So no PHYs between, and one side needs to supply the delays.

I had originally implemented this by using the phy interface mode to progra=
m
the MAC delays off of. This is what we had done previously in lan966x say.

But I was instructed that the modern approach is to use rx/tx-internal-dela=
y-ps
along with phy interface mode rgmii. There are a few other examples of
dsa bindings doing this:

Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
Documentation/devicetree/bindings/net/dsa/realtek.yaml

I will remove the paragraph from the commit message if that is wrong. I hav=
e
misunderstood that part of phy.rst.

Thanks,
Emil
