Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1A41D648;
	Mon, 14 Sep 2026 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378387; cv=none; b=dDffKkPisBcsgOd5uok72rla+BENIZjGwYVRtAvf9nTUWrjJTHjR8NMLlUi8p+P0A3FgGdE5QprY0j54pS0xAAV7vrhpSzsVxpiWOiQgqmghYifHAGE6TighQ1VsahiMv03bzb0tJih4bAZp3ZQ4HyxZ3jFsjL/M6iAe2g4/ruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378387; c=relaxed/simple;
	bh=Rns9Q4qLtxlw6IyA5BLhL4Pqqdje+UUjfQyTd+lbEuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylcvmy7kjzE00YfVQ7yqwK+J4L0P4vnNDxJVdoUtmmpf1Wy+53hdACe6I7fLZDGpo2r36mc+0KcI4kEXEXQywzDfyI6UZy0oQ4aYwpfmttBirKr2ffrxg0oTNyQEg17SOKChlLmgf04518R54HqgFgO6Avd0NH/HBNAZkk5n3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqyci8CU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqyci8CU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692FD1F00893;
	Mon, 14 Sep 2026 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378385;
	bh=TF8vWdHT/xzToLwETV42FttPVsuKKNCeUrPRhSDWsyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cqyci8CULMLK5znEv17PEAp1/k+q2BZIachlXSX4MAJIur5gdxyJpr9iZTcPmarw1
	 udrtyEXOfU3jnqGH9gn3/FEcgbXAmW37oY0S91OZZmtwu/0IEbZiRmm4YMKc9CFgjs
	 AVg7pAppOCUNzV1QITn1ejrkrVtZq7Wjgv8oTqgh/oIRJTsHIOLYAFDL2bF1dSWN/h
	 i7iTbvvfX4VhxkSnKVBjvl4IoGQiD5pquf5juSYLpa0ac1pj/5VrzV+n9eztmd0kWg
	 wZStrzX++2+c+NJrErDiuOCJWiDF2fskFA+YTdpX1MIP7gcvG9/P8beC4k8Yorw73G
	 /mnGqYlLgJncw==
Date: Mon, 14 Sep 2026 10:33:01 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: esteuwu@proton.me, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xlie7669@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH] net: ipa: Add IPA_MEM_STATS_DROP_MODEM memory region
Message-ID: <20260914093301.GP48209@horms.kernel.org>
References: <20260909-ipa-modem-drop-v1-1-0c9664f09c4a@proton.me>
 <178900975328.219967.188619870211891152@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178900975328.219967.188619870211891152@kernel.org>

On Thu, Sep 10, 2026 at 03:09:13AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> - [Medium] The newly declared region id `IPA_MEM_MODEM_STATS_DROP` has no
>   producer and no consumer, so the patch is functionally inert and…
> - [Low] Commit-message / code identifier mismatch plus stale peer
>   documentation for the new drop-statistics region.

Hi Esteban,

I'd appreciate it if you could comment on the AI-generated
review posted by netdev-bot+sashiko. This is now an expected
part of the Netdev development process [1].

Thanks!

[1] https://docs.kernel.org/process/maintainer-netdev.html#review-timelines

