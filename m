Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994980;
	b=qaqkKLba/1nna/LGK9E6P7n7XlpASBdH5K9FcIRG0pnmeCadw8Xlm9xaYTklBGsGl6JW
	 l1iFucy+FGCnhsMlJieOz55duvTaw3q8mxC8smEuaXp1B17Uub88CTSUQ7EhY57ptf19p
	 R5Aqyf+D5faYiYxdrpQPETjzzvpllVW8J2STEXU7hvV+JcN8MlK9avLQuiif6gd5Pwzxv
	 iKfaVyA1J3/qxZx/ZdHDEmAENf88OdDRwl1D9CD/2STOu47zb9V5YeM/WB0D26qW8JmJo
	 PO7rg+CtESW8CTv1wfSJ2DOdDYe3qXkwnWIh8zBha9LWkrpSctbsADE1hIhkXMhVs6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994980;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ScUwDrCxcDY2Tg+t0+W2UwFl6cxgpHFmAE9XOo7zw8g=;
	b=YkgtysEi4LyUNixjHDRx+Zp+LZ2obNElJrLcCcjcOszByywk7fTmHoXp8eGr1ehwmqPn
	 3xgX6BcpuSSfD/bCfXBlwN+MlnZvW7e81O0WbqqM4814HpyqiIL89I3g/xjI4fnLlGwVR
	 8CIQWdViRgB7z264i3FSzJ4fgaV0+xVqLYmWF8lsWkHyuqEacxb/m4L8GocT8RYvDilvS
	 4vQ7Bvs2svPMKlStEPYtw7rs0prDxGiH1AcNUq+3+SSO0LKZvoHx5mRCJtY3wIKqzLwdT
	 iCZmKB26/F/knRH7ABDW6JHaYQYPb5tI3ynz+e7MepshmBYZ1QFYmX0YR43GOQHOv7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZJ87ng0A;
	arc=none smtp.remote-ip=91.218.175.61
Received: from mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36052606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36052606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZJ87ng0A
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HVI1rhJAjlA6hwOuxcxfPrgx9c8vnckidjUuhN7LrGs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792994977; v=1; x=1793599777;
 b=ZJ87ng0Awshfd2qAvlXjnoYCpo/685WZn3yvyRHt4/IgTUhKjohacDBgrda54qYzp5EEu6a3
 j+5Z9V0ZA+ZvdslvqtOa0+tNlccVk8FfUpTHuYtkfVkkcwXZsifiFeGE8StoTGNJmjxarDN8IYO
 pNYB1P4Ax4eCxk58aoUyS7rA=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5076e146843fdcaf;
	Mon, 26 Oct 2026 06:09:37 +0000
X-Mizu-Trace-ID: 5076e146843fdcaf
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 14:09:23 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <at7uk8gXtzNufuQF@fedora>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026044808.613-1-n0ps1edzz@gmail.com>

On Mon, Oct 26, 2026 at 12:48:08PM +0800, Zhou Qiuyue wrote:
> rawv6_send_hdrinc() caches the route before handing the skb to
> l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
> the original route, leaving the cached pointer stale.
> 
> The function later dereferences that pointer for statistics accounting
> and as the output device passed to NF_HOOK(). Its RCU read-side critical
> section starts after l3mdev_ip6_out(), so it cannot prevent the old route
> from being reclaimed in between.
> 
> Reload the route from the current skb destination after
> l3mdev_ip6_out() returns.
> 
> KASAN reports a slab-use-after-free in rawv6_sendmsg(), with the route
> allocated by ip6_dst_alloc(), freed by dst_destroy() from rcu_core(), and
> the related RCU callback queued from vrf_l3_out().
> 
> Fixes: 4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook to out hook")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
> ---
> Changes in v2:
> - Rebased onto the current net tree at 7076f684d513.
> - Regenerated the patch with git-format-patch so it applies cleanly.
> - Corrected the Fixes tag to the commit that made the IPv6 VRF path reachable.
> - Shortened the code comment and added the required recipients.
> 
> v1: https://lore.kernel.org/r/6adad51d.8fc0b0c9.1ec657.1868@mx.google.com
> 
> Thank you to Hangbin Liu for reviewing v1 and pointing out the submission
> issues.
> 
>  net/ipv6/raw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index b965258cf..bdea82543 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>  	if (unlikely(!skb))
>  		return 0;
>  
> +	/* l3mdev_ip6_out() may have replaced the skb dst. */
> +	rt = dst_rt6_info(skb_dst(skb));
> +
>  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
>  	 * in the error path. Since skb has been freed, the dst could
>  	 * have been queued for deletion.
> 
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
> -- 
> 2.50.1.windows.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
