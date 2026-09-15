Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6176392C5F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455636; cv=none; b=FFHZBVgl6s+iDFe+65Jw88sPyL2HamZfLUENJ3qntqTLel6AbvwqfgETrgKUMHOAZbgzPa2IHuwmWzCr41Cj1K6bMHD/AcyBfb11D0AsmslYj8r9ig2CPv/FOTcn0ZJHH3nhBvuP09OHqlXoNUWA6zTo0sQ/hIKsVirHwGBV0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455636; c=relaxed/simple;
	bh=MP/8yDHExjnZ1f/l24lC5R0z/XeUaz77Yf+RqYu0/94=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=enIfM0fr4opavqjnev9BIoA2rwq7YV4HKw1A+gk0MmPWxspE7RbLC9SZPg6moJ25ljRuLU1SJ+nWB25Q2oBe7W5IMBPX7LykN5yAoOfMLWKaq/Q1/APwO74AzQZ73cmIY1lCSD9z1rqEuqt+pzJHFvGW9w45vAoL/tD8ESO0ICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz16t1789455551t232a42eb
X-QQ-Originating-IP: TaQAtXdlbh5puk/f3ylkSXlRs9hpyTLkzNjwR5mXq9U=
Received: from smtpclient.apple ( [122.233.172.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Sep 2026 14:59:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4557414969768314678
EX-QQ-RecipientCnt: 11
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v5] net: Wangxun: protect ring accesses with RCU
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260915065447.4450-1-mengyuanlou@net-swift.com>
Date: Tue, 15 Sep 2026 14:58:59 +0800
Cc: jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 jacob.e.keller@intel.com,
 richardcochran@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F038541-6AD2-435E-AA52-FA3BD4B4E8A8@net-swift.com>
References: <20260915065447.4450-1-mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MTOSPYkX0VHSTwY9Ze7S0w/4QnLU7BfUtzuXtn6sylOEs6bKFxBWURFC
	u3euGGYTCZOWx58Hl7kGfCdPUQKEHjuY0wggidC8HmMSXebFZbG0fbpJAoxQCnQys5mieB8
	D9Jy/olDBYC0l57yaN9yp4Ht+OC8PGjCvtjnCKq9qIn21taacnpW88/c3a3ht0sStSzgIqS
	WLaE5jgEZ1skDg91NrL7270KR2CxLEzgy5+ApDR41xgBwhA0LPqC1GM4it5ecMSgl/qKpn8
	VGR6onbCyZcgzaY9Goy7pht35Q5558hcLbQ2PhERus8RUTQ/fNFY6eyrzAsRhLNLDFKqeIA
	JXjsaTEsK0fb70ad0r8yRAd8nE4V/yFEvttBvrxXBEFkY2E8eVjkn95/yRDjQc6WyY9m9Cs
	xp3VXzPMaUNN4FPdqa9Cv58iev3wbxZhhYsUEugGEPrrOdNyoeYt8prcgTYoOvxgRV1yidn
	j/A0S4RYH4h1nnxxy8aKSvT92/4b7yebrowb40hukAxjG+pA6ByHgUA4wAyV0+uW+GYqUBG
	P/P1mi+MzQoSLvR3zOWxwGcWOPL0PXKGuefwaM3JfbcgcqMdQ+ZLZugVKKJC9ntkszLac/s
	pDcOtvCUj4dUM9wJwQ74k2yDBu9GLwSoL1B8CFqJNrPTJrrqVRHAjIH8fSvDdrfeVqb2j9x
	cdGmFQAlRwoemZeJ4Rv/I6Yc/wG7SXCOGg6ehXNm5M4sCjt5xtdfwsB291emEn6O9khlFz9
	b03ixtlEKJff72L11MMQ2q0/d8siT+bmk4fINZ3qedlUt0eeUz/jvQfDQnOOO1F9KdTR5sH
	E56Yiyu9vSAwZ5zDigm4hcfVODRadTDX+ZyJCz3ghRPdfiaYclAXsGojnadWmPnCN5rVQ4u
	zr4eRbNsRrmQR/or78LZ2y97KHw+No3Hb+JjZOob2F5jeomOPjahW5sCpRgRlQWE3hbHl9/
	bgk7H/A91snUUgU+ZNfZ4JD5iVADYrLQ9EeQvCmqD39OKtml6EQdiJ6yNmAp4oX8z4sGp+P
	QWtSQyMWjLxi+RmUbMo2Y/Hjcl1wIln+oOZNwGvvuQcvuv1xZEYSG9g13zq6ysbnqJbXhg4
	84EAxsAMHuFPCIIRnOSm3Ekz3qH06vGyZsCbjm8R/X6OP5Q48UdoR3TddafRpfCHQFYy0EH
	W9Adw6nwUnmzoHs=
X-QQ-XMRINFO: MSVp+SPm3vtSEEQF+isFh5nNKOnlizET/w==
X-QQ-RECHKSPAM: 0

Please ignore this patch=EF=BC=8Cthe format should be v6.

> 2026=E5=B9=B49=E6=9C=8815=E6=97=A5 14:54=EF=BC=8CMengyuan Lou =
<mengyuanlou@net-swift.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In the Wangxun driver family, ring pointers in wx->rx_ring[] and
> wx->tx_ring[] can be published, cleared, or replaced during interrupt
> scheme teardown, channel reconfiguration (e.g. via ethtool -L), or
> TC setup.
>=20
> Currently, various lockless readers (such as stats gathering, PTP
> watchdogs, and flow control checks) access per-queue ring structures
> without formal RCU annotations, relying instead on non-atomic state =
bit
> checks. Although q_vector memory lifetime is managed via kfree_rcu(),
> the ring array accesses themselves lack explicit RCU dereference
> semantics and barriers.
>=20
> To harmonize lockless accesses and harden concurrency safety during
> dynamic driver reconfigurations, convert the ring pointer management
> to use standard RCU primitives:
>=20
> 1. Annotate tx_ring[] and rx_ring[] arrays in 'struct wx' with __rcu.
> 2. Enclose lockless reader paths inside RCU read-side critical =
sections
>   (rcu_read_lock/unlock) and access ring pointers via =
rcu_dereference()
>   with NULL guards.
> 3. Use rcu_assign_pointer() when publishing or clearing ring slots
>   during queue vector allocation and teardown.
> 4. Use rcu_dereference_protected() in control paths guarded by locks
>   (e.g., RTNL or reset_lock).
>=20
> Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
> Changelogs:
> v6:
> - Add Fixes tag.
> - Use rcu_dereference_bh in wx_xmit_frame.
> - Use lockdep_is_held(&wx->reset_lock) or lockdep_rtnl_is_held() in
>  rcu_dereference_protected().
> v5: =
https://lore.kernel.org/netdev/20260909090005.79368-1-mengyuanlou@net-swif=
t.com/
> - Switched to rcu_dereference()/rcu_assign_pointer().
> - Since the code involved is extensive, rewrite the patch description =
to
>  suit `net-next` rather than a bug fix, and remove the `Fixes` tag.
> - Solve warnings from Sparse with rcu_dereference_protected().
> v4: =
https://lore.kernel.org/netdev/4353E83B1147D652+20260830070624.7410-1-meng=
yuanlou@net-swift.com/
> - Switched from rcu_dereference()/rcu_assign_pointer() back to
>  READ_ONCE()/WRITE_ONCE().
> - Standardized on READ_ONCE() and WRITE_ONCE() for all ring pointer
>  accesses and assignments across the driver.
> - Added RCU read-side critical sections (rcu_read_lock/unlock) and =
NULL
>  pointer checks to wx_get_ethtool_stats() in wx_ethtool.c and
>  wx_vlan_strip_control() in wx_hw.c.
> - Updated commit message to explicitly document the expanded =
protection
>  in ethtool statistics gathering and VLAN strip configuration tasks.
> v3: =
https://lore.kernel.org/netdev/20260818100841.37483-1-mengyuanlou@net-swif=
t.com/
> - Replaced READ_ONCE() with rcu_dereference() when reading __rcu =
annotated
>  rx_ring and tx_ring pointers to fix Sparse static checker warnings =
and
>  enable Lockdep runtime validation.
> - Wrapped wx_update_xoff_rx_lfc() with its own rcu_read_lock() and
>  rcu_read_unlock() section to ensure self-contained protection =
regardless
>  of caller context.
> - Extended RCU read-side critical sections and NULL pointer checks to =
other
>  background tasks accessing ring arrays, including =
wx_ring_tx_pending(),
>  wx_detect_tx_hang() in wx_err.c, and wx_ptp_rx_hang() in wx_ptp.c.
> - Updated commit message to accurately reflect the use of =
rcu_dereference()
>  and the expanded scope of protected functions.
> v2: =
https://lore.kernel.org/netdev/20260818100841.37483-1-mengyuanlou@net-swif=
t.com/
> - Moved rcu_read_unlock() after wx_update_xoff_rx_lfc() in =
wx_update_stats()
>  to ensure flow control processing remains fully protected within the =
RCU
>  read-side critical section.
> - Replaced WRITE_ONCE() with rcu_assign_pointer() when assigning and =
clearing
>  ring pointers in wx_alloc_q_vector() and wx_free_q_vector(), =
providing
>  proper release memory barrier semantics for lockless RCU readers.
> - Added __rcu annotations to tx_ring and rx_ring in struct wx =
(wx_type.h) to
>  align with Linux kernel RCU coding standards and fix Sparse warnings.
> v1: =
https://lore.kernel.org/netdev/20260813095141.88227-1-mengyuanlou@net-swif=
t.com/
> ---
> drivers/net/ethernet/wangxun/libwx/wx_err.c   | 20 +++-
> .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 14 ++-
> drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 78 +++++++++++----
> drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 94 +++++++++++++------
> drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  6 +-
> drivers/net/ethernet/wangxun/libwx/wx_type.h  |  5 +-
> .../net/ethernet/wangxun/libwx/wx_vf_common.c |  8 +-
> .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  9 +-
> .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  8 +-
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  9 +-
> .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  2 +
> .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 11 ++-
> .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   |  3 +-
> .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  9 +-
> .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  2 +
> 15 files changed, 209 insertions(+), 69 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c =
b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index b56fbdc959de..8eadb4d3abcf 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -201,12 +201,18 @@ static bool wx_ring_tx_pending(struct wx *wx)
> {
> int i;
>=20
> + rcu_read_lock();
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - struct wx_ring *tx_ring =3D wx->tx_ring[i];
> + struct wx_ring *tx_ring =3D rcu_dereference(wx->tx_ring[i]);
>=20
> - if (tx_ring->next_to_use !=3D tx_ring->next_to_clean)
> + if (!tx_ring)
> + continue;
> + if (tx_ring->next_to_use !=3D tx_ring->next_to_clean) {
> + rcu_read_unlock();
> return true;
> + }
> }
> + rcu_read_unlock();
>=20
> return false;
> }
> @@ -264,8 +270,14 @@ static void wx_detect_tx_hang(struct wx *wx)
>=20
> /* Force detection of hung controller */
> if (netif_carrier_ok(wx->netdev)) {
> - for (i =3D 0; i < wx->num_tx_queues; i++)
> - set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
> + rcu_read_lock();
> + for (i =3D 0; i < wx->num_tx_queues; i++) {
> + struct wx_ring *tx_ring =3D rcu_dereference(wx->tx_ring[i]);
> +
> + if (tx_ring)
> + set_bit(WX_TX_DETECT_HANG, tx_ring->state);
> + }
> + rcu_read_unlock();
> }
> }
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c =
b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 940d2e59876c..414523fe83cb 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -154,8 +154,9 @@ void wx_get_ethtool_stats(struct net_device =
*netdev,
> }
> }
>=20
> + rcu_read_lock();
> for (j =3D 0; j < netdev->num_tx_queues; j++) {
> - ring =3D wx->tx_ring[j];
> + ring =3D rcu_dereference(wx->tx_ring[j]);
> if (!ring) {
> data[i++] =3D 0;
> data[i++] =3D 0;
> @@ -170,7 +171,7 @@ void wx_get_ethtool_stats(struct net_device =
*netdev,
> i +=3D 2;
> }
> for (j =3D 0; j < WX_NUM_RX_QUEUES; j++) {
> - ring =3D wx->rx_ring[j];
> + ring =3D rcu_dereference(wx->rx_ring[j]);
> if (!ring) {
> data[i++] =3D 0;
> data[i++] =3D 0;
> @@ -184,6 +185,7 @@ void wx_get_ethtool_stats(struct net_device =
*netdev,
> } while (u64_stats_fetch_retry(&ring->syncp, start));
> i +=3D 2;
> }
> + rcu_read_unlock();
> }
> EXPORT_SYMBOL(wx_get_ethtool_stats);
>=20
> @@ -805,9 +807,13 @@ static int wx_set_ringparam_vf(struct net_device =
*netdev,
>=20
> if (!netif_running(wx->netdev)) {
> for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx->tx_ring[i]->count =3D new_tx_count;
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_is_held(&wx->reset_lock))->count =3D
> + new_tx_count;
> for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx->rx_ring[i]->count =3D new_rx_count;
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_is_held(&wx->reset_lock))->count =3D
> + new_rx_count;
> wx->tx_ring_count =3D new_tx_count;
> wx->rx_ring_count =3D new_rx_count;
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c =
b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 122c4952d203..07e50cdb0b04 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1598,13 +1598,17 @@ static void wx_vlan_strip_control(struct wx =
*wx, bool enable)
> {
> int i, j;
>=20
> + rcu_read_lock();
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - struct wx_ring *ring =3D wx->rx_ring[i];
> + struct wx_ring *ring =3D rcu_dereference(wx->rx_ring[i]);
>=20
> + if (!ring)
> + continue;
> j =3D ring->reg_idx;
> wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
>      enable ? WX_PX_RR_CFG_VLAN : 0);
> }
> + rcu_read_unlock();
> }
>=20
> static void wx_vlan_promisc_enable(struct wx *wx)
> @@ -1797,7 +1801,8 @@ static void wx_set_rx_buffer_len(struct wx *wx)
> * the Base and Length of the Rx Descriptor Ring
> */
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - rx_ring =3D wx->rx_ring[i];
> + rx_ring =3D rcu_dereference_protected(wx->rx_ring[i],
> +    lockdep_rtnl_is_held());
> rx_ring->rx_buf_len =3D WX_RXBUFFER_2K;
> #if (PAGE_SIZE < 8192)
> if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
> @@ -2021,8 +2026,13 @@ static void wx_configure_tx(struct wx *wx)
>      WX_TDM_CTL_TE, WX_TDM_CTL_TE);
>=20
> /* Setup the HW Tx Head and Tail descriptor pointers */
> - for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx_configure_tx_ring(wx, wx->tx_ring[i]);
> + for (i =3D 0; i < wx->num_tx_queues; i++) {
> + struct wx_ring *tx_ring =3D
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_rtnl_is_held());
> +
> + wx_configure_tx_ring(wx, tx_ring);
> + }
>=20
> wr32m(wx, WX_TSC_BUF_AE, WX_TSC_BUF_AE_THR, 0x10);
>=20
> @@ -2247,8 +2257,13 @@ void wx_configure_rx(struct wx *wx)
> /* Setup the HW Rx Head and Tail Descriptor Pointers and
> * the Base and Length of the Rx Descriptor Ring
> */
> - for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx_configure_rx_ring(wx, wx->rx_ring[i]);
> + for (i =3D 0; i < wx->num_rx_queues; i++) {
> + struct wx_ring *rx_ring =3D
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_rtnl_is_held());
> +
> + wx_configure_rx_ring(wx, rx_ring);
> + }
>=20
> /* Enable all receives, disable security engine prior to block traffic =
*/
> ret =3D wx_disable_sec_rx_path(wx);
> @@ -2837,13 +2852,25 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, =
bool rx_pause)
> *  This allows us to avoid head of line blocking for security
> *  and performance reasons.
> */
> + rcu_read_lock();
> if (wx->num_rx_queues > 1 && !tx_pause) {
> - for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx_enable_rx_drop(wx, wx->rx_ring[i]);
> + for (i =3D 0; i < wx->num_rx_queues; i++) {
> + struct wx_ring *rx_ring =3D rcu_dereference(wx->rx_ring[i]);
> +
> + if (!rx_ring)
> + continue;
> + wx_enable_rx_drop(wx, rx_ring);
> + }
> } else {
> - for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx_disable_rx_drop(wx, wx->rx_ring[i]);
> + for (i =3D 0; i < wx->num_rx_queues; i++) {
> + struct wx_ring *rx_ring =3D rcu_dereference(wx->rx_ring[i]);
> +
> + if (!rx_ring)
> + continue;
> + wx_disable_rx_drop(wx, rx_ring);
> + }
> }
> + rcu_read_unlock();
>=20
> return 0;
> }
> @@ -2870,8 +2897,15 @@ static void wx_update_xoff_rx_lfc(struct wx =
*wx)
> if (!data)
> return;
>=20
> - for (i =3D 0; i < wx->num_tx_queues; i++)
> - clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);
> + rcu_read_lock();
> + for (i =3D 0; i < wx->num_tx_queues; i++) {
> + struct wx_ring *tx_ring =3D rcu_dereference(wx->tx_ring[i]);
> +
> + if (!tx_ring)
> + continue;
> + clear_bit(WX_HANG_CHECK_ARMED, tx_ring->state);
> + }
> + rcu_read_unlock();
> }
>=20
> /**
> @@ -2893,10 +2927,13 @@ void wx_update_stats(struct wx *wx)
>=20
> spin_lock(&wx->hw_stats_lock);
>=20
> + rcu_read_lock();
> /* gather some stats to the wx struct that are per queue */
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - struct wx_ring *rx_ring =3D wx->rx_ring[i];
> + struct wx_ring *rx_ring =3D rcu_dereference(wx->rx_ring[i]);
>=20
> + if (!rx_ring)
> + continue;
> non_eop_descs +=3D rx_ring->rx_stats.non_eop_descs;
> alloc_rx_buff_failed +=3D rx_ring->rx_stats.alloc_rx_buff_failed;
> hw_csum_rx_good +=3D rx_ring->rx_stats.csum_good_cnt;
> @@ -2912,19 +2949,28 @@ void wx_update_stats(struct wx *wx)
> u64 rsc_flush =3D 0;
>=20
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - rsc_count +=3D wx->rx_ring[i]->rx_stats.rsc_count;
> - rsc_flush +=3D wx->rx_ring[i]->rx_stats.rsc_flush;
> + struct wx_ring *rx_ring =3D rcu_dereference(wx->rx_ring[i]);
> +
> + if (!rx_ring)
> + continue;
> +
> + rsc_count +=3D rx_ring->rx_stats.rsc_count;
> + rsc_flush +=3D rx_ring->rx_stats.rsc_flush;
> }
> wx->rsc_count =3D rsc_count;
> wx->rsc_flush =3D rsc_flush;
> }
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - struct wx_ring *tx_ring =3D wx->tx_ring[i];
> + struct wx_ring *tx_ring =3D rcu_dereference(wx->tx_ring[i]);
> +
> + if (!tx_ring)
> + continue;
>=20
> restart_queue +=3D tx_ring->tx_stats.restart_queue;
> tx_busy +=3D tx_ring->tx_stats.tx_busy;
> }
> + rcu_read_unlock();
> wx->restart_queue =3D restart_queue;
> wx->tx_busy =3D tx_busy;
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd..bbd670504b27 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1700,6 +1700,7 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
> unsigned int r_idx =3D skb->queue_mapping;
> struct wx *wx =3D netdev_priv(netdev);
> struct wx_ring *tx_ring;
> + u16 num_tx_queues;
>=20
> if (!netif_carrier_ok(netdev)) {
> dev_kfree_skb_any(skb);
> @@ -1712,9 +1713,18 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
> if (skb_put_padto(skb, 17))
> return NETDEV_TX_OK;
>=20
> - if (r_idx >=3D wx->num_tx_queues)
> - r_idx =3D r_idx % wx->num_tx_queues;
> - tx_ring =3D wx->tx_ring[r_idx];
> + num_tx_queues =3D READ_ONCE(wx->num_tx_queues);
> + if (unlikely(!num_tx_queues)) {
> + dev_kfree_skb_any(skb);
> + return NETDEV_TX_OK;
> + }
> + if (r_idx >=3D num_tx_queues)
> + r_idx =3D r_idx % num_tx_queues;
> + tx_ring =3D rcu_dereference_bh(wx->tx_ring[r_idx]);
> + if (unlikely(!tx_ring)) {
> + dev_kfree_skb_any(skb);
> + return NETDEV_TX_OK;
> + }
>=20
> return wx_xmit_frame_ring(skb, tx_ring);
> }
> @@ -2058,26 +2068,30 @@ static bool wx_cache_ring_vmdq(struct wx *wx)
> /* If we are greater than indices move to next pool */
> if ((reg_idx & ~vmdq->mask) >=3D rss->indices)
> reg_idx =3D __ALIGN_MASK(reg_idx, ~vmdq->mask);
> - wx->rx_ring[i]->reg_idx =3D reg_idx;
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_rtnl_is_held())->reg_idx =3D reg_idx;
> }
> reg_idx =3D vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
> for (i =3D 0; i < wx->num_tx_queues; i++, reg_idx++) {
> /* If we are greater than indices move to next pool */
> if ((reg_idx & rss->mask) >=3D rss->indices)
> reg_idx =3D __ALIGN_MASK(reg_idx, ~vmdq->mask);
> - wx->tx_ring[i]->reg_idx =3D reg_idx;
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_rtnl_is_held())->reg_idx =3D reg_idx;
> }
> } else {
> /* start at VMDq register offset for SR-IOV enabled setups */
> reg_idx =3D vmdq->offset;
> for (i =3D 0; i < wx->num_rx_queues; i++)
> /* If we are greater than indices move to next pool */
> - wx->rx_ring[i]->reg_idx =3D reg_idx + i;
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_rtnl_is_held())->reg_idx =3D reg_idx + i;
>=20
> reg_idx =3D vmdq->offset;
> for (i =3D 0; i < wx->num_tx_queues; i++)
> /* If we are greater than indices move to next pool */
> - wx->tx_ring[i]->reg_idx =3D reg_idx + i;
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_rtnl_is_held())->reg_idx =3D reg_idx + i;
> }
>=20
> return true;
> @@ -2098,10 +2112,12 @@ static void wx_cache_ring_rss(struct wx *wx)
> return;
>=20
> for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx->rx_ring[i]->reg_idx =3D i;
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_rtnl_is_held())->reg_idx =3D i;
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx->tx_ring[i]->reg_idx =3D i;
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_rtnl_is_held())->reg_idx =3D i;
> }
>=20
> static void wx_add_ring(struct wx_ring *ring, struct wx_ring_container =
*head)
> @@ -2191,7 +2207,7 @@ static int wx_alloc_q_vector(struct wx *wx,
> ring->queue_index =3D txr_idx;
>=20
> /* assign ring to wx */
> - wx->tx_ring[txr_idx] =3D ring;
> + rcu_assign_pointer(wx->tx_ring[txr_idx], ring);
>=20
> /* update count and index */
> txr_count--;
> @@ -2217,7 +2233,7 @@ static int wx_alloc_q_vector(struct wx *wx,
> ring->queue_index =3D rxr_idx;
>=20
> /* assign ring to wx */
> - wx->rx_ring[rxr_idx] =3D ring;
> + rcu_assign_pointer(wx->rx_ring[rxr_idx], ring);
>=20
> /* update count and index */
> rxr_count--;
> @@ -2245,10 +2261,10 @@ static void wx_free_q_vector(struct wx *wx, =
int v_idx)
> struct wx_ring *ring;
>=20
> wx_for_each_ring(ring, q_vector->tx)
> - wx->tx_ring[ring->queue_index] =3D NULL;
> + rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
>=20
> wx_for_each_ring(ring, q_vector->rx)
> - wx->rx_ring[ring->queue_index] =3D NULL;
> + rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
>=20
> wx->q_vector[v_idx] =3D NULL;
> netif_napi_del(&q_vector->napi);
> @@ -2659,7 +2675,8 @@ void wx_clean_all_rx_rings(struct wx *wx)
> int i;
>=20
> for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx_clean_rx_ring(wx->rx_ring[i]);
> + wx_clean_rx_ring(rcu_dereference_protected(wx->rx_ring[i],
> +   lockdep_rtnl_is_held()));
> }
> EXPORT_SYMBOL(wx_clean_all_rx_rings);
>=20
> @@ -2701,7 +2718,8 @@ static void wx_free_all_rx_resources(struct wx =
*wx)
> int i;
>=20
> for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx_free_rx_resources(wx->rx_ring[i]);
> + wx_free_rx_resources(rcu_dereference_protected(wx->rx_ring[i],
> +       lockdep_rtnl_is_held()));
> }
>=20
> /**
> @@ -2775,7 +2793,8 @@ void wx_clean_all_tx_rings(struct wx *wx)
> int i;
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx_clean_tx_ring(wx->tx_ring[i]);
> + wx_clean_tx_ring(rcu_dereference_protected(wx->tx_ring[i],
> +   lockdep_rtnl_is_held()));
> }
> EXPORT_SYMBOL(wx_clean_all_tx_rings);
>=20
> @@ -2823,7 +2842,8 @@ static void wx_free_all_tx_resources(struct wx =
*wx)
> int i;
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx_free_tx_resources(wx->tx_ring[i]);
> + wx_free_tx_resources(rcu_dereference_protected(wx->tx_ring[i],
> +       lockdep_rtnl_is_held()));
> }
>=20
> void wx_free_resources(struct wx *wx)
> @@ -2933,7 +2953,8 @@ static int wx_setup_all_rx_resources(struct wx =
*wx)
> int i, err =3D 0;
>=20
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - err =3D wx_setup_rx_resources(wx->rx_ring[i]);
> + err =3D =
wx_setup_rx_resources(rcu_dereference_protected(wx->rx_ring[i],
> +      lockdep_rtnl_is_held()));
> if (!err)
> continue;
>=20
> @@ -2945,7 +2966,8 @@ static int wx_setup_all_rx_resources(struct wx =
*wx)
> err_setup_rx:
> /* rewind the index freeing the rings as we go */
> while (i--)
> - wx_free_rx_resources(wx->rx_ring[i]);
> + wx_free_rx_resources(rcu_dereference_protected(wx->rx_ring[i],
> +       lockdep_rtnl_is_held()));
> return err;
> }
>=20
> @@ -3036,7 +3058,8 @@ static int wx_setup_all_tx_resources(struct wx =
*wx)
> int i, err =3D 0;
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - err =3D wx_setup_tx_resources(wx->tx_ring[i]);
> + err =3D =
wx_setup_tx_resources(rcu_dereference_protected(wx->tx_ring[i],
> +      lockdep_rtnl_is_held()));
> if (!err)
> continue;
>=20
> @@ -3048,7 +3071,8 @@ static int wx_setup_all_tx_resources(struct wx =
*wx)
> err_setup_tx:
> /* rewind the index freeing the rings as we go */
> while (i--)
> - wx_free_tx_resources(wx->tx_ring[i]);
> + wx_free_tx_resources(rcu_dereference_protected(wx->tx_ring[i],
> +       lockdep_rtnl_is_held()));
> return err;
> }
>=20
> @@ -3097,7 +3121,7 @@ void wx_get_stats64(struct net_device *netdev,
>=20
> rcu_read_lock();
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - struct wx_ring *ring =3D READ_ONCE(wx->rx_ring[i]);
> + struct wx_ring *ring =3D rcu_dereference(wx->rx_ring[i]);
> u64 bytes, packets;
> unsigned int start;
>=20
> @@ -3113,7 +3137,7 @@ void wx_get_stats64(struct net_device *netdev,
> }
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - struct wx_ring *ring =3D READ_ONCE(wx->tx_ring[i]);
> + struct wx_ring *ring =3D rcu_dereference(wx->tx_ring[i]);
> u64 bytes, packets;
> unsigned int start;
>=20
> @@ -3324,7 +3348,9 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
> */
> if (new_tx_count !=3D wx->tx_ring_count) {
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - memcpy(&temp_ring[i], wx->tx_ring[i],
> + memcpy(&temp_ring[i],
> +       rcu_dereference_protected(wx->tx_ring[i],
> + lockdep_rtnl_is_held()),
>       sizeof(struct wx_ring));
>=20
> temp_ring[i].count =3D new_tx_count;
> @@ -3340,9 +3366,13 @@ int wx_set_ring(struct wx *wx, u32 =
new_tx_count,
> }
>=20
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - wx_free_tx_resources(wx->tx_ring[i]);
> + struct wx_ring *tx_ring =3D
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_rtnl_is_held());
>=20
> - memcpy(wx->tx_ring[i], &temp_ring[i],
> + wx_free_tx_resources(tx_ring);
> +
> + memcpy(tx_ring, &temp_ring[i],
>       sizeof(struct wx_ring));
> }
>=20
> @@ -3352,7 +3382,9 @@ int wx_set_ring(struct wx *wx, u32 new_tx_count,
> /* Repeat the process for the Rx rings if needed */
> if (new_rx_count !=3D wx->rx_ring_count) {
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - memcpy(&temp_ring[i], wx->rx_ring[i],
> + memcpy(&temp_ring[i],
> +       rcu_dereference_protected(wx->rx_ring[i],
> + lockdep_rtnl_is_held()),
>       sizeof(struct wx_ring));
>=20
> temp_ring[i].count =3D new_rx_count;
> @@ -3368,8 +3400,12 @@ int wx_set_ring(struct wx *wx, u32 =
new_tx_count,
> }
>=20
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - wx_free_rx_resources(wx->rx_ring[i]);
> - memcpy(wx->rx_ring[i], &temp_ring[i],
> + struct wx_ring *rx_ring =3D
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_rtnl_is_held());
> +
> + wx_free_rx_resources(rx_ring);
> + memcpy(rx_ring, &temp_ring[i],
>       sizeof(struct wx_ring));
> }
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c =
b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 4708e7f3958f..68dc62977aab 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -274,11 +274,15 @@ static void wx_ptp_rx_hang(struct wx *wx)
>=20
> /* determine the most recent watchdog or rx_timestamp event */
> rx_event =3D wx->last_rx_ptp_check;
> + rcu_read_lock();
> for (n =3D 0; n < wx->num_rx_queues; n++) {
> - rx_ring =3D wx->rx_ring[n];
> + rx_ring =3D rcu_dereference(wx->rx_ring[n]);
> + if (!rx_ring)
> + continue;
> if (time_after(rx_ring->last_rx_timestamp, rx_event))
> rx_event =3D rx_ring->last_rx_timestamp;
> }
> + rcu_read_unlock();
>=20
> /* only need to read the high RXSTMP register to clear the lock */
> if (time_is_before_jiffies(rx_event + 5 * HZ)) {
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h =
b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 9454e90258d8..9d06003259db 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -6,6 +6,7 @@
>=20
> #include <linux/ptp_clock_kernel.h>
> #include <linux/timecounter.h>
> +#include <linux/rtnetlink.h>
> #include <linux/bitfield.h>
> #include <linux/netdevice.h>
> #include <linux/if_vlan.h>
> @@ -1359,8 +1360,8 @@ struct wx {
> u32 tx_ring_count;
> u32 rx_ring_count;
>=20
> - struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
> - struct wx_ring *rx_ring[64];
> + struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
> + struct wx_ring __rcu *rx_ring[64];
> struct wx_q_vector *q_vector[64];
> int num_rx_pools;
> int num_rx_queues_per_pool;
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..93a4d7632ea8 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -17,7 +17,9 @@ int wxvf_suspend(struct device *dev_d)
> struct wx *wx =3D pci_get_drvdata(pdev);
>=20
> netif_device_detach(wx->netdev);
> + rtnl_lock();
> wx_clear_interrupt_scheme(wx);
> + rtnl_unlock();
> pci_disable_device(pdev);
>=20
> return 0;
> @@ -36,8 +38,10 @@ int wxvf_resume(struct device *dev_d)
> struct wx *wx =3D pci_get_drvdata(pdev);
>=20
> pci_set_master(pdev);
> + rtnl_lock();
> wx_init_interrupt_scheme(wx);
> netif_device_attach(wx->netdev);
> + rtnl_unlock();
>=20
> return 0;
> }
> @@ -205,7 +209,9 @@ static void wx_configure_rx_vf(struct wx *wx)
> * the Base and Length of the Rx Descriptor Ring
> */
> for (i =3D 0; i < wx->num_rx_queues; i++) {
> - struct wx_ring *rx_ring =3D wx->rx_ring[i];
> + struct wx_ring *rx_ring =3D
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_rtnl_is_held());
> #ifdef HAVE_SWIOTLB_SKIP_CPU_SYNC
> wx_set_rx_buffer_len_vf(wx, rx_ring);
> #endif
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> index 7325b475ee10..d3bb9b4f22a3 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> @@ -175,8 +175,13 @@ void wx_configure_tx_vf(struct wx *wx)
> u32 i;
>=20
> /* Setup the HW Tx Head and Tail descriptor pointers */
> - for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx_configure_tx_ring_vf(wx, wx->tx_ring[i]);
> + for (i =3D 0; i < wx->num_tx_queues; i++) {
> + struct wx_ring *tx_ring =3D
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_rtnl_is_held());
> +
> + wx_configure_tx_ring_vf(wx, tx_ring);
> + }
> }
>=20
> static void wx_configure_srrctl_vf(struct wx *wx, struct wx_ring =
*ring,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index 1960f7154151..09a9727b6437 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -37,9 +37,13 @@ static int ngbe_set_ringparam(struct net_device =
*netdev,
>=20
> if (!netif_running(wx->netdev)) {
> for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx->tx_ring[i]->count =3D new_tx_count;
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_is_held(&wx->reset_lock))->count =3D
> + new_tx_count;
> for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx->rx_ring[i]->count =3D new_rx_count;
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_is_held(&wx->reset_lock))->count =3D
> + new_rx_count;
> wx->tx_ring_count =3D new_tx_count;
> wx->rx_ring_count =3D new_rx_count;
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610..c670f4eb2759 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -406,7 +406,9 @@ static void ngbe_disable_device(struct wx *wx)
> /* disable all enabled rx queues */
> for (i =3D 0; i < wx->num_rx_queues; i++)
> /* this call also flushes the previous write */
> - wx_disable_rx_queue(wx, wx->rx_ring[i]);
> + wx_disable_rx_queue(wx,
> +    rcu_dereference_protected(wx->rx_ring[i],
> +      lockdep_rtnl_is_held()));
> /* disable receives */
> wx_disable_rx(wx);
> wx_napi_disable_all(wx);
> @@ -422,7 +424,8 @@ static void ngbe_disable_device(struct wx *wx)
> wx_irq_disable(wx);
> /* disable transmits in the hardware now that interrupts are off */
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - u8 reg_idx =3D wx->tx_ring[i]->reg_idx;
> + u8 reg_idx =3D rcu_dereference_protected(wx->tx_ring[i],
> +       lockdep_rtnl_is_held())->reg_idx;
>=20
> wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
> }
> @@ -866,7 +869,9 @@ static int ngbe_probe(struct pci_dev *pdev,
>=20
> ngbe_init_service(wx);
>=20
> + rtnl_lock();
> err =3D wx_init_interrupt_scheme(wx);
> + rtnl_unlock();
> if (err)
> goto err_cancel_service;
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c =
b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> index d79cf8d8484f..aac88c77d3b8 100644
> --- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> @@ -202,7 +202,9 @@ static int ngbevf_probe(struct pci_dev *pdev,
> ether_addr_copy(netdev->perm_addr, wx->mac.addr);
>=20
> wxvf_init_service(wx);
> + rtnl_lock();
> err =3D wx_init_interrupt_scheme(wx);
> + rtnl_unlock();
> if (err)
> goto err_free_sw_init;
>=20
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index 3e32aca72806..6523d0e7e237 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> @@ -61,9 +61,13 @@ static int txgbe_set_ringparam(struct net_device =
*netdev,
>=20
> if (!netif_running(wx->netdev)) {
> for (i =3D 0; i < wx->num_tx_queues; i++)
> - wx->tx_ring[i]->count =3D new_tx_count;
> + rcu_dereference_protected(wx->tx_ring[i],
> +  lockdep_is_held(&wx->reset_lock))->count =3D
> + new_tx_count;
> for (i =3D 0; i < wx->num_rx_queues; i++)
> - wx->rx_ring[i]->count =3D new_rx_count;
> + rcu_dereference_protected(wx->rx_ring[i],
> +  lockdep_is_held(&wx->reset_lock))->count =3D
> + new_rx_count;
> wx->tx_ring_count =3D new_tx_count;
> wx->rx_ring_count =3D new_rx_count;
>=20
> @@ -366,7 +370,8 @@ static int txgbe_add_ethtool_fdir_entry(struct =
txgbe *txgbe,
>=20
> /* Map the ring onto the absolute queue index */
> if (!vf)
> - queue =3D wx->rx_ring[ring]->reg_idx;
> + queue =3D rcu_dereference_protected(wx->rx_ring[ring],
> +  lockdep_rtnl_is_held())->reg_idx;
> else
> queue =3D ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
> }
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> index a84010828551..9fa1006f2f60 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> @@ -599,7 +599,8 @@ static void txgbe_fdir_filter_restore(struct wx =
*wx)
> }
>=20
> /* Map the ring onto the absolute queue index */
> - queue =3D wx->rx_ring[ring]->reg_idx;
> + queue =3D rcu_dereference_protected(wx->rx_ring[ring],
> +  lockdep_rtnl_is_held())->reg_idx;
> }
>=20
> ret =3D txgbe_fdir_write_perfect_filter(wx,
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index eb91c4f28ecd..3d2f99e272ad 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -239,7 +239,9 @@ static void txgbe_disable_device(struct wx *wx)
> /* disable all enabled rx queues */
> for (i =3D 0; i < wx->num_rx_queues; i++)
> /* this call also flushes the previous write */
> - wx_disable_rx_queue(wx, wx->rx_ring[i]);
> + wx_disable_rx_queue(wx,
> +    rcu_dereference_protected(wx->rx_ring[i],
> +      lockdep_rtnl_is_held()));
>=20
> netif_tx_stop_all_queues(netdev);
> netif_tx_disable(netdev);
> @@ -275,7 +277,8 @@ static void txgbe_disable_device(struct wx *wx)
>=20
> /* disable transmits in the hardware now that interrupts are off */
> for (i =3D 0; i < wx->num_tx_queues; i++) {
> - u8 reg_idx =3D wx->tx_ring[i]->reg_idx;
> + u8 reg_idx =3D rcu_dereference_protected(wx->tx_ring[i],
> + lockdep_rtnl_is_held())->reg_idx;
>=20
> wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
> }
> @@ -865,7 +868,9 @@ static int txgbe_probe(struct pci_dev *pdev,
>=20
> txgbe_init_service(wx);
>=20
> + rtnl_lock();
> err =3D wx_init_interrupt_scheme(wx);
> + rtnl_unlock();
> if (err)
> goto err_cancel_service;
>=20
> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c =
b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> index 8b16b900820a..a4a829c65336 100644
> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> @@ -267,7 +267,9 @@ static int txgbevf_probe(struct pci_dev *pdev,
> ether_addr_copy(netdev->perm_addr, wx->mac.addr);
>=20
> wxvf_init_service(wx);
> + rtnl_lock();
> err =3D wx_init_interrupt_scheme(wx);
> + rtnl_unlock();
> if (err)
> goto err_free_sw_init;
>=20
> --=20
> 2.30.1
>=20

