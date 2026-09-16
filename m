Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC22EA15C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563933; cv=none; b=R2pafSajeoiwCwkg0Ou1hsZ40EmcfzDAY8ujwsKhIeZUsDiFO+yJ+RuAo/HU5xYbhh2nIgzJM6BaW9GFpdzsxwVa6Ih3NHHigZrBPwB190LJo5yX9Mt2glD4d37QJaAiq6I9u5XnC5GiAvb1hNjzTnlsnLkIqExHtU2bWwpcJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563933; c=relaxed/simple;
	bh=UeH2UGk52k+SKj9tD9AGMqAfOV7JIXNvyWwvPitzd1U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqfcuiGOoUE+jxx0GPH8beDJYI5A7guTK8yNqvqrmxm7/VPdGC2jEYa5NL25yhCoR8RBycxBqsDFLbj/Ax6bS+W6DTuxN2bwhAvZJnARicxUBlOwYCoozcgunybbch12A9koGEtRhplj95PNuw7pUxutVl8BvdH3el7O/WlGeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMT3cOU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMT3cOU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF231F000FF;
	Wed, 16 Sep 2026 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563932;
	bh=6gJ7OjGqFuhbohkbs30QVsuyYkxAUMRLJXF4ROwv9bI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OMT3cOU89qDSAUkHDarIsL6CfNMYspk0IsLW3om3dzLyTeyUAAXdLa66/5bf1yD6D
	 CgsTPEsgwNrdM0b7Gkc9Z2gAGWkO7FxJ4WL7URdbgYAJybChc5C/zUazmSihCKRZ1E
	 OYIdMhprJZxmsFao8tZKn0jI9+lQ3KgtGwCEmhfpgkHpPy023x5MadHfui5N9WUhtD
	 mMiGb5In1VuD+uE0cTiaVAJw+KXXkHc8KJxhXGKDHXRg2pJt51GDpjeOPcdwg38q3j
	 Ufsu7ON5PsRTV/15q0bg6kY1uRAkDycAh2EpLt9GWAhQ1IgPsc3pTSorPCt9/SV/dd
	 +VbUGOa23jJvg==
Subject: Re: [PATCH v2 net] net: skbuff: do not leave stale header offsets
 after pskb_carve()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 xuanqiang.luo@linux.dev, achender@kernel.org, rds-devel@oss.oracle.com
Date: Wed, 16 Sep 2026 13:05:31 +0000
Message-ID: <178956393100.22033.7676411417898444402@kernel.org>
In-Reply-To: <20260915130423.3956471-1-edumazet@google.com>
References: <20260915130423.3956471-1-edumazet@google.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete invalidation of checksum metadata in the new
  skb_carve_reset_headers() (net/core/skbuff.c:6842).

--

net: skbuff: do not leave stale header offsets after pskb_carve()

The two pskb_carve() helpers used to call skb_headers_offset_update(skb, 0),
which left mac/network/transport offsets describing bytes that were just
removed. This patch adds skb_carve_reset_headers() to unset the mac and
transport headers, reset the network header, clear mac_len, zero the inner
header state, and downgrade CHECKSUM_PARTIAL to CHECKSUM_NONE.

Closes: https://lore.kernel.org/netdev/6aa3e9d3.f2639fcc.29487d.0028.GAE@google.com/

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index cc3b4b70288b4..609f2c7f4a47a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6832,6 +6832,34 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>  }
>  EXPORT_SYMBOL(alloc_skb_with_frags);
>  
> +/* pskb_carve_inside_header() and pskb_carve_inside_nonlinear()
> + * remove the first bytes of a packet and reallocate skb->head.
> + *
> + * Whatever headers were present before the operation are gone,
> + * we must not leave stale offsets, otherwise users of this skb
> + * (skb_dump(), drop_monitor, taps, ...) would read or pull garbage.
> + */
> +static void skb_carve_reset_headers(struct sk_buff *skb)
> +{
> +	skb_unset_mac_header(skb);
> +	skb_unset_transport_header(skb);
> +	skb_reset_network_header(skb);
> +	skb->mac_len = 0;
> +
> +	/* Inner offsets have no "unset" marker, zero them so that
> +	 * skb_inner_network_header_was_set() becomes false and no
> +	 * consumer mistakes them for a real (and long gone) header.
> +	 */
> +	skb->inner_mac_header = 0;
> +	skb->inner_network_header = 0;
> +	skb->inner_transport_header = 0;
> +	skb->inner_protocol = 0;
> +	skb->encapsulation = 0;
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL)
> +		skb->ip_summed = CHECKSUM_NONE;
> +}

[Severity: Medium]
The changelog says the goal is that "all the header state is invalidated in
one place".  Is the checksum state fully invalidated here?

skb_carve_reset_headers() only rewrites ip_summed, while skb->csum,
skb->csum_valid, skb->csum_complete_sw, skb->csum_level and
skb->csum_not_inet keep the values they had before the bytes were removed.

For the CHECKSUM_PARTIAL case, the syzbot dump quoted in the changelog shows
the incoming skb already has valid=1:

  csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=1 level=0)

After the downgrade this becomes ip_summed=CHECKSUM_NONE with csum_valid
still 1, and skb_csum_unnecessary() in include/linux/skbuff.h returns true on
csum_valid alone:

  static inline int skb_csum_unnecessary(const struct sk_buff *skb)
  {
	return ((skb->ip_summed == CHECKSUM_UNNECESSARY) ||
		skb->csum_valid ||
		(skb->ip_summed == CHECKSUM_PARTIAL &&
		 skb_checksum_start_offset(skb) >= 0));
  }

Can a consumer of the carved skb then believe the payload was already
verified, even though the bytes the checksum covered are gone?  A leftover
csum_not_inet would similarly still claim CRC32c semantics, and skb_dump()
would print the contradictory "ip_summed=0 ... valid=1".

Should csum_valid, csum_complete_sw, csum_level and csum_not_inet be cleared
in the same helper?

The CHECKSUM_COMPLETE case looks untouched as well.  Unlike
skb_pull_rcsum()/skb_postpull_rcsum(), the carve path never subtracts the off
bytes removed from the front from skb->csum, and pskb_extract() trims the tail
with plain pskb_trim() rather than pskb_trim_rcsum():

  net/core/skbuff.c:pskb_extract() {
	...
	if (pskb_carve(clone, off, gfp) < 0 ||
	    pskb_trim(clone, to_copy)) {
	...
  }

So a CHECKSUM_COMPLETE skb keeps a whole-packet checksum that no longer
matches its contents.  Would it make sense to also drop or fix up
CHECKSUM_COMPLETE in skb_carve_reset_headers(), or to use pskb_trim_rcsum()
in pskb_extract()?

The only in-tree user of pskb_extract() is RDS, which copies the queued data
to userspace and never calls a checksum validation helper, so there is no
functional failure visible today; the concern is the trust bits left on a
generic exported helper.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915130423.3956471-1-edumazet%40google.com
