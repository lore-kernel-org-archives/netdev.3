Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717072;
	b=hgku8avzCJ3tgf0j/KC4eEdqdkkU53raEvJ7Ov/cAxWPYlG6GJa7menftIPC9jsHh/1i
	 qfBzO5DTFKce12MSXBrBEkI+BuYJBydoNxrWnVq1v7GbK8A/fVP7Wxfa+cfa4LbcyaQa1
	 0hqmHPDtGCn8McyX2c52oMDPyRnOINx13+5nEvmX0GbGXXE2NPWgpbhdumhxOBFoORIlF
	 Ban7F22hgHICSP1Pe6i73HBXZz+XaP7zzHkUoOW6ZW2M060BI22bWF5tk/RYdw7LAepmZ
	 OUEA4qwJ84qKG9AgXPsniiwo73bPNDaBAe0z0OCI9VywnLe8/nnHw524O6IuDb4QZwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=igIqrB8WB6A0jXhXFzQZWZHu05MDFb0+3aRgofBUPphbS+G8F9MFhL9XAClmsf4tzGRp
	 h3FYaoKkBsunsVfuiciurSMd0a0PPnTIOy9bxCMX9J5nLzBlicsHE0RLFiDk7uSQ4Rn+L
	 9LDDZZEEYvKIcClOJIlMk+8fbzRA1sEOyOoNtC1DdNloe2hajpMIrPL3Dtj9ZouAsP1LO
	 rtcZcPyFGjEEJZ3CPB48btgfV4YPpR8VhgfvtpLGFMj6CraIfnD64Vbov+nNKlzm4/eqF
	 8POF8pcuZxO0BeJyZ0Em9gX21JGcmjFAPeRmrYJ58z5NzObesAMzFWaUQp46rlFt/Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/8iLVB0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3F606A319;
	Fri, 23 Oct 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/8iLVB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C851F01825;
	Fri, 23 Oct 2026 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717072;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a/8iLVB0uEO0lhHxxObH6wwI8XSsIU8fsZkCMNC/Lon3/p45a0G8UZkZ1ELw++vrR
	 zFyMR4LeYn/RWVM5GviupbFzvLA4w9lUhncYxjRKeJa1BLqiKOLdJCE6so4vwKOGFJ
	 RPbjo02/l10B0zCzLcOQJO9eGYMu3dGX/LIwntaoCiVZPOLbemNY8yvDU/BXimcrR0
	 TDeHvSg9bWO/JCQhKg1Ck1dUvGk+Yssef7hqhiNsP9bZ0Nch77mFDp7IPt0s+gnyGS
	 1G9/C/lbHc6l4z2WI+CA2MqMm+cOLzTd5lYcv6oe74K/QnkHNnMuPzaKK8tMJ7xOwI
	 I++3iwwTK36ZA==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: fix oversized RX frame check
Date: Fri, 23 Oct 2026 00:57:51 +0000
Message-ID: <179271707120.3327.4775409276963055481@kernel.org>
In-Reply-To: <20261023005313.3946390-1-rosenp@gmail.com>
References: <20261023005313.3946390-1-rosenp@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
