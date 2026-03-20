Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450503D3329
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025099; cv=none; b=SpECitPFxY+PDcdyC8PpWW/USzUIdH5w3F9RRuQn/d1If/JwoWkcl+Xt0l0GgAvVwpgWEHb2V4lTAOU26G35y2UPRQ7irMxxshCEoOIRvMRv6jRT1PV7wwoH3bMBymFHDrZOT2nxqwcP3Bp992lo8v3N6drBBgmS7BQWU0PPCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025099; c=relaxed/simple;
	bh=XvtyeRdyTe4yJx38Xxj/5vma5vmFAWY0GDfAooXKx4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slj9jqE1XTXV7eZJKVNennShxdTTJGx9gRVWv6Qn6DqpAQyT/Hxztybv+4j7Jy5hg2X4Kiaqu42u/XsYYwUV0BZ9gTYacNx5QaA10j1fKavAnXfdPNZQ1oDb6Q1exhDgbcFZjuwj2ymQwgcO6Q8imDrybry96vfL7Ng6yuQU50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4WdYjnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4WdYjnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA532C4CEF7;
	Fri, 20 Mar 2026 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025098;
	bh=XvtyeRdyTe4yJx38Xxj/5vma5vmFAWY0GDfAooXKx4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4WdYjnc+0tljIDD4t50zjsaVKOrzd4XoUrF8CblSR2EWpROoj37yMu05o8x0RTOq
	 PmRlptITKk9rU7AY0QHKFnMrsivf+WeI0OKEsX0V5j2zlewfFzmTbsrTTOYMRDH+I9
	 /OA6gdbno1/+uvX5v5ABx8aDH1pgWazTth/k9TXFeAPxHEbY6go4JgziPRQQb8KGDr
	 lb4QS5Iv+R6CAf+3EuFhhW98U1nWzvSvWr8QTvmmYbXHUYioH+r+Ju0S2OrVMgd4az
	 hc9RbqXhfJ4GgkpSapyISIrJRSeY3xPXMnqET49chgXFnpvpfYPsmZruU809nVMK0h
	 HCGKaEJ9NR9bw==
Date: Fri, 20 Mar 2026 16:44:54 +0000
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net v2] ice: fix posted write support for sideband
 queue operations
Message-ID: <20260320164454.GB74886@horms.kernel.org>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319111659.551039-1-przemyslaw.korba@intel.com>

On Thu, Mar 19, 2026 at 12:13:27PM +0100, Przemyslaw Korba wrote:
> On E830, PTP time adjustment commands sent via
> SBQ don't generate completion responses, causing the driver to
> timeout waiting and return -EIO, when trying:
> 
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
> 
> Add support for posted mode not to wait for completion response.
> 
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> - change "postpone" to "posted"
> - init struct with {} instead of {0}
> v1:
> https://lore.kernel.org/intel-wired-lan/20260310110700.345904-1-przemyslaw.korba@intel.com/

Reviewed-by: Simon Horman <horms@kernel.org>
