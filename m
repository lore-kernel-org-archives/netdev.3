Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977B26ADC
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025919; cv=none; b=XlqQyC2RtWcx5LrYs5Bdn6AC8aEq/BOPf107Pa7bYdfm3E0NTW0PRcyZ//wNYBKtO4MostfowdCamhi653NCEoJISBjVzqtx+PJCQRXIZtyKfv6dypK6FJVp5E2Jr/29q/N0fBulWtrs/xd5NuoJ89morJR/j1TeI2eS8ICFg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025919; c=relaxed/simple;
	bh=cGLjn3BbyUk2K8A5VwKCMjPh/N4OlZgefXoNhVKHqm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtMsOW3FpaA3gQbqW7/Ic9z7gCljKrdTbyPPNrwnVdRnNrP8adk+uTII/MwzrRXQHFsiWGr2XkoV8KpcWfR1v45dYDRYSPbzS0K1pztPBlrR4jblD0KzFcYFi7tuACQKsnD1JYMET9nJGsi6f4Bu+vSbBeF/H3qwqpn6s6PvEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCr3ofEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCr3ofEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A83C19424;
	Sun, 12 Apr 2026 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025918;
	bh=cGLjn3BbyUk2K8A5VwKCMjPh/N4OlZgefXoNhVKHqm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GCr3ofEhiidMm1riAImE7TycHG6uIanKehC4PwtRRy5RULw/SId/LS7qW4YTyBeeP
	 d+NNmRmKSJxVa09PDDcYnFrBjB9/kT/MWPNB98YiBN3KHNvJaUME8scmK1vZVNreLp
	 U/Kt1rIgFZbGrprtzwMP1qqNWOhx5RM04M2kKJoX6s4RLo7LYZhsBZ8VGCGChSQteP
	 1plYSDoFVOZGdBeJxXQXoQ7H69708262dY9ptoMSdwZe40NbU4LfZA2U3TQ9ddtz45
	 9iJ2IwyY34aQC8lz7rOjEGvmZcf5S6U9mnEYPAUcBkfVwzYZl24trI+N2uAtJEhNLP
	 aY2LxEpMTDxcg==
Date: Sun, 12 Apr 2026 13:31:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <20260412133157.3b335e1b@kernel.org>
In-Reply-To: <DDF9CC02-6FC1-44F0-B95D-967151BF0592@linux.dev>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
	<20260407162502.19462-2-luka.gejak@linux.dev>
	<20260412124558.190c725f@kernel.org>
	<DDF9CC02-6FC1-44F0-B95D-967151BF0592@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 22:13:35 +0200 Luka Gejak wrote:
> Regarding the TLV loop: I actually implemented a TLV walker in v4 [1] 
> for this exact reason, but I moved to strict sequential parsing in v5 
> based on reviewer's feedback to keep the implementation simple. Could 
> you please check if the approach used in v4 is what you had in mind? 
> If so, I will rebase that logic onto the memory safety fixes 
> (pskb_may_pull) from v5 and submit it as v6.

That's not really what I had in mind. I was thinking of a loop which
just skips the TLVs in order, leaving the parsing of known TLVs as is.
But I've never used HSR maybe this sort of strict validation is somehow
okay in HSR deployments.

Please just undo the comment tweaks then.
