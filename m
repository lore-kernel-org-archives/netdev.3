Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E82BD59C;
	Tue, 26 May 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773913; cv=none; b=rLIW2KnsQafsSOgLeeOFtUGfXcmQN1ZrI8cXJM5RspaKEdoVc3z1uaEuHONLVSQU20syxzkKVKMEb2TrsEbxm9CMzzzEUzSSqX7H7syFvGDAL+MuCs8Yu8PX8mxQIQwLmFPE1h/FNVOYqw9cp7I8ocu/xd/ekuQx/Y18N/dG9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773913; c=relaxed/simple;
	bh=6T1quZ4ZpQjhr0OLtbXlNmgZ0jn9tW909CW5pRYbY7I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h7383dw7DR35gmHKdbP0bd2uPyojCk9wqO189xYAtsZt9y22GoVh1gfD2/NyIiJg7MQ+4UDhsRqPb/u90MGuEM66ZfmSbwxcHkoam/peE7QXtz6exqybfmwXA/uFQknR2yxKCgccVW4bPHe2SNEclKqh/BIfSt2xUmM2GGL4h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=GaEAE/Ey; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="GaEAE/Ey"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64Q5bvBJ027725
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 06:38:01 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64Q5bvBJ027725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779773885; bh=6T1quZ4ZpQjhr0OLtbXlNmgZ0jn9tW909CW5pRYbY7I=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=GaEAE/EymRZhjPN6MpIEdutKeClNNm07rttGf5iESxdHwPBW8A5z2FH7Mpg/z+LyX
	 21g0ClYsuYjZiWG21m2IaewUKXwQBZNovled8vJ4v6kf2NMr1Tuz2rJY5+8+PAoDv5
	 hLUEiaMC9XJgWiuys7LDOvfwcieNPf11Ux68pmw4EuN6MbpvUEfjWeIPAXdrR5kZpL
	 A28PWeWpO/b8tTK+cON4727dH2+G8s+qOSXMTEZOL/iZoJ8n4CSJPrUSH7k250YqLT
	 06zfbZ2uBpJALdOjm8837W8xrVbZfHZ80UGzRxTO4uhznBnj/psumdv0gaTncU/HEx
	 xknMNn6y/BZQA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
Date: Tue, 26 May 2026 15:37:45 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DED39BA6-C627-431F-B406-2C5A19DCE2E4@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi Cedric,

One followup:

I could be missing some patches from you due to netdev volume but, do =
you have a separate patch set for hardware offloaded MQPRIO?

Your example uses hw 0 (software MQPRIO) which doesn=E2=80=99t program =
the switch=E2=80=99s FPri/QPri mapping. For switches excepting the 6390 =
family, this mapping is per-chip, which means one needs to validate it =
is identical for every port on which CBS can be enabled.

Cheers,
Luke

> On 26 May 2026, at 10:32, Luke Howard <lukeh@padl.com> wrote:
>=20
> Hi Cedric,
>=20
> We sent RFC patches for mv88e6xxx support for both MQPRIO [1] and CBS =
[2] last year. (We have since made a few small changes which can be =
found in our working tree at [3].)
>=20
> We have been using these patches successfully for the past year with =
our SRP stack [4] on a custom board with a 88E6352. The CBS and MQPRIO =
patches remain unsubmitted because we also needed extend the Netlink API =
and software bridge with a flag indicating a FDB/MDB entry is managed by =
SRP.
>=20
> I would be happy to work together to harmonise our patches to avoid =
duplicated effort.
>=20
> Cheers,
> Luke
>=20
> [1] https://lists.openwall.net/netdev/2025/09/27/34
> [2] https://lists.openwall.net/netdev/2025/09/27/26
> [3] https://github.com/PADL/linux/tree/rpi-6.18.y-xebros-rmu
> [4] https://github.com/PADL/OpenSRP


