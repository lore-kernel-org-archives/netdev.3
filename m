Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2B47887E;
	Thu, 23 Jul 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823174; cv=none; b=nOEm3fLxUhKLQZTtdvce5i1BmGtskhizuxxAoYjvZK7d0t0Up2aFVL0KD7IMnYaRlELSC9DNnFJA+QFGQ2j3QLVbqRziBp6p3wYsT9ky8aETm3L+4UP9Y3XE5+/GUj3X8ztD8Oh1pt5nLC21JppBWL87ar6uFiSTXsNXLOzA2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823174; c=relaxed/simple;
	bh=CO9qNj4e2YFNFJQbrQJTRyuMNJqYRBVcFAt1Dt+uZCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnQyHfco3KHYFyKTnV7cgjLlar186IQ5QvF2bbE/VBrDungb65G2tWsL0yVaqX+bhCvHU5aes0z7oBEUGv8ZJhItYcP0XEx4ABQZH9S4Pjia7iFY7w9A2yC6bDO6nRWWDuRiabGkUXbh1fQ/tBXa8u3j0qx3ui6aU3mBKnNPfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563A11F000E9;
	Thu, 23 Jul 2026 16:12:51 +0000 (UTC)
Date: Thu, 23 Jul 2026 09:12:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, John Ericson <mail@johnericson.me>, Simon Horman
 <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, David
 Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, Sergei
 Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] af_unix: fix listen() succeeding on sockets
 in the wrong state
Message-ID: <20260723091248.6acaa173@kernel.org>
In-Reply-To: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
References: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 14:29:01 -0400 John Ericson wrote:
> Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
> reaped sk->sk_peer_pid") inserted a prepare_peercred() call between err
> = -EINVAL and the socket-state check in unix_listen(). Since
> prepare_peercred() leaves err at 0 on success, listen() on an AF_UNIX
> socket that is not in TCP_CLOSE or TCP_LISTEN state (e.g. one that is
> already connected) now silently returns success without doing anything,
> instead of failing with EINVAL as it did before.

As the bug proves this

	err = x
	if (cond)
		goto bla;

is a fragile pattern. People do this to avoid the extra braces AFAIU
but it's not worth it. Can you move the error setting before the jumps
please?

	if (cond) {
		err = x;
		goto bla;
	}
-- 
pw-bot: cr
