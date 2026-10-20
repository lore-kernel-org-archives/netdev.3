Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458800;
	b=T7i5BSJ/FW2BN6daK0nvuPx7FDLJLy09EF4SemW6ikj+OIT8pIj7DC3yFnPjYc0vDdhe
	 FH80CWh36wZ9K3nhdEU5HFU8QFw55jRT3zEFx+38CG6txzr5c90Cwn5WtcHniZTfDVPgr
	 /5hNO77s1JOht+788vJvy+ddsW7wWwSDBV+MHP8nP7uOnhOV5hbXz2LhGc79FJ5wm5jLT
	 NHP09VaO8/XVYuY3rZUnI8vH9csVwwXjQ4rj2aKuNNE9y7RaHvTg6d7PVylKF2ICBwXyN
	 6SIXXKWO4HG23ja5idz4Fns7/ycjcKZrjZj/rS9p24uYaLOFJnxOw3PFh+7KKy3k9oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458800;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=t6ngjq1ZN8WrJMvkM7HtEtE3jyfDu2m7PxUENwuCdWE=;
	b=OjLwcKY5oPebqz2vQpOHXeHX6aN6R+z8UmKz695w1a5QhpLTWl6/lfIuqx37bttersS7
	 RVyDtMpCquDp5GacrN6Zkqe7BgtehPWjLv8ZID2qpRq5wskyZfE7oYUeHauWzNGv0yQUI
	 p7KLF9EUu6AzeFTu/ArS97wW5xZRKiEuWTIofA3JEXu+tuW4EMgF3rTOvhwAOKjGuQr5/
	 +h3qjhoGdKlHa1v8Jd6gcmrR3Mu0gu0T41XD/yi29xr0+Otwfz8acTyMl9y7T8SaFNdr3
	 Z/lFm+wbnSdurz4orNFeBdntb+b71DQpa0jdbB0Nkum20Oj4h269rI/zlJo/2Ro2YTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M31iY/1i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C4606A31A;
	Tue, 20 Oct 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M31iY/1i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936A91F000C4;
	Tue, 20 Oct 2026 01:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458800;
	bh=t6ngjq1ZN8WrJMvkM7HtEtE3jyfDu2m7PxUENwuCdWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M31iY/1iUUCWhERvIVlKExzej6lQZt1u6Pr5AwoSDSkLCV0rbbVsJ/dc7pQBlAIKM
	 1x+wN4m81mbhRsaZT2cD2AcBSBbMtlVQggRC1uns1rgmINiqMlsj5QZzBSGB8GzkFE
	 Yt+05GHYWFF35mrrR5v1a5hzODWaFeMGu0toqXiiNy6ojYG7BuNZJCn0JVZsjxPHNh
	 /kOb+DobiJjf6NqbVt9t0kZY1laKSi/guZSd3MT69J1aSEYqpSfdhtBIFE6FH6gyUz
	 cn4SxxDjn4B5IwEaRFtEH3Q3TT43ygLa8aKfpS80V/ClkD7us3Sm3WpNF4sVdzHwYy
	 Gk80pw9YYcgeg==
Subject: Re: [PATCH] net: ipv4: ipconfig: fix OOB read in DHCP option parsing
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 01:13:19 +0000
Message-ID: <179245879909.3135.3119437755149379459@kernel.org>
In-Reply-To: <20261016041152.2294843-1-liuc63@xiaopeng.com>
References: <20261016041152.2294843-1-liuc63@xiaopeng.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] ic_do_bootp_ext() (net/ipv4/ipconfig.c) reads fixed-size
  payloads whatever the option's declared length: `memcpy(&ic_netmask,…
