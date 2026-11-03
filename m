Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674965;
	b=VcfHswcCWwuYvlFsAjF9xUWbW2xV8KnaxgCOIZN9OFi0x8OevA97WZ/606dk727Tsla2
	 aiCAxW7I712kZG/zmu6tboyL0HLbBiU7c2hYh0G9csDIipZhpcKbL/CE32bzx2enDlxpt
	 wuiiC6XMacedj0po6ihYiUDnF0mFuUjQ/IU9Iowu0VkzKITvjP94cB5Uxtm3PYhoRcMKH
	 aJWbxL5sFilA7qwCZ5By8e+78S4Rfpbh1toVrEx7MWa5PXZFsGCR+wE8vSD8qlNsYGq/2
	 5P5vTf1PEHyjOCRQgMCxB8DSP6h/9yLrWk7Ovwul0zsNRVkeRNnYAOkqQE3aek+NB2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z4d6XmbWcRWWI3RSqbOW04ft/6sO/Q2LzJ8s4Oj4NUY=;
	b=YxATVigUWArr3yY1DtYfOcAFZJ6QhLsC2VASBpl8YZDZAmB9TVlsGVRCr6IxQJTEl5mI
	 5bnw6YL3pITR8GmASDjK8vBO1aMs/QiWGL2l+Agm0l/PaVXLZXWxoJCd16xu/q78jzxl/
	 qmnNRFnM0Ih+NMViDAnyfzroOTgTjUUQ5Nj97lORCQzDYpmXUYrCN7rGYfBftqhAQm8UE
	 oaVsKW8C3pg5sEPycbC6tf7e4WZuhrwUyhxPJSXSa1e2nko1rcoyZAiBMhtrHo5kBhv9d
	 N/yl2p0ytfNrUO0Oe6l2epGnNxfJHY0X631pmOX0wr3JiNQFL66RVW9cD8H/CD+5xOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SHc03zoc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE4606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 03:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AE4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SHc03zoc
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso5317a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 19:02:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793674963; cv=none;
        d=google.com; s=arc-20260327;
        b=UF+xvB4hTSI1U4qsLRSlebgIKtvs1A9QOuJ3hKBRhzYYAka475NsoLCa2DLS8fHAus
         /DFFqslEzscPNUjMx7Q5eO2MEeVWLUaFU5ABVsBQjoCVspBDfJVW91zfsDt7ZTaVvdDf
         xGGCYCnlxZV7jSfl2E/LgG54lHOfERTS7WthSLciJsrnIoXM6PX0U/Zsjk9kKNT44XNC
         Y2SPDm6I1V/X2GdD0hZeoNMqL15CxL2rmlOJfn9nAosAZmmU/kDbUuAUxejw3ACOK3HV
         gNtHNAL0O39p/Rm0LBDwTBs8jVkJ+PHOHTnDQDXu7FQ0nF3Fhb7AZWkoTe6d6VBpNkWL
         VkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z4d6XmbWcRWWI3RSqbOW04ft/6sO/Q2LzJ8s4Oj4NUY=;
        fh=6GQzuehEurbmAo2kubD39JWX0L9oYMFUD7XlRkKsluI=;
        b=CcKHeFC0GJ58SJsPs0JgpBI9kSQttRjr10UjJyu1ub/5DV/w9r+4qIUfNvZEGwfPVk
         +s/aZkXEqEbTJh54GJiPsgEEzAd1rblsu5K1grygFyY39/W8XH3mo+C8EqYoEjeOZ714
         QA20LevnVaUYDW6dYyCe1KG3smmSjNkcqaRzKm0AWxJKVlnhsw7v/+gxOWhM4h2IAVxY
         jPUYRmtcStj/NyXXdnu52Us9fTICWOfOA9C1XsQofv9fEtoolz90XQpJgQRkDqXrF69A
         7vjhrStyRvhlygqR50ntx7x6ffcH/Re9ywtdUyTM41wMgXOvHOVzJEdTSCaZLQElABfB
         M79Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793674963; x=1794279763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z4d6XmbWcRWWI3RSqbOW04ft/6sO/Q2LzJ8s4Oj4NUY=;
        b=SHc03zocevjC7KfZIiSlBfK5e81sZxVjzOXl3MqOKfQ9Jr7WnPfUj6tXG1+gKS8Zro
         Lw7gnJcbd/StwoUsE6Cy6Tt8MifjDja9dGfHfvwhnp2YqTnNoKQHTEXfpdLoGIDeQcR/
         clntdUIXrtQpeHsdYTkv+I0SKJ7P4tVj16KRuLGOM7WZCmzBCmKQhqBWbBMwQ4wOzg+j
         agCwvzmKcEBWObdQzyVQ+rLTGS3AZcn+ooepLoIb2cRjFXP5GkMcm79/0dCtOasA54en
         Z/c+KCvG0haSbzJTGLBElAM6pYFycG0QlrFsVQBX+3Otvg40xoWkHxvC09mUBbIa4BO4
         QN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674963; x=1794279763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4d6XmbWcRWWI3RSqbOW04ft/6sO/Q2LzJ8s4Oj4NUY=;
        b=xMP2K2LEhaSjAX0tiY6D2cICnRBiZ8Mgn7cW9XPgR62G7e5fL42ZaoD2PExNvWHp1h
         ETQ7366hyt5TBkaNnRAVva8ifmKbeROapgIX1yrSSer4paBAhnJS2cwNMwEkpk5elucP
         8rFjtWiKiep8Gy1dFXH7MDCVjuodUzX1FTk54H0jl8tipljbEA8uhO9k1tECZddX8PXI
         9qmJJGevEFl/E21lY8yLau8smHZbnA2e6EUF+CjD6SpsfySunn8Gy7TU1WfQ8GCeoPzo
         aQJ6y3AHqBg97ASp9unkQ7tncgGVmKw1a2nJv5/3O808z3j2U5uy01RTzmvzNiAqrYFS
         k+bQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsw2Y/vLf0dc6j9zE77PAWg0Beu5IQcRxr70Tp5+UPxM1ky1DZDUabQXaoF3VvocChCMdwcmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ykk0rvBMI6Mun+7UkoMEJmi+GthvIIcF9IogApo2IKcTF/0bL
	LTaRR1cSCpuAo/imTQRj0LqSYmCrlrlMHelL5wgoNotiMwIvwxK/zgq8igNel0nWuxI0kYlHws5
	8/uX323c64BAvo2R04RvX26KZmjPjcbQFmgwHKWaV
