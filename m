Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06553B4EB2;
	Mon, 17 Aug 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951344; cv=none; b=IAl24ZRE95hRrE35uHLXIibeRnhP4hi6CUBne7NokOWhqXRFFQdGhjpZmfZ2ay6K/FT8Kn/wBftAlQ2NP076XtLyTY9PxmRtTpCnkeM44o9+FfGtLfwKTXE5B5I6Nse3T6s53ZF7BcBlK6QIeoZFuKYHo+RcwFlL0j7+iqIrI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951344; c=relaxed/simple;
	bh=r+JcW9APp5q+38H7W/b5ORSqUzjyckPUVwWpH2Jb5E4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDiboYAcYmu+QbGiunbSEvvZ0KxJicqXCPhVQ2hJTMZlMprLEAbjm23zjSa5cggHYfG492/R8ZqpnIDQaM55nKOuHgSatXYhYtcOJ24xmcTkzgCBrSxCW9SRM9VhfzhJeFc6QOxObnOiXZmeU09MWpdWmBTSS+YxCsoHiy1jqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=rxgy+h5M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="rxgy+h5M"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67H7LX5Q03741574, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1786951294;
	bh=uK2GvwiOjFvEFQQYrLD/cIwDWODcqpdqB02vqLl4ZAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rxgy+h5M/NZfG6pOKNgQX+ea61IKqNyYHH86kRTiQhBNbVYgUDYDYgmXcFo1mocuO
	 1jVYk7jAbTpzszfuTdHLnNIZWbBL698lO1k+DU1tuCnLQU3f5APoK9B7Tm+MQG16MW
	 BUoGJfK/IvYUveMnkbUDnnddGmxWmxPWRBMNVqDT82PgeGDlC6Iib0YDAhjg3wI0Lf
	 WtihxPwU3q9ccaX1hOeZqQYKmCW+NYhprSSDwlOaghxRyZvhzlFEwJZ8tvHA64TGxx
	 iBjveWNwygpsHcQFckSDYoDfYVOImA6TO0zODgk2215yesQlUjxjvwFtqpGBJt0BDl
	 NijGLHBeeGuPA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67H7LX5Q03741574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 15:21:34 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 17 Aug 2026 15:21:34 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Mon,
 17 Aug 2026 15:21:33 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Mohsin Bashir <mohsin.bashr@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v11 3/7] r8169: add support for new interrupt
 mapping
Thread-Topic: [PATCH net-next v11 3/7] r8169: add support for new interrupt
 mapping
Thread-Index: AQHdK4+DAzlcqd/n+kurx25NV1k9dradn+yAgAQwqEA=
Date: Mon, 17 Aug 2026 07:21:33 +0000
Message-ID: <eafe6576c61f4f79beca202479a69346@realsil.com.cn>
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
 <20260814015203.1328-4-javen_xu@realsil.com.cn>
 <cc106b5e-943d-445e-a48c-77af70e67e70@gmail.com>
