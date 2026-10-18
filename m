Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A7348C76;
	Sun, 18 Oct 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292594; cv=none; b=KazyWkIVrSAzaxvoTuQI14XtDxl+Ew+2xxS7fdo19Dp+J6mfv2PJ+7KM8ASYX1sWRgX0fQVWpEl9A5v6n37PY/sdE7fj1D0XfozOMgsNba6d7itOC4wM+Ht2lvVggYMyWgHs+4r3OAVH1v8wHg6xL8zQKC9IHbIF6wbZrwsxDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292594; c=relaxed/simple;
	bh=0KkuGVnbhsWfcdabm/htUrm/DqxpcuxDQZ4lojf2pUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbK/m9coO1QdjjuPAbEjVRR6k1NT5k2j/RXKrnHdKoiUkJE31hJBLTFuu7HUGElsH0fVoK+OFqNxTTbLfwnTx8moGI0g6i0PBE+adHTJVXRRuumVbEs7PM0t0sPocXUrq3RYIyYGL6ssvujvrhOWEmsu4XiviBAuWQYyArVSWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07857046|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00559226-0.000243516-0.994164;FP=11709099924969983668|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jie8pT0_1792292573;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jie8pT0_1792292573 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 18 Oct 2026 11:03:01 +0800
Message-ID: <b4e5b68e-2ece-4007-bd47-e6432ce70d9a@motor-comm.com>
Date: Sun, 18 Oct 2026 11:02:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
 <20261013011122.1889766-6-kyle.switch@motor-comm.com>
 <CAAXyoMPeOmMZ8u=+S9=W=aJ0riSRbkBX9afrcVdfrE4BreO-Hw@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMPeOmMZ8u=+S9=W=aJ0riSRbkBX9afrcVdfrE4BreO-Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/17/26 04:15, David Yang wrote:
> On Tue, Oct 13, 2026 at 9:11 AM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>> +/* yt922x register lists */
> The indents below look inconsistent. Please adjust to match the existing macros.
Okay.
>
>> +#define YT92XX_PAGE_SELECT     0x1e
>> +#define YT92XX_PAGE            0x1f
>> +#define YT922X_PORTn_STATUS(port)      (0x80200 + 4 * (port))
>> +#define  YT922X_PORT_LINK_STATE                        BIT(8)
>> +#define  YT922X_PORT_LINK_DUPLEX               BIT(7)
>> +#define  YT922X_PORT_RX_FC_EN                  BIT(6)
>> +#define  YT922X_PORT_TX_FC_EN                  BIT(5)
>> +#define YT922X_PORT_SPEED_10           0
>> +#define YT922X_PORT_SPEED_100          1
>> +#define YT922X_PORT_SPEED_1000         2
>> +#define YT922X_PORT_SPEED_10000                3
>> +#define YT922X_PORT_SPEED_2500         4
>> +#define YT922X_PORT_SPEED_5000         5
> Leftover from yt921x_speed.
will be removed and use the macros defined earlier in 921x.
>
>> +/* ISO */
> The comments here (and below) did not provide much information beyond
> the code itself.
>
okay, will remove meaningless code comments.
>> +#define YT922X_PORTn_ISOLATION(port)   (0x4 * (port) + 0x180d80)
> (0x180d80 + 4 * (port))
Okay.
>
>> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
>> index 3aa1111efaa4..a4cb74d0fd90 100644
>> --- a/drivers/net/dsa/motorcomm/mdio_bus.c
>> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
>> @@ -299,3 +299,42 @@ int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>>
>>          return 0;
>>   }
>> +
>> +/* intif extend register read/write api */
>> +int
>> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
>> +{
>> +       int res;
>> +
>> +       if (port > priv->series->max_ports)
>> +               return -ENODEV;
>> +
>> +       res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
>> +       if (res)
>> +               return res;
>> +
>> +       res = yt921x_intif_write(priv, port, YT92XX_PAGE, val);
>> +       if (res)
>> +               return res;
>> +
>> +       return 0;
>> +}
>> +
>> +int
>> +yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
>> +{
>> +       int res;
>> +
>> +       if (port > priv->series->max_ports)
>> +               return -ENODEV;
>> +
>> +       res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
>> +       if (res)
>> +               return res;
>> +
>> +       res = yt921x_intif_read(priv, port, YT92XX_PAGE, valp);
>> +       if (res)
>> +               return res;
>> +
>> +       return 0;
>> +}
>> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.h b/drivers/net/dsa/motorcomm/mdio_bus.h
>> index e79b725d435b..513a8d2d7618 100644
>> --- a/drivers/net/dsa/motorcomm/mdio_bus.h
>> +++ b/drivers/net/dsa/motorcomm/mdio_bus.h
>> @@ -50,5 +50,7 @@ yt921x_intif_modify(struct yt921x_priv *priv, int port, int reg, u16 mask,
>>
>>   int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp);
>>   int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp);
>> +int yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val);
>> +int yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp);
>>
>>   #endif
> intif_ext_* should be placed right after intif_* (if they are still in
> mdio_bus).
okay.
