Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC72EA171;
	Thu,  4 Jun 2026 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613534; cv=none; b=V40JZE6Fn7rpJNsV/alckPtfPWozYvJqfLqknPisEQedfJoWwWEJoRwvSI2PXP5fAUFIuTGkPbmGjoJAiLECQ4pf5BNEZWHG0wd69SMhqK+z9KKFi7fCqbXcrqm7j7o7gUrXtr6f766uTk7NTrQpSpOrrCxl8a4cK3IU1yBJ9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613534; c=relaxed/simple;
	bh=OEm1hdLn46Ff+W5Kx9p8C2M4P47h2b5Qaf5LFifR0nc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ba5wgFlhgItI+r5U/PNxIwAZWM+nIObe+ZmlMZ6UdglvKc5ijUQ/TLcb11b8Uqdqj1NXVfHnHGCBj4uFAelEJUd3SEqk5TJt76mKXVUzvIm8xOR2LGh7DxXdFvBYZ0z09BqyigVthfBfVDYhfON8VOhy2BkjKpNcCzK9Js7DnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=kTYAXuMs; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="kTYAXuMs"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D2DF960C6D;
	Thu,  4 Jun 2026 18:52:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780613531; bh=HMJb5ahSNURO+v12SkoNhUjqk5ykiyADfmMXFoQmvOk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=kTYAXuMsJ6t6QzFi2meSE+6bqSyaFb/75Y+b88APEz4vv44dLQwNzsNYh3DcvBhRu
	 OTcv35sQ2DAplU9HFIv91FrJGRa1Yomw5bXN3Am8cQON3MHIxlu543rHXl54dEGTy5
	 zICOuA6uKmoqC9Mo2s2lA65MGHj106d7g9Tmmn79vpefGh8kuqgvbjcHmaxAb1ouBP
	 pE2SvfdAKnEzbxsHRAmhILnIl9aHnM2n/PKkVtWNCQamS0t4oIPT0rrXrlptT1HoYJ
	 QfS57Fo9uWz/ZBvt8R10Aqnaf6ntUh7oJClU66er/J9MX+eQ3HzagtiClq0V6nWKM8
	 uGElNrxIlm+SQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
Date: Fri, 5 Jun 2026 08:51:56 +1000
Cc: cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi Cedric,

> On 4 Jun 2026, at 10:01=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@gmail.com> wrote:
>=20
> On Thu, Jun 04, 2026 at 08:37:17PM +1000, Luke Howard wrote:
>> I still need to find a similarly natural way to expose the switch=E2=80=
=99s AVB capabilities / 802.1Qat admission control. Perhaps there is =
none and it will need to remain a local patch.
>=20
> There's a devlink port param command. I've been wondering if this =
could be used
> to set a port's AvbMode. However:
> * at the moment there are no drivers supporting this.
>  eg. devlink_nl_port_param_set_doit and other return this isn't =
supported
> * i don't know if AvbMode is a valid use for devlink port param, and =
if it
>  would get accepted

mv88e6xxx already exposes the ATU_hash driver-specific devlink =
parameter, so there is a precedent which augurs well.

A per-port AVB mode devlink could configure:

- AVB mode to enhanced
- iso ptrs to number of enabled ports * N (currently we use N=3D64)
- enabling interpreting AVB_NRL entries as AVB with G1_ATU_CTL_MAC_AVB

The leaves two issues:

- if at least one port has AVB mode set, we could install permanent MDB =
entries as AVB_NRL. But here we have the old problem, that AVB mode is =
on the ingress port, whereas MDB entries are on the egress port.
- also the AVB FPri and QPri values would need to be configured, either =
via another devlink parameter or MQPRIO

This approach would integrate well with your CBS and DCB patches. Having =
said that, AVB mode could likely be reimplemented with TCAM, and =
(assuming an SRP daemon that knew how to install those flower entries) =
that might be a more portable and idiomatic solution. I am not sure how =
it would perform compared to the native AVB admission control in the =
switch.

Luke=
