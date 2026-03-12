Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E8359A95
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330179; cv=none; b=qyTH13gNjLG/buIo+6IkfBoHEmstxyCNwQebEQd+2m/LRALZY7ME6hwfy7RmelIFYn8EsE1Zfd+xekco7E2iHsd8xeAH9wXDzBAYRVXvq+DxrzTIhayt4nJerfzG5o3gOdS+osNY2kCXtVikcXoYbgRtMHGwUDZUxM5NuiBRFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330179; c=relaxed/simple;
	bh=Nz4L1eR+L1qlzE9WAkM18DQuDhU8EP+abBLbKqfGVoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5FG7YgcPzoT3elaa8fSHi6Q6FPOLekClrk1fc57oOm6DmjRVlUQWR1Y/FKYH2QB1KvDNI9JN96c978a+b0BQTVs31HTzDXeDL51hxixgeW+6TFK3+0YQ41RdneAMQWQLNeOq2taNGeDxjmEemSA4L1CJG5shFKHLqbwNjcQLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsVSGWYu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhAz6PDE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsVSGWYu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhAz6PDE"
Date: Thu, 12 Mar 2026 16:42:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773330175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz4L1eR+L1qlzE9WAkM18DQuDhU8EP+abBLbKqfGVoQ=;
	b=gsVSGWYuc/EKHWX6NW773c3LjLTKHSsF2Jtk6jVnkwQQAn6ON13Ftnn/ez9HfYC8W/s5qK
	wvemWr4C3Qv98WhNn5qZk2tZJLeoFGF1LJiyhNVCkfBJZSyYwZwIscNkZpjfDOLvTqryyB
	3u2yQBldlkZrMtAVzSS8tFFN2zCb6lHJvhEdeoGVIoeaLKFR8hzA8Q3LUpdyt9NUCFVF5C
	MIXyGrlb5NnmIEGtXDoc+CO7hmzMx/EnWppMna6WJkjBAATHhfjOFAnfbhtRjc1P8N4RTQ
	9pCJUpjkenA4IPyhq8daw1dNobj+RYDvzkS+7ZOrG6SO/vtZADaYBmaTB7FEtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773330175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz4L1eR+L1qlzE9WAkM18DQuDhU8EP+abBLbKqfGVoQ=;
	b=vhAz6PDEGpz5pAFJqRmIfSsrB5PULGyPyAeVrt2ufD6sU23MVI7SbPiV6ukkb15wGXTfWy
	B4nwNu54DZYURSCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260312154253.UC-QUPvD@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.3693c9aa8271@gmail.com>

On 2026-03-10 17:35:33 [-0400], Willem de Bruijn wrote:
> > but the problem was sending with system's HSR header.
> >
> > > For the first case, could skb->mark be used as port selector when
> > > writing from a packet socket to the master device? That already works
> > > with sock_cmsg_send.
> >=20
> > We would have to specify that SO_MARK 1 and 2 denotes the port on which
> > a packet is sent. This kind of burns the usage for everything else on
> > HSR so it feels misused.
>=20
> It is more or less what mark is for. An alternative similar field
> supported by sock_cmsg_send is skb->priority.

The ->priority thing looks wrong. It is used by ssh and other
application so they would suddenly behave differently.
But okay lets take SO_MARK. Might be smallest abuse here.
And we would have to hardcode the values in respect to HSR and I have no
idea where to document this.
The difference with SO_MARK in general (at least my understanding) is
that you can choose the values based on your setup. Here we would say
7-0 are already reserved.

> An alternative may be to share the information in-band. Already
> insert the HSR header also wen writing to the master device. If the
> master device can detect this packet-with-pre-existing header.

Given all this, I guess it is easier to stick to SO_MARK as the header
might collide with other data.

> This is not the first case where ndo_start_xmit may already expect a
> header prefixed that it normally inserts. I forgot the exact case (can
> look it up), maybe a weird edge case in GRE?
>=20
> It does not even have to be a valid HSR header: just an agreement
> between the process writing the raw packet and hsr_dev_xmit.
>=20
> There probably are still more ways we can approach this challenge.
> But these are three that do not require kernel changes outside the
> HSR protocol code.

Okay.

> > And then we would need an additional bit to
> > specify whether the HSR header is there or not. Unless I open additional
> > socket on the ethernet device just for sending and dropping everything
> > incoming.
>=20
> Right, packets that already have a header prefixed are written
> directly to the intended slave.
>=20
> > And we would have to filter/ distinguish the RX port based on it.
> > Userland has a cBPF filter to filter everything out and receive only PTP
> > frames. If the PTP packet is forwarded to both sockets (A and B) then
> > userland would have to throw one copy away and go to sleep again. This
> > sort of breaks currently linuxptp logic. It would probably require
> > either eBPF to filter also so_mark or deal with "no packet despite the
> > wakeup" but so far I tried minimal impact on both sides (kernel and
> > user).
>=20
> I don't fully follow this part. It discusses Rx again?

Yes, this is RX. If I open packet socket, bind to hsr0, how do I filter
for packets from one of the slaves?

After some thinking and browsing through the packet code:
The hsr stack creates hsrX. If it would create additionally hsrX_A and
hsrX_B in order to be able to send and receive only on the relevant
slave device then I wouldn't need the filters in packet code. That could
work=E2=80=A6

Sebastian
