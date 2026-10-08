Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083D48E0FF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464522; cv=none; b=qSLUoIKxT2utm9L3SDMQkUB4Nq1BBA7qXDJlvqpSFQ5b8IBbeSHfbzTBz75lrpzNcYsmOcj1BaYWQ7/tnQxN8OM/FVXZQWUZOYGGDeQgzirPUnJ+0G6AmcbiEbGeN78SeloHjkus/MNTPZChXyaFCu+HV1xNmeBkXqSHyNKRDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464522; c=relaxed/simple;
	bh=SW0joU4tSFdHbVrE5yufPWqGMWLiwjIXdBMK8MgSOdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkV0LJs8jOftiq/EhsaBMGVrKLbynkvtsFacS6SgJ/ufaRwiWIXzwEIxbNkmHkyfcYNi+O7Tg+oq7NhKVy62ATn42cEJb+jT0LrIJM88431UBvmCUtxFR0z7Q3g+3rV68Lb88jtXFB8ePKMZZcBnl1GPMxEEyXVqBMpW29kjC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nl5Qotpp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGZa8QfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl5Qotpp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGZa8QfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791464519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwPHHsgpMs6zbZHghQO2vU/k/AkZ7EfAHxPKWnb9ZmU=;
	b=Nl5QotppE8O3x3aevPG2ATBwSbldHJz+n4Af98uAGf+TaT8/thvbsLUErwBeQVecsd2HKb
	ZLrQ+Lc17uzhfWaBsixCwLXhIV2/GVK6DZz9v11zNnnS5v/GBUHGk7zuYe98C5zCIkxwmJ
	rgIwgFqLeNQc5gh1CZQlkSk7wFTfs3Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-ynf8eNeTNECRkltn16HybQ-1; Thu, 08 Oct 2026 09:01:58 -0400
X-MC-Unique: ynf8eNeTNECRkltn16HybQ-1
X-Mimecast-MFC-AGG-ID: ynf8eNeTNECRkltn16HybQ_1791464517
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so70972175e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791464517; x=1792069317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RwPHHsgpMs6zbZHghQO2vU/k/AkZ7EfAHxPKWnb9ZmU=;
        b=SGZa8QfMUjT2feee+Qe2o6y9WGCYS9N0gF+SrodoYmJxCkzlo2yWGz1iG37fl6c7Wq
         7dghoe01p4M5RAM8udOdSDcEI+Ig5QZ1ZKF8RcXE5vVllKvAFIggZmL2z76PWkEXNJxv
         K54g6KHeDiI3LdWkueD0oHt8vHsPFLCpVRHFH8T9URpma7qa1IGsoGAxZBTwnqlghi//
         gUPzp2eJQ+Yp5zcJ4GHoNhq7Drj+EEyM3c8NW9LkbvDnGjykyPkuGuZMP0AhZC4qnsO0
         gpej0KKn+UymdwB7lO3yBv9k5iTSvvNSl6RZHPqxXyUFIBilNlmLmSJM2KHrGaoCSErJ
         UBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464517; x=1792069317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RwPHHsgpMs6zbZHghQO2vU/k/AkZ7EfAHxPKWnb9ZmU=;
        b=wLKwKpD6Z4EVP1KfKsWd39LMDyl/ZsNkRbAOToDJGd/BTsim52eaww6CJHiiEa6QN5
         O/VvEf5yh4CPUB6ayWaE6Hy2PIEnUO0Xwo+TwUK+2o7aDzBxVAn3G+IlZPQFgvcj8FHh
         JHG3dnlHZmf5mbg/hJZ5Q4lRb8Fgxq//3ds9+NOq8nhxN03hHNoGH6JMdOiopaCumRXg
         E/cBj+lGNVy8VneFwvfdUuLBkoBwmvgNUCCMVyrhH/pjsx7flOBuB64ZqfNcUc7yR/Kb
         ITKq3bmRoPYN1uRnuCLg39yg0nWJysnUOFbcaSiMfPkTr87kjtSj/2jD7VdW2veBk4UZ
         FFbg==
X-Forwarded-Encrypted: i=1; AKwUvBzbS69g87BGsd0hXY5YHZAomhimH5JbNjRdZPzDq9LnNPtylA3mumEG3NGTmZTFlNY86iKxKUc=@vger.kernel.org
X-Gm-Message-State: AFuF++nZmq+dpEal3fgfRAHTJ79/DyT0IDdwR+eBzijqud5ZzJbJylis
	Gz8xMo/Hvwnc2M6Mh3+iyNel4aHauSo5E/V6c/SZTk7HGva3M/G6fDNyhNlxzux7zIFyIgmWRO7
	EySWUKlzc8JC+UjiJsJvzXyloOLO36xnvcp8LqTREtMDhmnKo0bUQ5nL7pGb+3wIPWF4/
