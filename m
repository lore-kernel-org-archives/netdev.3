Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666041;
	b=WQJ0APATiX6nleashNo+v/a3GE4IHswLAu9D5PvyiHiWPF/YhHDDStC6pUyRHnkZHofW
	 9xWQJdtBadCK4h1AX3CE+zqUst2QycJe1fwH+DAN/HWyBeP8j1FDz9D9w3JGFyCD6TBM6
	 Ps/wBVXzceba5Gi6Ibynh3fQTdy+ZUMG5FgWLio8nUDd4NdpVbS+uk9VPD0RbBcvNyDkG
	 O5kyvoIY+b3WF7hgIFh3UVeWpnTzsuIw9d+HHeuFAgZ7jSS0unZ6VwKo7mHGxLYTMsBwH
	 CG6w4/eBI7OF92tREMp5gz0vWQ5MuBE3kvzwvDzwWv2vCIEdjkvZ4gxjB5PTaxFsBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=DbQBlTu+57OoY+5wJbIdCiFCnmP6urNtPyXAL05TVnnzcFVHX7mT6mjkTqqR3nwAL7YZ
	 /OaXat5nh92+14hfJtc9hTwGiO5jIT/QAEiI6XCg+naOnVrXITG785ke4I0WaQQp7MKQp
	 tcxJ7ClU3z6XdJKzdNNS4+YR20rlNp2ZNz9E0bcLFL2YvUre/9OiJUAbswprwtD5zBE3r
	 CdhGqqVehAsZNZ1h0fLBvwQ5jNyhtlqsBWMhsWRmllmaRiLDd1fRD/iYi6a5BVfnBQir7
	 sz+YzLWy2XQ5woYlDK7lZkunhtcAOhKpPG6OMcrgmUTTPQwFnZUjqKdgXbs7QnruAdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFZbHdfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E5606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFZbHdfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE091F000C3;
	Thu, 22 Oct 2026 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792666040;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFZbHdfvgigGQnNn+tj4kZJenUQAHnAnHWSBvNzSU1D/+ZG3qTRM6N8vP1SlpsGkm
	 xTaf4xFvOi5vF0tBY6Ozrf1OWqEpma8oJP4jg7u23tnUBHibUvE4vXJUT9kAy3AP4o
	 S30ICcwJSpqyYQshZMrOYhniiieEtjt3nVXOASYDsxegkPTwfoLgl++q/2MC0dutF4
	 ZcJEza9ZN3wLkwBpfw1eJwU4E+NwthFO8S71zxEI88dsalqfrzSrFhtA09f27sUjVg
	 I0UW3h6vLMzvD7s07i0ELHuO1MeXSbeJBHaeAJt/Jr4G6yKrxmPvgOxBNUYMgQLuCi
	 dJ5PkhMpMYm5g==
From: netdev-bot+sinfo@kernel.org
To: Zizhen Liu <pointerliu@126.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 net] net: skbuff: propagate shared-frag marker in
 skb_zerocopy()
Date: Thu, 22 Oct 2026 10:47:19 +0000
Message-ID: <179266603967.3290.10967918397860377995@kernel.org>
In-Reply-To: <20261022104217.1852191-1-pointerliu@126.com>
References: <20261022104217.1852191-1-pointerliu@126.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
