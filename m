Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46883B42CE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557094; cv=none; b=Lrt3LYdOR8EOHE7GBJFJXirTC7EpIhF0mTuXG6GPsF6P2zMGwR+PNRqK8MPP1jG94zrh4KKSTLoW8Ttu1HxMPfyGb0uPj/Gn9DS+tYJ/m6QxXfkMrLzjpuzpgDUQClRzfR0AYvlEk4Thg6ZnVbFQiuIsg4i7a4Ubh44UqLr62Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557094; c=relaxed/simple;
	bh=UXSjJ8PjM65uSLxlz58RIRFwrovnsMYdMnC/FIeIuIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiXDZVXlzxx7L6Q1GNvtBvUdB464cIiJW+zPrF4zp2NRsdMuLpJxESIT/mS5cIWM6RSdGDg5fLq9nFYMjfA2Q/1/wZ+Lzdo00qxmzo9XA5JQB9+G491CGmEQPmRmXz0gFV2hiQzgE67pwNrcGcXUyD77RhyeT8V/lorqtbQRbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ6Vr0B/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ6Vr0B/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C05A1F000E9;
	Mon, 15 Jun 2026 20:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781557093;
	bh=zUd+W0FeD1SqLu0YbyUslyjd0iunVCVN9DkSX/L7Qg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TQ6Vr0B/WeRQ7w6uAS6excLt3874l2jBGtvnmKRfC9FcOF3WmHYvKOTPGdXCkT7Hh
	 ZfUxc88fRZFRzbwb7ACqZwmbl9QtcZuswFxfd7HSx+mbn+s46HxaVWWZ+SavEfJZB/
	 ixpUWEd0TgdPSWdzP2G0wQRcQptKuVsaRmpk2hGEp/MLUR5mSWJznT/sycwyzJPnDp
	 s4g7P2M4YN+GxMc/bhgTAGH1+nj1izrlvyMQ+dYgtXx45NovtMCu9JeAGzt0uQjl+3
	 qDF7MI+riNRiZ0orpurcARrfvUT6u24eusQxJ+k3yUuUCoMdv3KbCBAbBqfXoSYc+s
	 o+rCBIFSSKh/g==
Date: Mon, 15 Jun 2026 13:58:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 12/15] bnxt_en: Support kTLS TX offload by
 implementing .tls_dev_add/del()
Message-ID: <20260615135812.5663998b@kernel.org>
In-Reply-To: <20260614072407.2761092-13-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
	<20260614072407.2761092-13-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 00:24:04 -0700 Michael Chan wrote:
> Add basic infrastructure to allocate and free kTLS context IDs (KIDs)
> to support kTLS TX offload.  To offload a connection in .tls_dev_add(),
> the first step is to allocate a KID.  After that the kTLS offload
> command is sent to the HW via MPC using the function
> bnxt_xmit_crypto_cmd() introduced in the last patch.
> 
> In .tls_dev_del(), we send the delete command to the HW using the
> same bnxt_xmit_crypto_cmd().  After that we free the KID, making it
> available for new offload.  There is extra logic to handle ifdown,
> FW reset, and device reconfiguration while deleting the connection.
> 
> bnxt_ktls_init() assigns bnxt_ktls_ops to the netdev and sets up
> the TLS TX offload feature.  bnxt_ktls_init() will be called in
> the next patch.

Warning: drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c:320 expecting prototype for bnxt_free_one_ctx(). Prototype was for bnxt_free_one_kctx() instead
