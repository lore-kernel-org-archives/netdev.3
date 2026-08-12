Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC9372B3B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574463; cv=none; b=FcrJp2PwkosSAX2NQrhVX29H5OYJT1inYWkudSYUTUiCkr73/ZBsvLo+ov4b6FUdgrSBwZ9qnefXF02Rf5+Yqgr3XDCM9FBkv+oafBLnk66knJeS0AUjnVOjJ2Ad5IyDrL/LoYxBm43ZHQg8lTevxRJZJMjXxh5LaHcyfTNvAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574463; c=relaxed/simple;
	bh=qVJqiSQyamv8gXgU6hbDsZBL/oS6MlwSA5VM4UGbv3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3aBJQLU42OqIh76xBN6cOOqKBkzgNvvadsKPr26v9MI2MZCjeDyF8sGGOUoj66R8IL0Z89bDdNjRuR1DOcAlpG4eO5QiKghM6JKeuMeh7bgbBuqPp2WomP65LV5IxEilwGW9VhNw7M1GM423iVHdw190YAz8pwphezMOddXDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb5OzP1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb5OzP1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72841F000E9;
	Wed, 12 Aug 2026 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786574462;
	bh=VhE1FoZroQWXoeMrSq7dQZcE0LQjAHvrSEV/Qik5nsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eb5OzP1JOd0Y0RM3TfEdOSZ4QEMGiH4YKZ7hNwDLCpcRGaQBySssM4IhKpUZ+tmlg
	 4C1H6EZ0/LypMGB8lezXkd/2pJhL8MzGIJzZeiE5Eq+bzsUNi9CaRnxnWyzk++0wb1
	 bA+9SXUdVNpQMWNuovLiivuvEm37oEtX7k7CSHRPUh/BYTafSJeTOVTG5rElcq66tV
	 meK56EE/Z7pMwshCWHnWgFzT3ygGDfg7EoKUakVyp4Y1ADeYleAphXc00yeUPTOzGM
	 8oxFWHHY6TftvocBSU9NYbBTw4qjh923Ryb8MkR8pLCtUJh3u+XC1Yo7BAPB8w9lNR
	 lu/+91Te/GPrw==
Date: Wed, 12 Aug 2026 15:41:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Nimrod Oren <noren@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260812154101.72b64936@kernel.org>
In-Reply-To: <a0b4e051-546a-4950-8dba-03391bcded70@nvidia.com>
References: <20260804094518.53b56d24@kernel.org>
	<7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
	<20260811080433.26f404dd@kernel.org>
	<8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
	<20260811103832.28e5c8d4@kernel.org>
	<2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
	<20260812095947.3d0e6ca6@kernel.org>
	<a0b4e051-546a-4950-8dba-03391bcded70@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 21:48:31 +0200 Dragos Tatulea wrote:
> > Ack, I'll send a patch to bump the timeout shortly.
> > 
> > That said, the page pool warnings were probabilistic to begin with.
> > And they were hit in page_pool_unref_netmem(), I think _some_ bug
> > must still be there?
> > 
> > IOW mlx5e_page_release_fragmented() is draining more references than
> > the pp page use counter, that's not normal whether some command timeout
> > out or not.  
> Yes, this shouldn't happen.
> 
> You mentioned tag net-next-hw-2026-07-03--00-00 as the first where the
> crash occurred. Do you know if it ran before without crashing? I can't
> find older data in nipa. And there's nothing that seems relevant around
> that timeframe. I'm thinking that this issue could be older.

The data should be there but I think there may be limits on how much
the DB returns. Anyway, querying directly - looks like until ~june
there was something missing in the kconfig so the test was skipping.
But here is a June 1st run which passes:

https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/672642/test-outputs/35-pp-alloc-fail-py/stdout

so either it was running and not crashing for all of june...
or our crash tracking was broken in June :)
