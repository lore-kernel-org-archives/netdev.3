Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188842DEA7B;
	Fri, 15 May 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806653; cv=none; b=o0DzR2LXS0jDdtytL5B2EJna+en171KaG9PS3TGIS7Tz3tD6NrGSwD2w3/wF+UuJ2T/FP4CJDdh9X7jgELhWp5Aoyumb5011krjjyL7LycBhKCofPrvyLy2mPFXFo6GMyUtuHkXedkqiBvdSESFM/XH5QttFQxWclOtgNF8Kuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806653; c=relaxed/simple;
	bh=1MAxx97l9qPlZTWhsIlwy4yJk5DwyGZm4WbRgaTBino=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZruP8vmOd6bPyKr5hPt0SiZVicdzleOFX3Jw2H63KbcolELkTcRYYsoXStkWgzdysLG+oVsEh892Hsg5Nw5zTPWDRrlfL/1Tl+/ESgplpeDkHP/qSciC7O9+7ZnmLh99xdunv6zEkkJV1wld2PmXPjVBhOWrZTUDnos41549lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkvQYUJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkvQYUJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB32C2BCB3;
	Fri, 15 May 2026 00:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806653;
	bh=1MAxx97l9qPlZTWhsIlwy4yJk5DwyGZm4WbRgaTBino=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkvQYUJVkCp3XZ69qKuZWm52YnNOGp+dH6QL8h8HWFApoMxaoa3k03xB6a9uOiQ2m
	 hOmKui6qIy+Cq9PaBfbIyHSsObbuNSFaQgm2gwPS7y4Pga3heD1Cj3Ce67r6WZmLo5
	 s+xLJhxkXHRY92G59m9ViaU9/QEZtLIF2dMLMcn95E3c5HtE7ftsluZ9oeB57VMg9q
	 m87bsLTfgPVtt4ZsFFYaFU4GP28ZAO4gJwelnTHavbathiYVvHzh7y+IIG1pLrpnsa
	 R7ZnIC1iQxV48iusU4lKLIF5a5f8ntCL+BeFc9d6F9AiX9f/m8iri5VMsxJgzhabv2
	 OgqRWbtH0yA/g==
Date: Thu, 14 May 2026 17:57:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <qiu.yutan@zte.com.cn>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <yang.chuan1@zte.com.cn>,
 <huang.jian@zte.com.cn>, <zhou.shizhen@zte.com.cn>,
 <zhang.dongyu1@zte.com.cn>, <ye.guojin@zte.com.cn>,
 <yang.wei20@zte.com.cn>, <zhang.lin16@zte.com.cn>, <li.hao40@zte.com.cn>
Subject: Re: [PATCH net-next] net: arp: Fix the coding style issue regarding
 spaces in  arp_state_to_flags()
Message-ID: <20260514175731.1ef2bb5e@kernel.org>
In-Reply-To: <20260512143931584Zv3UzxnMq14MaQPmsK3VX@zte.com.cn>
References: <20260512143931584Zv3UzxnMq14MaQPmsK3VX@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 14:39:31 +0800 (CST) qiu.yutan@zte.com.cn wrote:
> According to the kernel's coding style, the binary operator & should
> have a space on each side.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

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
