Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2812379EFC
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393752; cv=none; b=N2O8tU868EUxv82zQZHktXAuIV6J0Sxy3Kq66g6PpyvpwjXLFEX5EFmC1bLS4CWjEIYGIs6JsabiHl0cL4Kxum5rgsiO9Ljiu12n0WVjPmFG2heJBP/+XQloMcgm4n3TzW2lUCDW4kPFIKPd+gvdG3I5LwXIXBbOdmcAPPTYhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393752; c=relaxed/simple;
	bh=/+WsiWwPai3aG6q0eTKytScZYgCVZiRVb1w1Ih/vpxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY3oN4UlsS2qgxKLnEw5dB/E3TL7AkjxPHkagfRqG4hiLBOxvwJgLQKcSDaPyuF2p4ZMmIrak3cAd+cqP2yc9NE1fENFILobWdBmFiALhYfj7PKuZKVi3Q6t1Vzq860jC4ZY/oDCUBmpbryQzU5xezVL/V2qVvB6MxWFdb0QfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MG16jQRj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5+i4IgW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MG16jQRj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5+i4IgW"
Date: Fri, 13 Mar 2026 10:22:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773393748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+WsiWwPai3aG6q0eTKytScZYgCVZiRVb1w1Ih/vpxU=;
	b=MG16jQRjPr1WRab2yjkQd1oVAcIYGDbe/XRRkJNG5TsN+EOSLkIgDQHQpyBopDV1FQM2dX
	lGLJBGrzZgdvyh7wcI8sRHp3XtsyLoMkOkGco7cozF9f5izJnsQTtRbsQ2fH3IREiS8cQB
	z3m5JUq/VvnvqdNjuWcFoc6yX+aLWDS+5KZ3dBleoDMf4QjMF4iD0Ot3ORwPrKSaSOQrQ8
	mMj3f1+qqEDojEzENYj77uda0DXocXiUprTs1NKTtjbfc+85xWX++SeqCCdJVRKDk04Ed5
	SUig0K4wzhIdF1zCRz0YntiuqsXQNTxnS2IHMeox/aSpqauzn9QhA2SDiY0fDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773393748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+WsiWwPai3aG6q0eTKytScZYgCVZiRVb1w1Ih/vpxU=;
	b=z5+i4IgWX5Avk8VmPKX7V7FdrTYxHUf1EQcFUdXrWjDfz0qUWiYTxidCqY1FKIYLz8JRpY
	OQ/5KqkFE8iL4yCA==
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
Message-ID: <20260313092226.SscHp2zQ@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.be379ee17449@gmail.com>

On 2026-03-12 17:43:36 [-0400], Willem de Bruijn wrote:
> > Yes, this is RX. If I open packet socket, bind to hsr0, how do I filter
> > for packets from one of the slaves?
>=20
> I was thinking of attaching directly to the slave devices.

That could work. Let me see.

> > After some thinking and browsing through the packet code:
> > The hsr stack creates hsrX. If it would create additionally hsrX_A and
> > hsrX_B in order to be able to send and receive only on the relevant
> > slave device then I wouldn't need the filters in packet code. That could
> > work=E2=80=A6
>=20
> That's another option.

Okay. Let me add this as plan B then.

Sebastian
