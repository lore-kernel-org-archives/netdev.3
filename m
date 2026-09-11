Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A135F602
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160891; cv=none; b=Amv3ypDjtLov2/OV+JkRfrX8AjKtnpnviU1w8Ms5QNgMMTMvegh0hlgyoqCn7agBt2t2f+wUUaBUYqk9XnrF+qKlPi7Ijtkj2eaSSr5zIKRY+42kO2AzRXCUmECh4lnzv79I+OKc7RoMV5f5bg+YRiMH2Xg0Y9nb4SJYh5TivAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160891; c=relaxed/simple;
	bh=OYpTZuGPV/D0r3me4ty1m5kYnCc2y9qCJVtwE8uWqvY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5p7uH/H48SYSlU3o4CrBX/zKSOcfc3LIqBCIN9v9eVqI1vO+rf+MeCzP/lRm1L88/rZcAvjNLKqy2zwcU+TRf4HkI8Il8rnY1EdLWIxiy2HmH7wjxhmwfAea8fq4PgV09Eo6lfek7usHizIO14wxtrxonJn6y9L4XOgh5bXhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRoZkz25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRoZkz25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2BA1F000FF;
	Fri, 11 Sep 2026 21:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789160889;
	bh=QU6Us7me6hkAuzJ+YiJrSu4YSUiuxPvohkqeDP1V0mA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oRoZkz25zPSSAc4BW061Uh2jqjFahhRhjkMKsCvkjls2wU/nmny1YnLN/g+MWfq6Y
	 68BovKJeXHXN5ZKcgfmB1MoUdmvh9YuTi5SQanHed7dOikt6+bZ9lg70oCOu3pxGd6
	 tWphaG9p64I6rCiwU8xWzvd3ZmshfbrmmwcntoZywOfjppsPCvzJR8f0SdanePe0m3
	 aDdJvL8aTJohuKQzRS02y7ImieQX1MyRIJkuBs9Bw12N9pcLkvFEYNZDTVv++zYnAw
	 bMK68nGeRinYmIF6KanCf1fBUVBGkgrY91L09KcmT+fNRGoFMpZfrRcpTQiUpmDbQQ
	 QpqY0+C7cLV1g==
Subject: Re: [PATCH net 4/4] drop_monitor: fix out-of-bounds write in
 reset_per_cpu_data()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Fri, 11 Sep 2026 21:08:08 +0000
Message-ID: <178916088869.219967.8693161380477380266@kernel.org>
In-Reply-To: <20260910204612.3762015-5-edumazet@google.com>
References: <20260910204612.3762015-5-edumazet@google.com>
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

- [Medium] Commit message overstates the impact: the pre-patch memset()
  in reset_per_cpu_data() (net/core/drop_monitor.c:165) is NOT an out-…

--

drop_monitor: fix out-of-bounds write in reset_per_cpu_data()

The patch stops adding sizeof(struct nlattr) to al in
reset_per_cpu_data(), and instead allocates the skb with
genlmsg_new(nla_total_size(al), GFP_KERNEL) so that al describes only the
attribute payload that is later zeroed via memset(msg, 0, al).

> diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
> index 795c15dd1771a..edc660778408e 100644
> --- a/net/core/drop_monitor.c
> +++ b/net/core/drop_monitor.c
> @@ -141,9 +141,8 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
>  
>  	al = sizeof(struct net_dm_alert_msg);
>  	al += dm_hit_limit * sizeof(struct net_dm_drop_point);
> -	al += sizeof(struct nlattr);
>  
> -	skb = genlmsg_new(al, GFP_KERNEL);
> +	skb = genlmsg_new(nla_total_size(al), GFP_KERNEL);

[Severity: Medium]
Is the impact described in the changelog accurate?  The subject says "fix
out-of-bounds write", and the body says the memset() is

    exceeding the allocated buffer by sizeof(struct nlattr) (4 bytes) and
    corrupting skb_shared_info.

With the in-tree constants, dm_hit_limit is a fixed "static int
dm_hit_limit = 64" with no module_param and no way for userspace to change
it, sizeof(struct net_dm_alert_msg) is 4 and sizeof(struct
net_dm_drop_point) is 12, so the old al was 4 + 768 + 4 = 776.

That gives genlmsg_new(776) -> nlmsg_new(780) -> alloc_skb(796), and with
nlmsghdr [0,16), genlmsghdr [16,20) and the nlattr header [20,24), msg sits
at offset 24 and memset(msg, 0, 776) writes up to offset 800, i.e. 4 bytes
past the 796 bytes that were requested.

But the head buffer that gets allocated is larger than the request, and
skb_shared_info is placed at the end of the rounded-up zone:

net/core/skbuff.c:kmalloc_reserve() {
	...
	obj_size = SKB_HEAD_ALIGN(*size);
	...
	obj_size = kmalloc_size_roundup(obj_size);
	*size = (unsigned int)obj_size;
}

net/core/skbuff.c:__alloc_skb() {
	...
	/* kmalloc_size_roundup() might give us more room than requested.
	 * Put skb_shared_info exactly at the end of allocated zone,
	 * to allow max possible filling before reallocation.
	 */
	__finalize_skb_around(skb, data, size);
}

For a 796-byte request SKB_HEAD_ALIGN(796) is 832 + 320 = 1152, which
kmalloc_size_roundup() rounds to 2048, so skb->end lands near offset 1728
and the 4 extra zeroed bytes fall in unused tailroom.  KASAN would also not
report anything, since kmalloc is called with the already-rounded size.  The
small-head-cache path gives *size = SKB_SMALL_HEAD_CACHE_SIZE, which is also
comfortably above 800.

Also, nla_total_size(772) is 776, exactly the previous genlmsg_new()
argument, so the allocation size is unchanged by this patch; only the memset
length shrinks from 776 to 772, which matches the usable payload (796 - 24 =
772 = 4 + 64 * 12) and the fill limit enforced in trace_drop_common().

The code change itself looks correct, but with the Fixes: 683703a26e46 tag
this will be picked up for stable and CVE triage as an out-of-bounds write.
Could the changelog be reworded to describe it as a size-accounting cleanup,
and to drop the claim about corrupting skb_shared_info?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910204612.3762015-1-edumazet%40google.com
