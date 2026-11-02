Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614430;
	b=lTzqg5Ik+A9lyscyaUP+5zWMO9AdNU8pA0FQAiuRJ5XKXlaxCzz3SssjW7cdKy1Ya9k1
	 suvbaAln5wNhS7/pxfV54g3ojnobswl2g97qtrtZ7moqgh1QL2RaTVSvU7lCia0ABAyOC
	 Xn5D6rrz5nNY4WEhiPeB1HCrT/6PtVd7ArbFKEdmSYAaofg0lM2vO+9R6lRGaR+dCtzQC
	 fPc+23M8F7f0+BT17xCGm0stuR0gD+e0LUej1L7POEEi3HgOG8a5ZzVm6KL1ixKQGiM6q
	 mcPjBRvFFs/rLY0zMiXthVBLxV7o9XVST376elb7Oq/b546coISBgyQD5wgsjQ2KSdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=m6rqo2fWjdqrlYKDMwp45LTioVFa+eSSPJn7hXLlqj36Q4TiasB46IyJpnI6EAf3sOnU
	 MorPTkqW/fIsGXHG6ikqWGawvVcB68it4WlsT/OMLvKJWo5VooI6gdikmeHn3b5tz8h5I
	 /SUOeZbAayVRau6+E1ucGDOBoxUxs8N0kyZyilNTtmNeJkPfX6mYjQoGZs9wjErK6DakO
	 SNnAKoUXhJWfu8ym/V091Tu6+nOIuXwZV6MRmvZxAvQuFGzRTe5jS+ArMWCETOa4gAIfn
	 0xxQH1gArMVAVPiO2o8RjYczZYergVHgVuAoqFw1pK6ioOcWX9YsF5jw7yI6uBoPWqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwjFARZU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DE606A329;
	Mon,  2 Nov 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwjFARZU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0481F00A18;
	Mon,  2 Nov 2026 10:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614430;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwjFARZUCE8eW6izTeOI/rl0il0aZsDTXNrGpjJjdK962sfr0lFKQrCfoyKVXzV3S
	 g1PFchZ3qqfmzRLsLGEwNv6qmX0g+fo1kySKfq2z2shBfP3n6/RxVzYx8RIV3G3SFk
	 rwRkdX/k66Ysc0QXy9ML6zp41Yp2l0N2eczAKMOvrdj1wzgh8Yx5J0KZw1Tmt97EEY
	 otKF8eI+EQOJ5b0xLAbMCZHT/4N50vuO/Kq8X+VC8rg86NY/wR3HbHvg7b/eKY82eB
	 GiHJvoJhLm3KGEX0b8Nttd+y3Ub7kiP7i/0KlPEtR2ysmBRLSlfFEoFxejmO0wiyqQ
	 9dInnRAIhoVzA==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip reset
Date: Mon, 02 Nov 2026 10:13:49 +0000
Message-ID: <179361442917.3286.13140295265370118734@kernel.org>
In-Reply-To: <20261102101125.3523835-1-mmyangfl@gmail.com>
References: <20261102101125.3523835-1-mmyangfl@gmail.com>
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
