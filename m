Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFE346E55;
	Sun, 19 Jul 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784460965; cv=none; b=PjLLDAMVTrY41Y3yUFATEnpKQSud/hTY90L6WIBfTAMLDHU9uxEK7YnRD/nTo6UnB6kGYepMmGAVePzn2FvpC/G/Mq7FjGTvryt/LtHgORYSrjBdtxDML8o8tOpXhLjhcdRPxPGtSr2/DUW14LiQ3IuQk8uTTIGJ0oB3JgPL5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784460965; c=relaxed/simple;
	bh=hr43sw9qW2shQXLeShsPM+9gJu+UI7BDR2J29LrKo5c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q1D8TKjB3QkxDCROAvsvlb740DFmtDUwKVEDDBUyWjvEA+R6qQfUy2KVkTh2+31b2lzIuAuace1zkNJuRbacVdqa/qcRaOyoqXSpWv4rAFttDgXi98EomJWIp3048UHqrJoRxSqxkbHA7t/Q4UyZEPdiiqqpFtVS2EJ2XxQy7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=s7n+rExg; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="s7n+rExg"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 593596095A;
	Sun, 19 Jul 2026 07:35:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784460963; bh=hr43sw9qW2shQXLeShsPM+9gJu+UI7BDR2J29LrKo5c=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=s7n+rExgJHTZ6EPdD5cu2Okl2ZmnJNINBknHrHJPxrQlVs8rIu1ZGCsAdwE0D4Mvi
	 PYXUDKuKLkZTxSxQnKPM7+OJ7l2b3NdVY8W6+ZVnkiKeYHnRL9+dHTl629hzGpGih+
	 q8tMAmFfWor0J1gaX86U7wUXCuPeN9TezNyC+kcVwsllrUKAm1gbcXMH0Uz7jQBZOI
	 6BXrE17Nn8OOIoAeJQeBaVJ8qRT80yAS8tAfBG9uo9GhO92LAdbsE9FfSFrBSHkEpJ
	 kYGL8PWtfeNAeAzgOhvYGkvJZF6ce9jJcrHQOHjpXX4rLHKTkoyC/fDxzfVicbbN+3
	 cHJRuXPnW44bg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260719101241.xs4nz7r5bonb3qys@skbuf>
Date: Sun, 19 Jul 2026 21:35:45 +1000
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
Message-Id: <A59F16A0-6C6A-4CC3-A7F6-84B7DDAD14B2@padl.com>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <20260710-mv88e6xxx-ptp-fixes-v2-2-af97c38df247@padl.com>
 <20260719101241.xs4nz7r5bonb3qys@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> We try to keep the data path protocol between the switch and the host
> API compatible, and identifiable by =
/sys/class/net/<conduit>/dsa/tagging.
> I would argue that the protocol where PTP timestamps are in registers,
> vs where they are in PTP header reserved fields, vs where they are
> appended as trailers, are 3 different protocols and should not be
> presented as "edsa".

For context: I added ArrTSMode support because even with the PTP worker =
process priority bumped, ptp4l frequently missed RX timestamps.

I can add these as non-default tagging variants that can be selected by =
the user. "edsa-arrts-trailer" and "edsa-arrts-ptp-reserved=E2=80=9D?

Luke=
