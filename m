Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975640EB80
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356977; cv=none; b=PTnGSprj1MAm/1vNNn6U5x70nReXZdgHP+7YRDkHvi4kv8Y2Vyw4paA7IQGCwuJeWx59m8Mjptsg+XfR5/tcoIlwCjIUgN0YM5r6ftD7kIrwRT7PLAf3uHueX4HexHu5hzV4CqQrJDOLoS6OaNAHpQBMuNZnKhnmK1/4mnhJhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356977; c=relaxed/simple;
	bh=qGG1JmeslCizYa8Z1QcubrfgIELzL0AGiZIRqaHhNSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYssq6LrjyJKg59Av0KdXmZHdoPh4X6ZsMN9jDkImOtmGq74X1sUuM8bgnxVDqgRnviWmqvAG8RCIcBlFZyh3RgmOdi8gN/brCRCf68EBuO/PD+OhH/TOxjkNir+sAqvRt4My8s7jJn6TaGmb6UlRBCZCEfa9WcsUOX1xOMUTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjFudJyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjFudJyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF741F000FF;
	Fri, 25 Sep 2026 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356975;
	bh=my5rV3MkvpAgY/IYTBj1G61ORyPyDGhx4/fK2LNjRgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XjFudJytBQ0VX2Oiasaia35jiX/zgBzCGpDiEUz0R0HV13oeao11BGAuiDQz5qAbR
	 mCxwUwE0/C1Ii5aaKFoVqLj0NZn4wXeyq1vOFtGECImQtxOfahB7ruTYnOfV8myoK1
	 tStbm8LuXgU5jkYS+2fF2DdvSnSl/IiMVotu2rLkDt8CwSalR7+NqCPcWVKk0B8hEO
	 1jh+/51blYyu9ubE1mEKAK4JhUy95zI+lbLrsxpuuSji+m+yF7zYzEpFC2ezyRwSL0
	 tD/V3hgQ88f+h0A66shonEjWeyNpteoVd6P5oODn51WIDtQL+EyC8hsfwURHDIfb5C
	 VwCeMVC5JPQcQ==
Date: Fri, 25 Sep 2026 18:22:52 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 1/4] ixgbe: Refactor device operations to
 check whether netdev is available
Message-ID: <20260925172252.GS13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-2-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-2-sergey.temerkhanov@intel.com>

On Tue, Sep 22, 2026 at 11:35:55AM +0000, Sergey Temerkhanov wrote:
> Refactor several ixgbe driver operations to check whether the
> netdev they operate on is enabled. This will allow the system
> to get synchronized, for example, during the PCI resets.
> 
> Fixes: f7f37e7ff2b9 ("ixgbe: handle close/suspend race with netif_device_detach/present")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I think the foce changes in this patch should be called out in
the patch description. Or, if feasible, moved to a separate patch.

...
