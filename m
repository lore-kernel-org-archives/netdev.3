Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693105;
	b=lanBhOkzcMwRUKdU6QFn6Gz+vCojEmQrK4mhZ2K9mfSK/NHVeE14DLnyGpVukGQVyZ9U
	 me2a5NcAzjj6GyPFFAaWEx1+//fxr63RjF/U/Oi2ALcr95P0cKiSIorZziVXs6RDh8RUC
	 bumgeU2s0O+i7/frGmNYGASFaK7TCWUHIOQ8fTbXYqLCZLD1hdCefT5RThOE3kfby07wy
	 6dzE6byOrUNnhGe0P3fjX4yZogW+On8CBdaSHzAxz5OgpuAazzZnj711zlcXFAncKzikk
	 j9JwUXMz4o2FJLSlndSfbP/8PkweIrspVrN0fYTuJx2BSWbe6LHCKHxraypUXBZqRvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693105;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oCaoMThyIIQHYQEmMpnmp88aQ+J+uEIeqkVnvW0Jyi4=;
	b=H4zXltwNXQW94AjmU96zOvEdZDAZQh3n9A2rCmk5iIQBbpYScfHsjqYiHLY4zFO82QbE
	 WEQu6+zzIVsHFDgZHvD3T5YA+q8m2eCz8eeq8DnxrdrHd1F2LX+dutadloKQDLJ8gbtAy
	 9YYEYhtVIDaxgEO2hkaRZiWFQzVzuQY+/GkuN8LYZzD7hXtyDd4KL2rEW7SLgfyNm5ZOE
	 oBC+Wgdb8uTkEYHEGip/9ectU/Rga001oIzlQqT55OCZad5NDrZz7XPuvBcnzKrhW4qjv
	 2C/eirleF+4BPLTBVizItgQVa/B7qvi02I3ecqP64YjC3gCXkH7Ub7mR8ETaC3YhM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpxchWOQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBF606D805
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpxchWOQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BACC1F000C1;
	Tue,  3 Nov 2026 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693104;
	bh=oCaoMThyIIQHYQEmMpnmp88aQ+J+uEIeqkVnvW0Jyi4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YpxchWOQ5o4LZ58CP7to96hdmYu77FkroCVPKlpC3eXEqDuUjiFYoYqaAQX17LQNe
	 KV2I9/zeSgwuln8w/byo7hFEhyYrk12f+5TJPjdqJMR1S3+29ccZeVFHMvZGNTfF7X
	 8NLMS1HnGujjkBIpG6xsKrLxFVOff7mQcrzeEl8FXYpkYklfr085ryMzvL+/QjEAzY
	 8cQ37iIGkkkansvHGZ2MrGdzMbsPpjGEj51dUYNa27FE8jVT4o7eVQ6Zr9WGAtcLbL
	 yniL4g9tP3lJWckXaPjnAbAYWC46ANm+KH/QzLAVvdwAzwKXxIBoNvCYtcxP6plQeD
	 Q5Im2j2XPOf1g==
Subject:
 Re: [PATCH 07/14] xfrm: policy: reject mark with bits outside its mask on add
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:03 +0000
Message-ID: <179369310395.488856.1196610792291916744@kernel.org>
In-Reply-To: <20261102100451.2505200-8-steffen.klassert@secunet.com>
References: <20261102100451.2505200-8-steffen.klassert@secunet.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes XFRM_MSG_NEWPOLICY and XFRM_MSG_UPDPOLICY
  reject input that mainline currently accepts and that works.

--

xfrm: policy: reject mark with bits outside its mask on add

This patch adds a verify_mark() check to xfrm_add_policy(). The check
rejects XFRMA_MARK values that have bits set outside the mask. It also
removes the mark sanitization from xfrm_policy_insert(), which commit
0b91fda3a1f0 ("xfrm: Sanitize marks before insert") had added.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index cc206017d0f50..cea6842e6454d 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -1575,9 +1575,6 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
>  	struct xfrm_policy *delpol;
>  	struct hlist_head *chain;
>  
> -	/* Sanitize mark before store */
> -	policy->mark.v &= policy->mark.m;
> -
>  	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
>  	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
>  	if (chain)
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 6b53373168b02..c1571c7a23153 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2307,6 +2307,9 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (err)
>  		return err;
>  	err = verify_sec_ctx_len(attrs, extack);
> +	if (err)
> +		return err;
> +	err = verify_mark(attrs, extack);
>  	if (err)
>  		return err;

[Severity: Medium]
Will this reject XFRM_MSG_NEWPOLICY and XFRM_MSG_UPDPOLICY requests that
current mainline accepts, and that work?

Since 0b91fda3a1f0, a mark such as 0xf42/0xf00 is stored by
xfrm_policy_insert() as 0xf00/0xf00. The policy then matches traffic in
xfrm_policy_match():

net/xfrm/xfrm_policy.c:xfrm_policy_match() {
    ...
	    (fl->flowi_mark & pol->mark.m) != pol->mark.v ||
    ...
}

With this patch, the same request fails in xfrm_add_policy()->verify_mark()
with -EINVAL and "Invalid mark value/mask combination". A userspace IPsec
config that loads and passes traffic on current kernels would no longer
load.

The commit message only says "Reject it instead". It doesn't mention
that this input has worked since 0b91fda3a1f0, or why breaking it in
mainline is acceptable.

The Cc: <stable+noautosel@kernel.org> # avoid breaking existing userspace
ABI trailer suggests this is known to be an ABI change. However, keeping
the patch out of stable doesn't prevent the change in mainline.

Could the lookup failure be fixed without rejecting any input? The GET
and DEL failures seem to come from the exact compare in
xfrm_policy_mark_match():

net/xfrm/xfrm_policy.c:xfrm_policy_mark_match() {
	return mark->v == pol->mark.v && mark->m == pol->mark.m;
}

Applying the same v &= m to the user-supplied lookup mark, for example
in xfrm_mark_get(), would let existing inserts keep working.

Also, the commit message says the policy can't be found "by id". Doesn't
the same compare affect selector lookups through xfrm_policy_bysel_ctx()
as well as xfrm_policy_byid()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
