Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A7322A;
	Wed,  7 Oct 2026 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334932; cv=none; b=Hr8mT0iDwyxUrWTq1MuSXUTIQx/vi9dAkKueORwuWH5iGLM+P8rUPSjIND8iHbAT0HDwNq4ct71pDS6cj6CgAM0kooI1Y3nQW2EfOUQTJCjFfo5eXI2y1+C9k0YfT5YwmYStcuovuT9o8XO7aZtTnQlEA00EETSMLHtC14893fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334932; c=relaxed/simple;
	bh=hxg+ABCJKg5Cxlenlv/t44xBi/bN/C7juasdDgFDgVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZD+oAOKX9xIk+YonV7VJAXRcRJhiZdOupzZPGBj5JSpU5ShZ6jhY5/+wDJiwLexA+Cwye2D2BTfjR2pgxNMrpOAHR56kXxHyGVYlhX4lkv2sngB+Dy7+NStF8l8bWi1E20mXilm+gNDrFB/mBSGem+BIces3c/aSyV3X1cMF8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp4PDKnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp4PDKnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CD21F0089B;
	Wed,  7 Oct 2026 01:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791334931;
	bh=lIYw+68tQBShUC14SvVeLSwO6mPbK9HrG575Az8p2gU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kp4PDKnqo0J/23bLkqvFzfL2HTVDM+J0OhbzRkl6j4JFVXuGpPZl2qDYtJNFP0E3V
	 elaZYc4UVq8kPA7aqfl+O+zxL7FGKx39ifPnVWV5u30r/ZK4hUbNLjBEBNlnD89G5x
	 UCc0ku32G9WCAlbz4IFvufJ4PxBDtBrkpwOg4Qfpa9FkNCQy2HiYvGi6/b3zFSdOLN
	 BBe2VPTrZRtJ0iAw27nBYi7DDr3Ru/YUo1CejoXZzFLSk45YWGMV1kGUSlAf7vd9em
	 Bv10bBQJixf3jRerI0oVvge40ctZfZVWcLBAFsHO+gbss9MQyYNHGy08Z4Z6Ksigj8
	 f0pEiw5W6xIqg==
Date: Tue, 6 Oct 2026 18:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 radhey.shyam.pandey@amd.com, michal.simek@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, jacob.e.keller@intel.com, suraj.gupta2@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
Message-ID: <20261006180210.03a15e52@kernel.org>
In-Reply-To: <CAMuE1bGXcNwKKX1firkq6eEzymkrDOp8PnnowMzz97SibtpoSQ@mail.gmail.com>
References: <20261004083759.1016519-1-maimon.sagi@gmail.com>
	<asQ1pF9AAqOiEo3r@devvm20253.cco0.facebook.com>
	<CAMuE1bGXcNwKKX1firkq6eEzymkrDOp8PnnowMzz97SibtpoSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 06:44:55 +0300 Sagi Maimon wrote:
> Agreed on the helper.  As on v2, I kept the fix minimal for net, and
> will send the helper to net-next once this has reached it, with both
> axienet_dma_bd_release() and axienet_dma_err_handler() using it.

Let's do this now, trying to keep fixes small is a bit of 
an anti-pattern
