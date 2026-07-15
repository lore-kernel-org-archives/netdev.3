Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B044163C
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111298; cv=pass; b=rpkIrE3kljDO5dpqvKAFCp6T0sP1D1ks2WJujlL1NylOFN55TJV08DvQfQnzvie5YytSmcj/qugUt+Ei3zc01kyKaLzCRJJ36LR3pES4+1SzsKW86D0N2mx2fgNbxHMwIrdptGwcQiLXvPsnor8CdvYtcf97fv6Po1GFF0ChTig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111298; c=relaxed/simple;
	bh=sdz/WAGfFG2PTmUZ1wJMxa5wHauvvFsHiUboiywwFiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aB1MfhtcGut73jwdZjtJLdcdmpiQdi1Cfc9k45hG41aV7g/WY/Ae+Y9DqnjPIKugcmfoTiq0IA2vANojdypq/4NhfgCbSLM4ZYGbIFScj945DlZxv4Rs6Jcl++zBeZi6ZuThCEgdtxURx2k3iGkO+9r0XBvVtOowwUvrFsOTEU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bwo7DQec; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bwo7DQec"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b018fe8318so1645497e87.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 03:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784111295; cv=none;
        d=google.com; s=arc-20260327;
        b=gouSYXha0DfLqdhV4EKCbrU0SPUYE49MSQCLWizrR/RXjLd9WQJ36ywp5f66i+xB2x
         FyVg8KxEkDmH/lHkSMwt9U4iru3XFxEFy1F7+f3wprNUMPRinSJnujh7Iyeo0ZeQbutI
         U1OkY9jPxmsvf1elYFMmh3jBpeDv3NZvarrwZXB+VSOycz7jGAvKkMf/oncreIzag+84
         gng645aBgbKSUvbObm1D3YkiN1mNLF2wKNsryJVuP9gL5483LEErQ2vvPTaMY7V2bwc8
         LrDVqfKs31yuFs8CcfH5mQ6CJ1/N3hBOUMM8o+SGz+1Rzx4ixMr+xPi7BUf8CPaEPjcW
         hcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QPvnZmvDyFwzWB/pCYkhKpUQPg4ZobgLnpg06TR5Pn4=;
        fh=l9mLQurEZzaKnCzEcsD3+B3Wip9ZUYM8nAeltVLK/ew=;
        b=iswYecvnLB4iRHjqBbtUv63pY6UQSlSN21W4CqAPrNLM1d4e1b2LedoWHb3rl0hKkw
         6lNaUNPeNp5DZT1NC1DfbZ6+KITzdwZ2evWz8VBD1mZhq0t521TaBkDj3EfB21f08N6W
         6a1sCEfM/ukKVT5jzO5D6OV2A+oBuQ6AxtnTtPXduT8h4TlCnJQaVDG1ta49mLPv4m9E
         fRk0GqRVvqn+QkMLD9rHIIkYotpg8jHAcG/7NLlZx7ElewBCQK4Z1yXhKowpq3lhlJt6
         MU4IgslKyjiFIWv4ah55MWYwyQxfWcjZbSaofVXY82yNatU6DPeX6KPveeB95DI54e/z
         KEvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784111295; x=1784716095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPvnZmvDyFwzWB/pCYkhKpUQPg4ZobgLnpg06TR5Pn4=;
        b=Bwo7DQecg64hOObF+sx2++MDKhXaiv4agJ07HxwHn7su3lqodxrQvVMWXuX1OQoWM3
         N39fgEzc20gHI4YBcm9STY23S490oE6PONDUbU/f4rmyX7ZNSgxdQQrn/sDItDYsbet+
         RhvjeyD8IF1w+hYWSLLAV15lGgt7U6M5XLLSD7OeKQJbE+gsUReYgikcghGzIyuYKLfm
         yz21dxwRkzy3oqtCvNws0kx+syk2u3tkVGHBneS2I1Ofnqnjeikl4PWyWPCF4N3q6z8o
         E9Zq3lPUCCrLMrA7u5hBzwhHr4xE+kR2GZdW8o9ZFJyejxt8O5BdRSDCSi9iSWKi4ylJ
         2TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111295; x=1784716095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPvnZmvDyFwzWB/pCYkhKpUQPg4ZobgLnpg06TR5Pn4=;
        b=SJBSnQ+jUGTe3YbQkTFXR4sJGV5YtUrsG5/blHnqZWY0oHG4DYYcHI8m2Sz1MsFLT/
         YtMY3ZHFa+YUaG9UO+t6ZxgAiHolFzr0E90XydGGS/xOgikE6/CqRupfHYb6RyH7Jaew
         /V/oBpRMeTShJlA7DA2Oyojqa145Jyy9dk13RVfwaa8zBA9JepdD5r9gwcpN55jKlPiH
         C1Lu6aWa3wOUhsbvC1DyZzN9fEcRhJKg5CX3jLhPUJkkV8FqDTJCGwrQ/XmERE0DcSuV
         ovt/DVCBEsVTplDgRua09SLEmA2RnZBY0KuvrRAMjYD/QIVT95Kr4q7Har9xh6rERW+X
         0ALw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2zEJQLrUcDm0++Cyx+0r8qA0TzfCll+FPUIt9bDZoRx16czKHV0Hh8tDoMAU4n2H6zGxes+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznuIYfayTFUVLQhtks22Pvj6If0lhc7t78qEreunJrC0QdG7xl
	+DB6nhIJAsCG/yOwxzxrVM1R6f9t2fs6LQMqm0e1ujgpMxikC5pbOA5WrFVBrDuWQir81xj9j/u
	+V4bVsAj5r3LeJvdLsm72A98BMmfGlTUJ3kPxU+13HA==
