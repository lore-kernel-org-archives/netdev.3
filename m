Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9FA448389;
	Fri, 31 Jul 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514219; cv=none; b=EuIsLTrA1xlzN+0tcDVEJGY2PBARUrKUD0DR8dfhF0CvcNDx8LEH+IVgo0xBoYdbEEp9hCE0iWlcldrC4NPqMXf1qIQFK7CRztnNlcLGWfNKtacLRvbjJH341rN57PTbNreFZzwwpUC8wXGMQCf/kZqhYsWnKM7/WbHaYvRfZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514219; c=relaxed/simple;
	bh=KLAYvAb1NHbZKz6ILdmJ27WSUk7H/DXlgI2AYiv7Lj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrApDVHewfEXLOBvQwKgCPUOsogsReCdlP7o6zv53MGFmK3zv2HKX2ty3VukR8YONWvs297+Om8LNuX4UUqsSrV2zvsW8guFZpShmF4xLS9H3I3DRr30qo+chGa09iwsYML4jjrJDt0gUHT17sIZr54PYaQDArAchRTRQhfGU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=PG2WfRbA; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=PG2WfRbA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="PG2WfRbA";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="PG2WfRbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514216;
	bh=KLAYvAb1NHbZKz6ILdmJ27WSUk7H/DXlgI2AYiv7Lj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PG2WfRbA7xVpSb7a6Nzok3v4yGCBX+UBavwArlrDOaaotzs4EJsU+WhPJw9mwFSmL
	 q/M381jyD8DiIL4LBxbjuygsyY4EeaedVoUCw6PPMdFMeOqb3Us5bZwE8FzttX0c9v
	 l85tTo2cJpI6zTU6bJlwN7T6iDTtW5MrxWM0GrYsNTx4RSgfpH6gZCLJevmZHS9kHW
	 k3zu4JtTw+58H44vFHKXiibfg2P4JVqWacM0/WHJ5wTwsKKENS4QyUHOH98Q2LVux9
	 bi28DohY4vyS8AIqAZWZSjSqmN85Xx1fKB5eV3+NgdR5fshYm6nOsmv5vb/DjEQN36
	 4gqNZyAUNQOwg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id CDFB9494F5; Fri, 31 Jul 2026 16:10:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514216;
	bh=KLAYvAb1NHbZKz6ILdmJ27WSUk7H/DXlgI2AYiv7Lj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PG2WfRbA7xVpSb7a6Nzok3v4yGCBX+UBavwArlrDOaaotzs4EJsU+WhPJw9mwFSmL
	 q/M381jyD8DiIL4LBxbjuygsyY4EeaedVoUCw6PPMdFMeOqb3Us5bZwE8FzttX0c9v
	 l85tTo2cJpI6zTU6bJlwN7T6iDTtW5MrxWM0GrYsNTx4RSgfpH6gZCLJevmZHS9kHW
	 k3zu4JtTw+58H44vFHKXiibfg2P4JVqWacM0/WHJ5wTwsKKENS4QyUHOH98Q2LVux9
	 bi28DohY4vyS8AIqAZWZSjSqmN85Xx1fKB5eV3+NgdR5fshYm6nOsmv5vb/DjEQN36
	 4gqNZyAUNQOwg==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CD7A5494ED;
	Fri, 31 Jul 2026 16:10:15 +0000 (UTC)
Message-ID: <76b95edb-88eb-4297-8979-6577a0f0f9a6@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:10:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/13] ax88179_178a: Use MMD accessor
 functions for AX88179A
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>
 <6cbd0d83-9802-4e02-ba1b-4cf76cb51659@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <6cbd0d83-9802-4e02-ba1b-4cf76cb51659@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 18:44, Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 09:36:46AM +0200, Birger Koblitz wrote:
>> The AX88179A uses a much simpler Clause-45 MMD access interface,
>> which are made available through ax_read_mmd() and ax_write_mmd(),
>> which in turn call the chips' respective implementation.
>>
>> Make use of these functions for stract MMD read/write operations.
>>
>> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
>> ---
>>   drivers/net/usb/ax88179_178a.c | 39 +++++++++++----------------------------
>>   1 file changed, 11 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
>> index b90a75a11024c58192bdb4a9436636bc9312148c..b7837c7a89f9b5ee520ef1ae91bbc7619d1a12bd 100644
>> --- a/drivers/net/usb/ax88179_178a.c
>> +++ b/drivers/net/usb/ax88179_178a.c
>> @@ -985,22 +985,19 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
>>   	int val;
>>   
>>   	/* Get Supported EEE */
>> -	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
>> -					    MDIO_MMD_PCS);
>> +	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
> 
> All these look to be standard EEE registers. phylib should be handling
> this for you. Put a printk in genphy_c45_read_eee_cap1() and make sure
> it is being called.
> 
> Basically, anything which is part of 802.3 clause 22 or clause 45
> should have helpers in phylib, and in most cases, phylib itself will
> take care of it. A MAC driver touching the PHY is generally a bad
> design, a layer violation. So any driver using phylink or phylib, all
> direct access to the PHY needs to be removed.
> 
Fixed in v4 by directly using phy_ethtool_get_link_ksettings
and phy_ethtool_set_link_ksettings

Birger
