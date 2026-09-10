Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DA33AD8B
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004162; cv=none; b=XExYG7yq93vWEZjXrQhwCn9xBpDTQRUcgwfMe0gCp1gMh9e9RzvdP+HSNaDxPSRbvk32YkRQVnCvIJs+g0Ovrr4dydBNMqTjV4iNfiO86+5CWmVVoMnbY4NfBvBK+9S0mfSofNxpm7XO/1p3rx8TIkg0Acrburi77Wq+T/AB44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004162; c=relaxed/simple;
	bh=sK4u1Ajqh97sJcnafXqWfCBCPAPipr78xeApWYH+JFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGMSqdkpI78tqJrTCIvAEqFDrKxW7z9nC6PxjZByjkz1VGP+pwwcAe8/Y5eENNyl1ubrfOaOqef3eyUbO5Lo4e+G6kNYEj0QgfGe50gCwxre4mEPkD8xlW9CvPDLGQd+hsNz4/kWT83Ltalkf+JvtjinDV5bftKgzhhHNuZTkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV8OJQo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV8OJQo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642EB1F00893;
	Thu, 10 Sep 2026 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789004160;
	bh=xdxFQj89d7ZmpT6S8J1AL8x3PT/s291j8lw5baFXfx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cV8OJQo1ym+sD4PK3fkNaoRyhqcFeZdqcbRkvnMfUmiEAGHFuwQ39LiOdBodmMTSo
	 Su6O/3NvY2P/nW5MIjCj0n3yEVeSDXoeoZ54q5tN+5rxuKUL7ZT84QShcn9nVyN/cx
	 W/vfSM8mgEA/eP9lxqEmNABy1lJbyjMdSpiyDt6TwQEy3YahXJbNLThrmzA2XRaPO2
	 KSBYq9NUQCKtTe3qNaYtrNtno00OaQV1Ou19vO0f3ZDUNQ6Hqg7/55PIGz1BCgeht5
	 VLGYAJ51BE7VkDqyaWFDxnRY/QlovY4+T4obxnNaTBWVuDpmbMV8Yw2013q7ryI1vN
	 pF2cyZDSi26hg==
Date: Wed, 9 Sep 2026 18:35:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, idosch@nvidia.com,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 5/8] vxlan: dynamically allocate struct
 vxlan_config
Message-ID: <20260909183559.24898956@kernel.org>
In-Reply-To: <178889063414.219967.17640576039088216642@kernel.org>
References: <20260906180111.1973188-6-edumazet@google.com>
	<178889063414.219967.17640576039088216642@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Sep 2026 18:03:54 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [High] vxlan_config_apply() publishes the newly kmemdup()'ed
>   configuration with a plain store and immediately reclaims the previous=
=E2=80=A6

This and the complaint on patch 2 do seem like something we should
address. I'm also tempted to take patch 1 via net, since we're=20
close to Thursday's PR let me do that. And if you feel strongly
that AI is nit picking please repost the other 7 after the net>-next
merge tomorrow
