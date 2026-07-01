Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13EEEB3;
	Wed,  1 Jul 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864993; cv=none; b=LJFZNDn+D4DSimxzKmSDVBG7mRXmiR8lXlHsYQmaDwOO9xCN6cnX1vyuZkGifH89HW4O+k0Fk/B0yp1gCVz5FaCykix82Qy03g+uibo5IzPW8YaAK95w+XSAVChiVow7AARWZh8Wamc9ge0bczBGL7MpFbpt463D5hueeplkvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864993; c=relaxed/simple;
	bh=T4uwGTpax03hBRtrOAoMsjhvYaxaEcRyMGXTtxahkLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK9e5Q05XbalpZG9v1nwhZ1ceeyD+tFrJjvqkert9rkNMwO5bJye/N+Fs5Hr/qdwivGbQakZxgI2eowQynigyf5G5dA/Ltpf1q8tc8zpCKYyuKu2jLXCkWVooYJ5q1t1CdMMBQ8OK5ciqy/xN50f7BlzlTU0hBhS0K0hJbYs/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSQv3xMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSQv3xMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308161F000E9;
	Wed,  1 Jul 2026 00:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864992;
	bh=9vJ2iyvv7Rvcgcc9XCLdq0p21TqfPLCFyK3t2lOVCnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XSQv3xMdrq4SaxadC8GJlAgFqOi2k/BpvVU7YVRSuxZKDU9BVVTe5fMei8EAptaMx
	 nGj4LbLp7A29v90mwWifK/JEeQbqmRkSRRkB/LHPH8nYU9VhHGheo2W54laEoV6tgy
	 ibJbGX9o111AlxfztqtDZOMQ+JbWCfo3oxi0nBFfG5Eq6xRQZiPGhdCK2U8EoIwRfR
	 vhyYhkr23722Vhi9it+DYhLrSiVz9I8dtXpBcUgcHTCvuXHBSdAKQlz6AcUwidk18H
	 HN0Pu6hpMSXLmhfpwFBhootgALp3JGYkCx1XDdx8qprOX1GHrX4AsM3wEpMdwALPO6
	 go9OSp/XWe6Cw==
Date: Tue, 30 Jun 2026 17:16:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markov Gleb <markov.gi@npc-ksb.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] chelsio: delete the line with the pidx
 initialization
Message-ID: <20260630171631.233056be@kernel.org>
In-Reply-To: <20260629130839.218-1-markov.gi@npc-ksb.ru>
References: <20260629130839.218-1-markov.gi@npc-ksb.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 16:08:35 +0300 Markov Gleb wrote:
> The value of pidx is overwritten immediately after exiting the "if" block.
> 
> Remove pidx ptr initialization string from conditional block.

shrug?
-- 
pw-bot: reject
