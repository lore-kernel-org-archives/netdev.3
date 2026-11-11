Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434416;
	b=kjiElpmBQOg8G7EAdxB7LtXpfBU2d8Pd8j0TwE0CqXTUxxlNXI8pv2inxD4qHQG+i2mY
	 IRdOeVfvs4vYG1VXqlir/OG6kn9T22bR82gunomQK0Ecr6WouuhfOHn/Cj91gaoK94xDR
	 yuSGd2GIsGP9NlFVp8ae2RpPioOEkG3o8L4Kv99YCfPDP1JG2hFY4L+t7I/7gMRo5XOfB
	 YpfOciSxGzSxnKqwXBjdCWeaQ4uD1iAVigS4vs0Sexau7CwI0EqrEmuckuEP7SwwCD/yI
	 z3B68paX7WxbvwR197EvtZu6QdHSGQo+D+ZI8+zcu/L/nF23cFq7VXlUhPdwmgGafBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434416;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=unfiBAflFFEpCG3dRIJsCPzJVGSDGkOzgz05GrP4H0Q=;
	b=MibpxCBcy3r9a96X9ac6IJE5bX/MsXX0aXlCYp5Akh7g9iaeAB1JKDpaDAIcFnL2IKDR
	 9Cw+1SFRqI2CsOXx83eok+EexKWEFKijQnF7mH+IC/vYmri+jD3rScTjrq1ogV6t5Hkjo
	 x0QbwW3a4xD6Rqz/1eIh3DawQPnTIqHZhzEoI79opOAEXGZ58IZ4oYv6TmEIm6ycNTdgc
	 PfVB2WoPdmpTnkTAYQA+2Wy9MZCEnxNqZ1pViOkpwPTTRCIyJIAY30+S/krtprbRswjFg
	 tckMcUoknDhEdCmsx1hPRrrEEibE6LIoD6o8HVMdVK8XmYDRQIFqiQk1psyD6CVz79w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8Wxw4uX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4560A380B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8Wxw4uX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5971F00A05;
	Wed, 11 Nov 2026 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434416;
	bh=unfiBAflFFEpCG3dRIJsCPzJVGSDGkOzgz05GrP4H0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R8Wxw4uXdPmZcmviyqNzouiTY4Z5vcHhax05dunRoLL1halGvB1EW6hlFeQIkOA92
	 3v33rdnIStYl8z/fGOzr1zO/TClpKTxXWFvyyA7yQu8lozQFW7pRzIG2djA78w5gAQ
	 ZAtv2WMZeNzopwKrjXi93BcKjpfZB+3fpFZ27W7H5BgjQC6H2tJZbE3MTsjSziNBDZ
	 6jO6jsoXbKcPIj4oA2FoIsa7+HQ7cR4yZnKGiMzqs1y3nTmgPXd8dwvaCoCf2NvpfM
	 qyNGuO19dUaB5HUMtr7Pq0TFxJmCqrsNB+80NcHI83/V5Vp5Pt913EBZGIdpPX8S+1
	 glDL0d/6+Mc2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E1C9391AFAA;
	Wed, 11 Nov 2026 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/15] net: skbuff: follow-ups to the BUG_ON()
 removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443441492.1663612.10817269880170067726.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:00:14 +0000
References: 
 <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: 
 <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Nov 2026 20:47:12 +0000 you wrote:
