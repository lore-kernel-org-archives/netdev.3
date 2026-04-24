Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633E2BE026
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059038; cv=none; b=rGv6wbIyJD4BVoqEvPXdyw2EnP2Sx2n+UwOK3w5nSNtwkRlVli6kLJVGWmYVB8ScCEj8dMn8R1I84CCh5zhTq9pP3pzfcDbX8IAKyeQ8bUlO4Kk8oWRXQHrnxRzlvchKoT91QAX1wRQwCFLeowOSfzxaVl9W/Qd/a6d3FjedstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059038; c=relaxed/simple;
	bh=nJ/U44d1I6NWvb8arGyA3HNe5F7J9VbTfGirfCbggfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSkiogfMSpGElhc1RqXyhv0/Xqw7KpqqDlP4VmbV5n5qY8yhak/c4Y23O9Jt4Om2XjDRiwxDB4u1a3TjzwpR+OSo6gReXr17Nu22DZXLtwuOU5ffC31EXxLEK1A8Ds5cE37TEGkHCb2DkiOnGz0UnokmG3YTIWfddt9jBJXdAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkJTJONu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkJTJONu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E82C19425;
	Fri, 24 Apr 2026 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777059037;
	bh=nJ/U44d1I6NWvb8arGyA3HNe5F7J9VbTfGirfCbggfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jkJTJONuTmagNZLW6PXM23Ih0FhnLm5w3ru4sgB1NXcwV59/VU5zYHBGE7QOEWikm
	 1bUTZMcZXdMHp04Nj1++m0CbN6yszjNisuNvpY8ON64/2Nk7iDVs9eYFoPqzN9vLEg
	 gJ/L3zmzqzjaoelSKrX3wb02dygPoSislAZ59QdHzsNyRcJGPwa8ZdyCnFjBql4WnE
	 UxJyP3jEN5ehvWWdVYGy2+sG7QFV1rxODx8Jtku8OgsvBX4rs/sbsGUmovCO9PkJEQ
	 g87nk4bu+vp4xgR5eLaRNZbK0fUEHbWrwbCVGO+2gVMyDixVf3U/3Mn+ubRwhK6z6q
	 9tFyjMiH3Xp+Q==
Message-ID: <9a8c7687-d264-495b-9cb1-0bac85a7082a@kernel.org>
Date: Fri, 24 Apr 2026 13:30:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] utils: add fflush_monitor() helper
To: Eric Dumazet <edumazet@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260424171151.1190882-1-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260424171151.1190882-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 11:11 AM, Eric Dumazet wrote:
> @@ -399,4 +400,10 @@ FILE *generic_proc_open(const char *env, const char *name);
>  int open_fds_add(int fd);
>  void open_fds_close(void);
>  
> +static inline void fflush_monitor(FILE *fp)
> +{
> +	if (monitor_mode)
> +		fflush_monitor(fp);

Circular call?


> +}
> +
>  #endif /* __UTILS_H__ */



