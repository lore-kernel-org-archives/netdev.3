Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE23D16F1;
	Fri,  1 May 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649579; cv=none; b=ZMqoVk0miq3SWHu1k98wVO9NgFZeIbEAtb5zY/F7oS7GNhq/v8j2p3jtGuic3xIe8kxdGwqp1PPzyLa3MX7kIyl85xm+8WHA2tV5pD64KXQYI3IwcXAoJcUOO3e6YtPoSxgDDCLUrktV0upUbU7FQ+7eT2PqPA8+kxnLAOA++V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649579; c=relaxed/simple;
	bh=6PRsjuPArP4S1iH3EgrUV5/FjiwTHGBLaee3iEDRAqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFmDMkb+nHpuy88Qd7G5HG4IM7bpgjdpODK18+uAT9n3IjJyddAoPE4jfCFkXfh3ZRCps9HTmdfUtIDOhtMTfk7t3Ea5atxMKx6y0fH5amPessQW6CX3rxRhkkRSXxYeE1n/s0blOM7+b2qeuUDZRdOEmEaTukyp8uV/+iZUDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIV8lO8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIV8lO8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B3DC2BCB4;
	Fri,  1 May 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777649578;
	bh=6PRsjuPArP4S1iH3EgrUV5/FjiwTHGBLaee3iEDRAqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIV8lO8oD/bm1+JoakBDKYOexpgkai6wMeiePzDLLKW6bGQrScOkr9PJohEK/B/H6
	 eTmWRma/AiujOOMMjEDh1S+0Z+AE5TNAF2l4k6UFSTD9v1Ek6ICjoh8apcs3M/oegC
	 iMB42UOv77bBHt80Cm1KQEiH3z88IgS8ce2KcF42rjffSljtmKPHyyx+v4raFR53nc
	 JdSg0BWHXw9yfrz9aq2K5u3tmsRqwDy6IHZe/KIPxNYsYUkmoymRrEsLqI906PJdvG
	 Z1I3Lg47dFLs19rQ2eJr1MR3HBDn7k1QcojPjIvxO4ewyTxJmSK+iCH/a/00A4p6zn
	 YoB1ETcRuFUbg==
Date: Fri, 1 May 2026 16:32:53 +0100
From: Simon Horman <horms@kernel.org>
To: gfuchedgi@gmail.com
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amd-xgbe: fix PTP addend overflow causing frozen clock
Message-ID: <20260501153253.GJ15617@horms.kernel.org>
References: <20260429-fix-xgbe-ptp-addend-v1-1-fca5b0ca5e62@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-fix-xgbe-ptp-addend-v1-1-fca5b0ca5e62@gmail.com>

On Wed, Apr 29, 2026 at 02:54:14PM -0700, Gregory Fuchedgi via B4 Relay wrote:
> From: Gregory Fuchedgi <gfuchedgi@gmail.com>
> 
> XGBE_PTP_ACT_CLK_FREQ and XGBE_V2_PTP_ACT_CLK_FREQ were 10x too
> large (500MHz/1GHz instead of 50MHz/100MHz), causing the computed
> addend to overflow the 32-bit tstamp_addend. In the general case
> this would result in the clock advancing at the wrong rate. For v2
> (PCI), ptpclk_rate is hardcoded to 125MHz, so the addend formula
> (ACT_CLK_FREQ << 32) / ptpclk_rate yields exactly 8 * 2^32, and
> when stored to the 32-bit tstamp_addend the value is zero. With
> addend = 0 the hardware accumulator never overflows and the PTP
> clock is fully stopped. For v1 (platform), ptpclk_rate is read from
> ACPI/DT so the exact overflow behavior depends on the
> firmware-reported frequency.
> 
> Define the constants as NSEC_PER_SEC / SSINC so the relationship is
> explicit and cannot drift out of sync.
> 
> Fixes: fbd47be098b5 ("amd-xgbe: add hardware PTP timestamping support")
> Tested-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI generated review of this patch available on sashiko.dev.
While I do believe the issues flagged there warrant investigation
as possible follow-up, I do not think they should delay progress
of this patch.
