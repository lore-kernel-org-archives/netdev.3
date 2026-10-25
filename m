Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948014;
	b=A3+FikgRL1IpkhQ2LOLSvCb6NTDOtWubQXP0oDJGjyxJkLdadj2MqUQRgAZfjLCjuTwv
	 lJYf+umS1JbI4gYpGesPXiz0Yy1tdpTlcv+fWlweXKwLaPat575ST0x5jd5Bn7V9jIRRZ
	 SkV3YboKYwe0Qs7wQ1TKugLSR6EVbmWQGZf3BbKxpGCPJ76et33qqObCTO08qqkXVOSLx
	 iz2mQ9SCOxaRYLakq8kQLq85RiHuD7xQH6Fq2q9lXeKefPEgP6K34WRdprrp0oP+sZvsy
	 Lg7/291Xq/o3z48LR74qKmtiXvydG0SxCo+bBPvk0Y6kI4bfEf9tnuuU5MyMFgko2Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948014;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FQ0+peCWUVO2jA4UlMabDTRqCs/B/n8KeGKmGRJQNV4=;
	b=3UWikW/YXjkeXkPFdlnJ38fSU9BLzsPB/Oa+BzkTsIIeMDxsF4IR7nozi8RoPhbKJwQX
	 7R5aBJpY4oH7bqXRFs8jtlpb5Lv3E/zMFWgZXAuaBWBtVgeRKTHbJwMuZPtKfao49WHxI
	 CQ200XAAgFza1Qkby0lYUbDSZBbJKJi4i5TUXyRwu+tiEafJyO/NsfBngH7DevY+mBJ8H
	 BMw7hieD+XaDV3fKRQdMqp0DupLU0mxQipFuFCuwKYlanlQV89xWRaCBpivM91IZwVWuE
	 oLSlrT/Xz/xBsElejFe75bHRpD+N/6u9Q4RZKHGlbnJXJk+vbfoAJfzdeyMgGMS/NVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AgaTNfG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2B606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgaTNfG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F071F01825;
	Sun, 25 Oct 2026 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792948013;
	bh=FQ0+peCWUVO2jA4UlMabDTRqCs/B/n8KeGKmGRJQNV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AgaTNfG/9SsDpyKcdjCOVQrvHIKwhEbWuQPqiVIaDmgxDkZU7WWM4o0uNh2Ezoojs
	 DosGpHdd+Fza90gx/udIX3Z+0Tir/9dyWvjgy0taoZqHaTkJ0tc5OVgHu2S4Q3cB5p
	 1pSQGbegkJFBhPpyxjDKdsBUjY6KLmp4SYvXxUr5mHOjpzuFI9Yvo6V+NrsvnQcaao
	 sDWCcyzrjgYxwxXT0LVEzlu1ArzBhp3cE+Y0HyBCT6h1uFuIe2IjlJTC0acx7KJjUb
	 H2AXjdM2cttRQ0LQUk0rZzhdSH9hnDJQbYkAC0gy6BQXSFEmVQA3Zb4O91BwzV0P3d
	 Eai0LL7JR32aQ==
Subject: Re: [PATCH net] net: reject flow_limit_table_len values below 2
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Date: Sun, 25 Oct 2026 17:06:52 +0000
Message-ID: <179294801288.3134.11285713978182388228@kernel.org>
In-Reply-To: <20261021155505.67208-1-phx0fer@gmail.com>
References: <20261021155505.67208-1-phx0fer@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag blames the wrong commit.
- [Medium] The new lower-bound check does not reject every value below 2,
  even though the patch title says it does.
- [Medium] net: signedness mismatch in flow_limit_table_len_sysctl()
  accepts INT_MIN

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  Documentation/networking/scaling.rst does not match the code.

--

net: reject flow_limit_table_len values below 2

This patch makes flow_limit_table_len_sysctl() reject a length of 1 as
well as values that are not powers of two. A length of 1 gave
log_buckets == 0, so skb_flow_limit() computed hash_32(hash, 0). That is a
shift by 32, and it produced an out-of-bounds index into the buckets[]
array.

> Fixes: 99bbc7074190 ("rps: selective flow shedding during softnet overflow")

[Severity: Medium]
Is this the right commit for the Fixes: tag?

Before c3025e94daa9 ("net: rps: change skb_flow_limit() hash function"),
skb_flow_limit() computed the bucket index with a mask:

    new_flow = skb_get_hash(skb) & (fl->num_buckets - 1);

and flow_limit_cpu_sysctl() stored:

    cur->num_buckets = netdev_flow_limit_table_len;

With a length of 1 the mask is 0. The index was always 0, which is inside
the one-byte buckets[] array.

The shift by 32 only became possible when c3025e94daa9 changed this to:

    new_flow = hash_32(skb_get_hash(skb), fl->log_buckets);
    cur->log_buckets = ilog2(netdev_flow_limit_table_len);

With the current tag, stable branches older than c3025e94daa9 would pick
this patch up. In those branches it fixes nothing, but writing 1 to
net.core.flow_limit_table_len would start returning -EINVAL.

Should this be the following instead?

