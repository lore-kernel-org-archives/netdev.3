Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C8343889
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229819; cv=none; b=FFZQuqzqHfGjItz3070Z4hnB9H+cdb9dzmwdi9Va7AIvSp3XLEJeT49EKuQMAg6U2ZuFHl1q+fpeTRBP4zcMUqd3qiK5k3TfQ5s6gN6guxnPqAIZkZ0WnE1k9DA/mA1JTuzl9GEbDhBObrs26VTicQRmjkAMpU92B7zyOEbP0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229819; c=relaxed/simple;
	bh=dAzRsYKuGvBreymHNHss5IcwlKD66sCyBOROx6Sy04c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAPOMAH+IR4xwM60zf7gY4MphKDEarsWX+GXM5okj+QrPhageHMOqU2Pxo3G3Qk5rmFbX/J2s/0AHOoEE3H3M1S22VuW/Hh6Df4zOWGTGJtMkNIn+nlcouBU/AgqTdynYnlhHjC9C7AaTLwV0uxkRH9aNeaC7O5/N66lZjE2UT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPiwVpye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPiwVpye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6361F000E9;
	Tue, 19 May 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229818;
	bh=b+uPr2wEeLMmo//EeABgKX4QMdU6Ywquwv2EaKNSEPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QPiwVpye9b1nrk6WGzVhcFGtfMK+T+qkvAZ6e5+55RJaYsDtxkze4Jg6jeFZGHqV+
	 iwNMIFnlKE3vjW8oKkOML2pYGjbF6z9QbsrCjAH0Dtu/yk2iOiho8FzUP97JFsIZgQ
	 PMCwn3siyfeIWpXjvUHbXHRwjivfY8+rjEWUkTAobklb4/L53+XgYHaQGUmABnwsmy
	 dZ4RGmIuqIevkEFzKo/tIgEwHNxva+nMP38oYB1Er3edqHk+lwME3AwVgiEVtLvOIB
	 An88/74gaumrBG/Rsn4Wy86nYpG3vER1RmUl6+qTToymv3dbuP+iR1cSus4Eeeu906
	 RXVcyw6YN6b/g==
Message-ID: <c5dd5dd8-44ec-45da-9e5e-5adbdceffab4@kernel.org>
Date: Tue, 19 May 2026 16:30:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: use WARN_ON_ONCE() in ip_rt_bug()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260519193248.4018872-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260519193248.4018872-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/26 1:32 PM, Eric Dumazet wrote:
> It turns out ip_rt_bug() can be called more than expected.
> 
> syzbot will still panic (because of panic_on_warn=1), but non debug
> kernels will no longer die while repeating stack traces on the console.
> 
> Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 



Reviewed-by: David Ahern <dsahern@kernel.org>

