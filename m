Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147749;
	b=ZK0Yff3rVhwvZQqirKL6ZOBy36eNGtKzbIdQrL0A6v86WspoN1yiG6V9cug6Pnwg9Luo
	 ubWouoplGfh+eEb8R+Vpd2wU9rd6ttkXkCE6k/pX2GbGAt6vsFp7WsR1Vqbf1Q35UX49p
	 01hIzxhnDPwxDqjd5WbmHVle6aAA07BRc6JrlttuLXhn9Tgr1Ctnd6kc7XxXOzvcCEKV/
	 LlAjxqNJoE6SEOiUJQznfWcZ1d4/Gsfvh1JhFsAA1DFYOdimz3iACeDDz1yOs//dfaYpz
	 sQcfkytyUuzeFvEgDXbFOyGwnLA2BBJiXR4WSLIHFrZ3qX780DTHOwvX2/q/OAaFkbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147749;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jvJNCQWDpcKYIn9dpyLnp9WuMSxCpzeLdI4GzacPzE4=;
	b=U+QaaIA6vpaUmqj5PgEnG71YaJGPGd9C6lQWrSBZUJM2U8TmKHCY0G1yrJfz4eaZGivq
	 RTiQLDpnb6O88Mwjt3DmL+opu/fDlQIB7m0lr0hk/djoVtgnRZx4dC7RGgIQtuLIV32PX
	 k5DfS8tjp845qbGtmG9YJO1KKwvi2QYUiqszYmOcz+nx2qhKfCCIU7idOTR59AI0FDNTF
	 k+dcg4l/dH0kmFHjXAc/cEgCxIiuxZ1/qqHzGBSi7DVD+J106lEM93dIpMwQHwIQMSZvU
	 JBj9XwhY2V+iYM7tV38pkSLGCRFNJEWpxsKgdBN79q9en7AMza+7SaqkCREUlvUstyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A543aOIQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA34606A330;
	Sun,  8 Nov 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A543aOIQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535AC1F0089F;
	Sun,  8 Nov 2026 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147748;
	bh=jvJNCQWDpcKYIn9dpyLnp9WuMSxCpzeLdI4GzacPzE4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A543aOIQehkdHy2WjB89r3/yjXuLt82fQ+96TNANFn6aJsGUYWg/J4DW0qWdM1RYv
	 yiNQSSy4l3nSNEJficcfCDYH4dD91hKgsa3De9ePKg7Jup++yDIusMIAyxd6JLfII3
	 5+UUiXYYincqCU1ynU2XTslKmRmEko+JXKBJDmcCwwBQcjcIk9m42/qXHIlbv5I5Gj
	 as8ZWgR0NV6ue51npH3S7H6OR6Sq9WfJcVO6Zn/IvuMEuLyYe3TbMh40FzRgQvgiLX
	 rgerPNVVPZmOhURCsaHvmB9T0AUx+QDumR5fqmw3KXpKspW7eYEwEuD2LGjF9YvFLA
	 qTWKVmhzxbD3Q==
Subject: Re: [PATCH net-next 2/4] net: dsa: motorcomm: Fix RMON fragments stat
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 14:22:27 +0000
Message-ID: <179414774787.994134.16499462160004455221@kernel.org>
In-Reply-To: <20261107132040.1066996-3-mmyangfl@gmail.com>
References: <20261107132040.1066996-3-mmyangfl@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This commit fixes a statistics bug that users can see, but it has
  no Fixes: tag.

--

net: dsa: motorcomm: Fix RMON fragments stat

This commit changes yt921x_dsa_get_rmon_stats() so that the RMON
etherStatsFragments counter is read from rx_fragment_errors, not
rx_alignment_errors. The alignment error counter is already exported as
AlignmentErrors and rx_frame_errors.

> etherStatsFragments counts frames with a bad FCS due to fragmentation;
> report the dedicated RX fragment error counter instead of the alignment
> error one, which is already exported as AlignmentErrors and
> rx_frame_errors.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>

[Severity: Low]
Should this have a Fixes: tag? The wrong mapping looks like it goes back
to the commit that first added the driver.

In that commit, yt921x_dsa_get_rmon_stats() in drivers/net/dsa/yt921x.c
already had:

	rmon_stats->fragments = mib->rx_alignment_errors;

Since then the line has only been moved by "net: dsa: motorcomm: Split
MIB module" and converted to u64_stats_t. Neither change touched the
mapping.

Without the tag, stable kernels that contain the original driver will
keep reporting alignment errors as fragments in the ethtool RMON stats
for YT921x ports. Would something like this work?

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

Older trees will probably need a hand-adjusted backport. Before the move
to motorcomm/, the code is in drivers/net/dsa/yt921x.c and uses plain u64
fields, not u64_stats_t.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107132040.1066996-1-mmyangfl%40gmail.com
