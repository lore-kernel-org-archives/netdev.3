Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F04F0547
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368599; cv=none; b=hbSCnR4zaCvfTPjXvf6XtIfxZHwXJuPz8oKA+vNR8245Q2tPf4Y9vt1W1LDL+9gLmKMcCQPBBOXeDjHO0doZEtpmZgVldJ0q+wOe6nuU8No7qwbZU19cNii/i7ie6nYJhoOhhohrVZ2MIfYRhWIcCKhPbDe4+abIdGeVQCcLrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368599; c=relaxed/simple;
	bh=f1C1P0RJV7UD3ihhv6TBK1d6AZmUsp5wVWoquHMzO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrEkPMnB5iF+RfvZWsUSDCet8YDidLYVWAdvF5WJDU+Jk6fZtwTmgsRGH34fGjjrT9y9pV3bapYmTd0pTKyKpYMCAO+KR7nulAgn/7MiRj3avKnNwtqmfJMyVNaatYSBhqqBUffiwJJWcAZBAngjPCmNlENQH8iCyaFvkcvzkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otx7KBmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otx7KBmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9531F00898;
	Fri, 25 Sep 2026 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368591;
	bh=MCeIEH+/nTOajLFES8iXUlHm6Kt0VZFSIkJ0GRUqBEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=otx7KBmEdvM5AzKVdrxOpbCgWxoqyh46RwkBOJG26e2Ex8dmNJbzIOOuNoWvVI/T8
	 /E24LpPUCaDEn0PZZkclidCWYq3knG/56d1LHhWJhjHqZh+vfezJhbgDwmIluSpLLl
	 9oRGIz+jmaxYUE5/gVAx6WZqouUFJihJsjHaSa3JfKZpdXGCgaTzDKm3DKprXaGDMM
	 LfEgjoSM90ytFM2T+owrzEqXWsWIjwhO2AFSudT36gX0ryi9ljjAi1DhlyzoYsSxyA
	 87V+G2f+T3JBk4CkMf6d5l9c2M619bZyVWQXMwJ7Cy7FhasXZu+f6RhRpFFBGH9ye+
	 Lg+JIFV+8Iang==
Date: Fri, 25 Sep 2026 21:36:27 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net  v5 7/8] ice: Annotate PTP control PF lock handoff
Message-ID: <20260925203627.GA1862486@ax162>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
 <20260924125916.2796499-8-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924125916.2796499-8-sergey.temerkhanov@intel.com>

On Thu, Sep 24, 2026 at 12:59:15PM +0000, Sergey Temerkhanov wrote:
> ice_ptp_lock() conditionally retains ctrl_pf_lock for read when it
> successfully acquires the hardware semaphore. The matching unlock occurs
> in ice_ptp_unlock(). Describe this cross-function handoff with context
> analysis annotations so static analysis can verify callers.
> 
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        | 12 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 26 +++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  6 +++--
>  3 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index c454f19a2cb2..8b7891ac25b0 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1179,4 +1179,16 @@ static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
>  		rcu_dereference_check(pf->adapter->ctrl_pf,
>  				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
>  }
> +
> +/* container_of() expands to a statement expression, which clang cannot parse
> + * inside a context analysis attribute argument, so open-code the cast here.
> + */
> +#define ice_hw_ctrl_pf_lock(_hw)					\
> +	(&((struct ice_pf *)((void *)(_hw) -				\
> +			     offsetof(struct ice_pf, hw)))->adapter->ctrl_pf_lock)

FWIW, another alternative to open coding container_of(), which I don't
love to see, is using a static inline function, which would likely read
better as well.

  https://lore.kernel.org/f147ad227b85439d56183e60e0332547b84441bc.1790360262.git.bvanassche@acm.org/

-- 
Cheers,
Nathan
