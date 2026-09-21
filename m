Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74526656D;
	Mon, 21 Sep 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972487; cv=none; b=ud72XPstOVGTLquAI/DdzrX3VLYLoKwi1Xs4t2aZIwE1EHM4ey+Hnlq1HQ2SbOcbI4Mnb7z6ttxbRNqchSfHkP/w9T0k6gGWa1e2XDHtSQHJs2v6+QWQqfCkXG6xRctxHn2krWMRDSt9kzmhMh6Wvm3ZVtRkb8GfN3gV5Alztb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972487; c=relaxed/simple;
	bh=q+1kzMClr6ItoigZSExvAXjrxzpE6A87KuZ9cLOXYJQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfDkmhunL+ClovWHaDXmHKF8OG5Ug2qlUApEiW9GWR9RHdSSXps4XHmXu90TNH7Gv0XGKfHV2fuYgF8/4Tdp3yXv1XdBbG4lLzqTCL0TpViTVPclIxaSsPdS8+Yarn3GQN16OWPbHbzxWjEMCWN/kzmVDixkO9V+5Mk6JvY/a5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTdkoPpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTdkoPpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D51F000FF;
	Mon, 21 Sep 2026 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972485;
	bh=H4cMmy0ekBDJfQRFfeZWaWIlR0+1gBW66rPbCmzLgEo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kTdkoPpn4tSPaKK8y+Nmci2AOojndCzKA+QP+L1Qo/osDK6ug1sBOsfF5INz6lV7O
	 dgCeLnh8t96fwhr2MzyRi4HXVF/T/NbE5kg1HsVgNBhsizJekRoq7cL1NNdGLGDnyn
	 C5R+1DtyQLJvfpYgQwMDRt7iFrEuhVEj1xrjMgcVoBV7y/6n6cf4ZBfLgnIchleRsp
	 QAk34EwGYbfDWgFb8b83i7nRKKJdpRl2lhv0/FsqOR0pXNQJsFTNIiUHL4EL9kiygY
	 CLTftr3hAYhSgP5RwFCgNeTG+nSEoioEtnHAo7/Z7oRPHss7n++n+1dyTaUv5ptoAP
	 snRTyRwwKxJXw==
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: limit the DDP profile
 count returned by the firmware
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 aleksandr.loktionov@intel.com
Date: Mon, 21 Sep 2026 06:34:44 +0000
Message-ID: <178997248483.2160803.11710552261264563604@kernel.org>
In-Reply-To: <20260920063244.1927792-1-xiaolinkui@126.com>
References: <20260920063244.1927792-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix in i40e_ddp_does_profile_exist() and
  i40e_ddp_does_profile_overlap()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it is the
  direct enabler of the residual garbage-compare above and would be…

--

i40e: limit the DDP profile count returned by the firmware

