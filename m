Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665094432E4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627526; cv=none; b=W93d1ef05neoIMqhzWRbDRXNbQAy8aiGeGncX1hAHnL1gSC9kWb1Cp/vO7Hjwpzmmi0wMOKuXxQ/s83Qj5qHmfpFSb8iMjGxurR4jQ+djzbOS5jqpDEQd/14SvSQVHc8ik9FJHeHPkPq+BAKK0+mA+VYeNfo55nN4xPYIn6r6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627526; c=relaxed/simple;
	bh=MWAPs8qBqwLHMORmwD4NZ7u5laojwl8fHchhfOY4UyM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lFXq4cdzJklwPCu5hlDPW4PsnKH/qvCTftt2wH8ALkBBZyYj66GBAsCE2jCKaqAbv2p5w/gMa/SMyCpztlnxyOZOvLhfUe3x69U5UWWediYLNNq676FxrrMECmf+xGjrQNF57c4eXHVyvbQj1Mo/7ViTTYgJKGomXORN1v+DytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1789627417t6c8cae62
X-QQ-Originating-IP: a/3fcY3QGFK+g/VDrjjGhDlnBLWSvxHNUI4ZivQsf9c=
Received: from smtpclient.apple ( [122.233.172.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Sep 2026 14:43:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11232726126545815307
EX-QQ-RecipientCnt: 13
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next] net: libwx: Add ethtool -L support for VF
 drivers
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <CAEAWyHfFYryMvtb+9XRY-hjjDpxiZUjfKX9ShK4My7Wtz-Dj2w@mail.gmail.com>
Date: Thu, 17 Sep 2026 14:43:14 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com,
 u.kleine-koenig@baylibre.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5151C867-ACED-4B65-A4FC-184CC432F3B2@net-swift.com>
References: <20260915093714.18815-1-mengyuanlou@net-swift.com>
 <CAEAWyHfFYryMvtb+9XRY-hjjDpxiZUjfKX9ShK4My7Wtz-Dj2w@mail.gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MuaVFG6ep5hsV1nCrAEw5SDCeGz7j/o9T8mNGf9YfKD17Ba7IaTrRVS1
	kuhy5YJQJsE8LdGyzJFWlayWqjOG37YzQ8rv6ClOKomS2a5B4oMZEIP4Xdj0S55SH9zeAov
	u51jMqqfDcqBdcNalkHPApznzpJTAGdcsMF4pCc58AT2pv0lQFc3dLmV9/njRrrMbsyBrqq
	S1rcJb30izG2aKYw6UnxwLh/+TkPb4J+z2iGed895FDamnhg1Mm1HYO7fr0hxEetFgdjsVF
	EevGpnH9nUsjpvLzUSY81JW+BC++KpBk1lab0ph37c9geKqHSFJCMivxN7aNXBx4pfndE8V
	2XgHBbodYR103N27FZeVjQVd6NFgPl6lyDorWpvli+lmHSdrKMdoVryuHiTJHnbFreXi0cR
	mB+jJ5gs6PTGAqoUkBTUt9uzwW3eunKgtKrIVOKyNTFeNiVODvlCzIL+qQQjvtv+l+0WcbK
	t/iuNCF/0HGM7LAWrDdcryw+3u8HrRnrWauGXe1JPQjqqA1zn3n1daoqf3LJwO2t2vzyF1U
	hG7Xk+1n6KotfG1gLRvEsu0twHa6ppceJo6AFBbuUgjBeAYed5TYHIxFJcMDSCJd6+wxQBi
	JX3+7EbJJOVQM0jXZ5tF0t2d8GW48ObuyG6pKFAwy40kCHdLlYOmYOCcGgkjXuYbrv02VQv
	8Yts071G6VP0YkrrRDc/SBNhWbq8auIPB3++8v9jiYmp5Tp2ekp7C0uqfsfTWl4zUvByfkz
	q0Y4azNzSHl8BQLLdfoBb924tDUg3di/vQwElVBcA9ulWe/Dz8YAIxg6OG8Jjtp1bxl167J
	jkISXjrFcGcm4xl2iGnCs6BtWqD3QAZb7q/qZVDs6rch31/5Z+PhEW5v5/fikgTlpTXcj1b
	lWOmvalIdkuSeduIGhzxAppSUgjeBbWX1Ujfz9tC3NEv7H/2U+IkUYPHGkb5mnYLAtWor7I
	mF4VFx3bRjneiGnjrAPFTr0OYhV4ewXHTs2fnTinfSY5zPI/wrSACq1mo5R/M0unctrFQsc
	b4+eZ/XXfKFLXZp4y1lgrWsYFYEe4SLgDyFnxM93r7xp8T45C+dLDauO5UCkV0Okbml+aqk
	/moQCVSEhH5dR5ujZywpESjDRIaTrlIm3qhddOwvbAp
X-QQ-XMRINFO: Nq+8W0+stu50DoRqCCgK95c9ineS5lb9CA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8816=E6=97=A5 03:19=EF=BC=8CHarshitha Ramamurthy =
<hramamurthy@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Sep 15, 2026 at 3:18=E2=80=AFAM Mengyuan Lou =
<mengyuanlou@net-swift.com> wrote:
>>=20
>> Implement get_channels and set_channels ethtool operations for =
Wangxun
>> VF net_device instances in libwx.
>>=20
>> This allows users to query and dynamically reconfigure the number of =
RX/TX
>> channels on VF interfaces via `ethtool -l/ -L`.
>>=20
>> Specifically:
>> - Add wx_get_channels_vf() and wx_set_channels_vf() to report and =
update
>>  channel limits and combined queue counts.
>> - Re-evaluate RSS limits in txgbevf_set_num_queues() based on user =
settings
>>  stored in wx->ring_feature[RING_F_RSS].limit.
>> - Adjust VF MRQC RSS hash mask logic in wx_setup_vfmrqc_vf() to =
correctly
>>  match queue configuration thresholds.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 64 =
+++++++++++++++++++
>> .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  2 +-
>> .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  3 +
>> 3 files changed, 68 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c =
b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> index 940d2e59876c..d24370790941 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> @@ -564,6 +564,68 @@ int wx_set_channels(struct net_device *dev,
>> }
>> EXPORT_SYMBOL(wx_set_channels);
>>=20
>> +static void wx_get_channels_vf(struct net_device *dev,
>> +                              struct ethtool_channels *ch)
>> +{
>> +       struct wx *wx =3D netdev_priv(dev);
>> +
>> +       /* report maximum channels */
>> +       ch->max_combined =3D wx->mac.max_rx_queues;
>> +
>> +       ch->max_other =3D 1;
>> +       ch->other_count =3D 1;
>> +
>> +       /* record current channels */
>> +       ch->combined_count =3D wx->num_rx_queues;
>> +}
>> +
>> +static int wx_set_channels_vf(struct net_device *dev,
>> +                             struct ethtool_channels *ch)
>> +{
>> +       struct wx *wx =3D netdev_priv(dev);
>> +       u16 rss_limit;
>> +       int ret;
>> +
>> +       rss_limit =3D wx->ring_feature[RING_F_RSS].limit;
>> +
>> +       /* verify other_count has not changed */
>> +       if (ch->other_count !=3D 1)
>> +               return -EINVAL;
>> +
>> +       /* verify the number of channels does not exceed hardware =
limits */
>> +       if (ch->combined_count > wx->mac.max_rx_queues)
>> +               return -EINVAL;
>> +
>> +       /* if device is resetting, do nothing */
>> +       if (test_bit(WX_STATE_RESETTING, wx->state))
>> +               return -EBUSY;
>> +
>> +       wx->ring_feature[RING_F_RSS].limit =3D ch->combined_count;
>> +
>> +       if (netif_running(dev))
>> +               wxvf_close(dev);
>=20
> The precedent has been for some time now that drivers are required to
> pre-allocate resources for the new queue counts before tearing down
> the existing ones. So that the driver doesn't knock itself out if
> something fails when attempting to apply the new configuration.
>=20
> Look at the nfp_net_ring_config() or gve_adjust_config() for examples:
> both try to allocate memory for the new config first.

Thanks for the feedback.

I understand that pre-allocating resources before tearing down existing =
queues
("prepare-then-commit") is the ideal pattern used by drivers like NFP =
and GVE
to ensure zero-downtime or graceful failure recovery during queue =
reconfigurations.

However, adopting the NFP/GVE pre-allocation model is not technically =
feasible
for WangXun VF without closing the device first.

1. MSI-X Vector Lifecycle Constraints
	Unlike NFP (which can dynamically manage dual sets of MSI-X =
vectors) or GVE
(which pre-allocates all possible MSI-X vectors at probe time and only =
resizes
queues afterwards), WangXun VF acquires its MSI-X vectors in a single =
lump sum
via pci_alloc_irq_vectors_affinity().
    =E2=80=A2 To change the vector count or reconfigure queue-to-vector =
mappings, Linux
	PCI architecture requires freeing all active vectors via =
pci_free_irq_vectors()
	before requesting new ones.
    =E2=80=A2 Freeing active MSI-X vectors requires teardown of the =
current interrupt scheme,
	which cannot be safely done while the interface remains RUNNING.
2. NAPI Registration Constraints (netif_napi_add)
	Each queue vector allocates a struct wx_q_vector and registers a =
NAPI instance via
netif_napi_add().
    =E2=80=A2 In the WangXun driver architecture, NAPI instances are =
tightly bound to the
	queue/vector layout.
    =E2=80=A2 Allocating new q_vectors and invoking netif_napi_add() =
while the driver is running
	risks duplicate NAPI registrations or corrupted polling state. =
Therefore, the
	device must be down (wxvf_close) before cleaning up old NAPI =
instances and
	instantiating new ones.



%%{init: =
{'theme':'base','themeVariables':{'primaryColor':'#dd6b20','edgeLabelBackg=
round':'#fff','clusterBkg':'#fff5f5','clusterBorder':'#fdba74'}}}%%
graph TD
    %% --------------------------------------------------------------
    %% Entry & parameter checks
    %% --------------------------------------------------------------
    A[wx_set_channels_vf(dev, ch)]
    A --> B[if (ch->other_count !=3D 1)  =E2=86=92  -EINVAL]
    B --> C[if (ch->combined_count > wx->mac.max_rx_queues)  =E2=86=92  =
-EINVAL]
    C --> D[if (test_bit(WX_STATE_RESETTING, wx->state))  =E2=86=92  =
-EBUSY]

    %% --------------------------------------------------------------
    %% Must stop the VF first if it is running
    %% --------------------------------------------------------------
    D -->|netif_running(dev)| E[wxvf_close(dev)   // stop Tx/Rx, disable =
NAPI, free resources]
    D -->|!netif_running(dev)| F[(skip) ]

    %% --------------------------------------------------------------
    %% Completely clear the current interrupt scheme (including MSI=E2=80=91=
X)
    %% --------------------------------------------------------------
    E --> G[wx_clear_interrupt_scheme(wx)]
    subgraph G[wx_clear_interrupt_scheme(wx) details]
        direction TB
        G1[wx_free_q_vectors(wx)                 // free q_vectors only]
        G2[wx_reset_interrupt_capability(wx)    // free MSI=E2=80=91X =
vectors (pci_free_irq_vectors)]
        G1 --> G2
    end

    %% --------------------------------------------------------------
    %% Re=E2=80=91initialize the whole interrupt scheme (allocate =
MSI=E2=80=91X, q_vectors, rings)
    %% --------------------------------------------------------------
    G --> H[wx_init_interrupt_scheme(wx)]
    subgraph H[wx_init_interrupt_scheme(wx) details]
        direction TB
        H1[wx_set_num_queues(wx)                 // recompute =
num_tx/num_rx/num_q_vectors]
        H2[wx_set_interrupt_capability(wx)       // request MSI=E2=80=91X =
vectors (pci_alloc_irq_vectors)]
        H3[wx_alloc_q_vectors(wx)               // allocate q_vector =
structs and rings (netif_napi_add)]
        H4[wx_cache_ring_rss(wx)                 // compute RSS reg_idx =
and program hardware]
        H5[set_bit(WX_STATE_DOWN, wx->state)]
        H1 --> H2 --> H3 --> H4 --> H5
    end

    %% --------------------------------------------------------------
    %% If the device was running before, open it again
    %% --------------------------------------------------------------
    H -->|netif_running(dev) after re=E2=80=91init| I[wxvf_open(dev)   =
// re=E2=80=91enable NAPI, wake Tx/Rx]
    H -->|!netif_running(dev) after re=E2=80=91init| J[return 0]

    I --> K[return 0  // success]
    J --> K

    %% --------------------------------------------------------------
    %% Error path =E2=80=93 restore old RSS limit and return error
    %% --------------------------------------------------------------
    H -->|ret !=3D 0| L[restore original RSS limit & return error]

    %% --------------------------------------------------------------
    %% Conflict points (why we cannot =E2=80=9Cprepare=E2=80=91first, =
close=E2=80=91later=E2=80=9D)
    %% --------------------------------------------------------------
    classDef note fill:#fffae6,color:#333,stroke:#ffa726;


    N1[**Conflict=E2=80=AF1**: MSI=E2=80=91X vectors are allocated only =
once (wx_set_interrupt_capability) =E2=80=93 a new allocation requires =
pci_free_irq_vectors(), which can be done only after the old vectors are =
released (i.e. after the device is closed).]:::note
    N2[**Conflict=E2=80=AF2**: netif_napi_add() (called inside =
wx_alloc_q_vectors) must be executed while the device is not RUNNING; =
otherwise double=E2=80=91registration of NAPI leads to bugs.]:::note
    N3[**Conflict=E2=80=AF3**: Hardware register mapping (reg_idx, RSS =
tables) must be programmed before the device is opened; changing them =
while the hardware is running causes race=E2=80=91conditions.]:::note

    N1 -.-> H2
    N2 -.-> H3
    N3 -.-> H4





 |
|------|----------|----------|
| **NFP** | `nfp_net_set_channels()` =E2=86=92 `nfp_net_ring_reconfig()`

**GVE** | `gve_set_channels()` =E2=86=92 `gve_adjust_queues()` =E2=86=92 =
`gve_adjust_config()`

NFP
 * struct nfp_net_dp - NFP network device datapath data structure

gve
   struct gve_tx_alloc_rings_cfg tx_alloc_cfg =3D {0};
   struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};

The allocation of interrupt resources and ring resources can be =
separated
which Wangxun vf can not do it.







>=20
>> +
>> +       wx_clear_interrupt_scheme(wx);
>> +
>> +       ret =3D wx_init_interrupt_scheme(wx);
>> +       if (ret)
>> +               goto err_out;
>> +
>> +       if (netif_running(dev)) {
>> +               ret =3D wxvf_open(dev);
>> +               if (ret)
>> +                       goto err_close;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_close:
>> +       wx_clear_interrupt_scheme(wx);
>> +err_out:
>> +       wx->ring_feature[RING_F_RSS].limit =3D rss_limit;
>> +       return ret;
>> +}
>> +
>> u32 wx_rss_indir_size(struct net_device *netdev)
>> {
>>        struct wx *wx =3D netdev_priv(netdev);
>> @@ -852,6 +914,8 @@ static const struct ethtool_ops wx_ethtool_ops_vf =
=3D {
>>        .set_coalesce           =3D wx_set_coalesce,
>>        .get_ts_info            =3D ethtool_op_get_ts_info,
>>        .get_link_ksettings     =3D wx_get_link_ksettings_vf,
>> +       .get_channels           =3D wx_get_channels_vf,
>> +       .set_channels           =3D wx_set_channels_vf,
>> };
>>=20
>> void wx_set_ethtool_ops_vf(struct net_device *netdev)
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
>> index 7325b475ee10..6fec3ab5e4e4 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
>> @@ -237,7 +237,7 @@ void wx_setup_vfmrqc_vf(struct wx *wx)
>>=20
>>        vfmrqc |=3D WX_VXMRQC_RSS_EN;
>>=20
>> -       if (wx->num_rx_queues > 3)
>> +       if (wx->num_rx_queues >=3D 3)
>>                vfmrqc |=3D WX_VXMRQC_RSS_HASH(2);
>>        else if (wx->num_rx_queues > 1)
>>                vfmrqc |=3D WX_VXMRQC_RSS_HASH(1);
>> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c =
b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
>> index 8b16b900820a..6e8659082051 100644
>> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
>> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
>> @@ -72,6 +72,9 @@ static void txgbevf_set_num_queues(struct wx *wx)
>>                queue =3D min_t(u16, wx->mac.max_rx_queues, =
wx->mac.max_tx_queues);
>>                rss =3D min_t(u16, queue, rss);
>>=20
>> +               if (wx->ring_feature[RING_F_RSS].limit)
>> +                       rss =3D min_t(u16, rss, =
wx->ring_feature[RING_F_RSS].limit);
>> +
>>                if (wx->vfinfo->vf_api >=3D wx_mbox_api_13) {
>>                        wx->num_rx_queues =3D rss;
>>                        wx->num_tx_queues =3D rss;
>> --
>> 2.30.1
>>=20
>>=20
>>=20
>=20
>=20

