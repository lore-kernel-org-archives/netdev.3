Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952497;
	b=nRzAHvq4WU0AOD5zLywuVlXyEE2uHdI5sDJlhvRYGvp9+q1OKnzDx3ylvWErTldljRDw
	 6h7ibZhyZ8c2VL+wR0MUgrHOxo3GwtlHnoe5QXq5niuodaEysjwssTPtMJxB3P0vjwCh+
	 aS9a7+rvALLPg4S6XgB1Sd2bqbPCL0AcKYeHoqRJj3nHi/vNK2Qa9CbWlbUu6CGg71x1P
	 RO1Y4dD1zcJvQ2Ftk8ouLU4KmBVOfpQc3EQGc0L9Z10TQgGbGcBIZ1P9TTDtcplZTN/81
	 Uze04j02xWQX2kao7G31KWqSAUojEWbWTkQjfjaEff9LeEt7+w7SgOEgoA/d0vB/lNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952497;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QTUVlPXfapWlmm/xh9eGeir+RrX39EDrNrK8lAdDbWw=;
	b=SCIR/CfMbCXAVSIfMbe8DKteKgV5y7hxRZlpSTCGO+6V+jJKsaEauX8gkEzALqNyqQ0l
	 oUPMym0jXOMGKJxo3sUYnZtPzg7H1xwysW6eJH/It6qmR3xsxPoFUBtzjDR+f+0usM5Ya
	 CJCGhp2MtPoDDhq6P/wFOuF229UEW/4XtfZ1DBlsxkWEm0gD2twZAOps7KorHKZ04E+ff
	 UZlzA6/kbb1fmo+09LgNQIYWLvaOxarkRwRIJh5ynEiDp90LbEJn2cMB3JPviqpfmoBWO
	 cMOoHnD1ys36I49FC8ErAqsPjnNdnYCN8wSGcQ6NQmS/4mZ1pOhu1ImVIJAEptypF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9bqZRrh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BFB606A31A;
	Sun, 25 Oct 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9bqZRrh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4B71F01825;
	Sun, 25 Oct 2026 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952496;
	bh=QTUVlPXfapWlmm/xh9eGeir+RrX39EDrNrK8lAdDbWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G9bqZRrhZ9Lc4+9et1T4QxTNvKJgBIcO5cB8FGWrs3mcNDMuW2r0deoEjkMK/lVsR
	 D3N02lrAX23DK2dYAiBGZQb2ehoibhUn5pe5Imr09n6xGvEXsy5NPcQDlirfsy9VDz
	 tNAfDfa4ARqc5qbqKtdFTnVtm3uC2ebOZVJsFNFdw6TvqhR5HGI1kdjTOXx7QBfy3S
	 +n+/Da7lZeMrITqDaXvy3PqmZ0C+wSjfAbqLs60XiUcGkEr2TLZ8dqWX8b+2Bs1h3y
	 ZGAqvLDWnCvkGaXt89HMZVs1zmzihT4hBjVHLUs6wGJrPaSAWPHw0QYXTAHWGMegJ9
	 w/vKh2DVJNdjg==
Subject:
 Re: [PATCH net 1/2] net: dsa: mv88e6xxx: fix 88E6171 statistics snapshot
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 18:21:35 +0000
Message-ID: <179295249579.3134.1107182685968868930@kernel.org>
In-Reply-To: <20261024182124.296988-2-f.fainelli@gmail.com>
References: <20261024182124.296988-2-f.fainelli@gmail.com>
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

- [Medium] The fix is incomplete.

--

net: dsa: mv88e6xxx: fix 88E6171 statistics snapshot

This patch changes the 88E6171 ops table from the shifted
mv88e6320_g1_stats_snapshot() helper to the unshifted
mv88e6xxx_g1_stats_snapshot() helper. The 6351 family takes the port
number in the low bits of the statistics operation register. With the
shifted helper, ethtool -S returns port 0's MIB counters for every user
port.

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 2a975ecd79c74..60d2ce80ede01 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -4611,7 +4611,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
>  	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
>  	.port_get_cmode = mv88e6352_port_get_cmode,
>  	.port_setup_message_port = mv88e6xxx_setup_message_port,
> -	.stats_snapshot = mv88e6320_g1_stats_snapshot,
> +	.stats_snapshot = mv88e6xxx_g1_stats_snapshot,

[Severity: Medium]
Should the other 6351 family ops tables get the same change?

In chip.c, mv88e6175_ops, mv88e6350_ops and mv88e6351_ops are all marked
/* MV88E6XXX_FAMILY_6351 */. Their info entries set
.family = MV88E6XXX_FAMILY_6351. All three still have:

	.stats_snapshot = mv88e6320_g1_stats_snapshot,

and that helper in global1.c does:

int mv88e6320_g1_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
{
	port = (port + 1) << 5;

	return mv88e6xxx_g1_stats_snapshot(chip, port);
}

For ports 0..6, bits 4:0 of the STATS_OP CAPTURE_PORT write end up as
zero. If those chips decode the port from the low bits, as the commit
message says the 6351 family does, wouldn't every snapshot on
88E6175/88E6350/88E6351 capture port 0?

All stats readers reach the callback through mv88e6xxx_stats_snapshot():
mv88e6xxx_get_ethtool_stats(), get_eth_mac_stats() and get_rmon_stats().
Each of these would then report port 0's counters for every user port on
those chips.

The commit named in the Fixes: tag, a605a0fe7115, appears to have set
mv88e6320_g1_stats_snapshot on all four 6351 family tables. Before that
refactoring, _mv88e6xxx_stats_snapshot() shifted only for:

	mv88e6xxx_6320_family(chip) || mv88e6xxx_6352_family(chip)

so every 6351 family chip used the unshifted encoding.

As far as I can tell, the follow-up patch in the series ("net: dsa:
mv88e6xxx: fix 88E6171 statistics type") only touches the 6171 info
entry. At the end of the series, the three sibling tables would still
use the shifted helper.

>  	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
>  	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
>  	.stats_get_strings = mv88e6095_stats_get_strings,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024182124.296988-1-f.fainelli%40gmail.com
