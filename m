Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42554145E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663264; cv=none; b=pgGQYCR5DnLJeShDKjC8UvXJ/tX4hXeV46hyMaQgnHAIPpIB8pkD2+l7hL//2o4PsQMP2UceqY0sdyV0piHCrLUWTBxgm9devokx398DIlEV2K3/pbyyBOhaXwqsKKEYCsjTJEHRrAt15p5pWhse5v04aruu3YXRFdin1qwwhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663264; c=relaxed/simple;
	bh=YAKO41wLQ3RQbu8qg/keeeTTdlwsdvYntzTV4RWRFFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9vBAzNBG45fM5LbyziGRb/N5i9r7pYIeCO+0J0UwYWR01r+Nj+dfCA/+5Hofx1K8pHEnoBHfuo4n6ylWKOeanH/kJfrDCkrCO2Z+plzsILcRDoiekOJa6Lpi4IbPGH/JpGGgLNAQ/owP5Mu2IBTO38N3eZlRjk7tf/0TRnFBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQezgzv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQezgzv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6267D1F00893;
	Thu, 17 Sep 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663262;
	bh=YAKO41wLQ3RQbu8qg/keeeTTdlwsdvYntzTV4RWRFFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fQezgzv7/zxxUoQti6zzujqi6F1R17qEsMew2QwJCAXSU1atJHuqxX/j7xGTr31cr
	 gYNL+9ilTgKqsf/+Qp5X6TKf0SR3heHL9k1xLqtGGmizfFYbceb7+lIJzSsC+R9YAS
	 63j2wgQNayGeoc1THZNlPSl0Bit3yXEZFR59/0y+Rqb58DBEv5UXHd6Yf4XZHoyA0G
	 laxK5GI6ZCi1c5USOAKAI8jtzHAzKvfn5D58OX+IaKiZ4zhZaT5HExRpy0aJuloPZk
	 VJHAuYOOuWDgjB8NwriamgqEHWgLV83qu3MK16SdQHH73Jg1SdzEcrT3Pwwe0IQlM7
	 x3JG/EznVuXlA==
Date: Thu, 17 Sep 2026 09:41:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Nimrod Oren <noren@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260917094101.0115277f@kernel.org>
In-Reply-To: <1c767f25-fa23-44aa-b8d7-b1374627fc9a@nvidia.com>
References: <20260804094518.53b56d24@kernel.org>
	<7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
	<20260811080433.26f404dd@kernel.org>
	<8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
	<20260811103832.28e5c8d4@kernel.org>
	<2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
	<20260812095947.3d0e6ca6@kernel.org>
	<a0b4e051-546a-4950-8dba-03391bcded70@nvidia.com>
	<20260812154101.72b64936@kernel.org>
	<1c767f25-fa23-44aa-b8d7-b1374627fc9a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Sorry to re-heat an old thread but FWIW I enabled HW-GRO recently,
to get the zero-copy tests to work, finally(?) And it increased
the reconfig time by ~2x :(
