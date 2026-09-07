Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2423F40D;
	Mon,  7 Sep 2026 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821497; cv=none; b=Ew8Xsa60oH6bD1i1RRvMyaao6wZACmEMZCJMCJPLuXWBtJ3DLtKbsoxy7N6Ao48sEUSLAo4qoCucLI7e+aqUva3gaPv2RP/qck0kQbFuUSXz+DoFewN6F96VjH+/B9ilATA4a4jF4VBQ9r4ZsUiG96T9n2xkhMq1BQFaZwEH1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821497; c=relaxed/simple;
	bh=e88CkWXLFXByErav3eyr21WjqFho/Gvfnvap7eHR0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puOGPqDbLqYumYEODco//5KqKP7x7BHtCGY1raI8iPz1O/DuFTqlIG7lZXoD+dnuj/20epYm1hOzKAVCXsAo4cpMnWpXqkLQHHipEjA/CMg1u56qJUQYZpKDhq7aRKTbA07rr2+rSHzqASQ1zqUgH6g+3w5fLMlrf6UmgoykHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fProWdD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fProWdD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214341F00A3A;
	Mon,  7 Sep 2026 22:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821495;
	bh=osyr9vbobtjiClFCVLlSdXjYM+xnAGLkGjSYTf1jHo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fProWdD8hdqV3J6Cs439SgfRjqDZrtdPaUoBSxecDNKYG0FC4/PDrVfpBYfK/t3sZ
	 7AMzpDAbYx2lR1uG18bjo5qubbpiLNCNqnyHhuEgXVJ9SLsloERycfvxyF6uzjSGwM
	 RYakJlPhxj7sZrwho1TeRZ0rOO+r37jeTw924uJxwtTOw9QsPinTtBPbNlERdQMF75
	 RBOs47a1KqZucaz1IVtx6NeuQgbSQh+cyFZeMa5enw4m/2hMDnZdiErXnGCGIWcJOO
	 808jLskhYt6kXdqujzmHYhp3GhrSjosuCEFh0ojlWKUm4opK78GTazVIFonp5R9Ls5
	 /nBbxXYVPaRaA==
Date: Mon, 7 Sep 2026 15:51:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "shenwei.wang@nxp.com"
 <shenwei.wang@nxp.com>, "frank.li@nxp.com" <frank.li@nxp.com>,
 "wei.fang@nxp.com" <wei.fang@nxp.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>
Subject: Re: [PATCH net-next v2] net: fec: support RX flushing via an
 ethtool private flag
Message-ID: <20260907155134.6e9e77f2@kernel.org>
In-Reply-To: <371b9a61b150bce5f43e70a8032be4b4bc97e759.camel@siemens.com>
References: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
	<20260904182056.0d81cf1f@kernel.org>
	<371b9a61b150bce5f43e70a8032be4b4bc97e759.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Sep 2026 15:47:07 +0000 Sverdlin, Alexander wrote:
> On Fri, 2026-09-04 at 18:20 -0700, Jakub Kicinski wrote:
> > On Tue,  1 Sep 2026 09:47:29 +0200 A. Sverdlin wrote: =20
> > > The FEC controller can flush the RX FIFO of an individual receive que=
ue
> > > through the RX_FLUSHn bits of the FEC_QOS_SCHEME (ENET_QOS) register.
> > >=20
> > > RX flushing prevents frames in the RX FIFO from being blocked. Blocki=
ng
> > > can occur when the frame at the head of the RX FIFO cannot be forward=
ed
> > > because the ring it is associated with cannot accept it, i.e. when the
> > > ring's RxBD[EMPTY] is not set or ENET_RDARn is not set. When RX flush=
ing
> > > is enabled for a ring, such a blocking frame is flushed (discarded)
> > > instead of stalling the FIFO and holding up the other rings.
> > >=20
> > > Expose this per-queue capability as a runtime ethtool private flag
> > > ("rx-flush-qN").
> > >=20
> > > Due to erratum ERR050395 (observed e.g. on i.MX8QXP), enabling RX flu=
shing
> > > on more than one queue at a time can lock up the receive path, so onl=
y a
> > > single queue may have flushing enabled.
> > >=20
> > > According to i.MX8QXP Reference Manual, "when both class 1 and class =
2 are
> > > disabled, RX flushing for these rings must also be disabled". Both RX=
 and
