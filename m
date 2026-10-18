Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514A2D662F
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792316562; cv=none; b=tpgnns3Zsx7sD/cBnrpqOXOeHor2bH0p4IIWTazmhWepJhDFHfNxExwJm3lQxM9I+OE70juzNXPlOa2bhCYTDIGewfYDPra6IMK0KPs/MU6C0OmL10njmK2fHSoj3xLRDOjfr9ZlZ1l9nSURo6ynIAt9opUfQN5d7vNyQHetnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792316562; c=relaxed/simple;
	bh=9C4T7YW/LVnB/UMRYsZiOBKN94yN5lGUdgLBOGDPFgs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US8tUUZz0Fc2tSHt0QkeIk9VY8pNMNg3uNonAw6PjrHHMZtiuix0MlUyvyEGkx/S31D32qNq1hcoc4Ey6dfl4KbOjWG79J8OWlVAMvSQe7mz4NxY4xpRIh9GngAnuSb6aQmN91jKs0u0G3qQt5rCkQ1AKTzbZpbnySU4lyHwSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trip-g.com; spf=pass smtp.mailfrom=trip-g.com; dkim=pass (2048-bit key) header.d=trip-g.com header.i=@trip-g.com header.b=ZxPsLz/3; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trip-g.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trip-g.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trip-g.com header.i=@trip-g.com header.b="ZxPsLz/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trip-g.com;
	s=protonmail2; t=1792316553; x=1792575753;
	bh=ETZs2hXk05/q2PPUutP4Iry1ao6GM/V9Us+KvT4SOMo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZxPsLz/3tTkvOIqJfrogq2LDCNRzD7nDVGMvecYkN/PAOv7xrp0xCvyFyWK26EKZ+
	 M0Myv2twNVnfju3FIyawJWPtiUi6gpzJDzCpOSTo1dKlMcn98g+FMo2MSwQU8Vi6B4
	 2i9mEx1AoARoXpoV5TpwFu1N5RqKVj+84jzQ+9NN7NT70KnTchrGMgtYQhh7ctf94H
	 DJITf5RUmLB3lVLKLneoWrcU4QwEitAe1UOEmxb0vI9/rV+kbU8CfrRvw4EjsmEezn
	 ttSJANb2Nyri5rJQEuwBQ8srV1cdSbFy3kKuKIZWQ+L8DC8LWChaTb1b9BXDiqTaRN
	 drYAkl2u75UcA==
Date: Sun, 18 Oct 2026 09:42:26 +0000
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org
From: Gregg <gregg@trip-g.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next 2/3] net: ethernet: mtk_eth_soc: fix ppe flow accounting for L2 flows
Message-ID: <a446e827-9aee-4e26-aacc-3a99f8bdf6e6@trip-g.com>
In-Reply-To: <83915a1e-0706-4081-9c2a-06051dc019f8@trip-g.com>
References: <83915a1e-0706-4081-9c2a-06051dc019f8@trip-g.com>
Feedback-ID: 34488774:user:proton
X-Pm-Message-ID: b54c4d3e5f5aa793c2de5b11aa1375bf05372e5f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A second, smaller gap in the same branch, found while testing the fix
above.

When the entry still holds this flow's data and only its state has
changed (for example to FIN when the connection closes), the branch
folds the acct value from the previous MIB read. The traffic counted
since that read is never read and is lost. Mainline doesn't have this
gap: it keeps calling mtk_foe_entry_get_mib() for as long as the entry
matches, whatever its state.

Reading the MIB a final time when the data still matches closes it.
When another flow owns the hash, the counters aren't ours, so the
cached value stays right. On top of the previous fix:

