Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984288;
	b=U8lY3gbSNcWZDXHIaUHH6K/uz2Eu1uuouKXy3//daGNI2KCpYVHfWeJDBtWLU/yvbABV
	 WKeSflh43U5saxkvMEgegYXLsg8QkkYEdLcIz2Asac7DyOqjx8GSkfr3e6u4a2qnpV90h
	 ZtgFehfHcuMzhARGrPdrRfqBuwNwzSMPL4ubFhRij4ohNq3nLVlXkk+hRrjRJbXX+bFOL
	 KxYWhnAO1WtZITocNbAxgCzqn4FUJrbw2VvesDxSltvWaSjvgPG25hrYj0TuPwA/EhP12
	 sTzyFL5nCrB73p01mCP6YEqN6MICE+IIgrqcnTElaQNnBuz9Ov4sH5ciD1LcM1IE0HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984288;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+LYv4FFAPGIAsOArb3pNFw7gnJa7ff2ymguPx9gtgLE=;
	b=XRKixp+hcHhd0PeXqZ5x+kOc1VPUyYK4u6iceAtC/qZttpSPdF3iMYG+M7ClyYvJSLai
	 cPsQB9VEMzVBbrcr+f2hryQXpIFLGBizol/Rpqqsbiq2E5oqJLn87QaF7nj1Ux30j75pt
	 5owngKkkyEFDVJ04kl5ANyyd7HKwHRfKBBRyGk1UxpIbkIZ2x2nMI7qL1tujIuIE2K9SU
	 B/vBJO/yxk16dHo5A7rgmhT5Z0DI6gHu+iSrugso/IW29Nj17myzG8sJQ7OLr+lqVi8Cv
	 yc8uLW/YGJOd8Xzp7W7e0vSXJ95Esrcalf39eLv8+Dl1Jgx3ez7aYO5U5zi8WU9lR2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lv94U6cm;
	arc=none smtp.remote-ip=91.218.175.134
Received: from mta0.migadu.com (out-134.mta0.migadu.com [91.218.175.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1880606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1880606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lv94U6cm
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LCccKxR1YRRVCuIaocwIJsSOibmvazapcXVPPlxCnPs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792984284; v=1; x=1793589084;
 b=lv94U6cmrmkza8kVMga5PF3q1XrYhDfXCeRh4PK1Wb9lMkuXd4t/TF4GcKSVLHkwCBw9hEBd
 41WsdCUKZ2O8Lluv/j5LaQIq2KLS9B0U036HWrriUKzeqjfMecclbJdvEnAvKUETCh1REijIKHn
 xmg5nypxKF3O9NjwWRKtzSM4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3f44c337d3a366c3;
	Mon, 26 Oct 2026 03:11:24 +0000
X-Mizu-Trace-ID: 3f44c337d3a366c3
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 11:11:14 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Message-ID: <at7E0uc5oU8AWZcD@fedora>
References: <6adad51d.8fc0b0c9.1ec657.1868@mx.google.com>
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
In-Reply-To: <6adad51d.8fc0b0c9.1ec657.1868@mx.google.com>

Hi Qiuyue,
On Thu, Oct 22, 2026 at 08:31:41PM -0700, Zhou Qiuyue wrote:
> rawv6_send_hdrinc() saves a pointer to the dst/rt6_info before calling
> l3mdev_ip6_out():
> 
>     skb_dst_set(skb, &rt->dst);
>     *dstp = NULL;
>     skb = l3mdev_ip6_out(sk, skb);
> 
> When the egress device is enslaved to a VRF with a non-default qdisc
> (e.g. fq), l3mdev_ip6_out() takes the vrf_ip6_out_redirect() path,
> which does:
> 
>     skb_dst_drop(skb);     // drops refcount on old dst -> call_rcu
>     skb_dst_set(skb, dst); // installs VRF's own rt6
> 
> The old dst entry (the one `rt` still points to) now has refcount 0 and
> is queued for RCU-deferred destruction via dst_destroy_rcu(). After
> l3mdev_ip6_out() returns, rawv6_send_hdrinc() continues to use the
> stale `rt` pointer:
> 
>     IP6_INC_STATS(net, rt->rt6i_idev, ...);   // UAF read
>     err = NF_HOOK(..., rt->dst.dev, ...);      // UAF read
> 
> With expedited RCU grace periods (rcupdate.rcu_expedited=1) and
> CONFIG_PREEMPT=y, the RCU callback fires quickly enough to free the
> object before the stale accesses, producing a slab-use-after-free
> detectable by KASAN.
> 
> Fix this by reloading `rt` from skb_dst(skb) after l3mdev_ip6_out()
> returns, so subsequent code uses the (possibly replaced) dst entry.
> 
> Fixes: a8e3e1a9f020 ("net: l3mdev: Add hook in output path")
> Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>

You need add a target repo for patch subject. e.g. [PATCH net] ...

BTW, you patch doesn't apply to the current net tree.

Applying: ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Patch failed at 0001 ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
error: corrupt patch at /net/.git/worktrees/tests/rebase-apply/patch:25

Please rebase you patch with latest code.

BTW, please remember cc all the needed maintainers with scripts/get_maintainer.pl.

> ---
>  net/ipv6/raw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index XXXXXXX..XXXXXXX 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -648,6 +648,13 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>  	if (unlikely(!skb))
>  		return 0;
> 
> +	/*
> +	 * l3mdev_ip6_out() may have replaced skb's dst via
> +	 * vrf_ip6_out_redirect(), in which case the original dst has been
> +	 * released and may be freed asynchronously.  Reload rt from the
> +	 * current skb dst.
> +	 */
> +	rt = dst_rt6_info(skb_dst(skb));
> +
>  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
>  	 * in the error path. Since skb has been freed, the dst could
>  	 * have been queued for deletion.
> --
> 2.43.0

The change looks good to me.

Thanks
Hangbin
