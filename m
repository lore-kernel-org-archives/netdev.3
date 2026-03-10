Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822C32C937
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120510; cv=none; b=j9QoNmtlb8LtpzEU5ojNMM1cYuJZ7XE221KHUZATiSrm23Vf2e+KvdOvqT7cFtFt3PUtV/Cz4/QrK1XHiE+e7Q4wzZKsfn0CHwO6dlolkxrYEMYJPpeNdgskt90z30NWIOQvnjVk+IUBc8C1C71cICKgVNrFIIQd84rQI3xd/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120510; c=relaxed/simple;
	bh=Y1xe48gAzTPbSXKbiH5g7POS/gt4IjnNnFPdB4Qf+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf2Y7SIUTrqGvvp5WgtZCm9JVZPfel2TDeszOmYyfG1vYAyIkViKG2qRgfETux1OYt86a0lOg7Ns40aaytO6c4JNRX90N4HQ4fKRc7Xx/MMA1d6iI3DiGAvDNhCjn3Kn29+EkkNf7yFPCtg+kwPRM/nDELKeDsfjnHOwNUaJSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PKHy1fqh; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PKHy1fqh"
Date: Tue, 10 Mar 2026 13:28:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773120506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4og8BexH1PjXrbQtBKxnHmDZU0IU91AS9lelhsT6RsI=;
	b=PKHy1fqhxkBJSnzHaJFjhxA9xNZG0q/w6Qs+krT7vdroeDHrxP12f2XunN0F8r+P+LWstP
	7tek/qgYRSR/2xUTO4wK075xgqinqYTjlgggb6Bi9lsDafqBtDUyHMhYd318uaif11UzhM
	URz/B4h/uljh+6vvGtXWUF+8OXaXhYw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()
Message-ID: <3bd4mwncqnakjtcgibi4ygaseemsheittzsdsriu7i5el3nbk2@3h7ul3264vqf>
References: <20260310012604.145661-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310012604.145661-1-atwellwea@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 09, 2026 at 07:26:04PM +0800, Wesley Atwell wrote:
> Commit dd23c9f1e8d5 ("tcp: annotate data-races around tp->tsoffset")
> updated do_tcp_getsockopt() to read tp->tsoffset with READ_ONCE()
> for TCP_TIMESTAMP because another CPU may change it concurrently.
> 
> tcp_v6_connect() still stores tp->tsoffset with a plain write. That
> store runs under lock_sock() via inet_stream_connect(), but the socket
> lock does not serialize a concurrent getsockopt(TCP_TIMESTAMP) from
> another task sharing the socket.
> 
> Use WRITE_ONCE() for the tcp_v6_connect() store so the connect-time
> writer matches the lockless TCP_TIMESTAMP reader. This also makes the
> IPv6 path consistent with tcp_v4_connect().
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>

I think maintainer will apply it to net-next tree after noticing Eric's comment..

Reviewed-by: Jiayuan Chen <jiayuan.chen@shopee.com>

> ---
>  net/ipv6/tcp_ipv6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index bb09d5ccf599..ba7cd7d3d4da 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -325,7 +325,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  						 inet->inet_dport);
>  		if (!tp->write_seq)
>  			WRITE_ONCE(tp->write_seq, st.seq);
> -		tp->tsoffset = st.ts_off;
> +		WRITE_ONCE(tp->tsoffset, st.ts_off);
>  	}
>  
>  	if (tcp_fastopen_defer_connect(sk, &err))
