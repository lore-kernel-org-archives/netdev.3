Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4C4E2F1A;
	Fri, 18 Sep 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737302; cv=none; b=Ms+OC9JwE/q20ujIDOqXTrXOeo666HZnjYJduKn7u8D6Hx86+u39EsLWUsAdUFQeEl3n8+jtlvXH8CDtDAYPE0/lPVKskHt8dSAryl+0Q14LfW90anTMAaOsoC+9/vb2Ur0w6qMP/bg4AWj75ts9QDzvrXSmLUj8vvRwWA6cdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737302; c=relaxed/simple;
	bh=Dp1ikT7X94yUIOvE+LAkmUAElxRAN2vlyZ8s+B/uXYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXtSoFVOufRV/fTPLgCeAY3Vblnu9CUPFJUd/tYMEqn1CKW511+ADgzWyRAyNAhcy1pDNUUmgAIcR8PxRh3AvheOEyoFe3VpojJjfRjT2MSir/NRPQDzKBbeUhUKpkdKQBnUIg37ZGNprIgjmfZ77CvWoqyv0TpEdFIn4aAWU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT+IaHx+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT+IaHx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50DF1F000FF;
	Fri, 18 Sep 2026 13:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789737300;
	bh=2C4pMhUvVIUeS+ugXdhw1S/i7ZPUhwZW4UiMI82ODyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AT+IaHx+ruXTf7GbqHeQ9MHgM410OMUcCP5aMqruqoyoXjRVG9uk574T6PpmclSg/
	 GG6MnPXkW6hAE99TOJut3/XNeahDnoumj6AylqBJbyU3Fzvy1fyK/VfQOSyiBDaILX
	 OoBNbux4/B+UKpm8eGl9GdLt9tPaFy+Yed4Q9Am3bR09NJz2UBzFn4wjA83Uw/SeFp
	 FRDvJmvZ3UpcwMW9TKsG8WhrslkpyCFe15LhmD74z0rSm58IE5Cjx5gwbO0OvB5Cj/
	 UKfZ6+83K6+Fb/oWbeGtXkWE3xqKj1GUg+6wU5X3BJs/+gzxsghTFKMqVRLqaIEQNG
	 oe4nXiTATg6Uw==
Date: Fri, 18 Sep 2026 14:14:55 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: bolin.liu@seu.edu.cn, sgoutham@marvell.com, rkannoth@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: skip absent MCS blocks in PTP
 configuration
Message-ID: <20260918131455.GJ51261@horms.kernel.org>
References: <20260913125212.110005-1-bolin.liu@seu.edu.cn>
 <178939359634.22033.5655691023198601345@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178939359634.22033.5655691023198601345@kernel.org>

On Mon, Sep 14, 2026 at 01:46:36PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0
> 
> - [Medium] The CNF10K-B branch of rvu_mcs_ptp_cfg() uses the CGX/RPM
>   index directly as the MCS block id: rvu_cgx_ptp_rx_cfg() obtains…
> 
> Pre-existing issues:
> - [High] mcs_get_pdata() walks the file-global mcs_list with no lock, no
>   RCU and no reference counting, while mcs_probe() inserts entries with…

Hi Slavin,

There is an expectation that AI-generated reviews forwarded to
the netdev ML are responded to. That can take a variety of forms
including an email response that agrees with or refutes the review,
or an updated version of the patch with an appropriate changelog.

The expectation is the patch author or submitter handles this.
But in order to move things along, in this case I've taken a look over it.
And it appears to me that both issues warrant addressing in
the context of this patch. Possibly expanding to a patch-set
containing more than a single patch in order to solve one problem per patch.

-- 
pw-bot: changes-requested
