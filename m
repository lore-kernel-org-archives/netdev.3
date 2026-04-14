Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5921A3029;
	Tue, 14 Apr 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126093; cv=none; b=AGblqitH2jLUIPOUBwfxRoXAdw1fGG699FGg0LDJeuk3Y24JO3rO/oc7UVx9Kl1Ge+4TEvPzrxPuBs55QxEBNCoAm2qlPBhRHO+ZtA+D0Va1pNhF/oO7lwtbd50olUn1OZ6JCLghmpskWxhlElLLKSJJCVgPsEPjQhuVqRMfV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126093; c=relaxed/simple;
	bh=Ymsl1LSQrl3zJWCSW3huvj0m4db53KKcpAUghLKLQYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHEWrSru6n6MouLenezGtnZckWpltZTcwBPpK+fNAzNVik32DbCiUsbA8HF3lJtmaVbLl+gvs6K3gr907mEFbOY7mxiaElb8U9/mftwf1EuKAO4+V4G8/pW42RiYIN9NQQPKMdEBKHPpXBa+ulWhsM1NW0FVdBrX8r3F4Q+CFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3W5aFHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3W5aFHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72058C2BCAF;
	Tue, 14 Apr 2026 00:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126092;
	bh=Ymsl1LSQrl3zJWCSW3huvj0m4db53KKcpAUghLKLQYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3W5aFHZz0QINrxVP/uQoFmrFfuPmUFQBxKXcB+U1bpM28WmdhVW+Cs5Di7+QOf+q
	 yYB4sPUynAVBmvfW0vyfSUmiXXqak8q824isXsEvx20C/MvEXizXDFaL39RLmjJTDK
	 O4TR38/iN0fRRegW+93gbGFCx57didwubjfmucU4lMjmbeuzm9NYVLf2ZScuxujWp6
	 REwWGPvpsWfSlWdpEmN4wmlCePiDoI/GDhec6XQ6219j1RK8W0vev5Q8UQw9FKhwW9
	 R/FUgddEd2e4INhBJSdJa8RZFSkveq93F3dkTWMgzT2SV1gXxqSxBe+OSjgEyswlue
	 nlU78BhlKw5vg==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 03/10] enic: add admin RQ buffer management
Date: Mon, 13 Apr 2026 17:21:25 -0700
Message-ID: <20260414002125.3734260-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-3-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-3-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add admin RQ buffer management

This commit adds buffer management for the enic driver's admin receive queue,
allocating DMA buffers on open and draining them on close.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index d1abe6a50095d..a8fcd5f116d17 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
[ ... ]
> @@ -151,6 +212,7 @@ int enic_admin_channel_open(struct enic *enic)
>  	vnic_wq_disable(&enic->admin_wq);
>  	vnic_rq_disable(&enic->admin_rq);
>  	enic_admin_qp_type_set(enic, 0);
> +	enic_admin_rq_drain(enic);
>  	enic_admin_free_resources(enic);
>  	return err;
>  }

Could this sequence allow the hardware to DMA into freed memory?

Here and in enic_admin_channel_close() below, vnic_rq_disable() is called
before enic_admin_qp_type_set(enic, 0), meaning the firmware might still be
actively routing admin messages to the queue.

Additionally, the return value of vnic_rq_disable() is ignored. If the disable
operation fails or times out, the hardware queue will remain active.

Then enic_admin_rq_drain() unconditionally unmaps the DMA addresses and frees
the buffers. If the queue is still active, incoming messages could be written
directly into the freed memory.

Would it be safer to stop the source of the messages first, and verify the
queue is successfully disabled before freeing the buffers?

[ ... ]
> @@ -166,7 +228,7 @@ void enic_admin_channel_close(struct enic *enic)
>  	enic_admin_qp_type_set(enic, 0);
>  
>  	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
> -	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
> +	enic_admin_rq_drain(enic);
>  	vnic_cq_clean(&enic->admin_cq[0]);
>  	vnic_cq_clean(&enic->admin_cq[1]);
>  	vnic_intr_clean(&enic->admin_intr);
