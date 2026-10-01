Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69F4CCDC4
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895409; cv=none; b=gYel8gvQhy5Bqnoj6z+OniZ97irKj1nhsOM/Ve+B7cDIF675RjvoaB8BpMc/8e4iGKv8Kai5WB6wSlrqLZ3w2+bh5JwhPL3Tt+SXjHsMHBrtSuuNL2FQ5Y7p8FE2TcoGL/c7YSWJYQPmLLQQIJPCJ7xsHwxFl6cItmPmm64cFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895409; c=relaxed/simple;
	bh=H8NFaTMuZbQ4YKm+CogUMym7Z14eCXyyMrAw+sva1Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lwd6IiU0wJcSVbY0Bzb4vnhiKn4yDK2h/xrYDSfx//0gZWyeRgf3vGPrJny7YpDzG4rML8On/p9swqlMIC63sKvV5h36IHr0EyZWihhOBAomwry60U5oRROxda5jXl6EWcwHWVyLCF5V5Rjz26PhuK6BSSKt0AWgA2RuXvRWvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnE+3Z6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnE+3Z6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8951F000FF;
	Thu,  1 Oct 2026 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790895407;
	bh=H8NFaTMuZbQ4YKm+CogUMym7Z14eCXyyMrAw+sva1Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JnE+3Z6GNVm4dkQp3Ky/Wr4oZb5HPnSFOFhIClfGdM9SlKUX5c2p1Q0cpIZVd3rub
	 1c0tvtQ8tuWFksgkmAWABr9k9yZ7gBu9uaXgFFiF0mzpDDE83FzLcVce6z7alwCy6M
	 7Efmo8o1IjdqOme2j5gu5TUFRKJUgxgq9ucVim0VA9kaVebusUxmSs9qpeDM7bnn++
	 V/9k1F7tSaJaaCX/QNwNcO5JEVN02lz8Qtun9/idy+OilA8fyG2zTLmU2Ze9Hm23F7
	 ESxrF0h1t6jVDzrxCIKx17MLH/pSzBAKOZlR55NCdsmmWjno4sLotxQunMnlVVB+0T
	 kg/4L13IM75Dg==
Date: Thu, 1 Oct 2026 15:56:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com, ricklind@linux.ibm.com,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v7 00/15] ibmveth: Add multi-queue RX support
Message-ID: <20261001155646.5957a373@kernel.org>
In-Reply-To: <966a8145-421e-4be1-8d46-2cf8e4f9fa2a@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
	<966a8145-421e-4be1-8d46-2cf8e4f9fa2a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Sep 2026 10:40:56 -0700 mingming cao wrote:
> Hi Jacub,

There's no c in my name, sir. I wonder why people do that.

> I noticed this v7 series is flagged red on patchwork. The apply failure=20
> is due to a dependency on my own [PATCH net 0/2] (Message-ID:=20
> cover.1790357373.git.mmc@linux.ibm.com) sent the same day =E2=80=94 kept=
=20
> separate per your earlier feedback to peel fixes out of feature series.=20
> Both touch ibmveth_open() in the same region, and the net pair is not=20
> yet in net-next.
>=20
> The v7 MQ series is based on net-next 161ea2d4f2a7 (2026-09-24). The=20
> fixes are already subsumed by MQ patches 3 and 6.
>=20
> Shall I wait and rebase MQ once the net pair lands in net-next, or send=20
> a v8 now with the net pair folded in? Happy to do either.

Sorry for the delay, hint: please put just me in the To: if you want me
to spot the email sooner. We get 400+ messages to the list every day,
I'm only reading the list as I review :(

To answer your question - please hold off with reposting until the fixes
are in net-next. We won't merge the patches if they conflict with fixes.
