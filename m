Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E821337BB8
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694368; cv=none; b=ZeLNFB+nMGpINmI+qgzogQqIKmKN3YuQMWMA1LPNt7VZCsZjr2awlESQIoYbS2+ROf3g7xrV5lCzWYhELwC8hIUaz8ywt+UbiG/s8SrG1Q4hzPN/2DXjxZl6mlnRtUFjz0AkMOXCjLK0ojaT3qCd1P9veXz7/SCoGqOAqnEkoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694368; c=relaxed/simple;
	bh=qrmkpFZhwC7RvSNi0aQ57NPsVlm+A2qSY32wplPY+7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6RMFIJiKj+wgkcOEi1+a9gyHkok+V7fXlkMkfbxEOCU3ZOF9PKaLRdbjlu+RZiUy6qZuNYLgflTvyd8uH9VIRz1Y5gQDWZt5uUJHJVDJISakpcLJlAI1W8ZnbsbArRM/XM8uv/grEiaeozHObnaZqJ2QuGkWY7ePnmIdnw+Mvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7DovHVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7DovHVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EDF1F000FF;
	Fri, 18 Sep 2026 01:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789694367;
	bh=rz/noIqjqfduJhrMMnLt7Bb/UQMI/HhnGLz0kfwYy5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i7DovHVl2NeiTYwFt5h+x2rfpd/swupXf+TOYfJ9UeA13uTpMFZ1CNibKy5CXPTP7
	 CF1r7Q7e6iTaEs27GkSbAic9M7jySwX6EFs38EQE0Z1kAF/qsFZoa1Hn8T0tBw5xgn
	 14zcGd+LOH61UgvUjZlWS/F/PdhCEW+PFd9JXIuzLIzfxrv9aD9EuJY7ic+THnRwSM
	 C9Alx9EfEAj+1YB6QmkztapllL7hQHlpZRDiDwx+mSwIoBLp9NHwAsE415OdgLGREc
	 TtiDqZmzWRVBfn066dCZncziq1ocABdhBvO+VQVmrNTXvWxTE9tYTVHz+c3/nNme+Z
	 vRDOXOLjohJHw==
Date: Thu, 17 Sep 2026 18:19:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, tariqt@nvidia.com, moshe@nvidia.com,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next v2 1/9] devlink: fix the enum behind
 DEVLINK_ATTR_RELOAD_LIMITS
Message-ID: <20260917181926.5bb21a6b@kernel.org>
In-Reply-To: <178958611873.22033.17037509618791035232@kernel.org>
References: <20260915161341.1053476-2-kuba@kernel.org>
	<178958611873.22033.17037509618791035232@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 19:15:18 +0000 netdev-bot+sashiko@kernel.org wrote:
> That reasoning covers the value bits, since only value bits reach
> devlink_reload_limit_is_supported().  But validate_nla_bitfield32() in
> lib/nlattr.c checks the selector against the mask on its own:
> 
> 	/*disallow invalid bit selector */
> 	if (bf->selector & ~valid_flags_mask)
> 		return -EINVAL;
> 
> and devlink_nl_reload_doit() in net/devlink/dev.c only ever looks at
> 
> 	limits_selected = limits.value & limits.selector;
> 
> so selector-only bits never reach any driver check.  Doesn't that make the
> mask change user-visible in both directions?
> 
> Going from 6 to 3 accepts selector bit 0 again.  The natural selector for
> userspace is the exported DEVLINK_RELOAD_LIMITS_VALID_MASK in
> include/uapi/linux/devlink.h:
> 
> #define DEVLINK_RELOAD_LIMITS_VALID_MASK (_BITUL(__DEVLINK_RELOAD_LIMIT_MAX) - 1)
> 
> which is 3.  With mask 6 that request fails early, since 3 & ~6 == 1, so
> DEVLINK_CMD_RELOAD with selector DEVLINK_RELOAD_LIMITS_VALID_MASK and
> value BIT(DEVLINK_RELOAD_LIMIT_NO_RESET) returns -EINVAL on current
> kernels and starts working again with this patch.  Should this therefore
> carry a Fixes tag for f2f9dd164db079 ("netlink: specs: devlink: add the
> remaining command to generate complete split_ops"), which is where mask 6
> came from (its parent used DEVLINK_RELOAD_LIMITS_VALID_MASK in
> net/devlink/netlink.c)?  Without a Fixes tag, and described as cosmetic,
> stable backporters will likely skip it and the -EINVAL behaviour stays in
> place from v6.7 onwards.

My point was that bit 1 / mask 0x2 is the only one that has practical
use, and it so happens that both old 0x6 and new 0x3 covers it. Which
is why I think it's is cosmetic.
