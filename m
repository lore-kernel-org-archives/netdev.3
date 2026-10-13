Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07403DD85E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884814; cv=none; b=UL9FlDzxxXwtUwwNqtk/t6Uh4aw/JG7jzgPcgB3fRzlM9X3daj//VK4BVjyETscrCtQkmJIbcY2at3Q3+Lc1WYbnL6toB08d1Xb1Vcy5lX0+7d7r7NLKz0zOB4eiKyhPrUVCzLMCSRsNdZPVxzBLvjlC1QR6/OsLac7BWUZ04ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884814; c=relaxed/simple;
	bh=Ry6whsfUsu53BZMgX8P0B7FbPjRMwxS3dEgGUZ2+s1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckHjf9yMH3HlEIyOZC7jDzvBnIsp27g8Aea/Vol8+14/iJnzEVpxyj9GcpLzUpjlaVpOfyJDQBA2ujrffIhUHwkwR+K+mLnkFYIUnUFZUnk/TYHtdKstk+Q4vW1Yi4Ly5FW6+SOKDtLwCDxdeP5ig7Dkbqr/uLo7uBLH1ZqGdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDzcsETM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDzcsETM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791884812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUkzT3aq37LJADFn6x+rptOFGT8F+q5O9gHeHYLf1Hk=;
	b=gDzcsETMX0k8ErLocD3YChDl7O4kSFrcH38F7oV/MxDS4y09I5w5ZIrqKAlENHaBh/RNdb
	K/8+PKA5FUJfCKWqI/1HCBXgryyI4KzXUezlHTltfF45oQ2rHZctQ+eqpZRMu8OVFKRRuq
	+E9cEsbs26p9eFOWJ8xTLw+nPR2NF08=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-TgrihILROuCm41BWTuCufQ-1; Tue,
 13 Oct 2026 09:46:47 +0000
X-MC-Unique: TgrihILROuCm41BWTuCufQ-1
X-Mimecast-MFC-AGG-ID: TgrihILROuCm41BWTuCufQ_1791884806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85BB6195422F;
	Tue, 13 Oct 2026 09:46:45 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 630D0180034F;
	Tue, 13 Oct 2026 09:46:42 +0000 (UTC)
