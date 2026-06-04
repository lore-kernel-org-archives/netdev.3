Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C730BB91;
	Thu,  4 Jun 2026 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612526; cv=none; b=gWVpAaz0XTX5+KkqkwlrHyK0RKmZ1pb96HkJLgAqkPQP3dB2SPjdihL2Nzmx0VjvABt0KcHF8iiKiBvDwCa11HWosPfmukGmK33vZaLmwPPxltmL6xHOT06Q5ht2TxoOyS/dTnyZTg8PFXZsGZhyokOwhw9PwX7Igm+qGBdmg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612526; c=relaxed/simple;
	bh=rLTMAydKOOra8DwW4cjtAIbOul+bhLvtg3gNxgP4t2k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RKkoZTILBs2PxKQ79eXgpNClO4W+2rxQO9HwfSmd0Y9UbzlUy8OoFN2IFILeirdP4YFu4CYclTxapESw1eMEe8S/BItzv2Ff51wYLAiizEzVEgH32TG1Ts70c3oahlytWuW97v3unibSPHME0CzwbwAMxELjEPgj64ZEulP+r9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=Dz7qK4sP; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="Dz7qK4sP"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1C14860C6D;
	Thu,  4 Jun 2026 18:35:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780612523; bh=8UEh4sCajbfrVQTbpv+xJtTwvbWZPfqHLFXzMe4K8N0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Dz7qK4sPUlfuYZSQwmf8V9BHKqnkqRwlg+jGLHhV5FUkEWHkrGf6Qjf4QPcz/kkZM
	 HIGKVDWA75ywKepHihraidIh4BGhbyfn/RvylKXwo97NxoQv3RwFncDs3hfAg6p7dH
	 g+aUfb69442MRyQHUsrk1miq0ImodL/7qdM9IqMIdMT6TcVr26Hnativ9N+lH1J4mK
	 voq67d0cPQAAqNVK2MYheay1pfjHUU1RfZAuAKTMCr1/Dq4xT8lMf3Y/Z+N+TOpwUd
	 kVTk9/vCPUDWdJf6mZIQ4eNa02IBlOA8W9AIckm5whYexPvrctEYxK+6bZCLjnBAVo
	 caGBq9t1joNrA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v6 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260604-net-next-mv88e6xxx-cbs-v6-2-b68c01142d1e@luminex.be>
Date: Fri, 5 Jun 2026 08:35:07 +1000
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
 =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7FE46EB-2AE6-4F8E-8821-24882C1DEDED@padl.com>
References: <20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e@luminex.be>
 <20260604-net-next-mv88e6xxx-cbs-v6-2-b68c01142d1e@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)



> On 4 Jun 2026, at 11:44=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
>=20
> Some of the chips supported by this driver have credit based shaper
> support. Support is added for the 6341, 6352, 6390 and 6393 families.
> This is configured using the Qav registers in the AVB register block.
> There are small differences in the Qav registers between the chip
> families (eg. the unit used for the rate and number of bits in the
> registers). mv88e6xxx_qav_info is introduced to configure this per =
chip.
>=20
> Eg. setting up 20mbps credit based shaper on a 1GBit link:
> tc qdisc add dev p8 parent root handle 100: mqprio \
>                num_tc 8 \
>                map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
>                queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
>                hw 0
>=20
> tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
>    sendslope -980000 idleslope 20000 offload 1
>=20
> Note: only idleslope and hicredit can be programmed in the switch
> registers, other parameters won't affect settings.

Reviewed-by: Luke Howard <lukeh@padl.com>

