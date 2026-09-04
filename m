Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05241CB5E;
	Fri,  4 Sep 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517134; cv=none; b=OuSobsl3rT/6TmPzzQGZ2YxBXhOLvsWy0d25M2AOqqpB8XyoW8D6uFQd53ceusY5eBN9nTCjMe3vDFSSaFdmS3VVGSracUXrgzPAsPDTzXeuqG3qBSyeo/AKn0aPQIqelRzLd32FWv13ObfvPj31EIWcWcB4j2zSFRIb4Dv4AgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517134; c=relaxed/simple;
	bh=2LfS1ILgRVJGhEydFtvfR8sucW1S+dwNw4DbtoSTMlQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPDGk1AGvyf0Lvc233gFo1g1KGlHUBOqPHe0fCVbaAFO1zlYQKr/mvIe+t1KiZW/s2BZCkcqXvse+jTV/tqS5605oZZq1ozkmV2ejG7DDZeoBIFS7ICLUb7hrzxg8bf78mBdahoeSpYTdOCR9ZHhOJ1glxsO5mtqL/gMCJjBGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHMxLatQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHMxLatQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7EF1F00AC4;
	Fri,  4 Sep 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517131;
	bh=XsT0Hkq+GMTpBqhe44EvCIfvwPLTkT5+iI32XCMiBCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eHMxLatQaD1YaNcY+DszNSwDBaLrpCgvSiEQ4SQDUhdt/d2DjU91wvikm4pLpWTp5
	 X5I/ZWXzhqXbh2mJlBjH0BQlNwFsfUT4xH39BKPvFa92Usy0kQFIVbVM6EW9V2d8qo
	 vw6fXVUIEjdY0M9Y9gFbjrdN6fVSZVa1sZB+/FMfTMer0CwZtvAuDRdjHIHI2bd24T
	 WZSSatyfNombzsT/9S/SGfs6ldWy3rIm6b/Z4y+8YZoxJGuVkA/UgZFOH8ojivqvsJ
	 NADAinc1m8uGnWb0XXLjmzWHaLE/TegKe9+ZsSstYh6tY4FYQalJB7PrhoBg6Etudf
	 vARZLewkDS90w==
Subject: Re: [PATCH net-next 5/7] bnge: Quiesce NQ0 around ring teardown in
 bnge_free_core()
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com
Date: Fri, 04 Sep 2026 10:18:50 +0000
Message-ID: <178851713033.4131868.1736986298233261886@kernel.org>
In-Reply-To: <20260901191728.643212-6-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-6-bhargava.marreddy@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claim: in bnge_alloc_core() bnge_resume_nq0() runs before the 'if
  (rc) goto err_free_core;' check, so on a bnge_alloc_nq_tree() failure…

--

bnge: Quiesce NQ0 around ring teardown in bnge_free_core()

This adds bnge_quiesce_nq0() and bnge_resume_nq0() helpers that mask and
re-arm the NQ0 doorbell and disable/enable its NAPI, and uses them to
bracket ring teardown in bnge_free_core() and the NQ tree rebuild in
bnge_alloc_core().  Both helpers are inert in this commit because no
bnge_napi has BNGE_NAPI_FLAG_NQ0 set yet.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index dc3d51f31e5ef..10d54568f2c56 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -563,6 +582,34 @@ static void bnge_free_nq_tree(struct bnge_net *bn)
>  	}
>  }
>  
> +static void bnge_quiesce_nq0(struct bnge_net *bn)
> +{
> +	struct bnge_napi *bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
> +	struct bnge_ring_struct *ring;
> +	struct bnge_dev *bd = bn->bd;
> +
> +	if (!BNGE_NQ0_NAPI(bnapi))
> +		return;
> +
> +	ring = &nqr->ring_struct;
> +	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +	synchronize_irq(bd->irq_tbl[ring->map_idx].vector);
> +	napi_disable_locked(&bnapi->napi);
> +}
> +
> +static void bnge_resume_nq0(struct bnge_net *bn)
> +{
> +	struct bnge_napi *bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
> +
> +	if (!BNGE_NQ0_NAPI(bnapi))
> +		return;
> +
> +	napi_enable_locked(&bnapi->napi);
> +	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +}
> +

[ ... ]

> @@ -1345,7 +1394,9 @@ static int bnge_alloc_core(struct bnge_net *bn)
>  	if (rc)
>  		goto err_free_core;
>  
> +	bnge_quiesce_nq0(bn);
>  	rc = bnge_alloc_nq_tree(bn);
> +	bnge_resume_nq0(bn);
>  	if (rc)
>  		goto err_free_core;

[Severity: Low]
Is the placement of bnge_resume_nq0() before the rc check here
intentional?

On a bnge_alloc_nq_tree() failure the internal cleanup has already run
bnge_free_nq_tree(), and only after that does bnge_alloc_core() re-enable
NQ0 NAPI and write the NQ_ARM doorbell:

	bnge_quiesce_nq0(bn);
	rc = bnge_alloc_nq_tree(bn);
	bnge_resume_nq0(bn);	/* arms NQ0 even when rc != 0 */
	if (rc)
		goto err_free_core;

At this commit bnge_free_nq_tree() frees the NQ ring memory for every
index without exception:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_free_nq_tree() {
	...
	nqr = &bnapi->nq_ring;
	ring = &nqr->ring_struct;

	bnge_free_ring(bd, &ring->ring_mem);
	...
	kfree(nqr->cp_ring_arr);
	nqr->cp_ring_arr = NULL;
	nqr->cp_ring_count = 0;
}

Tracing this to the end of the series, the exposure appears to go away:
bnge_free_nq_tree() gains an "if (!BNGE_NQ0_NAPI(bnapi))" guard around
bnge_free_ring(), bnge_free_nq_arrays() skips NQ0 as well, and
bnge_napi_poll() gains a guard for the one piece of NQ0 state that this
error path still clears:

drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:bnge_napi_poll() {
	...
	if (unlikely(!nqr->cp_ring_arr ||
		     idx >= nqr->cp_ring_count)) {
		raw_cons = NEXT_RAW_CMP(raw_cons);
		continue;
	}
	...
}

Would it still be worth moving bnge_resume_nq0() after the rc check, or
at least noting in the commit message that arming NQ0 on the failure path
is deliberate and relies on those later guards?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
