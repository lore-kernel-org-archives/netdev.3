Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD242B33E;
	Tue,  7 Jul 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434508; cv=none; b=rFnDH2RTqmsIX2sB8sS3W2PY16IBkmsrjMfJm5xAMaTdgGVFxTGphnZuKMBiFmoU/8d7yzNwH+l5cKm18OMMIuJzO21AXNnf0L7es+bLy5dx8RYB+FDy8TPZKIsomCZGIVME3qJlUX3D4R8DPFEMOzenGIP16+9dfSkmFzjtE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434508; c=relaxed/simple;
	bh=gqo6gEXoTe3fyScoNbc3NuYFQSDPGSJ2qCj+N/PDt48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXHuyJBI5uWjzMmcuKEs/Khth/mWcfYbEzR+5FK/OgG08YR6MABSPHZ7avDrbcFvobtfKxwPVQkmcIIil9sC+fy9tTQ+c3d/UyI7jDn62nBRCUSv84pfBcu1M2p69Jrq7dGFRrN01XN73zpv32p9FoTB71/RZaI8SN7QJ/tj9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAuOSXlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAuOSXlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F51F00A3A;
	Tue,  7 Jul 2026 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434504;
	bh=41ZeWzV7SKIfQsoqHph9zP5Zb0gN0C45td++j9BlLtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BAuOSXlkMdqrioqpjtcxpTdT98et0cG9eWj4RaTRmpYvjsiOu4jz0RWpj911sJ+1Z
	 RZkLoFCOJY+NlBBZ3RFGje/VZM1UOGN4ATixu2RMTM9QNKOPpK1p76FXe+x5EelcuS
	 5yZ+J8NsrIpqQoe5fJFTOOXRiNujB1cAvoA30P5ZrFBZ0TmTFh4D23bPC+LunCSwtq
	 pUED9N+PSFTT7U2hxJ0fwK0GWLJ6tpweU8EMRvfco/VbktbHXUwqKrEUBb3kBWvp5s
	 2t5GoRSOx4SWzWutPwlXO+By+f0SQj/Ml3hD2EV/09iYkRfOXSt/NPAuoR0DV/1v+p
	 aFlfTacoUbysQ==
Date: Tue, 7 Jul 2026 15:28:20 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Message-ID: <20260707142820.GG1364329@horms.kernel.org>
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>

On Wed, Jul 01, 2026 at 08:39:25PM +0800, Runyu Xiao wrote:
> The GTP PDP lookup helpers are shared by RCU-protected data and report
> paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
> helpers walk RCU hlists, but they do not currently pass the RTNL
> condition for the control-path lookups.
> 
> Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
> RCU-reader callers remain valid because the RCU-list macros also accept
> an active RCU read-side section; the added condition only documents the
> non-RCU protection already used by RTNL control paths.
> 
> This was found by our static analysis tool and then manually reviewed
> against the current tree. The dynamic triage evidence is a
> target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> to documenting the existing protection contract.
> 
> This is a lockdep annotation cleanup. It does not change PDP lifetime or
> hash updates.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI-generated review of this patch available on sashko.dev.
While I don't believe that the issues raised there should impede progress
of this patch you may want to look into them as possible follow-up.

...
