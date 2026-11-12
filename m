Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445582;
	b=BmkfgvhOyg7AG6+R9yLfYL0mO0Ey0rtBbXIe2YZaaNx09QKgjKjNPK+4+0H+tegDIiEm
	 Hi9RTnZvEactY8AXge1RbCMVu7fmK7/pWXYIbfUwT7/vnZrsqQFgwwftNwG9IJ4aL0HDL
	 +Kt5r2LMJg62r1nRfm3EUvqkR2lBZySuDAXSFxb/31UebCJLNBVq01t8kwbqDlF+mLy/B
	 Mhgbpeo+PuN8QQEZtdvch0Zxdy3EBXSpgmaO3+Mm14MTC+H90AgcaL5LQfms+O6B96KGQ
	 5cjFFVoj/YcRN5J8CAzRqgtakKWOjtzrnMibtbnC1l6epXQEYXWWmRuU4r2vD/csSpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iCMY9zzRpVOQiNVF7wIbVbtJSXaMkhe3lrzE3/4Rz2U=;
	b=HEnV1HPu+T/5M21Kr4ljJSgdX0JMyrj4XSo5lDbQmo1YzJz3RlpIPtMWSSptZBb7jgzm
	 p8aMohfP75fiSSr6eDju9yEhdhHhkaf+jSt3diDdbv6xeIqTbE12VRfDv2k1ODD66tRrC
	 s3+1DLlLWGGNDFMSgsnAfiSFZmhA9xNCnU1pIV4XdF2x/9TWmxIUlat7vRJSA5Fu5eZHL
	 CL/sarN8hJtbpJgvkXAXxAQ5L9JlbhV9ExA3fQvvhE0xaeaD/11BcLESwu9mG1VJz0IaC
	 a3dmN9+fS7zpFBwFDO6LCpL01932FhSDKfEmeZjDiRN7vuwQwGqn0uVh3ILlR7n+3EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cuklAEao;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38475606A326
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38475606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cuklAEao
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ccca948203aso1787771a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794445580; x=1795050380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iCMY9zzRpVOQiNVF7wIbVbtJSXaMkhe3lrzE3/4Rz2U=;
        b=cuklAEaoE6zQVXGV9gZrYyyqItQzkHyX4+pq6Om2py/IPAk90rm7VxGu5Niy6A/NAB
         /CTDV9uLtEi5ePJ8SHDdTKeOsAKFYuSFlOTJVID1BXTctrPANHf6Fsh/94ViibuZdt4f
         Q2uS27QxE15OXe1B2/UIVLPiH8FWH9HSBHg0lWTpyfxJc/g7mlpZgE8auqJVQ5K03uTQ
         Oec6ye85GtdZOpnEnqGhX+SpcuIigx9tgpLuBeoJyiHnXVCeX6t6W+0E81/rOOn6mkrN
         kDP4wV9wv+R5g1H09iidPza08AYoori8rgGZMt/P1JOfA4OD2urEbz84Z11ZPm+4xZvB
         hNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794445580; x=1795050380;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCMY9zzRpVOQiNVF7wIbVbtJSXaMkhe3lrzE3/4Rz2U=;
        b=pugDSM2IGYP/jd3ERi9lU5M7E/Q+5RTYizSY3EyMWWSRO1kl7vS1rjF2uyP9gSW5av
         BeJYpnWmcPnfPymR0HYkF24BkW9wp1dR2aMpaWgVxoWGHvOfXavS90BvS5+bRsUmnI4V
         4XQOkCEwcaKNFPFApz0TiGsk+7bg2/lhM0ozQEasQmdw03icqc1zSfnoTeOeAJ7UR6ah
         bUTFy931zh9JF4/B1fxA7Imhx4UPkGuRvHVAZRpyCvYGx4AE/SwCTuO5oShQwgbXcKRA
         6R/S82wYjrXnZr0aB766nE1rC8LQef7ykkJyglxyqezw94hJSGJboCYLl3w1pGnQvNcL
         b1xQ==
