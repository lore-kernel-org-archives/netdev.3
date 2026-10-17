Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131120D4FC
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199236; cv=none; b=HcFRPts4ZRUwmux0m6lVQK9dQ5jKUHLtgd1sYhMzZ75QmyiL5B9+2aOnpF37Zz+cARoDxsE0V93VbQnGJeErFt9sbqHBA7HtMdmlWfHHpF/+YEA05h/Owi+UqmDZsHtnC9C+pWULxgp8fhAs4/TDTuxESRFEDSkK9VboxRa5r+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199236; c=relaxed/simple;
	bh=/41peTb1mqV4xA06yZpph1+AxGXafN5TzwQF1/MNMXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=id6H++Oiu8edOEqG+lPuTLN2HFt9Y7ZDpV3eKlgRrMR+LoQQMnRmT2IInoCZm6e5aX3CBhgx4ISovxYmz3ExSTSheLNAVOtp5sVZhT+qB5iemlBblOIFy7gBiAKqu4SlKaFK/JpTFOKjhn7uO/kmCex0kLAqy0bvmqYEisjFfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb7876W7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb7876W7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F681F000C4;
	Sat, 17 Oct 2026 01:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792199235;
	bh=msFf5eZuBAZYQx2jkKUmCGaO9UqE+6lGeQRVz9HPL3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vb7876W7Ye52o+RmU1/61DWaqA7e6JdDCBCWL9TbkWGFWjb4bnqj2UK656749Lqop
	 mAqABWjveiIsfLlE0QS+K+lo1hElYNl6BU+Zg5T8zXU+AsfyxNHbFuhmZD2WOkSxO4
	 UX4iyUed7Fl8ehx2vqvTVmGGVHFSy69r+2DcKl7g06yoBx848O/26RR5jJAg8IsC34
	 7hvSrP7WdKn5C1I7uAuv0CA7a0Jw5rdXZuQGWTXaS//MOsSvly5QOuWDb0busrrhsE
	 wn+yoTnAeKFyD65T3/GjkQjtdGPLYqT8rurMJbJ5PEaLXLp95EF4h65AKDfhm1bCXK
	 oNr0b/y4DjnlA==
Date: Fri, 16 Oct 2026 18:07:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <20261016180714.05fc93c5@kernel.org>
In-Reply-To: <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
	<20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 10:31:51 -0700 Zack McKevitt wrote:
> +        type: u64

prefer uint and then no pad
