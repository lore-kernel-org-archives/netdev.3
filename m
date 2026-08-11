Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227B41F5D8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458472; cv=none; b=AyYnqYIr0TqHh/V7YiN/ogl8JskOHoqnOWwbYLF8dXIW64hYV8mwnAiY6x4zmt/+T/B2nYPrkeTVocIJHg5W7OldvPXn5khrrS0rJCYnpXKLmnccVLkcVb2aTToVCxyHakyemArYPb+5zOYBmeMXegmfVFqHrFhobN0XiQlB1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458472; c=relaxed/simple;
	bh=xf3o/AfjOWNxGO4wyGIBlYU71iMefmCD5jB4U7YdR6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U40Hm68Xb4dwfGncGZarWjOTvwH1WnXOJZwtUnfYNagS6JO1+LoEw8Yq5EQEHWGcDo8FeqHAQsG846WGxTcBP/xVLaWVVeagJSY9zDtbAa/+pHcNI9wSBZGxsApmT9db5PjXYKxhNsEKTs9g9MGE2PkseKFsEYvMPFVeDWXTt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8Hg4VHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8Hg4VHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF72A1F000E9;
	Tue, 11 Aug 2026 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458471;
	bh=wxbdeWqhWZfGgRetP8csfhUC5sKfer1hUFx+MZCPm6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R8Hg4VHWsGCM9KhVuMvBVW6CqmZXey11xrOUCrhrIHJaTjBd7NEMCNYu3DzZ5DGC9
	 NZSpfPaLo1a2wljkmmEgmtymIsFyrduEv1QDolsoywqIJbljvslxBibvYlSNnaMR5g
	 nAeGw7sT8rGMuY9LjSYCEP8Qf2M7oNEi0DzVvr1DZn3F/7S2r7NV2lA87yC1jbe54k
	 LqNOlr+g+/O9jt5+2AWgiYZ29/UMHFHgiUyma7PC56gzhXxCJ+/RnPzEVaVbeSu1c2
	 /VSr2OKNutRnVr2r1jfQ2+605ivnSq80lWzbIt+Tnfziv4mryMDbgGNatwdIaMaXOP
	 43mmNj0T7oZSw==
Message-ID: <9f458f93-77aa-4811-adc0-0c390fe3d18c@kernel.org>
Date: Tue, 11 Aug 2026 08:27:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 02/15] neighbour: Remove
 __neigh_for_each_release().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-3-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260811022448.116235-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> Since commit 6deb53595092 ("net: remove unused ATM protocols
> and legacy ATM device drivers"), there is no in-kernel user of
> __neigh_for_each_release().
> 
> Let's remove it.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/neighbour.h |  2 --
>  net/core/neighbour.c    | 31 -------------------------------
>  2 files changed, 33 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


