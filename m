Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465215;
	b=EE+mTbQN8quasIu8CXwrKRqHVoFwkFjrdJ4uPVRaRny0IEx+o//reI0CNWDUyobcw5Vi
	 gDza1PKVGTV3VOz2t/VdH0XI9glwrord8nAwa7H1172rvXbAB204ZDcpRZejJooCDqy6T
	 qC73mApPG8vmS40pzOKNw0IxCYZHVGBPcBoSCZllxRh+jnecT+yEvjwkj4nBcVF1JQ/AP
	 nypvHEbWH2p2jTJlPFNkWr8jaVGWKGOXSGsFU6wcdtbfdf6yfT+VZbLhkfeX4Vpvp/Yw2
	 PnwclW4Y8NhcZUy6AeLUrZ7XRg2xrWcoJOftBgStKKMZz44lcpjPt242FAttyl/+gQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465215;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uHXe8pVlE4dqfLIyGP09qtemqH9DvHUqldPU0PjaBp4=;
	b=OwaQr5Y+ASgJ/+xcC6TEKnEBIKRkNFNR2Gl2jb5EGL26LHafIZd8ly8YQ1k43eiXix7J
	 ctZg6y8S/b5frE6b64P9fwBnAHNGUxEuUJWDdGTPCsMUAwNDGnMiPfME6wwVfgJ6D4hbC
	 PM1UKJ0BQA/XnkmqJVF2D39zJWBN0UkNU1LHKIhC7uCvc+OIsUJuvwiKfX2pvhlz7HkCe
	 HJ8PRSIdrKe8mv82JQsQE1aEcdUscAqR718iDRWgssJrhVesrE7jYrZNozR1lxHwo/qtN
	 p3wsvlXZbUs8ooVKoHLFdH/vKYHFlho+ion5zUZIaDW2mFkFj/x2mXBA7PiT8dUZ68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZHf7iJJR;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA814606A31C;
	Thu, 12 Nov 2026 06:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA814606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZHf7iJJR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ZHf7iJJRwiC6lSaXY5rEk2qaazALqlsVkaG6IbgaVpRZTP/TdFcfZdqSJ2s13YE204Foo8yNTDgPJ
	 sVCPqlNtTMzZJ8dWqu/ZyiGtxwJbJaCMdV1drPvCXRoEMdzWCqPwHkNeKn1Mhk9G8xT+7yXD1Zfsr1
	 Jw5kra7aS1urSwzI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af55dbaba0-df60f;
	Thu, 12 Nov 2026 14:33:32 +0800 (CST)
X-RM-TRANSID:2ee76af55dbaba0-df60f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af55dbbd68-f5292;
	Thu, 12 Nov 2026 14:33:31 +0800 (CST)
X-RM-TRANSID:2eea6af55dbbd68-f5292
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net] ipv4: igmp: report IFA_TARGET_NETNSID in multicast address dumps
Date: Thu, 12 Nov 2026 14:33:11 +0800
Message-Id: <20261112063311.75767-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <avUMkYmCtkwNYf8_@fedora>
References: <20261111082222.327963-1-sunwenbo@cmss.chinamobile.com> <avUMkYmCtkwNYf8_@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Hangbin,

Thanks for the review and the helpful suggestion.

On Thu, Nov 12, 2026 at 08:47:13AM +0800, Hangbin Liu wrote:
> On Wed, Nov 11, 2026 at 04:22:22PM +0800, Wenbo Sun wrote:
> > Commit eb4e17a1d915 ("netlink: support dumping IPv4 multicast addresses")
> > extended RTM_GETMULTICAST to support dumping IPv4 multicast addresses.
> > While inet_valid_dump_ifaddr_req() accepts IFA_TARGET_NETNSID in dump
> > requests and dumps addresses from the target network namespace,
> > inet_fill_ifmcaddr() never puts IFA_TARGET_NETNSID in the netlink
> > replies.
> ...
> > Fixes: eb4e17a1d915 ("netlink: support dumping IPv4 multicast addresses")
>
> I don't think this should be fix. Maybe consider this as a new feature and
> target to net-next?

You're right. While eb4e17a1d915 reused inet_valid_dump_ifaddr_req()
for dump requests, inet_fill_ifmcaddr() never emitted IFA_TARGET_NETNSID
from the start, so this is not a regression. Adding IFA_TARGET_NETNSID to
IPv4 RTM_GETMULTICAST dump replies (alongside setting fillargs.netnsid = -1
in inet_ifmcaddr_notify() to preserve the preallocated skb size) is better
framed as a consistency/feature alignment with inet_fill_ifaddr(),
inet6_fill_ifmcaddr(), and dev_mc_fill_addr().

I will drop the Fixes tag, soften the commit message accordingly, and
repost this as [PATCH net-next v2] in a new thread once the 24-hour
resubmission interval has elapsed.

Thanks,
Wenbo


