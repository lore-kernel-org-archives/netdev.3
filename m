Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893413AF2
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219516; cv=none; b=P4nbiUxG41PsCbFRwhWUU3/yvRKE0R/wyx7fFP4piWuQJFsFXO4WbSK9+YZIAzMkuVdwZ44m7+Whbz4yieFTISTMJ3N1C1HU84lE5Rw/7X1KaRQCJvwunnHyaQGNRiiqKzxRA1YRvZLwk8k/OvuhPlHUuXQ2yZj4KIN8KGv68pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219516; c=relaxed/simple;
	bh=C14Dn6CJWe28rasT0KhU5z40Y19aGc+j9gzla04hLYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTgE38mFgiW2BH5+WpCSiZURcZso5RuA60WJk0RaBPZo1J9KvR0/bC6PN0T7KRjzh94sBHWm5VRkYRC9xoS8MGlvvfgoMV8qgtqBSnNGPL84R1yuBmnAPQ2kDBL1CVfnsuwD1rMCkH4Y1bkA85mrWcU9mY+pW/1pn5SCfMDdZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2K6KcHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2K6KcHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0018C4CEF7;
	Fri,  3 Apr 2026 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219515;
	bh=C14Dn6CJWe28rasT0KhU5z40Y19aGc+j9gzla04hLYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2K6KcHABx4bA638WrXtQBf/nDjyqvYOB/ggWc3LF1r3dQJdfXnZgI/dTwL1yOHOU
	 i+DBbxj7o8chwjW0hK1EZICNOYQxYUN/q5tvARBSRfK1N32D47zi3DBV/zHuVrvrN0
	 +hblTTKe0QS9kaOF10sPL1VRQN/YjjYz6PLKxD/iJGsI+x4uwxkYB8iTdNiHyxId98
	 p+LCPag0dt/BxeKSkmdvoPuviHdWLIh6BX7hRagaA4QDsUGsVMqgBCefKc0NX0Nj4r
	 n3xScGWD4tsAgQWx3o5WPe9RAAmloz6+o1X++Tr6Y/3WwSmssoNTMJWL4Z/BJu2B5h
	 GCHHfrbUeGUcw==
Date: Fri, 3 Apr 2026 13:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH net] ice: fix PTP hang for E825C devices
Message-ID: <20260403123152.GA89018@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-4-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:23:27AM +0100, Aleksandr Loktionov wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Change the order of PTP reconfiguration when port goes down or up
> (ice_down and ice_up calls) to be more graceful and consistent from
> timestamp interrupts processing perspective.
> 
> For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
> is called which starts/stops PTP timer. This patch changes the order:
> - while link goes down: disable net device Tx first (netif_carrier_off,
>   netif_tx_disable), then call ice_ptp_link_change
> - while link goes up: ice_ptp_link_change called first, then re-enable
>   net device Tx (netif_tx_start_all_queues)
> 
> Otherwise, there is a narrow window in which PTP timestamp request has
> been triggered and timestamp processing occurs when PTP timer is not
> enabled yet (up case) or already disabled (down case). This may lead to
> undefined behavior and receiving invalid timestamps. This case was
> observed on E825C devices only.
> 
> Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
> Cc: stable@vger.kernel.org
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

