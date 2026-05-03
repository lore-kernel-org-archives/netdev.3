Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140F40DFB7;
	Sun,  3 May 2026 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770543; cv=none; b=aX6iuW6Atehqf3CzSmdVDzBuoQDmAJGrSXYnD7kV3HkDwRHcZjgCYwtkCJ9bnG3WyJIhT54tU22ZLIP2/m4qS7jGPs++t6p9wMqqG3DRMefJVWhAQG5Ac5LtowyfRgKHx3kaN2WIANtQRd69NcXPuZ4I8J3QLMOgXOhnrjd6zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770543; c=relaxed/simple;
	bh=6jEpgIcQ4UUuMyRTmOhssNf2e0bzxddkcuIxBVbbues=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L198I1RFcC1K+FRzh2unwKa0RwK+9KHPHsFsRT4Yok18pedimPL1kMqcp5p9tu7yrFwOkpdPZ7D7SvrUGVuzqyrPoN1Kh2uorA9uXOU4d5aSIDe8NQrt1CkxES9SzYi564vno1XpPvscaUggSJC50Dneaqlg5MuZPd0Nrcnq7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJKD3p7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJKD3p7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E7CC19425;
	Sun,  3 May 2026 01:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770542;
	bh=6jEpgIcQ4UUuMyRTmOhssNf2e0bzxddkcuIxBVbbues=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJKD3p7NSXTx+ZFAMABc6ZdMKXEaOqewRvhy0a0gIigBiI/kD5vCR4QoDYerG/Awf
	 KByOBZPBA6USZQqv2SIiu9HnOkpSyU/nG/D8Xr31Qqe7ZaBbzAx04P1SjiwT3838Vw
	 f/S9RYTMlpaxwSg0G7WjcQKiOhaC0zZLqh3ucn2tutFQgPMgeMUV3lVuEaoX//dx7Q
	 HKIXramEaIlbJjYjwBt8NRoT6Qe934ZBpE0595qEIPcFdpIUQC4xveNp5L/FRYTOQI
	 2bpbT2lsMVGUa1/qRvgSKJihM0Q9TnbKoNWHfkuKv8zX51njDycDp4zbcw8y1PHp2c
	 EIPe2mVi07nFw==
Date: Sat, 2 May 2026 18:09:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v9 3/5] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Message-ID: <20260502180901.4f0e266c@kernel.org>
In-Reply-To: <20260429-tls-read-sock-v9-3-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
	<20260429-tls-read-sock-v9-3-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:48:10 -0400 Chuck Lever wrote:
> -void tls_strp_msg_done(struct tls_strparser *strp)
> +/**
> + * tls_strp_msg_release - release the current strparser message
> + * @strp: TLS stream parser instance
> + *
> + * Release the current record without triggering a check for the
> + * next record. Callers must invoke tls_strp_check_rcv() before
> + * releasing the socket lock, or queued data will stall until
> + * the next tls_strp_data_ready() event.
> + */

Please respect local style - don't add kdoc on internal functions.
This is not exported, just add the "body" of the comment above
the function. Kdoc on internal functions is a waste of LOC and
it's easy to forget when adding arguments.

> +void tls_strp_msg_release(struct tls_strparser *strp)

release -> consume

In context of TLS we "release" a socket when we unlock it.
And we "consume" and skb when we free it. So "consume" matches
the semantics better, no?
