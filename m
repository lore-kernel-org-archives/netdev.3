Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9801F4634;
	Sun,  6 Sep 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659664; cv=none; b=LyhHNwB1X+WBmuukDMv+CZPToP2xPn4ImdgsG/dqpNgB54lbNaacW0tF3b5Mo3mYprOIUn7UzZerJvDYaZMJNbZcQ7vcXaySH5JJJtfEibAwOq6/XW7R9cRUgF5yI2IL65+A9CnSsYf/D+WDcv+W4IJ+NYsw5kVE60msxTeC2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659664; c=relaxed/simple;
	bh=Aa6dBkobuG71w4nU/eQHUFahSYRWmmOCcwzhyCtzky0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oncOUtSPn1+kkHs8aswwxqYCZL0x1d2/EWbZmvgD/we39GFDjFzp9dTh0ixnY5fLPg67bBcVRs9zhVvAOz4DXKOiDAJW2BF+VEnn98KWyh9QmXC5tJLclIlh5+pC52nDMn6S0SU+oXNmy79WBmKFkH5DS5vruieCusJhVHO15x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1619376|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0160248-0.000302394-0.983673;FP=16997209193347725008|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j6gvkY5_1788659648;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j6gvkY5_1788659648 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 09:54:12 +0800
Message-ID: <8f3ba571-28f3-42da-9797-612589db0d07@motor-comm.com>
Date: Sun, 6 Sep 2026 09:54:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB polling
 initialization to dsa_setup()
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-3-kyle.switch@motor-comm.com>
 <69b0cc5b-0b67-4eec-89e3-b4c788febdbb@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <69b0cc5b-0b67-4eec-89e3-b4c788febdbb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/26 21:48, Andrew Lunn wrote:
> On Fri, Sep 04, 2026 at 05:54:13PM +0800, Kyle Switch wrote:
>> Move MIB polling start from probe() to dsa_setup()
> Actually, having thread the following patches...
>
> For every start, there is generally a stop.
>
> You move start from probe() to dsa_setup().
>
> Should you not move stop from remove() to dsa_teardown()?
> You want to keep the driver symmetrical.

Ans, yes, in the next version, we will optimize the handling

of MIB polling enable by moving into setup(), and remove MIB

polling disable into teardown(). From the current perspective, the

mib_init flag is no longer needed.

> 	Andrew
