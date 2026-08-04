Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012A463B6D;
	Tue,  4 Aug 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859512; cv=none; b=PzvDOCA2ytCcdMgB0ajoSLpkbS3R1BHw7lxH7UeVlyXEjzBtBPgQN+Ndg8qExzKjJ5TL0wPf1ZiMZNixvpn1sf2AXKmCNKPpd1NIc5QacdY6Op9Vb8Bx9MzNAGme9DeM/B4e8PIN3+733JrwZoeV02cU8W5h3n79HhJWaZcWdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859512; c=relaxed/simple;
	bh=ayczpbs10IRaGQSyxSkR7xRoVkbToh4EoscVg0eS5dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSAjCWga2CN7pi6kZ46K3feowtHi6Dh7Nse98yvnfM142NOecSq//av4oo5VdG69kDSTCxX7UsU0r9VX3iIA5qrtd3pBVtQwYpH8ES7CRb5iIwipsq6S1BaJA5LJldvruOFMnBjx0G9cNzdMhIYOazwhonGR+8EGo4YMsSOvE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJHCF3OX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJHCF3OX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785859509; x=1817395509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ayczpbs10IRaGQSyxSkR7xRoVkbToh4EoscVg0eS5dk=;
  b=VJHCF3OXYK9b2OMR4kIXFnJN+MxWEVysxdNi0oi3Ljj0hoVQjmkJd75j
   bWMYY6aqJ3cqqYCHiaQHTJjuSM0yDVvvHYzSpAk45rOeaq6Tp+vav4SR4
   4bp7XJcqPagVjXyjm2qtp83NgTLQE6/5RpGbGI9IZwtAYUQAF1ChtMl9k
   1G0z5Dp3jtCAor7VwnmU/Tu+Rl71rJTveFFRe9QxzHLbkLorIhBWXuq7Q
   TH7L3orT3r5RD3ULTDwBy6E1xGJfKqlXzjbvPuQYMWFw2QVnxfq/K4WWE
   9lIvkgxBtTS/wCNHn7f2JndGKvvtJ929unkee+fQ9GgSarkWfRPW/YRIa
   A==;
X-CSE-ConnectionGUID: LClTc+bMSmS3tLoB5uRLlw==
X-CSE-MsgGUID: 7f1Mnq68T72RREGadQ9WtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="103955489"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="103955489"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:05:03 -0700
X-CSE-ConnectionGUID: 6OWvW/zEQlamFuZ/OHC/ow==
X-CSE-MsgGUID: qmjsC0YGS3aGztoeLNJPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="255252961"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.248.216]) ([10.94.248.216])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:04:59 -0700
Message-ID: <0e4bdc1a-48ce-4860-a0f0-201bebf6d716@linux.intel.com>
Date: Tue, 4 Aug 2026 18:04:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around
 each flash read
To: Robert Malz <robert.malz@canonical.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260804083537.3997889-1-robert.malz@canonical.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260804083537.3997889-1-robert.malz@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04.08.2026 10:35, Robert Malz via Intel-wired-lan wrote:
> FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
> requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
> multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
> single lock taken by the caller. Reading a large region can exceed 3000ms,
> so FW reclaims the lock mid-read and the remaining commands might fail.
> 
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
> individual ice_aq_read_nvm() command, ensuring the lock is never held
> across more than one FW read.
> 
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that need
> it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
> instead of sq_last_status, others pass NULL.
> 
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped. ice_read_sr_word() is now a thin wrapper, so ice_read_sr_word_aq()
> is folded into it.
> 
> Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

---8<---
