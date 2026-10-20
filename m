Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456212;
	b=4qSHYwUWNcckd3cnG4YCsG53KifvsjU4AEkqvI4tg1O26nSm1wr8w2SntssYX3cERTJq
	 UFLmxTBc17LHBVLs+DuVE4EN088Ecqqfui7/czHz6tXZi1+A/YH6jjElCd/SJK1J5yavJ
	 vzvZzmRKOl5vEIbA52xFpzcGObm/R20FQTzKagm4fHm+S/sGVYMfi2hmQbCWXBhW4uGyv
	 fPluG0ESbxlvufOHrKRRp+bUCO5Wz99gyEwzaBrcOmva8c3UwREvHaapvSKC6evtPRNDf
	 CuT938VDlX+tS97PGTYCzuD65eSXjdJSpGLv7ryCFJJa8LpfJcVkBUiywz6p/SSveow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=k1hBglOV25iU0A9+/duOkWayb6c59Vgm5HHAa0OP7DWs1AwxvTiTRjQF/U1ZWbghbaoI
	 XEMEacZSRLaFsuagxJiWKtri/A77G0wG19xmGsuguv77ccgPBDSL2Qo60I/NnZdN7++z3
	 YY4V4IY9ed0ufRFan/gdeIbihfw4D0y/f6w99IzyK+aeJIkklPBEHeWaFbanqZ1pLZoVQ
	 NWMHj8ncLkObJVzFvd+HqHFamZxPFESd5AvOEDpMD1b/vy4v0Y/VXWX9QfwPf0UOOv/UC
	 UEn2HHOheqcpyKGXxvQYgO6LPdRLR17hjUMu9o/LujJarIIchXIu6Q5baadrgJMAYBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPlFtxU3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FB606A31D;
	Tue, 20 Oct 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPlFtxU3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0151F000C4;
	Tue, 20 Oct 2026 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792456211;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPlFtxU39KdcImvC4QnL8KWmpgIUxiP/vl8Z5o15vV575NbjBnWlwfLVy9V2ehoSg
	 3Zxyi/KL8X/TQ2mntPVHLXSfCtlBJ8uyPRWhrdsrKJOPMfWNqMSKhkjL4MHNGw5cyJ
	 7wdUZKHgS51mx2dSvVdlSQkVw69F+2CgKEsvJzC7gQ683jkqt7X6q1bjy12oOCgszi
	 dJ4hOXNgYJGrCT0zzbPFh0qLFPgKWY7uDYLDiIsb0fR7uLLcrCyL3f6/6hXPMuEyrQ
	 8R/39SLvoe5rPYF1bIX5saD+DI5QthiwOaGeuPa+xxwHaTVXUNPGWvJjIr+ZWrQyQ6
	 bskxKjsgRgB2A==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and
 request-path hardening
Date: Tue, 20 Oct 2026 00:30:10 +0000
Message-ID: <179245621074.3290.4127113725002865428@kernel.org>
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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
