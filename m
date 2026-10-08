Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB414E534A;
	Thu,  8 Oct 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473504; cv=none; b=lSUP+nCZE7UAGJ7b7318UOiRbPrgjQYHNSnCOGC9WtKbN90sJ4vMMABmjf4FRmQi6G5c4xkHkewOBViS0rSJ+4E3DnK90hMgvjsaYjkJVfuVcKvG6b/7h/tM3zvQpLi7mxcRcaF/8DNmsqRfw43c0q2gmH3Iyhfv+cM5trD/L0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473504; c=relaxed/simple;
	bh=oKq3LCIVxlEANL5mRyYb815Z8ciFvkq79Mo9KztKqx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYO8LsFQUc57yy3oVL1OVmx+YQxuypZH1UuJxtNF6qcfEZDr8CPgvC9VLxaoOuguCYQcWDFJIfwTRDTgqwwDs2UgqEMImkZ0kxl5uVvjbbzeBSXAnemqvdJ6peS668ogVx5u54MU285CcwHpWwxAE/F0HHWHYwqiyKnZDjDH8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo/yIYzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo/yIYzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CB11F000FF;
	Thu,  8 Oct 2026 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473502;
	bh=dJ+dI6fVl0ppHHe5Erg5+7zCijhVgWIpo/k6OR0FjDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Oo/yIYzxTW+k/cVURWxWXc417qbyMxV3LEU9s6d8Z3OWG1FS9l1g4tdPLMF2/Kiw6
	 nYnYN16j5P1TWsVtZpjlOAHpw0zBTNBpEm+Pcl1wg5whKUHIqZu1Hc7FiyrDqSVpuw
	 /MzDYJaEJkNFDe3Gx4VSVnVQbhsZlsf2iMbCUFfUm7tztYj9q0jK4DgXIbb/d7qfBp
	 GTMOnLQrphst+qof2os1CUhS0TxryQ6Xh6eay2WZkzXP4VDAfa1jbKFe8pqeMmvWcJ
	 1HF2kuRUJ9thxcQSG89Hy915C4iJGr+H7Tag9zptm+njcFFDC/ZdjGApwk2kSbk0js
	 2J5qZpaUP3Vgw==
Subject: Re: [PATCH net v3 1/4] dpll: zl3073x: reject output frequencies with
 too small divisor
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 15:31:41 +0000
Message-ID: <179147350175.434549.6966003929996681994@kernel.org>
In-Reply-To: <20261006153116.347497-2-ivecera@redhat.com>
References: <20261006153116.347497-2-ivecera@redhat.com>
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

- [Low] In N-div output mode, the new probe-time check in
  zl3073x_pin_check_freq() (drivers/dpll/zl3073x/prop.c) only requires…

--

dpll: zl3073x: reject output frequencies with too small divisor

This patch tightens zl3073x_pin_check_freq() so output pin frequencies
from firmware must divide the synth frequency with a divisor of at
least 2. For the N-pin of an N-divided output the minimum is 4. It also
rejects a zero frequency so the division cannot be by zero.

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978e..a4bdc3878590f 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c

[ ... ]

> @@ -41,18 +42,32 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,

[ ... ]

>  		/* Check the frequency divides synth frequency */
> -		if (synth_freq % (u32)freq)
> +		div = div_u64_rem(synth_freq, freq, &rem);
> +		if (rem)
> +			goto err_inv_freq;
> +
> +		/* The output divisor has to be at least 2. For the N-pin of an
> +		 * N-divided output the effective divisor also includes the N
> +		 * divider (>= 2), so the minimum is 4.
> +		 */
> +		out = zl3073x_out_state_get(zldev, out_id);
> +		if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> +			min_div = 4;
> +		else
> +			min_div = 2;
> +		if (div < min_div)
>  			goto err_inv_freq;

[Severity: Low]
For N-divided outputs, the new check compares the effective divisor
only against the synth. It does not look at the shared output divider
(out->div). Does that let an N-pin frequency pass this filter even
though no valid N divider exists for it?

In this patch, zl3073x_dpll_output_pin_frequency_set() in
drivers/dpll/zl3073x/dpll.c computes the N divider with a truncating
division and only rejects a result of 0:

drivers/dpll/zl3073x/dpll.c:zl3073x_dpll_output_pin_frequency_set() {
    ...
	} else {
		...
		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
		if (!out.esync_n_period)
			return -EINVAL;
	}
    ...
}

Take a 1 GHz synth with P-pin divider 10:

  N-pin request of 100 MHz: div = 10 >= 4, so it passes here.
  esync_n_period then works out to 1, and that is committed to
  hardware.

  N-pin request of 40 MHz: div = 25 >= 4, so it also passes.
  esync_n_period is truncated from 2.5 to 2. The output runs at
  50 MHz, but the call reports success.

The P-pin branch has the same truncation and zero-only check:

		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
		if (!out.esync_n_period)
			return -EINVAL;

The later commit in this series, "dpll: zl3073x: reject inexact
frequencies for N-divided outputs", fixes this. It adds remainder
checks and esync_n_period >= 2 checks to both branches, and returns
-EINVAL with an extack message.

After that commit, one gap remains. Some frequencies have an effective
divisor that cannot be split into out_div >= 2 times n_div >= 2, such
as synth/5. They still appear in freq_supported, but setting them is
rejected. Since this check is necessary but not sufficient, should the
commit message or the comment say so?

>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006153116.347497-1-ivecera%40redhat.com
