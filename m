Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63D3A9018
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220924; cv=none; b=JfGeSTu97f0OEJhNK9X5DuCPuzoimOJ58Ihl/zN/10bq9AUX8U/KzdNWu6hhAiGIK1zIla/8vP9cmkOC4UZthoF+oowtrER2gnG8fidzEElXxbQlCVfvYpQBHLF2GR/IMnpLESJ3dXhsFVEGaFtV9H3J3/h+XTLope4LgyyDcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220924; c=relaxed/simple;
	bh=hRHbs1nZiBxTW53Dr0PK/q49gOnA+srDX4sDHcKT/U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/CJKtIm3VUH053v2xo6qMpWSulZgbIsCM4w7Cu0vmIFhBteOIpevj2JcvHwNsxntUfANJxcguT9uU3pYW/HzmfrAHfT3qOoJX80imVlNPegXySX284RxTs3sytzBWloRiklO+NlSM+mTCuUjFVIInjdcFY/o039CVrfnR8l/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KupXL9c1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KupXL9c1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF89AC4CEF7;
	Fri,  3 Apr 2026 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775220923;
	bh=hRHbs1nZiBxTW53Dr0PK/q49gOnA+srDX4sDHcKT/U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KupXL9c1SOTFLELhbeEvZqVLN9rUlFO3MhzaB6z2L09ny7U2mHCyQHaKmI3iSeIup
	 pEJ84bkq93g8ZA0fS249HT5PeBcFO3yixizyo7mcR4uN0ek/QI8BROkzGaqeoC+qoK
	 012NavwbizjkM/9cZrZm1ekueAfoHaCKyJgdkfErXW6Cd1UOBTP0j6Zr5s34ViQxa1
	 5y2nC+Hkk0cO3qQnB/QrS5Hr6XvODNu8ZaST2GTW/M7vJKT5lMBRERc5ZIP5nwbMZ4
	 eDzIZ5lXROUgDzWiXcByC+MeXTdM9SH++Gr6OtIfxDGmo6O/sVD6DU06M82jkwRTmK
	 /rCSRYn8TTe/w==
Date: Fri, 3 Apr 2026 13:55:20 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH net] ice: use READ_ONCE() to access cached PHC time
Message-ID: <20260403125520.GA105440@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-9-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-9-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:23:32AM +0100, Aleksandr Loktionov wrote:
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> ptp.cached_phc_time is a 64-bit value updated by a periodic work item
> on one CPU and read locklessly on another.  On 32-bit or non-atomic
> architectures this can result in a torn read.  Use READ_ONCE() to
> enforce a single atomic load.
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

