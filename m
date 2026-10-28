Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207740;
	b=L4B2iuODqHgAjh+n9amcLpkjjJNIjPMvCQ4wq2e4J8zMusgs/0Y15fJutGo0WplfWqIg
	 BfBTsXyZjtgZx6s/SLVjURnB9RxjRiRvrsmZlIx8gXz5Vl30PWRkO6y+FC/OvNT57JR2m
	 eRC/OMQRnd+M8omCgP2TzsC/TQi96cREMq7U1DYJNbINcNxc74f7ZX2ptXVAiJXHNZiv8
	 UGHKfTNfIhKcYJ/BEPACZBUQZXYxLwW3UYHJQeRagq1mKaE3K1uh/7fkE6emyd3xodzXx
	 NXh7qjVO/GBALIobyC6/hAr8+v9QcML9hKkyMG8Y37AG2im6E9PflXNadHg82ZkyW2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=YYqQfQiajN7GoJg3GnxXEpgOiZZjX7HmtBfHmHxk+qQsMTCY3WbgZwHyT84ILcFmFRiS
	 bkMiHlzdQNXwuQ7gUxLHYIumDJ+UWPfAjNMtrzaS/zssljL2cLdqEwwHkPBzT6MQXfhTL
	 BhzfzkMG8oMmL/OIlO7H2U88GXDWJA7FhIBgbni/jpAJdszrBAuAqjVWvKbx9vEd32uqm
	 x58U3TuPG6pUgXebeCwhf6QlFnac8kO9hCwyj2rHSmFDfoRbOLPK/ddmFgEtEG6c9N9wI
	 OpO5oyKkscMtV3JhAXbeJfMV7x6EyiGmq8jDa3vJ/1IYCmZHyxue25uE+2EQLqEAx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GY+IK/mY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB2606A327
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GY+IK/mY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68391F01829;
	Wed, 28 Oct 2026 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207740;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GY+IK/mYxpcafkjr2pyBPBBRjPz5NZZrVMawoEiiiTRPkqeLaGmrDU2Z+LDBryFLc
	 HfX7Nl3K6H79qzv9O7Vb9o5cjOfW4V7AumakgNw1wgjDLvsmQc9oeBqnEoeAzFlVUK
	 EEh7S1GzllONfLzeGWiIwjbroH5rYYc8oJwD4/XRDFlMdsz4VkIG/3jtabqvEgeNa/
	 MMWITuZwyznDSS1tIC0tUwdRuZpCqaZtuQ7tQhoEvX4qHs93wkFhbG5ZXrx2MK19Kt
	 oAJAQ7MHEhURY21VAFLMwDNexhaF65TDUnxJOLPapS8n+o5K0a72vdfdbaJXJ887En
	 2Z9CPI3xa8KUA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net] gro: do not GRO GSO packets with inconsistent payload
Date: Wed, 28 Oct 2026 17:15:39 +0000
Message-ID: <179320773925.3327.6864413383684087920@kernel.org>
In-Reply-To: <20261028171350.2205175-1-edumazet@kernel.org>
References: <20261028171350.2205175-1-edumazet@kernel.org>
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