The patch clamps the firmware reported profile count in
i40e_ddp_does_profile_exist() and i40e_ddp_does_profile_overlap() to
I40E_MAX_PROFILE_NUM so the loops cannot index past the on-stack
buff[] array, and switches the loop counter to unsigned.  The clamp
value is the compile time capacity of buff[].

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index daa9f2c42f70..26dccd4236c1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -54,8 +54,8 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
>  {
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
                                        ^^^^

[Severity: Medium]
This isn't something introduced by this patch, but since both hunks touch
these declarations it may be worth handling here: buff[] is 772 bytes of
uninitialized stack in both i40e_ddp_does_profile_exist() and
i40e_ddp_does_profile_overlap(), and it is handed to
i40e_aq_get_ddp_list() as an indirect admin queue buffer.

i40e_asq_send_command_atomic_exec() does not distinguish input from output
buffers:

	/* if buff is not NULL assume indirect command */
	if (buff != NULL) {
		dma_buff = &(hw->aq.asq.r.asq_bi[hw->aq.asq.next_to_use]);
		/* copy the user buff into the respective DMA buff */
		memcpy(dma_buff->va, buff, buff_size);

Does this publish 772 bytes of raw kernel stack into DMA memory that the
NIC firmware can read?  On completion the same full buff_size is copied
back:

		if (buff != NULL)
			memcpy(buff, dma_buff->va, buff_size);

so any byte the firmware did not overwrite still holds the old stack
image that the clamped loops then compare against.  Would declaring the
buffer as

	u8 buff[I40E_PROFILE_LIST_SIZE] = {};

in both helpers remove both the device visible stack content and the
comparisons against never written bytes?

>  	int status;
> -	int i;
>  
>  	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
>  				      NULL);
> @@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
>  		return -1;
>  
>  	profile_list = (struct i40e_ddp_profile_list *)buff;
> -	for (i = 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count reported by
> +	 * the firmware is not guaranteed to fit into the buffer we gave it.
> +	 */
> +	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
> +
> +	for (i = 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
>  			return 1;
>  	}

[Severity: Medium]
The arithmetic behind the clamp checks out: sizeof(struct
i40e_profile_info) is 48 and I40E_PROFILE_LIST_SIZE is 48 * 16 + 4, so
p_info[15] ends exactly at the last byte of buff[] and the out of bounds
walk described in the commit message is closed.

The remaining question is that the new bound is the static capacity of
buff[] rather than the extent of data the firmware actually returned.

i40e_aq_get_ddp_list() sets desc.datalen on input but never reports the
response length back to the caller, and
i40e_asq_send_command_atomic_exec() copies the full requested buff_size
back from the reused DMA bounce buffer without consulting the response
descriptor.

So if the firmware reports a p_count larger than the number of records it
actually wrote, but still no larger than 16, do these loops compare
against p_info[] slots that were never filled?  In
i40e_ddp_does_profile_overlap() below, i40e_ddp_profiles_overlap() treats
a zeroed or stale entry as a conflict:

	unsigned int group_id_old = FIELD_GET(0x00FF0000, old->track_id);
	unsigned int group_id_new = FIELD_GET(0x00FF0000, new->track_id);

	/* 0x00 group must be only the first */
	if (group_id_new == 0)
		return true;

which i40e_ddp_load() turns into a hard rejection of a legitimate load:

	if (istatus > 0) {
		netdev_err(netdev, "DDP profile overlaps with existing one.");
		return -EINVAL;
	}

The equality helper can similarly produce a "DDP profile already loaded."
verdict from stale bytes.

The other direction is the p_count > 16 case that the commit message
targets.  Both helpers now silently truncate the scan and return 0, and
i40e_ddp_load() consumes that as a definitive answer: an add proceeds to
i40e_write_profile()/i40e_add_pinfo() without having examined every
reported profile, and the is_add == false path rejects a profile that may
in fact be loaded:

	} else {
		if (istatus == 0) {
			netdev_err(netdev,
				   "DDP profile for deletion does not exist.");
			return -EINVAL;
		}
	}

Would it be better to derive the iteration bound from the length the
firmware actually returned, by plumbing the response datalen out of
i40e_aq_get_ddp_list(), and to return an error instead of silently
clamping when p_count exceeds I40E_MAX_PROFILE_NUM?

The reachable path here is ethtool -f, so it needs CAP_NET_ADMIN plus
firmware reporting a count that does not match what it wrote, which is
the same untrusted firmware assumption the patch already adopts.

> @@ -109,8 +114,8 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
>  {
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
> +	u32 i, p_count;
>  	int status;
> -	int i;
>  
>  	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
>  				      NULL);
> @@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
>  		return -EIO;
>  
>  	profile_list = (struct i40e_ddp_profile_list *)buff;
> -	for (i = 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count reported by
> +	 * the firmware is not guaranteed to fit into the buffer we gave it.
> +	 */
> +	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
> +
> +	for (i = 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_overlap(pinfo,
>  					      &profile_list->p_info[i]))
>  			return 1;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920063244.1927792-1-xiaolinkui%40126.com
