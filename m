Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737D3C3F52;
	Thu, 24 Sep 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260180; cv=none; b=NN8kmaj9u6JJBNDaU5mpEb/L0kdFwLC11IQncrAq5IDu29nk+wTZO93Q1k3yc3UiyeVdWUhbNMQAKGrKauLRSTaSjc/Vk+d8sSQ5xXL6NRkfYRBQDUVnRLbi1d6J1MtgG95BXSxxmXinDlM01yoM5bF/beuY0vtXmB9/oQM2+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260180; c=relaxed/simple;
	bh=Alsg20ulwtmsCK0jhUo9W/eRC7ChTneIhhQfJMr9qwk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtNgd+hE/hl30khazzp9XEW37ROebARjxGF+NTp07mYEnlKIFkf6AbsC4HbHaInoNtDTNKjjAIHU46ZyVekdJRTnnVqhgmto53Vzu8ZNHVOgCjBTJn1DmIzpoyDZNRc7luegMTeLoDLfX3H64UCLTcNC8skE7gWJ/yfIIoJPOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqDw/h6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqDw/h6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17EC1F00898;
	Thu, 24 Sep 2026 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260171;
	bh=dtaH2juMcDUMlmsf+W76NMjGYSP66ee5OVypnL95UF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XqDw/h6hGz7+CVcou53M9G0uOLCwkoTBkVMNGBXHTG/wQ+EoSBgI34cEn9Bk1/q26
	 Zw1z9R7bQLHt3oaNSLMRHTsF8JMcR23fOKsBXXNtASY/OKsTbLLXZg5o0KKdbtwLk2
	 Wp2f9SP77e+s2dIEmOr6IwjtSFiheM5F4Dvtxz1tTgtymce7q5dZC80BpXBI+CIb1b
	 NbTMJ7ecEI4Gqz0U8KzH77ucCbvCUeqds7CSjA06jmFXwySeY7/M1k3DWfpdHQl10E
	 2uO6OtNIr+joZi9kskaumCT7fBjW5lz98VdTFcAJkoG42C2HhE42+kuEpRzNveW2Bv
	 b2wDG9vtCL5XQ==
Subject: Re: [PATCH net-next 6/9] ptp: ocp: report fw.cpld with an empty value
 until the USERCODE is read
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:30 +0000
Message-ID: <179026017024.2160803.16394646149517774385@kernel.org>
In-Reply-To: <20260922142829.57740-7-maimon.sagi@gmail.com>
References: <20260922142829.57740-7-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After any CPLD flash that reaches the erase step, the fw.cpld
  running version is never published again (and, at this commit, cpld.id…

--

ptp: ocp: report fw.cpld with an empty value until the USERCODE is read

Instead of publishing the literal string "unknown" for the fw.cpld running
version before the CPLD USERCODE has been read, the driver now passes an
empty value so the component name is still registered with devlink while no
version attribute is emitted.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index e10f6b5149c93..4ce86df6e1968 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2264,15 +2264,20 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>  		/* The flashable component.  Naming it here is what lets
>  		 * "devlink dev flash ... component fw.cpld" through, as the
>  		 * core matches the name against the versions reported here,
> -		 * so it is reported for every board that has the part and not
> +		 * so it is named for every board that has the part and not
>  		 * only once its USERCODE has been read: a part left holding a
>  		 * bad image answers neither, and gating the component on the
>  		 * read would make that state unrecoverable.
> +		 *
> +		 * An empty value still registers the name with the core -
> +		 * devlink_info_version_put() runs its version_cb before the
> +		 * empty-value early-out - while emitting no version attribute,
> +		 * so nothing is published until the USERCODE has been read.
>  		 */
>  		if (smp_load_acquire(&bp->cpld_usercode_ok))
>  			sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
>  		else
> -			strscpy(buf, "unknown", sizeof(buf));
> +			buf[0] = '\0';

[Severity: Medium]
The comment says "nothing is published until the USERCODE has been read".
After a flash, can the USERCODE ever be read again?

adva_x1_cpld_flash() invalidates the cached identity before erasing:

	WRITE_ONCE(bp->cpld_id, 0);
	WRITE_ONCE(bp->cpld_usercode_ok, false);
	WRITE_ONCE(bp->cpld_id_tried, false);
	bp->cpld_id_attempts = 0;

but the only thing that re-reads it is ptp_ocp_cpld_work(), and that worker
re-arms itself only while the one-shot has not settled:

	if (!READ_ONCE(bp->cpld_id_tried))
		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
				   HZ);

adva_x1_cpld_read_id() sets cpld_id_tried on success, so one second after
probe there is no pending cpld_work item left, and clearing the flag in the
flash path has nothing to wake.  The only other queue site for bp->cpld_work
is ptp_ocp_probe(), and no exit path of adva_x1_cpld_flash() queues it.

With no further read, smp_store_release(&bp->cpld_usercode_ok, true) in
adva_x1_cpld_read_id() never runs again, so ptp_ocp_devlink_info_get() takes
the new else branch forever, and devlink_info_version_put() drops it:

net/devlink/dev.c:devlink_info_version_put() {
	if (req->version_cb)
		req->version_cb(version_name, version_type,
				req->version_cb_priv);

	if (!req->msg || !*version_value)
		return 0;
	...
}

Does this mean fw.cpld is silently missing from every subsequent
"devlink dev info" after a successful flash, recoverable only by unbind and
rebind?  At this commit cpld.id is dropped the same way, since
adva_x1_cpld_flash() also clears bp->cpld_id.

For background: before the read was moved off the always-re-armed 1 Hz
ptp_ocp_sync_work(), clearing cpld_id_tried did cause a re-read on the next
tick; the commit that made the read a one-shot did not add a re-arm on the
flash path.  Checking the end of the series (5b9611f), adva_x1_cpld_flash()
still clears cpld_usercode_ok and cpld_id_tried and cpld_work is still
queued only from probe and from the worker itself, so the missing fw.cpld
version persists there; the cpld.id half is addressed by the later commit
"ptp: ocp: drop only the USERCODE when flashing, and drop it before erasing",
which stops clearing cpld_id.

Would queueing bp->cpld_work from the flash path close this?

>  		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
>  							   ver_type);
>  		if (err)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
