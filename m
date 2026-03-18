Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D73274641
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872021; cv=none; b=DkLIKWKBgZC9RiqTlP4APhXm7J0NpmJKGbZTsfkPp5VJLsyZtY2eUFUzzMYm2tfW4om4NE2YnTdlxSxP8u2jsflttfy0nweYHVXF7XGDR+re8nNFy7CtezLsdqiYUEJRoHlyPPeNDlqAxQPiYTHx6sSDsAu4mt/yNBQ1gQ3U7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872021; c=relaxed/simple;
	bh=wfedWDFzpWPSsc5+R0SIs/oE4e60/m59y0yB6Ffj13U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/cik5qvnDzLapgtrSvlNZpsrOZI5nmrnBrhygkjjG1hOpOUt4NFNtAxoMDsE8RNqFT0db41t/siCABjjXBIJ9+HsEs2S6CvQTu8lLaQi8zcldyzA4RgSICa+m7G8m6aWYq6q26WgK/RftJE6FKh5Jh2XjRsCK0/GQ+1qkQknEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaGZmBGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaGZmBGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D9BC19421;
	Wed, 18 Mar 2026 22:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773872021;
	bh=wfedWDFzpWPSsc5+R0SIs/oE4e60/m59y0yB6Ffj13U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XaGZmBGczjpqf9mGR6Plu2cC0lO6S86oj4J3oiyYF4i94+XL1bsw3YFShTTqiyp+z
	 9MdRti5i/V0gpeQG6oWYiB97hOhiBlJr+9a+f1dzbZ3l0lp98y0uDqjUtohJt/X+uF
	 lLpKXugRw5uz0gjvk4iFSXTOB+y4Va6nYhS4YLMvfJL+SHE2fk6Z7+9hTeYrzVEaIj
	 nnaf4Lg6rv6TwnxVftpONr8NWWpG3lyJDeS/iXtNgr551J9rm/7T1kcRdPWPL/pwGT
	 ebfbJwz3yNj8Sy2FmOAatK739GdB4nVEdwKUtKO7toemJZLROxjzMSFMgHmLEW67DN
	 3bGZ3Zy33hCeg==
Date: Wed, 18 Mar 2026 15:13:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolai Buchwitz" <nb@tipi-net.de>, <nicolas.ferre@microchip.com>,
 <claudiu.beznea@tuxon.dev>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Message-ID: <20260318151339.398e57f0@kernel.org>
In-Reply-To: <DH5TETVK34CG.V7P9P9Z1AAKL@bootlin.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
	<DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
	<20260317152330.32998fdd@kernel.org>
	<1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
	<20260317162303.4065e307@kernel.org>
	<DH5TETVK34CG.V7P9P9Z1AAKL@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2026 10:53:37 +0100 Th=C3=A9o Lebrun wrote:
> Goal is to keep `bp->queues` & co as before, to minimise the diff.

Minimizing the diff isn't really a goal usually.
As long as you separate out large mechanical changes so that it's easy
to scan thru them and confirm they are correct it's not a problem.
Of course if there's a mix of functional changes and renames that's=20
a nightmare.
