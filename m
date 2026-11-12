Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524862;
	b=iNPMThfWYPSP7OMddVwJy0rBdEUNZMD+oQzF5G699Gjz+ObGZVUdhK6E7zK3rLOxirRV
	 RVSdHO71yKaAP3aYY7pLnuMVjjvdd9fGAFLJ0WfLY6BLb404dnDiXR0DqUSJ5jwH+NtVl
	 Sf960fFDeTg7l2j4eP6rSnzCrfCrHiDJ1vXxLSG0QFWGVdZmCr6PJZBresxV8g8JnZcVs
	 wtdcrITpcpTJBj6p3tGu5kb/+36sTNYtU4JhHfEQjxZukezl4y/l2ln/2yGqsR1bJAwMq
	 AYeDVHEXJleEYec+oRJkcoqdAvpgCaHlwl9ysG7a7YDI3+lLQq2T7o+Q7mjClgLiKEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524862;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NvShZselLw+f68+vxnWiB6x6pndRpF29QA5p8Qv8+EM=;
	b=aNaBPtje/S/sBB6oDZPD/WrWyAqU64/EUfnsvnlBjfYP04JTYOPaevYJiB0Fd/I8RcSF
	 5OrMRj9900ultJcA1ieDmF1DdGL3wp4FDeHXd82vGtejkaTeKiKiWmQgrfmWYyV1gBJ1w
	 NoHF3EvLKTSdlpJuiV/hGeRVwldiIJVhgrYR2VksJkTeYbHSSl8q80jwfBXx1UMbT8IQ5
	 xnAWeusIjDjk7Vnz3txDI5EBJNGTfouuTOsZvXapbs/0EecELzGO160g2Iha7tn83Rfau
	 CldwxJArAbyqlZX0W8yPSqfspyrOM7FEMirr5VKR9PLwcLwzt0JSM8LmhgFN0H53FDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DztCMP8G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84745606A890
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DztCMP8G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71491F000C4;
	Thu, 12 Nov 2026 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524862;
	bh=NvShZselLw+f68+vxnWiB6x6pndRpF29QA5p8Qv8+EM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DztCMP8GNCc23NyIAAxDUZ+NxyJCJKv5MzqONOSa1sl5toMM8ZZhH+kBB3rXZ5KKZ
	 14IVscdANxSadw3soBCNqT4LTNwT1vPy77CJz5pJ4cijzR/HHJJjxeF4NW9zoXEN50
	 tg4GCJxkEOx72ty5wvokvetNK1mE+/Afy5dv/6zflS4sfM/YinL5trjcGNjiGhtKYD
	 8pxJNCzVfNZQ5kJpK7Iy4KVy7Q9Lul1y7hBTrKm6my1NgaajfucRIIoe8cS0+zHoEY
	 1G8BmYVrAY+vBonNd9dmFJhexSOuNO6/WzPe3exBKJ3hyk/AB7xF4zo1pcg3wY4HQS
	 UHHb33bLTasAQ==
Subject: Re: [PATCH net-next v5 11/15] ice: introduce handling of virtchnl
 LARGE VF opcodes
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com, edumazet@kernel.org,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net, jiri@resnulli.us,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com,
 poros@redhat.com
Date: Thu, 12 Nov 2026 23:07:40 +0000
Message-ID: <179452486033.2199510.16953679518950207701@kernel.org>
In-Reply-To: <20261110141534.95614-12-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-12-przemyslaw.kitszel@intel.com>
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

- [Low] This patch changes the type of struct ice_q_vector::num_ring_rx
  and num_ring_tx from u8 to u16 in drivers/net/ethernet/intel/ice/ice.h…
- [Low] The kernel-doc summary of ice_vc_validate_qv_maps() in
  drivers/net/ethernet/intel/ice/virt/queues.c (line 1257) reads…

--

ice: introduce handling of virtchnl LARGE VF opcodes

This adds PF-side handlers for VIRTCHNL_OP_ENABLE_QUEUES_V2,
VIRTCHNL_OP_DISABLE_QUEUES_V2 and VIRTCHNL_OP_MAP_QUEUE_VECTOR. With these
handlers, VFs that negotiate VIRTCHNL_VF_LARGE_NUM_QPAIRS can use more than
16 queues. VIRTCHNL_OP_GET_MAX_RSS_QREGION is only allowlisted for now.

> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 89a2bdbecf609..fc2e84136e247 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -474,8 +474,8 @@ struct ice_q_vector {
>
>  	u16 v_idx;			/* index in the vsi->q_vector array. */
>  	u16 reg_idx;			/* PF relative register index */
> -	u8 num_ring_rx;			/* total number of Rx rings in vector */
> -	u8 num_ring_tx;			/* total number of Tx rings in vector */
> +	u16 num_ring_rx;		/* total number of Rx rings in vector */
> +	u16 num_ring_tx;		/* total number of Tx rings in vector */

[Severity: Low]
This isn't a bug, but could the commit message body mention this change?

struct ice_q_vector is the PF's own interrupt vector structure, and the PF
data path uses it too. The only explanation for widening num_ring_rx and
num_ring_tx is in the v5 changelog below the '---' line:

  widen num_ring_{rx,tx} of struct ice_q_vector to u16, mapping all
  256 queues of a VF to one vector wrapped them around

That text is dropped when the patch is applied.

The reason is that ice_vc_map_q_vector_msg() increments num_ring_rx and
num_ring_tx once for each mapped queue, and up to 256 queues can be mapped
to one vector. Would a sentence saying that in the commit body be worth
adding?

>  	u8 wb_on_itr:1;			/* if true, WB on ITR is enabled */
>  	/* in usecs, need to use ice_intrl_to_usecs_reg() before writing this
>  	 * value to the device
> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> index 7f2b459dbc836..f87ccf5d370bb 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -1046,3 +1046,342 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)

[ ... ]

> +/**
> + * ice_vc_validate_qv_maps - validate parameters sent in the qs_msg structure

[Severity: Low]
This isn't a bug, but the kernel-doc summary names the wrong structure.

ice_vc_validate_qv_maps() validates a struct virtchnl_queue_vector_maps
passed as qv_maps, and it has no qs_msg parameter. The text looks copied
from ice_vc_validate_qs_v2_msg().

Should this say "validate parameters sent in the qv_maps structure"?

> + * @vf: VF the message was received from
> + * @qv_maps: contents of the message from the VF
> + * @msglen: length of the @qv_maps

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
