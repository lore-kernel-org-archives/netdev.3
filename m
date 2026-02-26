Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4773176E0;
	Thu, 26 Feb 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087095; cv=none; b=R1lobEFBG5OHa9HzNj05BvoI1LGvmTuZJZR+5PHjCyutHfX0aZN9XSlOur6vQ41oZ9W9tmx8kHTUKeljDyP9BL5KlEc7eHc0q1d3n9MJKY1cr1jlCxN/csUlNMIW8K+5yAGabpFUr5TROqz/7JHPwSnsdH5y+QCU4DEiHVRRKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087095; c=relaxed/simple;
	bh=9aPeIg8i7j2JFjSZZ83JjYjswZuyP2Mbg4p3aPTtmGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcppmD5PqSM7WF+Le6/WL+8F43QsRve9/8VEQBNBqmh7Hm+9/3X4AKb26lU5veDHgeFo7RKvtOZE4l/sh4Ab+JzSncyRuFDKOQh5BLmeQe+foX0VErfu3PU4UnkUZnBgZ89uSFKm3csz/coj7tps8s8aNmL2ax6F3ywdErQ+OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g5RtaD5N; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g5RtaD5N"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5NYYg9SyyRuhMIdqW5dQmykPCiWW2TQvca296B7GPZ8=;
	b=g5RtaD5NBnyOEYw7Rg65XbVlB8FqSXNglo22kKViu2JSGrJfxGiBYhuAtyfxZIzsUHUzxIqXb
	KxvWJmFChVNdDmnBKyDLGorKtVsqZ+pvFh41aJstPorwkBBT9N87LXc2qiMAXXLbs/mymcZ2rqR
	jgZYEg2evk53jhfK+5DGcTU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fM1XD1XjhzLlZ7;
	Thu, 26 Feb 2026 14:19:56 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 73AB240568;
	Thu, 26 Feb 2026 14:24:43 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 26 Feb 2026 14:24:42 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v01 00/15] net: hinic3: Fix code styles
Date: Thu, 26 Feb 2026 14:24:39 +0800
Message-ID: <20260226062439.1796-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260225172839.23f3546d@kernel.org>
References: <20260225172839.23f3546d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 2/26/2026 9:28 AM, Jakub Kicinski wrote:
> The LLM timed out for one of the patches so it won't get published 
> to patchwork.
>
> Another note - could you perhaps cut this series down?
> You're adding a bunch of features and:
>
>   34 files changed, 2985 insertions(+), 29 deletions(-)
>
> Not too bad, but I still think you'd make faster progress with
> a smaller series.
>

Thanks for the review. We'll split the series into smaller patchsets and
modify the code based on the reviews of Ioana, patchwork checkes and AI.

Fan gong
