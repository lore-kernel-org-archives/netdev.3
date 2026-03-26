Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF0421F0A
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545983; cv=none; b=g1z/ifWlJYiR10jVym29wRx3sk/6Mc3s/h8EA4CkexiqyiIzlZpMbru9dO6ZwXEZGWCrNJCzUSORfwaYLp0A0ASPVkwWxTNHGnV7q3gU1DdZS6vaPRrUCnOMHBJFI633vcostBF6MdjVtOySGSTk2MR+Jk0atNJRCgevCCx98HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545983; c=relaxed/simple;
	bh=LWTFsv4nYZ9jDSFpy02H2jil6tYSVenX/HC1bWCcB7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l25bcx02Tg3fG5PcGMDGLjDVZFpVYLKFxWXYrcEiHeYTOgsBdnBAuHuKJVP45msChthozmwIKI++iE6czSNHrkypijRR+AbSfAYo8bLAGcxrrkR3/sLZv24XEn+Yx8zHJUdooXdr1wW9WNpRpeSflpxGnN+FuQFApz6hJRG1kJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y79mGE0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y79mGE0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8DFC116C6;
	Thu, 26 Mar 2026 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774545982;
	bh=LWTFsv4nYZ9jDSFpy02H2jil6tYSVenX/HC1bWCcB7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y79mGE0egeDZNgxOvj5d4A4tjsi4khHu8JLdmL/JYL/TprpTrhe6pBxTGhWnG7G1l
	 0lNrYhHsRev4ZDWc65bvhRaswKpgQWsaaiiQRIT17vXP9F4821GJNXcNfBaI7rFl6W
	 nx3pNxModwUeINjqFh2rO1CcFGmLBeqfmVqALzim9aXfVlHHCfj7vMfRiRCE0bF0km
	 xhVbeSbB5gLugnsn7HWDzy86GWIMa/CwegXY3Wv1JPu/7IUWWEE9YTb0xxUh9lpVJP
	 GZNJZkeSBtQSDgCitwPWcTxg7eDQ7ThLgvcLxdBB/9bTRF0HGZrLpTxFsIWYfJqk2j
	 kTqL30i0pHrjA==
Message-ID: <d972e1e2-7090-47bd-988a-1ea854cbfb42@kernel.org>
Date: Thu, 26 Mar 2026 11:26:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: move IFA_F_PERMANENT percpu allocation in
 process scope
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <8c8bfe2e1a324e501f0e15fef404a77443fd8caf.1774365668.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <8c8bfe2e1a324e501f0e15fef404a77443fd8caf.1774365668.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 9:22 AM, Paolo Abeni wrote:
> Observed at boot time:
> 
>  CPU: 43 UID: 0 PID: 3595 Comm: (t-daemon) Not tainted 6.12.0 #1

6.12 ???

> IFA_F_PERMANENT addresses require the allocation of a bunch of percpu
> pointers, currently in atomic scope.
> 
> Similar to commit 51454ea42c1a ("ipv6: fix locking issues with loops
> over idev->addr_list"), move fixup_permanent_addr() outside the
> &idev->lock scope, and do the allocations with GFP_KERNEL. With such
> change fixup_permanent_addr() is invoked with the BH enabled, and the
> ifp lock acquired there needs the BH variant.
> 
> Note that we don't need to acquire a reference to the permanent
> addresses before releasing the mentioned write lock, because
> addrconf_permanent_addr() runs under RTNL and ifa removal always happens
> under RTNL, too.
> 
> Also the PERMANENT flag is constant in the relevant scope, as it can be
> cleared only by inet6_addr_modify() under the RTNL lock.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> explicitly targeting net-next as this is IMHO an improvement more than a
> bug fix
> ---
>  net/ipv6/addrconf.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