> 
> --
> 
> net: ipa: Add IPA_MEM_STATS_DROP_MODEM memory region
> 
> This adds a new ipa_mem_id enumerator for the modem-side drop statistics
> region and allows it in ipa_mem_id_valid() only for IPA v5.0 and later.
> No platform data file or driver code path references the new region.
> 
> Link: https://github.com/LineageOS/android_kernel_qcom_sm8450-modules/commit/fc71d0972a2453cc29f873d723a355a902c6d69c
> 
> > diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
> > index 078d32a18dbf..3000aaa24530 100644
> > --- a/drivers/net/ipa/ipa_mem.c
> > +++ b/drivers/net/ipa/ipa_mem.c
> > @@ -166,6 +166,7 @@ static bool ipa_mem_id_valid(struct ipa *ipa, enum ipa_mem_id mem_id)
> >  			return false;
> >  		break;
> >  
> > +	case IPA_MEM_MODEM_STATS_DROP:
> >  	case IPA_MEM_AP_V4_FILTER:
> >  	case IPA_MEM_AP_V6_FILTER:
> >  		if (version < IPA_VERSION_5_0)
> 
> [Severity: Medium]
> Can this new case ever be taken?  ipa_mem_id_valid() is only consulted for
> ids that already appear in a struct ipa_mem_data.local[] array, and a grep
> of the tree at this commit shows IPA_MEM_MODEM_STATS_DROP only in
> ipa_mem.h (the declaration) and here.
> 
> The v5.0+ data files that the version >= IPA_VERSION_5_0 gate could apply
> to all define just the one drop-stats region:
> 
> drivers/net/ipa/data/ipa_data-v5.0.c
> drivers/net/ipa/data/ipa_data-v5.2.c
> drivers/net/ipa/data/ipa_data-v5.5.c
> 	.id		= IPA_MEM_STATS_DROP,
> 
> and the only consumer of drop-stats memory still looks up the old id:
> 
> drivers/net/ipa/ipa_qmi.c:init_modem_driver_req() {
> 	...
> 	/* If the DROP stats region is defined, include it */
> 	mem = ipa_mem_find(ipa, IPA_MEM_STATS_DROP);
> 	if (mem && mem->size) {
> 		req.hw_stats_drop_base_addr_valid = 1;
> 	...
> }
> 
> The commit message says the region "is used in IPA v5.0 and higher", but
> with no producer and no consumer the change has no runtime effect.  Would it
> make sense to land the data-file entry and the QMI consumer in the same
> series?
> 
> There also seems to be a layout prerequisite that isn't mentioned.  In
> ipa_data-v5.0.c, IPA_MEM_STATS_DROP is at offset 0x3870 with size 0x0020
> (ending at 0x3890), and IPA_MEM_MODEM starts at 0x3898 with canary_count 2,
> so its two canaries occupy 0x3890-0x3898:
> 
> 	{
> 		.id		= IPA_MEM_STATS_DROP,
> 		.offset		= 0x3870,
> 		.size		= 0x0020,
> 		.canary_count	= 0,
> 	},
> 	{
> 		.id		= IPA_MEM_MODEM,
> 		.offset		= 0x3898,
> 		.size		= 0x0d48,
> 		.canary_count	= 2,
> 	},
> 
> Doesn't adding a second drop-stats region require shifting IPA_MEM_MODEM and
> everything after it?
> 
> > diff --git a/drivers/net/ipa/ipa_mem.h b/drivers/net/ipa/ipa_mem.h
> > index b25babade787..56703bada07c 100644
> > --- a/drivers/net/ipa/ipa_mem.h
> > +++ b/drivers/net/ipa/ipa_mem.h
> > @@ -68,6 +68,7 @@ enum ipa_mem_id {
> >  	IPA_MEM_STATS_QUOTA_AP,		/* 0 canaries, optional (IPA v4.0+) */
> >  	IPA_MEM_STATS_TETHERING,	/* 0 canaries, optional (IPA v4.0+) */
> >  	IPA_MEM_STATS_DROP,		/* 0 canaries, optional (IPA v4.0+) */
> > +	IPA_MEM_MODEM_STATS_DROP,	/* 0 canaries, optional (IPA v5.0+) */
> 
> [Severity: Low]
> The subject and the body both name IPA_MEM_STATS_DROP_MODEM, but the
> enumerator added here is IPA_MEM_MODEM_STATS_DROP, and a grep of the tree at
> this commit finds no occurrence of IPA_MEM_STATS_DROP_MODEM at all.  Could
> the changelog and the code be made to agree?
> 
> The neighbouring statistics regions put the owner last:
> 
> 	IPA_MEM_STATS_QUOTA_MODEM,	/* 2/4 canaries (IPA v4.0+) */
> 	IPA_MEM_STATS_QUOTA_AP,		/* 0 canaries, optional (IPA v4.0+) */
> 
> Would IPA_MEM_STATS_DROP_MODEM (as the subject says) fit that convention
> better than IPA_MEM_MODEM_STATS_DROP?
> 
> Also, the comment on the existing IPA_MEM_STATS_DROP still reads "0
> canaries, optional (IPA v4.0+)" with no hint that it becomes the AP-side
> region once the modem-side one exists on v5.0+.  Could that comment be
> updated so a config author can tell which region to use for AP drop
> statistics?
> 
> One more thing on the changelog: the paragraph explaining the split ("From
> IPA v5.0 onwards, two memory regions for drop stats exist: one for the AP
> (that is, the driver) and one for the modem (Q6).") sits below the ---
> cut line, so it is not part of the recorded commit message.  Was that
> intended to be above the cut line?
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-ipa-modem-drop-v1-1-0c9664f09c4a%40proton.me
