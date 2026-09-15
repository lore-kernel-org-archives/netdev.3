Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971639792B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468385; cv=none; b=V7kw9YXr6nUXUHsbwEQzGr2G/r5SQ5ar7Dh2oE3Jj3jy+afzlMhNaIpOaBII2IN3zyYhXecj6lbNDg2R53m8GeKu01KWAW3FT1xF7ORM1B4RpQieWntLYbprfLLXPAwg5gsnMOBCVEyMk08fnk9txNni3vbZu8bmyradq5nN37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468385; c=relaxed/simple;
	bh=IMpvgEb64G6MDu8d41GunMygEmE2zoxuSzZCsZg1cK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=demTBn5LLAJn9QemU87j6jP8RdDFI7dO87H1pCWa3W0DutpujJUZAEvmAc+B4qeVHotE9VFwcmMyJetTzUcWnv7XyqcpSAfat1b6quglbcT31teWZdz6dGvUdl22mWF5cO8zHtQ4IJ8uuIiXqIICfnPhscH2J15zT4bhNeL0Oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjPl1rRt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjPl1rRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789468383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4aFfoOaLNBY+Ab4zOG2d+H7sITNZn8EHiRQ7JSC1BI=;
	b=LjPl1rRtoOjzQYrnHtwntkgtexOfGKEmJttkLOS4m41jcCD5hsk31GncjSe4ErX8di6aVM
	Y+3x8sb4ZRBwHa7ZjWsZizx0Xc12q3K/BDZQzzSIntlw0VKn7DQOt4DkFPm/Mxk+9rho+X
	Ma7DLYEeEu/qn9/7ScoQBlG4wLz6Am8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-Q-OClTroOOSgxhLbjbvyPQ-1; Tue,
 15 Sep 2026 06:32:57 -0400
X-MC-Unique: Q-OClTroOOSgxhLbjbvyPQ-1
X-Mimecast-MFC-AGG-ID: Q-OClTroOOSgxhLbjbvyPQ_1789468376
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C7791964CCE;
	Tue, 15 Sep 2026 10:32:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.83])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 035CB426;
	Tue, 15 Sep 2026 10:32:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: admin@rezlabs.io
Cc: skalluru@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: skip invalid DCBX priorities in bitmaps and FW config
Date: Tue, 15 Sep 2026 12:32:47 +0200
Message-ID: <20260915103247.119775-1-pabeni@redhat.com>
In-Reply-To: <20260910080253.82432-1-admin@rezlabs.io>
References: <20260910080253.82432-1-admin@rezlabs.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
bnx2x: skip invalid DCBX priorities in bitmaps and FW config

This patch avoids shifting by INVALID_TRAFFIC_TYPE_PRIORITY (0xffffffff)
in bnx2x_dcbx_map_nw() and bnx2x_dcbx_fw_struct() by skipping any
traffic type whose stored priority is outside 0..MAX_PFC_PRIORITIES-1.
The stored sentinel itself is left untouched.

> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
> index 9af81630c8a44..e429e64d589d4 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c

[ ... ]

> @@ -1871,6 +1878,9 @@ static void bnx2x_dcbx_fw_struct(struct bnx2x *bp,
>  
>  	/* Fill priority parameters */
>  	for (pri = 0; pri < LLFC_DRIVER_TRAFFIC_TYPE_MAX; pri++) {
> +		if (ttp[pri] >= MAX_PFC_PRIORITIES)
> +			continue;
> +
>  		tt2cos[pri].priority = ttp[pri];
>  		pri_bit = 1 << tt2cos[pri].priority;
>  

[Severity: High]
Does this continue change what the firmware is told about unmapped
traffic types?

When the DCBX app feature is disabled or reports an error,
bnx2x_dcbx_get_ap_feature() fills the whole table with the sentinel:

	bp->dcbx_port_params.app.enabled = false;
	for (index = 0 ; index < LLFC_DRIVER_TRAFFIC_TYPE_MAX; index++)
		ttp[index] = INVALID_TRAFFIC_TYPE_PRIORITY;

Before this patch, the two assignments in bnx2x_dcbx_fw_struct()
truncated that u32 sentinel into the u8 HSI fields, so both
tt2cos[pri].priority and pfc_fw_cfg->dcb_outer_pri[pri] ended up as
0xFF, which is the value bnx2x_fw_defs.h documents as "not mapped":

	/* used by array traffic_type_to_priority[] to mark traffic type \
	that is not mapped to priority*/
	#define LLFC_TRAFFIC_TYPE_TO_PRIORITY_UNMAPPED 0xFF

With the new continue, both fields stay 0 from the memset earlier in
bnx2x_dcbx_fw_struct(). Since 0 is a valid 802.1p priority, doesn't
this now tell the firmware that the NW, iSCSI and FCoE traffic types
are each mapped to priority 0, rather than being unmapped?

The only early return in bnx2x_dcbx_fw_struct() is:

	/* to disable DCB - the structure must be zeroed */
	if ((bp->dcbx_error & DCBX_REMOTE_MIB_ERROR) && !mfw_configured)
		return;

which tests a different error bit than the app error/disabled bits, so
the sentinel state does reach the loop. The UBSAN "exponent 255" report
in the commit message confirms that.

The values are not driver-local bookkeeping. bnx2x_dcbx_resume_hw_tx()
calls bnx2x_dcbx_fw_struct() and then issues BNX2X_F_CMD_TX_START,
which reaches bnx2x_func_send_tx_start():

	for (i = 0; i < ARRAY_SIZE(rdata->traffic_type_to_priority_cos); i++)
		rdata->traffic_type_to_priority_cos[i] =
			tx_start_params->traffic_type_to_priority_cos[i];

	for (i = 0; i < MAX_TRAFFIC_TYPES; i++)
		rdata->dcb_outer_pri[i] = tx_start_params->dcb_outer_pri[i];

so both arrays go into the DMA-resident flow_control_configuration
posted with RAMROD_CMD_ID_COMMON_START_TRAFFIC.

Would it work to keep the firmware encoding and only skip the shift,
for example:

	if (ttp[pri] >= MAX_PFC_PRIORITIES) {
		tt2cos[pri].priority = LLFC_TRAFFIC_TYPE_TO_PRIORITY_UNMAPPED;
		pfc_fw_cfg->dcb_outer_pri[pri] =
			LLFC_TRAFFIC_TYPE_TO_PRIORITY_UNMAPPED;
		continue;
	}

For accuracy: tt2cos[pri].cos was already 0 before the patch, because
the u16 pri_bit = 1 << 255 evaluated to 0 in practice and the COS match
loop never fired. The encoding changes are limited to
tt2cos[pri].priority and dcb_outer_pri[pri] going from 0xFF to 0.

The commit message says:

> Keep the stored sentinel so disabled-app state remains visible; skipped
> firmware entries stay zero from the existing memset.

and:

> Valid 802.1p priorities 0..7 keep the previous mapping and firmware
> encoding.

Could these be reworded to state that the firmware encoding for the
invalid/unmapped entries does change from 0xFF to 0, and why that is
considered equivalent? The commit message also notes the driver "was
not rebuilt or loaded", so this part is untested against firmware.
-- 
This is an AI-generated review.

