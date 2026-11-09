Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235918;
	b=AeTeWfErd2QaousAvPia6pD7qyKFhuhP8ZixVfJctxlLkBC2XB28jchC5EwnKWDfMgfb
	 E5kDzSp9xGCqK5+GTw7kQw9A3ZCjbpgOvslwwtnsaGO5VU5jZwsrHszO8WBZktSwsnLTf
	 4XTJe00JGyBjQlH/Z22O62pKGEK4rSaHfVh1ZzS2lzJYEYyZXIvPduQ6JG+ux2lxmRhxP
	 /cOx9MibXL6wfLySeNfJxwMpAQlmfZOAN7bjR47l20/Oio7Vin2jYXYW5Z8rBU2yWRu/3
	 mVCDv4wk2veTfrr07PlgDrwf2uHdVpVKB9lXgFBBYLCcWL70qcur/gQ3lGbzgJ43Jkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=rGrd/hrGcia93dmf9EZtQ2Oojui07mAiwcWdJ1ZzDeVCeHpVsNU0xB2TwWYdg2d8vokw
	 s7zajKLr0lSoQ8TL4P3yp3wnT/jVsUOHQAV93kBcMtOES20xxayzXqdXLREXDEsKAkJVh
	 G0vFw5DXicu4Au6VAAa2A/huxwYjplhZJO9Rw4ZGfmRbWVf92ucQ9XeBWbwC1m0HXLysG
	 ZXEfK8Dv3/a5UbIQDtyw+IjV/cMXghQfwBWGN/RfFRBbrz6Ems26I043HaFIsK6yzSVlD
	 e6k9+8ohDShNc4yG7QJE6tlzVKD5OQLIIakRYRUw2teKa10+ltpgXYrxCFFhcW8+4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKrE0e1C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C4606A337;
	Mon,  9 Nov 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKrE0e1C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E828F1F008A2;
	Mon,  9 Nov 2026 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235918;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKrE0e1CeSXvjwyDMVEiAoThWrUuGjGGwPvHqg3Bdiv//KaTNi8SgNsrgiv6zCwS6
	 Ip8UKIRyNhwkLocs1tLJIXRD4afSKXxwb6UmUKgevgOC6dks/0/cnJjX69QsYJCC7s
	 xw/2SKzao4fVeMKOWXbG7mVpGcSaDha4XpmQYeHIBl2IKL61BqadJUgAPS/QSRZ5Yv
	 vjTkOMKYd56DRO4+sSpqfwXKpHBWBMZlJRyJVmLM0pzQhXmyNhUwlUGANAwL8iGvGD
	 AnpJaDKT1aHMjZa8hRXI4TVVzUEjwvMPTHSRG9uJk8few+bXRlx1yVppqxSy5qqKNP
	 AO2YTO9uBmxFA==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Free the MIB block on
 port teardown
Date: Mon, 09 Nov 2026 14:51:57 +0000
Message-ID: <179423591750.488859.16025770326702158514@kernel.org>
In-Reply-To: <20261109144705.1737460-1-mmyangfl@gmail.com>
References: <20261109144705.1737460-1-mmyangfl@gmail.com>
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
