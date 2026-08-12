Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C20270EC3;
	Wed, 12 Aug 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499147; cv=none; b=BjQ7kbtvUJLf8+Z1FhelZyyYoG+6ZdHIDX59RJXEODFL1NMugaU4zj0sHYeHgez04yQlimVba+3NaN4OMadR5Eajql51GrchpO7tfQbJPe2PSQj1otmlH8M/Y0G7yUDtKjUgOzqM4MWHOW6lrKA8cJzb9pUZkKyfgOISwT049ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499147; c=relaxed/simple;
	bh=6etSFMqouKEAaKD0w7tWD7DOwbrhwpBoiyozszCYDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnccqY/oBpakrmRAGVPhaIsOyyup4OMmFkpb9rwYcmFdJI/jxOCqhhvwcTX/yVTr5mdRD49xbxNyTSVGCsL8Z7T6lwALjE1W858t32qw4jZbHlaZLyMSfCDnf9lxHlVqU5Ub9L7TaiDGESj4MUkObuUWfrHo0CRruOyUHooZtCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv1wB790; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv1wB790"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC2D1F000E9;
	Wed, 12 Aug 2026 01:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499146;
	bh=6etSFMqouKEAaKD0w7tWD7DOwbrhwpBoiyozszCYDm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gv1wB790DT8yAAOsrItIm8DS1WO+JqgYQpxomwGEKOaWmOf2IwHrNwj/rSXOZ+xtZ
	 1qJ6xXSCeabCvlxU5rLRGv7PtH+VTtatb/CN5Tbvy8aMbGa3xEPgmbcyitR3Iz+c1P
	 xJKMX+xB6NIYVQoA1oPoiXpgfojnLF/cJXtCvXhzXLOGRLyewdrYXFbnMQwMu8LfFW
	 zWewkQfG7IyxZjbc7U2s1p117F1cLntwzHbw/oM17k5LAK/s7vqlcmi7CZ8x6ze1I2
	 v6k06NHoFZLzdEgnErJZWOqiqwMEbgRAkoeP8/G6xPo3M8+Db3bzFd22dBMTSN6CKF
	 YAr7jDxWJX6Pg==
Date: Tue, 11 Aug 2026 18:45:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <hawk@kernel.org>,
 <ilias.apalodimas@linaro.org>, <almasrymina@google.com>, <toke@redhat.com>,
 <shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
Message-ID: <20260811184545.53e149ec@kernel.org>
In-Reply-To: <20260807114830.344336-1-shaojijie@huawei.com>
References: <20260807114830.344336-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 19:48:30 +0800 Jijie Shao wrote:
> This bug was discovered while testing the hns3 driver under channel
> reconfiguration (`ethtool -L` / `ethtool -G`) with iperf3 traffic on
> arm64. The race is intermittently triggered when page_pool_destroy()
> runs page_pool_scrub() concurrently with page return via
> page_pool_put_netmem() on a different CPU. A WARN in
> page_pool_clear_pp_info() surfaced the dangling DMA index bits left
> by the cmpxchg loser, which led to the investigation.

LGTM, we'll apply on Thu, after the final PR for this release.
I don't think the risk / benefit ratio is here for final.
