Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819734FF79
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330841; cv=none; b=CCFY0Rei8X/Rr8IHAT1iCoPORW0O86yP+ISlj6y+6GAc8NpkuCVxfGDrLvWGIBExGlIeNEIirtbAnr//QcF1J6LPfXpX6G4MIGQjo6O6Cv25OQDmpUofJo2ZKF44Fz13qPdGfvIwPbigTREVoMtc8fkn1bYWK8xuuxYFw8hxwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330841; c=relaxed/simple;
	bh=5muOdTrZWcuDN0G3isCHu0K7NBjUMNGRyBGqUkXm8hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afuOMm6R1vtEd0Ncy2Gy8drw4VbuWF6s8Rk2G3p34UiiYdi/GwduKOdjUkT/TRa//n7IgJUGtxvD8Jj5E2ewT1uPO+BvL67Z7RQ30Gx1i95FKCbMbcwN/22flyCBb3aJ1JKgAKSVY5R476glnhW3TpxYtVdu0UncSgO7KSegAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5kTElTC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7ipui9e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5kTElTC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7ipui9e"
Date: Fri, 25 Sep 2026 12:07:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790330830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCjfL/WCmvsS3pbfbyrTap+A5Xmt7Kb4GNFmx+KCBjU=;
	b=S5kTElTCjB6DIOIYXCzcZQHPd+BaLES5eylZkWJLjSgrDNlUhngc9pJYFdWsVCyD1RY6Vb
	D8dA1P7qm9rgGbqrS4sX4mAc6YDbDZ0vEKOWj8bMID3uU/sMmpU+c2n4WyIsD6TmJ8xaU3
	YC74kF+E3eFepUEfe8XpNY9oTQCgAuFO58wcFsQNpUkoruPt7cr15Eg5FZ415jdvhrPwyQ
	DCStVOQ55DCgKfvv/2qiox56ltnv98cp+luiF0cD0Y1c1Nhq/0n/rkRrr5YVuAyXaUsTI9
	kYxhv+NU+QR/1qYz6xMKO8ytCjlbofDgw3tqR5b8JH2vRMUMiRvaZm6HqUq8eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790330830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCjfL/WCmvsS3pbfbyrTap+A5Xmt7Kb4GNFmx+KCBjU=;
	b=C7ipui9e1NMFu0mlAwaJQaJ94TvI4V/qV5+WNzd1CqHf2LFtmxnrhzB/fVvAqZXnejdLQh
	Gxggwa2+DUucRYCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v6 0/8] hsr: Add additional info to send/
 receive skbs
Message-ID: <20260925100709.pybl7s3J@linutronix.de>
References: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>

On 2026-09-23 14:14:01 [+0200], To netdev@vger.kernel.org wrote:
> I am trying to extend linuxptp to support PTP over a HSR network.
=E2=80=A6

sashiko:
- #2
| Does this manual offset adjustment corrupt the hardware checksum offload =
offset?

Nothing sets ->ip_summed here. But the bot seems to be right here.

| Does this overly strict pull check drop valid small Ethernet frames?

after revisiting I tend to replace it with
		 if (!pskb_may_pull(skb, HSR_HLEN + movelen))
with
	         if (!pskb_may_pull(skb, movelen))

since the memmove() below only moves movelen bytes, so there is no need
to check for the HSR_HLEN which are in the headroom.

| Does this hardcoded offset corrupt the network_header for VLAN frames?
okay, will add the VLAN header.

- #3=20
| Does this code break UAPI backward compatibility for standard userspace
| applications?

complains about the in-line header. Intended.

- #4
| Will packets arriving from a Single Attached Node (SAN) via the interlink
| port bypass the new PTP drop logic?

Yes. I guess it is okay to drop the PTP packets from SAN port, too.

| Does this check miss PTP packets encapsulated in VLANs or UDP/IP?

Yes. The specification does not mention UDP/IP for PTP packets. I will
ignore VLAN filtering for now.

- #5
| Does this code unconditionally drop standard L2 PTP traffic?

Complains about the in-line header again.

Let me fix that.

Sebastian
