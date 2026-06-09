Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB992D7DC8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967088; cv=pass; b=hk+Gg1DO7Tl8VOI/XcV5TQAuJ1/S3+Qkxm0P4QYUxjaTkue/GE9LoJ8jG9zsHiqOaJplk/+WTXrqX2Z1ZfRjHOxGYfkLpcDUO6RgK3Gon+rpVPVF4USDWp2HxFOvnV2K1hkSZX+Rp58Lt6PQN6hjrnCc9u4SlFxLqLE9dQ6sO20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967088; c=relaxed/simple;
	bh=LGE5Q/Qz0eknt7YJc8IYO/h9FHLDOCwiMGx623TL+c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAy3joe6aVWzm9wB5GzQSV8aFCEvAf45ksbb5wT9p4mDlFZ7ZihUn4/wZWhWaHGorTsMJsA4TBZHYSgL0GcELkdPY09rdjG9sRB0Yv5YgCNO42g01r7KotsHtM+mFVrWRy7+FMLef27HFE68IUIP7DLx1M/WkSsnCbHuQhapIyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXa8LcZw; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXa8LcZw"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51775f2473aso37435351cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967086; cv=none;
        d=google.com; s=arc-20240605;
        b=is4JO2BQ981Ozwge0JJoFb2z8tdPRo913XiBxk22oRH1CTShtNqtfpeA58l9j4Nkot
         1zmRb7nGktXLmvB6B83tpCcXMzp/nGJTaOeLHVkhsm/ieARRNuntlAUoPD+JIgns1++m
         anAFwPg06BFebzXMsUEt58unJz/welNnyTIPXla9j1p7X9EjlkRJ1owVUtIECS0YaVUG
         DtA3y/Y+RIxI7CCcWm6Wnpl5w8ncU7cEMygRHmS9Gj+JJV9xSBA3rV2ruPoPe6QR6cN+
         7x9uMeMXHEivn/VWaBN4d+sNQUhd1YELHaulJvgd2ipODJharsO/E73GkbcLMEcHFTUH
         jeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sYrxOjEEzKKjlNIprOzPL6Ep/56IZ4mIvGWCZyF1soM=;
        fh=ZBKYgYBK72enFsyWg4DU4QzN3tl1Z/aocmfNiTbuD6c=;
        b=AfhOPkbhXEIQTlvE4Yv/S2+f1w0w9olKwGqfAEIE3+c47rBDfemunieMWVwSerKOZ/
         SedOTYONYhOiXuEREz74DMPBRe9pfkzPiyUxzCyeB5jbsObMkiiPxi81Wrb6dl25Uy+J
         31dBONYmg2KWDrDEcjcjIsLhjocbrpioO8QrvA3+gwWyOMdmdjTVJOoFk2fVpVtSNjOT
         /45nGpKF4GWOMkOO7liHpdlLJYCBaeI5GRWLXATWhMvStg6R3NsIvE+yiGYPLMvzLwut
         8YGPferx2Vi3EXyUKlJmZpDmxCFWw/eQMvG6I6p79wdFofAhYUVoSiigbXIfUgKCGugX
         YrHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967086; x=1781571886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYrxOjEEzKKjlNIprOzPL6Ep/56IZ4mIvGWCZyF1soM=;
        b=rXa8LcZwqU64lc96/65zRECmJ+6xBHD2vk6r9i2o1EL1TdLO5ycgRw3t+/LVbkId5S
         YIeMG3PcakbaL3Ensw6xGJWPeMwZb66C73Ncc6izkV81bRZpC6tUp1IuO/cudr6/fRsP
         dGtP54teGRdP/fn5BhRpgHTnKz9W7OE6gSAr5GUnTh7Ql0bHkrFlOH1uZ/pRw9+rFvIg
         9ep0NRMpUo/26mH3yQ3pZOO3tQbeDUIa0zbg6eaEXp8QNJqluv6MR90hI/HTAw1BS/0x
         bW3EhBlNxhk4N7VBfUO9bmoxyyaF0vUjGgzz3Vjuc/tm5leVWECT43/Ek4s2pUk4dfzA
         rLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967086; x=1781571886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYrxOjEEzKKjlNIprOzPL6Ep/56IZ4mIvGWCZyF1soM=;
        b=cuNrkvVn+VIlY2KRwPCpCS8g7If2LitTvmJTy9y+lPK4l/M0K2/+AdnqYluLqPzygK
         2LQ3hd+kmOqBHCzev22ZzUEggE5KlJXpJf4SZ0pW+UaFGgOPgMDOqAL5+K5TRRsN6f8t
         zlR/El9w3/QDKmE/ZVppujJchTmOFl++k4AX9J88fglSlMsM/0QYg4jbNH8VqNoPgMer
         9xQksUZtVGcwH6/mB89q0ZxhYy0XRtL222m59QaHgtX2y+ugY693+8pgb11mOYfLd5LG
         Gi/BXXRSv6Mn0izfzQxWcryCwbJKs8n5OsUaR3ed1w9OxqV90z4eT5CECf3KYCncJToC
         PKQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Q6n6xE9h10MEe2OHiTJLcKXeOYXYp6FBcEZWOXc32+yskGKeFwVwzYeTFlYQwWCaSjFGV7GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtxVrYWyHmk6Qd9WpD+mpoP9EXA5k9oijVA2+LqpAMtMHHsRE
	NxqPxHcc4dw5t3svnZ6zwb6fWgwwUiY10d5yVzMwXPtQTpYMzVVEQmvoyOmn0KdGkwOjnoVtVMM
	Yulp1r43JVV/5P/xGJW734JrWfP9vFjJOvUNbyFKS