> v1: https://lore.kernel.org/all/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com/
> v2: https://lore.kernel.org/all/20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com/
> v3: https://lore.kernel.org/all/20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com/
> 
> v3->v4:
> - 1: the !sg && csum branch of skb_segment() returns -EFAULT instead of
>   -ENOMEM when skb_copy_bits() fails, like the branch next to it.  The
>   new cases in 12 made that stand out.  I kept Mina's Reviewed-by.
> - 12: run the nested and short skb cases without SG too (Willem).
> - 11: no code change.  The commit message was wrong that the path
>   without SG was fine before.  Three of the new cases in 12 hit the NULL
>   pointer dereference without SG if the list_skb check in the clone
>   branch condition is taken out, because the walk reads list_skb before
>   it looks at SG.
> - Picked up Mina's Reviewed-by on 1 and Acked-by on 4, Willem's
>   Reviewed-by on 11 and 12, and Juergen's Reviewed-by on 13.
> - No other changes, same base as v3.
> v2->v3:
> - 1, 2, 6: move the frag_list recursion into a noinline function, so
>   that taking the address of a local there doesn't give the helpers a
>   stack protector (Paolo).  On x86_64 defconfig plus CONFIG_IP_SCTP
>   none of skb_copy_and_csum_bits(), skb_checksum_full(),
>   skb_crc32c_full() or the two wrappers has one now, and
>   __ip_append_data(), __ip6_append_data() and skb_segment() are
>   unchanged.  The callers that pass a local do gain one.  Besides the
>   seven I listed on v2, that's __skb_gro_checksum_complete() and
>   skb_checksum_help(), which are converted in this version, and
>   skb_crc32c_csum_help().
> - 1: put the Fixes: tags back (Fernando, Sashiko).  csump in the
>   prototype, and drop the "Both of above in one bottle" comment
>   (Fernando).  skb_copy_and_csum_dev() zeroes the whole frame when the
>   copy fails, since leaving the checksum alone doesn't guarantee a bad
>   one (Sashiko).
> - 2, 6: the kernel-doc describes the unreadable check as it is, the
>   wrappers don't blame unreadable frags for -EINVAL, and the commit
>   messages say what changes for a failing frag_list member (Fernando,
>   Sashiko).
> - 2: convert skb_checksum_help() too, as 6 does for its crc32c twin, and
>   add Fixes: 20ddd0fd2fcd.
> - 3: convert __skb_gro_checksum_complete() too (Fernando, Sashiko).
>   Take the skb off CHECKSUM_COMPLETE on failure.  Otherwise conntrack,
>   which doesn't drop on a bad checksum, leaves the pseudo-header sum in
>   skb->csum and TCP's validation accepts the packet after all
>   (Sashiko).  Update the comments, and add Fixes: 65249feb6b3d.
> - 4: the commit message was wrong that devmem TX reaches this checksum.
>   Its skbs carry SKBFL_SHARED_FRAG, so the segment fails to linearize
>   first.  The patch is hardening, and the commit message says so now.
> - 5: when the tail can't be checksummed but what's left can be read,
>   set CHECKSUM_NONE instead of failing the trim, which dropped packets
>   that used to be accepted (Sashiko).  Retitled, and add Fixes: tags.
> - 7, 8: add the Fixes: tags for the original commits, and correct the
>   history in 8's commit message (Sashiko).  8 also says what it takes
>   to reach the memcpy().
> - 7: reject a negative @len or @hlen on entry.  The reorder left nothing
>   ahead of the skb_put(), which panics on one.
> - 8: the truesize check refuses the coalesce instead of only warning,
>   and runs before the head is stolen.  With len unsigned and nothing
>   else, an skb with a len above INT_MAX went from refused to coalesced.
> - 9: check data_len > len directly and zero the frame.  The old check
>   missed CHECKSUM_PARTIAL (Sashiko).  Retitled.
> - 10: drop both len > 0 tests, and correct what the commit message says
>   they covered (Sashiko).
> - 9, 10: drop the Fixes: tags.  Both problems are older than the commits
>   the tags named, and neither has a known trigger.
> - 11: Willem, this one changed again after you OK'd the walk up front.
>   A nested frag_list is only one way for the walk to run out of members.
>   A len that counts bytes the skb doesn't hold gets to the same NULL
>   pointer dereference, and the walk up front doesn't catch that.  So the
>   patch now checks for a NULL list_skb in the three places where the
>   walk moves on to it, and that's all it does: no pass up front, which
>   also takes care of the cost you pointed out for BIG TCP, and none of
>   v2's skb_has_frag_list() tests.  You asked on v2 whether the first two
>   checks were needed.  For a nested frag_list they weren't, for this
>   they are.  12 has a case for each, and taking any one of the three
>   checks out brings the oops back.  The path without SG is left alone
>   again.  The commit message says that IP reassembly does nest
>   frag_lists, just not on GSO skbs (Sashiko).  Retitled.
> - 12: add four cases for a len that counts bytes the skb doesn't hold.
>   Retitled.
> - 13: correct what the commit message says about when bounce_skb() runs
>   and when skb_copy_bits() fails.
> - 14: update the comment above skb_nsg() (Sashiko).
> - 15: one more stale comment, in net_test.c.
> - Picked up Fernando's Reviewed-by on 4.  Dropped Mina's on 1 and
>   Fernando's on 2, since the frag_list loop moved in both, and Willem's
>   on 12, since it grew.
> - Shortened the commit messages.
> - Rebased onto current net-next.
> v1->v2:
> - skb_segment(): check each frag_list member as the walk takes it,
>   instead of an extra pass over the frag_list up front (Willem).
> - KUnit test: braces around the suppressed skb_segment() call (Willem),
>   and the comment update for the non-uniform case moved into the same
>   patch (Mina).
> - Picked up Willem's Reviewed-by and Mina's Acked-bys.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/15] net: skbuff: make skb_copy_and_csum_bits() report unreadable frags
    https://git.kernel.org/netdev/net-next/c/23fe6ac2e97a
  - [net-next,v4,02/15] net: skbuff: add skb_checksum_full() that reports failure
    https://git.kernel.org/netdev/net-next/c/2a1e46c16105
  - [net-next,v4,03/15] net: skbuff: fail checksum validation when the skb can't be checksummed
    https://git.kernel.org/netdev/net-next/c/3fe3f8beef7e
  - [net-next,v4,04/15] net: skbuff: fail segmentation when a segment can't be checksummed
    https://git.kernel.org/netdev/net-next/c/7fec569df355
  - [net-next,v4,05/15] net: skbuff: drop hw csum if trim can't checksum tail
    https://git.kernel.org/netdev/net-next/c/05938d3edbdb
  - [net-next,v4,06/15] net: skbuff: add skb_crc32c_full() that reports failure
    https://git.kernel.org/netdev/net-next/c/b8f3a11ff453
  - [net-next,v4,07/15] net: skbuff: let skb_zerocopy() copy a short skb without head_frag
    https://git.kernel.org/netdev/net-next/c/86cc1a8a942b
  - [net-next,v4,08/15] net: skbuff: make skb_try_coalesce()'s len unsigned
    https://git.kernel.org/netdev/net-next/c/b242a00c2bc3
  - [net-next,v4,09/15] net: skbuff: reject data_len > len in copy_and_csum_dev
    https://git.kernel.org/netdev/net-next/c/3133a780ef89
  - [net-next,v4,10/15] net: skbuff: reject a negative length in skb_copy_and_csum_bits()
    https://git.kernel.org/netdev/net-next/c/2173a320e20d
  - [net-next,v4,11/15] net: skbuff: don't run off frag_list in skb_segment()
    https://git.kernel.org/netdev/net-next/c/e447e46ce976
  - [net-next,v4,12/15] net: test the skb layouts skb_segment() refuses
    https://git.kernel.org/netdev/net-next/c/7d02a2b23764
  - [net-next,v4,13/15] xen-netfront: don't BUG() when skb_copy_bits() fails in bounce_skb()
    https://git.kernel.org/netdev/net-next/c/ece597f62085
  - [net-next,v4,14/15] net/tls: don't BUG() on leftover length in __skb_nsg()
    https://git.kernel.org/netdev/net-next/c/e021a72ee9cb
  - [net-next,v4,15/15] net: update comments that still describe the skb BUG_ON()s
    https://git.kernel.org/netdev/net-next/c/c0073ae6e9d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


