Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3E37E5CF
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550769; cv=none; b=BrJnudtzTxPgZsEuP6iTqW015Li9e0F2sYa7CIQc8RF/L7gESuIYXVso22mZ/D7IKCkZmd2tAmizS9fSxNpozjncz4ACI4VCVHZS7RRmpueD0jFKnOxEFYc5AjInbW/OEHDpayonWYuZh3WkC+VpS0MsqwZbmiyIwZX7vjn+Ai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550769; c=relaxed/simple;
	bh=0sLq+mb8NNIfQ6TWGK3tdYy1TSN+EMEiubeQ4dG/GCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JErNxRjIDEfFCoEWy6nT3JL+emCQyaH+9Il/oK3kn2jcW7159vqsAItUr/NGp0lPIuEWdhpY/1iz6dvJNfOKg5OTczIUDxIQ1HP7iaNLhgYKSxgHOjgcU8+2bwu116HqKurAIuNTEWf6mlMWGRYbDKwhc6T4v1R4SPyTND7Q1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BujEgxi3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BujEgxi3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 913D21A15C5;
	Wed, 12 Aug 2026 16:06:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F6F76045E;
	Wed, 12 Aug 2026 16:06:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1AA1011C4D16B;
	Wed, 12 Aug 2026 18:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786550758; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AAf9WcD5U5rcXNEgPdOeLeYZObFyFgmjHwp/FwU/tAk=;
	b=BujEgxi3vMH2rRdMlmQb5SiY7pt77mVWhPBJBrnPLt+D/KIsUHdLq6k8kYLeu1VAxM38+N
	gInF92XmQKbM+6XRR8vizypUuIUGVN94flkcZnE+euU/RYFpJ70GDS+27vc8YGQj8gfT11
	f7g7mH0HCHAkDfXRod1zoCTEBwx5O3nDbArY/e6rKnFQxDle1vFYbjT4RY68Q1o3EA1x0p
	yWkvQBbaVMKAWf7e7JnskdyyoaB1JQe3Pjte1AEZalBRC6LWzCkQgHWfNhDJq1u54VOMfh
	EAx0AmhqLf2KXY452RYIREmP/JiuR/KUZwCSBScrN6t5oL3bMhdYQFkpntGgOA==
Message-ID: <a959dc2d-6f41-4c9b-9363-52c8edfcd85f@bootlin.com>
Date: Wed, 12 Aug 2026 18:05:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: split phy_probe() error paths
To: Andrew Lunn <andrew@lunn.ch>, Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
 <20260812125127.106255-2-xuanqiang.luo@linux.dev>
 <46ae1474-5abd-4908-9955-a364ec3e2f99@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <46ae1474-5abd-4908-9955-a364ec3e2f99@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/12/26 15:41, Andrew Lunn wrote:
> On Wed, Aug 12, 2026 at 08:51:26PM +0800, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> phy_probe() uses one cleanup path for failures at every initialization
>> stage. This runs cleanup for resources that have not been initialized
>> and leaves phy_setup_ports() relying on its caller to remove an SFP
>> upstream after a partial failure.
>>
>> Make phy_setup_ports() unwind the SFP upstream before removing its ports.
>> Then split the phy_probe() cleanup so each failure path unwinds only the
>> resources that may have been initialized.
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>  drivers/net/phy/phy_device.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 0615228459ef4..f8e434daab66e 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3556,6 +3556,9 @@ static int phy_setup_ports(struct phy_device *phydev)
>>  	return 0;
>>  
>>  out:
>> +	sfp_bus_del_upstream(phydev->sfp_bus);
>> +	phydev->sfp_bus = NULL;
>> +
>>  	phy_cleanup_ports(phydev);
>>  	return ret;
> 
> This does not look correct. phy_sfp_probe() may fail, and you then
> call sfp_bus_del_upstream() on something which never happened.
> 
> Also, it is not obvious that sfp_bus_del_upstream() is the correct
> thing to do. You are trying to undo phy_sfp_probe() so i would expect
> you to call a function like phy_sfp_release().

I agree with having phy_sfp_release(), we have even more to do with phy SFP
in the future with phy_port, this is less error prone.

> 
> It also looks like phy_sfp_probe() does not correctly clean up on
> phy_setup_sfp_port() returning an error. But that is a different
> issue.

In practise, this is cleaned in the phy_probe's "out" failure label,
but indeed this is not pretty.

Maxime

