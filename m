Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137E2BEC45
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101197; cv=none; b=OPjFNRceuPyrsjuqWpP14FecGHxuamgwcEPA8LYbn+LbV80/UKUDyHhYphaKG2WoOd+IbNui7JeqA3TL6Go3IwNTulRkPtbAOsRzZDh0tZ+8wLnDcGal1d9qbS+vXf3pGVHBFu2UQdozg9pKseKdRHvsm3GdpOVQhUhFuXaUGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101197; c=relaxed/simple;
	bh=xKDIpAQDLNGq7uehzRtwOlXTUZOsqApd1GYF0b0KNtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRfq+h/Bqf5zd1SVOYEUBlnFAw3ueaDdc/tGzqj1OjFYK+UpHZdq/SNjsOZL9uK+lRCpAvng1dGgQicwEIiVpW+MqVAWLzqKfB/gctg5/dFLqnHoM75eLWRVzEl1t63gFnAnfI07qIvDCPV48wNai86CYWEC8HkzsZNsws9cXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObgHAokN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObgHAokN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F731F00893;
	Wed, 10 Jun 2026 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101195;
	bh=DgU8/n+gM1V6Zd5/AIEcLcN4i7q1nRchMzePMbQTs98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ObgHAokNCeYxq3ism9jTWVUxMT9xR+S7D2Ih9L6tt9PDx0hPlZY8oEOKeG/Ia7ooP
	 TMAJpOJjcj35IWyxKfQsYcJuE0TP7uHQj0miCfiqiOtdsgVAKJeLrM6s11pu/X2z2k
	 YrnTRe2YKjcmR/8izmZS0+7sa/U46MAztkhGShE5Y5W86EJDdhu6nuCtptXeCT+OPz
	 AmywywRFQHafoHkwu+vPjvtSbGTRyH9n2ZBXudbe4rq3dZPzBYpTHLPUUI+AZ3mlEX
	 uIz17KSNuwbkusHEep843o1bZBZfCV+BVI7VIuSQI2819Dyq3zHeHdYRNXnvnIgKCE
	 i80ukN89XL46w==
Date: Wed, 10 Jun 2026 07:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Louis Scalbert
 <louis.scalbert@6wind.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com,
 horms@kernel.org
Subject: Re: [PATCH net v8 4/6] bonding: 3ad: fix carrier when no usable
 slaves
Message-ID: <20260610071954.60aef508@kernel.org>
In-Reply-To: <1120239.1781064105@famine>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
	<20260603150331.1919611-5-louis.scalbert@6wind.com>
	<1041444.1780954642@famine>
	<CAJ5u_Of1+eEL4iVe-sWzhOOva6xx3gPCeXeRP4Y3yCqny8=gOg@mail.gmail.com>
	<377b117a-b29a-4761-aae0-3236be1f0b49@redhat.com>
	<1120239.1781064105@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jun 2026 21:01:45 -0700 Jay Vosburgh wrote:
> >On 6/9/26 9:56 AM, Louis Scalbert wrote: =20
> >> Le lun. 8 juin 2026 =C3=A0 23:37, Jay Vosburgh <jv@jvosburgh.net> a =
=C3=A9crit : =20
> >> The path is ad_disable_collecting_distributing() ->
> >> bond_3ad_set_carrier() -> __agg_usable_ports(). __agg_usable_ports()
> >> reads port->actor_oper_port_state
> >>=20
> >> It was found by
> >> https://sashiko.dev/#/message/20260526084048.1696544-5-louis.scalbert%=
406wind.com =20
> >
> >@Jay: it's not clear to me if you are ok with the series in the current
> >shape, could you please clarify? =20
>=20
> 	This was the last question I had; everything in this version
> seems reasonable.
>=20
> 	For the series:
>=20
> Acked-by: Jay Vosburgh <jv@jvosburgh.net>

Thanks!

To state the obvious it's way too late to be merging this for 7.1
