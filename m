Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214706;
	b=YPs0BET1XHGxqAp7DjyAX+qjocB43zF8VHjOtmWDupzf3bD7czgtWIOQplEAq+Y7inq5
	 334md1B+VWGhyWTyzqEA4b6v4zm/IZSkgOtELsnh6Manq5ltWBR3hokWCskc9qyg8i0Cy
	 smVstv/UA7Eoi0Ay4AwuwsEEamGLPLAV+AW/0mIC00U23VkIQAU1wyXZxEHvXDn2AJkqA
	 0hqifD8BLl5bSAEIPYQFaJf7c8TXkwctVpU97aWq3+Aj6WXoUrTgInVH/T7Q/WHNp/0r9
	 hn9Ijp+j9cYwjxipOfXTMvdTqOM3FYHC6Ue4ccrr8owLPsV7ZNw38FLqsw56eqvW/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=PecuHkPy/BskxqIvmHmfDOrA6qqbFt0RAmMpgkm8YC9aSpB2E32lmbLvcI8KumUV64I/
	 vWzYTJNeAkrFICb2wor1tJG6yNOleEcDTCCUXmy5PNdsNts4JjC6aEXsxieMEcZSD0m34
	 rn+QSZkmRXoShoP6nvmLm0zlqBxNRr8Uc0AnJ9iYdtl42t3P4CPVtV4jqiLJFAEhhq9Ms
	 QuiFrDKBPH55bojQLoY4gi+xLehy9uY5noKzc51idAo1htUYtSx4vFU4IGE48eRdUQbzp
	 IDREb3x27WJG0njRMJcgArYVXrjXR7YN9vbAoKqCx3kNqnTlUeyMSczsvAQv8G/yccQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFgbM5JB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA0606BFA2;
	Wed, 28 Oct 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFgbM5JB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369481F01825;
	Wed, 28 Oct 2026 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214705;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gFgbM5JBJNm58X5FVXR4kAxidNrhrgcIGwITuz0sjEhtXqcH2uwtYivKICnsfKk23
	 mUJeZolreTPNDVgqEVD8NFhmLzGrXBm8Nr2mzndNYiMHOKXzJm13F++Nx6kZkPJUFX
	 WBzqY9EySCALQiYyYCMXRG/OonwVnsY+gr9QcgQbKclJJx3/DQ+t7r2CFqpRcaflPK
	 UqFGv3ZHDmbZN175W3mkphcJHm3CX1wIClfb5etOvS1I/vdElMextVRM/wKUa/Tqqt
	 MrHk+pFjyVffj0sIaF2zRAAxf0ga/sUXrX/lABkZE+u9UZhkMZc+sJztRc9VPI3oQZ
	 4tVMlOqmtA/MA==
From: netdev-bot+sinfo@kernel.org
To: Octavian Purdila <tavip@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] tcp: do not let tcp_collapse() drive
 sk_forward_alloc negative
Date: Wed, 28 Oct 2026 19:11:44 +0000
Message-ID: <179321470477.3327.2849472044719813166@kernel.org>
In-Reply-To: <20261028190820.2917252-1-tavip@google.com>
References: <20261028190820.2917252-1-tavip@google.com>
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
