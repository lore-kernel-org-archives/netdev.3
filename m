Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081532;
	b=JiPBiETBm4YClVpEtepOq+PB5Tq+VZ28Vl+ILN8/3xYDbpodBE+hqetaTy9tAOlLbol4
	 t+v4PXCaYDkP6bQ2CGD0H5MDnPg6dY5a7VdiC6vbo1HHqJBWlgjyUmSnkkmTJXS1ylRN1
	 h6406yWh2fxbNrUp1rXxRCk2ELLJt1373JpEzqCoRwnuuidRSfRr7xrdUuoiawl/ORWq0
	 +4+Ix+Uy8YndVrXelGcBfHjmvOSGAHycskYKB9zeIDkLHTMc+S0ivBYHKjWNb6xti5Zgh
	 XFQ1vW6ibl3gEZUkliH2ipNS7fN4epMopoxLI5AHIQa8MMerzN70oYTmb8fmPaLgwPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081532;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q5Im6BFhU4c73HRwf/q+HpEYX20gYNbEp6RoZ7l899w=;
	b=ZqczrpJ5m2JJBk2HYJ81+lNRY5+cMx+b7k51uo4hsFDi2ps7zTQgIvD+QN4A5nME2/y9
	 drx+1H0T76Z2zeN8YHk6cXRfGK/skyAYhZG3b+WwhxbAhXs0Zj2t/hERnu2eIsjzA2evb
	 d0LYApNCu9MydXwwURwdKY7/efY3XtwxHUVQb1S730d1jMhkiBovMEL0UXlXxuDQI3gWn
	 gKJV0CVftNdT/Y2+7KdWenChrnvpFOQMTE4uvtUUaoYXoiLFEtM00YX1LP7ut9j+GYQ+t
	 95WnjRDoTCI417AfFFb9U1Rr2YZQC/lxFH6gXgJ/dfxhRDOT03b15nN+kdy9HdUa7NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjkjE9Fx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CF606A330;
	Sat,  7 Nov 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjkjE9Fx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E38A1F0089F;
	Sat,  7 Nov 2026 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081532;
	bh=Q5Im6BFhU4c73HRwf/q+HpEYX20gYNbEp6RoZ7l899w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BjkjE9FxEZaXr65Lx27gx1Y9P7mXfdVT/aaHWy0gf1h1/UXo+fSc3Z2ouwgf7r8Uh
	 Ft2Bkm2leC8POeBXzCDoiv3sZSUACbx4wTRcA4UWcFVQ/3aeqPAA+CVKLXQQsb4aH0
	 3VU7QZ0cLlKmuqugZsVZnJ8k1XlSFfBO8TikkFbBUGYjTZZwyKCJevp/MkPZNKobZ+
	 XmoUsCYjGq+hKuR6ZYKBHTliqhh7KmXSAYZzQF9Q+r0DI7NUkLgBe2bj9XjNFZCqg2
	 nZ6UtBy0ML3pIhKWHR9TE5DmAD9oPBb0aLm/fIwIIoHnuM8jilYVygttKysU37ZSkj
	 sGeiDkq6FinEQ==
Subject: Re: [PATCH net v5 2/4] bnxt_en: check HWRM response if completion
 never arrives
From: netdev-bot+sashiko@kernel.org
To: joe@dama.to
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 prashant@broadcom.com, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:58:51 +0000
Message-ID: <179408153103.994134.11897477531270570828@kernel.org>
In-Reply-To: <20261106191423.4194081-3-joe@dama.to>
References: <20261106191423.4194081-3-joe@dama.to>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new fallback for a missing completion is in the generic
  completion-ring wait branch of __hwrm_send()…
- [Medium] bnxt_hwrm_rx_ring_reset()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c:14467) sends…
- [Medium] In the new fallback for a missing completion in __hwrm_send(),
  dma_rmb() runs once, before the loads of seq_id, resp_len and the…
- [Low] The commit message says the valid byte need not be polled because
  'Several seconds are spent waiting for the completion, so a response…
