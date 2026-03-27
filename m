Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B8282F11
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572652; cv=none; b=GYMhAMm5aVreyjyC5a8NAcL9m0OdhbVF4d4bRr26ld7NhgmduEj5wl9FTnccjFXTVvdeHsatpCcU0lqTqPHfvqwLNcNaOgIuyFuMBv+hojw6qprYkyCOeW3ftTsOoejUem9OOt2R9d+GKhkWI2mT7C4VyBEZwSOvlbF0s8RHBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572652; c=relaxed/simple;
	bh=E8z9xsiZJnyDXAvMSIm4/D6VjQNc8xajnju24fxixLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8+e3HWDJYUvP2MRmKemmsMrLh4w/sf2iWW4nH+YVcUzTBJiVa7pqWGrj3ELNXicMfarRKlu4yGXPJc8qO2ItOuk/XFMbOX7Hd9zTh7p5PHUt/kyzC7hsHBlrvaGzWsxvJdVobryqPaum7+jKhf2RokA33qCfePDB204qCbju8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o62RvCUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o62RvCUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C50C116C6;
	Fri, 27 Mar 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774572652;
	bh=E8z9xsiZJnyDXAvMSIm4/D6VjQNc8xajnju24fxixLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o62RvCUdaElvZvNdXI4uwGymAu3gdVtSXkaPEE9S1tCXCFLWKKE/GhHzbCuLNIU2K
	 Y9U9y0bljpe4Q/+bRPeXon/Z3CRZhSyO23GuXplBWmnpMKSXZAr0jZjDLOx6AcuaGD
	 W6OMOYIvgPctH404rVjPjGTLU0idA1OrO3y30h1BfcXLgqEtYz7hIereu4q+vjgxYW
	 4PR8oR0bXRj+DsisbuEbCif9obgp1eKBjAWJyYOtsOOTMFQPEeCE+faaoFhnkQA2p1
	 6MZUsfGbUZ/47RuW/Q3IHFX+x82i55j5kGogtoJ1HoqTg3vTmyYtgL1BAnm3Zo4r6p
	 4r/ldqyBie3UQ==
Date: Thu, 26 Mar 2026 17:50:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in
 rtsc_min()
Message-ID: <20260326175051.31828b64@kernel.org>
In-Reply-To: <CAPpSM+Sz_z2LpJwJrc9g+A+vRb=dRyMaDnBdZPP7TT952bgjpg@mail.gmail.com>
References: <20260326075851.3967598-1-xmei5@asu.edu>
	<g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
	<20260326122137.4aae1d46@kernel.org>
	<CAPpSM+Sz_z2LpJwJrc9g+A+vRb=dRyMaDnBdZPP7TT952bgjpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 13:44:37 -0700 Xiang Mei wrote:
> Thanks for the suggestion. A TDC selftest was added to v3.

Excellent, thanks!
