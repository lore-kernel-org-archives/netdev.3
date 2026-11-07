Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054083;
	b=NGmbuHgiKpgDkWcBeshFfF21v79eF5KducljqU7UECXqYfXGw5SW36+D4v3WWaq30qPp
	 28eSCvKuKh3tDkBI2xweLdlYElWzlZEObwxUyIHVAYtFipje072wSDFOJMKVn1a6v+Oha
	 DmQyKmPYuDX3G1SXfGQVSCoyUTN7M7My/owzh42AxT7mBUubf1xomHPxpaJ0ynieEWcKf
	 N8CV/jjFuIMg2cgEK92dTMPYb/rZF3E26UNUpgshBcmRDCS1jpExSGzK+DfOHTBljMQ/N
	 MATWnfkQemSF+wZGoxhJFrvkalQnCJZmpIm0650cfe0J76eif0LtPnfVJrSGj4YP2Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054083;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=ehmfhPz8eKtRUisB/N5lRZRKaBRlr7F+hoMe1jtgY7i1o6sa/hxfRVJgc7OkXlJBQNsU
	 p+wAXSfaYWLU8A5iW0L56oeYpqvNK9PTcHAEUZb+nuty7SBzwKUfOoJ6EHqTpQFa4W21/
	 Yvjs4++uESxgeOEFSPBUJmDGGumIyAwBy3p3iCoH1R8iOmylhvAqPtFrm2409aS1YWuTV
	 JXjmcIdMNkLa0DQpm2ufGbsxLHp8fuauJZzGJZtpq9zPf5VSbKpsxycHNlizRIg+CvJxK
	 HDP1yBpAFtCaYbQiepOAgsisvpI2AZ/n5cKePcLFTzDKhtwxr6sf7rFNVamZGQ50DEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfJ2MXdA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B0606A326;
	Sat,  7 Nov 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfJ2MXdA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F31F0089F;
	Sat,  7 Nov 2026 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054082;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfJ2MXdAmkr/YDY5MD8OpzZVCBwYNIgZHZEb62dEcqTlqLfxvR1IFhxyK1mcEig20
	 4PG2gCOwtpN/KNDVKoUw6gdBAb+jx2utw8+SFF863wd0DzG5AfZ19EZhSc9wDuOe5t
	 q4a8s/mvfujHqoXJI7wmXrvHXsDLdOoKa1q9jjvZPPUFF6OvN9O8wzbeSbnYzCR7ce
	 C4nxunXj0GEVrQD04ZhhUCMzFKoNlvwANfKt2RDZQOTTMchWz9YmiptSCVQQu8kd8Q
	 cTeUbuF5xV7mtwJLncA4D9xtFrTg3EHrSCiksiU+k/Uu/x/fdISgx9nlRNizuqWkpi
	 dVDWN+jdqq7iA==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] net: dsa: motorcomm: Add BR_FLOOD and
 BR_MCAST_FLOOD support
Date: Sat, 07 Nov 2026 12:21:21 +0000
Message-ID: <179405408165.488859.13345893308369940626@kernel.org>
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
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