X-Gm-Gg: AYBFou0JzaidEIbK1MTNiWOJjad12F6z2J7nvAgKb3wAdRQIR7Eo5xheeDh3Uuq7YHE
	59iYtcQKmvz4tbN7lCwSUTxJB37w/SZ2sevfe8NxksbhOdKotkOn8hH8tLrXSNcGAtM0v8yMffJ
	CYVERuWECjBADpARgGpkDkZ8N9eGJanEZa4tC/FaWQdLef7igMH5UCkgzGxIdbXoWVG6SsVfDmK
	PC0YbHWVOwtEp2lRLeUJZBW1bh5iMrtwxW1MHaim3D0iJfe/PM8kG0e6fbWMLsV5mn2ziCMo0rh
	BeJ7yTWObuoAx5BuNTusPe6dHlrV7xJnvwARRx4HAMv32q87AtEscHJnVIttyHBj9lfKMofteyO
	htWLaf/tK24MfiLooDRKulg199U03z/Wz
X-Received: by 2002:a05:600c:4fcb:b0:4a1:746e:589a with SMTP id 5b1f17b1804b1-4a18045579amr88642065e9.18.1791464517039;
        Thu, 08 Oct 2026 06:01:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:4a1:746e:589a with SMTP id 5b1f17b1804b1-4a18045579amr88641325e9.18.1791464516349;
        Thu, 08 Oct 2026 06:01:56 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842a349bsm70150905e9.2.2026.10.08.06.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:01:55 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:01:39 +0300
From: Mohammad Heib <mheib@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	linux-doc@vger.kernel.org, sx.rinitha@intel.com
Subject: Re: [PATCH net-next 2/3] i40e: add devlink parameter for Flow
 Director ATR sample rate
Message-ID: <aseTIxAIWeH5uSaR@mheib-thinkpadp16vgen1.rmtil.csb>
References: <20260917204541.3072415-3-anthony.l.nguyen@intel.com>
 <179002634197.2160803.3910890717187021181@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179002634197.2160803.3910890717187021181@kernel.org>

On Mon, Sep 21, 2026 at 09:32:21PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new devlink `atr_sample_rate` setter
>   (drivers/net/ethernet/intel/i40e/i40e_devlink.c:36-46) makes the value…
> - [Medium] The new documentation
>   (Documentation/networking/devlink/i40e.rst, lines 54-59) states that…
> - [Low] In the new documentation entry the lines 'Setting to ``0``
>   disables ATR sampling (no filters will be programmed)' and 'The…
> 
> --
> 
> i40e: add devlink parameter for Flow Director ATR sample rate
> 
> This adds a runtime devlink parameter, atr_sample_rate, that lets the
> Flow Director ATR sampling interval be changed without rebuilding the
> driver.  The value is stored in pf->atr_sample_rate and read by the Tx
> path, and a new entry documents it in the i40e devlink documentation.
> 
> > diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
> > index 51c887f0dc833..2cea98b631baa 100644
> > --- a/Documentation/networking/devlink/i40e.rst
> > +++ b/Documentation/networking/devlink/i40e.rst
> > @@ -40,6 +40,26 @@ Parameters
> >  
> >          The default value is ``0`` (internal calculation is used).
> >  
> > +.. list-table:: Driver specific parameters implemented
> > +    :widths: 5 5 90
> > +
> > +    * - Name
> > +      - Mode
> > +      - Description
> 
> [Severity: Low]
> This isn't a bug, but the third column here is labelled Description while
> the generic parameter table above it in the same file uses Notes.  Was the
> difference intended?
Fixed in v5, changed to Notes for consistency.
> 
> > +    * - ``atr_sample_rate``
> > +      - runtime
> > +      - Controls how frequently Flow Director ATR updates flow steering
> > +        information for active TCP flows.
> > +
> > +        ATR programs Flow Director entries based on sampled transmitted
> > +        packets. The sampling interval is specified as the number of
> > +        transmitted packets between ATR updates.
> > +
> > +        Lower values increase Flow Director programming activity, while
> > +        higher values reduce the update frequency.
> 
> [Severity: Medium]
> Is "the number of transmitted packets between ATR updates" the unit the
> code actually implements?  Three details in i40e_atr() seem to differ.
> 
> The counter compared against the configured value is per Tx ring, not
> per device:
> 
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
> 	...
> 	tx_ring->atr_count++;
> 
> 	/* sample on all syn/fin/rst packets or once every atr sample rate */
> 	if (!th->fin &&
> 	    !th->syn &&
> 	    !th->rst &&
> 	    (tx_ring->atr_count < sample_rate))
> 		return;
> 	...
> }
> 
> atr_count lives in struct i40e_ring, so on an N-queue device the
> aggregate programming rate is up to N times what a device-wide packet
> interval would suggest.  Given the commit message mentions "systems with
> a large number of queues", should the documentation say the interval is
> per Tx queue?
> 
> The increment is also only reached for TCP after the IP version and
> protocol checks:
> 
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
> 	...
> 	if (l4_proto != IPPROTO_TCP)
> 		return;
> 	...
> }
> 
> so non-TCP transmitted packets never advance the interval.
> 
> Finally, the threshold is bypassed for SYN, FIN and RST, so raising the
> value does not reduce programming activity for connection-churn
> workloads.  Should the text mention that exception?
> 
> > +
> > +        Setting to ``0`` disables ATR sampling (no filters will be programmed)
> > +        The default value is ``20``.
> 

