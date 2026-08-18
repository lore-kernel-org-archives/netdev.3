Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FD45C6E9
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057141; cv=none; b=IWkAUBTjAywMWIxaF5M6q6liPD9SbaVKQBmheCT5eeMZgSPX70yaPS9tMRsvQM3u9F21l9SPvTjQPpl2963V+QWkkfFnhSZzQ5wjO9c4JnTloEP4F9HOsbISBo+k2EBCOAaAuB43IFi/lC8QeBBxhzoYq+lNuTj8Ais9Hd5EFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057141; c=relaxed/simple;
	bh=MnSQYHO1irXevOg2ealXrfH39PWwPNOpIV3+zctjRto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkIFTGWlqtm2jFEDymwrpEjCC6SRdHUfxbFnT3E1Ircc6ZZhUcmmN99AcTZhQSiIkRJP6Gxm6JWzf5nwS2cgoaAxzIcQwkpO21asePkA6guUVlKMNhdukae2fz+iqXRtinI4g5xEjGglQu4e/sS+5/5SYqL6ZXCqhEFJhops/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7ljK1/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7ljK1/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C297D1F000E9;
	Tue, 18 Aug 2026 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787057139;
	bh=phLclicfwRczR7oRh0Xzr9icaR29umodk9bXfcJ7Pls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U7ljK1/WSkEB+1irQqOX+RfUMpboN25OVdfV3nwZUdAP/wrKug9xFIfeMTTMGqZda
	 nZQ8fjvB+Vrm3DRuoZrHClsP5AETeCWd3kPnbIuT4VBFDI4Ohue34e6+nGW5uRXrhE
	 aaNZQJhfQ5yhJO3QBcahtN205Y19lbQFzqhoNL0CgQCmHNq9/TuyvbY5dq9iXFH5LY
	 E2pShSZcJlRistD+6H6GIeJjhgOuVVkHJnq6Zw1Dxt0yO3z98xyg5MSI+wIfmyPGGy
	 x8NqbUKiMjMpJdbj2niFE82AV6idzXWaR0DHVAZAaZsYb3KhF5PFAUFhaxysaMn4xs
	 tFMAbdASOdC4w==
Date: Tue, 18 Aug 2026 13:45:35 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Nikhil P. Rao" <nikhil.rao@amd.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v2] ionic: Add .get_fec_stats ethtool handler
Message-ID: <20260818124535.GE265046@horms.kernel.org>
References: <20260814-ionic-get-fec-stats-v2-1-13f0e7d2e702@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-ionic-get-fec-stats-v2-1-13f0e7d2e702@amd.com>

On Fri, Aug 14, 2026 at 05:33:12PM -0700, Eric Joyner wrote:
> Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane
> counts currently aren't supported. Every counter reported here comes
> from the RS decoder, including fec_corrected_bits_total despite its
> name, and the only histogram format firmware produces is the 16-bin one
> from RS(544,514), so nothing is reported unless RS is the active FEC
> mode.
> 
> These are physical port counters, so virtual functions are skipped the
> same way ionic_get_link_ext_stats() skips them, rather than reporting the
> port's counters as if they belonged to the VF.
> 
> The reporting of these statistics is gated by DEV_CAP_EXTRA_STATS and
> checks for IONIC_STAT_INVALID, since only the newest devices support
> reporting all of these stats. Older devices can only report some of the
> statistics or not at all, and so the output will properly exclude those
> unsupported statistics.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> Reposting since v1 was too old to apply. This also addresses the netdev
> AI review comments left on v1:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731214021.15279-1-eric.joyner@amd.com
> 
> That review also flagged a NULL dereference in ionic_get_fecparam().
> It predates this patch, so it is fixed separately in the net tree
> rather than here:
>   [PATCH net 0/3] ionic: fix port_info lifetime problems around device reset
>   https://lore.kernel.org/netdev/20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com/T/#t
> 
> Vadim's Reviewed-by from v1 is retained. The only change to the code
> since he reviewed it is the histogram bin latch listed below.
> ---
> Changes in v2:
> - Latch each histogram bin into a local before testing it against
>   IONIC_STAT_INVALID, so the sentinel check and the store cannot be
>   folded into two separate reads of the firmware-updated DMA buffer.
> - Explain in the commit message why the RS FEC check gates every
>   reported counter rather than just the histogram: they all come from
>   the RS decoder, including fec_corrected_bits_total despite its name.
> - Rebased onto current net-next.
> - Link to v1: https://lore.kernel.org/r/20260731214021.15279-1-eric.joyner@amd.com
> ---
>  .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index c4ab4b5caa0a..2f2b5076dcf4 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -441,6 +441,91 @@ static int ionic_get_fecparam(struct net_device *netdev,
>  	return 0;
>  }
>  
> +#define IONIC_FEC_STAT(dst, src)			\
> +	do {						\
> +		__le64 __val = (src);			\
> +							\
> +		if (__val != IONIC_STAT_INVALID)	\
> +			(dst) = le64_to_cpu(__val);	\
> +	} while (0)

Hi Eric,

There is an AI-generated review of this patch available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-ionic-get-fec-stats-v2-1-13f0e7d2e702%40amd.com

In that review, the following stands out to me.
I'd appreciate it if you could take a look over it in particular.

  The v2 changelog says the per-bin local "latches" the value so "the
  sentinel check and the store cannot be folded into two separate reads of
  the firmware-updated DMA buffer".  Is that guaranteed by this code?

  Both this macro and the loop body in ionic_fill_fec_hist() use plain,
  non-volatile loads:

	__le64 __val = (src);
	if (__val != IONIC_STAT_INVALID)
		(dst) = le64_to_cpu(__val);

  and

	__le64 val = port_extra_stats->fec_codeword_error_bin[i];
	if (val == IONIC_STAT_INVALID)
		return;
	hist->values[i].sum = le64_to_cpu(val);

  Nothing stops the compiler from discarding the local and re-loading the
  word from the coherent buffer for the comparison and again for the store.

  Would READ_ONCE() on each word, or a memcpy() of the block, be needed to
  actually get the single-read property described in the changelog?

  The same applies to the struct assignment in ionic_get_fec_stats():

	port_extra_stats = port_info->extra_stats;

  This is an ordinary aggregate copy out of memory the device writes
  asynchronously, so members may be re-read at each later use rather than
  coming from a stack snapshot.

  If a word transitions while being read, can the 0xffffffffffffffff
  sentinel that ionic_port_init() memsets into extra_stats be reported to
  user space as a real counter, or a counter firmware did fill in be
  dropped, and can the 16 histogram bins end up stitched together from
  different firmware snapshots?

...
