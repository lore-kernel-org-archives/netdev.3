Received: from out198-6.us.a.mail.aliyun.com (out198-6.us.a.mail.aliyun.com [47.90.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728D3D45CB;
	Mon, 17 Aug 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963266; cv=none; b=gaDimN29nHQcwq5QsQ7F/vhCD3PLGvA+4raOKv16M8FwwD0WZkByOFfTz6CqKIHECpUCKz/gtZ3dNvrU3DQhS90Txz2ZwCyBMyLv9eTpD+rCYVF2vPO/K02y6Drfskyt2ARLidwDEZZ3azRB3B09vDkjYJNeL/KuDbEvgmQoa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963266; c=relaxed/simple;
	bh=Th8aEjG/v7spdjgmdFih8zoDm8bqeQ1ry8ns5FR3hBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjdhhVkWsMILTEM0tLlvWUtOtPKLcrtCLfr9YjCg/zsyy/ROulN++KUR5BSVkAvplVNA3AYfNBWi3ojOa3WuRNKKNhFH6P7ToSBVb95iBmvVlhBr3GsrY4kbWAd3PobFdHt0lTQRyxylJ/3BAuPxXq5LxBv0MV2sPmiBqP4jh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436381|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.169506-0.00059428-0.8299;FP=15778095390952263184|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.ip67BDX_1786963208;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.ip67BDX_1786963208 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 18:40:41 +0800
Message-ID: <f324481e-d49c-4d6d-b5fd-8a0296f82a15@motor-comm.com>
Date: Mon, 17 Aug 2026 18:40:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net:dsa:yt922x: Add support for Motorcomm
 YT922x
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260813104137.55550-1-kyle.switch@motor-comm.com>
 <CAAXyoMP=-YXbdgCWXRbPqmQXwPuRegHSDvDm9_+hhmf9ev2CAQ@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMP=-YXbdgCWXRbPqmQXwPuRegHSDvDm9_+hhmf9ev2CAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/17/26 05:17, David Yang wrote:
> On Fri, Aug 14, 2026 at 9:50 AM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>
>> @@ -148,10 +148,15 @@ static const struct yt921x_info yt921x_infos[] = {
>>                  YT921X_PORT_MASK_INT0_n(8),
>>                  YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
>>          },
>> +       {
>> +               "YT9224", YT9224_MAJOR, 0, 0,
>> +               0x1f1,
>> +               0x0,
>> +       },
> Why plain magic numbers here, despite what the above entries shows?
Ans: will fixed done in patch v2.
>
>>          {}
>>   };
>>
>> -#define YT921X_NAME    "yt921x"
>> +#define YT92XX_NAME    "yt92xx"
> This changed the module name which may affect end users. While I have
> no objection to this, subsystem maintainers may have different
> opinions.
Ans: This is used to indicate support for both YT921X and YT922X.
>
>> +static int
>> +yt922x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
> [...]
>
>> +static int
>> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
> Place them with yt921x_*if_*().
Ans: fix done in patch v2.
>
>> +static int yt922x_internal_phyaddr_get(int port,
>> +                                      enum yt922x_phy_reg_type reg_type,
>> +                                      enum yt922x_phy_reg_space reg_space)
> [...]
>
> This makes me headache and is prone to errors (an example below).
> Reorder it with early returns and/or lookup tables so that it is
> obviously correct.
Ans: The interface will be optimized in v1 using early returns.
>
>> +               default:
>> +                       if (reg_space != YT922X_PHY_REG_SPACE_PHY)
>> +                               res = -EINVAL;
>> +                       break;
> What would you expect here, when reg_space == YT922X_PHY_REG_SPACE_PHY?
Ans: The expected return result is an error.
>
>> +static int yt922x_port_sds_init(struct yt921x_priv *priv, int port,
>> +                               phy_interface_t interface)
> [...]
>
>> +       addr = yt922x_internal_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
>> +                                          YT922X_PHY_REG_SPACE_SGMII);
>> +       if (addr < 0)
>> +               return res;
>> +       res = yt921x_intif_read(priv, addr, 0x2000, &data);
>> +       if (res)
>> +               return res;
>> +       data &= ~(1 << 15);
>> +       res = yt921x_intif_write(priv, addr, 0x2000, data);
>> +       if (res)
>> +               return res;
>> +       addr = yt922x_internal_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
>> +                                          YT922X_PHY_REG_SPACE_USXGMII);
>> +       if (addr < 0)
>> +               return res;
>> +       res = yt921x_intif_read(priv, addr, 0x0, &data);
>> +       if (res)
>> +               return res;
>> +       data |= 1 << 15;
>> +       res = yt921x_intif_write(priv, addr, 0x0, data);
>> +       if (res)
>> +               return res;
> Numerous magic numbers. On YT9215, same finetunes are not required for
> a usable port. If you cannot name it, drop it if it is not mandatory.

