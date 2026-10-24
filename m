Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792811120;
	b=Tq/kObyo9LjjEdaia5ObYpgIQZH3VjsqXVXIMCW5nm91GW3qNYOtwbPpLGVHnw82oHwP
	 /zaQVvQdAXAFcs+Ku79ScaoyJTQSOMkHUrzI35vLPBfl83QZdWLbGzc5RTRdVlJXjRSQI
	 HkyKCPgeFmaGYK3KlR5dG+wOlu/zYO71RprCy4tJDr5Kw9aK6z0ALrdWttGuKa/S25Ydv
	 gifLggbWeazyfVp9jMY7F9Nng1ZsEDrO8ibi5q5OD1cD53wTKqX+BDFKMz+hA1eHW4ypd
	 Fv0eQCY4RCmP5fZaPNJJ9+dyLMbHmqgg2/glD+eevrjWnWw38r2V6Y0NSh6VGHqVMpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=1pecJEH//ddcMItCizBFAjcdAHfJsd3AZTd1U94rZJuxRunWk06b8gsSBFxrv0wyvK2n
	 snbteJAKrHMqqGq7QrGiqWfaka6yYfjxhs0p66xVzrsJH4RK+L5j5+x7n48IB54cFA5sU
	 opPxYkIRzGFv0FqFq+cJJ5O4KrYrwJ+YlxXjbu1zm+Qsn3gVJMVvaRGpVy0Q2vlFxzjxP
	 YUxRNvpCaqBMmDmGNNPaAHp3+pBnpWLxyqvDP61mylzS8gXXOXPje2rrs/XnZKJUDy0Kv
	 yb6I6kYzh5Q33f3nuNpWYiesVIy3KUY5njypOiAJ6NaphNoJ49qGmAMYvgxbrWfFGkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTGlhHVG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC55606A31A;
	Sat, 24 Oct 2026 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTGlhHVG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710531F01825;
	Sat, 24 Oct 2026 03:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792811120;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTGlhHVGc5IvkCPW0jTqNxXh+Y0Eft1b+yifmAHZks70nR7khcSzeXFodNKyitghd
	 euXuiSx8KtZW2Kv214fhk2NWZexnYI3Bpi6uphfUUQMh06mnMXod6szM8dhfwWmzH6
	 O96m44CtxQt51ovfE0uh2lXl65GdzFEEbzzgzBF7rDsqM54a3LA3JfS3dko+2MXepO
	 DdVkegeBNHT+s63vynUCSSQ9eq6K4ckNgLaWt1nmswT3SbJU4uFh/GcIY7G2cM9+w1
	 0PUV3DBQ7udFmXIeuUEACbHKZfsFSh9wgod5FZvqflG3z+1oXSlGrtqx8suS7errzj
	 9HK0skaNGzjRw==
From: netdev-bot+sinfo@kernel.org
To: Mina Almasry <almasrymina@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
Date: Sat, 24 Oct 2026 03:05:18 +0000
Message-ID: <179281111897.3327.1602182931669010390@kernel.org>
In-Reply-To: <20261024030401.852598-1-almasrymina@google.com>
References: <20261024030401.852598-1-almasrymina@google.com>
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
