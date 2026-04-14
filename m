Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866633A3E72
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156260; cv=none; b=dNNUh2WCx5x2GPY6KLgcM8JGBjZT/0mgIOQ+FODp8VRTyXVCKWF4AlNjxHB730JB+M2hI1tx/1E38uImkNWrqVL27dI4nwd43LENjHfjbYvgDtV5Qx0EIeKyFacx//Ejj+MnwTMDmH2bz9f0B/RVSp0YYYul9d6d/eK8fIsDVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156260; c=relaxed/simple;
	bh=s/RPIBdbqtGV3I+qgmGFUomO2XQA39NxOhQnddEQNNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6Z4De5rjSqW4I3AEALhAMxgiYlzYK99qGVsbwFhWiji+7GQe3dYjBfC6BM9gCq1aiZluzj6hn3Ipl2ebgry/CK21wLyoPSNTxKm6PCPNcK5XqjkQCqYg8zpssuXPJ/AvnydDk2kTq0/V3aTh5k4l7TZrCYU9K3kTz76xUqwfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma97uWBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma97uWBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D9C19425;
	Tue, 14 Apr 2026 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776156260;
	bh=s/RPIBdbqtGV3I+qgmGFUomO2XQA39NxOhQnddEQNNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ma97uWBCalFaX0n7G7DL1RiXBCVKhs+9NXOThx7gK7GXW/QQPYAApBlVF+7Dw+k/z
	 wjvZhox7JSgHEknoB/PQW2vf2a5lyyZWV6M/HNgOgtIq/8Uoavd4B47aPcWFSD/sGd
	 iCSc3RwNkfetixCuE7YMiu7yCyYCVK8fuBtZxnIfprvlAniYbYwtIgQtGrkhfWWb7g
	 roqigTciyc3SWshbHYlewOgCjgGWSfzr2K2clXXtsOg/iyXGWYoLVNO5QL7GFyLRFU
	 9FBhaGrK4taWLBhP5vBFDqY2U3u1A7CmUeDcevGnQpOaVrQyKSeY3ecs6R2sTpVYYG
	 e4pxX+j4BkC6Q==
Date: Tue, 14 Apr 2026 09:44:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH iwl-next 1/10] ice: translate FW to SW for max num TCs
 encoding
Message-ID: <20260414084416.GW469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-2-aleksandr.loktionov@intel.com>

On Fri, Apr 10, 2026 at 09:49:12AM +0200, Aleksandr Loktionov wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The FW uses a 3-bit field in a TLV to represent the maximum number of
> Traffic Classes supported per interface. Since the maximum value is 8,
> and at least one TC must be supported, the encoding uses bit values of
> 000 to represent 8 TCs.
> 
> The driver currently does not translate this value and reports 0 max TCs
> to the DCBNL interface instead of 8.
> 
> Add a translation when interfacing with the FW to use 0x0 as the value
> for 8 max TCs.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I'm not sure if you want to reconsider this as a bug fix.
But the code changes look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
