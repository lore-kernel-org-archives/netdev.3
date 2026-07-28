Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6F2673AA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218151; cv=none; b=iNE8j+O3YYhLJtoSVHsGLVrPQVC5wxr/vBybRNVRWGj0OHDksMkBGlzoWV/qNQm8ZXj0rmoxeDXeVdMcZBr7u0CHU3G4svxGdpWo47hz7FAogsGz2RJLSHutRUc95O3D7CRs3fex15T/K/bGH50AY77FlgRHKKrW9djMRtpuy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218151; c=relaxed/simple;
	bh=SKELMi9bljjPHx+HMGPrtaf5SUfdVlWTxBBdUyLtSO8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DkmKX/UdG4R9pZrPSiUULZh3AnYt1AbXqzdxaqETXnZYzuOZZ0QPsW9ii/eUEEsbkBBXJgLeQZASbxfV+Bg1fY0l8zig9jAlMmaycbbnU7SRh8RQucBlo7YamkJdPxQQL9z1OS00QTd+dL6j3egj4oHxbdVA5K8mHC1tn5EVXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mIC7lDDy; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="mIC7lDDy"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id EF1E960964;
	Tue, 28 Jul 2026 01:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785218148; bh=SKELMi9bljjPHx+HMGPrtaf5SUfdVlWTxBBdUyLtSO8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=mIC7lDDyaLwKU8eFhuA+/F360DB237zy8dEQS/LZYvn2Mo9xo5h9o+25D+4P32JSq
	 0OCXZNYKkSMkyRq43pYfvZ0dvRY29jdP9/KA6+Bgdwpt1zZ9r9WO3ta7FnP00x+8+e
	 RsWl4uc81eJ4wUJwsele+K3lzCOxcIixeucA8cDeMXmVhGcXqy+HViv8gaJu9QB71K
	 cSSPu53eFfYboQmvEnfpb0QCpH8ycdSN+TzblXjV5xKgM15SOTM8dD286B2g/uJetM
	 Jif/tHhpHGSgjNkgti9qdyhQhEiResar4+94YAPKNI5qKY9rPNS4QnoqYAJp79mMv5
	 G1wpF5174T3Xw==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v4 5/5] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260728035957.DC9821F000E9@smtp.kernel.org>
Date: Tue, 28 Jul 2026 15:55:33 +1000
Cc: robh@kernel.org,
 netdev@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8657BCE5-A6C4-4A27-84D7-F735D35AFF45@padl.com>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
 <20260727-mv88e6xxx-ptp-fixes-v4-5-10b4020155fc@padl.com>
 <20260728035957.DC9821F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> [Severity: Low]
> Is it possible for chip->tag_protocol to be modified concurrently by
> mv88e6xxx_change_tag_protocol() in process context?
>=20
> If this runs in the fast path rx softirq without READ_ONCE() and
> WRITE_ONCE() annotations, could this cause a data race?

Should not be an issue in practice because the tag protocol cannot be =
changed whilst the port is up.

> [Severity: High]
> If ptp_ops->global_enable() or ptp_ops->port_enable() fails and =
returns an
> error here, does this code leak the increment to chip->enable_count?
>=20
> If the count remains incremented on failure, could this leave the =
hardware
> state permanently out of sync and break the ability to enable or =
disable PTP?

Fixed in next revision.

> [Severity: High]
> This is a pre-existing issue, but can this dereference of =
hdr->sequence_id
> result in an out-of-bounds read?
>=20
> If an skb containing a PTP packet is received fragmented such that the =
PTP
> header sits in the paged data area, ptp_parse_header() returns a =
pointer
> extending past the linear region.

Same issue as you pointed out in 1/5 and 2/5. It is pre-existing and =
affects any caller of ptp_parse_header(). Perhaps ptp_parse_header() =
needs to linearize the SKB itself.

Luke=
