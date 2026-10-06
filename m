Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CA191F91;
	Tue,  6 Oct 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293745; cv=none; b=EqSati5F8NC6dAol0dw0a45c28aiLQy4Nk/HuXeIUf5ddFyzjcSPOg5mKPGkwo1mgbrau5d9xKUVlqmrPr8A6XAXNb0apboqGAt/gII289AV4yUBgne0vUJbTSeFAK7/GcMuBs3ILJyvwZHe+SHs0eWUaK/CMLSnXVkD4NdS4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293745; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWK4WXx5WtgSZ2r7Vdze6COnMcv0xfNMEcHWv1YRr0ZUO1jv6SSWzl4grZ/Wf8cAn8jrsfk9LJObWPLsg6glrDg5YRZrmXBPYvEYonVIwHLJZL2Y8//GdLfpJlN3E3jXcsANaIzkejCjI0415xL6v1kKjV9KNBVN9VCiPWBDL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkXPzmBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkXPzmBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F9E1F000FF;
	Tue,  6 Oct 2026 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791293744;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MkXPzmBm+Z/97ibzGKKISNMdyCrgkRyOS1mMO0o9+3ZyjTonFhxC4Ogmb0RkLktXX
	 K2FD2/Hl+g4UyooXclyXwo7Pi05vdginuWJlrWTtfBwNZaAI1ErPdNoIPjlmR+a6Bn
	 eAOD8yQL9TYV2hWgVwtdE2VaF3j5tCJntQcbofzFz4CAfvkO2qnMIbzAf6sY9KqZwb
	 LTpWjZYSVoUR53XRk+zbV85eB7s7wAfO3ssnZnGQAhYhM39HNRbETKJEAHu/Zp6bF7
	 YWRzFncOhuq+5//lRTY9meuZPpmkVVoZTsX9zPKwAhZOenLvA98VHqvnoKqZZpqbx2
	 Ogi5OThoP9msA==
From: netdev-bot+sinfo@kernel.org
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v12 00/15] rxrpc: Miscellaneous fixes
Date: Tue, 06 Oct 2026 13:35:43 +0000
Message-ID: <179129374309.2231598.633452204540998363@kernel.org>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
References: <20261006133011.531806-1-dhowells@redhat.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
