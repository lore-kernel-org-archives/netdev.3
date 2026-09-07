Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFC3EEAC1;
	Mon,  7 Sep 2026 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802040; cv=none; b=hjJjiUfbwNXt/xzfWZzvP9HDjPo0dH0AWCYduEGstEXZkG75lX2LleJc0akVy+YbTtLAJJrqXDLbfVGTQxcI8hpzPlfw0UcJYpotecsaIO7WaMbpBwikR3H4hQ7VzF0nRv8ysDQKibsDjMZPtYKN7VAnVC6yha8XlFIUGI3yrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802040; c=relaxed/simple;
	bh=NVkZTLR6E1Fi8cnffwG7jdAf1LCJ2wXhJiC84d+aSB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIceSRsHcEYQWJjgrDEhQuSRmdJebxDmBr+maDuVN3sbi+nEQlPqSdnUe6imkcXl5/lp4Qu7Of1wGxFA2wGVZ/V77++MEaai4Dh0Al+ftZdYP41aqNysLmV8XDZ8YcFwvUPVH/yy3Jkr20pS8ADrgtCxCgh1eF1DVz5+CQZkl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rTDLpUlr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rTDLpUlr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qc3L0xLUv/lYkUXmkoozru40b0Kewh1PPsm8nRO1ZD4=; b=rTDLpUlrNypoqlRiGdfc6rSdrD
	7LMWqUrifhoBnTBkTzyguZFMXg4SZNtEBOdrWhgb1kARZGfyeisRwe3vCycBxDHupw2RyaWP2N8/Q
	VyU731ksk/MEbR4l0f43b7Y/taRTNzRrP1tVpEJgWfw548UFtPFEUuF+CjudzOu6sAN/o6KmMzIp+
	QFdsTZiGTySzpyKIY4yJ9XaIpbvSnRluuD0uG55oxPI3lK2bu7AVyXncklODhy/ho4qHkVHM87weO
	Hn19XFG75rCZSP2kNXfK5pfIzbmS1epLZajgUXCYmm4e0AVL+mJsegz47JMQ9AAj3iGe3riRyyQbo
	tpUe3XQQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3d7j-00000007UPc-3zwW;
	Mon, 07 Sep 2026 17:27:15 +0000
Message-ID: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
Date: Mon, 7 Sep 2026 10:27:14 -0700
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

Hi,

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

How did you choose iwl-next as the target tree?

The closest match to that in the MAINTAINERS file is this:
INTEL WIRELESS WIFI LINK (iwlwifi)
M:	Miri Korenblit <miriam.rachel.korenblit@intel.com>
L:	linux-wireless@vger.kernel.org
S:	Supported
W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
T:	git https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/
F:	drivers/net/wireless/intel/iwlwifi/

but the patches don't touch any of the Intel wifi drivers.

I expect that you want net-next there, but I could just be confuzed.

thanks.
-- 
~Randy

