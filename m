Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B73932CA
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573965; cv=none; b=dH2cEYj1CWtYXrFM7OtxD/KLZ9WFpsa53cgNDW9hhpX4fRaIe52Y74W48TbKIOYpkOtCjI2cZjKfOBxINVdEL3ZmWkQESqvR3IYTItNEVFG3UxDln+mwvaK+e5guEd2EJliAp7SLNARE5cJTKz7LD8AHsbj0nNBS4cPPJ+HFCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573965; c=relaxed/simple;
	bh=OLJWTlRGDuIiR/Zh7tw5KqJKXc0XWmrhsZuf51N4z2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXt351+59FIavyASr611XXLBxOT7gcORdvgx24Fn5HDXf9GpVUz/3J32EJwk8JMjK2lI5o/RZEyGbvWywaPYemUdVBbY7sgroGDY90W+IxT/fB6wZxIRTG8b3RevEV//nO3MTEAOOBdYHy7fWr1L9ikBKdcAi/vlonSfMyIle70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiYwbY84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiYwbY84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BDAC116C6;
	Tue,  3 Mar 2026 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573965;
	bh=OLJWTlRGDuIiR/Zh7tw5KqJKXc0XWmrhsZuf51N4z2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RiYwbY84G3WNFKWJ2vzkrDvGqoFUX5qgEQQJ1VQZsoEEcOG8tZCxaXAUhGNHczyFx
	 fpthxpOVvaqeE08Y5bV5hFbNnX5hC5vP6pD9of/QDjlsuBavJTScHvq1hlifse0GLx
	 c9G5GMRDt722ropSAzPUlEfWjVA787OeshzgqQUyl6DUUk3fHS3F1djGzvLOiZBk+w
	 lYY2TlXo++yhSyScnKJJjbTXQVQM5sPt0rACWT0Rr9SuIKtJuKKPcz7B2T9+rh+v2T
	 gRBHGmHjvSka5WdWHncMadTYGVTdrFeHXsj6CmfaNpTxDuLVaCnw9UNxmmTWPc48jv
	 odHBJvlZkazrA==
Date: Tue, 3 Mar 2026 13:39:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Paolo
 Abeni <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-02-28
Message-ID: <20260303133924.521ed6cb@kernel.org>
In-Reply-To: <74f8c9d9-eac7-4681-b3ee-8ab2b20b7904@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
	<433139b8-3aea-4db1-8ed6-959ac445cd27@openvpn.net>
	<20260228170104.1ec4c133@kernel.org>
	<74f8c9d9-eac7-4681-b3ee-8ab2b20b7904@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 22:02:24 +0100 Antonio Quartulli wrote:
> > # timeout set to 45
> > # selftests: net/ovpn: test-chachapoly.sh
> > # Creating interface tun0 with mode 1
> > # Creating interface tun1 with mode 0
> > # Creating interface tun2 with mode 0
> > # Creating interface tun3 with mode 0
> > # Creating interface tun4 with mode 0
> > # Creating interface tun5 with mode 0
> > # Creating interface tun6 with mode 0
> > # kernel error: Unknown attribute type  
> 
> Maybe you didn't unload the ovpn.ko you built *without* the patchset 
> applied?
> 
> This line above makes me think you are using the newer selftests (from 
> the patchset), but without kernel support for a new attribute, 
> introduced in patch 6.

Yes, embarrassingly looking thru the logs I may have actually booting
the wrong kernel to test the "after the series" state. Let's see how
it looks when this series is merged. I added the tests to the runner,
they are just ignore for now:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-extra&pw-y=0
