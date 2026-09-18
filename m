Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6E4E7816
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744341; cv=none; b=uZrpJU1mrvN9jY9CsuL7OcT9eXZn9CGiMZkgoD3Lu7EIVEQuEkkNj18TZPpffD4Byv9Ux4YWp1uDQaXc47r1WH0KKtF6GLo5PiB34VN4Gu++fxrMAGaWNZhOGrGPCK1sV9eFlbrb0TLhvkSK/COm2e7nQceJG6vIN2esCNI/Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744341; c=relaxed/simple;
	bh=YpcYjmHh+3bEQfjta1+b+ENgptOyvE4kBs34OQRJNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4LWjOrYCLWoddcrPzDOJ42uRPGPkLWJIe3XGWmS+dv2NiTbFBIpx2uHWJ/N3xwrzxR5go+OfFln+pe88oJnX19qAjYJbbzE6zr6iSiR1m07+LE8dTlOClOJfyrPOzTDY1kqXkV/StAPN/EcZARa3ylE5n+Z2tkybuaTAf6Q+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOgqaXpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOgqaXpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C6A1F000FF;
	Fri, 18 Sep 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744339;
	bh=WpPQDLa8Sx4nTL+45DH3ON+KwEYm1nCt597VX4vcAhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eOgqaXpuTj41ftCt3KrPUfqyvTdxXCP0X7O2eMaNvS0ACAyHPW0QVXjudfHi+AZbN
	 ho0CbBfcNaU3Pxu+EbUz+QZHQvvsmywL2KZNqyQZzF5lQALqBNVpkcIKI+jjRLSj9K
	 C8Gnr9PcK10DAxSrWMcqm13ufHsH/Qb+4/ZlDDkZB2lN12HS5NYSmcKVYgB3ZD8yYt
	 DTD8BAiNYXH1DLqRcZlvCzyaEEAhYkw9APsHWl86hT3a218sB1maRrTIUyvifMQM/V
	 qgIsAh5gnSObCXYwCr7TAIlYsjoD71LC75mrwKS4/9ITjiO6eiT5UqPRKs3bkQa8rG
	 lcYqflJPZCsHQ==
Date: Fri, 18 Sep 2026 16:12:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/5] iavf: fix error path in
 iavf_request_misc_irq
Message-ID: <20260918151216.GL51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-3-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:48PM +0200, Aleksandr Loktionov wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> When request_irq() fails the interrupt vector was not registered for
> the driver. Calling free_irq() on a vector that was never successfully
> requested triggers a kernel warning. Drop the erroneous free_irq()
> call from the error path.
> 
> Fixes: 5eae00c57f5e ("i40evf: main driver core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This feels more like a clean-up than a bug fix.

But regardless, the change itself looks good to me:

Reviewed-by: Simon Horman <horms@kernel.org>

...