Fixes: c3025e94daa9 ("net: rps: change skb_flow_limit() hash function")

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index eb35da3556f4a..bb0fa69f94f5a 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -283,7 +283,12 @@ static int flow_limit_table_len_sysctl(const struct ctl_table *table, int write,
>  	ptr = table->data;
>  	old = *ptr;
>  	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> -	if (!ret && write && !is_power_of_2(*ptr)) {
> +	/* A length of 1 is a power of two but gives log_buckets == 0,
> +	 * which makes skb_flow_limit() compute hash_32(hash, 0) -- a
> +	 * shift by 32 -- and index the one-byte buckets[] array with the
> +	 * full 32-bit hash.  Require at least two buckets.
> +	 */
> +	if (!ret && write && (*ptr < 2 || !is_power_of_2(*ptr))) {

[Severity: Medium]
Does the new lower bound hold for every value proc_dointvec() can
store here?

netdev_flow_limit_table_len is a signed int, and proc_dointvec()
parses writes through proc_int_u2k_conv_uop(), which accepts
"-2147483648" and stores INT_MIN. flow_limit_table_len_sysctl() then
reads the result through unsigned int *ptr and sees 0x80000000. That
is not below 2, and is_power_of_2() is true for it, so the write is
accepted even though the subject says values below 2 are rejected.

If a CPU is then enabled through net.core.flow_limit_cpu_bitmap,
flow_limit_cpu_sysctl() computes

    len = sizeof(*cur) + netdev_flow_limit_table_len;

which comes out negative, and kzalloc_node(len, GFP_KERNEL, ...) sees
it as a huge size_t. Without __GFP_NOWARN, that reaches
WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp) in alloc_order_allowed().

The check also has no upper bound, and that matters beyond the
allocation size. struct sd_flow_limit records recent bucket indices in
u16 history[FLOW_LIMIT_HISTORY], but skb_flow_limit() computes

    new_flow = hash_32(skb_get_hash(skb), fl->log_buckets);

For a table length above 65536, log_buckets is above 16 and new_flow
is truncated when it is stored into fl->history[]. When that entry
ages out, fl->buckets[old_flow] is decremented for a different bucket
than the one that was incremented. Buckets at index 65536 and above
are incremented but never decremented, so flows that hash there end
up being limited no matter what their real rate is. Lengths from 2^17
through 2^21 still allocate successfully, so this happens without any
warning. Larger values hit the same allocator WARN as the INT_MIN
case.

None of this reads or writes out of bounds, and both the INT_MIN case
and the missing upper bound predate this patch. But since the patch is
tightening exactly this range check, could it be closed completely?
For example, proc_dointvec_minmax() with extra1 = 2 and
extra2 = 1 << 16, together with the existing is_power_of_2() check,
would compare as a signed int and match the u16 history[] limit. Or
is there a reason to keep accepting lengths above 65536?

[Severity: Medium]
Does this check reject every value below 2?

netdev_flow_limit_table_len is a signed int that proc_dointvec() parses.
flow_limit_table_len_sysctl() reads it through an unsigned pointer:

    unsigned int old, *ptr;

so *ptr < 2 is an unsigned comparison.

proc_int_u2k_conv_uop() accepts a write of "-2147483648":

    if (u > (ulong) INT_MAX + 1)
        return -EINVAL;
    WRITE_ONCE(*k_ptr, -u);

and this stores INT_MIN. As an unsigned value, 0x80000000 is not below 2,
and is_power_of_2(0x80000000) is true, so the write succeeds.

The check also has no upper bound, so powers of two up to 2^30 are
accepted.

Later, when a CPU is enabled through net.core.flow_limit_cpu_bitmap,
flow_limit_cpu_sysctl() does:

    len = sizeof(*cur) + netdev_flow_limit_table_len;
    ...
    cur = kzalloc_node(len, GFP_KERNEL, cpu_to_node(i));

For INT_MIN, len is negative and turns into a huge size_t. For values of
2^22 or more, the request needs an order above MAX_PAGE_ORDER. In both
cases the call goes through
kzalloc_node()->___kmalloc_large_node()->__alloc_frozen_pages_noprof()
and reaches alloc_order_allowed():

    return !(WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp));

This WARNs, because __GFP_NOWARN is not set. flow_limit_cpu_sysctl() then
returns -ENOMEM partway through its per-CPU loop. The CPUs it already
changed are not rolled back.

The allocation fails, so nothing is read or written out of bounds. The
INT_MIN case and the missing upper bound were also already there before
this patch. But the subject line says values below 2 are rejected, and
INT_MIN still gets through.

Would proc_dointvec_minmax() with extra1 = 2 and a reasonable extra2 cover
both cases? One example is 1 << 16, given the u16 history[] limit.
Comparing as a signed int would also fix the lower bound.

>  		*ptr = old;
>  		ret = -EINVAL;
>  	}

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
Documentation/networking/scaling.rst doesn't match the code. Its Flow Limit
section says the count is kept:

    count over the last 256 packets. If a flow exceeds a set ratio (by

but net/core/dev.h defines:

    #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */

That is 128, and it is the window skb_flow_limit() actually uses.

The description of net.core.flow_limit_table_len in the same file also
says nothing about valid values. It mentions neither the power-of-two
requirement nor the new minimum of 2, and writes of any other value fail
with -EINVAL.

Could the documentation be updated along with this change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155505.67208-1-phx0fer%40gmail.com
