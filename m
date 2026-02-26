Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A827B50F;
	Thu, 26 Feb 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108420; cv=none; b=rvsttWBFWEPTQpk9kKONBAetk1sQhPSh9sl++S7z9USXhNfTaGFfPPOX2zz+StzaWLqNfRhsjHBq4vvk39DkFQ4uTVIJ2V3gSPL1E2tnWMuwLBCHy0CnXZqziCxREB5nAzkElkU6xX4Sj0unwbiofEXE34j7qq0hA3lpLsijGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108420; c=relaxed/simple;
	bh=iiBtXlalbGXXCRQ1WO64lC7nwJGkJ7XOXhtNK/4xRkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k04ZA0b/k9IUxhLHa8gSCV7bF9B3zsQUjRiTBfYvbMyAEO3KQFNOsDDgE0icND172ZSYURzaUf6rTzehAY83dJS8XIiuN8hB5uopIQMd6omuihz9s/A0OG/8JxrpEvYru8fclFSOqWD5F4dJg1IgckdNnWnfuqrk+FNDIiQeMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgYEFS1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgYEFS1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A825AC116C6;
	Thu, 26 Feb 2026 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772108419;
	bh=iiBtXlalbGXXCRQ1WO64lC7nwJGkJ7XOXhtNK/4xRkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgYEFS1DCq4e/v1wNCyNETOTZ35sPU8PYMbRbUfOwZltvgIcmU9UWyVKdljcH4owT
	 2Zlu5XZ43oBkuoZ2CzhhybqAvtT7cIkYg9a/ujhkZcEluZiT7PTHq2AdVQsjAzx0ct
	 7vo88HIZIPZ/qoERTlNrQIIACUEtAYi/SWVbg+p9bXfgfcVrNiX2Gd3Jmy4BXl0oot
	 ZbijcKn/gWqNOXAIg6yM4NX22ooFRwO0a39J7sKsWweAs4MYSU3n/Rp7oJvdlPQ+dL
	 5XDMnd6T1UemkSHe6z7N2NRA7Lv5fQeFLqXFFvzQrwZ9Tp2s9m1duXzhWC3Pl0TU0v
	 0zOD3lg7daEmg==
Date: Thu, 26 Feb 2026 12:20:15 +0000
From: Simon Horman <horms@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
Message-ID: <aaA6f5xS5yONVlmE@horms.kernel.org>
References: <20260225102938.4131-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225102938.4131-1-maimon.sagi@gmail.com>

On Wed, Feb 25, 2026 at 12:29:38PM +0200, Sagi Maimon wrote:
> Add support for the Adva TimeCard model built on a Xilinx-based design.
> This patch enables detection and integration of the new hardware within
> the existing OCP timecard framework.
> 
> The Xilinx variant relies on the shared driver infrastructure, requiring
> only small, targeted additions to accommodate its specific
> characteristics.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>  drivers/ptp/ptp_ocp.c | 318 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 318 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c

...

> @@ -2926,6 +3168,45 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>  	return ptp_ocp_init_clock(bp, r->extra);
>  }
>  
> +/* ADVA specific board X initializers; last "resource" registered. */
> +static int
> +ptp_ocp_adva_board_x1_init(struct ptp_ocp *bp, struct ocp_resource *r)
> +{
> +	int err;
> +	u32 version;
> +
> +	bp->flash_start = 0x1000000;
> +	bp->eeprom_map = fb_eeprom_map;
> +	bp->sma_op = &ocp_adva_x1_sma_op;
> +	bp->signals_nr = 4;
> +	bp->freq_in_nr = 4;
> +
> +	version = ioread32(&bp->image->version);
> +	/* if lower 16 bits are empty, this is the fw loader. */
> +	if ((version & 0xffff) == 0) {
> +		version = version >> 16;
> +		bp->fw_loader = true;
> +	}
> +	bp->fw_tag = 3;
> +	bp->fw_version = version & 0xffff;
> +	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> +
> +	ptp_ocp_tod_init(bp);
> +	ptp_ocp_nmea_out_init(bp);
> +	ptp_ocp_signal_init(bp);
> +
> +	err = ptp_ocp_attr_group_add(bp, adva_timecard_x1_groups);
> +	if (err)
> +		return err;
> +
> +	err = ptp_ocp_set_pins(bp);
> +	if (err)
> +		return err;
> +	ptp_ocp_sma_init(bp);
> +
> +	return ptp_ocp_init_clock(bp, r->extra);
> +}

Hi Sagi,

I see similar patterns elsewhere in this driver. So I assume that I'm
overlooking something obvious. But it strikes me that
ptp_ocp_attr_group_add() and ptp_ocp_set_pins() allocate memory. Shouldn't
that be cleaned up if an error subsequently occurs in this function?

And also, shouldn't ptp_ocp_attr_group_add() relase the memory it
allocates if an error occurs in that function?

Lastly, the AI generated code review suggests that there may be
some scope for sharing code:

  This isn't a bug, but ptp_ocp_adva_board_x1_init() is nearly identical to
  ptp_ocp_adva_board_init(), differing only in flash_start (0x1000000 vs
  0xA00000), sma_op assignment, signals_nr (4 vs 2), freq_in_nr (4 vs 2),
  and the attr group passed to ptp_ocp_attr_group_add(). The version-reading
  logic and the entire initialization call sequence are duplicated.

  Looking at the existing driver convention, each board variant (fb, art,
  adva) uses this same pattern with separate init functions. Would it be
  worth parameterizing these differences in a future cleanup?

...
