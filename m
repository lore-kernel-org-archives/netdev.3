Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C4439F88;
	Tue, 22 Sep 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061419; cv=none; b=UPutBKlOlF8+kpnD1wuDd4w1v7u8943n2sIOcz/LH+MBVRoPM4Tq1Nj6yaA3L97rR8AJ+tpft2G+jWAjHeEsNoSA8PQEURhy1rNAhFDnwMObJnID418LgGLz3B5uFqSza1GZgaMegVzHRZWgU3/g5N5qdQEbu+kw+VhI4qLuCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061419; c=relaxed/simple;
	bh=eXNCPrKfHJPcki+h0vGLiwriuGBBLEfHPIdO7YzqF+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERrnom2+2I67kOR+1ZrtdVgnqk5ZhdXMUKwL/C/mBZihblTO9EsGcKEA7Y9AtkxQlaCDmnVWQ06a7Ag7V3FQED30yl2bJu2Wo3nzYYrexRbkdlV+tWqHD1lbQ5bRD/EvoDZyU+coQoiB6iym+KWZbHq3tHN1NgWeggeeBcvrjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArMiyMDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArMiyMDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444571F000FF;
	Tue, 22 Sep 2026 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790061413;
	bh=1ozzugNwC0Ma5vqRPrIYqe8LPeS4FR9eJ5gGP57BVro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArMiyMDRKoNLF6dfedUrV3xOp45+gIXu1v9EuFtb9duiUYCDxTPMd7MZBSmg2PT9u
	 qw1Y30c8ze2u+SEggDAxNJmwQY37gc1h4UfXRs+VKi2CB+jAElqW0T23p23uCBSIah
	 7RrQ9FCdyWD10O4wDbr/EqWrTZ9BrHbs8P7/V3a+dU1hSsORONMjLg8SzBtOHo3At/
	 nYSazROsdJ3iP889Cu3Ux3oSOHNDVKsY3ix1XeACYquyTKuezTH7oYKKrBMJWidHZ2
	 74DexlQxTIZzDmX7TlXsM+LrlhL9HPLc5fcUpbgfXEUvsdwUPn4m9S9fwchVncntU9
	 4G+nJGnBfgH1A==
Date: Tue, 22 Sep 2026 08:16:48 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	David Yang <mmyangfl@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Nishanth Menon <nm@ti.com>, Wingman Kwok <w-kwok2@ti.com>,
	m-karicheri2@ti.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: netcp: fix pm_runtime usage
 counter leak on error
Message-ID: <20260922071648.GZ13925@horms.kernel.org>
References: <20260918042804.13101-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918042804.13101-1-phucduc.bui@gmail.com>

On Fri, Sep 18, 2026 at 11:28:04AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> pm_runtime_get_sync() leaves the runtime PM usage counter incremented even
> when it fails, but the error path in netcp_probe() does not call
> pm_runtime_put_noidle() to balance it, leaking a reference each time
> resume fails.
> 
> Use pm_runtime_resume_and_get() instead, which automatically drops the
> usage counter on failure, fixing the leak.
> 
> Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core ethernet driver")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