In-Reply-To: <cc106b5e-943d-445e-a48c-77af70e67e70@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>
>On 8/13/26 6:51 PM, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> To support RSS, the number of hardware interrupt bits should match the
>> interrupt of software. So we add support for new interrupt mapping here.
>> ISR_VEC_MAP_REG is the hardware register to indicate interrupt status.
>> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>> Changes in v2:
>>   - no changes
>>
>> Changes in v3:
>>   - init index in napi_struct and get message_id from index
>>   - move rtl8169_disable_hw_interrupt_msix directly before the call to
>>     napi_schedule()
>>   - change the condition in rtl8169_request_irq when RTL_VEC_MAP_ENABLE
>>     enabled, use rtl8169_interrupt_msix
>>
>> Changes in v4:
>>   - remove flag tp->feature, replace tp->features & RTL_VEC_MAP_ENABLE
>>     with tp->irq_nvecs > 1, they are equivalent.
>>   - follow reverse xmas tree, in rtl8169_interrupt_msix(),
>>     rtl8169_poll_msix_rx(), rtl8169_poll_msix_tx(),
>>     rtl8169_poll_msix_other()
>>   - use napi->index in rtl8169_poll_msix_other()
>>   - add a comment to describe RTL8127 MSI-X vector layout
>>   - simplify r8169_init_napi()
>>
>> Changes in v5:
>>   - replace magic number in rtl8169_poll_msix_tx()
>>
>> Changes in v6:
>>   - when irq_nvecs <=3D 1, use register IntrMask_8125, else using vec ma=
p
>>   - fix irq sequence in rtl8169_interrupt_msix(), disable interrupts
>>     before clean it
>>   - remove dead code in rtl8169_poll_msix_tx()
>>
>> Changes in v7:
>>   - remove recheck_desc_ownbit
>>   - change return value of rtl_tx
>>   - remove message_id which only used once
>>
>> Changes in v8:
>>   - fix rtl8169_netpoll()
>>   - remove tx_done
>>
>> Changes in v9:
>>   - change the way of getting message_id of napi
>>
>> Changes in v10:
>>   - no changes
>>
>> Changes in v11:
>>   - add comment on rtl8169_poll_msix_tx, only use 1 tx
>>   - remove napi for other. Separate napi only for datapath, control path
>>     like linkchg is handled in interrupt function, which will not call
>>     napi any more.
>> ---
>>   drivers/net/ethernet/realtek/r8169_main.c | 213 +++++++++++++++++++---
>>   1 file changed, 187 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>> b/drivers/net/ethernet/realtek/r8169_main.c
>> index 9311a0cab4eb..b30f0a31d7c7 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -84,6 +84,7 @@
>>   #define R8169_RX_RING_BYTES ((NUM_RX_DESC + 1) * sizeof(struct
>RxDesc))
>>   #define R8169_TX_STOP_THRS  (MAX_SKB_FRAGS + 1)
>>   #define R8169_TX_START_THRS (2 * R8169_TX_STOP_THRS)
>> +#define R8169_MAX_QUEUES     16
>>   #define R8169_MAX_RX_QUEUES 8
>>   #define R8169_DEFAULT_RX_QUEUES     1
>>   #define R8169_MAX_TX_QUEUES 1
>> @@ -455,8 +456,12 @@ enum rtl8125_registers {
>>       RSS_CTRL_8125           =3D 0x4500,
>>       Q_NUM_CTRL_8125         =3D 0x4800,
>>       EEE_TXIDLE_TIMER_8125   =3D 0x6048,
>> +     IMR_CLEAR_VEC_MAP_REG   =3D 0x0d00,
>> +     ISR_VEC_MAP_REG         =3D 0x0d04,
>> +     IMR_SET_VEC_MAP_REG     =3D 0x0d0c,
>>   };
>>
>> +#define MSIX_ID_VEC_MAP_LINKCHG      29
>>   #define LEDSEL_MASK_8125    0x23f
>>
>>   #define RX_VLAN_INNER_8125  BIT(22)
>> @@ -587,6 +592,9 @@ enum rtl_register_content {
>>
>>       /* magic enable v2 */
>>       MagicPacket_v2  =3D (1 << 16),    /* Wake up when receives a Magic=
 Packet
>*/
>> +#define      ISRIMR_LINKCHG  BIT(29)
>> +#define      ISRIMR_TOK_Q0   BIT(8)
>> +#define      ISRIMR_ROK_Q0   BIT(0)
>>   };
>>
>>   enum rtl_desc_bit {
>> @@ -1663,26 +1671,38 @@ static u32 rtl_get_events(struct
>> rtl8169_private *tp)
>>
>>   static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
>>   {
>> -     if (rtl_is_8125(tp))
>> -             RTL_W32(tp, IntrStatus_8125, bits);
>> -     else
>> +     if (rtl_is_8125(tp)) {
>> +             if (tp->irq_nvecs > 1)
>> +                     RTL_W32(tp, ISR_VEC_MAP_REG, bits);
>> +             else
>> +                     RTL_W32(tp, IntrStatus_8125, bits);
>> +     } else {
>>               RTL_W16(tp, IntrStatus, bits);
>> +     }
>>   }
>>
>>   static void rtl_irq_disable(struct rtl8169_private *tp)
>>   {
>> -     if (rtl_is_8125(tp))
>> -             RTL_W32(tp, IntrMask_8125, 0);
>> -     else
>> +     if (rtl_is_8125(tp)) {
>> +             if (tp->irq_nvecs > 1)
>> +                     RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
>> +             else
>> +                     RTL_W32(tp, IntrMask_8125, 0);
>> +     } else {
>>               RTL_W16(tp, IntrMask, 0);
>> +     }
>>   }
>>
>>   static void rtl_irq_enable(struct rtl8169_private *tp)
>>   {
>> -     if (rtl_is_8125(tp))
>> -             RTL_W32(tp, IntrMask_8125, tp->irq_mask);
>> -     else
>> +     if (rtl_is_8125(tp)) {
>> +             if (tp->irq_nvecs > 1)
>> +                     RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
>> +             else
>> +                     RTL_W32(tp, IntrMask_8125, tp->irq_mask);
>> +     } else {
>>               RTL_W16(tp, IntrMask, tp->irq_mask);
>> +     }
>>   }
>>
>>   static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp) @@
>> -4382,13 +4402,17 @@ static void rtl8169_tx_clear(struct
>> rtl8169_private *tp)
>>
>>   static void rtl8169_napi_disable(struct rtl8169_private *tp)
>>   {
>> -     for (int i =3D 0; i < tp->irq_nvecs; i++)
>> +     int napi_num =3D min(tp->irq_nvecs, R8169_MAX_QUEUES);
>> +
>> +     for (int i =3D 0; i < napi_num; i++)
>>               napi_disable(&tp->rtl8169_napi[i]);
>>   }
>>
>>   static void rtl8169_napi_enable(struct rtl8169_private *tp)
>>   {
>> -     for (int i =3D 0; i < tp->irq_nvecs; i++)
>> +     int napi_num =3D min(tp->irq_nvecs, R8169_MAX_QUEUES);
>> +
>> +     for (int i =3D 0; i < napi_num; i++)
>>               napi_enable(&tp->rtl8169_napi[i]);
>>   }
>>
>> @@ -5030,13 +5054,66 @@ static irqreturn_t rtl8169_interrupt(int irq, vo=
id
>*dev_instance)
>>       return IRQ_HANDLED;
>>   }
>>
>> +static void rtl8169_free_one_irq(struct rtl8169_private *tp, int i) {
>> +     if (tp->irq_nvecs > 1) {
>> +             if (i < R8169_MAX_QUEUES)
>> +                     pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i])=
;
>> +             else if (i =3D=3D MSIX_ID_VEC_MAP_LINKCHG)
>> +                     pci_free_irq(tp->pci_dev, i, tp);
>> +     } else {
>> +             pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
>> +     }
>> +}
>> +
>>   static void rtl8169_free_irq(struct rtl8169_private *tp)
>>   {
>> -     for (int i =3D 0; i < tp->irq_nvecs; i++) {
>> -             struct napi_struct *napi =3D &tp->rtl8169_napi[i];
>> +     for (int i =3D 0; i < tp->irq_nvecs; i++)
>> +             rtl8169_free_one_irq(tp, i); }
>>
>> -             pci_free_irq(tp->pci_dev, i, napi);
>> -     }
>> +static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *t=
p,
>> +                                           int message_id) {
>> +     RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id)); }
>> +
>> +static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int
>> +message_id) {
>> +     RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id)); }
>> +
>> +static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp=
,
>> +                                          int message_id) {
>> +     RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id)); }
>> +
>> +static irqreturn_t rtl8169_interrupt_msix(int irq, void
>> +*dev_instance) {
>> +     struct napi_struct *napi =3D dev_instance;
>> +     struct net_device *dev =3D napi->dev;
>> +     struct rtl8169_private *tp;
>> +     int message_id;
>> +
>> +     tp =3D netdev_priv(dev);
>> +     message_id =3D napi - tp->rtl8169_napi;
>> +
>> +     rtl8169_disable_hw_interrupt_msix(tp, message_id);
>> +     rtl8169_clear_hw_isr(tp, message_id);
>> +
>> +     napi_schedule(napi);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t rtl8169_interrupt_other(int irq, void
>> +*dev_instance) {
>> +     struct rtl8169_private *tp =3D dev_instance;
>> +
>> +     rtl8169_clear_hw_isr(tp, MSIX_ID_VEC_MAP_LINKCHG);
>> +     phy_mac_interrupt(tp->phydev);
>> +     return IRQ_HANDLED;
>>   }
>>
>>   static int rtl8169_request_irq(struct rtl8169_private *tp) @@
>> -5047,8 +5124,26 @@ static int rtl8169_request_irq(struct
>> rtl8169_private *tp)
>>
>>       for (i =3D 0; i < tp->irq_nvecs; i++) {
>>               napi =3D &tp->rtl8169_napi[i];
>> -             rc =3D pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
>> -                                  NULL, napi, "%s-%d", dev->name, i);
>> +             if (tp->irq_nvecs > 1) {
>> +                     if (i < R8169_MAX_QUEUES)
>> +                             rc =3D pci_request_irq(tp->pci_dev, i,
>> +                                                  rtl8169_interrupt_msi=
x,
>> +                                                  NULL, napi, "%s-%d",
>> +                                                  dev->name, i);
>> +                     else if (i =3D=3D MSIX_ID_VEC_MAP_LINKCHG)
>> +                             rc =3D pci_request_irq(tp->pci_dev, i,
>> +                                                  rtl8169_interrupt_oth=
er,
>> +                                                  NULL, tp, "%s-%d",
>> +                                                  dev->name, i);
>> +                     else
>> +                             continue;
>> +             } else {
>> +                     rc =3D pci_request_irq(tp->pci_dev, i,
>> +                                          rtl8169_interrupt,
>> +                                          NULL, napi, "%s-%d",
>> +                                          dev->name, i);
>> +             }
>> +
>>               if (rc)
>>                       goto free_irq;
>>       }
>> @@ -5056,7 +5151,7 @@ static int rtl8169_request_irq(struct
>> rtl8169_private *tp)
>>
>>   free_irq:
>>       while (--i >=3D 0)
>> -             pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
>> +             rtl8169_free_one_irq(tp, i);
>>       return rc;
>>   }
>>
>> @@ -5255,8 +5350,12 @@ static void rtl8169_netpoll(struct net_device
>*dev)
>>       struct rtl8169_private *tp =3D netdev_priv(dev);
>>
>>       for (int i =3D 0; i < tp->irq_nvecs; i++) {
>
>Looking at r8169_init_napi(), later down the patch, it only calls
>netif_napi_add() for min(tp->irq_nvecs, R8169_MAX_QUEUES) vectors, but thi=
s
>loop iterates all tp->irq_nvecs. Can this be an issue? Looks like it will =
be
>because entries entries >=3D R8169_MAX_QUEUES are zeroed but
>rtl8169_interrupt_msix() would set dev to NULL.

Thanks for pointing out this. I have forgotten to modify this.

Thanks,
Javen
