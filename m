Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390771;
	b=RFjqgipuLsh+AExWgQjJRUxz6vgi0qbHQ1LHzxVdRoTr7a8bzsW5fiRBTNl+z9vsVzBq
	 LaaAMK+bMRhxji0AHcKyL68GuuhinfeeZ6EOcPHWK7on/eIPsz70AYYj7xKaId0UiSQXk
	 f9X7gPeJChJJMEeBKuk9DxyIMfxW9nS0Ta/qLr02Mf49XKDr0u2JzqsHH6wR2DhLBDsPv
	 gWpfmtSWzbCKTQoSHBMyFQBycd5AG5Vtc9jfpHfKz43J3LCEF6B9oA6D1A5K43ljm+gMn
	 yuUjdB4DYfy/s36/fTVXwabToXGnHMxFDlFWWUNGhneSKv6raoBzQg7E7ttIhTb2pQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=aqPfdDdmlR4ILskD9k+9pUOtPQB61uXNpk77Mv0fUXMj8iE3XMxS3kvMiMmRgyI8wKJp
	 GHLDZZw2qY+WSpqxZsfSd6QB0DJIkDjbgABSyN69V9KP7Z9Huz26v16kKNRrS2WRVVFA+
	 9NqpLy7JuH55wOAs8Ez7g7iHxkxqS+4cY755mnZNnZKT9AQbIdmHg5FNAXxRevQt6i6Gr
	 OO18eOhafGFDOEG4A5NHqBvH9AG2+RCl2R+DQYBDSFSmsxQTq5eLvNhVcLkr5i5vniPho
	 wILxfgvJ+iOAlvhUuW7qYVFhKCy73OnS1trf7JMrVrrHnJUhieYwg5vQJvpkRI4GVPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SI9YyrIa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F3606A334;
	Wed, 11 Nov 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SI9YyrIa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BE1F00A05;
	Wed, 11 Nov 2026 09:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794390771;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SI9YyrIayg09cMZv4qS34siWYyRGhBFEgPvahAzAYdXWfP0ozk/WdiRjdAqRyEFAo
	 QnRgtUDD98g9wMH9rSblz5CuvXOveJbPybGlJByBFpxF+/DB3mE1VV3XYP3kh/JUBa
	 n34oZXVz7y5ecj23eD9UOTw52unS9Au+xfgIm2+9HzlJXut0GMjNpmWRo8I0syQZPJ
	 nxb1bYkjlQoZmdRMW9e3S+GCpaYwDRnlkzrbujQN2MKU1bA+Bae/5yQIT4w2hCt83w
	 S7Hl3VVLGC5XSge1fl8TGLQw0uNWZulKsZWif6PNdOw7tHbw+dEsOz2xZyHRo2xan2
	 iYBlctMyKHrOw==
From: netdev-bot+sinfo@kernel.org
To: Jun Yao <yaojun8558363@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, dsahern@kernel.org,
 idosch@nvidia.com
Subject: 
 Re: [PATCH] xfrm: avoid stale tunnel pointers in deferred input callbacks
Date: Wed, 11 Nov 2026 09:52:49 +0000
Message-ID: <179439076995.2168702.457988164849465854@kernel.org>
In-Reply-To: <20261111094629.230568-1-yaojun8558363@gmail.com>
References: <20261111094629.230568-1-yaojun8558363@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
