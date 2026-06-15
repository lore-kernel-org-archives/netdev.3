Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414D155757
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487666; cv=none; b=eRa1T/CAwWgXQ6MCSbf92HwViGzcbQOYckVaWcezFj8/DdHZQTHYW974QlsEflhqLnscG9BpnN8OJZhzYX4Pina87CrfKERMWKgBsrp0yzxA93Y0Wqdg3rbANVinjXMzbsJi9asJC3riYd+bJiAffCwf/t4jLyxV9SWshd/FXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487666; c=relaxed/simple;
	bh=tL22lFV/p6qljk7tMljJ0+hqT64iKX7IAbGQ19Zwuls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pn7tcPZOh5cOpS+XfqzHBw/TIfMSwZkkSo7JguUKxo/GE63dgP252ErIDxzSJ47if4yHriqydK47wPNsJFr/fUxfI04wYcua0Xjsy7sUuIKcDbjRfg1LfARau9yYZdCD0D75Xl7s4yFkVawNGCbyVcZDD+P6O56UOIP5wi7dsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jj/zqXFe; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jj/zqXFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rkSJZJv6R0h/oeGm4YkXS/z977/uuGVq+lopNuX2gt8=;
	b=jj/zqXFeTA0dWoN//f2z6vDL56BJfsqUUHvoSLib3FVpIsC85nYvjxKWoelmNX
	YwtnMDtWfd1i5QA364AKIP5ThuhMyli8owciGFTPiUQp265WAllpu4cvlr1f7DpO
	8rLYacTySYS97WF8/k8W68F7likyHtbeTiFE7hmGjvj2o=
Received: from [10.42.20.136] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnZ5caWC9q21ylDg--.7092S2;
	Mon, 15 Jun 2026 09:40:43 +0800 (CST)
Message-ID: <9d3dfe98-676f-4a85-9e85-241f79ecfaea@163.com>
Date: Mon, 15 Jun 2026 09:40:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Content-Language: en-US
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Rongguang Wei <weirongguang@kylinos.cn>
References: <20260612080331.120096-1-clementwei90@163.com>
 <PH0PR11MB590263784927AAB47EE558BAF0182@PH0PR11MB5902.namprd11.prod.outlook.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <PH0PR11MB590263784927AAB47EE558BAF0182@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnZ5caWC9q21ylDg--.7092S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4xZFW3WryfWF4xJFykAFb_yoW8Cr1Dpr
	WUCa4DCr4UWr9Fga97Xw18ZF90k392qrWruF4fCw1Yg3s8JrWktr1xtF4UGryavw47C3y3
	JF1Yv3ZxA3Z8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uca9-UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4huC7WovWBvqpgAA3c



在 2026/6/12 16:58, Jagielski, Jedrzej 写道:
> From: Rongguang Wei <clementwei90@163.com> 
> Sent: Friday, June 12, 2026 10:04 AM
> 
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> The phy_data variable is not initialized. If e1000_read_phy_reg
>> returns an error, phy_data will not point to a valid value from
>> the PHY register, which may cause the regs_buff array to be populated
>> with unexpected values.
> 
> Hi,
> 
> Sounds like a fix, but i believe we would like to have any real
> scenario when the issue occurs and how it can be reproduced.
> If such is provided please target the patch against net tree and
> add fixes tag.
> 
Hi,
I was not face a real scenario. I just found out there is no check for 
e1000_read_phy_reg return value when I reading the driver code. 
Maybe is better to initialized the value or check the return value of e1000_read_phy_reg.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d
> 
> 
> i doubt this is a correct kernel commit tag
> 
>> ---
>> drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> index 4dcbeabb3ad2..f068108c5004 100644
>> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>> 	struct e1000_adapter *adapter = netdev_priv(netdev);
>> 	struct e1000_hw *hw = &adapter->hw;
>> 	u32 *regs_buff = p;
>> -	u16 phy_data;
>> +	u16 phy_data = 0;
>>
>> 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
>>
>> -- 
>> 2.25.1
> 

