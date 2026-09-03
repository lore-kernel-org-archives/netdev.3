Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7638F64C;
	Thu,  3 Sep 2026 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422002; cv=none; b=CuH5ykZrTn49nQIGERPIdsmI+D0R3oUxKOog/f89jOGckMcCK+8pjz0lKTeSR5X7hPiTfYmSverHEV91UtjVCR5DC56gApMEBXOt0YPYkV6dOv0OjM/E8aEVNREQv4vzvS5WR5IfZXQgUiya6iJ3PuKKAjiPc0wOZPrkR+aUnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422002; c=relaxed/simple;
	bh=NPaY5bHmYYWCVn3SDQaWCfO9KlzQcZEVTI+BmWvLRRM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CGZgQBJUeDcD7w7Qxtq/+cqUrlDRScOdfBZ3ySECXhc5nPwIjIgMBp/ACE/pwHxndR6/9MeqFBoM19UN3VdwgvWmA89WfzFpAdfEELuZNjNvZPWlHOdJxNY2mBvnEIOP0USeepKsSqVz7K70Yndwwxali7P5rNJNXIlwXbRK0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=i/LnNJgz; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="i/LnNJgz"
Received: from smtpclient.apple (unknown [120.21.173.4])
	by us.padl.com (Postfix) with ESMTPSA id AF94560968;
	Thu,  3 Sep 2026 03:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1788421618; bh=NPaY5bHmYYWCVn3SDQaWCfO9KlzQcZEVTI+BmWvLRRM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=i/LnNJgznNM60SUcvvLOzVw65MHMgZkEK7d620LrWflcSAeIlmSEtRctCoXarHBNW
	 C3yfFw5P7Dki+COJU9r4x8hB9c7AgSRyWtHayV7/O37vJVlugKIVd7r0WwCcZt3GJT
	 OFGZmJolxbbcOHls45HDf5snelR1Os3GTUwT4aKTQiGeB9gqD2h2supGGa3AaENU44
	 FOh3FZgYfCB5QKUfQCYO5DWF95hLIRV2SMxpFpqIdFtUixOWA7PkyxKtyZBh0IsEvw
	 6a+bnEFwEjmpWYP04oO7VHabgopZvrwxorWJfOSjUAeHnBRwkg/1sHcA9BCYKaCaD1
	 HTbWzzF18qCMg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mv88e6xxx: various hwstamp
 fixes
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260727131815.0403cbb3@kernel.org>
Date: Thu, 3 Sep 2026 17:46:13 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D59E67D5-E43D-4D5A-88F4-FAB7AE29B753@padl.com>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
 <20260724165207.6a03c9db@kernel.org>
 <d46fcc62-b032-4bf4-9397-a11f1b523125@lunn.ch>
 <20260727131815.0403cbb3@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)



> On 28 Jul 2026, at 06:18, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Sat, 25 Jul 2026 17:54:53 +0200 Andrew Lunn wrote:
>> On Fri, Jul 24, 2026 at 04:52:07PM -0700, Jakub Kicinski wrote:
>>> On Sun, 19 Jul 2026 15:30:52 +1000 Luke Howard wrote: =20
>>>> Three fixes for improving the reliably of hardware timestamp =
acquisition
>>>> on Marvell switches. In our tests this eliminated missed timestamps =
in
>>>> ptp4l, whilst also preserving PTP event and general message =
ordering on
>>>> switches that support embedded timestamps. =20
>>>=20
>>> Do you know if there's any precedent in the existing upstream =
drivers
>>> for overriding the reserved bytes? It's not normal for devices to =
modify
>>> the ingress frames. Perhaps there's some precedent, but if not I =
think
>>> we should gate this (eg with a devlink param?)
>>>=20
>>> Andrew, do you have any opinion? Or perhaps Richard? =20
>>=20
>> I have a dim memory of PHYs who change the packet by adding time
>> stamps. There are definitely DSA switches which can put the stamps in
>> the DSA header/trailer.
>=20
> Ack, thanks! To clarify I of course don't mind modification one-step
> timestamping style (Tx). But here we're overriding reserved protocol
> fields to carry local metadata (Rx).
>=20
> Let's see v4..

v4 was posted on 27 July [1], I=E2=80=99m wondering if there is any =
feedback?

Cheers,
Luke

[1] =
https://lore.kernel.org/all/20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc=
@padl.com/=
