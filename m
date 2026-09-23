Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0B40BCD1
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147977; cv=pass; b=YW70FWRDwmZmCeE4SGKd/0FyvMDzF1p7aYuVywJyjUM2lm4xKjqHQOgks+meMowC3WhnVbliUmSkcYmMiKpWCdE/8r9mC95+E8DCfGJOy7pYtpgQdcEd65iC53QhgdkJ/xXWRAZxtH3vH5V29ITyDXclsqCO/+4H4VmcAN+F52Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147977; c=relaxed/simple;
	bh=ePal1IXH2Ui+jY7Cm11lrIQVvYsSFG8i9kUMaDDpZ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwWbp3RYtHG1yQuvdrPtQsiavtpdGd9foBHiGGMiWhZQH1wNCUg4eG7JVbcHcfPZ2nFC6/utxyy9SVwn/aBSHfuYI5CowtgQUIPrCKdlhHYZg31G/yKFWZDFhi2iH+7FC4xMzGVs5Y/wadSesSKqYM4ijl0miZsEz1CTT/k1anY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGcKeR7X; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGcKeR7X"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c72bd8a02fso305806eaf.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790147972; cv=none;
        d=google.com; s=arc-20260327;
        b=gPl9oZQoOhAE7/Y3lSut46hhoIn7GbmQf7G6o19bKAo4c5BJk2AjXGZ/S57YvyX3CV
         BuVFYSVAJ/Xr0rCaBxBngjJAid4fMQ2ptzFRRqjD3ZiWq+ILQmP8Oo4wYSRPoIgyLofT
         uNd0ZawitIk6Si3MKlynbtXQbP2bPZ+P9dbtp+e/iLG2Looh4nv24Q4c2ayBIinvaKbC
         +kyo6B9SgTuZ9W8XrXIQjiIt1WYOIM3DCVAIAXzPqD7NRt48Ojhlu8SyYPvRJXonbrPi
         dDgEtVyze8XhzCAx1CjMIVUlYl2WIRvmLLNFMSBFL1SiS/6p/avS6tRhtsPs/7UECWRe
         qxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        fh=LNTbDzKyhpmwUcrL/dh1hTYGV+3G/j3xgw4dy7OiAfo=;
        b=mJGG1u091P3Lh6ekDY/6CcuY7T4lXErZtcwz1DcooNE9+2iVXOAWtu9GCxULmQHRoE
         PRU0HX5mE1QDFgTE2/MriTdzUava4T+9Gd7oSF8y8oMZq6g1QpECBNPZBGaujAuxIt34
         3/tgjU4lq+BAJ1LJnxTe0kq1fXotV+nsdXJ0tJwriYMsMrYAPd5mCZV/3NTwAG5W8qt+
         QDdxejKyKEwZjl1mjGtQGpMdwmlCLUu7xhJ82JVo15hnd/nUs3gVkMukicY4QgNYKsqd
         Wp6rZhcSjTZ7gV6sA+Jw1gfgt9Oc/ePrwZAuSpNzrmIiHDBU1zs3GwdICdJsFsPnvHv/
         6iDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147972; x=1790752772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        b=HGcKeR7X5wdmFNVztLpTVHd0VQG0IEZVv+qfNFkjxhgN53f1CpOgqIe4EluFKOVCbE
         TngReEz350iIGk7MvZccDJolTyCk/3O+RkrWWbMLKFsIjBHKYz4ExpPNYoNiMDZi1n8e
         IFvMCT2j/1S9HwPSnyZEaA9nm9JiBLf/Fo2MvfDykq3twvqhNR9vfB/ZER+i2NH1ytuY
         kxABg4SRExV6Qb1N0tAjhw3ShhVeA85z9ssWY0LwdUlUPK1B/fWX906aT6pMKz0p7AQQ
         z2o/UBVu7mvGPXpw6fnIx23ekepWq1dWBViDzJiu0ev3gnRKd+LQIPQd9dRqM5FeK/Rf
         w/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147972; x=1790752772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        b=G0Gkncb7pv0jnNVIy32tPuq6DvjHv4XQXMp1w6WDpMLf8Ijw4wPRF5hZIN2q+eyzBG
         kzpTfX5T2suGzHM50JDivqj3h9Y8Hp8psmt3I+BeTJ/c7IKTrzBc5aikDkkV0XYybDK1
         VrOkwVHblqIFJE8491MI3iybtoPHKyMpkJTCwo7wqbMUe0/fYs54irh+aqDTJBNVmXQ4
         KQf2UTkCJQTOJy2Dq4pC5WogJdtk5wWrV5HaPCEKZDP1cHSrn3AoIORR4kcaGj9gNm/M
         w3hAvFVyDT2BwkEaktijKUKi4BBiG+R+hkMmPannIAKnk+6SHr7aGP1iLm/PeNBkZPCk
         v5ug==
