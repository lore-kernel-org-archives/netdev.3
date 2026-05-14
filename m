Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EED3016F5;
	Thu, 14 May 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803036; cv=none; b=iT7+Dtcfm4jrNjzflpP1lZw3cLVyzon8vxOhj8t4oKwYjyOvyqt1uyUmQuPakCtHfJXlNIYh2T4gIH6L5fL2TaCivhDJbun+Im9Fy5AgMdDjeuQCOSQV0beOYWhbrw5hLLbOTmKq8vlMfm+BotEkX3ck5N9yPncfaRbvzmZ0NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803036; c=relaxed/simple;
	bh=RWTWIwqVzWQfpAUGzl/eLS/TxSSKAmFWkhFN91IfKCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwcxcSHxqSAKo6/8e94oexzrzLeKB8vU7HYqVQWQX5RTdlyIHYvb0E/GuAAaciqPt8h6EUuwkXckKU2fuKhhJihsNTTYS6virC2PlKtMHF9vuhrRph0TQPniFeAedgiVViv5KaxtwaMpHrirawz68Fo1hBFR89KbTh2i0DhGl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9E9NBPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9E9NBPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04302C2BCB3;
	Thu, 14 May 2026 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803036;
	bh=RWTWIwqVzWQfpAUGzl/eLS/TxSSKAmFWkhFN91IfKCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D9E9NBPg6StkIHoseBj6U2d7fSDfkF/XItVuTpwDb31G+TOpEXS17RKjSxhjDSuH1
	 RS/EOBgoNDgpX6thdkcCK8MrAH1d247Wfs5aAUeNKIxjgLTx8vrQ2YsncJdR0ELKW1
	 DiWXtXWTCuu/0H87bQYGC6DJ49JpdMYngSbnczublC+L67wglPnKkwQ1KTEuq1lqnl
	 dAV6kcNe97e95MnRd0aduso2hNW15HQUqe/o2ENF1M8DFks89O+u61tQbWVY97t/RE
	 EwTqIMjPZNkhAq/TdX5IIRWYMbdzFotYCHZf9fKVbUcZLbD9ieOeJQE57vpBarUUhd
	 ic0vPdl9RcyEg==
Date: Thu, 14 May 2026 16:57:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: netlink: warn on overwriting extack
 message
Message-ID: <20260514165715.3734df47@kernel.org>
In-Reply-To: <20260513143219.3327287-1-mmyangfl@gmail.com>
References: <20260513143219.3327287-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 22:32:16 +0800 David Yang wrote:
> When NL_SET_ERR_MSG is called more than once on the same extack, the
> existing message is silently overwritten. This is hard to detect via
> static analysis. Emit a rate-limited warning so these cases become
> visible.

I don't think this is worth the bloat.
There's only so much we can do for poorly written code.
-- 
pw-bot: reject