X-Gm-Gg: AfdE7cnm9rm3vSjHr5AuS0cOJDVkitRkUwXX0mPT+zFu1u5Up7s6h47ZW7YA73GukDX
	haAnjXL87KHed/J0DnVwGQq92kCDHW99cEmDzjJ565uxydUbTgbrQkvQ7JbdXc6WejFRmCqSTI8
	X/964vAKnpTybJHQHvZEh+n1MCq41QfiA4JE+g3Jp4sncrleUGL0u6BPgSqbSaARqQgw6uUN1Fx
	zSPukoJUPU01vVGu5swXb8LU68kZSmI2mP6Y7Xi5GhCEE7/ND+LKK2S4rFYng78GJO7iVfP
X-Received: by 2002:a05:6512:66cd:20b0:5b0:1eed:f702 with SMTP id
 2adb3069b0e04-5b0236b7a0bmr2733808e87.54.1784111294764; Wed, 15 Jul 2026
 03:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706134033.244295-2-marco.crivellari@suse.com> <20260711164434.1691221-3-horms@kernel.org>
In-Reply-To: <20260711164434.1691221-3-horms@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 15 Jul 2026 12:28:02 +0200
X-Gm-Features: AUfX_mxDB8UQzuGBAa50_CUwUbLgAP9_s8ih_XJWsAHI5lvvyskjdwGSmzvPwq0
Message-ID: <CAAofZF4JQebhYv6FTHZuygnPge32CPJam=JHmVc+QVT75Jp5Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org, 
	jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de, 
	mhocko@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	enelsonmoore@gmail.com, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 11, 2026 at 6:46=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
>
> Simon says: While I think that the pre-existing issue flagged below is
>             orthogonal to this patch, I wonder if you could respond
>             to the question regarding scope raised in the first
>             issue flagged below.
>
> [...]
>
> [Severity: Medium]
> Will this leave the primary reset path bound to the per-cpu system_long_w=
q?
>
> While this patch partially migrates delayed reset works to system_dfl_lon=
g_wq,
> the initial reset work enqueued in ibmvnic_reset() is still bound to the
> per-CPU system_long_wq:

I will double check the code but converting that workqueue seems doable.


Thanks!
--

Marco Crivellari

SUSE Labs
