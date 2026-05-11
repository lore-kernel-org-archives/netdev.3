Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00F356779;
	Mon, 11 May 2026 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541646; cv=none; b=e6YzPHQ7oMPdc/qqORiZ48dglnZDCHJjZSQSdjLouPMb0Da0JmmkIP4m8k2uwTSsn2bMAbCjaHlUQfmHV/EAkxL2ovP70yZKvzPfUT9pzhNlgwwJwryrOb3AlKKwUZLPzYh0hwAPT9cLwK6mZpM6vJBhHXL6RS+ke+izaK7l9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541646; c=relaxed/simple;
	bh=PwM3ya7Ehgsfd+B6pp70iDeXf5O/2ojRuTmM3KAZ7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJ7lm1bNaeYYVpGPKKPpqajd38hFqelqLRlHuHifDxKfISV2lqtZW65t1ucmxHE1ucLoQC6EiSAdAqHlJAmQc4qG13rhEBfz5wxHWeTI1UnB9X6InXwC+admRSAVD6NG7ZYukXr63AKd0NjCev3X25qROpL4VxzpoIa9yz2TbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6ITxTCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6ITxTCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856B4C2BCB0;
	Mon, 11 May 2026 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541645;
	bh=PwM3ya7Ehgsfd+B6pp70iDeXf5O/2ojRuTmM3KAZ7+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m6ITxTCr+I5YnuUj0CGnwRGFdgsvsgLoLGwgBbMq5JLkU1dxX93f+7uwV1gfc8WVo
	 nmzKTO91Lt0tJXntkEx6ckUbP25XZOgCYSHZmL30n9QU21jDBuRa6dFVfBie+XyZ60
	 Ks+37z6rXr7bFkC3vLprkQe+AKKoiz3eluBvryXhvF+wU1KEHDZVC4GeLWZAmI2wgb
	 O0N3Nxlz+dPuAb/lET4BFGWEobLEtPDbolMxFu7IBwIAE/6+/7Bay0+vCy0iDx/SuT
	 9yVooihC78y3YT48pL8dHvTUXJqFuShbFeHDZU8JOyrowKI3BmmWTEuUvF25gdCkvv
	 t3delzob7I59Q==
Date: Mon, 11 May 2026 16:20:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <20260511162044.45494456@kernel.org>
In-Reply-To: <CADkSEUj3qUFDG-Hc3_RNZjm6=h8wJF63OOcHWsZGumG18VdLkA@mail.gmail.com>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
	<20260509230519.57607-2-enelsonmoore@gmail.com>
	<alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk>
	<20260510085841.243bdd7e@kernel.org>
	<CADkSEUj3qUFDG-Hc3_RNZjm6=h8wJF63OOcHWsZGumG18VdLkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 10 May 2026 14:44:16 -0700 Ethan Nelson-Moore wrote:
> On Sun, May 10, 2026 at 8:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > Sorry, must have missed it or forgotten.
> > Could you point me to the report of these driver being used? =20
>=20
> Here:
> https://lore.kernel.org/all/alpine.DEB.2.21.2604240004280.28583@angie.orc=
am.me.uk/

Maciej, what's the relevance of your machine in the lab?
Does the platform or any component that you test on this
platform have actual users?

If the answer is no / unsure please fix the driver up to
follow modern coding standards and submit the patch.
