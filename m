Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B82E7F11;
	Thu, 19 Mar 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943653; cv=none; b=Sbdr+huR6IkJcxO3vg0OKHeZtLS4WzpVOwSSD+aivww8mmnuiPw4BqbW9qmwZLIx988nMsb384D+U7UoKsLaSTG3zcYO93lQMT0Dp5aQMV13LHiwb7DDxXW/mCi7MnKXRXcVgATi8m6is0SUHjnrKKpD13fe3yS1AsCwW3wlVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943653; c=relaxed/simple;
	bh=9/v9OP+6OoUAkiwOeDU2rKV1U3W0BWlpsm/v5xokvz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVrVTJoDBjChWkePoT3NTno2H3ptXLUszCCQKRags+apxPTrPwWFKSQkzlkfVBgK5cHpR/sfQCNMsxkfAx7PaR+P0nOEp7nZ3HPHIrOk/lTGbq8OHlNNBl5pCVg07X8aNoNeKia2yxUR5agE1U2KJVq26Z6Jb52XbN+kHfwo8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXyPtihU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXyPtihU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD492C19424;
	Thu, 19 Mar 2026 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943653;
	bh=9/v9OP+6OoUAkiwOeDU2rKV1U3W0BWlpsm/v5xokvz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXyPtihU0kjoUTzPRkOuvJzwKE+bvWJ4WSA1BN674OWWgMSbd+2Tvj9p95JiQ3Bn5
	 yA6QKyNWADA9xziy1CjoborO+zXGyViz+mWIuYLJrWnqXgAzLIu8z+SUaWsSGsw2KA
	 lvUdrp4UrBSF7K4auaKuo4P+VxzrGs6BrIvZct0lgHqLL52g9F2ZFjAxKnW3lHLrZp
	 6HR3h1AAOtCz10CJ3UB0twbZZ5lFDZOObQJwQVE8U9LJipcrK2EbQ1GJSkA/XzDO2w
	 jbyQ1M7Nq49+BFgGqG9GWA9KkeptkaNR1LAp+GGnD37b4gGelx/53gkmD9IVD2/SD0
	 KFrNKnbb4Jc0w==
Date: Thu, 19 Mar 2026 18:07:27 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 0/4] iavf: fix VLAN filter state machine races
Message-ID: <20260319180727.GR1753385@horms.kernel.org>
References: <20260316104209.1285962-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316104209.1285962-1-poros@redhat.com>

On Mon, Mar 16, 2026 at 11:42:05AM +0100, Petr Oros wrote:
> The iavf VLAN filter state machine has several design issues that lead
> to race conditions between userspace add/del calls and the watchdog
> task's virtchnl processing.  Filters can get lost or leak HW resources,
> especially during interface down/up cycles and namespace moves.
> 
> The root problems:
> 
> 1) On interface down, all VLAN filters are sent as DEL to PF and
>    re-added on interface up.  This is unnecessary and creates multiple
>    race windows (details below).
> 
> 2) The DELETE path immediately frees the filter struct after sending
>    the DEL message, without waiting for PF confirmation.  If the PF
>    rejects the DEL, the filter remains in HW but the driver lost its
>    tracking structure.  Race conditions between a pending DEL and
>    add/reset operations cannot be resolved because the struct is gone.
> 
> 3) VIRTCHNL_OP_ADD_VLAN (V1) had no success completion handler, so
>    filters stayed in IS_NEW state permanently.

...

> This series addresses all three issues:
> 
> Patch 1 renames IS_NEW to ADDING for clarity.
> 
> Patch 2 removes the DISABLE/INACTIVE state machinery so VLAN filters
> stay ACTIVE across down/up cycles.  This is the core behavioral
> change -- VLAN filters are no longer sent as DEL to PF on interface
> down, and iavf_restore_filters() is removed since there is nothing
> to restore.
> 
> Patch 3 adds a REMOVING state to make the DELETE path symmetric with
> ADD -- filters are only freed after PF confirms the deletion.  If the
> PF rejects the DEL, the filter reverts to ACTIVE instead of being
> lost.
> 
> Patch 4 hardens the remaining race windows: adds V1 ADD success
> handler and prevents redundant DEL on filters already in REMOVING
> state.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

