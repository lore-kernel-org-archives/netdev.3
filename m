Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C33ED13B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813817; cv=none; b=fycsLbPUB3hijC9+HXKj6u/Su7++p6rYKSygb4qhVr5bkzLvFS6Y4uOZJ1c7GUojGjEfMyR9jjmCEJ1iSFN3HR04KDRzP+/0r5MHdgHVVJGwAkYXROvoWzcAo2OvmsboVTtFYJL46Wf72JraRvcCtrxSfMxNwd/O8pkS7qZGCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813817; c=relaxed/simple;
	bh=ZiC41Lc9MKXMu3ERSODotf8Rnmczzur/6SsZnuBXsJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4XOj59O/uAMi1jQ9POwZJX+ngynACZaFdcyUg0atT8szaknK7iXUD8GXW0vb5mzq82E1v0yNiWy4l4rs6HhycaRUq6zfh2G8s2rx70obZMjwhsuEmV2T9an81vKpq24hgysAMidcLR5/fI3xFFfTd8+syZkWhkKZ+GlWp/+ONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6lfjvds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6lfjvds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B6AC2BCB2;
	Fri,  6 Mar 2026 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772813816;
	bh=ZiC41Lc9MKXMu3ERSODotf8Rnmczzur/6SsZnuBXsJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6lfjvdsLF7BOsL8s/jBSFwXa8hAcFOGtTRuNnqWN4XpUl823+KIEGHpUYJppKxGK
	 KEM6a3qv7wgdqx8TLFVVMuXHGEjg342Jtx4wkOUE9hMVFDtU+2b3C9yOyp1RMUJeK8
	 vgYYYS7bZXVFWi6CbFk68RDnOQy/MduN+B0VRQYrc2WPj/K5uvWxxY/tgXdduJWlx6
	 ywBqOp4YUX6TmG9UxFK+BRmUgpE1quvySt//rVI3Q75gdY8UTuJokfVV9lyp+OE9ZH
	 PN0Z3/4de5njQW4PG2huuRfxBCtYj4nnfsb+uA6hHo3FhNy10t3jseK6h4rC8bzTg/
	 CW3hp5o4tbARg==
Message-ID: <19f56671-3507-434a-bfe8-a7c6d25ed19d@kernel.org>
Date: Fri, 6 Mar 2026 09:16:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: move tcp_v4_early_demux() to
 net/ipv4/ip_input.c
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260306131130.654991-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260306131130.654991-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 6:11 AM, Eric Dumazet wrote:
> tcp_v4_early_demux() has a single caller : ip_rcv_finish_core().
> 
> Move it to net/ipv4/ip_input.c and mark it static, for possible
> compiler/linker optimizations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h   |  1 -
>  net/ipv4/ip_input.c | 39 +++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_ipv4.c | 38 --------------------------------------
>  3 files changed, 39 insertions(+), 39 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

