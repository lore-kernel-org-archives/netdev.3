Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A524C97
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029103; cv=none; b=G0GZIuyIWvwSBfWaV5uZ467RHqiBlg94F3Tyl7CcwGwQQ89ghSmD/ZeIG0oHdV9ow/80Aza1FfGu2tc1fNGbH1eUghJFq8dH0lYHZoDB561HwUPwJLSc6VHqt3i6oI6GWOAuM/1VXaDvegkkps/k2D8WwFK5nFm45dbVSZbacw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029103; c=relaxed/simple;
	bh=+JAxaUx7UjoHVnOTmI+xdaE+Svq3/qAHj2vs9aT850I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDSziTR0AhwQoUf+edlQrnjMNbEtbJ2ltk3qVz7QZ6+SbNOflzHpD75gI9GtLqZ1lVDAyROKTeaHQGFEoBRA+ay3I2h+g2e19i8Fqb7LI3dLbC2G0oIwP5uPTpePgc408qHTumhzpAxFMFXcV/pQ4tV+hfTQYfon4Qn+D3Toj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHxInPX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHxInPX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699F6C2BCB4;
	Wed,  6 May 2026 00:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029102;
	bh=+JAxaUx7UjoHVnOTmI+xdaE+Svq3/qAHj2vs9aT850I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vHxInPX+q5s/mIk+Uc+bDLwpbKN2yORUkwZfq4ez/5TEYLALSQWrdRBvksORInXOV
	 Y35ldDfYMgEVvJN/VxDcOW/bHCnTE82dj338XfDi12dYw6VFPa4ABe+MFkUTffcxOG
	 HzzaubA1Of5yJQh2TYn0FbUk4PyObtNVy7hjwTNsStE89dMeBjSk1dWToeq0ulLVZj
	 TiousA9Hm4veN5X8ghQWn2072LP/oC1HfsMeOd7yaJdKBxuH/zpbX2AaL4ckWAhGm1
	 Ta2E2vF7LylDjM1WpD2RLPS3Y31xHOyQW+vRmEr+MH3fvTpehfIxPO3uQZ7XRfnmZz
	 Ul+13frI4Xe8Q==
Date: Tue, 5 May 2026 17:58:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 12/15] bnxt_en: Support kTLS TX offload by
 implementing .tls_dev_add/del()
Message-ID: <20260505175821.5cfd800d@kernel.org>
In-Reply-To: <20260504235836.3019499-13-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
	<20260504235836.3019499-13-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 16:58:33 -0700 Michael Chan wrote:
> Add basic infrastructure to allocate and free kTLS context IDs (KIDs)
> to support kTLS TX offload.  To offload a connection in .tls_dev_add(),
> the first step is to allocate a KID.  After that the kTLS offload
> command is sent to the HW via MPC using the function
> bnxt_xmit_crypto_cmd() introduced in the last patch.
> 
> In .tls_dev_del(), we send the delete command to the HW using the
> same bnxt_xmit_crypto_cmd().  After that we free the KID, making it
> available for new offload.
> 
> bnxt_ktls_ops will be assigned to the netdev and the TLS features will
> be enabled in the next patch.

drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:269:32: warning: unused variable 'bnxt_ktls_ops' [-Wunused-const-variable]
  269 | static const struct tlsdev_ops bnxt_ktls_ops = {
      |                                ^~~~~~~~~~~~~

Warning: drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:24 No description found for return value of 'bnxt_alloc_ktls_info'
Warning: drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:24 No description found for return value of 'bnxt_alloc_ktls_info'