X-Forwarded-Encrypted: i=1; AKwUvBwBKITv6CnYehBOUCMQA80WCRpHcDXV+Ethck9fSEM3yctbrkPi0yCyDGXPdjMlGEVlZpUACZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++luI9X1B2DA6D0Exm8ARSBco/xdrAE2+XTN9r9UZPMVHfwrSPGu
	Ei/iNxPuNw5KPHiAiZbzuFx4xac6kdme/3k+oYaKjv5EJa40LYOL9OPv/LRweKu5q5JYJgem53e
	y55M7zTRXJws8UeFRtWra8s6YVCvODowmmK0RAUYT8ADmsb/+26QnNsr8nuI=
X-Gm-Gg: AYBFou21MG9HqNdKn1+85dt4VfnY/Ylb8KkgsHb7KEavOX3iE+hZgld21VafeVc3Fr6
	PLgh6YY3R/sDuf8CVoMJvfrF/+llXvZKkn/j1lBlyrjd6+rkj/ePcwPvBqo7vLEP9SEn7cLsO/t
	DPNlqHnN5JiK2Tq1PSKIOnfXVB5LZEQHXSSm986Wx9nOdlUUjWKpWnHOpo4vHc0dQQ5P8qi4Rhz
	98AzQAoAwBnFue22+Ko7zlARtPFNIdD5EuFgDL9aOBhlz50GWk/S4doLHtkQ9Go/+zbzfpfdfdw
	AK/XhGBO8htH8KaAthAimPGZVGdH0Vwc8B/i2TGppqlNX9nWimAyOChIUBIr59P9q4fK2IlfvGB
	oCm76Ly8EfChnygwdSJgh1BSAJAU+llBFdK4rHWs/Ht2PPPws689izk8ocrOMeSvYS4vX
X-Received: by 2002:ac8:570b:0:b0:530:e01d:6001 with SMTP id
 d75a77b69052e-532eac6cbb3mr31883801cf.11.1790147569115; Wed, 23 Sep 2026
 00:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 09:12:38 +0200
X-Gm-Features: AcwNN1VwyXdqxc5s0wWZvupLP8rtkXVbaVkNw_j7qxnCeeIIfDCdM4_fvPpPjkA
Message-ID: <CANn89i+fsQdMeMcc6zk_Vp0WtckLQBTmrQ_fbb9rm44L8kSiTQ@mail.gmail.com>
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from
 hardirq readers
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:29=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> est_timer updates the estimator seqcount with preemption disabled, which
> does not exclude hardirq readers on non-PREEMPT_RT kernels.  A reader can
> observe an odd sequence and spin while the timer is interrupted.
>

There is no hardirq reader of gen_estimator_read() in the tree.

The only callers are:
 - gnet_stats_copy_rate_est() from tc dump paths (process context)
 - tcf_police_act() (BH)
 - xt_rateest_mt() (process or BH)

est_timer() itself runs from TIMER_SOFTIRQ (or ktimers/N on RT), and
softirqs do not nest on a CPU, so no reader can interrupt the writer.

> Disable interrupts around the seqcount write section.
>
> The failure mode was reproduced with an x86_64 kernel under QEMU. A
> test-only hardirq injection invokes gen_estimator_read() on the same CPU
> while est_timer() is updating the sequence counter.

Injecting a call that does not exist is not a reproducer; with that
methodology essentially every seqcount_t writer in the kernel would need
local_irq_save(). Note that such a hardirq caller would already deadlock
on e->stats_lock in est_fetch_counters() anyway.

Also, the preempt_disable_nested() here is deliberate (9f74c0ea9b26
"net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=3Dy").
local_irq_save() is not remapped on PREEMPT_RT, so this patch would add
a real IRQ-off section in a context RT intentionally keeps preemptible,
and would lose the lockdep assertion on !RT.

Finally, the Fixes: tag and Cc: stable are not warranted: nothing
regressed in 1c0d32fde5bd, and there is no user-visible bug.

pw-bot: rejected