Fixed in v5. The documentation now says "TCP packets per Tx queue" and
clarifies the interval is per queue, not per device.

> [Severity: Low]
> These two lines have no blank line between them and the first one has no
> terminating period, so reStructuredText joins them into a single
> paragraph and renders as "... (no filters will be programmed) The default
> value is 20.".  The max_mac_per_vf entry just above puts a blank line
> before its "The default value is ..." sentence.
> 
> >  
> >  Info versions
> >  =============
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > index 229179ccc1319..6df7eb217073d 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > @@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
> >  	return 0;
> >  }
> >  
> > +static int i40e_atr_sample_rate_set(struct devlink *devlink,
> > +				    u32 id,
> > +				    struct devlink_param_gset_ctx *ctx,
> > +				    struct netlink_ext_ack *extack)
> > +{
> > +	struct i40e_pf *pf = devlink_priv(devlink);
> > +	u32 sample_rate = ctx->val.vu32;
> > +
> > +	WRITE_ONCE(pf->atr_sample_rate, sample_rate);
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> Setting the value to 0 is now reachable at runtime while
> I40E_FLAG_FD_ATR_ENA stays set.  Does this leave already programmed ATR
> entries resident in the Flow Director table with no way to remove them?
> 

Fixed in v5. The devlink setter now flushes existing ATR entries when
rate is set to 0, using the same mechanism as the ethtool ATR-disable
path (__I40E_FD_ATR_AUTO_DISABLED + __I40E_FD_FLUSH_REQUESTED).
> In i40e_atr() the zero-rate return happens before the FIN/RST handling
> and before the descriptor build that emits the remove command:
> 
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
> 	...
> 	/* if sampling is disabled do nothing */
> 	sample_rate = READ_ONCE(pf->atr_sample_rate);
> 	if (!sample_rate)
> 		return;
> 	...
> 	dtype_cmd |= (th->fin || th->rst) ?
> 		     (I40E_FILTER_PROGRAM_DESC_PCMD_REMOVE <<
> 		      I40E_TXD_FLTR_QW1_PCMD_SHIFT) :
> 	...
> }
> 
> That PCMD_REMOVE descriptor is the only software removal path, and it is
> only redundant when hardware eviction is available:
> 
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
> 	...
> 	if (test_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags)) {
> 		/* HW ATR eviction will take care of removing filters on FIN
> 		 * and RST packets.
> 		 */
> 	...
> }
> 
> I40E_FLAG_HW_ATR_EVICT_ENA is only set in i40e_sw_init() when
> pf->hw.caps has I40E_HW_CAP_ATR_EVICT, and it can also be cleared by the
> hw-atr-eviction ethtool private flag.  On such a device, after any TCP
> traffic has programmed ATR filters, a
> 
>   devlink dev param set pci/<bdf> name atr_sample_rate value 0 cmode runtime
> 
> appears to leave those entries steering received packets for flows that
> have since closed, while fd_atr_cnt and i40e_get_current_atr_cnt() still
> report ATR as active.
> 
> The existing way to turn ATR off via the flow-director-atr private flag
> does the teardown explicitly:
> 
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:i40e_set_priv_flags() {
> 	...
> 	/* Flush current ATR settings if ATR was disabled */
> 	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> 	    !test_bit(I40E_FLAG_FD_ATR_ENA, new_flags)) {
> 		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
> 		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
> 	}
> 	...
> }
> 
> Should the devlink setter do the same when the new rate is 0, or should
> 0 be rejected by a validate callback instead?  Note the later patch in
> the series that triggers a PF reset when re-enabling ATR via ethtool only
> touches i40e_set_priv_flags(), so it does not add this flush.
> 
> > +
> > +static int i40e_atr_sample_rate_get(struct devlink *devlink,
> 
> [ ... ]
> 
> >  static const struct devlink_param i40e_dl_params[] = {
> 
> [ ... ]
> 
> > +	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
> > +			     "atr_sample_rate",
> > +			     DEVLINK_PARAM_TYPE_U32,
> > +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > +			     i40e_atr_sample_rate_get,
> > +			     i40e_atr_sample_rate_set,
> > +			     NULL),
> >  };
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204541.3072415-1-anthony.l.nguyen%40intel.com

