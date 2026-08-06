Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6B2E54D1;
	Thu,  6 Aug 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044740; cv=none; b=aL7gIgdMFGdLkDCb9YIUntAXuVWftf+bdWwTZ6ZdRKP5fqPoeMqjzeb9dWrkBl+RJ3nb7TC2m1wEGc+9v5kdbrrhHVZxxE3F8N/k1o3+bGFOy94V17W+dLpzlgDomZNejj1mll2m8kZU4IYsXlv2bfw22FIB3DNPiLPNVKBx8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044740; c=relaxed/simple;
	bh=3KzeiQa+hZqeTYB1Gm3m7fHbxkQO+WwPhVCyaF0zGg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOAAtWjTrgSoPTzYpwM6qGUDCtIkzXCtzC42LvBld8Gxx4soeqi6KzVRcP4P0BxyfNIKyliH9xNVysvrjqsLR2yV7ygfXNiAr2VHMHRy1wpXDkYiTeXWwxtoSHjXF0iHtmTLUGmBLMg2ZZ9BaJ7AfXOlB8goKW7zSz8hC3QTQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tAxnX+Lx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wQhaKFi3; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tAxnX+Lx";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wQhaKFi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044730;
	bh=3KzeiQa+hZqeTYB1Gm3m7fHbxkQO+WwPhVCyaF0zGg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tAxnX+LxEJLULeSmCzDYjHtyuShf3QRNvOsyDNcQx6lyiUH0MXIaKY7+Eq/Ffs5HL
	 Okh0NpwUuHwbsSr0NBTNkk9US8dimwKpmZgcB9znEljX35j/V/2XqmovbHrlZ/IpLY
	 DwWVM7P8mAqWvaxGG/th3OMutFHbxFnKcTeJp+tmwn9fmzvalgWthYodoAeCafwB95
	 RSuzmuJ5D2srebIwa5BrKuNMGr1BRClTituC/Xk/pbeSmbeuPkCrSwMaLDqDbkdX+Q
	 3OomvLylHPA0dr012hBuwnhJ2Qb7P2X5C5PLvtl0/pw1kEuEy0RPLhMbpUs55QJcz5
	 edwTccW1cvN4A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 36F29496FB; Thu,  6 Aug 2026 19:32:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044727;
	bh=3KzeiQa+hZqeTYB1Gm3m7fHbxkQO+WwPhVCyaF0zGg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wQhaKFi3Hn3wZpfQ+zgT+x3CzIrR+sW1TD1v4iXMUin78tcSCF/2FADmFRiJUupn2
	 xiuCDFe6fePWS3LNjAiS3wKAJZZZJteaXOtqoYzEH8/Eh6VUPb3J1DIcZE5PLKuWdS
	 VJg5GhGfopxeT5cRCDMXpVvdA1d+VAgGY8HOUCMkrEf/WpEqrqg/K1eTqwTCfP9sIa
	 bg9FWaSjnXWG1SAdfYkr3HgwZgT0otlGR/bq+in9R5FMekGKEzePRQefJgwxgXytFu
	 8dL5Bt4QnJwavfP/KQ9uFuGe3R76WIagFyAAvusaDVsVZblt+CqbmTA6PCAGeBOYlT
	 O/CLZYJXJuV4A==
Received: from [10.30.1.58] (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 58662496F2;
	Thu,  6 Aug 2026 19:32:07 +0000 (UTC)
Message-ID: <3a2f6485-191f-4926-aab8-636bd168fc8f@birger-koblitz.de>
Date: Thu, 6 Aug 2026 21:32:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>
 <b6c5b109-a999-43ac-b4f1-14007e7b3387@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <b6c5b109-a999-43ac-b4f1-14007e7b3387@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/08/2026 23:28, Andrew Lunn wrote:
> This is more of a nitpick, given how much work you have already done
> on this driver. I think designated initializer syntax could make this
> more readable:
> 
> num ax_bulk_in_speeds {
> 	BULK_IN_SPEED_1G_SS = 0,
> 	BULK_IN_SPEED_1G_HS   = 1,
> 	BULK_IN_SPEED_100_FULL_SS = 2,
> 	BULK_IN_SPEED_100_HALF_SS = 3,
>   ...
> };
> 
> 
>> +static const struct ax_bulkin_settings AX88179A_BULKIN_SIZE[] = {
>   [BULK_IN_SPEED_1G_SS] = {5, 0x7B, 0x00, 0x17, 0x0F},
>   [BULK_IN_SPEED_1G_HS] = {5, 0xC0, 0x02, 0x06, 0x0F},
> 
>> +static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
>> +{
>> +	struct ax88179_data *ax179_data = dev->driver_priv;
>> +	const struct ax_bulkin_settings *bulkin_data;
>> +	int index = 0;
>> +
>> +	switch (ax179_data->speed) {
>> +	case ETHER_LINK_2500:	/* AX88279 only */
>> +		index = BULK_IN_SPEED_2500;
>> +		break;
>> +
>> +	case ETHER_LINK_1000:	/* AX88279 & AX88178A */
>> +		if (ax179_data->chip_version == AX_VERSION_AX88279) {
>> +			if (link_sts & AX_USB_SS)
>> +				index = BULK_IN_SPEED_1G_SS;
>> +			else if (link_sts & AX_USB_HS)
>> +				index = BULK_IN_SPEED_HS;
> 
> This removes the 1, 2, 3, etc making the relationship more obvious.
> 
Will be done in v6. And the change even allows to remove the above
dependencies on the chip versions in ax88179a_bulkin_config(), since
the different ax_bulkin_settings structures no longer need to start at 0
index. Much more than nitpick!

Birger

