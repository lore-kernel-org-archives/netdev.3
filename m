Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB739213254;
	Wed,  8 Jul 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516077; cv=none; b=SEK42fLxPpF4bnLVL98JQKdIplX6Gz3bMe/kzNLuRrHDScJDIyTcCc1oudOONziWauSeZT5ohBQ40egysteOkBWrQddSNT7TBPNBGGg8jqO9GrazJUi3XuGpOpd7cAkYgSvrgzXe1xnoXB2v+OlHxsQFB5CjiPeag53WeZL98ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516077; c=relaxed/simple;
	bh=68S989PONmhv7+eqxY9lQaNx5Y4o6WwzG4wnhKkqZlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnTu7aFd2j54Z0BLF+Q1iyanJlD17gy74tyl/QMHPxuUEIAxJmT6nk8kHHeK2vCQ6+8ZcAzhLAxfajmb0KLgCKXaEorA5IVzqMFQw1md3bDEo6zU/6ABKHG30hCQFqdcT2Zuz8Dby+2SDW5uKGxiejdNcmca2VYBpuTDZVqbgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2jit3P9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2jit3P9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C11F000E9;
	Wed,  8 Jul 2026 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783516076;
	bh=Hd9z8VELC8Q9jRxuWHqe0GJM5+T9P0twkrs5m0ntfM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2jit3P9I90j0FZjTmExlp1xbmH1GSvS4sU8IR3MyVc5sSpljbnNNdxGqkxsK2C3L
	 mmYeQcbz4811i4MpBns2qIcDzmt9GY+4F/qGKEsnth8bJVmZmIv5WEKSMvsQUm/pQM
	 NO2tCBRiZn0uM881e2uvqCJHEWrnO5D/LI6E1LdqS/AooESId9VYxZ8wbpk9zUpMWU
	 lm0hR7ekV4iUpI/DpMsN629BQUCuTyQfrFxrOzIlGoL4QPaVjaoUXam5hAkIom7RVK
	 QhaS3ubPY4NCh+harlsLa6KhQELB2Bb3QucvWb+CkBPivRb0Z/fnrNq2Y3kwH5rt0E
	 RsIdGMCRFtPAQ==
Date: Wed, 8 Jul 2026 14:07:20 +0100
From: Simon Horman <horms@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds read in activation
 parameter parsing
Message-ID: <20260708130534.GA1481798@horms.kernel.org>
References: <20260628210026.129941-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628210026.129941-1-meatuni001@gmail.com>

On Mon, Jun 29, 2026 at 02:00:26AM +0500, Muhammad Bilal wrote:
> nci_extract_activation_params_iso_dep() and
> nci_extract_activation_params_nfc_dep() receive a pointer into the
> RF_INTF_ACTIVATED_NTF notification but are not told how many bytes
> remain.  Each reads a one-byte length field (rats_res_len,
> attrib_res_len, atr_res_len or atr_req_len) and then memcpy()s that many
> bytes from the packet.  The length is clamped to the destination size,
> but it is never checked against the remaining activation-parameter data,
> so a notification whose length field is larger than the data present
> reads past the end of the buffer.
> 
> The sibling nci_extract_rf_params_*() helpers were recently given a
> data_len argument and matching remaining-length checks, but the
> activation-parameter helpers were not updated.
> 
> Pass the remaining length down and validate each field against it before
> copying, as the rf_params helpers do.
> 
> Fixes: ac2068384034 ("NFC: Parse NCI NFC-DEP activation params")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-=generated review of this patch on sashiko.dev.
However, I think that the issues raised there can be treated
as possible follow-up rather than impeding the progress of this patch.
