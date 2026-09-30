Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45777136672
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733154; cv=none; b=qRbaLT7Wjl07Ao1RSrFfTGblqsJE46dxGBZrvT8Gw4YNM92HAX0xxe6c8BWI78/r/SyCVlwMgxoe6uZO909bWYgClk1/cPZOV6Tmkcw2U0qHBgyhEshbMkvD15RnO2s/Y3QajUjSVut2CT52MAvuAXD9oiGJ3d9LBsORnrBbItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733154; c=relaxed/simple;
	bh=1rcGJk0qxJtyrX22/iXBP7Q9XHSDUnm38+blNWA9kC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o62Ex1/sKiiB/CiURebLWtFKGwHkB8Xd/vSLpjHXMRePrfSUgYdO7fn0TL2qk6RAgE+aXbJe6LYMtgGmkKkagVMrfGOB9LouhotwSVIorq+6mYGzEi8j/PQOAdcDZDivLUZc++l14uC6+cUe0PgnZnxaU3fApVoaNyFztXh12xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DofECQCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DofECQCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2031F000FF;
	Wed, 30 Sep 2026 01:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790733152;
	bh=acti/lnildUh/7zYN5zSjs+i8mozEg0PERsCmrc5xlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DofECQCMmYivbG8tGoX2fllOJMEyxL+XK7hRdjne4NZnfBNyjFwx8Yb6syaSI0ygD
	 mOboNwre58+76GTSfdJL5m5FM8SRYmDPAAAAmQbEfIdWVrUUWDg6mAT85QbMQaiWON
	 /bttIRL1tPNgjpB3FKw3R/EO8WiMMP1Kst3cZMFH7ofAb3xRSEGTrsEpCWucsBbus0
	 euE9wrSkxQBaC8AAnvqSTFfyq3upIHGefORwg0C8MmDSnO+4E5yHGKhZocVt59/0u2
	 bDAHfsqbBTwYw+gHePEcWL4v4yVmXR/C4ydJz+OZCP2VP59pHEmPUpJkDF2dM6Mg/M
	 6Dhom3eD7hiOg==
Date: Tue, 29 Sep 2026 18:52:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: pktgen: reject out-of-range node indices
Message-ID: <20260929185231.297fe610@kernel.org>
In-Reply-To: <179059386581.3965069.15320036220559790742.pktgen-node-review@gmail.com>
References: <20260924053752.1442623-1-4ncienth@gmail.com>
	<20260928093243.GL13925@horms.kernel.org>
	<179059386581.3965069.15320036220559790742.pktgen-node-review@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 20:21:04 +0900 Daehyeon Ko wrote:
>    I propose keeping the existing ten-digit decimal lexer and using
>    kstrtoint(..., 10, ...) for conversion, retaining the existing ERROR
>    result and write count. This removes the duplicate accumulator and
>    prevents 32-bit wrap. A host comparison against the pinned parsers
>    passed; this alternative has not yet been built or run as a kernel
>    patch.

=F0=9F=91=8D=EF=B8=8F
