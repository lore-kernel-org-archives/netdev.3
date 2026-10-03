Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8437F012;
	Sat,  3 Oct 2026 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057058; cv=none; b=RllPCPv5OzDwQyIFUI4SuYNdVFITfgJzFMqgu70Ur7Z7MidchscxVxonqf1RmI8wC3s3DpVKwKe/3d8lxBDEYA9j3ggyKrpqFfNad/CfHcTDhLf2uCeyne56qNWhqAJYxVnupa2mTky4L/dKNJDR3AElesl1V2fcqdEA3v5H3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057058; c=relaxed/simple;
	bh=v8g+H60BvsO2YQpllWlYYUMh2S3ninXQ9C3nZF3VTv4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7dZOLtKb0/IfkzIWztlNHrAH5GUx+bpHopX+r+apVgPqpT4GuwxQzrk4g9Vai+h1Az0uvnH6D6NPkQ04o8TowJFv0ObCyvdgnTZ5rWNVBU/iqu/MtpFNxyIBEM72/1HJuBfLRxFIIeA+dFde7M55ymZl/+QIaqaZACO+YLoXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkYR/kIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkYR/kIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C01F0089C;
	Sat,  3 Oct 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057057;
	bh=kKSLji1opqG6V8bCVVA6Sl+Mo+pVvpbsySpuhA5Z1t4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nkYR/kIBTNaALPFITh8Eq3BXEEmGnWJmVgUseUncKEywUUMEMdtsiAJVzfLhzjbbK
	 pYhLFgqb9AnLqXazIOIH4mgGfvx/YJ1TrsCzautcSxQd452sB8Zw3SMOdovZrKsNnZ
	 KQf6gS1oyM5mxpTNgX39ibZ9IDoYMjx0Va1Tt6QNpT575kjO+VhUhNtkXivUgpzKbf
	 /QU1HLmuq9yVfmVPmXcJEHpNTfGVwf2kKW4tKefPdcTkA8dOP84m1HeEa4rqWjKou9
	 KDPo8K8k46SGNL3aU7SlQ1zlwPTGMNGtMgCZZm5H0hpg1NtX/LXqFvOYHR2oW5Psse
	 aLFCK5dMHNRUw==
Subject:
 Re: [PATCH net-next v2 4/6] enic: validate V2 VF configuration replies
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Sat, 03 Oct 2026 19:50:56 +0000
Message-ID: <179105705600.434549.6058631557825724802@kernel.org>
In-Reply-To:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-4-5962c10061b2@cisco.com>
References:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-4-5962c10061b2@cisco.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit the message says the patch adds VF-side
  administrative-MAC notification operations, but…
- [Low] enic_mbox_vf_add_del_macs(), enic_mbox_vf_add_del_mac() and
  enic_mbox_vf_set_pkt_filter() have no callers at this commit, and…

--

enic: validate V2 VF configuration replies

This commit adds VF-side V2 mailbox message types for MAC filter add/delete
and packet-filter settings, and validates their replies (framing, echoed
entries, result counts and applied flags). A reply that is malformed or
contradictory, or that reports registration loss, forces the VF to
re-register. The PF side stays dormant.

> Add the established V2 mailbox operations for MAC filters,
> administrative-MAC notifications, and packet-filter settings. Keep request
> buffers alive until the VF request completes so detailed replies can be
> checked entry by entry.

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index 30a5f6fda676d..265b58cd39be3 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c

[ ... ]

> @@ -680,6 +905,34 @@ static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
>  	return true;
>  }
>  
> +static void enic_mbox_vf_malformed_msg(struct enic *enic, u8 msg_type,
> +				       u64 msg_num)
> +{
> +	u8 expected;
> +
> +	switch (msg_type) {
> +	case ENIC_MBOX_PF_LINK_STATE_NOTIF:
> +	case ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF:
> +		enic_mbox_vf_require_reconnect(enic);
> +		return;

[ ... ]

> @@ -718,11 +977,21 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
>  		size_t exp = sizeof(struct enic_mbox_pf_link_state_notif_msg);
>  
>  		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
> -					     payload_len, exp))
> +					     payload_len, exp)) {
> +			enic_mbox_vf_malformed_msg(enic, hdr->msg_type, msg_num);
>  			return;
> +		}
>  		enic_mbox_vf_handle_link_state(enic, payload, msg_num);
>  		break;
>  	}
> +	case ENIC_MBOX_VF_ADD_DEL_MAC_REPLY:
> +		enic_mbox_vf_handle_add_del_mac_reply(enic, payload,
> +						      payload_len, msg_num);
> +		break;
> +	case ENIC_MBOX_VF_SET_PKT_FILTER_REPLY:
> +		enic_mbox_vf_handle_set_pkt_filter_reply(enic, payload,
> +							 payload_len, msg_num);
> +		break;
>  	default:
>  		netdev_dbg(enic->netdev,
>  			   "MBOX: VF unhandled msg type %u\n",

[Severity: Low]

Is the administrative-MAC part of the commit message accurate for this
commit? The commit message says:

  Add the established V2 mailbox operations for MAC filters,
  administrative-MAC notifications, and packet-filter settings.

This patch adds cases to enic_mbox_vf_process_msg() for
ENIC_MBOX_VF_ADD_DEL_MAC_REPLY and ENIC_MBOX_VF_SET_PKT_FILTER_REPLY. There
is no case for ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF, so:

- A well-formed notification falls through to the default netdev_dbg()
  branch. It never gets an ENIC_MBOX_PF_SET_ADMIN_MAC_ACK.
- A malformed notification goes through enic_mbox_vf_malformed_msg(),
  which forces a reconnect.

The later patch in this series, "enic: manage V2 VF station and
administrative MAC", appears to add the ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF
case and enic_mbox_vf_handle_admin_mac(). Also, no in-tree PF sends this
notification yet, because the V2 PF path is dormant.

Could the commit message say that this patch only adds the admin-MAC
message definitions, and that the later patch adds the handling?

[ ... ]

> @@ -880,14 +1166,182 @@ int enic_mbox_vf_unregister(struct enic *enic)
>  	if (registered)
>  		return -EACCES;
>  	return 0;
>  }
>  
> +int enic_mbox_vf_add_del_macs(struct enic *enic,
> +			      struct enic_mac_addr *macs, u16 num_macs)
> +{

[ ... ]

> +int enic_mbox_vf_add_del_mac(struct enic *enic, const u8 *addr, bool add,
> +			     bool station)
> +{

[ ... ]

> +int enic_mbox_vf_set_pkt_filter(struct enic *enic, int directed,
> +				int multicast, int broadcast,
> +				int promisc, int allmulti, u16 *applied_flags)
> +{

[Severity: Low]

This isn't a bug, but at this point in the series nothing calls
enic_mbox_vf_add_del_macs(), enic_mbox_vf_add_del_mac() or
enic_mbox_vf_set_pkt_filter(). ENIC_MAC_ADDR_FLAG_PERMANENT_MASK in
enic_mbox.h is also unused.

Two later patches wire them up: "enic: manage V2 VF station and
administrative MAC" and "enic: configure V2 VF receive mode over mailbox".
The callers are enic_vf_station_addr_del(), enic_vf_station_addr_replace(),
enic_vf_sync_mac_filters() and enic_vf_set_pkt_filter().

Would it make sense to move these helpers into the patches that add their
callers?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2%40cisco.com
