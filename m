Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D184779BC
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806343; cv=none; b=Bw9bs/BCx8TWAHCwNpdiLpK+wkCvy5sDdmiq4/ZAN+p7K78IrDS0wcoY1ZiINIrwS2lug/s/Cr3g2p9cmFBjXNV8nGKYEN6x5Hj2cpR5tcjBoDzqQORyqV8r70af1eAZXuurSnMlq+3YpJ6LOyceYJSkzm21DVgqDVZE8/FLqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806343; c=relaxed/simple;
	bh=2riWbzasRuQEjZ/E+3H0ZpZl6tHDbe5S8oaV2eEQXX0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T29s0HRatYH0kCo+lgqS3YgrNIuC+OzW29Lk4gBNzY9rBnKs/ISPODmYTISRA2MifTS8njW3zlPSNGo3zkoIFC8392spZfp0gVqyIDJwLDbQ1frdgjqopL5uNz+z6NZLo4eNHHCazneu5isXJzWeQDPkfaqLRnVGNCm68GQ9AKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewBDpcKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewBDpcKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF31F000FF;
	Wed, 30 Sep 2026 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790806341;
	bh=TtcmqcFhsuJxbRIsWOTjeS5kmreIr3R9kEJkhztqQLo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ewBDpcKEv8ago2G2t1ii/AdziaUfzdJy/uVruux/eFc8r6ruT8bjo3s+4xx/hEHXW
	 2M+WlbS8HG81J/1YXpchMylxOQfpKyBRrPrtfL+A43dyVUV9GBHUa1pVMUbYEyb7Tb
	 LqWBEaNjWnWz6SKxhCfMKV0z9ULjJkkGkW7OZ7zzgsG6RQ4JtcFZkv+ePIP6uRsqb4
	 +1Jg4cmuCMaDzzaZfDySlVdAlaRT4bBlBHIGMFu5tvKgwx9fh6XbJt7nJpxSSm1rki
	 M7o0Deg+I5ZpgCkRsZaegqkFc1jvA86Ywuiz86RC9IkQGVhZ6a8927vuAu9OR4rYNY
	 1miYyywlPyjsg==
Subject: Re: [next-next PATCH v2 1/2] fbnic: Rework the BMC state pulled from
 the capabilities message
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Wed, 30 Sep 2026 22:12:19 +0000
Message-ID: <179080633998.434549.16996546396415552279@kernel.org>
In-Reply-To:
 <179061192791.414394.2161969547553719796.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179061192791.414394.2161969547553719796.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (7) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this patch, a present-with-MAC to present-without-MAC
  capabilities message clears FBNIC_FW_CAP_F_BMC_PRESENT and raises…
- [Medium] fbnic_fw_parse_bmc_cap() now clears FBNIC_FW_CAP_F_BMC_PRESENT
  whenever firmware reports BMC_PRESENT without a MAC array.
- [Low] The commit is titled as a rework, but it fixes at least two real
  bugs and has no Fixes: tags.
- [Low] The commit message says that with the old -EINVAL, "the link
  speed, FEC and anti-rollback version in the same message are no longer…

Pre-existing issues:
- [Medium] When a BMC becomes present while the interface is up, the RSS
  mc/bc action entries are not rebuilt with DEST_BMC, because…
- [Medium] The disable branch in fbnic_bmc_rpc_all_multi_config() moves
  act_tcam[FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET] to DELETE only when…
- [Medium] fbnic_bmc_rpc_all_multi_config() treats
  mac_addr[mac_addr_boundary - 1] being VALID as proof that it already…
- [Medium] In fbnic_sift_macda(), the inner while loop does not break
  after it moves a qualifying BMC-only entry into dest_addr.
- [Medium] fbnic_bmc_rpc_check() consumes FBNIC_FW_CAP_F_BMC_MACDA_SYNC
  before it calls fbnic_fw_xmit_rpc_macda_sync(), and does not raise the…
- [Medium] fbnic_bmc_rpc_check() runs from the service task under RTNL
  only.
- [Medium] FBNIC_FW_CAP_RESP_BMC_MAC_ADDR is validated as
  FBNIC_TLV_BINARY, which accepts any payload length from 1 to ETH_ALEN…
- [Low] The mailbox parser can overwrite fbd->fw_cap.bmc_mac_addr for
  response B while the service task is still validating and copying it…

--

fbnic: Rework the BMC state pulled from the capabilities message

This moves the BMC parsing out of fbnic_fw_parse_cap_resp() into a new
fbnic_fw_parse_bmc_cap() helper. A BMC reported present without a MAC
array is now treated as absent instead of rejecting the whole message.

The BMC bitfield members are replaced by atomic bitops on a new
fw_cap.state word. The reinit handoff is ordered with
smp_mb__before_atomic() and test_and_clear_bit(), and all_multi is now
always taken from the message.

