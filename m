Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187535677C;
	Tue, 16 Jun 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594067; cv=none; b=fLK+/im2o5PEo+k1qC/MFJUaYH/9Or/QsJGimeVBkEdbLiViKnZyqLe6BdUrVGKT0tK6js7YqBxTL3F2YPd8xm/RPt2KbviruNhw5Fdo9PBOaz403jO04ndp7CcoQRulLSudgaBTOy2jRrnIq4FNB1BJM+zVen7Lkq74Y92sq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594067; c=relaxed/simple;
	bh=XyeuJSA5ykEepUX4T61ME8R17/PH3rJkpHyO9CAyPcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF7huDJ/nt/WF6lfmbjwEwrZhTiCxH6zYvNHi085OIibQJywcnpuk4KPaA64bYBoPAe6wr9/7TEvTC9gVrc8A72mJqcgm4w+s+/bi9IhE8bKCBZ3JDDluqRhlwk4HwVZuCbm9VWWmJImvgOHYQLE+Cpgj1TFzClWm3Fve5tSjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpsV1r3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpsV1r3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B481F000E9;
	Tue, 16 Jun 2026 07:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594065;
	bh=M0RU1VheFArMiljHn9UwUVqDKTFvTtGQQ+qx5jR33jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VpsV1r3Rmn3q8P1djjCsi62QvF8Nvdagb0/DCqtLQjCeCcOCxwkh0PFvS1iaL2sYm
	 IaI/3/SL5Slkzdqm3wdK/MnHPu2QDBIjCh5C3xa2QMS09Hn+GeO1RLrKqpk9pk+Eup
	 gzSUUAkNGEVSYVPalOgPaUHqr/O1gtlLhlQzsVu7f4ZatkgswurxUOaDRfzVcnBZl8
	 nknJuJPn2C/BBO0Uv7lcdqZW6Z8l4lWzzUoQDxvPZth4I8gishC3RLMcZtkQ7gBRro
	 yJEN2mjONb0nftQTLJHSgaziBBcpewLH+4sQPLS/PtaOs33Ldrj1/gET4tvw377R7w
	 U7be4STD6+nxg==
Date: Tue, 16 Jun 2026 08:14:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-af: npc: Log successful MCAM
 drop-on-non-hit install at debug level
Message-ID: <20260616071421.GQ712698@horms.kernel.org>
References: <20260615033157.535237-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615033157.535237-1-rkannoth@marvell.com>

On Mon, Jun 15, 2026 at 09:01:57AM +0530, Ratheesh Kannoth wrote:
> npc_install_mcam_drop_rule() used dev_err() after a successful
> rvu_mbox_handler_npc_mcam_write_entry() call, so normal installs appeared
> as errors in dmesg.  Use dev_dbg() for the success path and keep dev_err()
> for real failures.
> 
> Fixes: 3571fe07a090 ("octeontx2-af: Drop rules for NPC MCAM")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>
