Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E029BDAA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590475; cv=none; b=uDxipI26Mknps7mGPGYwjiEhaJnrO43AqQDbZqQKyJQpDWFjxvNzmrwEyVlYGxm95N69TX0sfOL5enuEGJWPW2Gl+oUUNzRzRZNLM2So+XK6p2DLbeNTEy4F4CEZgbrDH3k3RIzsLT3x7X2uP7UsKlEtDiX5s6h1mAiqTEmo5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590475; c=relaxed/simple;
	bh=lXnloeSbbqWuH3Qf3c89IHAlxgiJWBJWSJnssm6ktuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwOYREyvXDohKjEMoaf8iQ7jx7uS71BZM7V/FApZ68WLn5JU0+PgY5W7ne9VAVpXjf98RgF5zuFoa7WQCiDQyVjp4Ye26xD2NjzBjWEu2/n6xVsLyY7QZUUvMMih2hmpwyfMs/AIJpp0mmkj/Ky80FtzJukxqoj4XyoL3u6coj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nizKRrDG; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nizKRrDG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lXnloeSbbqWuH3Qf3c89IHAlxgiJWBJWSJnssm6ktuU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786590471; v=1; x=1787195271;
 b=nizKRrDG4UgWEYESwESoleiT4iM0bJ3hgc07Syk6WYcfhVt6ME7Aq70qvMLVKGdrl5vpvjsS
 eqQuInNkI7vTD8nIzbXQK6rzU1TG8iyulO8+BlNJ5LCMcYFJUHaUehmdR9W5LJpBfD6Sh0zsboz
 +JP4m74YDkZXFmw2UCbeYP5I=
X-Envelope-To: netdev@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 34f956225baabe53;
	Thu, 13 Aug 2026 03:07:51 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <7a41da7b-62ba-4417-967b-cc4218ed1c17@linux.dev>
Date: Thu, 13 Aug 2026 11:07:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: core: avoid WARN_ONCE for stale RX queue
 mappings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Li Xiasong <lixiasong1@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260810125029.1567742-1-lixiasong1@huawei.com>
 <156834bb-8e40-496e-9443-9d515fa18eab@linux.dev>
 <20260812190324.74c7330f@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260812190324.74c7330f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/13/26 10:03 AM, Jakub Kicinski wrote:
> On Tue, 11 Aug 2026 14:58:31 +0800 Jiayuan Chen wrote:
>> I just run ethtool -L rx 2 on my host and got such message..
> Looks like veth fails to restamp the queues, tho, doesn't it?
> If so it's not an accidental race, the drivers are buggy and should
> be fixed..

Yes, you're right.

My test only triggered a mismatch between veth's rx and tx queue counts, 
which is not a race condition, unlike the one this patch addresses.

