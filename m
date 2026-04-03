Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FD279358
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247370; cv=none; b=fgLNZBmxPThaaVywwX0hmegG/mk6zL+v6EKejgDUQNXMorlgmI6ypR5yK1JaZZuSWE7OGRpEKEeWm4kC8A1X7dV4L3VE2SnnpKe1v5XwFrtuaU6lR7RQVwwEVjh6oV9wfpMHOOAvwbnExkPwVBfwAOt6RO9OtV1mu8TFyOrNY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247370; c=relaxed/simple;
	bh=kRsdmDX7gWtEfL1NZRFie0sO06YIDWSyDlF7Xu3tDWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDF0cSOzqnABeHP4E2UDMonJBJWcG3R0nqKKjJjYiNMut/xH20G+2vSnycL236Xhm+CjIRTI+VayN8AWq/hpqzzm0dDPz/a2gZqJdcNt286kWJ42xwh87jvqmffRYBuDPsZXNrx/uKKYEkqPQcObIw7shJaiUCJd0Ggzt4qnLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvzHTlAt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvzHTlAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA9C4CEF7;
	Fri,  3 Apr 2026 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775247369;
	bh=kRsdmDX7gWtEfL1NZRFie0sO06YIDWSyDlF7Xu3tDWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RvzHTlAtPtAmNh71kFPkZpvTiNN0MJD5T9aQD9BS65FHMPtKOXzYpanOM/QjD0zaz
	 AT9dc2tl2Oe2/iwh/uxivINHUKBGC/DwHxWeUOtF8lJqZs/VO95Teo9s/9IE7mCLeO
	 0EWLc2aoXZ8jymJcDbU9vTezHRn53kwR+MItlWF+J/ngvY6P8WowCKOUHokkUfvIXG
	 1YKAkP3XX2i+LFYG7oN7kwNIMXXplow01lln9hsuA1nsCJ1V/TzKANtP8xzDmrMJSY
	 7I0mQOjLGzKGJnqT4ihfRh24PnO8e7Or5IBRFBQbFnCC0Tzeoww4lhxBlOy1ZCuhUW
	 qNa5Lbh3LzpIw==
Date: Fri, 3 Apr 2026 13:16:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juanlu Herrero <juanlu@fastmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] selftests: net: fix checkpatch warnings in iou-zcrx.c
Message-ID: <20260403131608.4b8fecb1@kernel.org>
In-Reply-To: <20260403195754.10619-1-juanlu@fastmail.com>
References: <20260403195754.10619-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Apr 2026 14:57:53 -0500 Juanlu Herrero wrote:
> Subject: [PATCH] selftests: net: fix checkpatch warnings in iou-zcrx.c

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject
