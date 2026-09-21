Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BB449B21
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976754; cv=none; b=N5m0K2OXEifQnKpie4rPdM0jHx9NWKwM1KIRfajv8A54nlkYwe3444BKxJxHa6DQr98GdpE5U76pDU9U/nFIRLTMJ1QhAAcI6IBjUntGe05zWn/wMqgR5Hh3yTfyYYqMsFFXhVbsxC6gNomV6w3RAbT0Wszl1CeT1hSQTBTXohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976754; c=relaxed/simple;
	bh=8gwRQoywcKmC6kkD5djwWIixCXWA6M6E5flAOaKMijo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7k2owJfCbwWuqISaf2em1GEJmcbdcb84x/BS5SN5iu5WDa50f4s4sdD7zm5vXfVpOBJq4WOROgJ+mHGdVpfNgwYoGk2QcaJLNrv4c3REe91/JjgJlgylKD9oEdL9lbTEKyYc90ysx6o9LUMDv/LyZbPfDuGntYho4u/DgUexuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y57ZPITu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y57ZPITu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B31F000FF;
	Mon, 21 Sep 2026 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789976752;
	bh=ihe/piokdbpzw5gyUyu9TDQ9s1gHYBFXP+vk1T0qdgo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y57ZPITuk+AiuFpaOkcSlOBfczR4z2ZH8mOwPkwV79YtnLFPf/z+yD97YsV2morxF
	 cy5YKOXwVaWOLqqWAOWtYzm2vkeYe1WEmMXbFSbi8uWrRze5L2VBxU5BBwBLAf1PcG
	 aHTz6Mzxmae6iqUKuhy9V/ikck8JRxEzesFjBXRopl42Y8ZcsvXeA6ip43wxst1xE3
	 kUgM5YbRVeG4xX789DFh18kY80ADR2nCuOtRGsz52EsnW4wLB3uBitK+37PzImUJ/S
	 ffx/YB89QzQkNI1686Xc73RZzglIOqhrui5DoWQLi8QV1fpXISIIQF5x8A4oYEIpfA
	 R4yTTOnM+ZgOw==
Subject:
 Re: [PATCH net] net/sched: act_ife: validate metadata length before decoding
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, xiyou.wangcong@gmail.com
Date: Mon, 21 Sep 2026 07:45:51 +0000
Message-ID: <178997675182.2160803.3145510829619751243@kernel.org>
In-Reply-To: <20260920074245.79965-1-fangxy@xiaopeng.com>
References: <20260920074245.79965-1-fangxy@xiaopeng.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New error class from the decode callbacks is misreported by
  the unchanged caller.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  rewrites exactly the offending load statements and keeps the unaligned…

--

net/sched: act_ife: validate metadata length before decoding

This adds a length check to skbmark_decode(), skbprio_decode() and
skbtcindex_decode() so that a TLV whose payload is shorter than the
expected metadata size is rejected with -EINVAL instead of being read
past the declared value.  The caller keeps decoding the remaining
metadata after a decoder failure.

No Link: tags present in the commit header.

> diff --git a/net/sched/act_meta_mark.c b/net/sched/act_meta_mark.c
> index ea0573cb8b2d..3a7d568df0da 100644
> --- a/net/sched/act_meta_mark.c
> +++ b/net/sched/act_meta_mark.c
> @@ -28,8 +28,12 @@ static int skbmark_encode(struct sk_buff *skb, void *skbdata,
>  
>  static int skbmark_decode(struct sk_buff *skb, void *data, u16 len)
>  {
> -	u32 ifemark = *(u32 *)data;
> +	u32 ifemark;
>  
> +	if (len != sizeof(ifemark))
> +		return -EINVAL;
> +

[Severity: Medium]
Is the new -EINVAL return reported correctly by the caller?  Before this
patch all three decoders returned 0 unconditionally, so a non-zero return
from find_decode_metaid() could only mean -ENOENT:

net/sched/act_ife.c:find_decode_metaid() {
	list_for_each_entry_rcu(e, &p->metalist, metalist) {
		if (metaid == e->metaid) {
			if (e->ops) {
				/* We check for decode presence already */
				return e->ops->decode(skb, mdata, mlen);
			}
		}
	}

	return -ENOENT;
}

The decoder return value is passed through verbatim, so tcf_ife_decode()
cannot tell a length error apart from an unconfigured metaid:

net/sched/act_ife.c:tcf_ife_decode() {
		if (find_decode_metaid(skb, p, mtype, dlen, curr_data)) {
			/* abuse overlimits to count when we receive metadata
			 * but dont have an ops for it
			 */
			pr_info_ratelimited("Unknown metaid %d dlen %d\n",
					    mtype, dlen);
			qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
		}
}

So a frame carrying IFE_META_SKBMARK with len == 4 (dlen == 0) on an
action where SKBMARK is configured now logs "Unknown metaid 1" and bumps
the overlimits qstat, even though the metaid is registered and
configured.

Would it make sense to special case -ENOENT in tcf_ife_decode(), give
the length failure its own message, and update the comment so the
in-tree text and the operator-visible diagnostic still match what the
code does?  That log line is what an operator would look at while
triaging exactly the malformed-frame flood this patch hardens against.

> +	ifemark = *(u32 *)data;
>  	skb->mark = ntohl(ifemark);
>  	return 0;
>  }

[Severity: Medium]
This isn't a regression introduced by this patch, but since the load
statement is being rewritten anyway: is the plain u32 cast safe on
strict-alignment architectures?

The pointer comes straight from the on-wire frame layout.  ife_decode()
returns &ifehdr->tlv_data with ifehdr at skb->data + ETH_HLEN, and
struct ifeheadr starts with a __be16, so the first TLV sits at
mac_header + 16.  ife_tlv_meta_decode() then returns:

net/ife/ife.c:ife_tlv_meta_decode() {
	...
	return skbdata + sizeof(struct meta_tlvhdr);
}

which is mac_header + 20.  With the default NET_IP_ALIGN == 2 in
include/linux/skbuff.h (only x86, arm64 and powerpc override it to 0),
the MAC header is at an address congruent to 2 mod 4, so data is 2-byte
but not 4-byte aligned, and following TLVs inherit the same offset since
they are only NLA_ALIGN() spaced from that base.

That makes the two u32 loads in skbmark_decode() and skbprio_decode()
misaligned on the strict-alignment architectures (ARM32, MIPS, RISC-V,
sparc32), where the result is either an incorrect skb->mark /
skb->priority or a per-packet alignment fault fixup.  The u16 load in
skbtcindex_decode() happens to be aligned, but uses the same idiom.

Would get_unaligned_be32(data) / get_unaligned_be16(data) be preferable
here?  That also drops the now redundant ntohl()/ntohs().

> diff --git a/net/sched/act_meta_skbprio.c b/net/sched/act_meta_skbprio.c
> index 2df3133ce5ad..fa4ba4269ca0 100644
> --- a/net/sched/act_meta_skbprio.c
> +++ b/net/sched/act_meta_skbprio.c
> @@ -33,8 +33,12 @@ static int skbprio_encode(struct sk_buff *skb, void *skbdata,
>  
>  static int skbprio_decode(struct sk_buff *skb, void *data, u16 len)
>  {
> -	u32 ifeprio = *(u32 *)data;
> +	u32 ifeprio;
>  
> +	if (len != sizeof(ifeprio))
> +		return -EINVAL;
> +
> +	ifeprio = *(u32 *)data;
>  	skb->priority = ntohl(ifeprio);
>  	return 0;
>  }
> diff --git a/net/sched/act_meta_skbtcindex.c b/net/sched/act_meta_skbtcindex.c
> index 44547caead46..48f001ada8f6 100644
> --- a/net/sched/act_meta_skbtcindex.c
> +++ b/net/sched/act_meta_skbtcindex.c
> @@ -28,8 +28,12 @@ static int skbtcindex_encode(struct sk_buff *skb, void *skbdata,
>  
>  static int skbtcindex_decode(struct sk_buff *skb, void *data, u16 len)
>  {
> -	u16 ifetc_index = *(u16 *)data;
> +	u16 ifetc_index;
>  
> +	if (len != sizeof(ifetc_index))
> +		return -EINVAL;
> +
> +	ifetc_index = *(u16 *)data;
>  	skb->tc_index = ntohs(ifetc_index);
>  	return 0;
>  }

The same two questions apply to these two hunks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920074245.79965-1-fangxy%40xiaopeng.com
