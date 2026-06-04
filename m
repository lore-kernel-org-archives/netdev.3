Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A2199D8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537544; cv=none; b=RYitmdYYAkeEK/lyX4uuFgK3ekFJHuA+k+ETvkiFlyYRWrjQink4ladtQCJjEi+CHYWQlpfaaSdh5PIwLFzyqXXjsPDjz1kQFZe+no2vXJWPltgKh/QXoUjAVk8YSft3uD3zq6JRMt7ehQHXRx/6peKMFQRlESHJA4krfO9EDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537544; c=relaxed/simple;
	bh=l4ZF8/PZdrr9oJ9Z3PmYG1C/xSWrKhDGca+y0i0kYTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8m+cfxcDP8toY/OysWOOfdqnwFjrE8i3jTCCsUl63iZTU3ABONFQiG1wB24ywwzYQkG4eb+tqUxjLhgezachAgH5M+KEB0kK8NEZnlTaOlt6AyC7hvc6Y05+TBXtDopUikWlRKlYRnh2pwcyqj47yCWG9lbqD0VqVy7yhBEIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjF7yMxM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjF7yMxM"
Message-ID: <dce55902-02ab-4e5a-ac8d-6173064bb35b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780537540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ZF8/PZdrr9oJ9Z3PmYG1C/xSWrKhDGca+y0i0kYTY=;
	b=EjF7yMxMhYMnENFkoE8MMHzLnlnPcItcIWat4TPdPQ7FW/5m8X55awsl2uYvq1mgm9tm0a
	M4Yx4lIvVMZxAj2xsf/EZb4LN/8GHTAMDMtQO4EbWOj5qOlpPh776n38oJ3W+AHu0lb0Tz
	SpAGTwEDiMCrFAJEG8HhBOokDoY+uck=
Date: Thu, 4 Jun 2026 09:45:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net-next] rtnetlink: use dev_isalive() in
 rtnl_getlink()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260603180831.1024716-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603180831.1024716-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/4/26 2:08 AM, Eric Dumazet wrote:
> rtnl_getlink() uses an RCU lookup to get the netdevice pointer.
>
> When/If rtnl_lock() is used, we should check if the netdevice is not
> being dismantled before potentially perform illegal actions.
>
> Move dev_isalive() out of net/core/net-sysfs.c and make it available
> in net/core/dev.h.
>
> Return -ENODEV if rtnl_getlink() finds a device which is currently
> being dismantled and RTNL is requested.
>
> Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

