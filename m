Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359A359A90
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843731; cv=none; b=IfN9zxxgZq/SJz6lPlZaYrMh7zTa0FpN7dnrvY0T/FdSjIjGPidMlJYVsXnwhyyrr0VswGPOh/nIt2x+70VvAkN7qLTWUPO3Y9XdeaZSSZtx09oZC+N6BetHZx83chEQ0HsxLDfJCWhGm6KYq5/3CDsLQTukY4HDzTWvMZMDTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843731; c=relaxed/simple;
	bh=qhCSt9wJTsk3J71W1i9AjMXwjOLTe2WqVHxDmfL2PEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed+cE+VfN0HlkgCONrrBCGAJr2/cMPwX1i2Jhd6e+Xepw+n+IPDWt9vnaXn9ryChu/yk4JCQ4qy9tQPCW/FDRLyRrfNQyKrIsZFyJ9hgSrrUPjOvs8aQZ+sSe7bLz7MJH9ZtxElvun+16JgoxG7r2rK8d6GI3b8CvkwaKADjnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/aF+Lvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/aF+Lvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4B61F000E9;
	Thu, 27 Aug 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843730;
	bh=qhCSt9wJTsk3J71W1i9AjMXwjOLTe2WqVHxDmfL2PEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c/aF+Lvr/5Z/vYsHZN75hpa7LyVdBPnuSM+zIBsBl4qVChFXwO0miTwEjAsCAiKWJ
	 KZBICfqWPsAHEtwxE1oONevnF3D6U93x0/kgEkZS/UR9seprvsyVlMryNyP6NxqRbh
	 qXY2DePyrNmrlwzWHym/BrkWVwFkMn0q/xtK05SNIv90HkzW5KoBG3FqwTVTvSFQMV
	 mZbn+g3tpZPcZzCAknKW/1aRXTG3U39HWJ+IlFBedUmyjRR93wfcZ5MlypSD3uwHxy
	 yaPuRzXmHneljuN4mZwsC25q3nHuXwyOjHuKbAx7YdzGRcl0QD2m0w9A2/Ia39BWQj
	 7B5q9QcxPMaOg==
Date: Thu, 27 Aug 2026 08:15:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, ttoukan.linux@gmail.com
Subject: Re: MLX driver for host-to-ARM communication
Message-ID: <20260827081529.63513668@kernel.org>
In-Reply-To: <0444bbb8-39e2-40f8-b3c2-a5851e5bfa70@nvidia.com>
References: <ba322fd3-9f91-4e2c-9000-12d473ecb249@nvidia.com>
	<20260813081410.5fdeceb1@kernel.org>
	<0444bbb8-39e2-40f8-b3c2-a5851e5bfa70@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 11:24:08 +0300 Gal Pressman wrote:
> On 13/08/2026 18:14, Jakub Kicinski wrote:
> > This will be nacked. We nacked multiple such drivers over the years.
> > Most recent one not more than a year ago.
> >=20
> > If you model the device as a network node it should be reachable via
> > the normal networking path. If it's a control channel - explicit
> > control channel APIs should be built, rather than doing pretend
> > networking.
> >=20
> > Every IPU vendor gets to this sort of design sooner or later because
> > it's an easy hack when running a user space SDK. nVidia has clearly
> > turned from upstream work to pushing your DOCA stack on all customers.
> > No matter how many shameful lies y'all told about fwctl not being DOCA
> > related. This is just a next step. But please commence your bullying
> > campaign. What do I know, right?
>=20
> There are some unrelated accusations here, I'll focus on the technical
> side of things.
>=20
> No DRAM NIC (NODNIC) is not a new interface designed for BlueField 4 or
> DOCA. It exists in our NIC since 2015, and implemented in other OSs
> drivers long before DOCA existed.
>=20
> It is a lightweight NIC PF intended for simple packet transmission with
> a small memory footprint.
> It sends and receives ordinary Ethernet frames using SQs, RQs, CQs, and
> EQs. There is no private encapsulation or command protocol. You can
> connect this PF to any other NIC on the other side of the wire and it
> will work.
>=20
> On BlueField 4, the firmware connects the host side NODNIC PF to a peer
> PF on the DPU side using ordinary vport forwarding rules. The Ethernet
> packets are forwarded unchanged, both sides are Linux netdevs.
>=20
> The purpose of this is to provide network connectivity between the host
> and the DPU OS, particularly when the DPU=E2=80=99s OOB port is not conne=
cted.
> Standard networking applications such as ssh and PXE use it.
>=20
> To be clear, there is no hidden FW involvement or handling of the
> packets, these packets are forwarded as is between both sides.
> It makes sense to use a networking driver for networking purposes, I
> don't see how control channel APIs are better for this.

I understand. Having a full networking driver for such point to point
communication between device FW (/OS running on the device, doesn't
matter) complicates the system topology, config/init and mixes very
non-networking requirements with networking. It's a lazy design which
leads to poor, vendor-specific user experience. The NFP had a similar
thing, it obviously never made it upstream, but I'm very familiar with
the implications.
