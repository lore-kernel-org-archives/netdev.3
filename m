Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094D3CF692;
	Sun, 18 Oct 2026 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792294001; cv=none; b=jSK12GvCWKVt6dUOb9J+6dc38IKxfZfCLLKyD6MZImM1yH95QRp+IdMlm1aBbhanaO8Gfzq1r2q0jaHG98/Mc/ewgKtrUaM1107zkGbSUmvbz88pApOPuDatKC0M3+Llc/tEGxPZrRlQSz0RegEzfg1bjxHCdvbpiy2E0LZQfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792294001; c=relaxed/simple;
	bh=LXuTywJkxC4gtM82Mi/IluKJrjysWKZuSgCoMvMJVnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mToC4uZNeQ1Ram44XkLiJsz5UiJkQSe4nSpNfmV6zsA/albaApZMQNPL+Moa87ravy8LAHE+GDoR2X6b3VJvlkRCPA9PPCExAQaNW9jPkfuwicQ6w5L883+51R4OxoqugnXJvRwiq9L3IWoBuNmUvIvVonk5w8d1H6dfhGyd8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09685749|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0250378-0.000441063-0.974521;FP=12062793681018211984|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jicI1xN_1792293981;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jicI1xN_1792293981 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 18 Oct 2026 11:26:24 +0800
Message-ID: <7701a2c8-e945-489d-993b-d872d7852fce@motor-comm.com>
Date: Sun, 18 Oct 2026 11:26:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
 <20261013011122.1889766-4-kyle.switch@motor-comm.com>
 <CAAXyoMMw5ygXT7vO-GWWodY1HRuf+SgyfcaLenqnUGUvjTxjOg@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMMw5ygXT7vO-GWWodY1HRuf+SgyfcaLenqnUGUvjTxjOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/17/26 03:38, David Yang wrote:
> On Tue, Oct 13, 2026 at 9:11 AM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>> @@ -36,19 +36,19 @@
>>   static const struct yt921x_info yt921x_infos[] = {
>>          {
>>                  "YT9215SC", YT9215_MAJOR, 1, 0,
>> -               GENMASK(4, 0),
>> +               GENMASK_U16(4, 0),
>>                  BIT(9),
>>                  BIT(8) | BIT(9),
>>          },
>>          {
>>                  "YT9215S", YT9215_MAJOR, 2, 0,
>> -               GENMASK(4, 0),
>> +               GENMASK_U16(4, 0),
>>                  BIT(9),
>>                  BIT(8),
>>          },
>>          {
>>                  "YT9215RB", YT9215_MAJOR, 3, 0,
>> -               GENMASK(4, 0),
>> +               GENMASK_U16(4, 0),
>>                  BIT(8) | BIT(9),
>>                  0,
>>          },
>> @@ -66,13 +66,13 @@ static const struct yt921x_info yt921x_infos[] = {
>>          },
>>          {
>>                  "YT9218N", YT9218_MAJOR, 0, 0,
>> -               GENMASK(7, 0),
>> +               GENMASK_U16(7, 0),
>>                  0,
>>                  0,
>>          },
>>          {
>>                  "YT9218MB", YT9218_MAJOR, 1, 0,
>> -               GENMASK(7, 0),
>> +               GENMASK_U16(7, 0),
>>                  BIT(8) | BIT(9),
>>                  BIT(8) | BIT(9),
>>          },
>> @@ -3741,7 +3741,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
>>          if (res)
>>                  return res;
>>
>> -       ctrl = GENMASK(10, 0);
>> +       ctrl = GENMASK_U32(10, 0);
>>          res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
>>          if (res)
>>                  return res;
> The change below is fine, but the ones above aren't, the width is
> already pinned by the variable being assigned to. Also DSA expects u32
> port masks to some extent, those add unnecessary changes if you want
> to change port masks in yt921x_info to u32 some day.

you're right,  It may work for the current definition, but it's not

conducive to future expansion. In future series, there will be 
multi-port scenarios.

will be fixed in next patch version.

>
>> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
>> index 83f0212551ff..3aa1111efaa4 100644
>> --- a/drivers/net/dsa/motorcomm/mdio_bus.c
>> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
>> @@ -159,7 +159,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
>>          mbus->write = yt921x_mbus_int_write;
>>          mbus->parent = dev;
>>          max_ports = priv->series->max_ports;
>> -       mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
>> +       mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);
>>
>>          res = devm_of_mdiobus_register(dev, mbus, mnp);
>>          if (res)
>> --
>> 2.25.1
>>
