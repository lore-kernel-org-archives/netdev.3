Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FF471CE4;
	Thu, 23 Jul 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812554; cv=none; b=d3zZCkASsTESm7RD2Sc5Pc3RlWqV6rjd5hHEhOyfJq1PlGy7Mau7GmeDexu2fr0hdQ55hO8rkaVFISwOB8yCtPCOWAUTawRfK/ElY97e43qZUh40IFmfwSEBHRxmbOzzu0+ACel4Rb7XcKAjLfgB3DAys4fw+FDhAkQ5Yu1MAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812554; c=relaxed/simple;
	bh=ogF1/lx6v80Y9VEHNW9XJ9YZVZb3lZFUF1zZ52uRDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QK3GbAwtGqHZnH+dTKt3KuaCdpgqzlY5YzFg/6CASO4DjB9EaGQ+W38i+l7RwSGzY26sXwKUQzt1RPcLjfgeSjtBapEYLiSb2UA6zKno/Q9Rc5P6TU0k5vm7d/fsYlvS/+VXWiUyIlD+reM6IvNQTQ4ufPGsvXrtuQS8yDgt3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIZ1GuyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIZ1GuyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965731F00A3A;
	Thu, 23 Jul 2026 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784812544;
	bh=+0Wn7Wwmg9bFq1zegHa1QOhYQQe3Q8knYFvDFs+AtsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jIZ1GuyKv6h8fYAMIBA82ika/8T+D4WsQx6VrgEYHP0uppD4wfo5ns5wQnoDMv/55
	 +OQLRqXbZ8cPfwrKT/XuSDHipCy1100iOsOVENsOWc+UWG1knqEk7W8b/ZfQqVumCj
	 XCkU1sTksTFrJLMcBQr9TOM2uwlYLpdgpFddwojZlTz9rNAFskpAQBz+ZMwOinf+p3
	 KDseMzc9NxiKV/p6p1EEUwW9OYD7ljA/n7DWAHndIpez+Vw7Ah9iDqW0pzb1Pl8u8c
	 qTdnNvXdZ34oh5agLGxXINUdrzh0xwmg8xeoLLJgWK/7IXrq+kLsSiLCE12Y5nBcBh
	 oDE7Zn2gzA6Vg==
Date: Thu, 23 Jul 2026 06:15:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
 <aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
 <michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
 <emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
 <joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
 <jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
 <corbet@lwn.net>, <richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v5 00/15][pull request] Introduce iXD driver
Message-ID: <20260723061526.38902608@kernel.org>
In-Reply-To: <al5Lr2Qm5pDa-yOF@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
	<al5Lr2Qm5pDa-yOF@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 18:24:15 +0200 Larysa Zaremba wrote:
> I have looked though Sashiko feedback for this version. A lot medium+ comments 
> were things that I have addressed as false-positives in v4, so those are left 
> out, same as many of low-severity subjective issues. Unfortunately, patch 4 does 
> need a fixup (see Re: for the patch itself), but hopefully this does not warrant 
> another PR.

There's gazillion patches in the queue. Just fix the bugs and repost.
This "we will follow up" attitude is getting out of hand IMHO.
