Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595228D8DB
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342086; cv=none; b=sEBJj03Q419qm7SJTgpyrP33wWFXiMLzaAoesQKUDYNDfI3X2JUOC0KoVDSsYluz51cAZCNLufk5cDk4sm8dqOsNZhxYECv9O9qSU1kWds/aw1sDklaKdlaWp5errtEe+/rnm0buo5t92GtOjBup1odEeyZn3M8j7OzSBLIxf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342086; c=relaxed/simple;
	bh=aJe/CXqnh300oDWk1+OKN6sl8DV+i/s0/gCPYCUEZ24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnbeXNwcJyFcb4LiKJW69Iv7pHmNiDvVsZF+DHvAgyJZmyvYRD7prdWgYizgEQX/9chnjHPZfVsVTWJxYzf1vwGL+UMZiaogPyrUX9ckHxomt7JmMd7mDvQdu4eYI+BX4jkB+pzaDijmWG319HSt4o+451zJhyqzxAg9wLuITw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8TvfMHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8TvfMHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E8EC4CEF7;
	Tue, 17 Feb 2026 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771342086;
	bh=aJe/CXqnh300oDWk1+OKN6sl8DV+i/s0/gCPYCUEZ24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8TvfMHzh3ghMgKqhYWkAuw8kfnAH64Au1YpPHNs+Hj9GKDgYAu0/Kndw8Frc2pQI
	 DydcgLcbgS8z8wXiPbqP9dLNVbGCAwT9CN9ykLiFj95RhtlTMBZHmPFjWd+sVNXC++
	 t2vyuP1m8itnmoVLR6AiWjfl3oYA1B9orK/JlhBPfJz39o7SpImqSDwovJZeh2rxi6
	 w1rtgmddGw9KjsqioL1hfSDhhkIgkZ1nUio21z+Hww7kxwIfUH/3rF47Q5l6t83v17
	 pK69iiHwnbyuxEeCS11hK52fdAbQqqQZD+2XJKKcFLhwGCHMswlweS63FcaxWvrSOe
	 xNx5hKXLK6tCg==
Date: Tue, 17 Feb 2026 07:28:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Henrik Steen
 <henrist@henrist.net>, Olivier Tilmans <olivier.tilmans@nokia.com>, Bob
 Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not
 attached to ingress
Message-ID: <20260217072804.213307b9@kernel.org>
In-Reply-To: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 10:38:52 +0100 Paolo Abeni wrote:
> Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
> later on tries to tuch again such packet.
> 
> act_ct was never meant to be used outside of the ingress path. Making
> defrag really works for act_ct outside such constraints range from very
> difficult to completely impossible.
> 
> Address the issue making act_ct drop any packet when not attached to the
> ingress path and additionally emit a warning about the bad
> configuration.

FWIW there is a test case in net/forwarding/tc_actions.sh that fails
now (needs to be adjusted/deleted/reconsidered).
-- 
pw-bot: cr
