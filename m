Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90883E573;
	Sat, 21 Feb 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634626; cv=none; b=cpGxnheaoK43QXGPsiZj1k1fsEjF1Iq0gkPl9V5UnNdCDhxPVOiAwf4bYeFcxLiBsXTbx89RS2cfWSbqKm6MnsxgzNf2+V+CO0J6V1wRgT48i3afBsdmyETs4ZHof+6wymUlZlk6jt2ewze7bmUau6mHRmO7Uvbw0n8dEj2Yk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634626; c=relaxed/simple;
	bh=ni4lmMR1qwcH0aTAzZas8Lc7RHRQIG+P83jf/meWNO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G23YZn9YVy84tg89TE11Q9lwVpplp8XIFfY/hD8lP2A9/pVq/qJlRWIVAN1DoIaMxUv+OdmZ7QCm1gEekBpww3bT11q5snP11EBfMIGaGH00fEBH5dyUqWpIKX5bq6NmzIZF2TZiJHdnJKcduhCbOw4+erwJpkKU8GT0iLESV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAYwSMFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAYwSMFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB220C116C6;
	Sat, 21 Feb 2026 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634626;
	bh=ni4lmMR1qwcH0aTAzZas8Lc7RHRQIG+P83jf/meWNO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAYwSMFuTJ+3d2SzzaaQyqEAQLaazsbnnfOqgseOKb5bvLcK/82v9Qg6Fg2+GS8Ur
	 /hg5m2b5ZMrawY8bmSrNuUHezIUYPv0L6lgKBCdCEhHc7nU0Y8lNOIcMSo5uEncfMs
	 kk6zkO4ybpt92zq4NPLuJ8WcRczysrW4kxkNYrDQnhexerrD2Eu2U5xp89B6uo6Q7S
	 gliaHxfyL+dsyjlfMT4ZkphFb4lsXXpTh1UOVcq0+tDBAJDSQVAGyiWSFYPjwiqI07
	 60us8YdwgyBxOtO+oPBi0w71JolstmKQy4CGtzCWmUuIDCD+RI6GeJqV+yIo5RpS1B
	 hZWIj98jrUAsA==
Date: Fri, 20 Feb 2026 16:43:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <20260220164344.68ab2a6a@kernel.org>
In-Reply-To: <20260219162200.510325-1-g.goller@proxmox.com>
References: <20260219162200.510325-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 17:21:58 +0100 Gabriel Goller wrote:
> +neigh/default/gc_interval - INTEGER
> +	How often the garbage collector for neighbor entries should run. This
> +	value applies to the entire table, not individual entries.
> +
> +	Default: 30 seconds

AI suggests that this value is not actually currently used
in our implementation. I can't find any use either, TBH.
It's read and can be written but it's seemingly not used for anything.

> +neigh/default/gc_stale_time - INTEGER
> +	Determines how long a neighbor entry can remain unused before it is
> +	considered stale and eligible for garbage collection. Entries that have
> +	not been used for longer than this time will be removed by the garbage
> +	collector, unless they have active references, are marked as PERMANENT,
> +	or carry the NTF_EXT_LEARNED or NTF_EXT_VALIDATED flag.
> +
> +	Default: 60 seconds

AI adds:

  Important caveat: This check is only reached when total_entries >= gc_thresh1
  (line 1000-1001). Below that threshold, the periodic GC skips the scan
  entirely.

If true I think we should mention that ?
-- 
pw-bot: cr