- [Low] BNXT_HWRM_CTX_SILENT is documented in bnxt_hwrm.h as 'squelch
  firmware errors', and hwrm_err() turns messages into netdev_dbg when…

--

bnxt_en: check HWRM response if completion never arrives

This changes __hwrm_send() so that when a command sent over a completion
ring never has its completion consumed by NAPI, the DMA response is
checked before giving up. If resp_len is non-zero, the sequence id
matches and the valid byte is set, the command is treated as completed
and falls through to the normal error_code handling.

> Several seconds are spent waiting for the completion, so a response that
> was written at all is complete by the time the wait gives up. There is no
> need to poll for the valid byte here the way the polling path below has
> to, where the poll is for a non-zero length and the valid byte at the end
> of the message may still be on its way.

[Severity: Low]
Is the "several seconds" part accurate? __hwrm_req_init() sets the
default timeout like this:

    ctx->timeout = bp->hwrm_cmd_timeout ?: DFLT_HWRM_CMD_TIMEOUT;

DFLT_HWRM_CMD_TIMEOUT is defined as 500 in bnxt.h, and
bp->hwrm_cmd_timeout comes from the firmware's def_req_timeout. None of
the completion ring callers (ring free, ring reset, selftest irq) seem to
raise it.

The wait loop can also end with no timeout at all when
bnxt_free_hwrm_resources() cancels the token:

    WRITE_ONCE(token->state, BNXT_HWRM_CANCELLED);

That also enters the new != BNXT_HWRM_COMPLETE branch. And if firmware
finishes right at the timeout boundary, the response DMA may still be in
flight when it is checked.

