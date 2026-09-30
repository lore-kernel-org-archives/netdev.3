Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865135DA53;
	Wed, 30 Sep 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751444; cv=none; b=jhA9va3STvYIlUt00lD0jIqJYl7oUeLD5yLvLaCz/1wX7VBkYYgOLIXoe/Xqdv6DgQblmvD3iF+N/bEDfm8TrgCsLvbGgZMburAL7MOq52ymqFFenKN2aH+KK6vW6Hh1XNNqnBaypc0y329hT/y2DCz5dH5j9nN0WnTEtjrk0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751444; c=relaxed/simple;
	bh=5DjtQHnwEV0CIiB/q3HFjI5dn7fkGMSIfiTQ8C0m9jk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awpVASaOOdDTMswkQR7HqSxHdlapKU9G0Pw66491sp38wMIZDF30s05JGZR/kSF5vl/DM1npN1jMBsFdnRcc5uTag9e4SXDro4obdwGxOMGDGe/hqZ3d4+y/8C9667+mI2Q+F06EVGdKX413DwMXK4tb5Oo+6RYBqRYhrRh2n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7qHxssc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7qHxssc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0631F00893;
	Wed, 30 Sep 2026 06:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751433;
	bh=vpVM261qTPodnqvjTNFhL++hxSudMNkypS0mdn4IpzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I7qHxsscUFpsy15gvpxtyxT0kOwJC/3fCzRH4JsmCjwaVCtHzebJg28+PNPGbd+mV
	 w1L9g/8aX1Jce24ntO9/6jJ2UcrlKamkYYh5hx0YUqlIPXQZ47BjUjyEksT4bFrnir
	 C8AkTJmiMlIseN+//xTklFkxPOB4JdIOQZVgz6eq82swZe+WZ7uKQ01kdLumha0NXJ
	 P3r5LDRWMEhmWLKUjSyrfPUzNqCUZsAPnW81aysdnvSg8t7YBV2g37kcKOOatv3i9T
	 saabY4b7sjUef6ftwE+FtIYTdVeb9CxldDrzohqFsF09ljvJ5UNjIohWU9ypTVwPJX
	 vbX5E0D/4capQ==
Subject:
 Re: [PATCH net-next 2/6] dpll: zl3073x: add GPO support for output pins
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org, jiri@resnulli.us,
 min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 06:57:12 +0000
Message-ID: <179075143241.434549.4937444709313263420@kernel.org>
In-Reply-To: <20260928185552.1103515-3-ivecera@redhat.com>
References: <20260928185552.1103515-3-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Error-recovery path applies the output restart before the
  pending GPO change.
- [Low] The struct zl3073x_dev kernel-doc in drivers/dpll/zl3073x/core.h
  (line 65, '@out: array of outs' invariants') and the inline '/*…

--

dpll: zl3073x: add GPO support for output pins

This commit adds the GPO override mailbox fields and the direct gpo_out_x
registers for CMOS output pins, along with helpers to read and set the pin
function. It also adds the output_ctrl_x stop bits and stop/start helpers.
ctrl moves into the cfg struct_group, and zl3073x_out_state_set() now
writes it directly.

> diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
> index 410d15b96d0b..82564045890d 100644
> --- a/drivers/dpll/zl3073x/out.c
> +++ b/drivers/dpll/zl3073x/out.c

[ ... ]

> @@ -120,11 +135,17 @@ int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
>  	struct zl3073x_out *dout = &zldev->out[index];
>  	int rc;
>  
> -	/* Reject attempts to change invariant fields (set at fetch only) */
> -	if (WARN_ON(memcmp(&dout->inv, &out->inv, sizeof(out->inv))))
> -		return -EINVAL;
> +	/* ctrl is a direct register, independent of the output mailbox */
> +	if (dout->ctrl != out->ctrl) {
> +		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_CTRL(index),
> +				      out->ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dout->ctrl = out->ctrl;
> +	}

[Severity: Medium]

zl3073x_out_state_set() now always writes output_ctrl_x before any mailbox
field. It does not roll dout->ctrl back if the later zl3073x_mb_op() or a
mailbox field write fails.

Can this order apply a restart before a pending GPO change on an error
recovery path?

The follow-up patch "dpll: zl3073x: allow enabling/disabling output pins"
adds zl3073x_dev_output_pin_state_set(). It puts a stop before the GPO
change and a start after it. Its recovery path looks like this:

	rc = zl3073x_out_state_set(zldev, out_id, &out);

restart_output:
	zl3073x_out_start(&out);
	rc = zl3073x_out_state_set(zldev, out_id, &out) ? : rc;

The second zl3073x_out_state_set() call only changes gpo_en/gpo_config.
Suppose it fails in zl3073x_mb_op() or in one of the mailbox field writes.
Then dout->cfg keeps the old GPO values, while out still holds the new
ones.

The recovery call then carries two changes: the cleared STOP/STOP_HZ bits
and the uncommitted GPO change. Because ctrl is written first, would the
clock restart, with the GPO override then changed on a running output?

That looks like the toggle the stop/start pair is meant to avoid. The
driver's own comment says the GPO toggle is not glitch-free. For
enable=true, the override is released onto a clock that is already
running, at an arbitrary phase. For enable=false, the override is engaged
in the middle of a clock cycle.

Also, if the retried commit succeeds, the "? : rc" still returns the
earlier error. zl3073x_dpll_output_pin_state_on_dpll_set() would then
report a failure even though the pin state changed.

>  
> -	/* Skip HW write if configuration hasn't changed */
> +	/* Skip the mailbox commit if nothing else has changed */
>  	if (!memcmp(&dout->cfg, &out->cfg, sizeof(out->cfg)))
>  		return 0;

[ ... ]

> diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
> index 660889c57bff..66a8432c00df 100644
> --- a/drivers/dpll/zl3073x/out.h
> +++ b/drivers/dpll/zl3073x/out.h

[ ... ]

> @@ -29,8 +32,9 @@ struct zl3073x_out {
>  		u32	esync_n_width;
>  		s32	phase_comp;
>  		u8	mode;
> -	);
> -	struct_group(inv, /* Invariants */
> +		u8	gpo_en;
> +		u8	gpo_config_p;
> +		u8	gpo_config_n;
>  		u8	ctrl;
>  	);
>  };

[Severity: Low]

This isn't a bug, but with the inv group removed, struct zl3073x_out has
no invariant fields left. The struct zl3073x_dev comments in core.h still
describe out[] as invariants:

 * @out: array of outs' invariants
...
	/* Invariants */
	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
	struct zl3073x_out	out[ZL3073X_NUM_OUTS];

These comments are still unchanged at the end of the series. Should they
be updated along with this change?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928185552.1103515-1-ivecera%40redhat.com
