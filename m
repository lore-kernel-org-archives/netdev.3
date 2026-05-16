Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43A632;
	Sat, 16 May 2026 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894053; cv=none; b=cToYz6cWfzlb2dLK9+43bpadxoF+1zNrCfspWEPCKHrQcaEBP2WRxx5ZYgg9VKKNXx9FLr7nnTwaYSShS0M/0fOv0mxLT/5bJ5Q2FDuZvwM4b1EvsGEwtwui/HA82qIQHes6dIGrSY7klk/PfXolxyH3NDxrF7eMTxqULQXWO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894053; c=relaxed/simple;
	bh=se2KfORpOTI0Cd2p9Kb6eMiHDpeFbhpWjpaNI7QgMIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFgjuKaAhbn1jb0vz3EaGX70gZOGMGirC2zrDY4DjgWpapf9PmMGKt7tngdwq+hPIL7m5fuoId49ho9WKHb6d/KmtIfG0ZPpxEmE79kBIfDMARqbgFaThjW2B3OMvQ1JCqn3V/aEJH2q3IETY3QF79+LV8ltiyk+C1uaWLCe1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHiHau4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHiHau4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA4AC2BCB0;
	Sat, 16 May 2026 01:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894053;
	bh=se2KfORpOTI0Cd2p9Kb6eMiHDpeFbhpWjpaNI7QgMIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHiHau4wH2tVPelVnSACn8zOkP4SFIejKvNVinqoRt1ZhHuoKr7ZkN6IcuQZqSYLu
	 mdGPW5P1yR05cOgayb23PT79jqLDP4wT+E4z5Ldz15v5wsS7wSxjWjZZrKDZgN2WTF
	 UwGZJKYBrGnQLNMBQwfWPsaFz3dcRDH0tJafG+BQ0d00xHuj5hu9lBZZVKnoV7jCG4
	 SntblJWZNKS2hulG1yHLltXtvsqWfEz3y8tdaESpEKHugSJtvTMbvARKYQANO9TsdU
	 O6UCKdrx0/0HBU7sx1WIxjwt5wO8nhjE4UR+SVpGextL0rW/m7XMCQb3Xu/u4/tBEV
	 ftJx5tdry0JLw==
Date: Fri, 15 May 2026 18:14:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: toke@toke.dk, stable@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
 linux-hams@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
Message-ID: <20260515181411.28af7ffc@kernel.org>
In-Reply-To: <CAFAa3YDcBsCnEJ1t+a3iHhzxW65HX+QNkZWPKHvDYp_V+UwZYQ@mail.gmail.com>
References: <87se8mytvv.fsf@toke.dk>
	<20260512144512.9960-1-bernard.f6bvp@gmail.com>
	<20260512163648.7367a640@kernel.org>
	<CAFAa3YDcBsCnEJ1t+a3iHhzxW65HX+QNkZWPKHvDYp_V+UwZYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 16:52:43 +0200 Bernard Pidoux wrote:
> I am happy to submit these two fixes as patches to mod-orphan if that
> is the right approach. Please let me know.

It's a GitHub repo so PR is probably appropriate there.
