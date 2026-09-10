Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA1368D52;
	Thu, 10 Sep 2026 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005072; cv=none; b=IzXpJAjcIgrCul8m3zVE+NW3Hjh4RdLlZIeGOgd5k6VfFcICRNbiYYMPHGh6QofKkbaRQloInuFvj8i4VcdteZq+cSQ1NaG/bSul0K2uCRRg9YQLCGe0LQ23cadZU8j2zdbCwC3n2otRIf21GK11YHAHG+UkY3/ZVcNbEHmQQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005072; c=relaxed/simple;
	bh=tzLNyfownMZjYU6v57iC3Uf3r2zJVaIL0tInN+NNvFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfZ/H096js0M0Unufp/QvZ7BkvB5tmrtfOdsL5ncCViFFqYFY97uzjXVZZuD8lvzsJLF3K8I7UVZeQsDhVr/K7TtOxbQmAmT9k8XpfCSVN2jrcKmASxx3nnb9k6CxiCUSsZeuDBVtU957W7LNB8Km7d+zrBMZGwQLGYxAvaA7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07938847|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0324629-0.00116868-0.966368;FP=5338738741604404410|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jA.hkM7_1789005056;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jA.hkM7_1789005056 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 09:50:58 +0800
Message-ID: <5e492c8b-1afa-4af8-8f66-9b50799911e4@motor-comm.com>
Date: Thu, 10 Sep 2026 09:50:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
To: Andrew Lunn <andrew@lunn.ch>, David Yang <mmyangfl@gmail.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
 <20260908083614.2210505-7-kyle.switch@motor-comm.com>
 <CAAXyoMMLpaD5B4QojC0OKHxOFfPfFGpsS2nxCMT9e=nJeo8beg@mail.gmail.com>
 <0aa20394-2042-4c52-b30b-cdd742d4da65@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <0aa20394-2042-4c52-b30b-cdd742d4da65@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/26 01:32, Andrew Lunn wrote:
>>> +/**
>>> + * Initialize serdes configuration based on interface mode.
>>> + */
>>> +static int yt922x_sds_init(struct yt921x_priv *priv, int port,
>>> +                          phy_interface_t interface)
>>> +{
>>> +       int addr;
>>> +       u16 data;
>>> +       int res;
>>> +
>>> +       addr = yt922x_sds_phyaddr_get
>>> +               (port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
>>> +                YT922X_PHY_REG_SPACE_SGMII);
>>> +       if (addr < 0)
>>> +               return -EINVAL;
>>> +       /* write protect */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
>>> +       if (res)
>>> +               return res;
>>> +       /* CDR */
>>> +       if (interface == PHY_INTERFACE_MODE_100BASEX) {
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
>>> +               if (res)
>>> +                       return res;
>>> +       } else {
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
>>> +               if (res)
>>> +                       return res;
>>> +       }
>>> +       /* PLL */
>>> +       if (interface == PHY_INTERFACE_MODE_USXGMII) {
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070);
>>> +               if (res)
>>> +                       return res;
>>> +       } else {
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x43d, 0x207d);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x43c, 0x207d);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3032);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x6);
>>> +               if (res)
>>> +                       return res;
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070);
>>> +               if (res)
>>> +                       return res;
>>> +       }
>>> +       /* VCO */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x439, 0xC0);
>>> +       if (res)
>>> +               return res;
>>> +       /* Vdac */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x491, 0x7f);
>>> +       if (res)
>>> +               return res;
>>> +       /* Eye */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x454, 0xf14);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x497, 0xa44);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4cd, 0x0);
>>> +       if (res)
>>> +               return res;
>>> +
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e3);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x48a, 0xfff);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x408, 0x7c00);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4d6, 0x7f);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x44f, 0xff08);
>>> +       if (res)
>>> +               return res;
>>> +       /* FFE */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x48e, 0x7d00);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0xd, 0x60f);
>>> +       if (res)
>>> +               return res;
>>> +       /* CTLE */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4b0, 0x804);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4b1, 0x7774);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e7);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x3, 0x5603);
>>> +       if (res)
>>> +               return res;
>>> +
>>> +       msleep(20);
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7fff);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
>>> +       if (res)
>>> +               return res;
>>> +       /* CTLE */
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x2000, 0x40);
>>> +       if (res)
>>> +               return res;
>>> +       res = yt921x_intif_ext_write(priv, addr, 0x2000, 0x0);
>>> +       if (res)
>>> +               return res;
>>> +
>>> +       if (interface == PHY_INTERFACE_MODE_SGMII) {
>>> +               res = yt921x_intif_ext_write(priv, addr, 0x1042, 0x48c);
>>> +               if (res)
>>> +                       return res;
>>> +       }
>>> +       /* soft reset */
>>> +       addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
>>> +                                     YT922X_PHY_REG_SPACE_SGMII);
>>> +       if (addr < 0)
>>> +               return res;
>>> +       res = yt921x_intif_read(priv, addr, 0x0, &data);
>>> +       if (res)
>>> +               return res;
>>> +       data &= ~(1 << 15);
>>> +       res = yt921x_intif_write(priv, addr, 0x0, data);
>>> +       if (res)
>>> +               return res;
>>> +       addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
>>> +                                     YT922X_PHY_REG_SPACE_USXGMII);
>>> +       if (addr < 0)
>>> +               return res;
>>> +       res = yt921x_intif_read(priv, addr, 0x0, &data);
>>> +       if (res)
>>> +               return res;
>>> +       data |= 1 << 15;
>>> +       res = yt921x_intif_write(priv, addr, 0x0, data);
>>> +       if (res)
>>> +               return res;
>>> +
>>> +       return 0;
>>> +}
>> No one else, except you, can maintain this stuff. Drop it for now and
>> discuss it later.
> There also appears to be similar magic in the PHY driver. Can this be
> consolidated?

Ans: This part of the initialization is for the switch SerDes, so from my

side it may be hard to consolidate.As mentioned in David's email,

if we're not considering switch SerDes performance for now and are

only concerned with DSA driver functionality, we can temporarily

remove this part of the initialization configuration.

> 	Andrew
