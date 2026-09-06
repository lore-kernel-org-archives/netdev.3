Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055D5B5AB;
	Sun,  6 Sep 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659290; cv=none; b=mp28FRMNPHatS3hL7PAzfVsP1MXjDeGuVKAqatDxe8ioB5iPSWwLBorI2hrSFp5LnZt9r00ue0HG0e6hAaI9qEQBHIzM4vMmsBZrezuy3+TYsNjguSBcIYZE7XW/RiuC0DW0EIWUkqP9b2gl1YozWMdIL0l4xj8X1Np2Fu3+SaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659290; c=relaxed/simple;
	bh=RwpScbY6iLeL8kts5z6BRmCTg4rrhEjhACAcWvOU8ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ps6Qdl7HVzGG79OARM5f7wiaZtGhW5ZLuT/527coCLJvgm80gwWB+EiH26av1ERdolk4e6oYkrN6CDDZLiMy9XC4w/snLYyWw3bmXVMEsXM/INDKkXXgSWLJ0f4WR1kM8qYYZXHauZGgv7eHyiwn3A318zTUqA7HO50y95P013s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1130755|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0468906-0.00146128-0.951648;FP=7923826060246824710|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j6ix7UJ_1788659275;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j6ix7UJ_1788659275 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 09:47:58 +0800
Message-ID: <5f366761-28e9-40da-90dd-baf6d8fa7502@motor-comm.com>
Date: Sun, 6 Sep 2026 09:47:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/6] net: dsa: motorcomm: use max_ports from
 series_info for port bounds checking
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-2-kyle.switch@motor-comm.com>
 <74410f94-cc37-48b8-8118-5fe45fc3fcd2@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <74410f94-cc37-48b8-8118-5fe45fc3fcd2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/26 21:32, Andrew Lunn wrote:
> On Fri, Sep 04, 2026 at 05:54:12PM +0800, Kyle Switch wrote:
>> Replace the hardcoded YT921X_PORT_NUM macro with the per-series
>> max_ports field in port validation. This removes family-specific
>> constants from the common code path and simplifies adding new
>> switch families with different port counts.
>>
>> No functional change for existing YT921X devices.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> Did you review your own patch? Don't you think it is now a lot easier
> to see this patch is correct, now that it is short, does one thing and
> have a commit message focused on just this change.

Ans: yes, by splitting patches so that each patch contains only

one functionality, it becomes more convenient and easier to review

the code logic and whether there are errors. We will follow a similar

approach going forward.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew
