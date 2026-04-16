Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17867340A46
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325823; cv=none; b=o+vqJQ7sTcD8mDNBYJYqa4IzQH855bqlR6N47ZYJKE0fU446ONJXhN6I8pH3Pm6SE++Xd746M2JNgIYuUm109byTmf30SbD05oi+84vVVNkBmvLkvjUvEp7ZHzLt+tubRMxPxuZNL12lC0d9locUEnfhtU1U3c5Ro9PvubxbzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325823; c=relaxed/simple;
	bh=KxuNWQ2a3a9rgfOr9Cf2/P6mQx3czM9m0lYSOzgROec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqgwwiPAcJup0BHLb5XyhlPbo/8WTaO9rvoafOB35pROkQc7luEuZBjTo8mcLwHqRTqPEKHVZLFo6V/IE0jDCQ9VUTAC7ugT6cdz78xjhKGQJdMXbmd1/08fiKFSkp3OYt0TnqX+s0yX3/5m6ykQp2RmUY3K0GaGXUQH+RTz+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xV8yrVIJ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xV8yrVIJ"
Message-ID: <0e579779-f38b-4db3-936b-5d7add12d15e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776325810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11cyg0mvKQwNL/9Dn8fT/UbJkY9yFbzdNgRtigL8718=;
	b=xV8yrVIJm3m5Eoss2vL0r2ithRXeQ2KtK434zYXzyj821InVMuKPvhtIAiiq97KeX74jy2
	aQ5sO2zvfEmCMT38NiYa7kearyrZSbsBqK8OLrW8edfRIbMwqBUVWpSEyNFXOVUaKCgAw1
	lwC+YEu1sL7qITn6zMdDMvpvsr7NNa8=
Date: Thu, 16 Apr 2026 15:49:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot ci] Re: net: tunnel: fix stale transport header after
 GRE/TEB decap
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, pshelar@nicira.com,
 syzbot@syzkaller.appspotmail.com, tom@herbertland.com
Cc: syzkaller-bugs@googlegroups.com
References: <69e08a0a.a70a0220.259bc5.0019.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <69e08a0a.a70a0220.259bc5.0019.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/16/26 3:04 PM, syzbot ci wrote:
> syzbot ci has tested the following series
>
> [v1] net: tunnel: fix stale transport header after GRE/TEB decap
> https://lore.kernel.org/all/20260416034610.8873-1-jiayuan.chen@linux.dev
> * [PATCH net v1 1/2] net: tunnel: fix stale transport header after GRE/TEB decap
> * [PATCH net-next v1 2/2] net: add DEBUG_NET_WARN_ON_ONCE for negative transport offset
>
> and found the following issue:
> WARNING in udpv6_err
>
> Full report is available here:
> https://ci.syzbot.org/series/3886f2f1-a6d5-4c5c-8dc8-bc1cec577567
>
> ***
>
> WARNING in udpv6_err
>
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
> base:      1f5ffc672165ff851063a5fd044b727ab2517ae3
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/06cf41a2-60fe-4f9b-8f68-57eb6d1e48cc/config
>
> ------------[ cut here ]------------
> off < 0
> WARNING: ./include/linux/skbuff.h:3239 at udpv6_err+0x1521/0x16d0, CPU#0: kworker/u9:2/51
> Modules linked in:


icmpv6_rcv
   pskb_pull ==> skb_transport_offset() = -8
   icmpv6_notify
     udpv6_err
       __udp6_lib_err_encap(skb) ==> WARNING


