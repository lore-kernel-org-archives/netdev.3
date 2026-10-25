Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896645;
	b=5bsTRXmiAKveDa3qoUD7OlS+pcq1r2oVBINbTrW3CswXBc5aHvFl8XPRwi32dzybMrrE
	 uWdWYi2eqcW/rfdzyfSWmc2TfrxnhwT1urEErlFvmzGdboBacm0SiwGlg5WLioqhNsiiJ
	 ZIDIBNYckUsJWINeTGovbc/OGC9+qst/UIARcEVhPp9/V6NrsHKPTpYLOFEgBIifeJ0NY
	 NsvI84SJoRA01TrSDCiVToq+Z2vRE1h26lNNJBxDrqijaXRRsnAQ2C/vdB207y7TNOXk6
	 z6nlmREw3BK/CTJGIcd0rfnxEl9/Ysf/tsnUVl4G7Q4/qiyIGH4ZnOu80QaxqHUGsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=cs2CMViiq9bSxB6Itxomp/7DsAJ8wKDkr2U0T45Z1HL+67yBuDUxiXgnW1ltDGM8UdLg
	 twx93eaXZ4jxGbXbaXXek7j7rCqMbPfzaRBt9a5K8WNcZTNa8pVmcCrfmIh3ZgMB/Z2UY
	 jbAXX2V3UCiDt5LKqKwILBd6YkthKXaPOMP9+S6dm47+FOwALyBuTNVLv1Kfqv2/eSAnb
	 HFKNW8SEB0EJeugdnCDos3+NCkGjK3+Vpt0tLjt2ehqCgKjfqMyRlpk4r6qj7mCt0/YCV
	 1iIJe3+bEObLCRO61BJUwnkn3FJQ9kc5AdD4D8+Oe6YqcqjWLCgjMCNTyKrtW/kbm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEuUv254;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95402606A31A;
	Sun, 25 Oct 2026 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEuUv254
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37A31F01825;
	Sun, 25 Oct 2026 02:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792896645;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GEuUv254RxWiGvc1ZfA8OuASlp3VzmFho55zr6Z99JfC2yL/MdsXFtWDWp8UpeR97
	 j7YDUv7bm+wCB5kSHtucT2AzCdBtoKDY+yr5NHcHHL+MmbWhomszjw04j8DzFP881f
	 6tM8/MHtYJTGKL6T4motNvCaejoz/0eiBGnrak5a6I0ohYPiIaDzi1Avq+cCg44mEa
	 vuUebXY8tqAr+8vzNUkACtMvMcvPLqMI48S98mkMzYncr6XiLGsUGd9So3i3rDNcpI
	 F/Uo5krwZDWpNq9bvMFGWRODAeVJ1rfMlaAM/SCLn5ZochWizVzXPwYOLd7FImCo+o
	 mMQSm+oEadclw==
From: netdev-bot+sinfo@kernel.org
To: Daniel Palmer <daniel@0x0f.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Denis Ahrens <denis@h3q.com>
Subject: Re: [PATCH] net: i825xx: 82596: use MMIO accessors for the MVME16x
 PORT/CA registers
Date: Sun, 25 Oct 2026 02:50:44 +0000
Message-ID: <179289664421.3327.13269797237144711675@kernel.org>
In-Reply-To: <20261025024514.802862-1-daniel@0x0f.com>
References: <20261025024514.802862-1-daniel@0x0f.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
