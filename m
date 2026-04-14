Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6943B8D4A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159201; cv=none; b=twRTfOxgSa5TipspnMsEucm5yl3cbjIf8Vj36uURVbvK8ya7yOBjXy+RT9/6ho9hQHx07gIKpCfg75ZxU6H2gkqIFAzo2Qt+2NAVZSxy3emLmieivplzl3eUmghtDSjCuqoSIsNS/U2eh5QMLvlkykAkB2zfQ/rrxriHF4mimCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159201; c=relaxed/simple;
	bh=LsW298vC1uXD4bNamm2iAeOtiJmLtwQwZUl1bRwVznM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw/6nbxltUd4Hw11kaNgns5/GK5EyvyzI6vsaHCW1I2gIJvv96hmyNx0C1SJz2pkeaKjYGR3OEXaInyUW85e8utFQqrYUTO/s/UZUkYgiT99yPu45u2XvKV8LjaGz0+KJ0+WWcD7qOs7TudMkrJP2n5QwyjV6sHit6iB/nLWJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+Tbw0Cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+Tbw0Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC5C19425;
	Tue, 14 Apr 2026 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159201;
	bh=LsW298vC1uXD4bNamm2iAeOtiJmLtwQwZUl1bRwVznM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+Tbw0CcClfF8F75vv96rwLR7UM3a7fRL/T3bZ1hNRJnlyCrlJOU2NTgGmLhNngss
	 4s+n7kvhJef/vDVcve6TDvBD3nqoMPQk075oWrebT/iPaLDoQwTBeZOpPt0e353zHg
	 B09LaAtf44/1/Ffb4GBkMdjjo+eswm/xEAXJwcBJ4JpEQA1Mwz4nVE7KIm5PdHeYBD
	 51CuH5Es5wmNcSlft0/RU9CoilQ3PdOkAUc1D2csJu+Mcxms6Vjk5Gee8J3ZQdA4Qc
	 EYiwEQh5UFVDbEGKSm1Bp/bOPeeTgkSePmZ910I6Z2fKcXAGkiAHgbrNIDPcah5ARa
	 dS9Z8eAqc5Iow==
Date: Tue, 14 Apr 2026 10:33:17 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 6/10] ice: increase OICR interrupt moderation
 rate to 20K interrupts/sec
Message-ID: <20260414093317.GY469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-7-aleksandr.loktionov@intel.com>

On Fri, Apr 10, 2026 at 09:49:17AM +0200, Aleksandr Loktionov wrote:
> The miscellaneous interrupt cause (OICR) is throttled to 8K
> interrupts per second (124 us minimum spacing). This interrupt
> handles VF mailbox messages and Tx timestamps, so the low rate
> imposes a minimum latency floor on both use-cases.
> 
> Raise the rate to 20K interrupts per second (50 us minimum
> spacing) to allow lower latency handling for Tx timestamp
> bursts and high VF message rates.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

