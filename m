Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6282D12EC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822780; cv=none; b=lxfG5n+CmR2mQOMUPmaW2uoyA9XHTx2eb3if+WjbQTnU13fwrf3dajBKg7l32Y7PeF9jnw77Wdc195qf2s45P0hQCIw6saQQRp+3oVM3HYCMUbLH10IcajqiYmMfvhO91D45tJDfpR6swcGtkgqdATy483dYvvSo/VXHBtyGkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822780; c=relaxed/simple;
	bh=woH5WzIbEMI4/ez9/bwF03cYAl/1Bf+6YyVwL/KWlSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZR8s+iOpNICd9AwXKLgp6RRDwl9pKf5zRm++QS2YUdtZpxYuQLS/dDOH5GMBU7IlxI6mtarKWCSiZBVLPJJfzcBf3nDxCTdlDdCeCk6q00e7nhkNNzBBsPRkkpoyKJU8GYmpoElU7CX7H611+muLiXKBTMLe4E+t0uU7eRPzDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzGLwQq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzGLwQq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481DF1F00A3A;
	Mon,  7 Sep 2026 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788822779;
	bh=DHnX3supMJOAcIQjXok4Fsq37bPzgHsC7fbCrsr7Nnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nzGLwQq/KaM9g/DmTYEURgJkCwBTY+YtKyl9diy4F4gPpDD26SKYFju5oSZE1zUHn
	 e2AP3LFbgdkg/JAG1J2pdbc4is+xDhH6C30VTyxIK3WhqZqcaHCQNaHEFVm7yIcMpT
	 LBkbhOtXd6ulXa4VsRwfFYSeujeDUwsEdTtunen+KQQlczrPgF9e5XVMTAPoMFBZwl
	 dTaAssvYCUbnIDVaHCNFm524G8rw+iq4a5RLZ+a6Jcf0xsifXKWav3DIrl0MdXsQKx
	 0oxIkPMPPn/8IFzdNrn/sMKzPM7KLNuINvwcdnepPRI27GQmBDPHcc8k/3vJK3e4oQ
	 n7eRtQA+sJCtg==
Date: Mon, 7 Sep 2026 16:12:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Message-ID: <20260907161258.2b0b421d@kernel.org>
In-Reply-To: <willemdebruijn.kernel.173115664f973@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
	<20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
	<20260904160106.08acccb5@kernel.org>
	<willemdebruijn.kernel.173115664f973@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 05 Sep 2026 22:22:06 -0400 Willem de Bruijn wrote:
> > > Perhaps I don't understand how dev->pacing_offload_horizon
> > > would function as a boolean. =20
> >=20
> > The only uses of the new value are:
> >  - as the qdisc bound, replacing the max_ value =20
> >    -> Leave the qdisc as is, let qdisc config define the active horizon=
 =20
> >  - in the driver =20
>=20
> I see your point now, thanks. A flag NETIF_F_PACING_OFFLOAD?

=46rom the name I suspect you mean a feature / ethtool (-k/-K) ?
That would do, but presumably not as a real low bit within
dev->features ? I guess it is a datapath feature but somehow
those bits feel too precious.

> The two configurable offload_horizon fields is definitely redundant.
> I do not want to ship idpf with the feature on by default, because of
> SO_TXTIME. But a boolean will do.
>=20
> Plus, a netdevice_notifier in FQ to clear q->offload_horizon
> - when this feature flips to off or

Not sure if we should be clearing user config or rejecting
the feature change if currently in use.

> - when dev->max_pacing_hardware_offload changes to a value smaller
>   than then configured q->offload_horizon (e.g., on device reset).
