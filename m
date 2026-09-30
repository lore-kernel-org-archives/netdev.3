Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238127F4F5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780826; cv=none; b=WB7BU000G1g58XcAuW90NXOQ6rC4lbAiIhd8IPev1VmsgiIPuxUGF+djCXBy3tA8+nwq2AcyJi7sz3arc20iPsjcHtecL8NhpCHAcRBz0g4mt0yM5OUKWM4GaagqGASxkMm4PiGBQLFKe9NrzOkJEKMY18BELIrf94OWbfmPhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780826; c=relaxed/simple;
	bh=tOYfJ7mtvd9YngIC3BTmSIfaaGsFsKLEkUz2G4IsgjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJGASivim6ET6k92VsJ1Y8G3y3h4+99Wp18I8bGEawq9dkvkAycgDwNHQbfXFufKk/6XCg0m1Bt7Vb+kjNt1ylU3P+unA5zDCAf5JLpYNWIues5zvcgOnWG8nuVAHnacMcxJPMGO4zv5WlX8+u3M0liQC14Ybt1SnyZAHCV+md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcknPrUD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcknPrUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790780819; x=1822316819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tOYfJ7mtvd9YngIC3BTmSIfaaGsFsKLEkUz2G4IsgjA=;
  b=gcknPrUDHMLfJYddxfS6VEJu9CXPUyhgitWCMsRB8SHnNUsIq5Lru93J
   8yG6ezdqo7C7IUT9CTuJ6liqm1b+CQvbb5pvKZMSWE6RmohmO5+MCdwLo
   lk5iTtYZy8ZjNj0qSuAhhzrZAnJ9YIo1827TKbCG1RL7iKF/bRgEjNS0R
   gyg0KpwHFgM1kh1qq7X8alAugvSml1fmJ4Db1dtP9BJ1bSkQNWDs/Ivv/
   0ThZVYWiqwfyowereOZVYM/D3sWBBJ5ONG6H4PxnQHSYw0zKusizm3wpQ
   CI3kSQRHwRpbefVej9yj7TVnvEh8yBKf2zZHGBaLksqyhF+s+vkZG40zV
   g==;
X-CSE-ConnectionGUID: qyW8HsBNR5ukKZmRMB8Ybg==
X-CSE-MsgGUID: Co6S336EQo+62jyrm6CE2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90651028"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90651028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 08:06:51 -0700
X-CSE-ConnectionGUID: 1a98pPD9T/GjyayjhN95Uw==
X-CSE-MsgGUID: 5HrXzimbQVK1UZ2M82HTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="279042724"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 08:06:51 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id 475AE20B5708;
	Wed, 30 Sep 2026 08:06:48 -0700 (PDT)
Message-ID: <f8b8d444-da7b-4a9f-8706-ed7ff5286995@linux.intel.com>
Date: Wed, 30 Sep 2026 17:06:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
To: netdev-bot+sinfo@kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 david.butler@appgate.com, horms@kernel.org
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <179063700944.31693.1912265472568249345@kernel.org>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <179063700944.31693.1912265472568249345@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.09.2026 01:10, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


This information will be included in patch 5/6 iavf: fix VF stats not updating due to PTP command preemption:

How discovered: found while investigating a bug report where VF statistics in sysfs stayed at zero despite working traffic.

Triggered: yes, actually reproduced — ping/iperf succeeded while rx_packets/tx_packets stayed at 0 in both sysfs and ethtool -S.

Hardware tested: Intel E810-C (ice PF) with an iavf VF passed through to a KVM guest. The fix was validated on the same setup by swapping an unpatched vs. patched iavf.ko in the same guest kernel.

Thanks,
Tomasz
