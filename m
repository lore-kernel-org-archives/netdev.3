Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955547;
	b=gWdw3dlE/1n126zfIkX3EKKi5iG8u4jZ2ppsMuTBg9qSnzBxA1/02iRxOdW0lefnqHC0
	 djzdGY/Gkl42bhTuX7hbO/RGzQsW8/TzMrqkDuZt0GN+0aMgU/ECRn8uRJyHd7XcpHy5q
	 fJ9OCnIdf33k3qrW9UHlAiIwS3xusYqQDnUIXo1pnp5zboOYipOivYWIi6108zY/fbzwH
	 5EmyEaC1tS936CaZkqmNDZGHGo8f4vyShZGeOsfA8AZqWXPT+Yt4MkLvh0N1c62GQ/+1k
	 u4ivjHNS1K0zs4eCb8WjLg1ASeBk5AeOeHOjeNBdyumUbvAwNV+Vi3ULuKwCWBqM3zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955547;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MO8XPrss8e8D10gEPIl/eYSRHSXegn9/Cagna4MsP34=;
	b=ycw2OJdy2Ko2TA/HSQO2kSmUnTFVTDeLMpRdvoyJNfKeosNsDYDR+w5UPEEr9EqEStUU
	 OBXsYF18NfDnZ2t7gsg9W0jF3V2BjHdWz3zhcnDO7OLuKoLyHE6Ism4ti5qw9bmhvi2ed
	 BG4Jfc4DAjJOBecKHyeofOaOgZJzm3aRSmMaXENc76JR2LXi8NRajAUtVSVcbMBYCeOXl
	 l2MEaymqYAO31C64Nqir1hrrfYGYX/v4onGccdnZqNprngiI/1wYaRl2B4YCNeNMewp7z
	 nC1aN1Uukxfh7qyZmbXNKDkn1cTF/2t2jFeIftlt3RhN8RvBqriguqg/RllhkZJpXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=C9I1mFmM;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF49606A33A;
	Fri,  6 Nov 2026 08:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF49606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=C9I1mFmM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=C9I1mFmMExiwVoYIQJr3bAJ+rl5woD8bRXUy/clBstmqh57XNegcT6xXEAVppDJnPL9iklEdHOpkZ
	 I9Un1wGHn2BM5Di1R4HNBaF/fMJtKmnclx9o7VIMmyQkbofgdK3/4RSiGCLPXN8QVVgsRpSvdTEhsu
	 7I7vA41oXiW6KKCA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aed96d6f3e-7c8f9;
	Fri, 06 Nov 2026 16:59:03 +0800 (CST)
X-RM-TRANSID:2ee66aed96d6f3e-7c8f9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [192.168.229.154] (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aed96d4ca6-1a1f5;
	Fri, 06 Nov 2026 16:59:03 +0800 (CST)
X-RM-TRANSID:2ee56aed96d4ca6-1a1f5
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David S. Miller <davem@davemloft.net>,
 Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: Re: [PATCH net-next] net: dsa: hellcreek: fix device_node leak in
 hellcreek_led_setup()
Date: Fri, 06 Nov 2026 16:59:02 +0800
Message-ID: <1793955542000.6629.2266841121642210855@cmss.chinamobile.com>
In-Reply-To: <179395510331.488859.15134331933976267509@kernel.org>
References: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
 <179395510331.488859.15134331933976267509@kernel.org>
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
Content-Transfer-Encoding: 7bit

On 11/6/26 16:51, netdev-bot+sinfo wrote:
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Hi,

The leak was not hit at runtime. I found it by code inspection while
reviewing the OF node handling in DSA drivers, as the commit message
notes. There is no stack trace: the effect would be one device_node
reference leaked per probe and never released.

Thanks,
Xia Yan


