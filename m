Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8A37F8C1;
	Wed, 16 Sep 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563182; cv=none; b=A10UX64BU0KTVBwA++J70PZtM+aKiOrM4cUYkFlQwztfDsWNZnbA9Z2oLbQm8THUXj1qM5TysCVOn1q/ZyWBiO1w0NNQqQTltOhYBC6AoRKPKuNI90Kh1vU4QRRuizsTjexIUBPdVYenjzEfVtpF04J7izES1C3PrBXDnXFNQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563182; c=relaxed/simple;
	bh=1jPHqqKWVgzdASRumvweTZPlu0WRjucZswerhj1CvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFUM3gaYAKe53NF0eRRpUaCDENt1NilMPrqe1juGzyltpja/KJdcEB0o/P8Vp0W42B49OZj56qfbNTPGT+A+BVBgXmp+Gcgm4fwMgDfC1hgPQQfeKmRLeT4ImEmt9ckKdQy7JYY33NJ0POJjtbD7akf7h5eF2KBCkuPu5HYHO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlsZMWhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlsZMWhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7318B1F000FF;
	Wed, 16 Sep 2026 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563180;
	bh=ECGhs/jw631DcK951Pu4QrAhITSXxLczEZxG3qzOMuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FlsZMWhxqTrZxfa975FyF9k7IqZJ672OKh2vyiyW8ergfy0tX5lr6UrHMgJOdlDkV
	 EaFwAS8u5CjqS7HECHElbah/+oHVAC4pOt/E2hSjbl5hcoxtkhn647Quk3GdNOgK79
	 PfCznRL9lDCL0VojUDxdArew56r1LLH61A9t//qhAQJxcWLCIv4A/MmzYNqVn0i4vX
	 nekz1XfNtV6r1HCygaFJ5nPG7346dnMQY3xr1LSqDtnZaV/o4hCu1PJ3/JOyDsEE3A
	 ybnCfFcxH8A+e4jYBo5ZHYVTmfafMs7BG8HZ4riSWUQTNYEtkzgSdf/2kkqJs1f9lW
	 yuxyVxlaN5awQ==
Date: Wed, 16 Sep 2026 13:52:56 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net] eth: fbnic: Fix payload page pool error cleanup
Message-ID: <20260916125256.GH51261@horms.kernel.org>
References: <20260915104917.3978113-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915104917.3978113-1-bjorn@kernel.org>

On Tue, Sep 15, 2026 at 12:49:15PM +0200, Björn Töpel wrote:
> The payload page pool pointer contains an error pointer when its
> allocation fails. The cleanup path passes that error pointer to
> page_pool_destroy() instead of destroying the header page pool. This
> can dereference the error pointer and leave the header page pool
> allocated.
> 
> Destroy the header page pool instead.
> 
> Fixes: 8a11010fdd96 ("eth: fbnic: allocate unreadable page pool for the payloads")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

