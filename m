Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484769;
	b=S/ib6vkxdMRojKZMTbBC66lFBHbDUpOO+QSPBNNJGVJDM3YxRHr/RnbVXPJGmvakCe7r
	 7clfLE6PPb8FiRzV7eOfDHL1TCzceAWGMQnff6LzplrLD03LXWdwlZFOTz+J8/e4fIiYb
	 oLOCk3EJHclIXtJXirc5FYrgjxTn/aWIpQFXMQUb/otrn6WSf2z936NKg2bHJpSX+jZ/J
	 NvZhf80oN8/GcEVMgpshbyfK/75YoCjNL4XSinWtQhLyHi2xQvxfV6AHf31qDY9pbgE4r
	 9O474Jdimhz9Cur4IH9YZi/6m3aK1ZduaNGg3fWvJI4bpOpMcH2jtng79hymRoqRQkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484769;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CWhpEnAkiBLLWdhO8qZS4UezdC3Z8f/sSXSKbe306+4=;
	b=fvLDrp1rdlnnyXLZvZAo3+BvLF3W83wmxZWoU8au94JyIlGdcWiQlRrlGptOkrjIq9hN
	 o/fuF6COmgYQfQJwl5Pa6+gYNhSewsQhE5KK53k+b04qVvIJGBOoaqMYAT6kWDHM1M/2x
	 0B8SLj8KX5GZ82NJbUmZ2g2MY/gD6QPzk7l9brvViTYRSzBOS2HELn4KQevsbVmfWMfDD
	 CSpcsoI9M8cm+QdxfaZ1U5vOSLYLF5DE6XnVgcoDKL2fF4kpTRZOv+kSQYq/6fJshGOqd
	 t27us6ITuNuNbXBTibKYBuAg25JwRBRW2jB55VnpTyB2m3RCobvshAhoyXMoV829B+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMj+nBSt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E660A3819;
	Tue, 20 Oct 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMj+nBSt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08091F000C9;
	Tue, 20 Oct 2026 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484768;
	bh=CWhpEnAkiBLLWdhO8qZS4UezdC3Z8f/sSXSKbe306+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JMj+nBStKUQVM0j2Bt0N9zxpyyCkWM4aKgGJFDiKknav89+Lfnda8Q4510hEqdRof
	 hkQ1LP7+gE19SEadMCJHs1ryttEA65rZzv51bXMA1+zTPF7SpG75OJT1Btz8SdW4kh
	 vs3oC2B3KRwgGYidg5bzPaQLMmY5Ie4aoOQL2zeJBwp2tcbJFvTcWrC68Ojnc63ZSX
	 XZFFjcir3kIL6oA3edxbobaBydxS5eUp0awe6r+FAJ4Hl9gjXwewAuuk6Xi+9Q4P9D
	 Jg9wgLufCQ85nv+lPvfQ9g0dBgjx+PJ/bwkj7ZXWWQw6UM9CnxhiEpku5R2fWVTz1i
	 AHoZ3mazWxv0A==
Subject:
 Re: [PATCH net 3/3] enic: require DEVCMD2 and set the V2 VF mailbox source
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com
Date: Tue, 20 Oct 2026 08:26:07 +0000
Message-ID: <179248476749.3135.499310434326384536@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261016-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v1-3-d27b55f69883=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261016-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v1-3-d27b55f69883=40cisco=2Ecom=3E?=
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fence for the statistics-command DMA is cleared only when
  the command succeeds, not whenever it completes.

--

enic: require DEVCMD2 and set the V2 VF mailbox source

This commit has V2 VFs query CMD_SRIOV_STATS_GET after opening the admin
channel. The returned logical VF index becomes the mailbox src_vnic_id,
and SR-IOV V2 now requires DEVCMD2. A timeout of the statistics command
is tracked with sriov_stats_dma_unresolved. A later CMD_QP_TYPE_SET is
expected to fence it, and if nothing does, the probe resources are kept
until reboot.

> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index cf2dee8fa78ff..886f3cba543dc 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -273,6 +273,11 @@ struct enic {
>  	u16 num_vfs;
>  	enum enic_vf_type vf_type;
>  	bool vf_registered;
> +	u16 vf_id;
> +	/* A CMD_SRIOV_STATS_GET timeout leaves its persistent coherent target
> +	 * device-owned until a later serialized command completes.
> +	 */
> +	bool sriov_stats_dma_unresolved;
>  	u32 pf_cap_version;
>  	unsigned int enable_count;
>  	spinlock_t enic_api_lock;
> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index a5c08cbcb3391..2f6688a73b41a 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
> @@ -406,6 +406,12 @@ static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
>  
>  	spin_lock_bh(&enic->devcmd_lock);
>  	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
> +	/* DEVCMD2 runs one command at a time for a vNIC. Completion of this
> +	 * blocking command proves that earlier statistics-command DMA has
> +	 * finished. Admin WQ/RQ ownership still requires RUNNING == 0.
> +	 */
> +	if (!err)
> +		WRITE_ONCE(enic->sriov_stats_dma_unresolved, false);

[Severity: Medium]
Should sriov_stats_dma_unresolved be cleared whenever CMD_QP_TYPE_SET
completes, not only when it returns 0?

The comment above, the enic.h field comment ("until a later serialized
command completes") and the commit message all treat completion as the
fence. On the DEVCMD2 path, _vnic_dev_cmd2() returns -result->error only
after firmware has written this command's result slot:

drivers/net/ethernet/cisco/enic/vnic_dev.c:_vnic_dev_cmd2() {
    ...
	for (delay = 0; delay < wait; delay++) {
		if (result->color == color) {
			if (result->error) {
				err = result->error;
				...
				return -err;
			}
    ...
}

Only -ETIMEDOUT leaves completion unknown after the command is posted.
-ENODEV and -EBUSY are returned before anything is posted.

In enic_probe(), a timeout in enic_dev_sriov_stats() sets the flag, and
the unwind goes to err_out_admin_close. There, enic_admin_channel_close()
calls enic_admin_qp_type_set(QP_DISABLE). If firmware completes that
command with an error status, the flag stays set. This happens even
though enic_admin_channel_close() treats the rejection as harmless:

	/* Firmware rejection does not undermine the WQ/RQ proof. */
	return qp_err;

At err_out_admin_fence, enic_dma_quarantined() still returns true. Probe
then calls enic_terminal_dma_quarantine() and returns early, skipping
enic_dev_deinit(), vnic_dev_close(), vnic_dev_unregister(),
enic_iounmap(), pci_release_regions() and free_netdev().

Would that keep the netdev, vdev, coherent buffers, BAR mappings and PCI
regions held until reboot, and prevent the VF from being probed again?

If clearing only on success is intended, could the comments and the
commit message say so?

>  	spin_unlock_bh(&enic->devcmd_lock);
>  
>  	return err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883%40cisco.com
