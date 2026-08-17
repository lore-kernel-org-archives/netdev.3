Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AC3B42E8;
	Mon, 17 Aug 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951343; cv=none; b=VpBTukLzJFXHdINyROKxZ+pMafvo79w5eIWSXtMYS3mpwxMKYwE5FEbN5pH2nH/MNW2dORItKhAHwJNqFvqvQbFliYp7f20gziYgcMp5RaXfkItIP4zjBfUxm6Ka5mi/RI781Lv+1KiECa/6ra66k1SR6pKNE0myz667UOQiiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951343; c=relaxed/simple;
	bh=H68UE4Bo1PqmNZegPXz5Z3faUh79UgUtjbf1b4/6lZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lmgt6jcE7Sq359yNkLIHlDjuMRrHcJmdAvTpXu3eqNtXHM/QONtRqVKqB7tGmo0phXh1JcT/AYVh48IHU6FhXPq8trVPHeot0iVaJivnBpzh57t6zvc7PvFJJOWB62AiAYrlD7Fyj+ZOWHAJd2RInUUGhZ44r/khsf/sCaAXUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ZEVhS+xJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ZEVhS+xJ"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67H7Lfa563741600, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1786951301;
	bh=PbBt74LrXWi9kT4svINEZTN7Ljwz+jsblHlmO8HXNBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZEVhS+xJylXcL/Q8XL09wdHUKax/Gp9ltvvMGwvYR6bVGjako+yHGarfD0bOiW4Cq
	 SCZ6JYHPl3Geiw1Bi2xgfbrhfOCLPJqYgSxnzLmFYFV44Cdhvb4GoKMs83y403c5Ji
	 ouq5eTTTxam10cvW06xdoqYhhDF2zc0Xah83wt3cjwEpjCxq8hwG6XWcWnWuVLPb9v
	 wKXsIYhOZ+fvluwfD9ROqNGlfl+3Nn8zZj2yGV9Mr2z/XQy5GUsDF+TEZalnLU2m8z
	 n6dsWXYNeqSs9GsXtiuwBNNJL1HnSs30rAzmWE6u755KOoFCPiuDY848ZGoIeJjL0z
	 0faiRZpgw6EOg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67H7Lfa563741600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 15:21:41 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 17 Aug 2026 15:21:41 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Mon,
 17 Aug 2026 15:21:41 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Mohsin Bashir <mohsin.bashr@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v11 4/7] r8169: enable new interrupt mapping
Thread-Topic: [PATCH net-next v11 4/7] r8169: enable new interrupt mapping
Thread-Index: AQHdK4+D23SxVQFkok2R80srsbelxLadomiAgAQvLuA=
Date: Mon, 17 Aug 2026 07:21:41 +0000
Message-ID: <48ac068870fb49ff92c4dce9382d83e3@realsil.com.cn>
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
 <20260814015203.1328-5-javen_xu@realsil.com.cn>
 <9c73a611-8aab-411a-968f-86757e2756e5@gmail.com>
In-Reply-To: <9c73a611-8aab-411a-968f-86757e2756e5@gmail.com>
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
>
>On 8/13/26 6:52 PM, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> This patch enables new interrupt mapping for RTL8127 and add error
>> pkts counter per ring.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>> Changes in v2:
>>   - no changes
>>
>> Changes in v3:
>>   - no changes
>>
>> Changes in v4:
>>   - no changes
>>
>> Changes in v5:
>>   - no changes
>>
>> Changes in v6:
>>   - no changes
>>
>> Changes in v7:
>>   - no changes
>>
>> Changes in v8:
>>   - no changes
>>
>> Changes in v9:
>>   - no changes
>>
>> Changes in v10:
>>   - no changes
>>
>> Changes in v11:
>>   - add error pkts counter per ring
>> ---
>>   drivers/net/ethernet/realtek/r8169_main.c | 80 +++++++++++++++++++----
>>   1 file changed, 68 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>> b/drivers/net/ethernet/realtek/r8169_main.c
>> index b30f0a31d7c7..aa72c42c374d 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/prefetch.h>
>>   #include <linux/ipv6.h>
>>   #include <linux/unaligned.h>
>> +#include <linux/u64_stats_sync.h>
>>   #include <net/ip6_checksum.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/phy/realtek_phy.h>
>> @@ -754,6 +755,15 @@ struct rtl8169_rx_ring {
>>       dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
>>       dma_addr_t rx_phy_addr;
>>       struct page *rx_databuff[NUM_RX_DESC];
>> +
>> +     struct {
>> +             u64 rx_errors;
>> +             u64 rx_dropped;
>> +             u64 rx_length_errors;
>> +             u64 rx_crc_errors;
>> +             u64 multicast;
>> +             struct u64_stats_sync syncp;
>> +     } stats;
>>   };
>>
>>   struct rtl8169_private {
>> @@ -3939,6 +3949,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>>       return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>>   }
>>
>> +static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
>> +{
>> +     u8 tmp;
>> +
>> +     tmp =3D RTL_R8(tp, INT_CFG0_8125);
>> +     tmp |=3D INT_CFG0_ENABLE_8125;
>> +     RTL_W8(tp, INT_CFG0_8125, tmp);
>> +}
>> +
>>   static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>   {
>>       rtl_pcie_state_l2l3_disable(tp); @@ -3947,6 +3966,9 @@ static
>> void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>       RTL_W32(tp, RSS_CTRL_8125, 0);
>>       RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>>
>> +     if (tp->irq_nvecs > 1)
>> +             rtl8169_hw_enable_vec_mapping(tp);
>> +
>>       /* disable UPS */
>>       r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>>
>> @@ -4347,7 +4369,7 @@ static int rtl8169_init_ring(struct
>> rtl8169_private *tp)
>>
>>       memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
>>
>> -     for (i =3D 0; i < tp->num_rx_rings; i++) {
>> +     for (int i =3D 0; i < tp->num_rx_rings; i++) {
>
>This looks like an unrelated change. Looking the function body, this is
>introducing a new bug on the cleanup path by changing the scope of i.

Yes, this change have been dropped in the next version.

Thanks,
Javen

