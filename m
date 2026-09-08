Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AED5908BF;
	Tue,  8 Sep 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892333; cv=none; b=awxmRyEFV75oXkT05wN8+Cv5N+42LkXBlWirEjMHK1S1rvd5zjn9SH9LVCgfAlNF++Qk0XyQWSAIHaZUaXUDMaQwn13oox5pbEmOyG9EbmQGb+fpqLpbDrDvGv9ZlCSV7YOumRyAhRnyBv4IpZyY/9c2rMK/B70TuZ0zE4Kv/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892333; c=relaxed/simple;
	bh=liWYTw1gFaWCOc3lsNTkoVeARu8vtlTsM0Gf7Ryge7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1lXELJQyW1mPzkuieZkHfKttjkrI+3y26gknNLxwby0G3e/79z7RWPGnBjvSSSHI81eoTBLNR1flv/oV7p7P6SbImyr+/fX978oQNLm74OmoBgWds0f1ETwf/dHk5iQlrlv0BnV2rZvjpak8dG9leJO3hBA/a9MnTAcDV7gzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crBidmcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crBidmcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8635D1F00A3A;
	Tue,  8 Sep 2026 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892331;
	bh=l0CggrwevG1xFJXWU9JWMqvoGtAQryeGoT9XLBo0uuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=crBidmcrpEcnBr67Ljy1VrLxiB9GDPbc+oVD+aJxu0WBgWe0tftkVIQr09iuviLxT
	 5AjjKhYWInCjEnlJ6m/iPoeRccV6tD6azBT6MZh3/QGYhU6d/BdYzKxJAOlf89dgP4
	 xGXh3tY9T1LYnMX5SvS1O0ttI6WhL8y/Ihq7HqM7p90/QwRt8CFNxWJh++liFe8IxR
	 YVOs16jX3OWQ3emsqekKdjrqSmqFyLMSH2UM219oUtf1ww6Oto+lFY0AMD5ER1rQcd
	 2JSzAr49CaPe6HlgxWELVMqIkMwF/FmrpCF+GHd965t5kFXyvnuSNj3Lqfq2fmMJqd
	 FI06m+DSNAYVA==
Date: Tue, 8 Sep 2026 19:32:07 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henry Tieman <henry.w.tieman@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Message-ID: <20260908183207.GE40544@horms.kernel.org>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
 <20260907115221.926007-2-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907115221.926007-2-aaron.ma@canonical.com>

On Mon, Sep 07, 2026 at 07:52:21PM +0800, Aaron Ma wrote:
> Flow Director profiles retain handles to generic flow entries. Reset calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
> handles unchanged until replay replaces them.
> 
> If rebuild fails before replay completes, later driver removal follows a
> stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
> 
> The failure is reported as:
> 
>   KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>   RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>   ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
> 
> Clear the Flow Director handles while holding hw->fdir_fltr_lock before
> the hardware tables free their entries. A successful replay installs new
> handles, while a failed rebuild leaves them invalid for later cleanup.
> 
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
>   synchronize with concurrent ethtool filter add/del.

Reviewed-by: Simon Horman <horms@kernel.org>

