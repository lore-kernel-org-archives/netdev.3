Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358655C31A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997857; cv=none; b=aUjekTaNq+tL+OStHLZMzfOcCGFH2sUvFuyMgAY8+B7seh6mRwzN/WYeKfvkCCqVtb5sO1T+9pE7dcC7/JBvQmqa+MCy73arNN1rWXvyyE82diMNiP9ZPXXDZjc5PpX/VT6k3gevJpru+AHKeUmZSShxCcOtP37H2BajDk9HshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997857; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVdLUiPD7BA3fHQ8E5AW6BKcqwb+afKSyID5i/pF1nHjs3ngGqLlkwsJf59bUdo+o/qHKy35xiP27nK28gj0wKBOboco7/SjuyB1TYNCCOfKKkf9wZnXlNL/uWfHTMkRYZ7E0kA9B5FGiwkbRitszdGpSacrZ7ivtemX2M56Gok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCieCQPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCieCQPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8936E1F000C4;
	Wed, 14 Oct 2026 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791997856;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCieCQPPa65jCX+rXGrTb4TiOxR3NUi5/8zZdVWB4ipf0tHWTsQqSfwFeEbMAYq35
	 3oyvmHa3sYXEKJo/34kiFubCwwumnn4FRI4f1w/wvK7ue7icWThbs3j5ak4X545pII
	 zpSGezaKsA/dwKIl5t0e1Q5oX2zuwK+niWxWLnHV15r3tGkjsdOfwVVeHNrk1p3W6q
	 4Y35VHcPA9m/X1WY3Yy4SBtHOu3cD22oFb2I0vsQ/OltiANzzxs5TZZdN69xXf9UkL
	 mc/MNWWrHvjpYYkZw8abphKKOfY971jTS+82SH5j/u3U8PrrwTcWf9FNmZUqKv78qk
	 PxCbrSXNCyV6Q==
From: netdev-bot+sinfo@kernel.org
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@kernel.org, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top
Subject: Re: [PATCH net v9 0/3] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Wed, 14 Oct 2026 17:10:55 +0000
Message-ID: <179199785507.408196.211098055550383602@kernel.org>
In-Reply-To: <cover.1791994057.git.zihanx@nebusec.ai>
References: <cover.1791994057.git.zihanx@nebusec.ai>
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
