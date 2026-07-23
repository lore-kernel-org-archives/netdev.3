Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B6472795
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822102; cv=none; b=pS39TiHfKUhINvfcQN/fkHDUC0+TV+DJsxQQbe8w6eGoej/5deX/6zLGxSJWiYxwMzypdaLmZG173wbNOWOufBpZq6QcAaidv5Li7M16m+7qv/f7XDeo6zRidQ00gVJk8kAa+ZNoaQ1VOvHBY7vrPOtkySUVeHN2KwTq8R0GCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822102; c=relaxed/simple;
	bh=njIS0q1s7EVbxoUYGknpvkHU0wRBsTpKJoeDMSd9PgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgHfxF4TEoz0Cs8bBQp3MMJos128IevgqC3OLTZnIB0exkRbL+n5R2g6IZl7vh95MI3Rb/a1Zp8GRMm+xeQL5EMhaCtKdMQWw3oGCAj4PsxVspm8zNWhEfYiGz+kHfjrE1lgy8fn6Rb+FpfyJcdxHf/9qI83kzyep8dBTlDeViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdJJYtv+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdJJYtv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508451F000E9;
	Thu, 23 Jul 2026 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784822101;
	bh=wA7ERSZvQ8CTrbChmzTqS6GApbkH+FwX+werSviNmFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WdJJYtv+7VszuU4WXaJzzxa9YDQxzxorcjWwxyhuNpuT95njy+30WnIe/TR0upiLs
	 Raz/xr0FqyJsp4fmtJU1p5d4JCyEf5GYILuk4oqOiayUzsY+rm99mIOoMpFuqY/eZk
	 fYxCwN5zTmpYVde6bkatzsZBSsrTOkUGl6Bt1NXKff281i75ro2BBLc0s7F5UVK2eR
	 iolNjD9ykfp9g/mQUj/cNATNZggdh6QJHnOPvWQBHsHBvyg5upswet0Qaxs4zbUXbj
	 TDN5xjV3JL2eGcnt7bObhfJVrLHl57TEYrTFqEu6Dc45ztIx5YN1QanumglsKXpX0m
	 W96JASET0mdLQ==
Date: Thu, 23 Jul 2026 08:55:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, horms@kernel.org,
 jramaseu@redhat.com, willemb@google.com, benoit.monin@gmx.fr, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Alexander Nowlin
 <alexander.nowlin@intel.com>
Subject: Re: [PATCH net 05/13] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
Message-ID: <20260723085500.71171f3e@kernel.org>
In-Reply-To: <20260717185340.3595286-6-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
	<20260717185340.3595286-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 11:53:27 -0700 Tony Nguyen wrote:
> The hardware is capable of calculating checksum for IPV6 packets with
> extension header. To not drop such packets switch from IP/IPV6 checksum
> to HW_CSUM.
> 
> HW_CSUM is also used in previous generation (i40e).
> 
> Previously HW_CSUM was used to indicate that hardware supports general
> checksum. Drop it assuming that if the hardware supports it, it is used.
> 
> Disabling offload for E830 in case of TSO isn't needed anymore as the
> check for TSO is done in Tx path just before preparation of the special
> GCS descriptor.
> 
> The commit from Fixes didn't introduce a bug, it just shown that the
> driver is doing sth wrong with the checksum features.

This really reads like net-next material :/