> The firmware reports the BMC present as soon as its NC-SI channel is
> enabled, before the BMC has been assigned a MAC address. Such a message
> carries no BMC MAC array and is rejected with -EINVAL, discarding the rest
> of it. Treat a present BMC with no MAC as absent instead. There is no entry
> to steer traffic to without one, so the BMC paths stay disabled either way,
> and the link speed, FEC and anti-rollback version in the same message are
> no longer thrown out with it.

[Severity: Low]
Is the part about link speed and FEC accurate? The baseline
fbnic_fw_parse_cap_resp() stores both of them before it reaches the BMC
block that returned -EINVAL:

	fbd->fw_cap.link_speed =
		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_SPEED);
	fbd->fw_cap.link_fec =
		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_FEC);

	bmc_present = !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
	if (bmc_present) {
		...
		if (!attr)
			return -EINVAL;

The only caller, fbnic_mbx_process_rx_msgs(), logs "Unable to process
message" and does not undo fields that were already written.

The old code actually lost anti_rollback_version and the
need_bmc_tcam_reinit raise. It also left bmc_present, bmc_mac_addr and
all_multi at their previous values.

Could the commit message describe that impact instead?

> bmc_present, need_bmc_tcam_reinit, need_bmc_macda_sync and all_multi are
> single bit members of one bitfield, so every write to one is a
> read-modify-write of all four. The mailbox writes three of them and the
> service task writes the other two.

[ ... ]

> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

[Severity: Low]
The subject calls this a rework, but it seems to fix at least two real
bugs. Should it have Fixes: tags?

The -EINVAL rejection of a BMC_PRESENT message without a BMC_MAC_ARRAY
comes from:

Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")

The shared u8 bitfield comes from:

Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables channel")
Fixes: cee8d21d8091 ("fbnic: Push local unicast MAC addresses to FW to populate TCAMs")

Three contexts write that bitfield: the mailbox threaded IRQ, the service
task, and the rx-mode path through fbnic_write_macda(). Each write is a
non-atomic read-modify-write of the whole byte, so updates can be lost.

These fixes are also mixed in with the helper extraction and the
all_multi semantics change. Would splitting them out make a stable
backport easier?

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 47894b45676b..49b8813a3564 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -620,11 +620,55 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
>  	return 0;
>  }
>  
> +static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
> +				  struct fbnic_tlv_msg **results)
> +{
> +	struct fbnic_tlv_msg *attr;
> +	bool bmc_present = false;
> +	u32 all_multi = 0;
> +	int err;
> +
> +	/* FW reports the BMC present once its NC-SI channel is enabled, before
> +	 * it has a MAC. No MAC array means nothing to program, so treat it as
> +	 * absent rather than rejecting the message.
> +	 */
> +	attr = results[FBNIC_FW_CAP_RESP_BMC_PRESENT] ?
> +	       results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY] : NULL;

[Severity: Medium]
Does treating present-without-MAC as absent affect more than MAC
steering? fbnic_bmc_present() also decides what happens to the link and
the RX parser on ifdown:

fbnic_stop()
	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));

fbnic_rss_disable_hw()
	if (!fbnic_bmc_present(fbd))
		wr32(fbd, FBNIC_RPC_RMI_CONFIG,
		     FIELD_PREP(FBNIC_RPC_RMI_CONFIG_OH_BYTES, 20));

fbnic_clear_rules() also uses it to decide whether to keep the last
BMC-routing action rule.

Before this patch, a present-without-MAC message that followed a
present-with-MAC message was rejected. That could happen during firmware
recovery, or when the BMC clears its MAC filters but keeps the channel
enabled. bmc_present stayed set, so link and RPC stayed up on ifdown.

If the host now does an ifdown in that window, can the link and the RX
parser be shut off while the NC-SI channel is still active? The service
task is not rescheduled while the interface is down. A later message that
restores the MAC would not bring the link back until the host brings the
interface up again.

The commit message only says "the BMC paths stay disabled either way" and
does not mention these link and RPC effects. Can firmware send
present-without-MAC after present-with-MAC with no absent message in
between?

> +	if (attr) {
> +		err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr,
> +					       attr, 4);

[Severity: Medium]
This isn't a bug introduced by this patch, but can a short MAC attribute
cause an out-of-bounds read here? FBNIC_FW_CAP_RESP_BMC_MAC_ADDR is
validated as FBNIC_TLV_BINARY, which accepts any length from 1 to
ETH_ALEN:

fbnic_tlv_attr_validate()
	case FBNIC_TLV_BINARY:
		if (!len || len > tlv_index->len)
			return -EINVAL;

