Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440844;
	b=Ldz0ZUCGAfoYqcinVMc2IoTjnZwuCn/s474Fs6FRKhxgtF2wJ2ERy2LMKhM9wiNPCyDU
	 nwTCYDxt2hrl9Ci1CxeZ79YyjgP9O1dcEWPV5SccZ7nuudWaQtsSCW1oEz/sVDtuBfbBp
	 Ib6QgVHL56Ajeg84batR0OimCFHMaCfm7JYhcU+kiC17CtWpGsSF8Jr67ABy/RuBvSuRQ
	 QPsRl/WPmZ0/E3yYkZ1fl0PRuhvHXDsj6/XN6C2dtUjZtG9S+WAyTMPgnL2ebJk/bbPTd
	 BMzuHODftlvMwfkCa3QPIQrX+BJzYopXl3yOwLVd7ZK14DzJzyuW78RwuXccIee7OZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440844;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fJ9tVhtZR9lffxtiuB8KMn8XmTaRx8A4a8uVirllzs4=;
	b=vPPJuDwWzINqAaFL3oNPeSbXyuLgI2hvaXh/HJ1Dd9akmz3y304yEIjWlUW0cm2kZUQU
	 nZPqW7068U2dm78691PQjqz6Y5OXH5oVkNYZKuMQLL3aeXtaT6CDnZlZKWNnBSJHg2BAs
	 gHcMqpTmD3+04PHGA8dcsX4ktZFvkgiNZ4Zj7x+xhJ64tsAVH+/WiPX3SJJvvJBmu76P5
	 PMnUpD83gxqTxburzCSSjsVnfMtE3Xxzhdmi2vprJTFWDLg1mizFv89j6zAI+GJ/Fz9gw
	 Vm8udxqQDuWiCzn0THf2xzvjKABTug6T6CPKfMR4E0EUthS1NtmkRF8ZJWLhVfgXFCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3fqn1r9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F5606A327
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3fqn1r9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79D11F000C5;
	Mon, 19 Oct 2026 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440843;
	bh=fJ9tVhtZR9lffxtiuB8KMn8XmTaRx8A4a8uVirllzs4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J3fqn1r9YukkypgUTpI4ayaToOrFub7zcFM3mXxW380DsQKHG9sLSPQXOybDY8bSc
	 oIP9r7DTf403K+WDYbNJTejN3FrLXheDmN6smIs6ss5W5ORCdZSErJZNMMEmvFW67Q
	 RUa9w2eaI2uln/cowGNJtmbJAnXIL3luUa9GKUWsQYp8E0Lpsf9runts0wjCAFz7a2
	 2IDq+nRl/TkKgwY3H/x6grCTAuCDgRA+vZEJS0XfeN/N2E8H6YIq1BWt+oOJEu1SYb
	 I/cE8T6BnVzVueJeax4fHxWgWeoygFvvIlAJYQOy89EMl5309fOOHafZBFYBno054k
	 zL6C8rctiAWUQ==
Subject: Re: [PATCH net v3 02/14] ice: use reference counting and SRCU for PTP
 port access
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:02 +0000
Message-ID: <179244084232.3135.1622859924790214166@kernel.org>
In-Reply-To: <20261015191102.1174111-3-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-3-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] drivers/net/ethernet/intel/ice/ice_adapter.h now embeds `struct
  srcu_struct srcu` by value in `struct ice_port_list` (line 32).

Pre-existing issues:
- [Medium] ice_ptp_prepare_rebuild_sec() (E825C owner reset path) holds
  only an SRCU read section and a kref on the peer port when it calls…

--

ice: use reference counting and SRCU for PTP port access

This commit replaces the mutex-protected adapter port list with an SRCU
protected list plus a spinlock for writers. It also adds a kref to each
ice_ptp_port. Readers take the kref with kref_get_unless_zero(), and
ice_ptp_cleanup_pf() waits for the last reference to drop before it calls
synchronize_srcu().

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index 4f695f32da3d8..0b01c7f5cf0da 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -17,15 +17,19 @@ struct ice_pf;