X-Gm-Message-State: APuU4Z9ONohY2IScJsTvwLGhi/40fzgPRx/UTliG4WMk+ixDg7usKJw/
	3sZOa20Wp5z3eYnxujJQ2TwJsEqf2I5uRNdJSmgpMWQB7C6pjbS9ehs3OttGFVH+5N8=
X-Gm-Gg: AYBFou3rj2ZV6OFeWnaGGLE5OsnEw/miK9TuaA5Cn2gmutsEURYQnFCVerlGKcY9R2a
	IxJ135tNuPhQGKnYQ0tzb1JLeeKlQbnq875KWAeUZ3ar03GD8HVYbXtKIxcyLcIyuSplM8T56sS
	DbLT9bbP4P9C3lwknCic6zfDGKS4HCZvM9pBe2Fr1pdOI5yMGPy1dx+zTdZ3ZdruNyFfIV3O361
	czAD29U7jcVXwjTIbhMLbQqQEgmv18k8+h2IrLigMNFwi1LVOvh3FhcjFEysWxBH2706v5BRhNC
	TkboA7nqoQ/zhd9z0kXcnmR6I5HKW9sJkQTKtRyLUs0lu7vrkL++kinhn+whqyqw0IwRTuJt583
	NMXUXUxNnbZzfr0honVoE9gl3PxbMGpczq03oalOgnfn60++u7+UCgYBob/EqqEaZbM7+L6z0TM
	qSkOYQXPtVHHbVyzBPMJUyx7Au07P02Z9NYXv0EfHPIKJHbnruDs0KRQ0qzpcDAkCZoeFJTBTK0
	gGuHqajOCZAWifYVlj+jRveWlEoKs6CV1iqd4PQ/Cj+9dB+E5/R7GhMb0EVBx0Z3kZO4dmwe+96
	7AbeoNYMsaM0moNcY3YpBPxp+T8dZgUB4vDZuV0UqZuZfaYX1LsvfB0mhMHC6mrKUFIBcEMbvET
	UJE9unmYsvU/UpbNjUxc=
X-Received: by 2002:a17:90b:4c49:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3b182eacc7emr3660192a91.28.1794445580376;
        Wed, 11 Nov 2026 17:06:20 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182dff97fsm2402471a91.3.2026.11.11.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 17:06:19 -0800 (PST)
Date: Wed, 11 Nov 2026 17:06:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Todd Freed <toddfreed@meta.com>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Zahka
 <daniel.zahka@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH iproute2-next 3/3] tc: flower: add matches psp_spi,
 psp_ver and psp_dev
Message-ID: <20261111170617.5fbde961@phoenix.local>
In-Reply-To: <20261112001512.3598626-4-toddfreed@meta.com>
References: <20261112001512.3598626-1-toddfreed@meta.com>
	<20261112001512.3598626-4-toddfreed@meta.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 16:15:12 -0800
Todd Freed <toddfreed@meta.com> wrote:

> Match on the PSP Rx state of a packet the device decrypted: the SPI it
> was decrypted with (psp_spi, with an optional mask), the PSP version
> (psp_ver), and the ID of the PSP device which decrypted it (psp_dev).
> 
> For example, to take the packets decrypted with one Rx SPI, from
> rx-spi-alloc, and remove their PSP state:
> 
>   tc filter add dev eth0 ingress protocol ipv6 flower
>       psp_spi 0x80000001 psp_ver 0 psp_dev 1
>       action psp decap
> 
> These keys only match decrypted packets, even with a zero mask, so
> "psp_spi 0/0" matches any decrypted PSP packet.
> 
> psp_spi and its mask are hexadecimal, like spi. tc-flower(8) documents
> the keys.
> 
> Signed-off-by: Todd Freed <toddfreed@meta.com>
> ---

AI review feedback on this


get_u8/get_u32 use base 0 for psp_ver and psp_dev, so "psp_ver 010" is
octal.  The man page documents plain numbers; base 10 would match.
Otherwise this one looks fine.