X-Gm-Gg: AYBFou0WMfp6F8VI5VW9CV9J8yKTsHrgVRR4HmQo8ocHLfwEnEW2cxpBDpEbst8S8m1
	VvGOVmHU05GiP9NbivRHcdFlpHn+yppr3FkZQLQ/W+kuqs/ArUAtfEvcSVE6BCYCatB6IIfBwR6
	lmERTAMjsKBGVs1fAw0i+Znd7s7Ib8xYsSLyuvx7lLuiAZAAH5HSAT3joXnuTAxcBwmMpniZfEo
	EAGncFUFr+sXWwmmSHqVrSPtK8RaLNJLDqPmOvVhRd/b8DM3eShFcpTCe5mZB15T/3vvsA0s7KO
	ucUOKnqRFrdj4jFNCdeg13eB5bpoLAsGBYOGn86Magr/wHcHFXNWbNzZwvfvDUltWW8z0C0Dh6D
	ADoICu40ia/y4Sw6o1v8xxLYK2QrEq3JqfDf6piI=
X-Received: by 2002:a05:6402:a0c7:b0:6b4:9221:8932 with SMTP id
 4fb4d7f45d1cf-6b53e97900bmr26656a12.10.1793674962548; Mon, 02 Nov 2026
 19:02:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 19:02:30 -0800
