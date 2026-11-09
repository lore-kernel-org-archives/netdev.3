Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222550;
	b=UlGF9RDbp1y8t0UXDhXaG0/2l4oFl7NlYbrUZC15LBDQ233mGkguhUka2j/6IRE2Y9fJ
	 gEZXZEPKjgMOHJMABS53TePcvrqEv8TBRS2sHF/2GLUZb7u2n0mb+0qmuC4oMWjkFsyvf
	 YEjigSIVbEUDnpz0TibLMS7tPoZdb+tUl1WI1tnc6EFYmkqPbXUUOyuYvGHEU9BrAceyz
	 hzjj6R8utgyVMAes+za6e8CS6+tKb2d+gkOq25c8xxsFyTfn/bAx4ia8/c4UUFRP/cpdz
	 YrVHKX8vPyU1XlhmkRLZZsByfpiyYqLi9ybe/gWiPI+MtdrIySRT/reErEmKtHCmLng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222550;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aOodfZE2ZLJT1tt72r9gxw/AwWXvUZO8hln4ZVGINpQ=;
	b=oT0VGJEMgO1aFCQLT6MLOiHyhF6UBm11OSy8vzU80uXx/Pe54d7L3henjQOvXQwmBiAN
	 VPaATArF1LTnNV7aTXzPeHUl91yoUS0eHuNS2xzpX4DI2p9ANS3yQUwXAvVX4aiCak5wO
	 4S11r+xYP+IbIeVlPcEIZHGjTPQXZnMDiqOYasYGydQyx5JFCbtx7KgvpiEUvuaEy8WXo
	 uIiIUr1w12wFjQDMOoPnjVG5XHt66uB0/8PihePUhE2k/m6c5pJ4f3G3nzOFQP+WMvyf1
	 UhomxrrtddeKWcTjQbu29latTY2DC1NWXl8GvOGFi/JA5jvucjxXQryYK9sLE4WmJjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVy7dpEW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C20606A322;
	Mon,  9 Nov 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVy7dpEW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314141F0089F;
	Mon,  9 Nov 2026 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794222549;
	bh=aOodfZE2ZLJT1tt72r9gxw/AwWXvUZO8hln4ZVGINpQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OVy7dpEWlg5/XbJsqYaWzhLgZhXYjImiWD+7BGtQkQS5rpiBB85a1/PQ0PkrxDf5M
	 wk43LO1COjb2xg+5HPNyr1QkIYNDrIb4eOs7I2Iwq4YwsQMLmMHgC7V6vgkRoLACGI
	 XWYQ6ahL7CJCsRdAHmQNfr7CCjxQUFxNEKcMeNskzB4OD34KI6XvgWgIHKmydbIRX8
	 ssM7IQSJdxcajwYHE98J+/58pjYvmhu5SCoPrTsqWhGYHjK4u5Z7GLERW7R5MDTvNp
	 6EMN6qtTxnTWW04+peDUxv9u1UnMfJDe6DSMt2dITZ31QBgxdt2FcSnef3ArvwiBVi
	 j3Og+kFrFeKxw==
Subject:
 Re: [PATCH] nfc: pn533: validate response length before parsing DEP ATR_RES
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 09 Nov 2026 11:09:08 +0000
Message-ID: <179422254869.994134.11688036324201956954@kernel.org>
In-Reply-To: <20261105105805.1450120-1-hj351016@gmail.com>
References: <20261105105805.1450120-1-hj351016@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new length check in pn533_poll_dep_complete() and
  pn533_in_dep_link_up_complete() (drivers/nfc/pn533/pn533.c) runs…
- [Medium] pn533_activate_target_nfcdep() in drivers/nfc/pn533/pn533.c
  parses the ATR_RES returned by PN533_CMD_IN_ATR in the same way as the…
