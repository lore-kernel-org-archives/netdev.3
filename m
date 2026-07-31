Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E73812D2;
	Fri, 31 Jul 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541722; cv=none; b=kpKz4RtLmeHbyS9tAA3+ONb+XSwXA91F3mk2HhYWP/DagEMic7s2z1S+Wd3rf7o91zXZ+FWXKo+I53xm3vhqxpJFYH9TrGl1+GrxWQwhfdZMzx8KMmR0G+OxZxfceBi9G3czWrMUJx+9CBvqtRm5Pfo4V8FJiyD4SCgwcCYeLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541722; c=relaxed/simple;
	bh=Zt/brRx2WhrKDhVf6UNXQhf3aprRllAC5j9QI3kbKto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rib3ZxP9Q13pRJhiEWkWmXiaaPBvEnDzmI9KlPesjOYsEkDWNvvjrbXCgBdt3B3vs9W47zkFe4tvL0MI6ASFxHH2vc9ZtuOHnpyvLBdR+ScvNSK/zBxNT71pPNKPBWbWO+77wXyrAsLNQ9Qm9hEHbBHWy5bOKlmtXNWD64/KFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW4vgSqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW4vgSqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D8F1F00AC4;
	Fri, 31 Jul 2026 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541721;
	bh=LbSFirBXbG34eFxWRtBpQZ0x3LqqqbKzaBXUfzDEIg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DW4vgSqaH1tXxVyDTtj00S5pU2Daqy3jOwrbTc4pf1L9eU49+6GffPjPjLQ8xlyYn
	 S2FB9IiJV+6xxwdhCPl2YSshbn9fUzm3Ji9YdvBfUbeL0x3au54JW3zTyjvVEvyKP6
	 kxjWBhQijlqCE8Tesss/f6+jeGZcbK4kY55mdrUAMsJONeIe520AQCcjg4mUAyEbxK
	 gLFaPMRovQ2/Sy2cJ+lkcyfWA5T8GBq9K4RvlKjXZlJxGKntbjHzfOJW0SneMW5jOa
	 HajgKKuX+32Bek5kpNNzYWRXoQUzA9qTdleCJhNfoWWDARYaDCm6HvnZk5CbZP80bW
	 eaavSPyl9dsnQ==
Date: Fri, 31 Jul 2026 16:48:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lee <david.lee@trailofbits.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, Dominik 'Disconnect3d'
 Czarnota <dominik.czarnota@trailofbits.com>, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: seg6: clear IPv4 control block in End.DT4
Message-ID: <20260731164840.511f6a3d@kernel.org>
In-Reply-To: <20260731140832.567669-1-david.lee@trailofbits.com>
References: <20260731140832.567669-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 14:08:32 +0000 David Lee wrote:
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.

Please delete this ad from the commit msg.
Maybe you want to put Reported-by: Kyle .. @open.ai>
And you are sending the patch so that will be the trailofbits.

Please learn to use correct authorship tags (From vs SoB).
-- 
pw-bot: cr
