Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A63A3E79;
	Thu, 20 Aug 2026 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253096; cv=none; b=iY8ZbzGY4KLAl8B2B3QSouykSfzjcRfjh3jwyhMamOMT69+5/wS4RNFO6FGfzaJYR1wJDo/y/CA/tzxeyntTDFawdb7HSW0KftxF6/qreL9rENCo9mATpDRCVVuokCxI/DUpxuBhlCUlYOpW0K/q3yRWggsfJfdT1lNhmPFryng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253096; c=relaxed/simple;
	bh=YNzJeRUD+VvA08JY84zQA1lLUSwCjFeOahToci685pA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLJkhB1O6eMohVPSuo1ZN/LOeDyb155ibCu+QDOGD3YqT2Er9ZVHXQ8nOEVX2iOp+1cnriDg8/CpZ42dDjWO8qlmF6ahA1jsMNvdIRtXSEcF2ilh+li9/JfQIhvoTSikfFhyuDqc8czS2FrVrXi3aqvxea6yunf3T7/gYIqTBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT8SR+sd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT8SR+sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346551F000E9;
	Thu, 20 Aug 2026 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787253095;
	bh=Rgz7nLOynOkKBfQZJcUeKxO0QPZ1fI+l6eEtRSyezjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GT8SR+sdO/0l6mnXZ9tFpcfcrEhK0g3Tx4gHWq+HGR0lcMdgjiF2hiZjY9VFNPMLJ
	 zdxpBT+uaDWTGxPGH/Ee8TAM2ecRDCpMXX4oMdOtd67DUI6f/Ldrj92vkl0CmTNBVf
	 +3wGgJT2HVdCc7L/rgrbd8JyU0RFw9pPcRWvm7DbchOpSd1IcvPJBq/gyg9labu3GZ
	 +RVINtW7yLktITokTOFhcVLbt45L0N38zsVhwjryhB+iBLvUZKbwDza8AOhZMaamkG
	 PpSLa0IT3IwDS1IqEuIGDIqYKUdoGrA7HxatX2Uq9GTIHQoGQK7NCX4+0P4Fn/QuOM
	 xWIAZhPYJ8Xhg==
Date: Thu, 20 Aug 2026 12:11:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Walsh <thwalsh@redhat.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
Message-ID: <20260820121134.6af40206@kernel.org>
In-Reply-To: <CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
References: <20260818141556.64303-1-thwalsh@redhat.com>
	<CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
	<20260820103950.5dfa2969@kernel.org>
	<CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
	<20260820111557.49f658a4@kernel.org>
	<CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 14:29:55 -0400 Thomas Walsh wrote:
> On Thu, Aug 20, 2026 at 2:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Thu, 20 Aug 2026 13:55:57 -0400 Thomas Walsh wrote: =20
> > > In this particular situation, the customer had very recently upgraded=
 their
> > > firmware. "RX queue restart failed: err=3D-95" messages were still ob=
served. =20
> >
> > Would you be able to share the NIC and the FW version? =20
>=20
> NIC is BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> [14e4:16d7]
> FW version shared with us was 238.1.138.6 upgraded from 236.1.167.0
>=20
> > Could it be that they upgraded to a version which has TPH but not queue
> > resets yet?  I _think_ queue resets came in 232.x but maybe there were
> > bugs which delayed it later. =20
>=20
> I suspected something similar initially, but both of the versions are
> _relatively_ recent AFAICT. =20

Ugh, apparently :( I would have thought nobody is buying BCM574xx

> Which lead us to graceful handling of pcie_enable_tph()

Either way, I still agree with your approach.
Let's see if Pavan and Michael feel strongly.
