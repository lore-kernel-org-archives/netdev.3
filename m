Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B33E5A2E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415467; cv=none; b=AFcrKX8HCRLycolD+CXK3BR1dYGUH/2lnaq7HUhLX8M7jAG/REKfLmSxxNqXx6903JVBAEpDPgmp0vH1m0QfD6Y5K5zOIIT/UBcsxgsAE/XmJfYzVVl4w32yTHmrad8qEMeifdvn76HYk8M0mCXYpwi49hJ7Zz6w8puusLlY29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415467; c=relaxed/simple;
	bh=QzNsK7rFLIoeGEIayo5E+3AYoDpfcbywxFbpaKUUE4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3peAC3hBmiLUX7CirJuuTp1SgrHr6v1pP8H6Bb6zGIWDL5mf5KR5xUMVIsk3eCMV9vXVR5zykpz/IYAVlShXpbtpirbEAJ8sL8KjNLz7PraO/ZApW8Qs/oFPUF/kbzqYOsPTGHf/47zyEQELEVawqSUu08za5JHjvXkWAm85LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI3DhsWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI3DhsWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E542D1F00893;
	Tue,  2 Jun 2026 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415466;
	bh=7x17cech0QEHBN2xgd52j16S/dxR37CAYobneoa5SV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI3DhsWnCVU2a0zXrhPD8kRbYo6KjkAvdbUzSjpvqTRC47K5OhiXHO1U4sKocvxTY
	 VBPazaHPZllHPSVnNs8HGvOTjh6Ab0v9axIl4e5rlb5gRINzlpJJ4AO2Tz5tXi/1Ic
	 S/HJf46ykWDRMb57j89XxAv4dmZ8yqeq0SS28GbYiHFpoqCjoE+/GoVVjqSzkDe23/
	 5ApjmLDnJxDPu6yCcVu/FdhcUDxSiQ7ECTusOCZd1ZY/2kXutCUWLbuDIjJCnEJ2Bn
	 YTpeAikbsdu2UX9/KxLxwWkkLOgLXVzYBLnEp/QIdSGvJe3Ur8KT71So+eg9f395q1
	 qlYHyOepcEZBw==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] ice: validate FDIR action queue index against VF VSI queue count
Date: Tue,  2 Jun 2026 16:49:12 +0100
Message-ID: <20260602154911.3594793-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527071842.11478-2-aleksandr.loktionov@intel.com>
References: <20260527071842.11478-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: validate FDIR action queue index against VF VSI queue count

This patch adds a bounds check on the VF-supplied queue index in
ice_vc_fdir_parse_action() against vsi->num_rxq for both
VIRTCHNL_ACTION_QUEUE and VIRTCHNL_ACTION_Q_REGION, so a VF cannot
direct matched FDIR traffic to queues outside its own VSI.

> diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
> index 4f1f3442e52c..1bc524f3616c 100644
> --- a/drivers/net/ethernet/intel/ice/virt/fdir.c
> +++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
> @@ -1152,6 +1152,7 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,

[ ... ]

> @@ -1176,11 +1181,21 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
>  			break;
>  		case VIRTCHNL_ACTION_QUEUE:
>  			dest_num++;
> +			if (action->act_conf.queue.index >= vsi->num_rxq) {
> +				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
> +					action->act_conf.queue.index, vf->vf_id);
> +				return -EINVAL;
> +			}
>  			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
>  			input->q_index = action->act_conf.queue.index;
>  			break;
>  		case VIRTCHNL_ACTION_Q_REGION:
>  			dest_num++;
> +			if (action->act_conf.queue.index >= vsi->num_rxq) {
> +				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
> +					action->act_conf.queue.index, vf->vf_id);
> +				return -EINVAL;
> +			}
>  			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
>  			input->q_index = action->act_conf.queue.index;
>  			input->q_region = action->act_conf.queue.region;

[High]
For the VIRTCHNL_ACTION_Q_REGION case, does this check fully close the
steering hole the commit message describes?

The commit message states that the patch validates the action queue
index for both action types, but the Q_REGION action targets a range
of 2^q_region consecutive queues starting at queue.index, and
action->act_conf.queue.region is still copied verbatim into
input->q_region:

	input->q_index = action->act_conf.queue.index;
	input->q_region = action->act_conf.queue.region;

ice_fdir_fltr documents q_region as:

	/* queue region size (=2^q_region) */
	u8 q_region;

and ice_fdir_get_prgm_desc() programs it into the descriptor's TO_Q
field for the QGROUP destination:

	if (input->dest_ctl ==
	    ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP)
		fdir_fltr_ctx.toq = input->q_region;
	fdir_fltr_ctx.drop = ICE_FXD_FLTR_QW0_DROP_NO;
	fdir_fltr_ctx.qindex = input->q_index;

ICE_FXD_FLTR_QW0_TO_Q_M is a 3-bit field (0x7), so q_region can be up
to 7, i.e. up to 128 queues starting at q_index.

With the new check, a VF can still set queue.index = vsi->num_rxq - 1
(which passes "index >= vsi->num_rxq") together with queue.region up
to 7, causing the hardware to spread matched traffic across queues
beginning at the last valid VF queue and extending past the end of
the VF's VSI into queues owned by another VF or the PF.

Should the Q_REGION case additionally bound queue.region and verify
that queue.index + (1 << queue.region) <= vsi->num_rxq (and possibly
require queue.index to be aligned to 2^queue.region as is conventional
for hardware queue groups)?
