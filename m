Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9E38E8B9;
	Wed, 30 Sep 2026 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746189; cv=none; b=pGX+24vrhZkPvA+IL7kFleoYXbuIlVG/N3C3vzXBmYgcT3JRULzSORBcJAoKwfmL8lTGk4MAUUmIIojdqTH0Z7nnl/zQXoObME4EQaQA8+OVuoCBfPv5aBo7sCJ54HfPb6UcNg6UYirwrX9DVaDBZ7dCmeczd63FFb+Lxx04g/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746189; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mdkdl2BUslvAG24NX4SdEhMLG2LXKmBeGtvnyFJk+3fjtH+uRY+Khzb+cuw20mZdBv+VjTmsdjOjvzIBHAhQys0gbAqGZG+N0RMTkpUQefWygUxAe8iVQy4qhQEUiM8OWzgMsJtd1XFkQ1weA2j0Ru25lOyx0ZZuSYXhn5OsTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOA6Z4XL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOA6Z4XL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80301F000FF;
	Wed, 30 Sep 2026 05:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790746188;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bOA6Z4XLo/6IA/I72fE+Kl+LGr09jw+BBPCh2Xv+aeVKemLzFEKnouMbFygPWqPL4
	 ji7GmVBwTcKE07l8TtbMRI0uCcC01k5hPuwdVPvd37oktAMxkvyO3jqpy8W09A4ddK
	 TFAX3rPDLSEgEhZQspiLiYghfzkxG1jRo1FLdGwHXmfgBg08RDljo4HjS4rK3w3Lcg
	 VIsxvXVXVUijLf/jXhKdZU75tfbfMsZNPHikNA41j63n4cNRpc9DupgljBBIA3xYwp
	 dnqfjN+K5pxUfhRiA05JsyB4+Ay2NRtm9gyZXRyq3DupTu1VS4SOwbPeCiJsBxE1kK
	 t3t90P4ETk6bg==
From: netdev-bot+sinfo@kernel.org
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Dave Watson <davejwatson@fb.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Date: Wed, 30 Sep 2026 05:29:47 +0000
Message-ID: <179074618718.31693.10040628020266132112@kernel.org>
In-Reply-To: <20260930052636.166007-1-qingfang.deng@linux.dev>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
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