- [Low] The commit message says 'pn533_rf_complete()-style handlers in
  this file already length-check resp->len before use (e.g. the…
- [Low] The patch says it fixes an out-of-bounds read whose bytes reach
  userspace through nfc_targets_found() (netlink), but it has no Fixes:…

--

nfc: pn533: validate response length before parsing DEP ATR_RES

This patch adds a resp->len < sizeof(*rsp) check to
pn533_poll_dep_complete() and pn533_in_dep_link_up_complete(). The check
runs before the InJumpForDEP response is parsed as a struct
pn533_cmd_jump_dep_response. The goal is to stop reads of the 17-byte
fixed header from going past the end of a short frame.

> A valid ATR_RES always carries the full 17-byte fixed header (the
> general bytes, if present, start at offset 17), so reject any response
> shorter than sizeof(*rsp) before parsing it. pn533_rf_complete()-style
> handlers in this file already length-check resp->len before use (e.g.
> the ATR_REQ_GB_OFFSET check in pn533_init_target_complete()).

[Severity: Low]
Is this description accurate? pn533_rf_complete() only checks
IS_ERR(resp), queues poll_work and frees the skb. It never reads
resp->data and has no resp->len check.

pn533_init_target_complete() does have a real check:

    if (resp->len < ATR_REQ_GB_OFFSET + 1)
        return -EINVAL;

Other completion handlers in this file read resp->data without any
length check. One example is pn533_start_poll_complete():

    nbtg = resp->data[0];
    tg = resp->data[1];
    tgdata = &resp->data[2];
    tgdata_len = resp->len - 2;

pn533_tm_get_data_complete() and pn533_data_exchange_complete() do the
same.

Could this sentence be reworded or dropped, so it doesn't suggest the rest
of the file already validates lengths?

> Found by code review; not reproduced.
>
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

[Severity: Low]
The commit message says stale buffer contents can reach userspace through
nfc_targets_found(). Should the patch carry Fixes: tags and Cc: stable?

git blame shows the unchecked parsing came from these commits:

  pn533_poll_dep_complete(): 673088fb42d0 ("NFC: pn533: Send ATR_REQ
  directly for active device detection")

  pn533_in_dep_link_up_complete(): 361f3cb7f9cf ("NFC: DEP link hook
  implementation for pn533"), with the current rsp cast from
  13003649b1eb

> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index f5a6a7c20d5af..63b6032692184 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -1310,6 +1310,11 @@ static int pn533_poll_dep_complete(struct pn533 *dev, void *arg,
>  
>  	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;
>  
> +	if (resp->len < sizeof(*rsp)) {
> +		rc = -EINVAL;
> +		goto error;
> +	}
> +
>  	rc = rsp->status & PN533_CMD_RET_MASK;
>  	if (rc != PN533_CMD_RET_SUCCESS) {
>  		/* Not target found, turn radio off */

[Severity: High]
Does this check also reject failure responses that worked before? The old
failure path read only rsp->status (resp->data[0]), so it handled a
failure frame of any length.

pn533_send_async_complete() strips the frame header and tail:

    skb_pull(resp, dev->ops->rx_header_len);
    skb_trim(resp, resp->len - dev->ops->rx_tail_len);

After that, a status-only InJumpForDEP error reply such as D5 57 <status>
has resp->len == 1. It now takes the goto error path and returns -EINVAL,
skipping the "Not target found" branch:

    queue_work(dev->wq, &dev->rf_work);

pn533_wq_rf()->pn533_rf_complete() is the only place that re-queues
poll_work after a DEP poll attempt. pn533_wq_cmd_complete() ignores the
callback's return value except for -EINPROGRESS. Doesn't the poll loop
then stop silently?

In that state poll_mod_count stays non-zero and nfc_dev->polling stays
true. No targets are reported, and a new NFC_CMD_START_POLL fails with
-EBUSY in nfc_start_poll() until userspace stops polling. The one
exception is when the current modulation is listen mode
(cur_mod->len == 0). In that case listen_timer eventually moves polling
to the next modulation.

Once pn533_start_poll_complete() has set poll_dep, this is the normal
"no peer in range" path, not an edge case.

pn533_in_dep_link_up_complete() below has the same ordering. A short
failure reply there now returns -EINVAL before reaching this:

    nfc_err(dev->dev,
        "Bringing DEP link up failed (error 0x%x)\n", rc);

so the chip's error code is no longer logged.

The commit message says "A valid ATR_RES always carries the full 17-byte
fixed header", but an error reply is not an ATR_RES. The message also
doesn't mention any change to the failure path.

Would it work to require resp->len >= 1 before reading status in both
handlers? The resp->len >= sizeof(*rsp) check could then apply only after
status is PN533_CMD_RET_SUCCESS.

> @@ -1928,6 +1933,11 @@ static int pn533_in_dep_link_up_complete(struct pn533 *dev, void *arg,
>  
>  	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;
>  
> +	if (resp->len < sizeof(*rsp)) {
> +		rc = -EINVAL;
> +		goto error;
> +	}
> +
>  	rc = rsp->status & PN533_CMD_RET_MASK;
>  	if (rc != PN533_CMD_RET_SUCCESS) {
>  		nfc_err(dev->dev,

[Severity: Medium]
Should pn533_activate_target_nfcdep() get the same fix? This patch leaves
it unchanged, but it parses the ATR_RES from PN533_CMD_IN_ATR in the same
way:

    rsp = (struct pn533_cmd_activate_response *)resp->data;
    rc = rsp->status & PN533_CMD_RET_MASK;
    ...
    /* ATR_RES general bytes are located at offset 16 */
    gt_len = resp->len - 16;

rsp->status is read with no resp->len check. With resp->len == 0, that
read hits the trimmed DCS byte. The u16 gt_len also wraps when
resp->len < 16.

nfc_set_remote_general_bytes() narrows the wrapped value to u8, and
nfc_llcp_set_remote_gb() then rejects it. So the gt[] over-read is
mitigated, as with the two patched handlers. The unguarded status read
and the wrap are still there.

The same approach would cover this handler: a resp->len >= 1 check
before reading status, then a sizeof(*rsp) check after the success test.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105105805.1450120-1-hj351016%40gmail.com