Ans: Some patches are mandatory, while others are for performance 
optimization.

        These will be further refined/optimized in the future.

>
>> +static int yt922x_cpu_tag_mode_set(struct yt921x_priv *priv)
>> +{
>> +       struct device *dev = to_device(priv);
>> +       u16 eth_p_tag;
>> +       u32 val;
>> +       u32 val1;
>> +       int res;
>> +
>> +       /* cpu tag mode set */
>> +       res = yt921x_reg_read(priv, YT922X_CPU_TAG_RX_CTRL, &val);
>> +       if (res)
>> +               return res;
>> +       res = yt921x_reg_read(priv, YT922X_CPU_TAG_TX_CTRL, &val1);
>> +       if (res)
>> +               return res;
>> +       val &= ~YT922X_CPU_TAG_RX_MODE;
>> +       val1 &= ~YT922X_CPU_TAG_TX_MODE;
>> +       val1 &= ~YT922X_CPU_TAG_TX_TYPE;
>> +       res = yt921x_reg_write(priv, YT922X_CPU_TAG_RX_CTRL, val);
>> +       if (res)
>> +               return res;
>> +       res = yt921x_reg_write(priv, YT922X_CPU_TAG_TX_CTRL, val1);
>> +       if (res)
>> +               return res;
>> +
>> +       /* tpid check */
>> +       res = yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
>> +       if (res)
>> +               return res;
>> +       eth_p_tag = FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
>> +       if (eth_p_tag != ETH_P_YT921X) {
>> +               dev_err(dev, "Tag type 0x%x != 0x%x\n", eth_p_tag,
>> +                       ETH_P_YT921X);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
> This looks similar to yt921x_chip_reset(), so you'd better merge it
> into yt922x_chip_reset() above.

Ans:Given that this interface is responsible for mode selection related 
to CPU tags, the cpu tag

        TPID check has been consolidated here as well.

>
>> +static int yt922x_cpu_port_set(struct yt921x_priv *priv)
>> +{
>> +       struct dsa_switch *ds = &priv->ds;
>> +       u32 ctrl;
>> +       int res;
>> +
>> +       /* cpu tag mode */
>> +       res = yt922x_cpu_tag_mode_set(priv);
>> +       if (res)
>> +               return res;
>> +
>> +       /* Enable DSA */
>> +       priv->cpu_ports_mask = dsa_cpu_ports(ds);
>> +       ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
>> +              YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
>> +       res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
>> +       if (res)
>> +               return res;
>> +
>> +       /* Setup software switch */
>> +       ctrl = YT922X_CPU_COPY_TO_EXT_CPU;
>> +       res = yt921x_reg_write(priv, YT922X_CPU_COPY, ctrl);
>> +       if (res)
>> +               return res;
>> +
>> +       return res;
>> +}
> Also, snippets from yt921x_chip_setup_dsa() and unaligned function names.
>
>> -static void yt921x_mdio_remove(struct mdio_device *mdiodev)
>> +static void yt92xx_mdio_remove(struct mdio_device *mdiodev)
> Unnecessary renaming.
>
>> +#define YT922X_PORT_SDS_MODE           0x400
>> +#define YT922X_PORT_SDS_MODE_M         GENMASK(6, 4)
>> +#define YT92XX_SERDES_MODE_SGMII                       0
>> +#define YT92XX_SERDES_MODE_REVSGMII                    1
>> +#define YT92XX_SERDES_MODE_1000BASEX                   2
>> +#define YT92XX_SERDES_MODE_100BASEX                    3
>> +#define YT92XX_SERDES_MODE_2500BASEX                   4
>> +#define YT92XX_SERDES_MODE_USXGMII                     6
> Not an objection, but better to keep the formats with YT921X_SERDESn:
Ans: fix done in patch v2.
>
> #define YT922X_PORT_SERDES           0x400
> #define  YT922X_PORT_SERDES_MODE_M           GENMASK(6, 4)
> #define   YT922X_PORT_SERDES_MODE(x)
> FIELD_PREP(YT922X_PORT_SERDES_MODE_M, (x))
> #define   YT922X_PORT_SERDES_MODE_SGMII              YT922X_PORT_SERDES_MODE(0)
>
>> +#define YT922X_ACT_UNK_ACTn_M(port)            GENMASK(2 * (port) + 1, 2 * (port))
>> +#define YT922X_ACT_UNK_ACTn(port, x)           ((x) << (2 * (port)))
>> +#define YT922X_ACT_UNK_ACTn_FORWARD(port)      YT922X_ACT_UNK_ACTn(port, 0)  /* flood */
>> +#define YT922X_ACT_UNK_ACTn_TRAP(port)         YT922X_ACT_UNK_ACTn(port, 3)  /* steer to CPU */
>> +#define YT922X_ACT_UNK_ACTn_DROP(port)         YT922X_ACT_UNK_ACTn(port, 1)  /* discard */
>> +/* NEVER use this action; see comments in the tag driver */
>> +#define YT922X_ACT_UNK_ACTn_COPY(port)         YT922X_ACT_UNK_ACTn(port, 2)  /* flood and copy */
> Sort them in numerical order.
Ans: Fix done.
>
>> +
>> +/* CPU PORT */
>> +#define YT922X_CPU_COPY                        0x181100
>> +#define YT922X_CPU_COPY_TO_INT_CPU     BIT(1)
>> +#define YT922X_CPU_COPY_TO_EXT_CPU     BIT(0)
>> +#define YT922X_CPU_TAG_RX_CTRL         0x80504
>> +#define YT922X_CPU_TAG_RX_MODE         BIT(0)
>> +#define YT922X_CPU_TAG_TX_CTRL         0x100710
>> +#define YT922X_CPU_TAG_TX_TYPE         BIT(0)
>> +#define YT922X_CPU_TAG_TX_MODE         BIT(1)
>> +#define YT922X_CPU_TAG_TX_CTAG_OP      BIT(2)
>> +#define YT922X_CPU_TAG_TX_STAG_OP      BIT(3)
> Not an objection, but better to keep the indentation formats of yt921x
> register definitions above.
>
>> +struct yt92xx_chip_info {
>> +       enum yt92xx_mode mode;
>> +       const char *name;
>> +       unsigned int ports;
>> +       unsigned int lag_id;
> lag_ids, or num_lag_ids (and num_ports) for consistency.
>
>>   struct yt921x_priv {
>>          struct dsa_switch ds;
>>
>> +       const struct yt92xx_chip_info *chip_info;
>>          const struct yt921x_info *info;
> yt921x_priv :: info is chip info already. You may want `series_info`,
> or more straightforward, `series` and `struct yt92xx_series`.
Ans: Fix done.
>
>> diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
>> index 294784ab6694..a3012ec39868 100644
>> --- a/net/dsa/tag_yt921x.c
>> +++ b/net/dsa/tag_yt921x.c
> [...]
>
>> +/* To define the from cpu tag format 8 bytes:
>> + *
>> + * 0 1 2 3 4 5 6 7 |0 1 2 3 4 5 6 7
>> + *|<------------TPID 0x9988------->|
>> + *|<--RESERVE-->|<-----DST POR---->|
>> + *|-|<---------RESERVE------------>|
>> + *|<------------------------------>|
>> + */
>> +#define YT922X_TAG_NAME                        "yt922x"
>> +#define YT922X_TAG_PORTMASK_0          BIT(15)
> Sort them according to their corresponding word.
>
>> +#define YT922X_TAG_PORTMASK_M          GENMASK(8, 0)
>> +#define YT922X_TAG_PORTS(x)            FIELD_PREP(YT922X_TAG_PORTMASK_M, (x))
>> +#define YT922X_TAG_FORCE_DST           BIT(9)
>> +#define YT922X_TAG_PRIO_M              GENMASK(12, 10)
>> +#define YT922X_TAG_PRIO_EN             BIT(13)
>> +#define YT922X_TAG_PRIO(x)             (FIELD_PREP(YT922X_TAG_PRIO_M, (x)) | YT922X_TAG_PRIO_EN)
>> +#define YT922X_TAG_RX_PORT_M           GENMASK(5, 2)
>> +#define YT922X_TAG_RX_PRIO_M           GENMASK(15, 13)
> This did not answer the question in the previous review: do tag_yt922x
> and tag_yt921x share any common routines? If not, better to make
> tag_yt922x a separate file.
Ans: Fix done.
>
>> +static struct sk_buff *
>> +yt922x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
>> +{
>> +       struct dsa_port *dp = dsa_user_to_port(netdev);
>> +       __be16 *tag;
>> +       u16 ctrl;
>> +
>> +       skb_push(skb, YT921X_TAG_LEN);
>> +       dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
>> +       tag = dsa_etype_header_pos_tx(skb);
>> +
>> +       tag[0] = htons(ETH_P_YT921X);
>> +       if (dp->index != 0) {
>> +               /* Port index is not equal 0 in tag[1] */
>> +               ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
>> +                       YT922X_TAG_PORTS(dsa_xmit_port_mask(skb, netdev) - 1);
> dsa_xmit_port_mask() returns a bit mask - you won't do arithmetic
> operations to a bit mask normally.
>
> The field name does suggest it is a port mask. Have you noticed
> excessive packets on other ports?
Ans: yes, There are some issues here that will be fixed in patch v2.
