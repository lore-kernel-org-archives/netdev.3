Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFE3A3826;
	Mon,  8 Jun 2026 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953774; cv=none; b=UDXoy9V8DV3M0tjTpnH7XQDcPcVZp0V/jzvGzlWu38WqVpPLcEJPIph9YvIX63bWhrNf7w+CZ509qYn/EcaEHz8Fr/Ahbo/LHRyhdhilLW9f6y5vDuBqiQVMU+wNw5nRuDaIYl1tcTBAbzquZBht77FES8bv1+pievAf8DyxMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953774; c=relaxed/simple;
	bh=8EIjrvUetgeNkzalIfRFNRue5/oVT2LXCEbrwIazQkg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kt/65KNvYCyD9oz+n8j8tLRrWr3IaW+8jWstgzSczTBT8lFiaYNnAXk2LMUQtf5tzoQm6/UANfJpGqYxtRZJ2OLh8mXidbUaoD+dQP+dpOcARhiGTlxUgBToVP1kVU9usBAUkmx8fEyZaa9AFtTu8AFCt2yNzau0t48QkN9R/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=GuN3h7UU; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="GuN3h7UU"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id B842F60961;
	Mon,  8 Jun 2026 17:22:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780953762; bh=8EIjrvUetgeNkzalIfRFNRue5/oVT2LXCEbrwIazQkg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=GuN3h7UUAl/L/yJCtI+77MqQzOTSs+3WPPcM8hK0RFgBFvgQ+dbgxExqsxp3GBHUX
	 4xg1gE7svWnajYoSBYOb2Q23RBNVkrl8n8x1Bbs0hZ7pDSWTemgBYT4T1cpBNEPsgr
	 V9MDWFJA8NM6Xnrbm2IMXTvroRzb+X9fVQa1qYXs6xEPO2VZt9opMhdFf7yBD8yl3J
	 a17vMKb/EkKfx8hHrf3A5QHxMJADDs9CU1nBklLfDvjg04njwFxLZ30jTok9PEaerm
	 hv/Vj8EpjEVIzsz5rwjgtw5u/YN+OfkEF6/OaSpsO07ymp1w4ZSD8HhcCXVamERER7
	 N5uMPWZ2VqqXg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <EA180F4E-7922-4A97-8912-E2D850E7F563@padl.com>
Date: Tue, 9 Jun 2026 07:22:22 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BD5E3E3-DB11-489B-9B6C-14A93C406940@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <EA180F4E-7922-4A97-8912-E2D850E7F563@padl.com>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81.1.4)



> On 7 Jun 2026, at 13:12, Luke Howard <lukeh@padl.com> wrote:
>=20
>=20
>=20
>> On 4 Jun 2026, at 6:30=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>>=20
>> To me the dcb pcp app feels like the natural way to configure the pcp =
to QPri mappings in the switch.
>=20
> Revisiting this, I think the DCB PCP to PRIO mapping should instead =
configure the Port IEEE Priority Remapping registers (6352) or Ingress =
PCP mapping (6390). There=E2=80=99s nothing in dcb-app(8) that suggests =
to me that PRIO implies queue just because the PCP selector was used.

I=E2=80=99m wrong, DCB priorities are not PCP priorities, the closest =
analogue is QPri. Comment withdrawn.

Luke=
