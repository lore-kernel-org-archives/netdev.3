Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8983B52E6
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070519; cv=none; b=btzhNm2A73qMamiup9waGpm8UqoeIYIt2kjgsjelccsbIFFbqgIR4Qshy3oGB8r/69zntaqTRksYcbqEVkTs0vrGp92yAhvlRhdY+L+flmV0WNqAAV+hCE506rzVF9qpWmiKBykmzAk0HzXNMCkgGim5k9TKsNsEa4PmR3X+RzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070519; c=relaxed/simple;
	bh=E78LtmI6PrxdG3FpOofBnDZpLMsfS+njHi1wo6UMfGI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfIyJLU3S+qrSvlre1IwQjWmIpZy3BoG2mVRsr6700KiK3R7lDYJ37DZ4Zh5fWtZKTmBfXCgUoE1WqYsFa1siFJqQFAdivi/En79jTpa8uj+yqxXWg9di2FVK+oqvagR/uaI7gFX4m6d+QTvFcpLDry1yTxnsPon+Qgifv7bV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/toJp8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/toJp8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E5B1F0089D;
	Sat,  3 Oct 2026 23:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791070517;
	bh=IqBVOfbsmtB+klZdXZe33fcWB0RBwDaeJGB1tYBEEGo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L/toJp8AU7Eh6mCLygqpes3TXL8Vu96LEhiPnJbbPJwbWZhv92ZVgfQYs/m6jcb3g
	 CUJp5k9aJ30UN1GvghqcS8HUgX5ZrZqeuofolKMuP00pPatApXEMdrhdBimXRSJ3AV
	 ZzjvAqCFSf3WHKkBIdI1Jwy8jwxbQqPpir6yn3ktrCy4OFCdSwY9DpZ81zlq6O3GDS
	 yI+aLQTPXnnZBrOSWQOFPtIUzM6+B2l24CFv2SymcdJA9q2znjZ+YX7UUvC/Uq9cI6
	 MYUG9Roeit6ygL1KsOgt12qLsWKiGkcXwyxe4Zhj2l8Bl8QbaK5eWu9fxHCUjU60Xy
	 QgXj/cajQwv8Q==
Subject: Re: [PATCH net-next 2/2] libie: log more info when virtchnl fails
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 boolli@google.com, aleksander.lobakin@intel.com, sridhar.samudrala@intel.com,
 emil.s.tantilov@intel.com, decot@google.com, brianvv@google.com,
 aleksandr.loktionov@intel.com, Samuel.salin@intel.com
Date: Sat, 03 Oct 2026 23:35:16 +0000
Message-ID: <179107051628.434549.3228672692343576524@kernel.org>
In-Reply-To: <20260929231305.1515873-3-anthony.l.nguyen@intel.com>
References: <20260929231305.1515873-3-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new "Non-zero virtchnl ret val" log in
  libie_ctlq_xn_process_recv()…

--

libie: log more info when virtchnl fails

This commit adds rate-limited error messages to the libie control queue
code. libie_ctlq_xn_process_recv() now logs when a received message has a
non-zero virtchnl return value. libie_ctlq_xn_send() now logs when a
synchronous transaction ends in a failed state.

> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> index 6214fc036ce5f..5fce6d9db1e28 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -835,6 +835,13 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
>  		return false;
>  	}
>  
> +	if (ctlq_msg->chnl_retval) {
> +		dev_err_ratelimited(params->ctlq->dev,
> +				    "Non-zero virtchnl ret val %u (msg op: %u, data_len: %u); xn id: %u, cookie: %u\n",
> +				    ctlq_msg->chnl_retval, ctlq_msg->chnl_opcode,
> +				    ctlq_msg->data_len, xn->index, xn->cookie);
> +	}

[Severity: Low]
Does this message always show values the device actually reported? When
ctlq_msg reaches libie_ctlq_xn_process_recv(), libie_ctlq_fill_rx_msg()
may already have overwritten chnl_retval and data_len:

drivers/net/ethernet/intel/libie/controlq.c:libie_ctlq_fill_rx_msg() {
    ...
	if (likely(msg->data_len)) {
		if (unlikely(msg->data_len > LIBIE_CTLQ_MAX_BUF_LEN)) {
			msg->data_len = LIBIE_CTLQ_MAX_BUF_LEN;
			msg->chnl_retval = U32_MAX;
		}
    ...
}

Suppose a reply's descriptor has a DATA_LEN field larger than
LIBIE_CTLQ_MAX_BUF_LEN. This would print "Non-zero virtchnl ret val
4294967295" with data_len equal to LIBIE_CTLQ_MAX_BUF_LEN.

By then the firmware's real virtchnl retval (possibly 0) and the real
DATA_LEN are lost. The log would then make the driver's own length check
look like a firmware error.

The new "Transaction failed" message in libie_ctlq_xn_send() prints
xn->recv_mem.iov_len, which is the same capped length.

Also, neither message includes ctlq_msg->hw_retval. That is the
mailbox-level status that libie_ctlq_fill_rx_msg() decodes from the
descriptor.

Could the oversized-length case be logged separately in
libie_ctlq_fill_rx_msg() with the raw DATA_LEN? Could hw_retval also be
added to the new messages?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929231305.1515873-1-anthony.l.nguyen%40intel.com
