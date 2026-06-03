Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754048165E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500354; cv=none; b=tuqsHnNImiVuWHL/1ZT7Tq++XKuySL6LNMiZSlTNjbRg7v0rMouDYxp2pM9rakLQg8KokckBWtOzVwGrOTNGecpDdhyR+5/n7uXAqMoL3KiWYz1FtJFp9ZydABjQuGAIfXu3Dx0kpeavPpH1nIfdhZPGiOhEadMbYnMFQYkJRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500354; c=relaxed/simple;
	bh=hiV5wjfi0ksmcZVrrOgVqE6eZqBUzpFFmG8w8NDSGY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsBB6iyYtohjreZ/k442VOeUbXJ+q8YK9B6n/kHeY1qWcTYsTUhwgAQZLWKBIjavRKCudNZ2ailKd+Eg8o7u1XXevTwlut21Vagvyt8rTA7M7PTy2PsmWNfmOQAuZqXtVla3ykWo3V/XLUiORQCZApQu6eH5udjZuELh4TzZNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2rzOcWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2rzOcWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098331F00898;
	Wed,  3 Jun 2026 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500353;
	bh=QY2N2XF8Xy9LWkg4ETKn3pjdKoLHVKBBH9yoExCV/Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y2rzOcWO1NAzil44qLurZP9u983aIjK0LhY1d+ZhU/ElgdBesAXvQEUCST9bGRUG6
	 Ldix1n4GvO7ImRTOOHYBXtRlsFLX38tj7IKhbASNmGLGlVs4rgpERu+G/E4Q3gzMuo
	 M2D/U/r8JPjcxdvm6h9SjwLHrB5yWgTxM38mHsqzrg3VKDSp1//lbBFiMXzHdf/bME
	 gxVbJ93Kye1bKqUe+ZB4OtX07+uJXIhymd+ZytcCj11vgXIrNOjZX5lLQYLrl7yvyn
	 SaMqQCljVCMm8MyZLSEr+PlJifNilojGYCWv4V/pgPXAT0em1lzQBi2Om40z+PLm57
	 gKSzOnHnr0d1Q==
Date: Wed, 3 Jun 2026 16:25:49 +0100
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 1/3] net: libwx: add support for
 set_ringparam in wx_ethtool_ops_vf
Message-ID: <20260603152549.GB3766816@horms.kernel.org>
References: <20260529075147.88398-2-mengyuanlou@net-swift.com>
 <20260603152134.3794913-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603152134.3794913-1-horms@kernel.org>

On Wed, Jun 03, 2026 at 04:21:34PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I forwarded this in error.
I don't think anything in this review is
actionable in the context of this patch-set.
