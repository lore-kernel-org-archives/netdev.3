Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85683CC323;
	Wed,  7 Oct 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386534; cv=none; b=GBcce3NblT8nz5Blaxrctkjgi5tSlwbcZiEy2BmUxefFZew57LDBlzK44oC7v7c4HrQveAd2rYsAH5xixPqnKsjzjK60vauYCDuNoinr+MpWXrR9U55Kz0WdNfIU8x00uPg7solsrZyMKs0awoeSye318Mj5DCgoZQO2edMoNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386534; c=relaxed/simple;
	bh=xneb9de67g/zQpN8KvDJVfJi8Ni6Shft0/cTpp/tlfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2Gsv+klzdo18hEjv8twpNAA5tgM37Dirs5qs9+PKzQYWQmmlB5LmPeDgpZ/yNY/YJy6oPDKy80/xEMQdWoJwprz2nBATxLMjx1Hl88ozOy6irBlyd0Gn69YvEcZS9G9LeVp0+uXnQqW9lKCSduL82uHHAfSOVtcZIVPt6sW++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ1yW1PD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ1yW1PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167071F000FF;
	Wed,  7 Oct 2026 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791386530;
	bh=jgeXfWY/7QFIRQsY6WO+2PJ/DzNrLa7cA9ZWSAgL5Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJ1yW1PDfpO28AIbMX1jNLKh+xQq6LxBLKFrUv42Y05G6RBi7JwGuIweIHppJ1NMG
	 T6JM3pkDWis9+vykuou3utRuXFT0kYrWTCPZf/jOwrx7Zdj9Dqaq+4GFnNVyqFRolw
	 AukOf7O8vAoAkgeNvh1ekOprOfz4ZZ6dVSwqMvkWHxR6yl/DNz7/MZSVaDjkVYuWpj
	 WL3Sf+JEU/HLucD1V+2QezbMuAKqKLsfgHalO4oj+LjQD1a/y1q2jalaCAlOkM6YXY
	 bAKVnkVfs4mM5TvNea9x1DZP3S3EZOqAKRCZPn3y6hme2R7/P7bf26KaJPks31huZ6
	 tBypkr6mssP6w==
Date: Wed, 7 Oct 2026 16:22:05 +0100
From: Simon Horman <horms@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: fix stale kernel-doc member names in
 net_driver.h
Message-ID: <20261007152205.GU83879@horms.kernel.org>
References: <20261003055443.144554-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003055443.144554-1-kapoorarnav43@gmail.com>

On Sat, Oct 03, 2026 at 11:24:41AM +0530, Arnav Kapoor wrote:
> Several kernel-doc comments in net_driver.h describe struct members that
> have since been renamed or removed, and the EFX_MAX_FRAME_LEN() comment
> is separated from the macro by the EFX_FRAME_PAD define. kernel-doc
> reports:
> 
>   Excess struct member 'state' description in 'efx_channel'
>   Excess struct member 'state_lock' description in 'efx_channel'
>   Excess struct member 'indir_table' description in 'efx_rss_context'
>   Excess struct member 'irq_rx_mod_step_us' description in 'efx_nic'
>   Excess struct member 'tx_queue' description in 'efx_nic'
>   Excess struct member 'rx_queue' description in 'efx_nic'
>   Excess struct member 'extra_channel_types' description in 'efx_nic'
>   expecting prototype for EFX_MAX_FRAME_LEN(). Prototype was for
>   EFX_FRAME_PAD() instead
> 
> along with "not described" warnings for the renamed members.
> 
> Fix the member names to match the structs, drop the entries for members
> that no longer exist, and move the EFX_FRAME_PAD define above the
> EFX_MAX_FRAME_LEN() comment, documenting its @mtu parameter.
> 
> No functional change.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Comment-only change (plus moving a #define above the comment), checked
> with scripts/kernel-doc; W=1 build of drivers/net/ethernet/sfc/ shows no
> new warnings.
> 
>  drivers/net/ethernet/sfc/net_driver.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 3964b2c56609..76b48f96ec62 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -467,8 +467,6 @@ enum efx_sync_events_state {
>   * @irq_moderation_us: IRQ moderation value (in microseconds)
>   * @napi_dev: Net device used with NAPI
>   * @napi_str: NAPI control structure
> - * @state: state for NAPI vs busy polling
> - * @state_lock: lock protecting @state

Hi Arnav,

I agree that neither state nor state_lock exist in struct efx_channel.
But while checking that I noticed that it seems the documentation
for @busy_poll_state is missing.

Could you ask your AI friend to audit that aspect too?

>   * @eventq: Event queue buffer
>   * @eventq_mask: Event queue pointer mask
>   * @eventq_read_ptr: Event queue read pointer

...
