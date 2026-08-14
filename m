Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21436382F10;
	Fri, 14 Aug 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716060; cv=none; b=jYfhidLNqTi5Cp60eSlFsE5GI7Rx62GJgx8AjhG/+8DsqR2GzvLgqmSYWwCPh/5QSKYESpgC63gaulgaSQDvnS7LhOjdM/tftsoQAoOyyaVy8su5UTyR5m9zNPvAbjKj3BY6u3bSgrfCskfe/cB8xtoVQvwo/POe9wUQaYso2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716060; c=relaxed/simple;
	bh=LslceuiY8HZRBaqg6P5ub9AiOyzRd9BR/BleMyoY9Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS7iypmjf6EuQJoRa9JZ4kmJPBCHCdwi9lRVZB4RU9ZrKViZYhnMB6gORzWO78Wk1Cu4dpeGloin3iw93Yd3EVwOfMR8gPfSZOn3Q8dSh5jJdslsSli6gWbZDvBcJueTHCTPa2LngB2ZegtSzYHmZW3MwUGzoj6yq5/XyGGjk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IanslU2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IanslU2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683C1F00A3A;
	Fri, 14 Aug 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716058;
	bh=4sI8JODm7fVR7BgNeRz4w2a/a2exGgyy219YJnkD9mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IanslU2FKU2IUT9OPKMRS+av0y+cLb3ns0kwktpivGhqUBkwGrkY6G+pgYvl0xyOf
	 6kMxWoR0uDor3yVDoJDWikSN6R4gqNcw+LwTcI1N1C0o6NQ1nLLjgPn/ETCxWd/8jZ
	 /sjaXq6M0Y+P9Hf0aaSPhFgK3kEJQC23GZ8laBhTLZcQtAgSodXQctglMoGTMJVD/4
	 fPaoQb13dQvuJz7709cS3w4Cvftm2bpVDMJazutIyFxre0WRNvktgMtZh3lXh/tuYe
	 xGPx7OkJRjrU9CXXymcmTncaiSQQs7+iNGS14J7o8Xb0AiZo5kG0rm0aTsFKzjmGDK
	 424gtVLWoTbgg==
Date: Fri, 14 Aug 2026 15:00:54 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] octeontx2-pf: Add NIXLF error and poison
 interrupt handlers
Message-ID: <20260814140054.GN265046@horms.kernel.org>
References: <20260812160627.3992050-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812160627.3992050-1-nshettyj@marvell.com>

On Wed, Aug 12, 2026 at 09:36:26PM +0530, nshettyj@marvell.com wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> Register and handle the NIX LF error (NIX_LF_ERR_INT) and poison/RAS
> (NIX_LF_RAS) interrupt vectors, The handlers acknowledge the interrupt
> and log the status (ratelimited) to help debug NIX LF faults.
> 
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index b022f52c6845..2a5630561b12 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -554,7 +554,7 @@ static int otx2vf_realloc_msix_vectors(struct otx2_nic *vf)
>  	int num_vec, err;
>  
>  	num_vec = hw->nix_msixoff;
> -	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
> +	num_vec += NIX_LF_POISON_VEC + 1;

Hi,

There is an AI-generated review of this patch available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812160627.3992050-1-nshettyj%40marvell.com

The following part of that review seems of particular note
and I am wondering if you could comment on it.

  Can this fixed vector budget end up smaller than the number of CINT
  vectors the driver actually registers on a VF?

  The new count reserves exactly 64 CINT slots, per otx2_common.h:

	#define NIX_LF_QINT_VEC_START	0x00
	#define NIX_LF_CINT_VEC_START	0x40
	#define NIX_LF_GINT_VEC		0x80
	#define NIX_LF_ERR_VEC		0x81
	#define NIX_LF_POISON_VEC	0x82

  but otx2_open() still walks the CINT vectors from hw->cint_cnt:

	vec = pf->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
		...
		err = request_irq(pci_irq_vector(pf->pdev, vec),
				  otx2_cq_intr_handler, 0, irq_name,
				  &qset->napi[qidx]);

  For the PF that is bounded, because otx2_probe() clamps:

	qcount = min_t(int, num_online_cpus(), OTX2_MAX_CQ_CNT);

  otx2vf_probe() has no such clamp:

	qcount = num_online_cpus();
	...
	hw->rx_queues = qcount;
	hw->tx_queues = qcount;
	hw->max_queues = qcount;

  so hw->cint_cnt can exceed 64.  With 66 or 67 online CPUs the CQ loop
  claims vector indices 0x81 and 0x82 with dev_id = &qset->napi[qidx] and
  no IRQF_SHARED, so the new request_irq() for NIX_LF_ERR_VEC returns
  -EBUSY and otx2_open() fails through err_free_cints.  With 68 or more
  online CPUs the CQ loop itself fails, since pci_irq_vector() returns
  -EINVAL for indices past the 131 allocated vectors.  With the old
  formula the request grew with hw->max_queues, so both probe and open
  succeeded in those configurations.

  Would something like requesting max(NIX_LF_POISON_VEC + 1,
  NIX_LF_CINT_VEC_START + hw->max_queues), or clamping the VF qcount to
  OTX2_MAX_CQ_CNT the way otx2_probe() does, work here?

  Also, the comment above the PF change now reads oddly:

	/* NPA interrupts are inot registered, so alloc only
	 * upto NIX vector offset.
	 */

>  
>  	otx2vf_disable_mbox_intr(vf);
>  	pci_free_irq_vectors(hw->pdev);
> -- 
> 2.48.1
> 
