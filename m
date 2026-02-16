Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597138D
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262482; cv=none; b=PgLLtkGn1hFrx77Q5sRHRAQK/8araISLBwnf19bzEu53nDyB7+4w4s/UzZAe7agX+GRIg4fRwrXed/StOss8stZo8Tk5qldLfYXq9rj1+oJev+Db9R5AZ5AjfzKKT/awxb7Ocy8GIj1aSYDMUk+NsneOdoBS8r/cSmhKgQw4v9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262482; c=relaxed/simple;
	bh=bT2fiqRkjI9axK4fJtClgUV/TJc6YLz7YhqPHByH0kk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=a0TzS4MPXTmsnMlrmSFQd/lOsKblhMVmWULmxYHwtK4bkNBXJgjwKd44DwiL/2wMJum7YH0yRR4iHDbyuwBNL6TygN9r4qKJZVmyknz1hgHkL8jMh7q8yb+HKkGySc7oEdN0wsVH5xVoaU+JLNxgAkkgXtvuoeR3YCbh5wgTA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=cjOgiwYl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="cjOgiwYl"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1771262476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT2fiqRkjI9axK4fJtClgUV/TJc6YLz7YhqPHByH0kk=;
	b=cjOgiwYl2zixY+bjimSYCRXIK8VH45q1zpZ1bCPWBn6AL3obFgYyxLF/iACRf63TTAktFJ
	AEPwW/vgIDKy/zZwcOJ8dAr9pFBaV7VzA5IMFMD02K3WfN2dAHj8VDBdyzAVYBwdwFv896
	xbeNmH0OqheYp6HHoLu25WAtADiCWSZOj/ajeIZyJt4H85EYm1UzPuGfk6pe+Bl+TcSk/t
	h1JmbrHDLXfjIeoKWwFmhoJmcf/yF7TtQCAdk4+u5+joiz80eZ1Qnm2FmwfVcVHRpPALy6
	R06ZFyGXSo09DlUZpFifiVeEfgTcum63vNhsQldwCRxfARIGMEDAncFyEq5m8Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 18:21:13 +0100
Message-Id: <DGGK56T574F0.TJSLQL9P1SM@cknow-tech.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Andrew Lunn"
 <andrew@lunn.ch>
Cc: "Yao Zi" <me@ziyao.cc>, "Heiko Stuebner" <heiko@sntech.de>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
References: <aY9s5PXP4zZ7R6fa@pie> <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
 <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
 <aZDGsJNLZIty0242@shell.armlinux.org.uk>
 <a4aebacc-c273-4e42-97ff-0cdd88d771dd@lunn.ch>
 <aZMxKdkl2Qa7e1WU@shell.armlinux.org.uk>
In-Reply-To: <aZMxKdkl2Qa7e1WU@shell.armlinux.org.uk>
X-Migadu-Flow: FLOW_OUT

On Mon Feb 16, 2026 at 4:00 PM CET, Russell King (Oracle) wrote:
> On Mon, Feb 16, 2026 at 02:57:48AM +0100, Andrew Lunn wrote:
>> On Sat, Feb 14, 2026 at 07:02:08PM +0000, Russell King (Oracle) wrote:
>> > On Sat, Feb 14, 2026 at 05:50:15PM +0100, Andrew Lunn wrote:
>> > > Rockchip have recently started adding support for a new version, and
>> > > appear to of listened to what we have been saying. So it could be th=
e
>> > > next generation of chips get this correct.
>> >=20
>> > Have you seen any proposed code from Rockchip for their new scheme?
>>=20
>> There was a patch, including a rather odd formulae to convert register
>> value to delay. I gave some feedback, but it has been silence
>> afterwards.
>
> Searching lore's netdev archive doesn't seem to bring anything up.

https://patch.msgid.link/b25d6eb2-e105-4060-86fa-c1a06396ca92@lunn.ch/
