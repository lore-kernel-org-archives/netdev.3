Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3130199D8;
	Sun, 19 Jul 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784460179; cv=none; b=avTWAzGxcycYmcBtDywCoTggKEn1lqgWGZj3eCWjVuW2DJ5ez/d08qs8pBs41FE9/lo4jw8MbubVh67YN6Utk88tbGh1WHNmo42DCmgXhNLjCIdJPnjs8LHSCKG5+u7E5jlOp3uIkDyQjlpQjH9bCOvCy5bu303AzCwVWHQ0+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784460179; c=relaxed/simple;
	bh=erp5PHdYqohbvgIRKv0C1u9q3Q6swRpSS3g3Z7FMa18=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mnA1jGxraUl4VeALF5CH4heFza062MF25XlFNrBhdt2PsLzO6WzmHMSUk16lr4jVG7Lj88fb7ZBhthrGU8mxIYFDvn/THYCH2T8eELIt2SdmPdIpj5NU3zoHReOCCpzaKDlFXDts6t2epyX4PvYTdNoh28jTx/07s/wlI/wfqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=PTYarDYO; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="PTYarDYO"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 8C57F6095A;
	Sun, 19 Jul 2026 07:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784460176; bh=erp5PHdYqohbvgIRKv0C1u9q3Q6swRpSS3g3Z7FMa18=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=PTYarDYONWs/1vrJciy4AqRngvM5ermapQ/l13GAkC2TNtWTWLY6W+CubFP/nDHhq
	 4s8OoDK9260p0qXS//aF6KLwei2y3rPWi6IASpqcAJyDZT9rFUUBFNBllnhRVjGCxO
	 K9ULqPMObpkRLTiTjEavPVLeQEZmSnJ+mAb3MSNh9EmWwwvciv01b7JiuRCwj2h/jL
	 CdeHotxOJex+JaJkityVqJPQmaXWmxNRNWHLySneEppS2celclIpuZfZrCRBlyyDLr
	 wHCeo+y8LCxhwoyjou52mFDyK3sqZsGVIcayBRsDPtXveZUlfe1ss3cnUt5/uwEGcS
	 gmZRsm6Y1/3Hg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp
 fixes
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260719095307.hwtnbrqdkjxntrcr@skbuf>
Date: Sun, 19 Jul 2026 21:22:39 +1000
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
Message-Id: <92B1BC3E-6976-478B-8B34-043EFE63C3DA@padl.com>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <0A7B1CC8-F5F6-487E-A14C-1F0C2D5ADC84@padl.com>
 <20260719095307.hwtnbrqdkjxntrcr@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Vladimir,

> ocelot_ptp_rx_timestamp() accesses MMIO-based registers, which can be
> done atomically.
> mv88e6xxx_ptp_clock_read() accesses MDIO bus registers, and the MDIO =
bus
> is sleepable. Fundamental difference.
>=20
> Your hardware only provides 32 bits of partial timestamp, so
> mv88e6xxx_ptp_clock_read() will always be needed one way or another, =
to
> recover the full 64 bits. Either through tstamp_{cc,tc} or through
> direct calls.

This still happens from overflow_work().

>> Deferring to the worker can reorder frames such that PTP general
>> messages arrive before the timestamped event messages, which confuses
>> some other PTP implementations such as gptp2d [1].
>=20
> True, this is a caveat, but event messages and general messages can
> already take different network paths, especially with PTP over IP =
where
> they go through different UDP ports (even if for gPTP that is not the =
case).
> The PTP user space implementation needs to be prepared to handle this.

Good point. So perhaps processing the embedded timestamp inline =
doesn=E2=80=99t confer much benefit. ptp4l (which we use) handles =
out-of-order messages fine.

>> This optimisation of course only works for ArrTSMode because there is
>> no MDIO read required.
>=20
> I don't understand this comment given the partial 32-bit timestamp
> limitation.

Better phrased as no MDIO read to recover the arrival timestamp.

Luke=
