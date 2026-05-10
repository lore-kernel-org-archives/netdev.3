Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BACA4E;
	Sun, 10 May 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427141; cv=none; b=qoyEfvTges87/dAYieUkuPLZcR4zLpNaciFUWuXpNMtn29GvCA5pfeUZ7zfZQUg2nde0aB0GelR3m4bt1YmzpT21FVk6+ML1ZJSSzhd5BBepIg9Q7UMCBjPyoe5dOmqOzAXDw1hyOPK5v56pUTIL0IL7Bk5X0Xes+pGP+DXgrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427141; c=relaxed/simple;
	bh=IP9ymPdhjEvlsXziBwpZgl3VeAVkIzU9wywqT4QOBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VceUGhGDVscxs0lwzNcj+GZpPyh3Vp6NrWoH04yOosylnjeL/GMybQWSyLxYlINHYCiVrmz9yKzaWjGniL6onqW3zQHv5Aesgj6MOl7ENaeeM9+m3g8ale+PQIZN4jYSdASE8YanReB+vJuB90/s5Izxz6ivrRZd2EswJBYvHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F67ppo9p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F67ppo9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78E7C2BCB8;
	Sun, 10 May 2026 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427141;
	bh=IP9ymPdhjEvlsXziBwpZgl3VeAVkIzU9wywqT4QOBtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F67ppo9pcFhYGh5QQ+R/kDruLnCYONRpYIMakk04BzmRRzyGvDRzYpvPObfZYGyPM
	 xkwrcKlLXL1U4LyEiqzK4mbmzJtOEyJV464lde8Ahl35J0Tdaj5l+SA8nvmI8TsMT4
	 PffOXiNV7C3PuVzUen0IEDHSsFXsBfZ1PpvFzt749yUo5YbCOtAYZsY8k/17/wNUOR
	 udpf1xuOV8namHBU2mcfOY5zHN87Fnm5NsAqtuU64UzDTxlFKbBpFeiPoK1tm4O4c4
	 uc9aiqEj58jkVfzLO78PXLnTwQenuFb/exRSrr8F7i3PMwaTQMt8222R5nUK1RPEVk
	 i0deBd1uPN43g==
Date: Sun, 10 May 2026 16:32:16 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	jacob.e.keller@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] ice: restore PTP Rx timestamp config after
 ethtool  set-channels
Message-ID: <20260510153216.GU15617@horms.kernel.org>
References: <20260507081653.1717172-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507081653.1717172-1-grzegorz.nitka@intel.com>

On Thu, May 07, 2026 at 10:16:53AM +0200, Grzegorz Nitka wrote:
> When ethtool -L changes queue counts, ice_vsi_recfg_qs() closes and
> rebuilds the VSI, reallocating Rx rings. The newly allocated rings have
> ptp_rx cleared, so RX hardware timestamps are no longer attached to skb
> until hwtstamp configuration is applied again.
> 
> Restore timestamp mode after ice_vsi_open() in the queue reconfiguration
> path, matching reset/rebuild behavior and ensuring newly rebuilt Rx rings
> have PTP RX timestamping re-enabled.
> 
> Testing hints:
> - run ptp4l application in client synchronization mode:
> 	 ptp4l -i ethX -m -s
> - run PTP traffic
> - change queue number on ethX netdev interface:
> 	ethtool -L ethX combined new_queue_size
> - observe ptp4l output
> - expected result: no "received DELAY_REQ without timestamp" messages
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Cc: stable@vger.kernel.org
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR: There is an AI-generated review of this patch available on sashiko.dev.
     I do not believe any of the issues raised there should block progress
     of this patch.
