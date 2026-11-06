Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955105;
	b=CCihqf8job2PKBozgwilYba3Ko7hl6417aCY1Mu1f9T5XKwzhfXVsgnAW/Fj6cftvkIA
	 +Cw9yCNOnSSjwLkwRhBtP6e7OkwC48sXKP0YtNoMpcmIiRxbZNU9Jl8yqFj+GZbRFFUtV
	 /CPnu+h4hCDPSKcfTd9hxVPU+/sxtcfIjOHLUHC71dG3iGM9M+t0E9Bcr23UGhvSTJBbA
	 gzeYhhZHoh8yhHCHjkQmfN07NjpF18RY0PNksdXPU6xWypWILTPcPlrJXlj4nsTfrrYVo
	 AFPecktK4fmLmBDeNPqaMcwyAllqU3UtvQCq+t/6MtOJGm35/Rvpfj8wT8qX0PHC6Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955105;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=1USpPJLgupCojsqdnyuirVo+K8hW8Qt52xr1uO9HQCVrTYHedIaj70zNAHrsJNUL3c16
	 0wO2AYmkhMvy8Zfw4oVQE85ghuVUy/gAe/cKMKclpN+4g8pW97BNdCY86km1uHNNtHO6J
	 rFHI9CMVWxAFM5FljcWur5gGNu/fCbc/k28UGmS3QOAIC+mUpI94BhckMJZeyc15m0xyi
	 5WwwGPW7kl2s81ZHCBpb2x3lgOt/hAon9xkDgbTUHCmjuVm0Wl7PtCjh6NzQZGUboBNmP
	 +G7vNBLcIPn2tcA2CScStBnATHet0/lBu9cedL5MIeiIx+HjQtbQi5kegTwjg0b30/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3d4leIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9749606A326;
	Fri,  6 Nov 2026 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3d4leIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C495A1F0089F;
	Fri,  6 Nov 2026 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955104;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3d4leIAu6OtGVBhonwjduoCUCV5DWrR6Sm5GZ396UR+TB0JOmYmt0dcZnrpcYAZv
	 E+hcHDzkbvLxs1cMNUXOjDGvXj0eVAD95mbfAwOr05A7oWUqnaCvlmRnXBDE9Ae+Jl
	 3MwmwYsDwx4weeM/r3UGNu59UAPfvf4TswR6tlmJeYE/so9QJq+rSpZjlDD3/0Ar2G
	 WphvXbrfuXqIYn7zBGV/3IVX3aXWzWzqLqx59zedsNi3IFYQ1kD8dAT0lGZan6umsD
	 A7Hfr9idYHX0U+eK3fLHx7NnWRcfGkV0NsjVKSMUjxuDx/EPlaoH3mtr82f9qAvG82
	 /7ZJCoCvn+TYA==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: Re: [PATCH net-next] net: dsa: hellcreek: fix device_node leak in
 hellcreek_led_setup()
Date: Fri, 06 Nov 2026 08:51:43 +0000
Message-ID: <179395510331.488859.15134331933976267509@kernel.org>
In-Reply-To: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
References: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
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
