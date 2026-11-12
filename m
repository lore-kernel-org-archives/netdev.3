Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508668;
	b=XYSMpYwWEBhRFYnq7Y5nt/4/Wpbb2Q1lfDFukIG3y94/wTL2JPcVPIKWF+Th2mQu8gNI
	 MMU29FwVLxvvmex2MUGv56Vn+CoHvYPRgWqwV+hpT2k7Hp1ABRm1QeBgoq5TllB0aCMeP
	 WXGgH45lZMm1TT40zC5Bd3Z03zTwwqD8GXJIOI6Jw364Gg/yK53wq5I5eaaMPTZNkftK5
	 XZAo8GBunjqbnUOU4pmb5UdV8g9Y2W+S2SRPKIdwwnRERQ+/sOJn6TAke14P7JmQhSRsC
	 b0GB+CLRUVJClFVgE0lhAChWLNLtbX/ZzyOZeNdpcEeeWgJsH92e+w41e3sUKlbRCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508668;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RsXs2i7+CtvLR6Av6bBCfCc6Wle/5dFWZ1B+tWLP9vo=;
	b=KFM8cv27wkwdPRC7W1u5FgU3U3zxd5z33uM8CME0ZH5nletw80NBtADekCyWmaD9AsDX
	 J/2qFq/S3d3eZbAFa7SK+59mN2lh2J78LIcJOkRiJUgCsubjbnSEcQtsMQkdX/q4Yp9oU
	 /IyCwVsespEgsQ3KefAOq+0psWy78Nt/hSH5sOo+zgW/qQr8cW/r/FXxH2pt5Tch69u7t
	 aEcxD6nFMTunBbpnQ5X7WL0XeO0L6cNHbRR1prwDSRy9CNzj3LBNvTAFtSvpmsn9WyxVM
	 sqxTbTUnDtxVx0FCrK/NQA48rZT5Vl8o9NaXL/K9WwkXGKgOgoN6gk6Jrg8i5Sj7i8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKxNGQRN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082C606A32D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKxNGQRN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440191F000C4;
	Thu, 12 Nov 2026 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508667;
	bh=RsXs2i7+CtvLR6Av6bBCfCc6Wle/5dFWZ1B+tWLP9vo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jKxNGQRNkeqaQIOutbdp2E9BXGD+7bxSyYwxhNRk7DCLImB1rMgjy8nfZQt4lus7U
	 pxOBAaOsE+1I4Nck+5ZA4xqzsmmASNPdpIS0Cwwcll0BKxqmXj/KiMElqhLeQL/AES
	 fii7f6oylrsv3QUitRBbdycFfKF7pK7FKRsZTVxpIC3a0xBPrV2njDnYeXu1eWGzAM
	 Ibvp9AYMD1+AaXUf0ZvPblJODoPa63UfXI6+pN9gq9/IJ5KHVmI43cddhsxkowBKBR
	 c4NJecm0bySNEYFVfqDuulwLfEUUsvsQUIArquX1ow+e2OnFVSDGAJt9pfzZhWsO8M
	 GLZ+fpSG4SSjA==
Subject: Re: [PATCH net 2/2] bnxt_en: Wait for the PF in bnxt_resume()
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 keegan.freyhof@broadcom.com
Date: Thu, 12 Nov 2026 18:37:46 +0000
Message-ID: <179450866678.2199510.18044059314286997868@kernel.org>
In-Reply-To: <20261110174943.2106347-3-michael.chan@broadcom.com>
References: <20261110174943.2106347-3-michael.chan@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch uses two things as the PF-ready barrier for a VF
  resuming in the same kernel: a successful HWRM_VER_GET poll, then…
- [Low] The failure that the commit message and the new comment in
  bnxt_resume() describe is not the failure shown in the logs.

--

bnxt_en: Wait for the PF in bnxt_resume()