[ ... ]

>  struct ice_port_list {
> -	struct list_head ports;
> -	/* To synchronize the ports list operations */
> -	struct mutex lock;
> +	struct list_head list;
> +	/* To synchronize write operations on the port list */
> +	spinlock_t lock;
> +	struct srcu_struct srcu;

[Severity: Low]
Should ice_adapter.h include <linux/srcu.h> itself? struct ice_port_list
now embeds struct srcu_struct by value, so it needs the complete type. The
header only pulls in:

#include <linux/types.h>
#include <linux/mutex.h>
#include <linux/spinlock_types.h>
#include <linux/refcount_types.h>

#include "ice_type.h"

The patch adds <linux/srcu.h> to ice_adapter.c and ice_ptp.c instead. The
header seems to build today only through a transitive chain:

ice_type.h -> ice_osdep.h -> <net/udp_tunnel.h> -> ... -> <linux/notifier.h>

and notifier.h is what includes <linux/srcu.h>.

In the same patch, ice_ptp.h does get <linux/kref.h> for its new struct
kref member.

>  };
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index e1c66cd0f94ff..55241802d17ae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -2890,14 +2934,18 @@ void ice_ptp_queue_work(struct ice_pf *pf)
>  static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>  					enum ice_reset_req reset_type)
>  {

[ ... ]

> +	srcu_idx = srcu_read_lock(&ports->srcu);
> +	list_for_each_entry_srcu(port, &ports->list, list_node,
> +				 srcu_read_lock_held(&ports->srcu)) {
>  		struct ice_pf *peer_pf = ptp_port_to_pf(port);
>  
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +
>  		if (!ice_is_primary(&peer_pf->hw)) {
>  			if (rebuild) {
>  				/* TODO: When implementing rebuild=true:
> @@ -2909,7 +2957,10 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>  				ice_ptp_prepare_for_reset(peer_pf, reset_type);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Can this
call to ice_ptp_prepare_for_reset(peer_pf) race with the peer PF's own
ice_ptp_release()?

Here the owner holds only an SRCU read section and a kref on the peer
port. ice_ptp_prepare_for_reset() then reads and writes peer_pf->ptp.state
with no lock held:

	if (ptp->state != ICE_PTP_READY)
		return;

	ptp->state = ICE_PTP_RESETTING;

	/* Disable timestamping for both Tx and Rx */
	ice_ptp_disable_timestamp_mode(pf);

	kthread_cancel_delayed_work_sync(&ptp->work);

At the same time, the peer can be in the READY path of ice_ptp_release().
That path does the following before it reaches ice_ptp_cleanup_pf():

	pf->ptp.state = ICE_PTP_UNINIT;

	/* Disable timestamping for both Tx and Rx */
	ice_ptp_disable_timestamp_mode(pf);

	ice_ptp_cleanup_pf(pf);

One possible interleaving:

owner (E825C reset)                    peer PF (unbind/remove)
ice_ptp_prepare_rebuild_sec()
  kref_get_unless_zero() succeeds
  ice_ptp_prepare_for_reset(peer_pf)
    sees state == ICE_PTP_READY
                                       ice_ptp_release()
                                         state = ICE_PTP_UNINIT
                                         ice_ptp_disable_timestamp_mode()
    state = ICE_PTP_RESETTING
    ice_ptp_disable_timestamp_mode()

Could the peer then be torn down with ptp.state left at ICE_PTP_RESETTING
instead of ICE_PTP_UNINIT? Both sides would also run
ice_ptp_disable_timestamp_mode() with nothing ordering them.

The new kref wait in ice_ptp_cleanup_pf() keeps the peer's kworker and Tx
tracker alive until the owner drops its reference, so the earlier
use-after-free window looks closed.

Before this patch, the same call ran with no locking at all. The commit
message also limits its scope to the port list.

^ permalink raw reply

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
