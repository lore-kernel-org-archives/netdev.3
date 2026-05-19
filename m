Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5C18FDDE
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229081; cv=none; b=i/n8KmPBq4fF2seAHBb/v+dDngkyhTs13Cjb+Yp7tQrm3q4ryB4zcg6cGIDbbhKdidt9qv5vsdlClOrkybMsjjAh3WlU0c45Wo8PnSU6lv0oZMh4VGZkQ60MKMtWi0NeUjdZiZPsUIxIuzWqTrml5Unft3K4PIy3yv2MRKTST1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229081; c=relaxed/simple;
	bh=0k06EVANLwGSrY70zeBUEgT/cp27ylsxx+eifdqcbgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iagE+mpNKrrDxCkES6AB8ndL+Jwid0csb4LUoCGIWpd7t/rt7IwYA6Df4+D7oVRSRrs0INLh59Oj6n4U95R2ePopj/uRyZLIzqARwYI755ccfX23C4cwm4mFEPaOzslpfAOaCy7R4YhR7pkmm7DyqOpY92if64zfJiztiKErWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUkcSbSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUkcSbSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABD41F00893;
	Tue, 19 May 2026 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229080;
	bh=0k06EVANLwGSrY70zeBUEgT/cp27ylsxx+eifdqcbgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UUkcSbSn+kr8thHaxXjnrpaLA0D1TOg1Ll5kq+LbBvY3m9N9Sn58rDQiFW3aGpBv0
	 PIoG7WzPpcYu3WK4jPmJaVI6FiGxwgF2905rduyZKjyvgZaFRcakLwLw+PBvKP6/ei
	 5ilc02WhhFUziGF1sZlPNzO0XDUxajwrAbnlVqc10xEjgf/pRIOHFrbtrvXh4IXk+j
	 aZg1Xhjsr8XIuhbph6S2qFDomwBlCNcl+5RO5HnsMLxC1TJ8GE6L7idLstZeORl4mi
	 WqNddjJWfWwj0yu92tV/XtVqK+GqlTbiggBTbraCP+cne0AMurxOcRLfWnMPsyafN9
	 9Uao0tByt3ekQ==
Date: Tue, 19 May 2026 15:17:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/2] rtnetlink: use nla_nest_end_safe() in
 rtnl_fill_prop_list()
Message-ID: <20260519151759.690eda98@kernel.org>
In-Reply-To: <CANn89i+pLyyDedP7YeFLxYrESrhLvFrRoeaVJHrG=aDEnM0csA@mail.gmail.com>
References: <20260519114355.2769474-1-edumazet@google.com>
	<20260519114355.2769474-2-edumazet@google.com>
	<20260519093904.49298543@kernel.org>
	<CANn89i+pLyyDedP7YeFLxYrESrhLvFrRoeaVJHrG=aDEnM0csA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 09:53:08 -0700 Eric Dumazet wrote:
> On Tue, May 19, 2026 at 9:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 19 May 2026 11:43:54 +0000 Eric Dumazet wrote: =20
> > > Avoid corrupting a netlink message and confuse user space in the
> > > unlikely case rtnl_fill_prop_list was able to produce a very big
> > > nested element. =20
> >
> > Should we not prevent it from happening in the first place?
> > IIUC otherwise if user adds a lot of altnames ip link will no longer
> > work? =20
>=20
> We cannot prevent this unless we add a mutual exclusion.

Today its under rtnl_lock, AFAICT, so nop, if we want to lift
rtnl_lock from RTM_NEWLINKPROP we can probably slide the props
under dev->lock or add a new lock?
