Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421F3EA66;
	Wed,  7 Oct 2026 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791346582; cv=none; b=OqRIMWwTodPEmL1/IDg10Rqip3I4w3R1mrw3+zr+ccdiTFqn2GXNepWhtZZtU/IldcqPpJe/0usvs1sV/87a8w/HwBJX9hSArJ0fYOclpaO8rJoQzwZQxHFwGL9NSZdpmDxZ1RjRrtTl5dwYVdYsMj6l2wR97bBdy9Pfra5JW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791346582; c=relaxed/simple;
	bh=/vyd/FQLF6/bsjJPkbsGohKU2hqKKx1TlXPt6tpTKgc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAg88ZITV/S3xLLPIPNsH4y8NJv8fTotulWW5Fz4NkYIVtY6ltstiy/DQDTrcq0ea9zw2NRO/HVbIdLAWpKAFKEHAMi2YlrTsezIsBeaD3Yr3HD1229pfaDi7Fl1l4lZ3T5XHFp2Rg5DBdUDfOYfoAuDt9HEk+036YYtn64XvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot9cGFfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot9cGFfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CF1F0089B;
	Wed,  7 Oct 2026 04:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791346580;
	bh=DK2RY7seVzGda+su9QWy1XsAt86ArzDgwrkeksorEhQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ot9cGFfN02SxuwdxRsXTp0fwvHp5ysnrL0exlrMZngMlBHW0zYR1kFhnnwnazLnCL
	 iNL1KtYdfbb6eeL+GmI2+tUaEoarLGPECFGR8NibMEP9Ql6d2u+XekVrTDptlAZux4
	 FxaFfpbFRbWHU0/eL/0LNC5ACOvpLe+83sM/dKQ+DDJ09S8QxfxjLdJl6K2QiDrnVG
	 xKHtDLuit4fLC+dINlbDToatEfErHRj6PememGXGL9usR7CFvqgugDskp2hZdRfI7l
	 4LRB/0f6bKSSgUH1MVOrMop0HyiR+DmcpGxOUDHA61IMa4DHSekx2JFc3Ao9OshjeK
	 qYkMIj9nBX/dw==
Subject:
 Re: [PATCH net] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
From: netdev-bot+sashiko@kernel.org
To: xinsheng.zhu.ny@gmail.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, oliver@neukum.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 07 Oct 2026 04:16:19 +0000
Message-ID: <179134657946.434549.14071341559835135672@kernel.org>
In-Reply-To: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com>
References: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In cdc_ncm_init() (drivers/net/usb/cdc_ncm.c:527-529), the new
  check `if (err != sizeof(ctx->ncm_parm)) { dev_err(...); return err;…
- [Low] The patch makes any GET_NTB_PARAMETERS response shorter than 28
  bytes fatal to bind (cdc_ncm_bind_common() -> error2 -> -ENODEV).
- [Low] The commit message describes a defect: cdc_ncm_init() only
  checked `err < 0`, so initialization continued with an incomplete…

--

net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses

This patch changes the GET_NTB_PARAMETERS check in cdc_ncm_init() from
err < 0 to an exact-length comparison against sizeof(ctx->ncm_parm). The
goal is to reject short responses instead of continuing initialization
with zero-filled NTB parameters.

> Require the return value to equal sizeof(ctx->ncm_parm), consistent with
> the existing exact-length check for GET_MAX_DATAGRAM_SIZE in
> cdc_ncm_set_dgram_size().
>
> Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>

[Severity: Low]
This isn't a bug, but this fixes the unchecked response length in
cdc_ncm_init(). Should it carry a Fixes: tag pointing at the commit that
added the err < 0 check, so stable backporters can follow it?

> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 35db38cb3e4a2..66f40f0d9c273 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -524,7 +524,7 @@ static int cdc_ncm_init(struct usbnet *dev)
>  			      |USB_RECIP_INTERFACE,
>  			      0, iface_no, &ctx->ncm_parm,
>  			      sizeof(ctx->ncm_parm));
> -	if (err < 0) {
> +	if (err != sizeof(ctx->ncm_parm)) {

[Severity: Low]
With this check, any response shorter than sizeof(ctx->ncm_parm) now makes
bind fail. There is no fallback, and the wLength the device reports is not
used.

Before this patch, short responses were accepted. The zero-filled fields
were then sanitized by cdc_ncm_fix_modulus(), by
cdc_ncm_check_rx_max()/cdc_ncm_check_tx_max(), and by the
tx_max_datagrams == 0 default.

The commit message calls this "consistent with the existing exact-length
check for GET_MAX_DATAGRAM_SIZE in cdc_ncm_set_dgram_size()". That check
is not fatal, though:

	if (err != sizeof(max_datagram_size)) {
		dev_dbg(&dev->intf->dev, "GET_MAX_DATAGRAM_SIZE failed\n");
		goto out;
	}

No device that sends a short response has been identified. That makes
this a compatibility question, not confirmed breakage. Is it intended that
these responses now cause a probe failure for cdc_ncm, cdc_mbim and
huawei_cdc_ncm, which all share this bind path?

>  		dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
>  		return err; /* GET_NTB_PARAMETERS is required */
                        ^^^

[Severity: High]
What happens when the device ends the GET_NTB_PARAMETERS data stage with
a zero-length packet? usbnet_read_cmd() then returns 0. Does this branch
log "failed GET_NTB_PARAMETERS" and still return 0, which the caller reads
as success?

__usbnet_read_cmd() passes the usb_control_msg() length through unchanged:

drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
    ...
	err = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
			      cmd, reqtype, value, index, buf, size,
			      USB_CTRL_GET_TIMEOUT);
	if (err > 0 && err <= size) {
    ...
	return err;
}

cdc_ncm_bind_common() only treats a non-zero return as a failure:

	if (cdc_ncm_init(dev))
		goto error2;

So bind would continue, but the rest of cdc_ncm_init() never runs.
SET_CRC_MODE and SET_NTB_FORMAT are never sent. ctx->is_ndp16,
ctx->tx_max_datagrams, ctx->max_ndp_size and ctx->timer_interval all keep
their zero values from the kzalloc.

With ctx->tx_max_datagrams == 0, this loop in cdc_ncm_fill_tx_frame()
never runs:

	for (n = ctx->tx_curr_frame_num; n < ctx->tx_max_datagrams; n++) {

Each incoming skb then goes to the "free up any dangling skb" block, gets
freed and is counted in tx_dropped.

On the RX side, is_ndp16 is 0, so cdc_ncm_rx_fixup() calls
cdc_ncm_rx_verify_nth32(). The device was never sent SET_NTB_FORMAT, so it
is still using its default NTB16 format.

With CDC_NCM_FLAG_NDP_TO_END set, kzalloc(ctx->max_ndp_size) with a size
of 0 returns ZERO_SIZE_PTR. That passes the NULL check in
cdc_ncm_bind_common(), so the problem is not caught there either.

Before this patch, a zero-length response went through the full
initialization with sanitized defaults. Isn't this a regression for the
zero-length case? Short reads of 1 to 27 bytes do fail bind, but only
because the positive byte count is non-zero.

Should this branch return a negative errno for short reads? For example:

	return err < 0 ? err : -EIO;

>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005041525.49111-1-xinsheng.zhu.ny%40gmail.com
