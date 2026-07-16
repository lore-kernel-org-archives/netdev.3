Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973F31D367;
	Thu, 16 Jul 2026 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185773; cv=none; b=Zca92H5dJ7CzJg47W6i6rXvnM6/+ksv9GnJ1sjyVxicks36UlPGur2YJBKvV3FrqD9Abq/NpvgU3sUtRJLei9aCzGYZM7wa4lfLfCcsq6ezhiJ0SQyPbimxCvratZIBbUDLptMVxPMYGwmdPPsxgcrEaW1wnvdCjJJI1omXCuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185773; c=relaxed/simple;
	bh=bULteZDyZ9e1vPn1LqBJbYIJMR8M4dH/uL5GWDjurmw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RJELsuS0Hy811uHD++83hwL0dnHJ9IWrD9MbPoSO0bXkR83Uc7TcOMY5yPoWSXrt+EmLt4zR3xEknPwl0aysM8DG3nbuj3VIniYMzFoAaFUEn0z9lEJ5IH63aouNRHDrW7VBtSZgA1rVsXng2GETVumMkKme1NYO3WDnP1TGl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=nblI5pYY; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="nblI5pYY"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 58B8C6095A;
	Thu, 16 Jul 2026 03:09:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784185762; bh=bULteZDyZ9e1vPn1LqBJbYIJMR8M4dH/uL5GWDjurmw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=nblI5pYYBSmHFEHaQui9HFE1lWA2OL4BHkz+Co8t6Erkn1Ycs7bbfVvI9tym+Mn9C
	 LqlVTrkaaVfYPdac+1wDKpKzG8XP8dMByhpdNA5QFYKz6xkOXn6JpDOyHd4VPaurNZ
	 pN+abr74MUJl9wBOEWkp47AglY3CiLBMa5xRPqPgCzeJlklbwBoGyT2DtfIAoS6ZW3
	 krBwYZAFoy/XIW/Hnk95b1w9bDZBpdQPkErDMtdyn8FUdA1ecAUWwxjjs3ReBQywRn
	 nEvzasm0Qa/214CY85QkMKZYgfihhk//JM5pBNfy6D0mNXEd3n5AZX3zUzCkOKEMoh
	 0eP+ifZF6krsA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v3 2/3] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <CAOiHx=mZeS1dZ59grQrf9U2QP3OKEJDahhYpLx5_tKCEUty1yQ@mail.gmail.com>
Date: Thu, 16 Jul 2026 17:09:05 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
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
Message-Id: <540B5427-A5BE-486A-818F-5D512E1BBE4E@padl.com>
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
 <20260715-mv88e6x41-fixes-v3-2-9a8702b27ecc@padl.com>
 <a607d5f5-a315-493c-971c-d5e8cab33941@lunn.ch>
 <CAOiHx=mZeS1dZ59grQrf9U2QP3OKEJDahhYpLx5_tKCEUty1yQ@mail.gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On 16 Jul 2026, at 4:52=E2=80=AFam, Jonas Gorski =
<jonas.gorski@gmail.com> wrote:
>=20
> Probably also needs to be not attached to any bridge, right? To make
> sure that no additional static entries can exist (because I think
> these are hard to recreate).

Thank you, I have fixed and tested locally and will include in the next =
revision.

Luke=
