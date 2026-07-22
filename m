Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15C1B78F3;
	Wed, 22 Jul 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730393; cv=none; b=Son9tH7BqEKm6EUqxQ10YOXYmQcI1LoXZA25xKR7p1HdnzNhpN1GiC2oyMasWHqbY1rYqWGo5fwd9c8r2p7gyp2sv+XNTWghkc32yi63TmXXrYcYRaiCaIdMpUFYe2QBmCXruiSfLc6BRhKbNGU26NrnqOzUv55fREDgwxzOxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730393; c=relaxed/simple;
	bh=XcaYw6VDHPgYoR4lnw1nAoEjgpD7zdhASaWE8DodbvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mgqo+Ou8bi44ulqOs7pJQGMhJRwEOEY7IEcYySCMTxApQ5NlTKkB7hR2G22X40RIA81mojxnVWYQTEOwWsIRZ882v+BaavKnXWYC4Q4ZiI6ecYGcYY4b9AebTgpePgc9WVCBCpXwqPhNPW1bHaxPgABMrwW5Tm77Lw+I5cgFV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy7fbMKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy7fbMKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C6F1F000E9;
	Wed, 22 Jul 2026 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730392;
	bh=kGZ9n0pbWYL3A6KhWezEcua+WEtRYw0llEcbuqPEedg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sy7fbMKgMfdkvlmTbnuf4kV/ZgbY4RqUJFD2/jJQi6OMM8NFV4gtGshnwwaBSmJ9W
	 QwqiKAVH6CLd0SIpLlYJx1raxmKUiFIsaD6K+VK8u8ta0grQ7RFISiiVdmuVd6VsUy
	 uaYgMRCYqK/9gAtl60QP+hp3wwDnn6BqQtO6YSVdo1MQHr7b4cJi/w5Cuy4Jq9zH7X
	 3TwHJeTX2Yrk7IPKPPwGqKPyi57iwQZeb4i8yz1vs8Xqabdj1wAGdWes7d98qpSmb5
	 otOSiBH7TrCXYuROdVzyktNEcgfhJ7ZkpflA1uQ794TDe7t8Wo8fV4sMCqaXL00ssV
	 nRh3pB/aJK5YA==
Date: Wed, 22 Jul 2026 07:26:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tim Gebauer <tim.gebauer@tu-dortmund.de>, Brett
 Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260722072631.21b57e1e@kernel.org>
In-Reply-To: <20260722040722-mutt-send-email-mst@kernel.org>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
	<20260714092506-mutt-send-email-mst@kernel.org>
	<5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
	<5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
	<20260721105853-mutt-send-email-mst@kernel.org>
	<20260721100715.5b43412d@kernel.org>
	<20260722020611-mutt-send-email-mst@kernel.org>
	<8814700c-7549-4d12-b657-c990dfeec14f@tu-dortmund.de>
	<20260722040722-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 04:09:25 -0400 Michael S. Tsirkin wrote:
> > Would be great if you could do the revert.
> > I don't want to mess it up. :P
> > 
> > For the re-apply:
> > I can post a v13 to net-next soon with the flag included
> > into the existing commits.
> > Or would you rather take v12 plus this opt-in commit as-is?
> > 
> > Thanks!  
> 
> jacub if the revert goes into next what is the process to
> target a patch on top of it for net-next? Thanks!

misheal, revert will be merged to net and reach net-next on Thu after
the downstream PR, at which point you can post the net-next patch.