> > > TX QoS classes are enabled via DMA_CLASS_EN bit, currently tied to
> > > num_tx_queues in the driver. Currently there are no constraints on
> > > num_tx_queues =3D=3D num_rx_queues, neither in DT nor in the code, ev=
en though
> > > having different values doesn't make much sense even without RX flush=
ing.
> > > RX flushing code just takes min() of the both values for now. =20
> >=20
> > For the errata - how is the user supposed to pick a queue?
> > The documentation talks a lot about device specific terms instead of
> > using generic easily understood terms. IOW it reads like slop. =20
>=20
> Fair point on the wording, let me re-phrase:
>=20
> The FEC has a single shared RX FIFO that feeds multiple DMA rings via
> hardware classification. The FIFO is drained strictly in order, so if the
> frame at its head is classified to a ring that currently cannot accept it
> (the host has not replenished that ring's descriptors), that one frame
> head-of-line-blocks the entire FIFO and starves all other rings,
> including higher-priority ones. RX flush lets the MAC drop such a blocking
> frame instead of stalling the whole port.
>=20
> So this is not a generic "queue full -> drop its own packets" situation.
> On a controller with independent per-queue FIFOs a backed-up ring only
> drops its own traffic; there is no cross-queue impact. On FEC the shared
> FIFO means a low-priority ring can stall a high-priority one, which is the
> specific problem this knob addresses.

Sound pretty typical for a NIC so far..

> In practice a user would enable the flushing on the lower-priority
> ring(s) =E2=80=94 the ones whose backlog you are willing to discard to ke=
ep the
> FIFO head clear for high-priority traffic. The queue->priority association
> is hardcoded in the driver: VLAN PCP 0=E2=80=931 (and unclassified) -> ri=
ng 0,
> PCP 2=E2=80=934 -> ring 1, PCP 5=E2=80=937 -> ring 2.
>=20
> There are actually two constraints stacked here, and I should have made
> both explicit in the commit message and documentation:
>=20
> - Why flush is needed at all: a low-priority ring can head-of-line-block
> a high-priority ring through the shared FIFO.
> - Erratum ERR050395: only one RX_FLUSH bit may be set at a time, so only
> one ring can be protected this way. With three rings, the remaining
> ring must be guaranteed not to stall by other means (limiting link rate,
> for instance).
>=20
> So because of the Errata we cannot set RX_FLUSH in queues 1 and 2, but
> if PCP 5-7 bandwith is already limited in HW, we might want to set RX_FLU=
SH
> not in ring 2, but in ring 1.
>=20
> > In general AFAIU the flushing should be enabled in tandem with pause
> > frames right now. It'd be great if we can stick to that, or failing
> > that add a generic config knob rather than private flags.
> > There's nothing private about the drop decision when host ring is empty=
 =20
>=20
> I don't think tying it to pause works on FEC, because pause-frame
> generation is port-global. There is a single flow-control enable and a
> single pause-quanta setting, driven by the shared RX FIFO thresholds.
> There is no per-ring pause.

Global pause means no drops for all rings, PFC/DCB can be more
selective with certain queues and traffic classes being "lossless".

> I fully agree there is nothing private about "drop when the host ring is
> backed up". If we want a generic uAPI, the natural shape would be a
> per-queue attribute (drop-on-backpressure / flush), not a pause-linked
> one, since the decision is inherently per-ring.
>=20
> Does the above justify the ethtool private flag in your opinion, with the
> fix being a much better commit message and documentation or do you have
> a new generic uAPI proposal in mind?

The problem is fairly generic. Ideally you would find something
matching in PFC/DCB APIs or even devlink shared-buffer config.=20
Failing that we can add something to netlink APIs at queue level.=20
But since you seem to have a strong association between the rings=20
and traffic classes AFAIU, the PFC/devlink direction would probably=20
be better than ring level.
