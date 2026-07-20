Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7E1F4C8E;
	Mon, 20 Jul 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510010; cv=none; b=r7uHjyVlcvNsFJ373zoVvWAeqE8VktB/+Mk+edCPBR8dQq8UavNaj3xza+sI8l4t/HR/s86U9P8xF8PnpkbVQZ7+GZn6ZrYe+U8VfXMTGVQxBHyLZptu+JXTRgxliqrGQwuEJbrogUsDfoYaPyAbNQT/s0wHdU2dV8MrSiWf/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510010; c=relaxed/simple;
	bh=mzhDYiU1OVoUhCqJyxPsSIsPxPKYmPT3KU6c5ZZyJhU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UhDf0FQu7B6B/vYkEZ2rwNLUgS4OdO8f/9WyHMODY1DdEr328WtwrgIzjFRFco3bduxcpxyCq22caYVLigI+FpJuCHOfxvezXLnBsE/gRQT+GojueuE5pv61/F8QCmpcAKq5SLPZtFXV19n88ev2zwmIIquai7C1EJeiqtnLV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=1dOyq9Vn; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="1dOyq9Vn"
Received: from smtpclient.apple (203-220-69-184.tpgi.com.au [203.220.69.184])
	by us.padl.com (Postfix) with ESMTPSA id 0CDE26095A;
	Sun, 19 Jul 2026 21:13:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784510006; bh=mzhDYiU1OVoUhCqJyxPsSIsPxPKYmPT3KU6c5ZZyJhU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=1dOyq9Vncbw/08fJG0BWDgkJcHnrLAk3wQHHKuaNmYPDLV39Jabu8MAGHXnoqoPMn
	 i3Hy4r3fqdrumPIgiJhT9uhLGHy0snrKtCA/HOznJvPpQBwxfTavm1UDvcB61ymu5/
	 5Q+E3l3g9LCt8Z4tFcOm9lsh/u+BLtq2EBSbsxLZVzzId70OF3R4k3cTwDKa8sysf/
	 kvhQHSbXbxnPWUDdPHthjDK5GSRj00hy2U21VI7DPqHoM/5awudQTl5QEylo+nHrLB
	 pFdjdhwMIZy2n7WS8ayut8UQcFA/ptTUcFXLQ3cX5PzgWfC6hdJ7FfYoHV2+2J8kSi
	 uQrZEYT+73wQA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp
 fixes
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260719225701.okkvl2uhgsuwydfi@skbuf>
Date: Mon, 20 Jul 2026 11:13:06 +1000
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
Message-Id: <537810DD-FAA6-4DF9-BC6D-36ED01093022@padl.com>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <0A7B1CC8-F5F6-487E-A14C-1F0C2D5ADC84@padl.com>
 <20260719095307.hwtnbrqdkjxntrcr@skbuf>
 <92B1BC3E-6976-478B-8B34-043EFE63C3DA@padl.com>
 <20260719225701.okkvl2uhgsuwydfi@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)


>> Good point. So perhaps processing the embedded timestamp inline
>> doesn=E2=80=99t confer much benefit. ptp4l (which we use) handles =
out-of-order
>> messages fine.
>=20
> If you're intending the in-band timestamps as a fix for gptp2d's
> limitations, then no. As a general optimization - maybe.

Delivering it inline makes more sense to me but it is a more intrusive =
change. I don=E2=80=99t have a strong opinion either way. I=E2=80=99m =
sure gptp2d could be fixed were someone motivated.

> The only problem with timecounter/cyclecounter is that the hardware
> clock remains free-running, which means you won't be able to apply a
> time-synchronized taprio schedule (if the hw supports that).

Yes, many Marvell switches support 802.1Qbv but there is no kernel =
support at this time. For 802.1AS, you want both kernel and user =
counters to be free running, so neighborRateRatio can be correctly =
reported.

Luke=
