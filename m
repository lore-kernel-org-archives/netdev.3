Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912D3D8906;
	Tue, 28 Jul 2026 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280392; cv=none; b=ihM6/qhpYg+C/xLQLSpPEMLGiEeqsy2J8R8+YEddUfL44gG3500jEjXrb7AaZiAZ+VUxgylGJwdnex+BXjwRFXTsEbMIFnyG1waG8DtSiEj7mQFon/MMIr3K/Vq0DX5Iq4vB59BljNzVLubcGpXVsagVTvHAyQk+lW39hGh580I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280392; c=relaxed/simple;
	bh=KMuF2xeHC8iolv7f1haD1XvvCAO8CHzj7+FDYxSGQqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUHAo/LsFOHHdshSzjavBEGcwRdIC5XHc2aOe+XyqPjZzfrm6QGFrSoLfAcRN5JqVpoAPhXB+zEr80WrqSEKUWUkXVC3n7Y/T83n6ALeQXdLFhlH4fWW97MEAJsh8fKgWnn94VOdkBDK0vY1AY1BL1RO1OdnSgwbuCrL5+p3Jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrxC86d8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrxC86d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076311F000E9;
	Tue, 28 Jul 2026 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280391;
	bh=wUIOcGPi36MI84Vcm4WbKh6029l9YCYhnWB3KwfZlVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GrxC86d8772voT9cRIHbTji4AGD93l7dO3+45mRwyvah7k3Dl6vRl/BWl2zGUeeOC
	 o5vW/dL/b2dh9bNcMapf8wzl77mwr/prQPim8b6p5v9d2j2dQwxSIn3hnV0R0aVnhD
	 d8CjjSq04DHJRWo7Mr7whlt8I1ENv04xwvy/w26VkfVwfA6d/t+vMuchqwIblrQfok
	 CDztbPR52XP3SqC5sdZgeH7vpv6zabbh6SGCllhStu7a0zZ/cJhAg1yhhm73QwrIMB
	 6i2Rh3jIeETmZA7A16cdLrPoSLUeth+kZw3l5XDwdYCSDdKGK6y4GgaQdH3/ASWBU7
	 DNjggCmoiK8xw==
Date: Tue, 28 Jul 2026 16:13:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ayananta Paul <ayanantapaul@gmail.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: netlink: fix spelling in
 tcp_metrics.yaml
Message-ID: <20260728161310.218d4662@kernel.org>
In-Reply-To: <amhElJLQoUJE3lwA@ubuntu-btw>
References: <20260728052507.9954-1-ayanantapaul@gmail.com>
	<amhElJLQoUJE3lwA@ubuntu-btw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 11:29:08 +0530 Ayananta Paul wrote:
> Apologies -- this was sent with an incorrect \"1/3\" label due 
> to a local git-format-patch mistake on my end (unrelated commits 
> sitting on the same branch). This is a standalone fix, not part 
> of any series. Please disregard the \"1/3\" in the subject.

You'll have to repost, sorry. Patchwork will think 2 more patches are
coming and wait forever. CI will not run
