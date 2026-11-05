Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914640;
	b=PUizWjA/M6LhKGmI8gqdZlZx8KSUfc/PiVTC9BNiB8hQCbSAD3hlCyuLVDea1cyE+mmj
	 Fo0PbZK8g18JZDCLhGerxMkqX2fiuZ67WkSCwi5IhoRCKStWScYa7SgiE6R+pADDoxrXm
	 Pg9+Ahl0o56Z9oO1w6mg9mPqfRK3riW7M7eDxbTF5fJ1KZCF8yqnxR5p+cM9L7EnhCq8U
	 Z4bJ85gBoB8MxKePSPNFN8Scja6mZGYlSXNkYTgXw20unXciebLzLkvNAWuhf6An976mp
	 pBc8EAtQf7t23lXlJlj5SdefyiISnOgoRQc8+HlKS6VRHKeUFAb80E2alv2aaXsx4Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=qGvBItWGidTeMN+utGqj2MmZPM8jtzm0sVyI3KSJWMEkEBZwWgjgdYraLRCtbSbjCNd6
	 DcQIGl5uow7rW/TwUBMqaoc9J8YqFscxglkIRS4H5fKxdWNUxIW3HFzpkTY+aOX7M6Z4D
	 kRuKhTzYWsrICR86pOL0LdDFJcsxxlpx9H9EKd2ViBiXV7nBNhF3+oYI/iyFhF2xNA5oc
	 k1emgAQDbsSCetWh6ZnDWqVxvLRqcEZns3xOo2ijsajLeiWOJ023vWuTo7jXdyYR+vGFp
	 w/kvcxgcOwjhYnof0qKOyKztJeV0jtNAV3CmieB9X6d9cTrpj914Gw54Yt2T+g0ybDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNenvKka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30768606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNenvKka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F931F008A1;
	Thu,  5 Nov 2026 21:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914640;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bNenvKkacl8wU/EstLZb8Nz70CcOA9GAMCF99NaRjRk+3Blr6Trj1kAagkOhiPY4U
	 Q5OJajq2QOOULBJjxwibdR29V97Si1grq5iP21AS5Om/HItbkeU+bbgbjmhGzSJzmt
	 O6PLWyKx2crmfMl8Ic/MPsYeTBnuaVlSB3Q5i+UVI96ZU72DhC7TGzpAKhcNgYkCg/
	 obyo+0cHQMFDyZ/EZcRIVceR1Cor1P8XO04EITD50jkOVvEOVmS8nIpOM7CiUwewEt
	 AYziLJkLsWYHCK5h9UIkQ1IT2lUjmitdsXHlL9cYK9yo2oP2e/nEinM8+jwZFfNcWz
	 fgBUi/iA7n3iA==
From: netdev-bot+sinfo@kernel.org
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] net: Fix memory_allocated leak in
 __sk_mem_raise_allocated().
Date: Thu, 05 Nov 2026 21:37:19 +0000
Message-ID: <179391463924.488859.10033550397120765032@kernel.org>
In-Reply-To: <20261105212905.3122712-1-kuniyu@google.com>
References: <20261105212905.3122712-1-kuniyu@google.com>
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
