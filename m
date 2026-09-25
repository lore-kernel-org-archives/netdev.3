Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E03AEF34
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340544; cv=none; b=po3Wbzi5sFuS2/jNgO4N3X3KWxlhLS4XLVoffra79moOc3U+YusbygsmCjvrOs4w6D7UEHIT7dOzCXuuesXyDh7IiKGimZAp9jtjAC3Mgfbj+MWPXTr4885MM9kyBIJq6/2eilFqanYdarsxP572PHU+d+xJYb2nUcyrqCOJ3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340544; c=relaxed/simple;
	bh=lNWYv9EFeKpWyRw9xyUTEdtmwTUWFyVLNyC/A7x+Td0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDXgEJJqBoRZcG4g3hby+nCnT9WgLeF0n3JNb6cZOSq2V7JHdSeCWd51jC1i3jo02qR7+2TN8B02MskaM/Ck7G+aSUgZ/lh/AF1f1db9McvuM6QQLsn+3Y8QPWWJpzPu/cZaoom3m9AxI6oB2n5yh3FSTkvNb/CGU6MbXhzqgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjTUuGYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjTUuGYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59691F0089A;
	Fri, 25 Sep 2026 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790340542;
	bh=LFx6B7bGW1B6TdxGWQsEWzAcwSgT4EsF8Fy7tnAJlwc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MjTUuGYlUDOhJKynb5mRVeFQS2iDGIJdApYJo+5/787AeZbUVLDlPMTU6cKDZWpT3
	 mwIt5DTlUndxzgEuXEUK1lZox7O/5ORYNr6O2JFnKBce0656fHBYGjK+GLQbGE1MjL
	 v5eABl26+rQUTE+uSSuIPVJuauhLlAfIX0SOIrSg/VflqUM4BzQ3lMwfLFm7CUpOvN
	 F7FkKTqYUUxtLH1uX59fiTMSl0XTWA15Zw6IQezpT46h0czDRnTW6y4m25W2mwdCjo
	 U94AvXKKfEdUwg65yGipqNwOdO5e4pYtpVkxEeEeZ11W1nai5fS9VguFlQnadC3W65
	 72QgjsCqwukOA==
Subject: Re: [PATCH net 1/2] net: restrict SO_RESERVE_MEM to TCP sockets and
 cap max value
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, weiwan@google.com,
 horms@kernel.org, caixinchen1@huawei.com, netdev@vger.kernel.org,
 edumazet@kernel.org
Date: Fri, 25 Sep 2026 12:49:01 +0000
Message-ID: <179034054135.2160803.17217974915706503423@kernel.org>
In-Reply-To: <20260924123602.1979090-2-edumazet@google.com>
References: <20260924123602.1979090-2-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] getsockopt and setsockopt for SO_RESERVE_MEM now disagree on the
  valid range.

--

net: restrict SO_RESERVE_MEM to TCP sockets and cap max value

This patch limits sock_reserve_memory() to TCP sockets. UDP protects
sk_forward_alloc with a different lock, and udp_rmem_release() does not
honor the reserved memory. It also makes sk_setsockopt(SO_RESERVE_MEM)
reject values above INT_MAX >> 1, so that the page conversions in
sock_reserve_memory() cannot overflow.

Closes: https://lore.kernel.org/netdev/5a88421d-10ef-4fca-9acb-85a27a3c1173@huawei.com/

> diff --git a/net/core/sock.c b/net/core/sock.c
> index d23333bb4f3fa..cfc6700a62e6f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c

[ ... ]

> @@ -1661,7 +1661,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  	{
>  		int delta;
>  
> -		if (val < 0) {
> +		if (val < 0 || val > INT_MAX >> 1) {

[Severity: Low]
Could this cap leave getsockopt and setsockopt disagreeing about the
valid range for SO_RESERVE_MEM?

The check is made on the raw byte count. sock_reserve_memory() then rounds
the request up to whole pages before it stores the value:

net/core/sock.c:sock_reserve_memory() {
    ...
	pages = sk_mem_pages(bytes);
    ...
	WRITE_ONCE(sk->sk_reserved_mem,
		   sk->sk_reserved_mem + (pages << PAGE_SHIFT));
    ...
}

If val is 0x3FFFFFFF, the largest value this check accepts, sk_mem_pages()
returns 0x40000 pages with 4K pages (0x4000 with 64K pages). So
sk_reserved_mem becomes 0x40000000. The same holds for any val within one
page below the cap.

sk_getsockopt() then reports that rounded value back to userspace:

	case SO_RESERVE_MEM:
		v.val = READ_ONCE(sk->sk_reserved_mem);

If that value (1073741824) is passed back to setsockopt(SO_RESERVE_MEM), as
a save/restore or checkpoint/restore flow would, it is now above
INT_MAX >> 1 and fails with -EINVAL. Before this patch, setting the value
returned by getsockopt always worked.

Nothing overflows here, since 0x40000000 still fits in an int. The only
effect is an unexpected -EINVAL on that round trip.

Would it make sense to apply the cap after page rounding? For example,
reject when PAGE_ALIGN(val) > INT_MAX >> 1, or state the cap in
page-aligned terms.

>  			ret = -EINVAL;
>  			break;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924123602.1979090-1-edumazet%40google.com
