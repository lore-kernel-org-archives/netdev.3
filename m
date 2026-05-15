Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440883EC2FF;
	Fri, 15 May 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885467; cv=none; b=eywDvajSpe0thGN4g5Zpo6evAxcYNexMfAZ2TYUaTlei4PyHzr0OJhtJQRvdCpsCHD6W8N0P43mK9hqW78HiVyu438edoghnWA1TdH4PuJwcKuooIqgko0OXpd+/v/KFEUL+zuNSYDhtYtfLC1231//YVrvJWi7TSJjPDdkM4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885467; c=relaxed/simple;
	bh=wVfO0gE3m0UYUZcGPsl3M/Uxe7YMqqLtXybLl9PHyYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7dSzyPRaVzStcrVFZNQ1dEIR5T4iWSmS4NqEHvmZGEV5QXhtb6yjTcgAHPvNr4fEDoQtF5hiAdtqMdaQkZn6SroUBWIo2H6aPjKNeBiienOU/V5/WuaHVjFBjsgpQlxAhFv2YLQfGnpoJwseZBdGjHDyFAHjsTAa6WdBdYTsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncLKCtDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncLKCtDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A87C2BCB0;
	Fri, 15 May 2026 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778885466;
	bh=wVfO0gE3m0UYUZcGPsl3M/Uxe7YMqqLtXybLl9PHyYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncLKCtDLSB5osBKxm3z+Zqp9EOVWa/LSmory/5sDfCL003KNloJgSiZ/eLYV3iBOc
	 kkJxNgZvGG7AuDBD6rmT5+AcTXikHQ38B6tllyNYtVUt3N1fGDhEcRy6c/bWeQvaP2
	 g1qPY/U+/e8rE0zxfiWE0WYcA0n9NJ5PmpN8LJuuqX5h+q0zoAdLr4BhzSDknivhyY
	 IaCwnsUE/0FIsnHA9pRpOEYcaPNInIQCCqUFVA3hP4R6ZSCxp55vL3XyxyjrgiaqCx
	 k0quJM/II0YRZEEd16E2KvzmIxgs/4almk16xjwemE2Dw5htzJs1vQVmMqfggOpKdp
	 i3mOI3O+6XOWA==
Date: Fri, 15 May 2026 15:51:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Shabanov <mail@etehtsea.me>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: netlink: Correct buffer sizing info
Message-ID: <20260515155105.77ce437a@kernel.org>
In-Reply-To: <20260515155741.25082-1-mail@etehtsea.me>
References: <20260512172757.10c43c86@kernel.org>
	<20260515155741.25082-1-mail@etehtsea.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 22:57:41 +0700 Konstantin Shabanov wrote:
> The problem is that according to the comment, kernel isn't going to send
> more than 8K in a single reply and the documentation is currently recommends the opposite:
> to create _at least_ 8K buffer what looks excessive.

Got it.
