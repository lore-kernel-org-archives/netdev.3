Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9B23E334;
	Tue,  8 Sep 2026 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847264; cv=none; b=SBMj/ULC3+9IbNBJI27XXAOqNIEIHv4ufJg5LsSqM6TIqh3GAFAyQeqgU652QTRmu/pqr0rG9SZd1iuGh5dRv4/klJdDpBbRLbE1AQ5UwRQg51Z+y9FH99VCrfP27kUePCUko4f8LnfFAocXygajowdHuviSa2b0gXwnRg/o/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847264; c=relaxed/simple;
	bh=dP7PTSIqr+PUylng0LNaTf+XvZfMQ1DUZ+WGex+fVBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn4JQdG4JFNOvWQDVPp/QZOBRiwgWwt4SGVYOEKtCycU5TFF6UC5CLEaLVL3FXFXENkt2Kytq7XkhjpZKQh3MCX+MmyTxPpUzL9Kfm9vOhhlYtL2mV3hgSVy4CelBU8nUNjCmtI6M3dXouWt6pDpicD1XHD7WHTvjClSUey2Gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KL2M8MXH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KL2M8MXH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UdN27yuarFJ0bS6RZN4qrHEQI6SbOy4cMG40wpZ62V0=; b=KL2M8MXHvjrx5fgGwmm7ZEEQKh
	nqS5WzlK0dCIcTetr0hiJo/XTEFKRck8OwZpNkqGc4MDp3xjeZfbwim0XvpYxbxWn/23UHdw8UYE6
	tqoJyNURI49wNqflHfO6ofAKwTycKaahYsF2BH1KUjMzx+g5r5Q3iJGHdXGzb+buXUAP8Fi37YkLX
	bTfUgfASYTCK20HI6bfb7MCINfcBkSOwuuM2sTHtDp1IaEFAgITpaWz5e1i3MPArJ3G1CdkSoWSuu
	ANxMIo/PMhGfjv25wLeu2Er0blhZ1jbx21gkOn2NmyMpF1ptXQaPlQTXaLNbm8C4Tfmnj5s7RfVxO
	0HQLivIA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3ot7-000000087Ke-1m4N;
	Tue, 08 Sep 2026 06:00:57 +0000
Message-ID: <a33355f3-3295-4aab-8e37-b176d477ddc4@infradead.org>
Date: Mon, 7 Sep 2026 23:00:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/26 2:54 AM, Hemanth Selam wrote:
> Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
> 
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.
> 
> v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/
> 
> 
> Hemanth Selam (4):
>   i40e: fix typos in comments
>   ice: fix typos in comments
>   ixgbevf: fix typo "enble" in comment
>   Documentation/eth/intel: fix repeated words in comments
> 
>  Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
>  Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

For the series:

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
