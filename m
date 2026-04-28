Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763A3DE45D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371101; cv=none; b=PnBy+fTX9l9lrVpEfo4FH7VXIhZfNrciLeXkrJYOxKdhJfYnfMp/rKXWBFQwZjI1zQ3jHNl+gYFO7K95g0vFZLrtxkdgz83iv8uc47sQwcLUdYrRuG1X/LyMWWl6duWcRQN0Gc4JzRu56Hp41J+1bTEFdP4NaU0YEsO7mlZySbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371101; c=relaxed/simple;
	bh=QENjEpNoS7q5Ws0xYsiz+zv7m8XIjdGxrcgC8Z5U73I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx+mHzAHhnjSI7C5fpMoRkOWe7O/qtKGvN4NBMIs66htMdDQIK8PqPBAcRjfpaq2UhhazFS5dnOh3Jej3gI5JN646DQeo3XN8+fW49kIgqTlGKmHtZu7UcEh6+cDNFFJ2fZ12C9QPdRDanESv5GjuJ9LKv+5AaJ+U+GWgVP45/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaPkkW9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaPkkW9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D55C2BCAF;
	Tue, 28 Apr 2026 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777371099;
	bh=QENjEpNoS7q5Ws0xYsiz+zv7m8XIjdGxrcgC8Z5U73I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaPkkW9gYWt1N+rNjzv/iW+7EZRsU7TrxnfGhWD9uA8+JkrQGCKk5YyfgwnKYx3zl
	 1MxbnhpIuRX+vPm7iDnxnzYi3r/Ce69x6sUrdrFwexpw+IZqoWquW7VgplS7OvCAx4
	 dWtnl2aIQ/e9LsFMdzz9Fgr4cKxs6di5mbw+A/s9GVoKsbq6UvZqgwNY9fRmovRiDy
	 PPvxmxlPjtBO+Z/JPC5f9eaEhx9GxBCKiErhYrK/yF52Pb/6/7xYzSbzE1TNlNIEUC
	 rCWYXX04ot3dYw+4rbWTXTgtgu5EkBXVK9Zso+XTTaENp5NGoGRduReyT7V+xCWYc7
	 WSha+Y3vVnPiQ==
Date: Tue, 28 Apr 2026 11:11:36 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-net] ice: only free LL TS IRQ when the handler is
 present
Message-ID: <20260428101136.GP900403@horms.kernel.org>
References: <20260424061958.918404-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424061958.918404-1-aleksandr.loktionov@intel.com>

On Fri, Apr 24, 2026 at 08:19:58AM +0200, Aleksandr Loktionov wrote:
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> Free LL TS IRQ handler only when the handler was previously installed.
> Unguarded calls to ice_free_irq_msix_ll_ts() may result in a double
> free when the LL TS interrupt is not supported by the firmware because
> ll_ts_irq.index is zero-initialised and would pass the index >= 0 check.
> 
> Track whether the LL TS IRQ was successfully requested by initialising
> ll_ts_irq.index to -ENOENT in ice_init_pf() and when taking the
> "not supported" skip path or on request failure, then guard the free
> paths with ll_ts_irq.index >= 0.
> 
> Fixes: 82e71b226e0e ("ice: Enable SW interrupt from FW for LL TS")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR: There is an AI generated review of this patch available on sashiko.dev.
I believe the issues flagged there pre-date this patch and do not impact
this patch. So while I do not think they should block progress of this
patch I suggest looking over them to see if any follow-up is warranted.
