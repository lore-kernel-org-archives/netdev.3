Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7E3C769B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143404; cv=none; b=pcJVbzH2FvP8DvRdhWxKRY6jC6ISt8146jYu2V2UEyYLXrd/QUnmVGNb5o3IBFvHdK3YMJhhfy/hVDEeo3jryoo9/1HIsv9/CX+YnxmAQBA/KvVpPsDIZGuM67x2rvhqmGFYJZvEO73i1vv9k8XOjq1+nZJP8mgNnvGHgDRqNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143404; c=relaxed/simple;
	bh=dDLLW6Jv6VN0ln8Wl67499r7jaXsEzi7UIk69cNw3Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwc3fjpdUnRtJ4d+mr02mS5OvHrNxxj15dwP0wdtgPbBrvYZ/6BVpdZvu1D18qyMpr0VrNsE1tKlPfWb+xsvsywQnNuBfmBybt2JecGfFt/0UzDvIbgYu6fO9/sryg7SP8rReY09ieZraFn9TMO/Ji4MSWqnOgF97H6LNajLXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ba9/ZfMt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aub7ty/G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ba9/ZfMt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aub7ty/G"
Date: Fri, 16 Oct 2026 11:36:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792143401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDLLW6Jv6VN0ln8Wl67499r7jaXsEzi7UIk69cNw3Do=;
	b=ba9/ZfMtXXaMLnVMhnNUiCUsW4eQjMXZ04BXfobOorNlsMMo4HN1lVWw+SCYkF6woSNsxZ
	gykGxM9Rd3UEHJiqi8VNPVd6ZKqKuaUS+Nv/ZcPXsU5aX33n82XCduyOJ3Turtsr13jzWd
	xitJAjXVp+Gcw4Cl+aGCk78frpDKciCKgYjYIb8DO2fsqdg20AeCQvY7rQEtQ+DEN41g0Y
	de78WKPa6q1fro+yZDhu0ZjA+w0V04BZMuINF1W9ppZbO0i/5szpGnGoP+ivtWzPBDZH8C
	58DJPdwxRGmxiQqyh+X4YhYCkcd47iKhwcdbAvboEduCDeycgj1/nMmSH+1Oyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792143401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDLLW6Jv6VN0ln8Wl67499r7jaXsEzi7UIk69cNw3Do=;
	b=aub7ty/GqcLxjEJhDivVwDAMqnzwLXJo4ZoPF9zj7pu1vJhRAqn0JYk62ucCnQWyM5PMFL
	J1e7uNwp3kv1yEAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 0/8] hsr: Add additional info to send/
 receive skbs
Message-ID: <20261016093639.gtBcF4nq@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261016090104.cqli34hczhsav6e3@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261016090104.cqli34hczhsav6e3@DEN-DL-M70577.microsemi.net>

On 2026-10-16 11:01:04 [+0200], Daniel Machon wrote:
> Hi Sebastian,
Hi Daniel,

> > I am trying to extend linuxptp to support PTP over a HSR network.
> >=20
> > This is the kernel side of the changes. In short PTP over HSR sends its
> > packets to a multicast address and every node needs to forward the PTP
> > packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
> > In order to achieve this, the HSR stack must not duplicate and forward
> > the PTP packets as it would do with other packets. The delay caused by
> > the duplication and forwarding adds overhead which in turn makes the
> > timing information within the PTP packet inaccurate.
>=20
> I think the main reason is that PTP over HSR needs per-path delays, so pa=
ckets
> have to be steered out a specific ring port.

not only that but the time, the packet was in transit, needs to be
accounted for.

> >=20
> > My current approach is to open the slave devices (eth0/ eth1) from
> > userland in order to receive the PTP packets. Sending happens from the
> > hsr0 device. The actual packet has an inline header prepended of type
> > struct hsr_inline_header. The size of the header is equivalent to
> > ethhdr. The header has a type (h_proto) at the same position as ethhdr
> > and expects it to be ETH_P_1588 as this extra meta information is only
> > relevant for PTP packets. It makes no sense to send PTP packets via the
> > HSR interface because it gets duplicated and the timestamp information
> > is lost so this should not break anything. As an additional safe guard
> > there is a magic value at h_source position. The value has '0xaf' at the
> > most significant byte which makes the address a locally administered
> > multicast address.
> >=20
> > The header passes two information from userland: On which slave port
> > the packet has to be sent and does the HSR stack need to prepend a
> > header or not.
>=20
> It was not entirely clear to me that hsr_hdr=3D1 meant "this frame alread=
y carries
> an HSR tag" as opossed to "please add one".

Is this English bad and must be changed or just a note?

> > The header is skipped so that the remaining stack sees the actual data
> > and can send it as requested.
> >=20
> > The PRP packets are sent directly via the SLAVE interface. The standard
> > mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP
> > packets. There is not really a reason to use hsr interface.
> >=20
> > HSR hardware offloading is optional. The driver needs to know if the
> > operating mode is HSR or PRP. In PRP mode it needs to check the ether
> > type and for ETH_P_1588 it must not perform any offloading.
> > In HSR mode, for ether-type ETH_P_1588 there must be no offloading. If
> > the ether-type is ETH_P_HSR there must be no offloading if the
> > encapsulated protocol is ETH_P_1588.
>=20
> I think my question on v8 still stands: some existing drivers will undo t=
he
> directed TX. Should they be updated to check for PTP frames? I am not sure
> myself.

I though my answer was clear, sorry it it was not. The drivers with HSR
offload support need to be updated to get the PTP part properly to work.
They didn't before so it is not a regression. I can't do it all at once.
Once this it through I plan to look into the icssg driver. I can help
with DSA stack but I have no HW around.

> > This has been tested in a pure software environment and in an HW-assist=
ed
> > environment where the HW is able to duplicate and duplicate packets
>=20
> s/duplicate and duplicate/duplicate and deduplicate/

oki=E2=80=A6

> >
>=20
> nit: the subject for the cover letter says little about the patchset, may=
be that
> could be updated.

I see. The subject? So I have "Add additional info to send/ receive
skbs" from v1. I don't have the receive part anymore due requested
changes. The send is still accurate. Any wishes?

> /Daniel

Sebastian
