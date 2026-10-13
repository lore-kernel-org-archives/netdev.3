Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200254528C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921613; cv=none; b=KKT3YBzd/gOizZgqXZQtwdmFlA/c0zQAv4cQOgbziHheaWBqx8Jp+0T+TRSFMomVpZ4pWMLYC9BcvEC5M1tO87QceK6OiaC5dMbelVvAcxwVZzIFKCNQ3llpaUqkqSTMRwWuXf34QiqLk4ITx1c1+ayzJXTRtMzW6QyfzWcB2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921613; c=relaxed/simple;
	bh=b45tsu+eioKXjGWESLNf0TWAtg+PwfGspwvZ/bxJWxc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWTwS9408sDIkJddhD0pqA7qnmqWPICT4Vmaer49go+bHNdDHYzTvvQQiF7+5Gxnpo2teevcbYpN0LXlgugdVJnCWA8Mmr+xfLwdGZcemVCU8Wj3T804d3h3A1eJLOxeLVP5T1Gy7y1VUVqeRPgg0gelADVnoWc7kYbGGw/p8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJH7hiOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJH7hiOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8831F000FF;
	Tue, 13 Oct 2026 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921611;
	bh=II7YZB1fMbxeuKfkzDZZ3r+IByv1oRdAaVPiFHHTxAU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DJH7hiOaodkUZIJkupc7sFCbEOU33bpWCoYa7F0gAlMUmdgNINeZUIUXxA6RX88YH
	 0AFskFxumQZfELlNNbjBW3/zdYpRkOmaz8jxAmjRGhCVkXyE/nORjOnsJfmhSQjFRh
	 cl0vAoEsm16Rwz0kF0SrRk/2zv5mgKlH0lO+OBUFEeMaitu1XaFi7vkrR75x8RUcZB
	 CUmuIVQ8nDLeRS3F2oP02uZ6hJMcN4ZQF5HFfXgDxCX+4Dxt8HVz2hu/iMD3su+x9B
	 te9xq5a1a3Ntp8AYffZ7hWdN7NgCXiyhwvtdZzQjjipUP8+c0byBDeiLUWuh4+516Q
	 HBy7yi0JzALhw==
Subject: Re: [PATCH v1 net-next 2/4] selftests: netfilter: Set gc_thresh[123]
 for gw netns in nft_nat_zones.sh.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
Date: Tue, 13 Oct 2026 20:00:10 +0000
Message-ID: <179192161050.434549.10197928132047024081@kernel.org>
In-Reply-To: <20261012194530.3751034-3-kuniyu@google.com>
References: <20261012194530.3751034-3-kuniyu@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In tools/testing/selftests/net/netfilter/nft_nat_zones.sh, the
  patch deletes the init_net writes of…

--

selftests: netfilter: Set gc_thresh[123] for gw netns in nft_nat_zones.sh.

Commit cda2962b6e2b ("neighbour: Namespacify neigh_tables.") made the
net.ipv[46].neigh.default.gc_thresh[123] sysctls per-netns. This patch
removes the init_net writes and their save/restore in cleanup(), and sets
the thresholds inside the gw netns instead.

> diff --git a/tools/testing/selftests/net/netfilter/nft_nat_zones.sh b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
> index 9f200f80253a7..d935c967dd13b 100755
> --- a/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
> +++ b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh

[ ... ]

> @@ -59,18 +40,19 @@ fi
>  
>  setup_ns gw srv
>  
> -trap cleanup EXIT
> +trap cleanup_all_ns EXIT
>  
>  ip link add veth0 netns "$gw" type veth peer name eth0 netns "$srv"
>  ip -net "$gw" link set veth0 up
>  ip -net "$srv" link set eth0 up
>  
> -sysctl -q net.ipv6.neigh.default.gc_thresh1=512  2>/dev/null
> -sysctl -q net.ipv6.neigh.default.gc_thresh2=1024 2>/dev/null
> -sysctl -q net.ipv6.neigh.default.gc_thresh3=4096 2>/dev/null
> -sysctl -q net.ipv4.neigh.default.gc_thresh1=512  2>/dev/null
> -sysctl -q net.ipv4.neigh.default.gc_thresh2=1024 2>/dev/null
> -sysctl -q net.ipv4.neigh.default.gc_thresh3=4096 2>/dev/null
> +ip netns exec "$gw" sysctl -q \
> +   net.ipv6.neigh.default.gc_thresh1=512 \
> +   net.ipv6.neigh.default.gc_thresh2=1024 \
> +   net.ipv6.neigh.default.gc_thresh3=4096 \
> +   net.ipv4.neigh.default.gc_thresh1=512 \
> +   net.ipv4.neigh.default.gc_thresh2=1024 \
> +   net.ipv4.neigh.default.gc_thresh3=4096 2>/dev/null

[Severity: Low]
Are the thresholds still raised on kernels that don't have commit
cda2962b6e2b ("neighbour: Namespacify neigh_tables.")?

Before that commit, arp_init() and ndisc_init() registered the sysctls
with neigh_sysctl_register(NULL, &arp_tbl.parms, ...) and
neigh_sysctl_register(NULL, &nd_tbl.parms, ...). So neigh/default only
existed in init_net.

On those kernels the ip netns exec "$gw" sysctl call fails, and
2>/dev/null hides the error.

The init_net write is removed along with the save/restore in cleanup().
That write used to raise gc_thresh3 to 4096 for the single shared table.
Without it, the table stays at the default 128/512/1024.

Documentation/dev-tools/kselftest.rst says mainline kselftests may be
run on older stable kernels. The comment at the top of the script says:

    # Don't increase too much, 2000 clients should work
    # just fine but script can then take several minutes with
    # KASAN/debug builds.
    maxclients=100

With maxclients raised to 2000, the shared table would need more than
2000 IPv4 entries. That is above gc_thresh3=1024, so neigh_alloc() would
report "neighbor table overflow".

Could that make the ping counter or socat checks fail on those kernels?
The default maxclients=100 doesn't trigger this.

Would it work to fall back to the init_net write, with the save/restore,
when the per-netns write fails? Another option is to do both writes.

>  
>  for i in $(seq 1 "$maxclients");do
>    setup_ns "cl$i"

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012194530.3751034-1-kuniyu%40google.com
