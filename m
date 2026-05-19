Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF242874E3;
	Tue, 19 May 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222381; cv=none; b=KfRroTn1Hxb0XTfBoVSvyD3Nt4r2ISYXfsLI5eIdQ8/kTHAtXgRPn9caEvPfbWNwpqE6q1HwwkISCK7R55j4EdUwXhkxYpG9m+NHl3r+HYP/+g8jvoodnvf59mfks0qWSyBueUXh6O+TrEE7OazPQqGSWABC8SuR9/zckjYfWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222381; c=relaxed/simple;
	bh=l6Cn7HEELqc4tHWwQOHslAPenl93wOtMeTnsCORUAJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw65Zf8MaU6tY5kRQqwoAWlM1Bf2P61h34GxtR3MceU9M9YnXstNzvQTXI26HZcnmEECQoYrH56fTExW9ReRJ4AQfsJ2os4b0YE/o+iFsPW9lqeIUvv2NgeuAQQ+BqnCN+9VHskEsrQZ9CKAzfKdT/0ZFhc6mB5j67kaWHZXe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCXbCoje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCXbCoje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC411F000E9;
	Tue, 19 May 2026 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222379;
	bh=1QaohRfK/Pp16YUyd3MuiVvxN0mjbrearDCh1e89Psc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nCXbCojeCCvfKedCNiIEtV7bDjml9LlzSW/PTswikOpX+BKEjtOon3XqRqo43h2Uv
	 ft1HVLjMOZANUWZ+PS5kcmX1dacX0SOR/My6IcNjWvMX0cJyQuqGcygoeVdNtCY82W
	 SHHxS9KYKwYtlFDT4iLZwHQPgg8Z/WgDyVKWyz18WNhGEfz8iGkX5mkzQzplRC6r2Z
	 8GTS8J6+DhulZLgMa0bXRmjX22Ci/r8zULR61OiDEIcAQ/hHj1eLksh5Kb43K6ycmM
	 ysdwUC9fnNgbbl/8P5iicMt6y8F+CrbVDWRvAaZOrWLE2glpvrvSScOxd4Jx9LTgET
	 SfePCzXTcowfg==
Date: Tue, 19 May 2026 21:26:14 +0100
From: Simon Horman <horms@kernel.org>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
Subject: Re: [PATCH net] octeontx2-pf: avoid double free of pool->stack on AQ
 init failure
Message-ID: <20260519202614.GA988238@horms.kernel.org>
References: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>

On Fri, May 15, 2026 at 11:18:26PM +0800, Dawei Feng wrote:
> otx2_pool_aq_init() frees pool->stack when mailbox sync or retry
> allocation fails, but leaves the pointer unchanged. Later,
> otx2_sq_aura_pool_init() unwinds the partial setup through
> otx2_aura_pool_free(), which frees pool->stack again. The CN20K-specific
> cn20k_pool_aq_init() implementation has the same bug in
> its corresponding error path.
> 
> Set pool->stack to NULL immediately after the local free so the shared
> cleanup path does not free the same stack again while cleaning up
> partially initialized pool state.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc3.
> 
> Runtime validation was not performed because reproducing this path
> requires OcteonTX2/CN20K hardware.
> 
> Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
> Fixes: d322fbd17203 ("octeontx2-pf: Initialize cn20k specific aura and pool contexts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI generated review of this patch available on sashiko.dev
I believe the issues raised there can be considered in the context of
possible follow-up. I do not believe they should effect the progress
of this patch.