X-Gm-Gg: Acq92OHNdZahJpGoQuKT8Hhk8N/9vcqspIa1OOwg4/Hj0rNLvefKd+e8RACmOqmn7/e
	rwC/I1lLDolbTQuRQhR0XmX10hIMztT/Bnv3p39TCOurl6xn63Iz00CBNuzXFtiodghQeBKbWzP
	7FXrNMXyAQXUU3FY8HT1FoIhH67Turb0SCBR+XzcJhtmoWp19le67qEpVomkM6V8F+sTLAqm7dj
	Mc7UeH/H3HujTuTlHfG1qGugbG1duFZSit7A09JMV5Gs6n5qOMETr9mo9tMnUq+PsEjqLkrfDwU
	3IMf6KFt/FaLwdc9y4oDLHPO9w/FaQlaV7KpO4fIAzYWAAMXmlI5zFhXGTheIyHu7vnlffE3tdC
	FNetVpCCEBeItTStPh+FPY9SLIdA0
X-Received: by 2002:ac8:41cc:0:b0:517:9648:f71f with SMTP id
 d75a77b69052e-5179648fc59mr189512921cf.45.1780967085175; Mon, 08 Jun 2026
 18:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003958.1238678.04aa5c10b22f.fq-pie-change-quantum-stale-deficit@trailofbits.com>
In-Reply-To: <20260609003958.1238678.04aa5c10b22f.fq-pie-change-quantum-stale-deficit@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:04:34 -0700
X-Gm-Features: AVVi8CdtgSHpGL7r93-9Ha8wVWwdR0fIk9S-06LtiqPbRJJFP2fOsstt5jdzm44
Message-ID: <CANn89iKUN_eqcNGdNB1waaxJ8RqmQpp1zouyDQgFu_SFz_OdHg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fq_pie: clamp flow deficit after quantum changes
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:40=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> fq_pie keeps active flow deficits when userspace changes the scheduler
> quantum.  The next dequeue rounds can therefore spend credit that was
> accumulated under the previous quantum.
>
> This can be observed by making a flow active, changing the quantum, and
> then dequeuing with the old deficit still present.
>
> Clamp active flow deficits to the new quantum when the configured
> quantum changes.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

NACK.