Message-ID: <a68ee429-c63e-4948-bc98-d895ed8066da@redhat.com>
Date: Tue, 13 Oct 2026 11:46:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/12] dpll: sit9531x: implement output pin
 state on a DPLL
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-10-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-10-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> An output is driven by its PLL rather than selected by it, so its state
> says whether it carries a signal: connected while it drives, disconnected
> while it is muted.  Setting the state mutes or un-mutes it by forcing the
> pad to Hi-Z, the only per-output control the device offers that leaves the
> divider alone.
> 
> The force bit and the state bit are separate, and a pad follows the loaded
> configuration while the force bit is clear, so both are read to decide
> whether an output is muted and both are written to change it.  Which of
> the four register banks applies depends on the slot and on whether the pad
> is single-ended or differential.
> 
> A mute or un-mute is a per-output control, but each one that changes
> something runs the device-wide programming sequence of the previous
> patch, so a request for the state the output already has is answered
> from the registers without entering it.  A request that fails after some
> of its writes landed still announces the change, so a subscriber is not
> left with the old state; the pin handle is read once, so a teardown
> racing the request cannot hand the notification a cleared one.  A failed
> entry into the programming state is left the way a commit leaves it:
> loops re-locked and the settling time waited for.
> 
> This is also where output pins start being registered at all: until now
> the registration filter took inputs only, so the output operations the
> earlier patches added -- direction and frequency -- had nothing to
> dispatch on.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/core.c | 344 +++++++++++++++++++++++++++++------
>   drivers/dpll/sit9531x/core.h |   7 +
>   drivers/dpll/sit9531x/dpll.c | 130 +++++++++++++
>   3 files changed, 427 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index ea15830b0efa..19aeabd3cd4f 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -488,71 +488,50 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,
>                                          muted);
>   }
> 
> -/* Attempts to re-lock the output loops before reporting them open. */
> -#define SIT9531X_LOOP_LOCK_TRIES       3
> -
>   /*
> - * sit9531x_prg_abort - leave the programming state without committing
> + * sit9531x_output_state_refresh - read an output's mute state back
>    *
> - * Entering the state is two writes, and the second can fail with the debug
> - * block already unlocked and the part possibly already in PRG_CMD.  There
> - * is nothing to commit in that case, but the loops still have to be closed
> - * and the debug key put back, which is otherwise only done by
> - * sit9531x_prg_commit().
> + * Used when a mute could not be confirmed at the time it was written.  The
> + * driver does not poll output state, so without this the cached value would
> + * stand until something else happened to write it.
> + *
> + * Caller must hold sitdev->multiop_lock.
>    */
> -static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)
> +int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)
>   {
> -       u8 attempt;
> -       int rc = -EIO;
> +       bool muted;
> +       int rc;
> 
> -       for (attempt = 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {
> -               rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> -                                      SIT9531X_LOOP_LOCK);
> -               if (!rc)
> -                       break;
> -               usleep_range(1000, 2000);
> -       }
> +       lockdep_assert_held(&sitdev->multiop_lock);
> +
> +       rc = sit9531x_output_forced_hiz(sitdev, out_idx, &muted);
>          if (rc)
> -               dev_err(sitdev->dev,
> -                       "output loops left unlocked after a failed entry: %d\n",
> -                       rc);
> +               return rc;
> +
> +       sitdev->out[out_idx].enabled = !muted;
> +       sitdev->out[out_idx].state_stale = false;
> 
> -       sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> -                         SIT9531X_DEBUG_LOCK_VAL);
> +       return 0;
>   }
> 
> -/*
> - * Enter the output-system programming state: unlock the debug
> - * registers on Page 3 and issue the PRG_CMD state command.  Register
> - * writes that reconfigure the output system only take effect when
> - * they are made inside this state.
> - */
> -static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
> +static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,
> +                               unsigned int reg, u8 bit, bool set)
>   {
> +       u8 cur, new_val;
>          int rc;
> 
> -       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> -                              SIT9531X_DEBUG_UNLOCK_VAL);
> +       rc = sit9531x_read_u8(sitdev, reg, &cur);
>          if (rc)
>                  return rc;
> 
> -       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> -                              SIT9531X_PRG_CMD_STATE);
> -       if (rc) {
> -               /*
> -                * The debug block is unlocked at this point, and a transfer
> -                * that reported an error may still have reached the part --
> -                * which would leave the device in PRG_CMD with its output
> -                * loops open.  Callers skip the commit when the entry
> -                * fails, so close both here.
> -                */
> -               sit9531x_prg_abort(sitdev);
> -               return rc;
> -       }
> +       new_val = set ? (cur | BIT(bit)) : (cur & ~BIT(bit));
> 
> -       return 0;
> +       return sit9531x_write_u8(sitdev, reg, new_val);
>   }
> 
> +/* Attempts to re-lock the output loops before reporting them open. */
> +#define SIT9531X_LOOP_LOCK_TRIES       3
> +
>   /*
>    * Commit a programming sequence started by sit9531x_prg_enter():
>    * update the NVM shadow and re-lock the loops.  The sleep gives the
> @@ -622,6 +601,251 @@ static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
>          return 0;
>   }
> 
> +/*
> + * Enter the output-system programming state: unlock the debug
> + * registers on Page 3 and issue the PRG_CMD state command.  Register
> + * writes that reconfigure the output system only take effect when
> + * they are made inside this state.
> + */
> +static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
> +{
> +       int rc;
> +
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +                              SIT9531X_DEBUG_UNLOCK_VAL);
> +       if (rc)
> +               return rc;
> +
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +                              SIT9531X_PRG_CMD_STATE);
> +       if (rc) {
> +               /*
> +                * The debug block is unlocked at this point, and a transfer
> +                * that reported an error may still have reached the part --
> +                * which would leave the device in PRG_CMD with its output
> +                * loops open.  Callers skip the commit when the entry fails,
> +                * so leave the state here the way every completed sequence
> +                * does: nothing was changed, so the update commits what the
> +                * part already holds, the loops are re-locked, and the
> +                * settling time is waited out before the caller drops the
> +                * lock and the next request programs the part.  The entry
> +                * failure is the error to report.
> +                */
> +               sit9531x_prg_commit(sitdev);
> +               return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * sit9531x_output_hiz_write - mute or unmute an output
> + *
> + * Muting takes control of the pin (MASK=1) and forces it to Hi-Z
> + * (STATE=0) on every Hi-Z pair of the slot -- differential, CMOS OutP
> + * and CMOS OutN -- because the output must go quiet whichever way it is
> + * wired; unmuting releases the override on all of them and hands the pin
> + * back to the device.  The caller must already be in the programming
> + * state.
> + */
> +static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,
> +                                    bool mute)
> +{
> +       struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];
> +       u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];
> +       int i, rc, undo_rc;

Reverse X-mas here, please.

With both of them...

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

