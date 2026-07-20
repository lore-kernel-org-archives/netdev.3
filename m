Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1C35893;
	Mon, 20 Jul 2026 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510229; cv=none; b=VekTYVP0hIUlg67qH354iPX3BGrIMzh4dGELOMDxnRD1KyfcaDvprwcdYlqNIQrGbqiJnwMOAOn3igu2H0SyJogVD9um4+p25LOgzXeIb+DT1z3YYoxiJlfEx0pYaz7TcSdNdSYbz+MYLP0sYMlNXF5xR6+ibd6KMDw0sWLB8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510229; c=relaxed/simple;
	bh=YMZYN4oUh9M4VmIDdGcNCJNcrqKTGFCQC3fWxEKsif4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pxaMl+qsMVe1vYS4JWt9fIMHoDro764Na7qJVfjnhQ2aBMbTWmn6C1D23EEl63u4xOWEtmZTjJrIms3X5cugLyuHza8I+rA0IM5L7ZwmtvNREY/651Z/BuOGDstUFFOuv0K/AYT+DONyKTlHTHX0W0wH5Wyy12PqCLriNvnrQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=d3VC6c8I; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="d3VC6c8I"
Received: from smtpclient.apple (203-220-69-184.tpgi.com.au [203.220.69.184])
	by us.padl.com (Postfix) with ESMTPSA id CC4BE6095A;
	Sun, 19 Jul 2026 21:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784510226; bh=HbhwYN8xcTcVdqhsLQMhQ5+1ZMbWiGfwUJe/6FZSLao=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=d3VC6c8IdoDNeTEpuxsbR3Fd0gVNHrEFusUTw/nJB/DqPWm6b0EweLpxN+ejR75pS
	 X3vdMMTtBC2dmiMIBMiub7rhG0crgYB44Nst8aBzFdpiux3JqjTZc2SNC3Z+KGp0md
	 8TwL9ZirxmnJdcv2ZXqU2SXSgo8QmJ+OfA2UYl1Y2uxodee3N6s+snWL/xl0SB4BZl
	 taNKnxWMDvtqScWMrqXttxRzBSYUPCbyQAfUpJ++bHtP81vnlBHkmpRuCahQ0MrD3j
	 Cl0rrwYXqxAND/gc1j9/GE9oEr4HXvbQ9SJvLwvntafwqhnBWOY8OqLC4glSDItszh
	 TkOhDcmdmYvgA==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260719230455.eaf7a4mlkx5l2uzd@skbuf>
Date: Mon, 20 Jul 2026 11:16:47 +1000
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3F288ED-50EA-4A3F-BD7B-C5461A475E4F@padl.com>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <20260710-mv88e6xxx-ptp-fixes-v2-2-af97c38df247@padl.com>
 <20260719101241.xs4nz7r5bonb3qys@skbuf>
 <A59F16A0-6C6A-4CC3-A7F6-84B7DDAD14B2@padl.com>
 <20260719230455.eaf7a4mlkx5l2uzd@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)


> I guess that would be fine, except:
> - worth clarifying that you're talking about the Reserved2 field =
(rather
>  than Reserved1 or Reserved3)

Yes, well some Marvell chips can write at any offset, but Reserved2 is =
the expected offset.

> - any reason justifying the introduction of "edsa-arrts-trailed", or
>  would it be just for completeness? As a user, what would make me
>  decide between "edsa-arrts-trailer" and "edsa-arrts-ptp-reserved2"?

No good reason, and the newer Marvell chips only document support for =
Reserved2. Removing trailer support makes sense.

Luke=