A partly written response still reads valid_byte == 0 and takes the error
exit, so the code fails safe. Could the justification be reworded, though?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> index 5bfabdca7d0e2..4feba90f0bf68 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> @@ -582,11 +582,36 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
>  		}
>  
>  		if (READ_ONCE(token->state) != BNXT_HWRM_COMPLETE) {
> -			hwrm_err(bp, ctx, "Resp cmpl intr err msg: 0x%x\n",
> -				 req_type);
> -			goto exit;
> +			__le16 resp_seq_id;
> +			u8 valid_byte = 0;
> +
> +			/* The completion ring entry was not delivered for
> +			 * some reason. It might be possible that the command
> +			 * was carried out even without a completion being
> +			 * posted. Check the response before giving up and log
> +			 * the state.
> +			 */
> +			dma_rmb();
> +			resp_seq_id = READ_ONCE(ctx->resp->seq_id);
> +			len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
> +			if (len && resp_seq_id == ctx->req->seq_id)
> +				valid_byte = *((u8 *)ctx->resp + len - 1);

[Severity: Medium]
Is the dma_rmb() in the right place here? It runs once, before the
seq_id, resp_len and valid byte loads. Nothing orders the loads of the
rest of the response after the valid byte is seen.

Those later reads include ctx->resp->error_code in the netdev_warn()
below. They also include the common tail of __hwrm_send():

    *valid = 0;
    rc = le16_to_cpu(ctx->resp->error_code);

and any response fields that callers read after hwrm_req_send() returns.

Firmware writes the valid byte last. The usual consumer pattern is to
see the valid byte, then dma_rmb(), then read the payload. The address of
the valid byte load depends on len, but the error_code load depends on
nothing.

On weakly ordered CPUs such as arm64 or POWER, could the error_code load
complete before the valid byte load while firmware is still writing the
response at the timeout boundary? The response buffer starts zeroed, so a
stale error_code would read as 0 and a failed command would look like a
success.

For HWRM_RING_FREE, would that hide a failure from the error handling
added later in the series, which stops DMA only when ring free fails?

The polling path has the same gap after its valid loop. This patch adds
a new consumer that relies on the completeness argument in the commit
message.

> +
> +			if (!valid_byte) {
> +				hwrm_err(bp, ctx,
> +					 "Resp cmpl intr err msg: 0x%x len:%d seq:0x%x/0x%x\n",
> +					 req_type, len,
> +					 le16_to_cpu(resp_seq_id),
> +					 le16_to_cpu(ctx->req->seq_id));
> +				goto exit;
> +			}

[Severity: Medium]
This fallback is in the generic completion ring branch, so it covers
every request that sets cmpl_ring, not only HWRM_RING_FREE. Does it change
the result of the ethtool interrupt self test?

bnxt_hwrm_selftest_irq() sends HWRM_SELFTEST_IRQ with the completion ring
set:

    req->cmpl_ring = cpu_to_le16(cmpl_ring);
    return hwrm_req_send(bp, req);

The test catches a broken interrupt path only because hwrm_req_send()
fails when NAPI never consumes the HWRM_DONE.

Firmware still writes the DMA response for the command. If the interrupt
or completion never reaches NAPI, this path now falls through and returns
error_code, which is 0:

ethtool -t <dev> offline
  bnxt_self_test()
    bnxt_test_irq()
      bnxt_hwrm_selftest_irq()
        __hwrm_send()

bnxt_self_test() marks the test failed only here:

    if (rc || bnxt_test_irq(bp)) {
        buf[BNXT_IRQ_TEST_IDX] = 1;
        etest->flags |= ETH_TEST_FL_FAILED;
    }

Would Interrupt_test then pass on a device whose interrupt delivery is
broken, with only a netdev_warn in dmesg? The commit message mentions
only the ring free case.

[Severity: Medium]
bnxt_hwrm_rx_ring_reset() raises a similar question. It sends
HWRM_RING_RESET with cmpl_ring set to the RX ring's own completion ring,
using hwrm_req_send_silent().

Before this patch, a lost completion returned -EBUSY. bnxt_rx_ring_reset()
then fell back to bnxt_reset_task(), which also re-initializes NAPI and
IRQs:

    rc = bnxt_hwrm_rx_ring_reset(bp, i);
    if (rc) {
        ...
        bnxt_reset_task(bp, true);
        break;
    }
    bnxt_free_one_rx_ring_skbs(bp, rxr);
    ...
    rxr->bnapi->in_reset = false;

Now the same case can return 0 and take the in-place recovery path.

Commit 74608fc98d28 sent the response through the ring's own completion
ring for ordering: "The response will be the last entry in the ring and
we can free the ring after getting the response." When NAPI consumes
HWRM_DONE, that shows the earlier RX completions on the ring were
discarded while in_reset was set.

Without that, can unconsumed completions stay on the cp ring and be
processed by bnxt_rx_pkt() after in_reset is cleared and the buffers are
replaced?

If the completion was lost because the ring's interrupt or NAPI is stuck,
would the in-place path leave the ring broken, where the global reset
would have recovered it?

What happens once stale entries are processed depends on runtime state,
so this one is less certain.

> +			netdev_warn(bp->dev,
> +				    "Resp cmpl intr not delivered, msg: 0x%x completed anyway (len:%d valid:0x%x err:0x%x)\n",
> +				    req_type, len, valid_byte,
> +				    le16_to_cpu(ctx->resp->error_code));

[Severity: Low]
Should this respect BNXT_HWRM_CTX_SILENT? The flag is documented as
"squelch firmware errors". The failure side of this branch uses
hwrm_err(), which drops to netdev_dbg for silent contexts.

This netdev_warn() always prints the firmware error_code. The common tail
of __hwrm_send() suppresses the same error_code for silent callers:

    if (rc == HWRM_ERR_CODE_BUSY && !(ctx->flags & BNXT_HWRM_CTX_SILENT))
        netdev_warn(bp->dev, "FW returned busy, hwrm req_type 0x%x\n",
                    req_type);
    else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
        hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
                 req_type, le16_to_cpu(ctx->req->seq_id), rc);

bnxt_hwrm_rx_ring_reset() uses hwrm_req_send_silent() and goes through
this path. A lost completion there would now log a warning that includes
the firmware error code.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106191423.4194081-1-joe%40dama.to
