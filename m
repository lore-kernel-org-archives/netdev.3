Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF1318EF3;
	Wed, 18 Feb 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409327; cv=none; b=j+j7l7dRDTNBzXv91xy8M9JckZ8fJwq1XKu7VC1tm//+h1jBhPFaJDA4maISUAKWsND0/Uv7LfNs68ue5X29IfO/2g0+ZoeSsqGRqVPW3u9W3lD4MpQaxh23d0wSFZiuxbj2g12Qq1glUW9ekRWLZzHEpXGHO7O2NTJgU9yz1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409327; c=relaxed/simple;
	bh=8wVSrOkJuWNj1ya33pRQkBNo/9BCw3Mt6Hqmp4kc1uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4HMExxEQVoaAQSffiFiz3HomytczTHpFoy8hggEfiily7kqoPdsfwUBR/Ra5NcF+72wc62Xg7TdB9d9N4X53CbneoNg7lQMCrnFE9ze0NrwIBeAqGXvg5DoDomLX/Y2lpl9/gTti4GLEzNEZoNKL36CDlvDZw6jsxkSZVjbi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYLjhRSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYLjhRSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDDC19421;
	Wed, 18 Feb 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409326;
	bh=8wVSrOkJuWNj1ya33pRQkBNo/9BCw3Mt6Hqmp4kc1uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYLjhRSoURz9E+I67P1izIPbV1KnvA1Aq6Ofntc1C6YvbkJ3p7+4n+PC9BNMaFs5j
	 yg8e/L69aYTOYP2N1WMB72rqP9iWPxod2/CQ6mu78KV5L0xqbcw3inMIjF9jMDdCtq
	 yLylfmUsIYjL+nFxtLzJvSzgU5TZ+f8JiCRtUy+YWOs1OSvrm3sSvoCIu3dRHDPQeP
	 406lEsJuFPU6m+XV8Iu52n8Tf0Wt65hEfJivN3KmnFFQjZODPYDjQWn8wtLz0Is7Jv
	 LOIft9rda0MVXcafXSaPYdt8UOAw3Cxc04ozM6YtbljdrzHnIyXjuZFd8uV8SBA6OI
	 4MIagG5BndOHg==
Date: Wed, 18 Feb 2026 10:08:42 +0000
From: Simon Horman <horms@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, rajashekar.hudumula@broadcom.com,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net v2] bnge: fix reserving resources from FW
Message-ID: <aZWPqvRJtjophunO@horms.kernel.org>
References: <20260218052755.4097468-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218052755.4097468-1-vikas.gupta@broadcom.com>

On Wed, Feb 18, 2026 at 10:57:55AM +0530, Vikas Gupta wrote:
> HWRM_FUNC_CFG is used to reserve resources, whereas HWRM_FUNC_QCFG is
> intended for querying resource information from the firmware.
> Since __bnge_hwrm_reserve_pf_rings() reserves resources for a specific
> PF, the command type should be HWRM_FUNC_CFG.
> 
> Changes in v2:
>   -Fix commit message.
> 
> Fixes: 627c67f038d2 ("bng_en: Add resource management support")
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>
