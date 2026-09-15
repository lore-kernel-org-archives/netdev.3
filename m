Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F7463B6A
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457249; cv=none; b=dRDvFlvEwu/fLlAcsUcUVniI92Ar8ZAxMZfLzEcMavVX1vxRWLViKpeNw5r0ozicDK1oq+Dyme7XYb8ZsbG0hrO3JlOVaykfOAle7b2gEyPp0GJpBtA9zraE9l9RULq+viLW/2I4L7FhgsW9KTbwfLyMIdRnVcy7r49MrAiHXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457249; c=relaxed/simple;
	bh=MqBCI+lVDGGCy/7zFPDUhkaMR+eRFuQUiREtT+Naq2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbaB6HFFR2hF3CBD7wVnOuZwF2IFhYOpEup+qH4Ima61PA/Ibf/5bPrh+pMe+DwevCHkLspioRYpCnk8Ru20UUjPh+REDl1C8vL3bhTPKYYvUfpRkKlk+0wnaVYWAq0BXkXzKHZpYaEUDaBpOI42xWqE2D1fbYeqEyCo75+RxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjF7aBUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjF7aBUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28841F00893;
	Tue, 15 Sep 2026 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789457248;
	bh=dF1FTwkM5J/isiMsXGhYAvgDZuguh0QJTLMQEfmKgwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RjF7aBUi+BXFMeM3T7Frj79uzK7UMwdoBI5fInd/CkHMLYeqgSj3IEowBFnDdsZLR
	 Lgu8800VXrKeBSNjLvSopcjApVJaJ7epCc77PCIzm5hKITmQpz/d2MpMs++uY2TI0z
	 OqYSnOeDBzeJEmM4ggpSP+e9RXzi2s/3PFFvon9mXsm4lBEgdNJZ6pNn2/xQHM6gTM
	 qidvIQyHMHcTc5AQulHkf2N6NosK9BarORm8jKIH9+F9x348jrthpKT8ZZMVLaCwT/
	 oEEt/jtfJhOhAgFNFhDyNEJeziiwky1SQdn+i3GDGnUgB4A1DgQrZro2/0Su2rwkwf
	 J/gWlCKyQ2pbg==
Date: Tue, 15 Sep 2026 08:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 0/2] af_unix: Fix inconsistent scc_index.
Message-ID: <20260915072724.GB314999@horms.kernel.org>
References: <20260912030852.1467872-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912030852.1467872-1-kuniyu@google.com>

On Sat, Sep 12, 2026 at 03:07:50AM +0000, Kuniyuki Iwashima wrote:
> James Burton reported that a single SCC could have multiple
> scc_index and unix_vertex_dead() fails to detect a dead SCC.
> 
> Patch 1 fixes it and Patch 2 adds a test case.
> 
> 
> Kuniyuki Iwashima (2):
>   af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().
>   selftest: af_unix: Add test case with mixed lowpoint in scm_rights.c.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

