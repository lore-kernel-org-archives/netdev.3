Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEC339362
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464143; cv=none; b=Kn3UaRnCBPSuNtUBfN/gQ0DTuZTNRNpgm5ZTaj2fbKhO9Ah3ZZ+LL9gzw36TffA9gaBir0FM6FFhzbsp/37bPXD4mf+E23O7sK6f246JGhQbm/PgtUp9nvQwZO9MUW+4iPwNDwB0arEvogHuy/KIBrqebqgTu7bPzmGA9YZ+DOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464143; c=relaxed/simple;
	bh=vpJ2m3WVJ+ZWlwZ45XrmIJUfYLUSFJ4thsDQKkfwywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH/DIBfZkWKNoEul4hmtl3zc303YNxxKVE3UVvDCQB20/LN+5N5+EjlRO00ZnZWeQTxiR1C79WeC7XkSjIKljzDnNA/dwnu1GitRAKGqUp0ImwR8XFAFHOt0Icu7iBrUhrS32bdCYGYCuAQ+te2X3QKjKK5szXU2rSnNbDFL1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhM9IePM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhM9IePM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786464140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M57msK1gt394tHHb8/wcEXScUoSQF7jRkGcnZ1po3R4=;
	b=bhM9IePM3eiAF9wImxd0zICfrM6DCpSEcYhdDfDj7+GlbMC8ssgT5eAp5QzWZzYUnL6lsH
	aTdfzckvIj+xI/7cmR3EgZEQRw1A2oEr6qr6/lBKQoGb5+jEk3MbeukQR7xs2YZXiTPxOV
	Ek83CHMr8XwAjNnT2LRLCdYlJtdwd88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-4SHOdkvxNMqOKSwFbm3M6A-1; Tue,
 11 Aug 2026 12:01:50 -0400
X-MC-Unique: 4SHOdkvxNMqOKSwFbm3M6A-1
X-Mimecast-MFC-AGG-ID: 4SHOdkvxNMqOKSwFbm3M6A_1786464109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 772DA195604C;
	Tue, 11 Aug 2026 16:01:49 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4E2A19560AB;
	Tue, 11 Aug 2026 16:01:47 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: przemyslaw.korba@intel.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	jramaseu@redhat.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write support for sideband queue operations
Date: Tue, 11 Aug 2026 18:01:39 +0200
Message-ID: <20260811160140.2161988-1-jramaseu@redhat.com>
In-Reply-To: <20260319111659.551039-1-przemyslaw.korba@intel.com>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Mar 19, 2026 at 12:15 PM Przemyslaw Korba <przemyslaw.korba@intel.com> wrote:
>
> On E830, PTP time adjustment commands sent via
> SBQ don't generate completion responses, causing the driver to
> timeout waiting and return -EIO, when trying:
>
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
>
> Add support for posted mode not to wait for completion response.
>
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> - change "postpone" to "posted"
> - init struct with {} instead of {0}
> v1:
> https://lore.kernel.org/intel-wired-lan/20260310110700.345904-1-przemyslaw.korba@intel.com/
>
>  drivers/net/ethernet/intel/ice/ice_common.c   | 7 ++++++-
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 4 ++++
>  drivers/net/ethernet/intel/ice/ice_controlq.h | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 8866902efb91..c89c6ca1281b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1765,6 +1765,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
>  {
>         struct ice_sbq_cmd_desc desc = {0};
>         struct ice_sbq_msg_req msg = {0};
> +       struct ice_sq_cd cd = {};
>         u16 msg_len;
>         int status;
>
> @@ -1785,10 +1786,14 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
>                  */
>                 msg_len -= sizeof(msg.data);
>
> +       if (in->opcode == ice_sbq_msg_wr)
> +               cd.posted = 1;
> +
>         desc.flags = cpu_to_le16(flags);
>         desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
>         desc.param0.cmd_len = cpu_to_le16(msg_len);
> -       status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
> +       status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
> +
>         if (!status && !in->opcode)
>                 in->data = le32_to_cpu
>                         (((struct ice_sbq_msg_cmpl *)&msg)->data);
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> index dcb837cadd18..a6008dc77fa4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> @@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>         wr32(hw, cq->sq.tail, cq->sq.next_to_use);
>         ice_flush(hw);
>
> +       /* If the message is posted, don't wait for completion. */
> +       if (cd && cd->posted)
> +               goto sq_send_command_error;
> +
>         /* Wait for the command to complete. If it finishes within the
>          * timeout, copy the descriptor back to temp.
>          */
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
> index 788040dd662e..c50d6fcbacba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.h
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
> @@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
>  /* sq transaction details */
>  struct ice_sq_cd {
>         struct libie_aq_desc *wb_desc;
> +       u8 posted : 1;
>  };
>
>  /* rq event information */
>
> base-commit: acd2abc52dea91c3bc3d1b6dd8a92b9631d48bbf
> --
> 2.43.0
>
This is actually a valid fix to a,
885c5e57924dc0 ("ice: fix 'adjust' timer programming for E830 devices"),
which allows the E830 HW to continue in the function 
and then invoke the following: (with some ice_debug() messages enabled)

[ 2946.907728] ice 0000:6c:00.0: Failed to send message to PHY, err -5
[ 2946.907731] ice 0000:6c:00.0: Failed to prepare PHY ports for timer command 2, err -5
[ 2946.907733] ice 0000:6c:00.0: PTP failed to adjust time, err -5

But the patchwork lists it as Changes Requested. Any idea what happened with it?

Tested-by: Jakub Ramaseuski <jramaseu@redhat.com>

