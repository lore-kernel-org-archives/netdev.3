Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063787;
	b=f6uetouCPo8c4M+cjKxmk9/GJOK6oY7WQVHl6h9VXMTBTO5vA/Gwc1cZzui2OLXHbFfW
	 vTUqrkBURkrtPj8QtCJ/Sv/viGrwquMqVPTxAboJhhRMv+AIOMkUgJeSIFIjqOR7BJo7c
	 w13/IHrO7zJHOarhjz6U2Zy3m0o2SyZGbWxFDTyKwsC3qmbFepe8ylzL5BTP3rs65o7rB
	 JBIDtin4s/VAVY+Jsnb/x9vLDo8doqzH2xu+CDI8377wuG3FHShf0ygfEsVn9cG35kntq
	 j/o2LM5CXRM8pK5mxlQLQv4nALOV6gu9v34/BUs1FWhwzUbBBwKhfahMMUXMeUqMnXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063787;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=70g4G37l8EVjm8zR18ELGxvJLg3g7+9igUjOf1zODP0=;
	b=ABgsqhaXPdSS5ZufYUGBvFqPpj27mXZFQqSFH35AU8Hd9TqMUoPEIFroSFiw4PBEmTyA
	 k3kYul6Vwe/R97/22xWxqBsupeE9aURj8Qi07Vxu/zOZf0iwakgqfrhD57ITe6HDYcVO+
	 y4ik6M2GICBsnWPv4hVPafDnIXvuvAWzNoFRi2Kp5tKcTSHpz+xz1GHCri4lTL4MdY0oa
	 e3qczYbDQPNQ1aiaSGAF/Gsh/qeDRWGijpf8gqQZqVGI4b17s45vmEoVh2iyJY6CgSL3Z
	 uqwo3lNRxZn1qwEvutLkdVrHuRUQC3kyCmzaIvy0wkcGrM7TFs7Qi66bYxo4H8Vze5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFj3FhMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49360A3810
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFj3FhMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3181F008A2;
	Sat,  7 Nov 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063787;
	bh=70g4G37l8EVjm8zR18ELGxvJLg3g7+9igUjOf1zODP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SFj3FhMhmJDyVAOp0Q2CWjzWrAhTtXQhY0RRPZGk1CkwV2cIFy9fIRGsFJUthVDW+
	 xKos7JvQlC0ZjormSfhXIZLGcJFzqxL4y/Kgh55gJcSWw0oBdguBmYVFIcASNxjbsE
	 K4y6MSVPLDuMsyi30erInKSr5gKRTlJZiVRWDZ0eVz/5BxHddsV6GkELuEcyWQROar
	 cC6/gBKpBnH8p7PP8SxjTmPUs3J6Y5uFpGx0iulpnag2hz00u1MLTcxAd1fUe5qtkt
	 iTH/51qaJkUxzUlL3jocWehKEwZvRaD6gRCGFzjEfVOtPTTMm3EYrdV3kccrS0KCat
	 PKsho816IP0yA==
Subject:
 Re: [PATCH net v5 2/2] enic: require DEVCMD2 and set the V2 VF mailbox source
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Sat, 07 Nov 2026 15:03:06 +0000
Message-ID: <179406378616.994134.1586384067056474250@kernel.org>
In-Reply-To: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-2-2501d1223eff@cisco.com>
References: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-2-2501d1223eff@cisco.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] V2 VF probe now depends on firmware support for the new devcmd
  CMD_SRIOV_STATS_GET (devcmd 98), and nothing checks for that support…
- [Low] enic_admin_channel_open() accepts the CMD_SRIOV_STATS_GET reply
  only when le32_to_cpu(stats->ver) == VNIC_SRIOV_STATS_VERSION (1).
- [Low] The comment on the new struct enic field
  sriov_stats_dma_unresolved says a CMD_SRIOV_STATS_GET timeout leaves…

--

enic: require DEVCMD2 and set the V2 VF mailbox source

This patch makes DEVCMD2 mandatory for V2 PF support and V2 VF probe. On
a V2 VF, enic_admin_channel_open() now issues CMD_SRIOV_STATS_GET and uses
the returned vf_index as the MBOX source ID. It also adds per-call DEVCMD2
completion tracking so that a statistics DMA target is retained after a
timeout.

> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index ebe617e752c79..d1f9f2156e0b0 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -271,6 +271,11 @@ struct enic {
>  	u16 num_vfs;
>  	enum enic_vf_type vf_type;
>  	bool vf_registered;
> +	u16 vf_id;
> +	/* A CMD_SRIOV_STATS_GET timeout leaves its persistent coherent target
> +	 * device-owned until a later serialized command completes.
> +	 */
> +	bool sriov_stats_dma_unresolved;

[Severity: Low]
This isn't a bug, but does this comment describe a broader release
condition than the code implements?

The flag is cleared in only two places: on a VNIC_DEVCMD2_COMPLETED result
from CMD_QP_TYPE_SET in enic_admin_qp_type_set(), and on one from
CMD_CLOSE in enic_dev_close(). Every other DEVCMD2 command goes through
vnic_dev_cmd() -> _vnic_dev_cmd2(), which passes a NULL status. Those
commands complete on the same ring but leave the flag set.

The commit message is more precise: "A later blocking QP or close command
result fences that target". Could the comment say the same thing? A later
change might otherwise expect an ordinary devcmd to clear the flag, and
then get -EBUSY from enic_admin_channel_open().

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 8a063c563a41e..6fa27a755e3f3 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -590,15 +604,40 @@ int enic_admin_channel_open(struct enic *enic)
>  		goto disable_queues;
>  	}
>  
> -	vnic_intr_unmask(&enic->admin_intr);
> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    READ_ONCE(enic->vf_id) == ENIC_MBOX_DST_PF) {
> +		struct vnic_sriov_stats *stats;
> +		u32 version;
> +		u16 vf_id;
> +
> +		/* Keep received notifications queued until their ACK can use
> +		 * the VF source ID. The statistics query needs QP_ENABLE first.
> +		 */
> +		err = enic_dev_sriov_stats(enic, &stats);
> +		if (err) {
> +			netdev_err(enic->netdev,
> +				   "Failed to get SR-IOV statistics: %d\n", err);
> +			goto disable_queues;
> +		}

[Severity: Medium]
What happens on firmware that provides DEVCMD2 but does not implement
CMD_SRIOV_STATS_GET (devcmd 98)?

For a V2 VF, enic_probe() checks only vnic_dev_uses_devcmd2(), and nothing
checks for the new command before it is sent. vnic_dev.c already has
vnic_dev_capable(), which sends CMD_CAPABILITY for this purpose, but
vnic_dev_sriov_stats() does not call it.

If the firmware answers ERR_ECMDUNKNOWN, _vnic_dev_cmd2_status() exempts
only CMD_CAPABILITY:

			if (result->error) {
				err = result->error;
				if (err != ERR_ECMDUNKNOWN ||
				    cmd != CMD_CAPABILITY)
					vdev_neterr(vdev, "Error %d devcmd %d\n",
						    err, _CMD_N(cmd));
				return -err;
			}

So the driver logs an error and returns a failure. A timeout returns
-ETIMEDOUT. In both cases the path is:

enic_probe()
  enic_admin_channel_open()
    enic_dev_sriov_stats()
      vnic_dev_sriov_stats()
        vnic_dev_cmd2_status(CMD_SRIOV_STATS_GET)  -> error
    goto disable_queues
  goto err_out_dev_deinit

and the netdev is never registered.

Does this also break VF 0? Before this patch VF 0 could register with the
deployed PF, because its source ID of 0 matched.

The PF-side VIC_FEATURE_SRIOV check in enic_sriov_detect_vf_type() does not
cover VF probe. The patch carries a Fixes: tag and may be backported.
Would it be worth adding a vnic_dev_capable(CMD_SRIOV_STATS_GET) check, or
stating a minimum firmware version in the commit message?

> +		version = le32_to_cpu(stats->ver);
> +		vf_id = le16_to_cpu(stats->vf_index);
> +		if (version != VNIC_SRIOV_STATS_VERSION ||
> +		    vf_id == ENIC_MBOX_DST_PF) {
> +			netdev_err(enic->netdev,
> +				   "Invalid SR-IOV statistics version %u VF index %#x\n",
> +				   version, vf_id);
> +			err = -EINVAL;
> +			goto disable_queues;
> +		}

[Severity: Low]
Is the exact match on VNIC_SRIOV_STATS_VERSION intended?

struct vnic_sriov_stats has a reserved1 field and a reserved2[256 - 23]
tail, which looks like space for fields added in later versions. This code
reads only ver and vf_index, and vf_index sits at a fixed offset. If
firmware raises ver above 1, every V2 VF would fail probe with -EINVAL.

The MBOX capability negotiation in enic_mbox_vf_capability_check() treats
the version as a minimum instead:

	if (version < ENIC_MBOX_CAP_VERSION_1) {

Would a "version < VNIC_SRIOV_STATS_VERSION" check work here too?

Also, the commit message says:

  Validate the returned version and zero-based VF index

The only check on vf_index, though, is that it is not the
ENIC_MBOX_DST_PF sentinel. Could the commit message say exactly what is
checked?

> +		WRITE_ONCE(enic->vf_id, vf_id);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-0-2501d1223eff%40cisco.com
