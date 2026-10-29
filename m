Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267793;
	b=asjVNcYfH99fDwXKRchZ4Y0W1LJU9UK8W/QLIhFQriL73+rLKGicCqjOTceFX8QBIbFk
	 rhTDzfS08eDtQDfGskWy0YfOy1tx8EKKUypM7wSoMAemm6bobaQg9d0eLkXUpBH4dHPAX
	 c40Q853PXl5JyEFkRRreC+YJo3Ezt2ZynlApHbeaKFJB5J8crUiYUWopz/QFZdoArf1W5
	 Bkd0GFfjE1o/d+FIWR8ykKnBW+QA8zbS1eeNY024D6N4z8cvYxLykT9xsrewgwm0PovRj
	 WclWM9VdzvOwTJu+6kPW8p+SiUriDdVl6eDh9A+FuYzL1cmUtLGquljnD5cmGNpC++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=BQ7utKynwQWDrnjHnQU8rInTnbd56jtxZwPJG5lj1AtnFTXANqmNwSlWejryEhbDXN3W
	 Fmo+565h1z+czU5gzU4Sk7numv/y9GgLW4Q5RV3+PfnPePWnfIfDm+T1xbvhDx6DstVpB
	 QrkJtV1MDpZ/qg3t4D9hglqxol8T6rnCRR1C02EAaJj53v7R/gcm3zP5xTqbY+JvBc2dh
	 wrgkvrpLyLBWz6ziGuRK4/JcW4LHbpBCINpUP2szXeY77jRvd4kxjfEXu1PU+BQi9icRE
	 xtuSFS7453dznHRTT+gOODGJ7iymBCI7wkc3scUdkzAO1SuuCfwf9mttCNa9k00pbGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVlmbW8U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097E606A31F;
	Thu, 29 Oct 2026 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVlmbW8U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA11F031E3;
	Thu, 29 Oct 2026 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267792;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVlmbW8UihNpNvT/6rh5IRV/88agVTAnNdYmKJH9XSzSvfJj2hY7/cX++uJJmpR7i
	 lescv/ASmjxHLEh8zAo5AwIKdqvimEveMHZrlA/3BbbJrMwOIb0hWZ08MXyJk98Ddb
	 QyWlUAlO6ARwKp+RtIG8rLlgtIlL/wMz8FgjqUBNGwbq0jnKG4LershNDJsKjmqm/D
	 1ybyonl4x3aUcw4zm1zLzcIF0pMlkaVp2niOaL4aHGYIFgwTUpuLXDSki1wMZXcLVe
	 Fu71xI1zm6I79oYpVYiIMmxmVFffUQ3fWVm95CMTpUfw9rPhsX2v8/Q4+fQIPO8gHh
	 FD+COQWphX3Kw==
From: netdev-bot+sinfo@kernel.org
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
Date: Thu, 29 Oct 2026 09:56:31 +0000
Message-ID: <179326779144.3327.11596356628770174944@kernel.org>
In-Reply-To: <20261029094916.3127193-2-coiaprant@gmail.com>
References: <20261029094916.3127193-2-coiaprant@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
