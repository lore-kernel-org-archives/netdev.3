Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02925353EDF
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207004; cv=none; b=fqOgGPcqe24l0VYqimxbfle50aan44Xxhuu+TlhsUETNBpqYUSGHF1ptYCcuIwwZ5iYzx99gFDC5rdcYVtDAKsDc+6B/WOUUjmxQi1W5sf4v0ezavhiG4Mv2kPtxmAY9yBewtz2DuvICiJM2kgbic54W7wPjFa0MQ1n6o7HpqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207004; c=relaxed/simple;
	bh=uYfpJf1PlvTAcU8ebq/7cUHKuXcqf0B8lI+Qqwxgiac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMNvuLh+zmVXF7npt2KcdfklRbTF5+PbRiKvaVyurmkq0dT1oJvEvt4+lu5aU1aag1L3wKotWWcq34WfV9gBUXw6vTDD11TrISw8ifDDze598CATbUXfJisTiuWaR+ARLgVyVy86b7nI6vfL0s2Cvk+QMgSN1UZ6RytPj7uyydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEFLPM+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEFLPM+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF37C4CEF7;
	Fri,  3 Apr 2026 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775207003;
	bh=uYfpJf1PlvTAcU8ebq/7cUHKuXcqf0B8lI+Qqwxgiac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEFLPM+n8Z3KnW7gkt6ce0BmuStcIfeS7hNNF/HDFaepeanRfHftg8nIKukK5Bqmx
	 awokF0zpn0VeW7wii7OL37qFwS94wvjcuHgNWHgn54HHDYbIApF6/Vwg50Zhtktlto
	 YJEKNT11BxJ/PdxP0DnKbKMz4rpUbf4lkIZ4DGrpMZOl4n/XlZpciIOVpxTfwF/ie5
	 /Ihl/RTMeLv7EvPrAxRjSkWEcngNi+I4o13R5WJLnd56xnvHdEpR94HQnYzAjL2vS+
	 fkr7ApOR+epGTleXYa2ArCJf4rOtDTIhi8YeM1zwOPGHqHMdEqYayTO4Rb17KAzl5H
	 qJhBOJGWKMuhw==
Date: Fri, 3 Apr 2026 10:03:20 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ice: check cross-timestamp timeout bits
Message-ID: <20260403090320.GD11973@horms.kernel.org>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
 <20260327072236.129802-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072236.129802-3-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:22:34AM +0100, Aleksandr Loktionov wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Polling for cross-timestamp active bit depends on HW scheduling and
> actual timeout may happen before the driver finishes polling.
> 
> Check cross-timestamp timeout bits to ensure that the driver finishes
> the operation earlier when HW indicates timeout.
> 
> Fixes: 92456e795ac6 ("ice: Add unified ice_capture_crosststamp")
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

