Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E433D506;
	Wed,  8 Apr 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611601; cv=none; b=pggWJkxZfRkLmwRaKkCv0bdMRr1EeY0k30un/yM3glx3t4AgArExXVV7Ak1emfrcgEMGguhTV7Dmh+/UmSrMAzb41+k0fTAZU+uYGtukLkkS0klitVDUZOhrAGtPLJODgqvCjG4UPgxgqdeR2ZywsXl4HfXd29sNkbrWKdpiQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611601; c=relaxed/simple;
	bh=Nyr4Y3hrqW0lsZpUYwgdlqSjdXbPzIuecRDVMwNRpzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CZ+NJHDKweqOnDM4Sj7derOqqyai8/l9VOVbPVqgcMliI0NCbOyB63WjT/EVGZNWDyxsJCSpXRsT5BiqCE65YyS4i/cIdyvqdJ/nhng7z/Pt+8txgdN3pnAn+x1old3MN5NWoB7YLRXbTClle9hP7FJRMlPR9g3lGx4Slq0j6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BiA6zpbd; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BiA6zpbd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FexY6FUOSc2W+INBh8iz7/U4FBYoyIaQIFaFQtwrhtQ=;
	b=BiA6zpbdNo6mLOYPlnSJcnEXh5YnfkQLLLLUdUBz9dw3Ig4b7LB0AyuCP3JoPQzS0OiH+WZmL
	Uw5GodWyDlxAj4sP/RUXc1feyHqia/HLLZdEdiXHQW/iyM6OquH3XRuRJyErrYoWkwNqeKVgfhS
	8OqCmOGYHJt5PyarlcsjMzs=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fr4xf4ydfzRhSJ;
	Wed,  8 Apr 2026 09:20:22 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A9DD40561;
	Wed,  8 Apr 2026 09:26:36 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 09:26:35 +0800
Message-ID: <377e560c-486e-499c-a7e9-19edf2a7cbdd@huawei.com>
Date: Wed, 8 Apr 2026 09:26:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: sit: remove redundant ret = 0 assignment
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260403084402.4105936-1-yuehaibing@huawei.com>
 <20260406184313.5c446354@kernel.org>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20260406184313.5c446354@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/4/7 9:43, Jakub Kicinski wrote:
> On Fri, 3 Apr 2026 16:44:02 +0800 Yue Haibing wrote:
>> The variable ret is initialized to 0 when it is defined
>> and is not modified before copy_to_user().
> 
> Makes more sense to remove the init during definition IMO.

OK，will do this in v2

