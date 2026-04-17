Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C43B19CA
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435150; cv=none; b=TZeKs4tEojdTxc0q8qTyYSM1Ac2F+8hiQ0B++0SEsQlAe6L5duyM6QATHCI6B5sHmiiwG6IbHolBM99UzpistDSai9x7Jq214F+Fmgt2gJvPoEpeWEKQnZO0+d2WNjYkY4spjdlPzycSqiCkhtVhTxnO6eCVcCNZ1UQPO+xj11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435150; c=relaxed/simple;
	bh=LPMz+wvVSpzcjh14fUZJ2kJ+IffLKQsd9VxWmRRI0n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdZpcz1CVKjJUMfcZJOT3D5D9J100vhLDaLIuTvE6NVAY25U/vTtXTqycLzXYOxVkJkC4ibflEh/oWGdtjOBKQ9Ey4SdeFbyUPzm+wtCQzI179DCAeh5lmxgV8Tv2WLFqN1IAYMV61nUGv9Zru2DvXW+u+JeDA0yXvNXz/eIbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClTow22D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClTow22D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABB3C19425;
	Fri, 17 Apr 2026 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776435150;
	bh=LPMz+wvVSpzcjh14fUZJ2kJ+IffLKQsd9VxWmRRI0n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClTow22DVaBwTimMV8DHetTUvp7mCeucU4ZJ+VkxVMIi/zc2PY40S+L0YmAlftSXm
	 ZGLWBqUpypDz/SYjedkVL43tIR9XvPdV8ekidacuL3XNtLJFmm8/22zPPCa14ir3bA
	 Tvnf7wK/+XHQbPQzO1BKyFJlKskv8Js8QVCcqfVeffso5INtzLqvJMzBVcEYzUGa5o
	 ii+z/yNloQF1ippW3VwmQot17MXnLjd/sQuzUVkNM1QzO9ySiXKmHCuser4ERoTwkR
	 UQa/PXddFaArajmTQX3i1VHmzCtfhyJwo5aTEvYwaLASZnTJmxFMTMfILVyMOCE8eb
	 sdZ/exf+9m6GA==
Date: Fri, 17 Apr 2026 15:12:26 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] i40e: set supported_extts_flags for rising edge
Message-ID: <20260417141226.GF31784@horms.kernel.org>
References: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415102511.1560665-1-przemyslaw.korba@intel.com>

On Wed, Apr 15, 2026 at 12:25:05PM +0200, Przemyslaw Korba wrote:
> The i40e driver always supported only rising edge detection, so
> advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
> PTP core properly validates user requests.
> 
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

