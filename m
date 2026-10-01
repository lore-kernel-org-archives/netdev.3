Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EEF31B101;
	Thu,  1 Oct 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854410; cv=none; b=oFieSvLiyiw8yHZ1QkgGZxgNmyp0DGJSoBtrMTvEy8LH/LCLIpIJrzRiqQHA9aS1hShD7z1oD9SNyHesh1MkSojaqd3SaDcKTtIiLoP79E3WGNdNriAm8PIewdFv3kfOFSf9htSftSnvkqos4vpO4xcgKKw++g0d5WHic0kAfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854410; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0pq8lCWqWHd1dWSjtk9g/uxRiiVYH/5YAE9iStBKZazXyZJmeDIyKid76o9gX6CCx5ZQtFCfeRNzXoEV645gawpNSqqsh8SCBAKAuYfeatWBrz4dsmc+TvmibfUqq7F+7DnPRIDNt+pnmHxJmPHZuXG/VfFqz0JJMo943LS9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usm6GZD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usm6GZD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D91F000FF;
	Thu,  1 Oct 2026 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790854407;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Usm6GZD249ToSowYQhSmMxNwHAv2rPOg7oM8032ZY/GtmUcTBMrnHev5/Ih8PzexT
	 QJEPeAp4AY/cnYf1xlLXAEf5Tc8jiumX7SVNKaLmImarQVhjN2I5EExYcotMeCTbEk
	 dfYYcB6OQXF1304q434r8JYybEgbPlDr7QMWw7yxzM9hFriDq4cS/bg+RCquvMCLsl
	 FeoFvJyJ0/mpH/ZzKPUvpe3vVWxC6NxM/GXumhW0UI2gSjLf958OPf9nhgbmvg3Bet
	 IegQNkKBzZmXBq/YzVxUgdtVG9caz1PT5l9k9yS9e27sbo9y5uSeoY/aJChSYCJcw8
	 KIjlwtH9+xG0g==
From: netdev-bot+sinfo@kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] tcp: fix a few divide-by-zero in
 congestion control modules
Date: Thu, 01 Oct 2026 11:33:26 +0000
Message-ID: <179085440669.31693.6891704382706969220@kernel.org>
In-Reply-To: <20261001112948.322463-1-jiayuan.chen@linux.dev>
References: <20261001112948.322463-1-jiayuan.chen@linux.dev>
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