This patch changes bnxt_resume() on a VF. Before taking rtnl_lock() and
netdev_lock(), the VF now polls firmware with bnxt_hwrm_poll() up to 10
times, so that a PF in the same kernel can finish initializing first.
The retry delay depends on the error code: 250 ms for -EAGAIN, 750 ms
for -ECOMM, and no delay for -EBUSY.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 9d232d8357587..03682d9182c6d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> +	if (BNXT_VF(bp)) {
> +		for (i = 0; i < BNXT_RESUME_MAX_RETRY; i++) {
> +			rc = bnxt_hwrm_poll(bp);
> +			if (rc != -EAGAIN && rc != -EBUSY && rc != -ECOMM)
> +				break;
> +
> +			/* Wait briefly for -EAGAIN (FW busy), a bit longer for
> +			 * -ECOMM (PF down) to allow the PF to fully initialize.
> +			 * For -EBUSY, the message typically has timed out, so
> +			 * try again immediately.
> +			 */
> +			if (i < BNXT_RESUME_MAX_RETRY - 1) {
> +				if (rc == -EAGAIN)
> +					msleep(250);
> +				else if (rc == -ECOMM)
> +					msleep(750);
> +			}
> +		}

[Severity: Low]
Do the commit message and this comment describe the failure that the logs
actually show?

The commit message says:

  the initial FW message may timeout if the PF has not been initialized.

But every quoted log line is:

  hwrm req_type 0x0 seq id 0xb0 error 0xa

That message comes from the firmware error response branch of
__hwrm_send(). It is printed only after firmware returned a valid response
with a non-zero error_code. A timeout would print "Error (timeout: ...)"
and return -EBUSY instead.

Error 0xa is HWRM_ERR_CODE_HOT_RESET_PROGRESS, and __hwrm_to_stderr() maps
it to -EAGAIN:

drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:__hwrm_to_stderr() {
    ...
	case HWRM_ERR_CODE_HOT_RESET_PROGRESS:
	case HWRM_ERR_CODE_BUSY:
		return -EAGAIN;
    ...
	case HWRM_ERR_CODE_PF_UNAVAILABLE:
		return -ECOMM;
    ...
}

The kernel-doc for hwrm_req_send() also describes -EAGAIN as "HWRM busy or
reset in progress".

The new comment labels -EAGAIN as only "FW busy" and gives it the shortest
backoff. The longer "allow the PF to fully initialize" wait goes to -ECOMM.
So the observed failure goes through the 250 ms -EAGAIN branch, with a
total budget of about 9 x 250 ms.

Could the commit message and the comment be updated so they name the
hot-reset-in-progress (-EAGAIN) case as the condition being fixed?

> +		if (rc) {
> +			netdev_err(dev,
> +				   "Firmware not responding during resume, rc = %d\n",
> +				   rc);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	rtnl_lock();
> +	netdev_lock(dev);
> +
>  	if (bnxt_hwrm_ver_get(bp)) {
>  		rc = -ENODEV;
>  		goto resume_exit;

[Severity: Medium]
Is rtnl_lock() enough to make the VF wait until the PF has finished
initializing?

On the PF side, the end of bnxt_resume() drops both locks before it
reconfigures SR-IOV:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_resume() {
    ...
resume_exit:
	netdev_unlock(bp->dev);
	rtnl_unlock();
	if (!rc) {
		bnxt_ulp_start(bp);
		bnxt_reenable_sriov(bp);
	}
	return rc;
}

bnxt_reenable_sriov() calls bnxt_cfg_hw_sriov(bp, &n, true) with neither
rtnl nor netdev_lock held. That path does this:

bnxt_cfg_hw_sriov()
    bnxt_hwrm_func_buf_rgtr()
    bnxt_func_cfg()
        bnxt_hwrm_func_vf_resc_cfg(..., reset=true)

It registers the VF request forwarding buffers and reserves per-VF
resources with HWRM_FUNC_VF_RESOURCE_CFG.

A VF that has passed the poll and is blocked in rtnl_lock() gets the lock
as soon as the PF drops it. It can then run bnxt_hwrm_ver_get(),
bnxt_hwrm_func_reset(), bnxt_hwrm_func_qcaps(),
bnxt_hwrm_func_drv_rgtr() and bnxt_open(). All of these can run before or
during the PF's bnxt_cfg_hw_sriov().

In that window, could the VF query its resource limits and reserve rings
before the PF has restored the VF min/max resources and forwarding buffers
after the hibernation reset? If so, bnxt_open() might fail ring reservation
or see stale limits, so the "PF not initialized" failure could still happen
in later commands.

Would it need explicit ordering to close this window? For example, the PF
could reconfigure SR-IOV before releasing the lock, or the VF could wait
for a PF-side SR-IOV ready condition.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110174943.2106347-1-michael.chan%40broadcom.com
