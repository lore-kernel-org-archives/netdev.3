Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859C3D47A5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671869; cv=none; b=XoO2OxwG3LeLZtyjlaWg3DUJuYHCZX4K8x9Zy7+jGiTzZOM/lt0v5iyDSemt3xIOwTPSYch5VBfOJ2hHaI/ruok+sZKclO09u+Zt3Di9pZhmeVCvH4Ab3YIPMjC8e9m53v8fm9Z6AyduLzeGPmoRmREOHFfeGCUnGOg22vSmZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671869; c=relaxed/simple;
	bh=BxftJ50X5hnPm/KpTXBi6PGNMlBmjsQxlxihvPD7dbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvBWfQ2kA3XrXFBOM7qkEuXjDB5HjdN1116kgTJz0QQvVECeEYAGNso+vuzEZW5KN9fsfoyfaxslKyVqLR2yRwqIH57lo9g7al2MHw/V5vIzX+1O/H0I8Btm53ShZ3vNt4yAjaWyKkMBEqAEl8l5vgzNj7wg9tq1m3CIYcJLZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqb142pu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqb142pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D525C19421;
	Wed,  8 Apr 2026 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671868;
	bh=BxftJ50X5hnPm/KpTXBi6PGNMlBmjsQxlxihvPD7dbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rqb142puwWrvVaZqBzE4pxEHDbp0qi+ewKF/paZFQiI5VMbsm/aukwzt0GH0ga8Ju
	 UDLRm2Z7z4GSIVM2a9TuqbRKurs4dxG9nRtmtpE6wuVBQpJPurwEPYI8Q8RiIh+yQ3
	 x0EfcAwnshD/gW7xW54RH2ZS3HXeqH+kV6JmSJLqcAq8u0DFakMYWlC1u9nn9rJfwl
	 vOmYmWg5Hjt8yGG8gfjMeKLpku/H8oUfpMNX9ly6CHGoccW2zUhJz9bdAdPlPqEJEE
	 XzcbVGRnY/O7qNqHYXcxhp99hOd44eIH+uVVEOBh9aUcIfHfre/5ykGawxNpf4NMGK
	 xoNuJBYZ3Ep3g==
Date: Wed, 8 Apr 2026 11:11:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, willemb@google.com, dsahern@kernel.org,
 quic_subashab@quicinc.com, quic_stranche@quicinc.com
Subject: Re: [PATCH net] tcp: update window_clamp when SO_RCVBUF is set
Message-ID: <20260408111107.077659c6@kernel.org>
In-Reply-To: <20260408001438.129165-1-kuba@kernel.org>
References: <20260408001438.129165-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 17:14:38 -0700 Jakub Kicinski wrote:
> Commit under Fixes moved recomputing the window clamp to
> tcp_measure_rcv_mss() (when scaling_ratio changes).
> I suspect it missed the fact that we don't recompute the clamp
> when rcvbuf is set. Until scaling_ratio changes we are
> stuck with the old window clamp which may be based on
> the small initial buffer. scaling_ratio may never change.
> 
> Inspired by Eric's recent commit d1361840f8c5 ("tcp: fix
> SO_RCVLOWAT and RCVBUF autotuning") plumb the user action
> thru to TCP and have it update the clamp.
> 
> A smaller fix would be to just have tcp_rcvbuf_grow()
> adjust the clamp even if SOCK_RCVBUF_LOCK is set.
> But IIUC this is what we were trying to get away from
> in the first place.

Hi Eric, any thoughts?
I always assume you are displeased if you don't reply within 8 hours :)

I should say that everyone has obviously discouraged the team that run
into this from using SO_RCVBUF. I'm fascinated by how they decided that
it helps since it clearly doesn't work. AI sure makes it easy for
people to "try things". Sigh.
