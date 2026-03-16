Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DD3ED11B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691964; cv=none; b=W4oX1c5nKvLb/eDYV2vYPbzT4OZ1pfm28mc6sikYJ4mtcMe5aL+Y0KbJpZeghpvyanXaCUOKLggvzcPb1JnXWeCnkLhZ1yw1pdQtYT+rQePHeAwZVBVWrhlQfaG763zmIy0dgjzLY6NuDbjVm+1jffLnCnbq/+r6p9L4aeUiFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691964; c=relaxed/simple;
	bh=BCEuppfBjGi120pV/L4H1HAw8bpqmE1a9Cpj8etm8hY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sx+o4t1fIqM6qKDCxSMIV6cDvKJrM85G6t8p2N55BEVUTSv9KM0mcF0WMb9v7L+l2mS9TyToFfAppfnlFy204lgYVEXDjACN5xfEW6xE68iQ2SpN48VWuoWv6ZwD29icLPZl34eKvlEfKhJoQorvD65iNvRW/qGH46Tr8arvknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUxcFEl3; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUxcFEl3"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64c9c8f8783so111767d50.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773691962; x=1774296762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrPxfYOr1fCTB8o4oA9UBBY4QdP8hZH2JqAozaNlWlU=;
        b=OUxcFEl3geCLRMIgL4Eqw1ctr6spJkSVGoLSY1jYzWH3ofHat0jNBENFRa1JYeOr+J
         rc4T5NVX95z1fIIhAsmpYEu9qlMm2J3/spMJ77jlxcdCpmkp1iuF6juunF2iplctbh5Y
         qGtC+MWd+bgSB15kVPCg3NklLfhyAxFXZN9HE/QEs3deTUzpa3VIi3FceTk9fU6CBmHa
         SpjkoaKSmDsWqAHSLXuz9qxbG6xVeWB1cWcE3pDz7wjk9/F+YOtS2+gy+ib9FIOPhIqm
         g1sVX1FwEfKzlQLwDJWOZEnRPOLcYgHRdFXaK7G4kW6i5A0nZdaNMCCslLafHfwlK4f1
         fkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773691962; x=1774296762;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrPxfYOr1fCTB8o4oA9UBBY4QdP8hZH2JqAozaNlWlU=;
        b=fCofLGdV9Y6OIbcpGHWCSleCdUteenoR1Unu9pJo1nQzjo5JXUTHh7LyWdQQ/FJtWk
         1m3I59xgrkCf5Xy3ucVQGtIj9k14zw3RbEBbPnb649w3rnEFpOa4WUSRya67zZJB18RE
         V2SR9gm9UXI38itsD1KqVstrzfd/NPjnK3XyN7awUNWpKANIz1+vOqntFVMXYPpXdbER
         z0LCTkuyVeGXyc0ebGru0doBLuf2wwx5I2yiBk/lzHDAfs8vrx8eOPLFNElpIPCenNFe
         dJmRAv8hQ2ENXmB8Q+KD9nkI/h1021Yd13gUWtXpZYtaI2EGZeZwajxTyjxnCwE8q3iu
         IfuA==
X-Gm-Message-State: AOJu0Yxf3ZyYRHpi11mdJOaoQS1kUH6kfrQvmSV3Okg7vzSEmHd+LtW3
	l0riPQvA26hvCVzl2bTGAdR5iaBuagIB7lg/VCq+7H4/qPrUmaoQ9/pM
X-Gm-Gg: ATEYQzyWH5NViIfkA71vBGjRkHngx0/BFO+Wi7g8HwdmqNJOBQXUEe2zKCQExWPlPYb
	ajyA0/DnfcKNLcrKC7oOHHPL227p0LR+CqceD8ifeW4muvC9u2FIy+TpmJNmdzzmNCfnQPnp7kc
	5+DPoo0TMt8k9aqr7ZHKHQKa4VF6vzyQ1d0bYSBp0WHShsz1wgMCeE8M1i5vKCoCGxmPMH4o10i
	MEK/jXawtWmx2bv3ZwBlD4oo4QoBQVJrn5m6tsvbKytBoyjolgigGhDwMVuc503itj4lpjrBmO2
	ztEtfIlbO2WRPFbSvjH5buohwsln/YaYisVMxQ/teKNsexFApLHmD0ikMDBDvCZbjMJDmx+giDY
	XTIki9wyhtHbRsjfozx6IfftQH4LFzVaICaW4IEFnvF5s8Kk59Mo58pcCbRT/Yzy87PcyMvjmnB
	RZG8DpE83gUr9mdu0krSFVlGFwweIhjlczppPBUxYe94OFc2IPZTaZvCp0XGv9Y22uCo04GNDpi
	ZpK
X-Received: by 2002:a05:690e:4147:b0:64c:acdd:f165 with SMTP id 956f58d0204a3-64e88b0269amr793889d50.25.1773691962495;
        Mon, 16 Mar 2026 13:12:42 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e65b628d1sm6131460d50.16.2026.03.16.13.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:12:41 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:12:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "(JC), Jayachandran" <j-rameshbabu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
In-Reply-To: <20260313160410.LEhav8Xz@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific handling
 for HSR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior wrote:
> On 2026-03-13 10:22:28 [+0100], To Willem de Bruijn wrote:
> > On 2026-03-12 17:43:36 [-0400], Willem de Bruijn wrote:
> > > > Yes, this is RX. If I open packet socket, bind to hsr0, how do I =
filter
> > > > for packets from one of the slaves?
> > > =

> > > I was thinking of attaching directly to the slave devices.
> > =

> > That could work. Let me see.
> =

> Halfway done. What we went down to is:
> =

> Send with header    -> eth0/ eth1 + SO_MARK for header + port 1/ 2
> Send without header -> hsr0 + SO_MARK 1/2 port 1/ 2 =

> RX                  -> listen on eth0/ eth1
> =

> Now this compiles and I look into userland and am currently stuck with
> the problem that it does not expect "two devices". It is not impossible=

> but=E2=80=A6
> =

> > > > After some thinking and browsing through the packet code:
> > > > The hsr stack creates hsrX. If it would create additionally hsrX_=
A and
> > > > hsrX_B in order to be able to send and receive only on the releva=
nt
> > > > slave device then I wouldn't need the filters in packet code. Tha=
t could
> > > > work=E2=80=A6
> > > =

> > > That's another option.
> > =

> > Okay. Let me add this as plan B then.
> =

> At this point I am considering this which would avoid having to use
> hsr0+eth1 for one direction depending on whether I have to send with or=

> without the header. But this might lead to other problems such as ip
> address and so on.
>  =

> The suggested changes to af_packet, that remains a hard no?

Yes. Packet sockets are largely superseded by XDP and AF_XDP when it
comes to new functionality. And were never open for such protocol
specific logic.

Protocol independent extensions, such as reading skb->mark as part of
extended auxdata, could be up for debate. But again, we already have
XDP and AF_XDP which allow passing arbitrary metadata to/from
userspace. That is preferable over adding new structs to the ABI.

If you only want to attach to a single (hsr0) device, I still think
passing the data inline might work. Either by overriding existing
fields such as a MAC addr (a hack for sure) or something in the HSR
header (it as the direction? or by inserting a custom header (or
trailer) akin to virtio_net_hdr for tun/tap. But custom to your
workload.