- [Medium] The patch also changes the post-advance check in the DHCP loop
  of ic_bootp_recv() from `if (ext >= end) break;` to `if (ext > end)…
- [Low] The commit message describes the bug inaccurately.
- [Low] The patch indents the whole DHCP option loop in ic_bootp_recv()
  by one extra tab.
- [Low] The patch presents itself as a fix for an out-of-bounds read
  triggerable by a rogue DHCP server, but it has no `Fixes:` tag.

--

net: ipv4: ipconfig: fix OOB read in DHCP option parsing

This patch adds an ext >= end guard to the DHCP-only option loop in
ic_bootp_recv(). The guard stops the length byte from being read when the
option code is the last byte of the packet. It also relaxes the
post-advance check from ext >= end to ext > end and re-indents the loop.

> The DHCP option parser in ic_bootp_recv() advances the option
> pointer by the option length and only checks that the new pointer
> has not reached the end of the packet.  The length byte and the
> option payload (opt[1], opt[2]) are then read without verifying
> that they lie within the buffer, so a malformed reply from a
> rogue DHCP server can trigger an out-of-bounds read.

[Severity: Low]
Is this description of the payload reads accurate? In the original loop
the post-advance check ran before the switch:

	ext += *ext + 1;
	if (ext >= end)
		break;
	switch (*opt) {

So reaching the switch already meant opt + 2 + opt[1] < end. That covers
opt[2] for option 53 and opt + 2 .. opt + 5 for option 54.

The only out-of-bounds access was the 1-byte read of *ext when ext == end
after ext++. Whatever that byte held, ext then went past end and the loop
broke, so the value was never used.

The payload reads that really lack a check are in ic_do_bootp_ext(), which
this patch does not touch (see below).

> Validate the option length against the remaining bytes before
> consuming the option, and skip options that do not fit.

The new code uses break, not continue, so it stops parsing rather than
skipping the option. Could the message describe that?

> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

[Severity: Low]
The patch is presented as a fix for an out-of-bounds read that a rogue
DHCP server can trigger, but it has no Fixes: tag. The parser lines it
changes come from the initial git import. Should it carry this tag?

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 1b8585404a41d..e2c8bcec615a2 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -1083,25 +1083,27 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
>  			__be32 server_id = NONE;
>  			int mt = 0;
>  
> -			ext = &b->exten[4];
> -			while (ext < end && *ext != 0xff) {

[ ... ]

> +				ext = &b->exten[4];
> +				while (ext < end && *ext != 0xff) {

[Severity: Low]
This isn't a bug, but the loop is now one tab deeper than the other
statements in the same block: server_id and mt above it, and the
pr_debug() and switch (mt) after it.

The functional change is two lines, but the diff rewrites the whole loop.
That makes the real change and git blame harder to follow. Could the
original indentation be kept?

> +					u8 *opt = ext++;
> +					if (*opt == 0)	/* Padding */
> +						continue;
> +					if (ext >= end)
> +						break;

[Severity: High]
This guard is added only to the DHCP-only loop. The generic option loop
later in ic_bootp_recv() walks the same buffer and still has the same
pattern:

net/ipv4/ipconfig.c:ic_bootp_recv() {
    ...
	ext = &b->exten[4];
	while (ext < end && *ext != 0xff) {
		u8 *opt = ext++;
		if (*opt == 0)	/* Padding */
			continue;
		ext += *ext + 1;
		if (ext < end)
			ic_do_bootp_ext(opt);
	}
    ...
}

Say the last byte of the datagram is a non-zero option code other than
0xff. Then ext++ makes ext == end, so wouldn't the following *ext still
read *end, the same access this patch removes from the DHCP loop?

The break here only ends the first scan and does not reject the packet.
The same malformed suffix therefore reaches the second loop. That loop
also runs for plain ip=bootp replies when IC_USE_DHCP is not set.

The earlier pskb_may_pull(skb, skb->len) means the byte is still inside
the skb head allocation. The practical effect is the same as for the loop
being fixed.

The commit message says the change ensures "all reads stay within the
received packet". Should the second loop get the same guard?

> +					ext += *ext + 1;
> +					if (ext > end)
> +						break;

[Severity: Medium]
This comparison changed from ext >= end to ext > end, and the commit
message does not mention it.

Take an option that ends exactly at the end of the datagram, with no 0xff
terminator. Before, it was ignored: a trailing message type option left
mt == 0 and the reply was dropped as "Urque". Now it is parsed, and mt or
server_id are taken from it.

The commit message says the patch "keeps the existing parsing logic
intact". Is this change intended?

The generic loop below still uses the strict rule:

		ext += *ext + 1;
		if (ext < end)
			ic_do_bootp_ext(opt);

So the two parsers of one option list now disagree about whether the
final option is valid. Could the change be called out in the message, or
could the two loops be made consistent?

> +					switch (*opt) {
> +					case 53:	/* Message type */
> +						if (opt[1])
> +							mt = opt[2];
> +						break;
> +					case 54:	/* Server ID (IP address) */
> +						if (opt[1] >= 4)
> +							memcpy(&server_id, opt + 2, 4);
> +						break;

[Severity: High]
Option 54 checks opt[1] >= 4 before its 4-byte copy. The handlers in
ic_do_bootp_ext(), which the generic loop calls, copy fixed sizes without
checking the option length:

net/ipv4/ipconfig.c:ic_do_bootp_ext() {
    ...
	case 1:		/* Subnet mask */
		if (ic_netmask == NONE)
			memcpy(&ic_netmask, ext+1, 4);
		break;
	case 3:		/* Default gateway */
		if (ic_gateway == NONE)
			memcpy(&ic_gateway, ext+1, 4);
		break;
    ...
	case 26:	/* Interface MTU */
		memcpy(&mtu, ext+1, sizeof(mtu));
    ...
}

The caller only checks opt + 2 + opt[1] < end. Consider a subnet mask
option of length 0 ("01 00") whose length byte is at end - 2, followed by
one more byte. The check passes and memcpy reads end - 1 .. end + 2. Can
this copy three bytes from past the received datagram into ic_netmask?

Option 3 does the same with ic_gateway. Option 26 reads one byte past end
into ic_dev_mtu.

Those values are then applied to the interface and printed to the
console. Even inside the packet, a short option makes the handler read
bytes that belong to the next option.

This patch is meant to close out-of-bounds reads in DHCP option parsing
from a rogue server. Should cases 1, 3 and 26 check the option length the
way option 54 does?

> +					}
>  				}
> -			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016041152.2294843-1-liuc63%40xiaopeng.com
