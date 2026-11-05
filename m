Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881591;
	b=3uEPB8MjrYm0kGAmG8JRfu7cxpIPzWFDslNA6OjKzKF4EsWAGNEewRjtXt7uvf9H9eBu
	 WjLCJYpVwA5TgbtxhdXTW1FcyTbZ+cg0TzOKYj9lCFd5MuB8BLBINJRiZNsP25YFl6YyY
	 FddtSnQ6rIg7jJ1ffsFA39jfXzoV9e+iMlQCX6NPsLkGFzI16zpwa8BQdDOJOX7vVlFal
	 lnhr6VvovwxgJErovwVke6aDmXnhSwxziq3/gRNhzsAjOcz2ZUSr/Gad3bQYUyFgSA31q
	 TRZarFBGbzAvzJSxbd9qsxFsdW/GbX9EWh9AgJlDeaneX/fT38saEwUBRSxbKMOoLEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881591;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=iK0upVVHj6CH2nJbJWc/rtLMFbPNRgClx8lZjjU/rLI=;
	b=wmgLBu6j1vRdIEmF1+rOJzKus+li0Ezb//CV8FmQf2ca8WAwknuP6qTrzxzZLbrtPDPM
	 WW4fQH8f/Me5/cgytj7UCF+qsRppC9gNP4ZgVI5Glh7xZseS+PfTUaf27jVjWpScXsrAr
	 8AJGhtb5pc8FkwUyZ7j3eFOIK5FLHqN0B6aVfxmR3buhayWXEY8ZXdHd25oge8lIWUt2E
	 tXzbrOsjJ/sKiWO65HHdQ/eWC0uI79GQJiHZzXt3hVTdwM3iWHMAkUEZo/6iWvGrfxZN9
	 Alina/R+Qpm4CPDD24LYcsU75txQFZeLNMhalbTxFJd3U3PFS4P7vJ2a1WnUm3rusAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZElehuT;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B9606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZElehuT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793881589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iK0upVVHj6CH2nJbJWc/rtLMFbPNRgClx8lZjjU/rLI=;
	b=UZElehuTif/wSko0TZYU7I/h6XvGrjlx6QoAIYz/fBiEyi/qjCy9eJWqm3oC/0BwZfEB7f
	B0twcyGhyAGwJHXswcxd5TWSOlm23kfp0BkJhRGdnOxeMEqRZtHqPRXqnnPchvSNxCSUDY
	Up/BvF7F9bfSoo4kno+qGCT9jteLZk0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-oQAo8b2KNAKlL3VUlX3_EQ-1; Thu,
 05 Nov 2026 07:26:23 -0500
X-MC-Unique: oQAo8b2KNAKlL3VUlX3_EQ-1
X-Mimecast-MFC-AGG-ID: oQAo8b2KNAKlL3VUlX3_EQ_1793881581
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E56D2180047B;
	Thu,  5 Nov 2026 12:26:20 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F40121956088;
	Thu,  5 Nov 2026 12:26:16 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	intel-wired-lan@lists.osuosl.org,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v4 15/15] ice: support up to 256 VF queues
Date: Thu,  5 Nov 2026 13:25:58 +0100
Message-ID: <20261105122558.1701877-1-poros@redhat.com>
In-Reply-To: <20261103141646.303620-16-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com> <20261103141646.303620-16-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 3 Nov 2026 15:14:56 +0100, Przemek Kitszel wrote:
> Add support for up to 256 VF queues. To enable more than usual 16, user
> needs to assign GLOBAL LUT (devlink resource named "rss/lut_512") for 64
> queues or PF LUT (name "rss/lut_2048") for maximum of 256 queues.

I ran the whole v4 on an E810-C for SFP (4 ports, 10G DAC between two
of them, FW 8.1.1 with mgmt API 1.7.11, DDP COMMS 1.3.55.0) on top of
net-next 7b6ab4dbc156 with lockdep, and again with KASAN. The
documented flows work as described: PF and VF LUT assignment, 64 and
256 queues on a VF (also with 65 MSI-X), VF FLR, iavf unbind and bind,
PFR, CORER and GLOBR restoring the default assignment, the ADQ
exclusion in both directions, 16 VFs taking all 16 global LUTs, and
teardown with LUTs still assigned. The two problems below come with
this patch.

> diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
[...]
> @@ -329,12 +328,16 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
>  	if (vf->driver_caps & VIRTCHNL_VF_CAP_PTP)
>  		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_PTP;
>  
> +	if (vf->driver_caps & VIRTCHNL_VF_LARGE_NUM_QPAIRS &&
> +	    vsi->rss_lut_type != ICE_LUT_VSI)
> +		vfres->vf_cap_flags |= VIRTCHNL_VF_LARGE_NUM_QPAIRS;
> +
>  	vfres->num_vsis = 1;
>  	/* Tx and Rx queue are equal for VF */
>  	vfres->num_queue_pairs = vsi->num_txq;
>  	vfres->max_vectors = vf->num_msix;
>  	vfres->rss_key_size = ICE_VSIQF_HKEY_ARRAY_SIZE;
> -	vfres->rss_lut_size = ICE_LUT_VSI_SIZE;
> +	vfres->rss_lut_size = vsi->rss_table_size;

