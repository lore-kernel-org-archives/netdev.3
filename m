Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7840910F
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569723; cv=none; b=RoAwCjnmWddR+2j007y3Q+RHyHAs8axbpsY7GrN6PyL5sEiiIoLCZtZ/ZjyTIH0h2E5NudlZStcplaQFADLy+ZZy2n2A0h+nq3NP2+4p+tTi1OE2eplac7UaCypxiQK0FdqiWcbQE6o2NhWxF3P3qyWt7EubLgMt1nMhL5MVl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569723; c=relaxed/simple;
	bh=+TGxz0MXCXJOROkkQ52Zly85Lf6V6W9rOsLi0mbHMgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ+KOYD6HCFYa5TgHGmMdmSZNDpAInY1a/stVmN9XX5Smm6EqNSo16Fz9FzwtEOWiE+KBu3N9vSJz75YWKSMt/oiQIFPgkms1q6jFNPhRv5zXDaiN4SFICVlPhCvOJiKSJ94bODlUWRNXiUeQeUwIBBlZnDbO5juK6Q5ZJevPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEgiaHjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEgiaHjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4411F000E9;
	Mon, 24 Aug 2026 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787569721;
	bh=Le5WmkAN4u0IGX86Dtsiq5E/X6/dEQq9bQyFCSqFyPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XEgiaHjXxppXUG2pPcxKCT3GnPMBcvbqiKOl2ajhiOEZgjhE1aZKTQJfzT1D4POpX
	 bZXR9lyoN8BBqfheSbsp0CobKK5Kgo33hNBc0LzXw+XtVmAZU2vbRvu2mhuu0Pg2Kf
	 N0lxJ6c2Xoo0+QT0IJP3J9P3GmG8kL0Uoi7muj/njCi7avpyEcuOoEPIyqSuOogHJa
	 4f8CdDRPavxiWFeudXz5OfEc+82JPhLWiEsS18Ow3C0A2MTx1pOh5wCqGDyLr+urB/
	 mGKXpDqWulMGLEEA6UQd1DlO+upHz76RJ6IvJUsw2P6N496LOMkamfebPufuO+VSrZ
	 np2eUtL5/k5WQ==
Date: Mon, 24 Aug 2026 12:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Message-ID: <20260824110838.GP265046@horms.kernel.org>
References: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820114314.646344-1-aleksandr.loktionov@intel.com>

On Thu, Aug 20, 2026 at 01:43:14PM +0200, Aleksandr Loktionov wrote:
> ice_rt_ho_set() uses the HO register as the starting offset of an
> ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
> be advanced by user-controlled data reachable through
> ice_parse_raw_rss_pattern() -> ice_parser_run() ->
> ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
> VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
> size of pkt_buf.
> 
> Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
> be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
> so it stays correct if the packet buffer layout changes.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser_rt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> index 3995d66..bfdb50b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> @@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
>  
>  static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
>  {
> +	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
> +	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
>  	rt->gpr[ICE_GPR_HO_IDX] = ho;
>  	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
>  }

Hi,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/20260820114314.646344-1-aleksandr.loktionov%40intel.com

The first item flagged there seems of concern
and I am wondering if you could respond to it.

  Does this new clamp introduce an infinite loop?

  In ice_parser_rt_execute(), the loop termination condition is:

      if (rt->gpr[ICE_GPR_HO_IDX] >= rt->pkt_len) {
          break;
      }

  If a guest VM VF submits a raw RSS pattern with a pkt_len greater than 504
  bytes, ice_parser_rt_pktbuf_set() saves that unclamped length directly into
  rt->pkt_len (e.g., 1024).

  With this patch, the HO register is capped at 488 (sizeof(rt->pkt_buf) -
  ICE_GPR_HV_SIZE). Since 488 will never be greater than or equal to 1024,
  can this cause the parser to loop indefinitely if the state machine
  processes a repetitive sequence?
