Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D24848AA;
	Mon, 28 Sep 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586958; cv=none; b=jzDii2FP6zegK6IeFdDMAXue3vYlCnvRZOwAZZ5GigfcF6Rjbuy+gRu9TmJeTPuDdstViGZiZ3jLSu454I5f0SsOeUa2wLtAVeh9nkMeStuNw/aDjsp4DETxo6WVpveb3CwrgMBRB08P/qkKwcagXVL7bJTg1h7aocx8d3HRIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586958; c=relaxed/simple;
	bh=KA7msbkBhKRylE6ykkowL4wnegtKfawYoC5D3Gu2Aks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdADtLIHSlKzS5Yp3X+tKpIvHZJ9iBGiHMColGrNvfYUWOw7nNWBN+A3iTaxq4xXhx6GF3sy9jNRy6OClM/6VCGl70JlC3ibAUY+rjn+PLEDdmMM3lLmsek9rOpj1jIT9Y434Bhh2PqTCBHtQHvyh2Np0NlLhBxyZr5Dd+Ys3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljpQiG5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljpQiG5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566101F000FF;
	Mon, 28 Sep 2026 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586957;
	bh=kSzIqxDU2Z4/O/az/Uu82s65RFvMqhh8MlAp8bqUwPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljpQiG5P227/LcY7idizoYLptGbyQgKSFUC8/2oATpP46sCxkyyiRZO+xBsfikhis
	 wHhMaRx2n1sARJHUW5/G4R6prUcGQHvYGrw0yQd2RcG9bqu9e4OcM6OiFloxbNKYRK
	 hIHOtNF99l1wcmgq+m14bpB1LuoOAC0EUzG+P4T7A3id3/jKcucFyFl3veZg9PForS
	 eWQmq5NDyU4Y7fwKCaC80kiXyVSxNRER0amoFDf7IvyC+h9qF3riQVMYmYwH67SWy5
	 HARXCmqAjZ2+Xa4nV8m3goX8w84KTf1HELKMzcl7e74VyIqb7Jjc6seRq8/bQs7e3e
	 GYfm/3YK30Vlg==
Date: Mon, 28 Sep 2026 10:15:51 +0100
From: Simon Horman <horms@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Message-ID: <20260928091551.GK13925@horms.kernel.org>
References: <20260923234819.702327-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923234819.702327-1-oss.patchbox@gmail.com>

On Wed, Sep 23, 2026 at 07:48:06PM -0400, Yuho Choi wrote:
> idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
> calling request_irq(). On success, the name is released later through
> kfree(free_irq()), but when request_irq() fails, the error path only
> unwinds the previous vectors and the name for the failed one is leaked.
> 
> Free the allocated name on the request_irq() failure path, as done for
> the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name leak
> on request failure").
> 
> Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")

I don't believe that commit introduced this problem.

> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 defconfig + CONFIG_IDPF=m, W=1).
> 
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 4311ffa30bb1..e7d5e7923371 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4073,6 +4073,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
>  		if (err) {
>  			netdev_err(vport->netdev,
>  				   "Request_irq failed, error: %d\n", err);
> +			kfree(name);

name is allocated by kasprintf() which is a wrapper around kvasprintf_const().
And kvasprintf_const() documents that it's return value should be freed
using kfree_const(). I don't think it will make any run-time difference
here, but perhaps it would be best to follow that convention.

Also, for completeness, shouldn't there be error handling for the case
where the allocation of name fails?

>  			goto free_q_irqs;
>  		}