This reports the 512 or 2048 entry LUT to every VF, including VFs that
never negotiated VIRTCHNL_VF_LARGE_NUM_QPAIRS. The iavf before this
series copies the new rss_lut_size in iavf_parse_vf_resource_msg()
when the GET_VF_RESOURCES reply of the reset arrives, but its rss_lut
buffer was allocated once in iavf_init_config_adapter() with the 64
entries reported back then. From that point iavf_get_rxfh() and
iavf_set_rss_lut() read rss_lut_size bytes out of the 64-byte object,
so the LUT sent to the PF carries neighbouring heap memory, and the
next VF reset writes rss_lut_size bytes into it through
iavf_reset_step() -> iavf_init_rss() -> iavf_fill_rss_lut(). The
in-tree iavf of every released kernel behaves this way, so a guest with
an older kernel hits it as soon as the host admin assigns a LUT, and
presumably other VF drivers that size their LUT once are affected the
same way.

Reproduction on the PF with this series and an in-tree iavf built from
the parent commit bound to the VF:

  echo 1 > /sys/bus/pci/devices/0000:04:00.0/sriov_numvfs
  devlink resource set pci/0000:04:01.0 path rss/lut_512 size 1

After the deferred VF reset, ethtool -x on the VF showed a 512 entry
table with 60 distinct queue indices for a VF that has 16 queues, two
following ethtool -L calls on the VF (two more VF resets) went through,
and the host hung hard right after that, without reaching the serial
console.

I think the PF has to keep reporting ICE_LUT_VSI_SIZE and leave the
VSI on its VSI LUT for VFs without VIRTCHNL_VF_LARGE_NUM_QPAIRS, or
reject the devlink change for such a VF with an extack message. The
mix of an old VF driver and a new PF driver is exactly what stable
backports and VMs produce.

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
[...]
> @@ -1005,19 +1005,37 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
[...]
>  	cur_queues = vf->num_vf_qs;
> +	/* without LARGE_NUM_QPAIRS, VF can only use the v1 queue opcodes */
> +	if (vf->driver_caps & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
> +		max_lut_queues = ice_lut_type_to_qs_num(vsi->rss_lut_type);
> +	else
> +		max_lut_queues = ICE_MAX_QS_PER_VF_VCV1;
>  	tx_rx_queue_left = min_t(u16, ice_get_avail_txq_count(pf),
>  				 ice_get_avail_rxq_count(pf));
>  	max_allowed_vf_queues = tx_rx_queue_left + cur_queues;
> +	if (req_queues > max_lut_queues) {
> +		vfres->num_queue_pairs = max_lut_queues;
> +		goto error_param;
> +	}

Up to now a VF asks for at most 16 queues, so the ranges VFs free and
take again have the same small size and __ice_vsi_get_qs() finds a
contiguous range for a VF VSI in practice. With requests of 64 and
256 the PF queue space fragments quickly, the ICE_VSI_MAP_SCATTER
fallback kicks in for VF VSIs, and ice_ena_vf_q_mappings() only logs
"Scattered mode for VF Tx queues is not yet implemented" and leaves
VPLAN_TX_QBASE and VPLAN_RX_QBASE unprogrammed for the new range. The
reset still completes and the VF is told it owns the queues.

Reproduction with 16 VFs on one PF:

  for vf in 0000:04:01.{0..7} 0000:04:02.{0..7}; do
      devlink resource set pci/$vf path rss/lut_512 size 1
  done
  for vf in enp4s0f0v{0..15}; do ethtool -L $vf combined 64; done

All 16 requests were granted and 12 of the VFs came up with scattered
Tx and Rx mappings. The three of those I checked (VF 3, 4 and 10)
have no connectivity at all, ping fails in both directions and no Rx
queue ever counts a packet, while VFs with contiguous mappings pass
2 to 4 Gbit/s in a short iperf. iavf on an affected VF then loops on
"Failed to configure queues, error IAVF_ERR_PARAM" (CONFIG_VSI_QUEUES
is NACKed by ice_vc_cfg_qs_msg() without any message on the PF side)
and on NETDEV WATCHDOG transmit timeouts, 70 of them on VF 3 alone.
About 20 s after the grants the PF also logged "Tx Malicious Driver
Detection events detected on PF 0 VF 13", a VF with a contiguous
mapping; I did not chase whether the stale mappings cause that.

A request that cannot be served with a contiguous range should be
refused here, or clamped to what can be, and ice_vf_rebuild_vsi()
should fail the reset instead of leaving the VF half mapped. Sashiko's
remark about max_lut_queues not being clamped to max_allowed_vf_queues
is about the same spot.

One more data point, not caused by this series. While stressing PFR
together with the LUT changes I hit a slab-use-after-free in
ice_add_rss_cfg_sync() called from ice_replay_rss_cfg(). It reproduces
on plain net-next with "ethtool -X <pf> equal 4" followed by a PFR, so
I will report it separately with the details.

Regards,
Petr