However, fbnic_tlv_attr_addr_copy() always copies ETH_ALEN bytes:

	mac_addr = fbnic_tlv_attr_get_value_ptr(src);
	memcpy(dest, mac_addr, ETH_ALEN);

If a truncated MAC attribute sits at the end of a firmware message, the
copy reads past the attribute, and possibly past the receive page, into
bmc_mac_addr[]. Those bytes are then programmed into the TCAM.

[Severity: Low]
This is a pre-existing issue, but what stops this write to
fbd->fw_cap.bmc_mac_addr from racing with the reader in
fbnic_bmc_rpc_init()?

fbnic_bmc_rpc_init()
	for (j = 0; j < 4; j++) {
		u8 *bmc_mac = fbd->fw_cap.bmc_mac_addr[j];
		...
		ether_addr_copy(mac_addr->value.addr8, bmc_mac);

The mailbox can parse response B while the service task is still copying
the addresses from response A. One pass could then program a MAC made of
bytes from both responses.

The new ordering does place B's set_bit() after B's writes, so another
reinit pass follows. The snapshot taken in that first pass is still not
coherent.

> +		if (err)
> +			return err;
> +
> +		all_multi = fta_get_uint(results,
> +					 FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
> +		bmc_present = true;
> +	} else {
> +		memset(fbd->fw_cap.bmc_mac_addr, 0,
> +		       sizeof(fbd->fw_cap.bmc_mac_addr));
> +	}
> +
> +	/* all_multi is only read out of the message when a BMC is present, so
> +	 * it is never set on its own and callers can test it without pairing
> +	 * it with the presence check.
> +	 */
> +	assign_bit(FBNIC_FW_CAP_F_BMC_PRESENT, &fbd->fw_cap.state, bmc_present);

[Severity: Medium]
What happens to the BMC rules already in hardware when a
present-with-MAC message is followed by a present-without-MAC one? This
clears FBNIC_FW_CAP_F_BMC_PRESENT and raises TCAM_REINIT, but
fbnic_bmc_rpc_init() then returns early:

fbnic_bmc_rpc_check()
    fbnic_bmc_rpc_init()
	if (!fbnic_bmc_present(fbd))
		return;

Nothing removes the BMC-tagged MACDA entries, action rule 0, or the
DEST_BMC bit on the RSS multicast and broadcast entries. Does hardware
keep steering traffic to a BMC that the driver now considers absent,
until the interface is bounced?

The next patch in the series, "fbnic: Remove BMC routing rules when the
BMC channel is disabled", adds fbnic_bmc_rpc_disable() and calls
fbnic_rss_reinit() from fbnic_bmc_rpc_check(). That resolves this by the
end of the series.

> +	assign_bit(FBNIC_FW_CAP_F_BMC_ALL_MULTI, &fbd->fw_cap.state, all_multi);

[ ... ]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index ab6e342ec3fa..51fd0564d33f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> @@ -117,7 +117,7 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
>  	 * BMC.
>  	 */
>  	mac_addr = &fbd->mac_addr[fbd->mac_addr_boundary - 1];
> -	if (fbnic_bmc_present(fbd) && fbd->fw_cap.all_multi) {
> +	if (fbnic_bmc_all_multi(fbd)) {
>  		if (mac_addr->state != FBNIC_TCAM_S_VALID) {

[Severity: Medium]
This isn't a bug introduced by this patch, but does a VALID state prove
that mac_addr[mac_addr_boundary - 1] holds the multicast wildcard? The
value, mask and owner are not checked. __fbnic_uc_sync() can also give
that index to a host unicast address once the higher entries are full:

__fbnic_uc_sync()
	for (i = fbd->mac_addr_boundary - 1;
	     i < FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX; i++) {

In that case the wildcard is never installed, and the BMC all-multi
action rule (DEST_BMC) matches the MACDA index of the host's unicast
address. Wouldn't that address's traffic then go only to the BMC?

This needs BMC all-multi on, host all-multi off, and enough extra host
unicast addresses to fill the entries above the boundary.

>  			eth_zero_addr(mac_addr->value.addr8);
>  			eth_broadcast_addr(mac_addr->mask.addr8);
> @@ -144,7 +144,7 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
>  	/* If we are not enabling the rule just delete it. We will fall
>  	 * back to the RSS rules that support the multicast addresses.
>  	 */
> -	if (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi || enable_host) {
> +	if (!fbnic_bmc_all_multi(fbd) || enable_host) {
>  		if (act_tcam->state == FBNIC_TCAM_S_VALID)
>  			act_tcam->state = FBNIC_TCAM_S_DELETE;

[Severity: Medium]
This is a pre-existing issue, but does this check skip entries in the
UPDATE state? After ifdown, fbnic_clear_valid_act_tcam() leaves
act_tcam[FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET] in UPDATE. It is then
not moved to DELETE here, and fbnic_write_rules() writes it back as a
BMC-only rule even when host all-multi is requested. The BMC-only rule
would then take over host all-multicast delivery.

The next patch in the series, "fbnic: Remove BMC routing rules when the
BMC channel is disabled", changes this test to
act_tcam->state != FBNIC_TCAM_S_DISABLED.

>  		return;
> @@ -238,20 +238,25 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
>  {
>  	int err;
>  
> -	if (fbd->fw_cap.need_bmc_tcam_reinit) {
> +	/* Consume the flag before the state it advertises. The ordering
> +	 * implied by test_and_clear_bit() pairs with the barrier in
> +	 * fbnic_fw_parse_bmc_cap(), and claiming it atomically means a set
> +	 * racing with us is kept and retried rather than overwritten.
> +	 */
> +	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
> +			       &fbd->fw_cap.state)) {
>  		fbnic_bmc_rpc_init(fbd);

[Severity: Medium]
This isn't a bug introduced by this patch, but when a BMC becomes present
while the interface is up, do the RSS multicast and broadcast action
entries ever get rebuilt with DEST_BMC? That bit is only computed in
fbnic_rss_reinit():

	if (i >= FBNIC_RSS_EN_NUM_UNICAST && fbnic_bmc_present(fbd))
		dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
				   FBNIC_RPC_ACT_TBL0_DEST_BMC);

This reinit path does not call fbnic_rss_reinit(), so the BMC would miss
broadcast and shared multicast traffic until the interface is bounced.

This has been the case since 04a230b27d8f ("fbnic: Add logic to
repopulate RPC TCAM if BMC enables channel"). The next patch in the
series, "fbnic: Remove BMC routing rules when the BMC channel is
disabled", adds fbnic_rss_reinit(fbd, fbn) to this path.

[Severity: Medium]
This is also pre-existing, but what serializes this path against the
async rx-mode worker? fbnic_bmc_rpc_check() runs from the service task
holding only RTNL. It modifies fbd->mac_addr[] and fbd->act_tcam[] here,
then walks the MACDA table in fbnic_fw_xmit_rpc_macda_sync().

For ops-locked devices, the async rx-mode callback modifies the same
arrays while holding only the netdev instance lock:

netdev_work_proc()
	netdev_lock_ops_compat(dev);
	...
	netdev_work_run(dev, events, core);

The two lock sets do not overlap. Can both sides update the TCAM shadow
state at the same time and send firmware an inconsistent snapshot?

The next patch in the series, "fbnic: Remove BMC routing rules when the
BMC channel is disabled", adds netdev_lock()/netdev_unlock() around
fbnic_bmc_rpc_check().

>  		netif_addr_lock_bh(fbd->netdev);
>  		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);

[Severity: Medium]
This isn't a bug introduced by this patch, but __fbnic_set_rx_mode()
calls fbnic_sift_macda(), and the inner loop there keeps going after it
moves an entry:

fbnic_sift_macda()
		while (src < fbd->mac_addr_boundary) {
			struct fbnic_mac_addr *src_addr = &fbd->mac_addr[src++];
			...
			memcpy(dest_addr, src_addr, sizeof(*src_addr));
			src_addr->state = FBNIC_TCAM_S_DELETE;
			dest_addr->state = FBNIC_TCAM_S_ADD;
		}

With two or more BMC-only multicast addresses, won't the second matching
source be copied over the same dest_addr, with both sources marked
DELETE? The first BMC-only multicast filter would then be lost. Is a
break missing after the move?

>  		netif_addr_unlock_bh(fbd->netdev);
> -		fbd->fw_cap.need_bmc_tcam_reinit = false;
>  	}
>  
> -	if (fbd->fw_cap.need_bmc_macda_sync) {
> +	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
> +			       &fbd->fw_cap.state)) {
>  		err = fbnic_fw_xmit_rpc_macda_sync(fbd);
>  		if (err)
>  			dev_warn(fbd->dev,
>  				 "Writing MACDA table to FW failed, err: %d\n", err);

[Severity: Medium]
This is a pre-existing issue, since the old code also cleared
need_bmc_macda_sync unconditionally. Should the flag be set again when
fbnic_fw_xmit_rpc_macda_sync() fails?

A transient -ENOMEM or -ENOSPC, or -EBUSY from a full mailbox, leaves
firmware with a stale MACDA list and stale receive-mode flags. That lasts
until some other change sets FBNIC_FW_CAP_F_BMC_MACDA_SYNC again.

> -		fbd->fw_cap.need_bmc_macda_sync = false;
>  	}
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179061185153.414394.13396934246780284806.stgit%40ahduyck-xeon-server.home.arpa
