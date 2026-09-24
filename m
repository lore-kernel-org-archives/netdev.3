Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0747ACD6;
	Thu, 24 Sep 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262630; cv=none; b=Wx2EFj2uJUJ8N11dnQXo5J1uXVx9w4KlNmxdVN0ldEM9RnbT3vBahRqtNT3tJVEDoWPxibVdSwrNQDOJow7riLp/e9TORQAgrXjOlh9+Z+G8UgPdoS/fFKmk6AKYDAcbFnRV0My5QZlLj6C/0XOOrHMTd08I7MOGj3cZhFPePNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262630; c=relaxed/simple;
	bh=kmECzyA9SwcKafrelKws3j36NEpt5Rd0Eh17TaupPNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdl7i26HxAbgmvWKbvQKb+B5ei8vs//4bx+v4hX34iNJpJEZ455NPdbj0QxmGzyon+WAJgSBhnmBelva67y3Q84eE3j56o96Rd/DCEQzu3hJ0ybCYv4awhAyKyPeWMlqmJnjhwPTUrmjrbod4/uW/OBGTiRYc9Y5zTKjRC+B6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2BQXmHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2BQXmHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B1D1F000FF;
	Thu, 24 Sep 2026 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262628;
	bh=D6OG3n4N0mKuX99K9C3N8BtDO4m4BTi3PpA2GBpxPpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j2BQXmHaEwaJcw67eADj2vKL+NHteC9J5/gXDYVyCwm5fZWWcvEhMneMSw3HrbvjQ
	 mKUp0R+rHfq5mJWXNZOT6iHZ5jbxXS8M4/NKFHPgLdNA70jThXutW2NKUgDeUaOPPb
	 QjQis2nwv44GlIFt/OPZZORpFpqFi96+0zrN0BStEjr9hk5CdEKh9mq+7LwIpr7tCY
	 Dhl74fkJzMnn2w8ncc/zw7/5/m0S/FykEakwLd+9Lq62H+mbvYb9woM8lbc2JmcQ+l
	 YsiAYepAjjGHiXRvEIwKO7UKhLZ5VYux+VXjaMPh9vMxl3VKmB0knb7Ht8dXCXSsuV
	 l4uLO4fQ/LoBA==
Date: Thu, 24 Sep 2026 08:10:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Cc: quanyeyang@proton.me, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to
 sk->sk_err
Message-ID: <20260924081027.28b39617@kernel.org>
In-Reply-To: <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
References: <20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me>
	<20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 06:41:22 -0700 Quanye Yang via B4 Relay wrote:
> -			if (sk->sk_err) {
> +			if (READ_ONCE(sk->sk_err)) {
>  				ret = sock_error(sk);

This sort of construct needs to be de-sillified in both patches.
-- 
pw-bot: cr