--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -568,6 +568,7 @@ mtk_flow_entry_update(struct mtk_ppe *ppe, struct
mtk_flow_entry *entry,
 =09struct mtk_foe_entry *hwe;
 =09u16 hash =3D entry->hash;
 =09bool ret =3D false;
+=09bool matched;
 =09int len;

 =09if (hash =3D=3D 0xffff)
@@ -577,9 +578,18 @@ mtk_flow_entry_update(struct mtk_ppe *ppe, struct
mtk_flow_entry *entry,
 =09len =3D mtk_flow_entry_match_len(ppe->eth, &entry->data);
 =09memcpy(&foe, hwe, len);

-=09if (!mtk_flow_entry_match(ppe->eth, entry, &foe, len) ||
+=09matched =3D mtk_flow_entry_match(ppe->eth, entry, &foe, len);
+=09if (!matched ||
 =09    FIELD_GET(MTK_FOE_IB1_STATE, foe.ib1) !=3D MTK_FOE_STATE_BIND) {
-=09=09acct =3D mtk_ppe_acct_data(ppe, hash);
+=09=09/* Still this flow's entry, only no longer bound (e.g. after a
+=09=09 * FIN): read the counters a last time, or the traffic since the
+=09=09 * previous poll is lost. If another flow owns the hash now, its
+=09=09 * counters are not ours: use what was read before.
+=09=09 */
+=09=09if (matched)
+=09=09=09acct =3D mtk_ppe_mib_entry_read(ppe, hash);
+=09=09else
+=09=09=09acct =3D mtk_ppe_acct_data(ppe, hash);
 =09=09if (acct) {
 =09=09=09entry->prev_packets +=3D acct->packets;
 =09=09=09entry->prev_bytes +=3D acct->bytes;

This only matters if something asks for stats after the entry leaves
BIND. With netfilter as it is, that's whichever periodic poll happens
to land between the FIN and the delete. Locally we also have
flow_offload_work_del() query the stats once before deleting the hw
entries, so a closing flow always gets that final read. That's a
separate netfilter change, not part of this driver.

Same test as before (100 MiB download, MT7622, the previous fix plus
the netfilter change), with the server closing right after the data:

  without this change, 28 Mbit/s:  109,270,558  (about 1 MB short)
  with it, 44 Mbit/s:              110,270,254
  with it, 8 Mbit/s:               110,271,680
  with it, 100 MiB + 45 s idle:    110,270,254

The real value is about 110.27 MB, so every run with it is exact. It
also applies with no fuzz on top of the previous fix on OpenWrt main's
6.12.112 and 6.18.55.

Thanks,
gregg


On 2026-10-17 16:42, Gregg wrote:
> Hi Felix,
>=20
> OpenWrt still carries this series as pending-6.12/736-03 and 736-04
> (and the same in pending-6.18). On an MT7622 router (Linksys E8450,
> OpenWrt 25.12.5, 6.12.94, flow_offloading_hw=3D1) we found that it
> over-counts conntrack bytes by a large factor. The hunk below in
> mtk_flow_entry_update() is where it happens:
>=20
>>  =09if (!mtk_flow_entry_match(ppe->eth, entry, &foe, len) ||
>> -=09    FIELD_GET(MTK_FOE_IB1_STATE, foe.ib1) !=3D MTK_FOE_STATE_BIND)
>> -=09=09return false;
>> +=09    FIELD_GET(MTK_FOE_IB1_STATE, foe.ib1) !=3D MTK_FOE_STATE_BIND) {
>> +=09=09acct =3D mtk_ppe_acct_data(ppe, hash);
>> +=09=09if (acct) {
>> +=09=09=09entry->prev_packets +=3D acct->packets;
>> +=09=09=09entry->prev_bytes +=3D acct->bytes;
>> +=09=09}
>> +
>> +=09=09goto out;
>> +=09}
>=20
> 1/3 dropped the "entry->hash =3D 0xffff" that this branch had before, so
> the hash stays set after the PPE ages the entry out. Every later
> FLOW_CLS_STATS poll takes this branch again: it folds the same acct
> values into prev_* and adds them to *packets/*bytes once more.
> mtk_flow_offload_stats() reports the difference, so conntrack grows by
> the flow's whole total on every poll.
>=20
> nf_flow_offload_stats() asks for stats on every flowtable GC run (1 s)
> once less than 90% of the offload timeout remains. After the PPE
> unbinds an idle entry (TCP bind age 7 ticks), lastused stops moving, so
> the flow is polled every second until it expires about 30 s after its
> last packet.
>=20
> Measured with one TCP flow through the router: the client downloads
> exactly 100 MiB, then the server keeps the connection open and idle for
> 60 s. conntrack -L was read every 2 s:
>=20
>   download (reply) bytes      stock        with the fix below
>   after the transfer          110,270,150  110,271,646
>   after the PPE ages it out   +~110 MB/s   unchanged
>   final                       1,102,320,800 (10x)  110,271,646
>=20
> The upload direction went to 18x of the real value without the fix and
> stayed correct with it. On a home router with everyday traffic,
> conntrack/ulogd totals since boot were about 3x the WAN switch port's
> MIB counters.
>=20
> Putting the reset back fixes it. The poll that notices the unbind still
> adds the folded counters once, through out:, and later polls return
> early on hash =3D=3D 0xffff. Rebinding is unchanged, because
> __mtk_ppe_check_skb() finds the flow through its foe_flow bucket and
> sets entry->hash again. On top of this patch (as in OpenWrt):
>=20
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -585,6 +585,11 @@ mtk_flow_entry_update(struct mtk_ppe *ppe, struct
> mtk_flow_entry *entry,
>  =09=09=09entry->prev_bytes +=3D acct->bytes;
>  =09=09}
>=20
> +=09=09/* The hw entry is gone (aged out, unbound or reused by another
> +=09=09 * flow): its counters are now folded into prev_*. Forget the
> +=09=09 * hash, or every later stats poll folds them in again.
> +=09=09 */
> +=09=09entry->hash =3D 0xffff;
>  =09=09goto out;
>  =09}
>=20
> It applies with no fuzz on OpenWrt main's 6.12.112 and 6.18.55 copies
> of the series. Could you fold it into the patch.
> One more thing I noticed while reading, not tested: in
> mtk_flow_entry_update_l2(), when a subflow is gone,
> __mtk_foe_entry_clear(ppe, entry, false) is called on the L2 parent
> entry instead of on cur. Is that intended?
>=20
> Thanks,
> Gregg
>=20
> On 2023-03-31 04:29, Felix Fietkau wrote:
>> For L2 flows, the packet/byte counters should report the sum of the
>> counters of their subflows, both current and expired.
>> In order to make this work, change the way that accounting data is track=
ed.
>> Reset counters when a flow enters bind. Once it expires (or enters unbin=
d),
>> store the last counter value in struct mtk_flow_entry.
>>
>> Fixes: 3fbe4d8c0e53 ("net: ethernet: mtk_eth_soc: ppe: add support for f=
low accounting")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>  drivers/net/ethernet/mediatek/mtk_ppe.c       | 137 ++++++++++--------
>>  drivers/net/ethernet/mediatek/mtk_ppe.h       |   8 +-
>>  .../net/ethernet/mediatek/mtk_ppe_debugfs.c   |   2 +-
>>  .../net/ethernet/mediatek/mtk_ppe_offload.c   |  17 +--
>>  4 files changed, 88 insertions(+), 76 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ether=
net/mediatek/mtk_ppe.c
>> index e9bcbdbe9c12..64e8dc8d814b 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
>> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
>> @@ -80,9 +80,9 @@ static int mtk_ppe_mib_wait_busy(struct mtk_ppe *ppe)
>>  =09int ret;
>>  =09u32 val;
>> =20
>> -=09ret =3D readl_poll_timeout(ppe->base + MTK_PPE_MIB_SER_CR, val,
>> -=09=09=09=09 !(val & MTK_PPE_MIB_SER_CR_ST),
>> -=09=09=09=09 20, MTK_PPE_WAIT_TIMEOUT_US);
>> +=09ret =3D readl_poll_timeout_atomic(ppe->base + MTK_PPE_MIB_SER_CR, va=
l,
>> +=09=09=09=09=09!(val & MTK_PPE_MIB_SER_CR_ST),
>> +=09=09=09=09=0920, MTK_PPE_WAIT_TIMEOUT_US);
>> =20
>>  =09if (ret)
>>  =09=09dev_err(ppe->dev, "MIB table busy");
>> @@ -90,18 +90,32 @@ static int mtk_ppe_mib_wait_busy(struct mtk_ppe *ppe=
)
>>  =09return ret;
>>  }
>> =20
>> -static int mtk_mib_entry_read(struct mtk_ppe *ppe, u16 index, u64 *byte=
s, u64 *packets)
>> +static inline struct mtk_foe_accounting *
>> +mtk_ppe_acct_data(struct mtk_ppe *ppe, u16 index)
>> +{
>> +=09if (!ppe->acct_table)
>> +=09=09return NULL;
>> +
>> +=09return ppe->acct_table + index * sizeof(struct mtk_foe_accounting);
>> +}
>> +
>> +struct mtk_foe_accounting *mtk_ppe_mib_entry_read(struct mtk_ppe *ppe, =
u16 index)
>>  {
>>  =09u32 byte_cnt_low, byte_cnt_high, pkt_cnt_low, pkt_cnt_high;
>>  =09u32 val, cnt_r0, cnt_r1, cnt_r2;
>> +=09struct mtk_foe_accounting *acct;
>>  =09int ret;
>> =20
>>  =09val =3D FIELD_PREP(MTK_PPE_MIB_SER_CR_ADDR, index) | MTK_PPE_MIB_SER=
_CR_ST;
>>  =09ppe_w32(ppe, MTK_PPE_MIB_SER_CR, val);
>> =20
>> +=09acct =3D mtk_ppe_acct_data(ppe, index);
>> +=09if (!acct)
>> +=09=09return NULL;
>> +
>>  =09ret =3D mtk_ppe_mib_wait_busy(ppe);
>>  =09if (ret)
>> -=09=09return ret;
>> +=09=09return acct;
>> =20
>>  =09cnt_r0 =3D readl(ppe->base + MTK_PPE_MIB_SER_R0);
>>  =09cnt_r1 =3D readl(ppe->base + MTK_PPE_MIB_SER_R1);
>> @@ -111,10 +125,11 @@ static int mtk_mib_entry_read(struct mtk_ppe *ppe,=
 u16 index, u64 *bytes, u64 *p
>>  =09byte_cnt_high =3D FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1=
);
>>  =09pkt_cnt_low =3D FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
>>  =09pkt_cnt_high =3D FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
>> -=09*bytes =3D ((u64)byte_cnt_high << 32) | byte_cnt_low;
>> -=09*packets =3D (pkt_cnt_high << 16) | pkt_cnt_low;
>> =20
>> -=09return 0;
>> +=09acct->bytes +=3D ((u64)byte_cnt_high << 32) | byte_cnt_low;
>> +=09acct->packets +=3D (pkt_cnt_high << 16) | pkt_cnt_low;
>> +
>> +=09return acct;
>>  }
>> =20
>>  static void mtk_ppe_cache_clear(struct mtk_ppe *ppe)
>> @@ -503,14 +518,6 @@ __mtk_foe_entry_clear(struct mtk_ppe *ppe, struct m=
tk_flow_entry *entry,
>>  =09=09hwe->ib1 |=3D FIELD_PREP(MTK_FOE_IB1_STATE, MTK_FOE_STATE_INVALID=
);
>>  =09=09dma_wmb();
>>  =09=09mtk_ppe_cache_clear(ppe);
>> -
>> -=09=09if (ppe->accounting) {
>> -=09=09=09struct mtk_foe_accounting *acct;
>> -
>> -=09=09=09acct =3D ppe->acct_table + entry->hash * sizeof(*acct);
>> -=09=09=09acct->packets =3D 0;
>> -=09=09=09acct->bytes =3D 0;
>> -=09=09}
>>  =09}
>>  =09entry->hash =3D 0xffff;
>> =20
>> @@ -535,11 +542,14 @@ static int __mtk_foe_entry_idle_time(struct mtk_pp=
e *ppe, u32 ib1)
>>  }
>> =20
>>  static bool
>> -mtk_flow_entry_update(struct mtk_ppe *ppe, struct mtk_flow_entry *entry=
)
>> +mtk_flow_entry_update(struct mtk_ppe *ppe, struct mtk_flow_entry *entry=
,
>> +=09=09      u64 *packets, u64 *bytes)
>>  {
>> +=09struct mtk_foe_accounting *acct;
>>  =09struct mtk_foe_entry foe =3D {};
>>  =09struct mtk_foe_entry *hwe;
>>  =09u16 hash =3D entry->hash;
>> +=09bool ret =3D false;
>>  =09int len;
>> =20
>>  =09if (hash =3D=3D 0xffff)
>> @@ -550,18 +560,35 @@ mtk_flow_entry_update(struct mtk_ppe *ppe, struct =
mtk_flow_entry *entry)
>>  =09memcpy(&foe, hwe, len);
>> =20
>>  =09if (!mtk_flow_entry_match(ppe->eth, entry, &foe, len) ||
>> -=09    FIELD_GET(MTK_FOE_IB1_STATE, foe.ib1) !=3D MTK_FOE_STATE_BIND)
>> -=09=09return false;
>> +=09    FIELD_GET(MTK_FOE_IB1_STATE, foe.ib1) !=3D MTK_FOE_STATE_BIND) {
>> +=09=09acct =3D mtk_ppe_acct_data(ppe, hash);
>> +=09=09if (acct) {
>> +=09=09=09entry->prev_packets +=3D acct->packets;
>> +=09=09=09entry->prev_bytes +=3D acct->bytes;
>> +=09=09}
>> +
>> +=09=09goto out;
>> +=09}
>> =20
>>  =09entry->data.ib1 =3D foe.ib1;
>> +=09acct =3D mtk_ppe_mib_entry_read(ppe, hash);
>> +=09ret =3D true;
>> =20
>> -=09return true;
>> +out:
>> +=09if (acct) {
>> +=09=09*packets +=3D acct->packets;
>> +=09=09*bytes +=3D acct->bytes;
>> +=09}
>> +
>> +=09return ret;
>>  }
>> =20
>>  static void
>>  mtk_flow_entry_update_l2(struct mtk_ppe *ppe, struct mtk_flow_entry *en=
try)
>>  {
>>  =09u32 ib1_ts_mask =3D mtk_get_ib1_ts_mask(ppe->eth);
>> +=09u64 *packets =3D &entry->packets;
>> +=09u64 *bytes =3D &entry->bytes;
>>  =09struct mtk_flow_entry *cur;
>>  =09struct hlist_node *tmp;
>>  =09int idle;
>> @@ -570,7 +597,9 @@ mtk_flow_entry_update_l2(struct mtk_ppe *ppe, struct=
 mtk_flow_entry *entry)
>>  =09hlist_for_each_entry_safe(cur, tmp, &entry->l2_flows, l2_list) {
>>  =09=09int cur_idle;
>> =20
>> -=09=09if (!mtk_flow_entry_update(ppe, cur)) {
>> +=09=09if (!mtk_flow_entry_update(ppe, cur, packets, bytes)) {
>> +=09=09=09entry->prev_packets +=3D cur->prev_packets;
>> +=09=09=09entry->prev_bytes +=3D cur->prev_bytes;
>>  =09=09=09__mtk_foe_entry_clear(ppe, entry, false);
>>  =09=09=09continue;
>>  =09=09}
>> @@ -585,10 +614,29 @@ mtk_flow_entry_update_l2(struct mtk_ppe *ppe, stru=
ct mtk_flow_entry *entry)
>>  =09}
>>  }
>> =20
>> +void mtk_foe_entry_get_stats(struct mtk_ppe *ppe, struct mtk_flow_entry=
 *entry,
>> +=09=09=09     int *idle)
>> +{
>> +=09entry->packets =3D entry->prev_packets;
>> +=09entry->bytes =3D entry->prev_bytes;
>> +
>> +=09spin_lock_bh(&ppe_lock);
>> +
>> +=09if (entry->type =3D=3D MTK_FLOW_TYPE_L2)
>> +=09=09mtk_flow_entry_update_l2(ppe, entry);
>> +=09else
>> +=09=09mtk_flow_entry_update(ppe, entry, &entry->packets, &entry->bytes)=
;
>> +
>> +=09*idle =3D __mtk_foe_entry_idle_time(ppe, entry->data.ib1);
>> +
>> +=09spin_unlock_bh(&ppe_lock);
>> +}
>> +
>>  static void
>>  __mtk_foe_entry_commit(struct mtk_ppe *ppe, struct mtk_foe_entry *entry=
,
>>  =09=09       u16 hash)
>>  {
>> +=09struct mtk_foe_accounting *acct;
>>  =09struct mtk_eth *eth =3D ppe->eth;
>>  =09u16 timestamp =3D mtk_eth_timestamp(eth);
>>  =09struct mtk_foe_entry *hwe;
>> @@ -613,6 +661,12 @@ __mtk_foe_entry_commit(struct mtk_ppe *ppe, struct =
mtk_foe_entry *entry,
>> =20
>>  =09dma_wmb();
>> =20
>> +=09acct =3D mtk_ppe_mib_entry_read(ppe, hash);
>> +=09if (acct) {
>> +=09=09acct->packets =3D 0;
>> +=09=09acct->bytes =3D 0;
>> +=09}
>> +
>>  =09mtk_ppe_cache_clear(ppe);
>>  }
>> =20
>> @@ -777,21 +831,6 @@ void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struc=
t sk_buff *skb, u16 hash)
>>  =09spin_unlock_bh(&ppe_lock);
>>  }
>> =20
>> -int mtk_foe_entry_idle_time(struct mtk_ppe *ppe, struct mtk_flow_entry =
*entry)
>> -{
>> -=09int idle;
>> -
>> -=09spin_lock_bh(&ppe_lock);
>> -=09if (entry->type =3D=3D MTK_FLOW_TYPE_L2)
>> -=09=09mtk_flow_entry_update_l2(ppe, entry);
>> -=09else
>> -=09=09mtk_flow_entry_update(ppe, entry);
>> -=09idle =3D __mtk_foe_entry_idle_time(ppe, entry->data.ib1);
>> -=09spin_unlock_bh(&ppe_lock);
>> -
>> -=09return idle;
>> -}
>> -
>>  int mtk_ppe_prepare_reset(struct mtk_ppe *ppe)
>>  {
>>  =09if (!ppe)
>> @@ -819,32 +858,6 @@ int mtk_ppe_prepare_reset(struct mtk_ppe *ppe)
>>  =09return mtk_ppe_wait_busy(ppe);
>>  }
>> =20
>> -struct mtk_foe_accounting *mtk_foe_entry_get_mib(struct mtk_ppe *ppe, u=
32 index,
>> -=09=09=09=09=09=09 struct mtk_foe_accounting *diff)
>> -{
>> -=09struct mtk_foe_accounting *acct;
>> -=09int size =3D sizeof(struct mtk_foe_accounting);
>> -=09u64 bytes, packets;
>> -
>> -=09if (!ppe->accounting)
>> -=09=09return NULL;
>> -
>> -=09if (mtk_mib_entry_read(ppe, index, &bytes, &packets))
>> -=09=09return NULL;
>> -
>> -=09acct =3D ppe->acct_table + index * size;
>> -
>> -=09acct->bytes +=3D bytes;
>> -=09acct->packets +=3D packets;
>> -
>> -=09if (diff) {
>> -=09=09diff->bytes =3D bytes;
>> -=09=09diff->packets =3D packets;
>> -=09}
>> -
>> -=09return acct;
>> -}
>> -
>>  struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, i=
nt index)
>>  {
>>  =09bool accounting =3D eth->soc->has_accounting;
>> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ether=
net/mediatek/mtk_ppe.h
>> index 6823256016a2..13dd7988e95c 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_ppe.h
>> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
>> @@ -283,6 +283,8 @@ struct mtk_flow_entry {
>>  =09struct mtk_foe_entry data;
>>  =09struct rhash_head node;
>>  =09unsigned long cookie;
>> +=09u64 prev_packets, prev_bytes;
>> +=09u64 packets, bytes;
>>  };
>> =20
>>  struct mtk_mib_entry {
>> @@ -327,6 +329,7 @@ void mtk_ppe_deinit(struct mtk_eth *eth);
>>  void mtk_ppe_start(struct mtk_ppe *ppe);
>>  int mtk_ppe_stop(struct mtk_ppe *ppe);
>>  int mtk_ppe_prepare_reset(struct mtk_ppe *ppe);
>> +struct mtk_foe_accounting *mtk_ppe_mib_entry_read(struct mtk_ppe *ppe, =
u16 index);
>> =20
>>  void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struct sk_buff *skb, u16 =
hash);
>> =20
>> @@ -375,9 +378,8 @@ int mtk_foe_entry_set_queue(struct mtk_eth *eth, str=
uct mtk_foe_entry *entry,
>>  =09=09=09    unsigned int queue);
>>  int mtk_foe_entry_commit(struct mtk_ppe *ppe, struct mtk_flow_entry *en=
try);
>>  void mtk_foe_entry_clear(struct mtk_ppe *ppe, struct mtk_flow_entry *en=
try);
>> -int mtk_foe_entry_idle_time(struct mtk_ppe *ppe, struct mtk_flow_entry =
*entry);
>>  int mtk_ppe_debugfs_init(struct mtk_ppe *ppe, int index);
>> -struct mtk_foe_accounting *mtk_foe_entry_get_mib(struct mtk_ppe *ppe, u=
32 index,
>> -=09=09=09=09=09=09 struct mtk_foe_accounting *diff);
>> +void mtk_foe_entry_get_stats(struct mtk_ppe *ppe, struct mtk_flow_entry=
 *entry,
>> +=09=09=09     int *idle);
>> =20
>>  #endif
>> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c b/drivers/n=
et/ethernet/mediatek/mtk_ppe_debugfs.c
>> index 53cf87e9acbb..c13acdbb874c 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
>> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
>> @@ -96,7 +96,7 @@ mtk_ppe_debugfs_foe_show(struct seq_file *m, void *pri=
vate, bool bind)
>>  =09=09if (bind && state !=3D MTK_FOE_STATE_BIND)
>>  =09=09=09continue;
>> =20
>> -=09=09acct =3D mtk_foe_entry_get_mib(ppe, i, NULL);
>> +=09=09acct =3D mtk_ppe_mib_entry_read(ppe, i);
>> =20
>>  =09=09type =3D FIELD_GET(MTK_FOE_IB1_PACKET_TYPE, entry->ib1);
>>  =09=09seq_printf(m, "%05x %s %7s", i,
>> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/n=
et/ethernet/mediatek/mtk_ppe_offload.c
>> index c9cb317b7a2d..f1e8cdac5792 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
>> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
>> @@ -499,24 +499,21 @@ static int
>>  mtk_flow_offload_stats(struct mtk_eth *eth, struct flow_cls_offload *f)
>>  {
>>  =09struct mtk_flow_entry *entry;
>> -=09struct mtk_foe_accounting diff;
>> -=09u32 idle;
>> +=09u64 packets, bytes;
>> +=09int idle;
>> =20
>>  =09entry =3D rhashtable_lookup(&eth->flow_table, &f->cookie,
>>  =09=09=09=09  mtk_flow_ht_params);
>>  =09if (!entry)
>>  =09=09return -ENOENT;
>> =20
>> -=09idle =3D mtk_foe_entry_idle_time(eth->ppe[entry->ppe_index], entry);
>> +=09packets =3D entry->packets;
>> +=09bytes =3D entry->bytes;
>> +=09mtk_foe_entry_get_stats(eth->ppe[entry->ppe_index], entry, &idle);
>> +=09f->stats.pkts +=3D entry->packets - packets;
>> +=09f->stats.bytes +=3D entry->bytes - bytes;
>>  =09f->stats.lastused =3D jiffies - idle * HZ;
>> =20
>> -=09if (entry->hash !=3D 0xFFFF &&
>> -=09    mtk_foe_entry_get_mib(eth->ppe[entry->ppe_index], entry->hash,
>> -=09=09=09=09  &diff)) {
>> -=09=09f->stats.pkts +=3D diff.packets;
>> -=09=09f->stats.bytes +=3D diff.bytes;
>> -=09}
>> -
>>  =09return 0;
>>  }
>> =20
>=20


