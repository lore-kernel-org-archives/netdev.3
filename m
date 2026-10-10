Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFD314D13
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619218; cv=none; b=Rb6RPGWzdJMqm6JznPZL8DunXeejIdc9I3W+/D744vRUXXMoGroqUVnMOw6777QcghMf+0ZmuypIdNKwghXid1dSi7eONmnbpRvbkhYaRcwy/9HzJQ1A6FB8g6GB7KqZsU+RHZOGjFnfAoC8HHmvcGRDv44e8iKvYGy/MRxUOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619218; c=relaxed/simple;
	bh=FrTK7tRScSczB/bKYOfDN8HoVU9eC+BlyUFz1zqPkYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpMDlIYun3rvT69pQz228YEd2qi6rqB8SVMHZdPYrlKR3QLAbQBWlUk6VAuYwDKW4318eegBU9wC1f/JhNE/2l+jHbYHdRMW6INoSJmXHG7wo8wovDmN6p6AB4/30xmPPTVzuacJSt/ftZtecPIwGvnQup/uZ0Fin4abhFI/SFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU4iR8TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU4iR8TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E3F1F000FF;
	Sat, 10 Oct 2026 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619217;
	bh=J3hIyD4vBhiH2d6hToHHU8eoO5zU5a4zSscnFTA7T/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FU4iR8TDQBdyxJxSgAuPfwFk8cDVXEi8KA8hZQEHCNdXP+3/mRmu3yuhXXTTlyYN4
	 JIvjoShb9q+JWgYTl5hjCgwfYbFZ7IU7ZtWwYK/AxqUW9JG57513dc0mCgwL+iOzZN
	 J3ahDHOTf6L2JINiHNev4J8L82VKF1KDJQFyzCoZeuc7kFSnE/6dTiHT53ofBdvr/L
	 yl9Pqsd7sBU0Hm5amOu731x2MJNck9HkVTZYE7d81A1bkQsIWzFbI/JOH4CBSoYNve
	 Nw+1euJj73afw4jpv1VnQ7G5tNZts2n2Rq8VcTfdAhn3d0dDe20Up+WPC7A21T1NZe
	 hZenJZyZiRQAw==
Date: Sat, 10 Oct 2026 09:00:13 +0100
From: Simon Horman <horms@kernel.org>
To: Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	kuba@kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v5 0/2] tun: fix re-attaching the socket filter
Message-ID: <20261010080013.GN83879@horms.kernel.org>
References: <20261008080420.132050-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008080420.132050-1-clementwei90@163.com>

On Thu, Oct 08, 2026 at 04:04:18PM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> This is v5 of the series that fixes attaching a queue to a TAP device which
> re-installs the socket filter of a persistent device.
> 
> Patch 1 keeps a copy of the program in the kernel when it is configured,
> instead of reading tun->fprog from user space again on every later attach,
> and fixes the inverted error check in tun_attach(). The two changes are
> one patch on purpose: with only the kernel copy every re-attach returns 0
> without publishing the queue, and with only the check fixed a re-attach
> that used to succeed without a filter starts to fail. IFF_NOFILTER keeps
> working and is no longer needed as a workaround.
> 
> Patch 2 adds selftests: it re-attaches a queue after the buffer the program
> was copied from was made unreadable, attaches a second queue from a fresh
> socket to check that the filter is rebuilt from the kernel copy, and checks
> that a rejected TUNATTACHFILTER keeps the saved program, plus the ways to
> attach a queue without a filter.
> 
> Thanks to Willem de Bruijn for the reviews, and to the CI reviews for
> the comments they raised.
> 
> Rongguang Wei (2):
>   tun: keep a kernel copy of the socket filter program
>   selftests: net: add TAP socket filter attach tests

...

Hi Rongguang,

Unfortunately this patch-set did not apply cleanly to net,
and thus our CI did not run.

Please rebase and repost.

--
pw-bot: changes-requested