X-Gm-Features: AclHuK9j_VamVmfLtRp6iU-ICWXr3S3wDrU7Ligs7Ww-1otOL5tUZpvUdpJQlZo
Message-ID: <CAHS8izN6+eDztiidOMykUq5A=-7kzsbA+h6rEkkqb1VriPaCGw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/15] net: skbuff: follow-ups to the BUG_ON() removal
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:28=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> v1: https://lore.kernel.org/all/20261019-b4-skbuff-bug-on-followups-v1-0-=
41dbef50b9f7@toxicpanda.com/
> v2: https://lore.kernel.org/all/20261021-b4-skbuff-bug-on-followups-v2-0-=
2aa780a03524@toxicpanda.com/
>
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
> --- Original email (v1) ---
>
> Hello,
>
> Jakub applied v2 of my skbuff BUG_ON() series[1] before I got v3 out, so
> this is what v3 would have changed, as fixes on top of what landed, plus
> the skb_copy_and_csum_bits() patch I'd been sending to net on its own.
>
> Patch 1 is that patch[2], moved to net-next as Mina suggested, with his
> Reviewed-by.  It makes skb_copy_and_csum_bits() report failure, and the
> rest of the series builds on it.  Please drop the net version.
>
> Patches 2 through 6 deal with skb_checksum() and skb_crc32c().  My v2
> had them return 0 when they run out of skb, and that turned out not to
> be safe: 0 is a valid checksum, and it can make a packet that was never
> fully checksummed pass verification.  So they get versions that report
> failure, skb_checksum_full() and skb_crc32c_full(), and the core users
> switch to them: checksum validation now rejects a packet it can't
> checksum, skb_segment() and pskb_trim_rcsum() fail instead of using a
> bad sum, and skb_crc32c_csum_help() drops the packet.  skb_checksum()
> and skb_crc32c() stay as wrappers that behave as before, and I'll
> convert the rest of their callers per subsystem in later series.
>
> Patches 7 through 10 fix problems Sashiko and an LLM review found in
> what was applied.  skb_zerocopy() refuses a zero-length copy that Open
> vSwitch can trigger from a user namespace, skb_try_coalesce() and
> skb_copy_and_csum_bits() can be handed a negative length, and
> skb_headlen() can underflow in skb_copy_and_csum_dev().
>
> Patches 11 and 12 make skb_segment() refuse a nested frag_list, which
> could still oops on a NULL list_skb, and add KUnit cases for the layouts
> it refuses.  Patches 13 and 14 get rid of the same BUG_ON()s in
> xen-netfront's bounce_skb() and tls's __skb_nsg(), and patch 15 updates
> comments that still describe the old BUG_ON()s.
>
> I tested this with the net_core KUnit tests, a test module that drives
> each of these paths under KASAN and fault injection, an Open vSwitch
> reproducer for patch 7, and a stress run over veth with netem.  Thanks,
>
> Josef
>
> [1] https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f73289=
5b@toxicpanda.com/
> [2] https://lore.kernel.org/all/20261013-b4-skb-segment-nosg-unreadable-v=
2-1-6c28d8ffa51e@toxicpanda.com/
>
> ---
> Changes in v3:
> - Link to v2: https://patch.msgid.link/20261021-b4-skbuff-bug-on-followup=
s-v2-0-2aa780a03524@toxicpanda.com
>
> Changes in v2:
> - Link to v1: https://patch.msgid.link/20261019-b4-skbuff-bug-on-followup=
s-v1-0-41dbef50b9f7@toxicpanda.com
>
> ---
> Josef Bacik (15):
>       net: skbuff: make skb_copy_and_csum_bits() report unreadable frags
>       net: skbuff: add skb_checksum_full() that reports failure
>       net: skbuff: fail checksum validation when the skb can't be checksu=
mmed
>       net: skbuff: fail segmentation when a segment can't be checksummed
>       net: skbuff: drop hw csum if trim can't checksum tail
>       net: skbuff: add skb_crc32c_full() that reports failure
>       net: skbuff: let skb_zerocopy() copy a short skb without head_frag
>       net: skbuff: make skb_try_coalesce()'s len unsigned
>       net: skbuff: reject data_len > len in copy_and_csum_dev
>       net: skbuff: reject a negative length in skb_copy_and_csum_bits()
>       net: skbuff: don't run off frag_list in skb_segment()
>       net: test the skb layouts skb_segment() refuses
>       xen-netfront: don't BUG() when skb_copy_bits() fails in bounce_skb(=
)
>       net/tls: don't BUG() on leftover length in __skb_nsg()
>       net: update comments that still describe the skb BUG_ON()s
>
>  drivers/net/ethernet/sun/sunvnet_common.c |  10 +-
>  drivers/net/xen-netfront.c                |   7 +-
>  include/linux/skbuff.h                    |  12 +-
>  net/core/dev.c                            |  14 +-
>  net/core/filter.c                         |   6 +-
>  net/core/gro.c                            |  11 +-
>  net/core/net_test.c                       | 100 ++++++-
>  net/core/skbuff.c                         | 447 +++++++++++++++++++++++-=
------
>  net/ipv4/icmp.c                           |   9 +-
>  net/ipv4/ip_output.c                      |  11 +-
>  net/ipv6/icmp.c                           |   7 +-
>  net/ipv6/ip6_output.c                     |  11 +-
>  net/sunrpc/socklib.c                      |   9 +-
>  net/tls/tls_sw.c                          |   8 +-
>  14 files changed, 515 insertions(+), 147 deletions(-)
> ---
> base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
> change-id: 20261016-b4-skbuff-bug-on-followups-ad11adf285a4
>

Honestly there is nothing super objectionable about the series, but it
seems a bunch of unrelated fixes, capped at 15 because netdev doesn't
let you have more than 15 patches out at once. I wish you broke it up
into less ambitious problems that the human reviewers can follow. But
maybe that's just me.

Like crc checksum failing in 1 series we can follow, and maybe 1
series for a full failable skb_checksum changes in 1 go so we don't
add the new thing before removing the old? Or is that too infeasible?

--=20
Thanks,
Mina
