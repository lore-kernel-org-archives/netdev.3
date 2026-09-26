Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DF3A6EEB;
	Sat, 26 Sep 2026 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431239; cv=none; b=BfOYI6M7lrBOYE/bTp2yKcj4XnLsk1lNeCypq85yqGmugTtpEWWTMARy+wZcv1DHiGSco1JZCj2P0CoEM++WI+wJpAjvMXsnoFRT0MIi5JDkqMEhch4sSl4Vx82FgC5cVq9VGZqbX3YqNVHefwhz/E9lY0NfrV/HFIUNx0PUy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431239; c=relaxed/simple;
	bh=2Q9KfD8xPzCTbRnfq/tJk3nKETv0AKFOPWwDfXF+SF8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2fgIT4IcXct33FmkGSMXKV38c2JqZKp6ppkoFHq9NIQd03aIBhRKCMeDRRwDDXr2pB/t1Uq9JnQ77YVVScxlgfoWmqE950lHQx8CrqKZXqqSWCQVz699LJrUdaqndVtLJsOYB4kJiDwgOJPLJE2qGobE6rivtLiwRI+xV39vS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlDrvCV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlDrvCV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018661F00893;
	Sat, 26 Sep 2026 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431229;
	bh=Xld9Y4axv1/BMk23dnVje6lvml/en/pW8VvvxYx9Ewk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BlDrvCV8WedOF3GYKcC3K9qeroiCVb6YdmK6u7HntFacIgYoycstOOrFwfZRD8q/4
	 UuVOpyEO8sBvH2g1N0prCfugiPFlr5KEL70zz32vik6S6D7GR9wkwN9whTdxHgnIkZ
	 ASeHoVloWiz0xxVRFDvC4OcfRw7lu7u+TDZur28N7SB/pHHq3A+T7YUBaFgSvcGVTr
	 o9etLjRNSYYWjJXZktxB9vyC+guDpD1VDuLHvcHfC91KVWFafvr3smBBjtEYYrovKD
	 7NmwQy+x1jYz4YIWdZGj4AszgLJCStVV8g6XrV6hNIxmnfwzx54ELFIkp2foYxPcqk
	 Pp5+RxeXDBriA==
Subject: Re: [PATCH v29 net-next 2/8] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:28 +0000
Message-ID: <179043122855.2160803.4088505740875316744@kernel.org>
In-Reply-To: <20260922120311.86593-3-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-3-illusion.wang@nebula-matrix.com>
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

- [Low] Commit message statements are not backed by the submitted code:
  (a) it says `nbl_res_ctrl_dev_setup_eth_info()` builds "the per-PF…

--

net/nebula-matrix: add common resource implementation

This adds the chip-independent resource layer for the nbl driver: PF mask
parsing, SR-IOV BDF table construction, eth info and VSI base id setup on
the control PF, plus VSI/func/eth id conversion helpers.

> - nbl_res_ctrl_dev_setup_eth_info(): validates that firmware port
>   count (get_board_info()->eth_num) matches max_pf and the eth
>   bitmap reported by get_fw_eth_map(), then builds the per-PF
>   eth_id / logic_eth_id lookup tables.

[Severity: Low]
Is there really a logic_eth_id lookup table?  struct nbl_eth_info in
nbl_hw/nbl_resource.h only carries eth_num and eth_id[]:

> +struct nbl_eth_info {
> +	u8 eth_num;
> +	u8 resv[3];
> +	u8 eth_id[NBL_MAX_ETHERNET];
> +};

and nbl_res_get_eth_id() computes the logical id on the fly from the
relative PF id rather than reading it from a table:

> +	*logic_eth_id = rel_pf_id;

Would it be more accurate to say setup_eth_info() builds the per-PF eth_id
table, and that logic_eth_id is derived from the relative PF id?

> The resource conversion helpers themselves do not include locking;
> all resource operations must be serialized by upper dispatch layer via
> ops_mutex_lock. Non-control PF requests are routed to control PF via
> mailbox RPC, and these helpers are only executed on control PF.

[Severity: Low]
Do ops_mutex_lock and the mailbox RPC routing exist at this commit?  A grep
over drivers/net/ethernet/nebula-matrix/ at this revision finds no
ops_mutex_lock at all, and enum nbl_chan_msg_type in
nbl_include/nbl_def_channel.h only defines the ack opcode:

enum nbl_chan_msg_type {
	NBL_CHAN_MSG_ACK = 0,
	/* mailbox msg end */
	NBL_CHAN_MSG_MAILBOX_MAX,
};

The newly registered res_ops (get_vsi_id, get_eth_id) also have no caller
yet, and non-control callers are rejected locally instead of being
forwarded:

> +	if (!common->has_ctrl || !eth_num || !eth_id || !logic_eth_id)
> +		return -EINVAL;

Both the ops_mutex_lock serialization and the mailbox RPC routing appear
only in the later patches "dispatch: add control-level routing core
infrastructure" and "dispatch: implement channel RPC framework and
serialize hardware ops".  Could the message be reworded to describe those
as coming later in the series, so the "lookup helpers require no internal
locking" claim is justified by code that is actually present?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
