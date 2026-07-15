Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1C400979
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138923; cv=pass; b=VgGHORvtuFn1TstJqZj7dXIuyLRbSF35NwEKKUu5GqqzGZoK/DO/TJM75QrDDMV43zHsgRrB98D8smrSfIpNxxPFHZnyULIhZirg2hhyPmmao5xDUIQSMQAgCx9AguIJmf3BKtGHVL89S3rOujHBLQIXI0Aza6qcqAKgNsbXZ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138923; c=relaxed/simple;
	bh=kms617EFclEvRrNPTRVheqPWG3JDFp4EMWFZVwNFooY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czaKmFK9rwjh69dJ4/bda2hCIDfQwnbBvVanzI1s7aK3ohXzFsKpeH3LjWrqVbbeHvkUHzK9G/7fMr5ARfRA9XX0FCanzM5W7gjDiQT8w2VKHIyJO4J/NWTfJEwjLJthmaePO3T98sm9LlZNQyPDjegMpvGnMpHWGxlojRzugbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktKNpeE8; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktKNpeE8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab97c86bdso11995ad.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784138918; cv=none;
        d=google.com; s=arc-20260327;
        b=BKkPBRvFSpUMztRrTEmr27qFKLAz6t6pqMD7QU2TYb1b4hV+3EhQSbMqGtKnMFHIbV
         I2kznx85/eeJIMW8WHj/csSlpvDgwzinXgYqbjiDdf3kvB2NdHxmYxn+NuOZKtTumCXq
         GGdKEgydcGGpf7kaM+aQICRTynOjqE34/twSPAm71tAKh9IX0WOm23iwfHwrIJfAYa8F
         XzLFys+J8YmbTKIYE9R/imryJT83fIcbn40VV38Q71SPjwOSThYJgsCuKDRZYq7AU9eh
         iAIwTpWrFcgFlI5H3CZOnA1qnqr860BG1H0MqctVkfmEDjHgYQQ+y6MSEyQ4HFjXMDYt
         MKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
        fh=XdiMdfBZ5SwXC9kO1KD9vfU1uyLfSSFRKCwzGBYh5oE=;
        b=oo2J37eJBheI7pbrPWrGIig+4Wxk2VL5iSRuO/oaA8QpsSSH3Sx7o9UvkdXNTePE+Z
         LlNst56cSZHVlrhlwqwLA4S6s+1mpT4ZWOuVKmVhRRzUuCSWqDI170HDOb1qNawsJDv1
         zq5vpdV/4feOmrVwmjgZY8teng93kYQ/XFScyVdmLKndD4/X+3bX5t+BzHlepeCnCSlu
         sPOwx7zrdWzRS8KTBNc+3gy+sAFKJn8abpM/kf6iVL45g7UeNFKO7ZwGnyA1d7Gbv0lV
         X5z4//eG9j7oC1kgQe1tRwuO8IF+47SMknRp0HYil+HBnsZiJII2oO6OxQD11oLNV5FO
         0Frg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784138918; x=1784743718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
        b=ktKNpeE8jasqBBAOWKVFo2Bb4wq9271I1lPQZDYPl+kvXu41b83w8S8mm/taInS43Z
         sE0TRpTLL7fbgTnP4Dd3jQQiSO5fo5eAU95FJB9SOUKFAW0ALZi7FzjaOvWgRyH6rATd
         N+m8d+mzvuq9TOhGoS1Vbct8E3bSEZEjx+fXEm58g547krXdBtBiktrdLtaUw6V4jvXv
         QeSeBTPYcXu9QHwb/h4UIHaxPHjA4Dz23NiJ/vO2ab1cnDzMid1tKDq+fi//N5SV0dKL
         KhIronNFgmtkLhSkKzhcyhBZGr3P3qNi93ydg/MBWsc4DodPDfzNP0HrxB3O7b9TS7CY
         i8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138918; x=1784743718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
        b=W6iiIMW66zGvejr8HRo9rOfziSyOk1OXqd5U3Wro0TlXpmYRN1ULph/Ik5S6ILiOe5
         9u46Fvx8mscTZYOLJnynk4/OXHSkPtY7ifBY3Ee7w4EhTA94wQPWE1jwc+j9iCOGjKCK
         CMczBWAM/d4opUW0vwNkT3Lc/OKtvKPfTkCVyBmKxW6QRYWwNigpgw+Q/6oG24R22vWb
         FxFPL7+GDqX2WKdytQS1cEPfTuZrCpPlkNlloravUWyX6yvX4Td1XZqxcSFMK7UGBKt5
         PaQLRWK2EFfHy5+Nls+X/yieuF8BBV1vYU800N/hdqqn31jC5P49Dy4rD2KcKTxJh+mt
         Rexg==
X-Forwarded-Encrypted: i=1; AHgh+Rok2SYj4O40b4bqlQBgos7/ckibtDkQK5p9CKO4Ul6UDbLGmoKvn/f6bg4KIpV5wQad5pgLxMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVg3Yi6rBL388/7S4yjZgMX7boNZpxVt8ywDVNGDLyLuazkhZ8
	DDzstX2/nuGyXqE9FyesuqywwJh8zCX88b/gzY9KAh2LOZ1zE7zuw8nKLuzSaVes+Ue/a8Cp6Z9
	6zr2txmcocuYCUnhXYHPu1CawmsfS5AdCo5gcL6ma
X-Gm-Gg: AfdE7cmQjrqsmIJK3icD+FAo/9XiIrOxWEj+LwvTUzGYMt4eHFFUhVQA4+yVBMay0Q5
	5peeP/UM8n+ap1jSLyiMtjeqEnn/ZoXXdmP8GWsLYvs8hhLW1J+una8e1KAto0fRJdVBwBbUu8f
	GD+YounRBmBFNKNzZd8A+ZfBXWQIJfkzTfkwHi4hjFI4UEuE3qjAaXk4CjaZuwGp98uBwLwdDic
	VdQryPPU6RlnUj+p5uVjNjkLsq9YW7D1Q+mxrpUs+xtSTnWrpXaub9DE4HQmOn6iWrGlzeZ9oIm
	dW68xVv/MhgIb47VXMmTJILsbfogF7cCmZbPEg==
X-Received: by 2002:a17:903:b8e:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2cf1a94694dmr10215ad.3.1784138917054; Wed, 15 Jul 2026 11:08:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715074342.49281-1-mhun512@gmail.com>
In-Reply-To: <20260715074342.49281-1-mhun512@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 15 Jul 2026 11:08:24 -0700
X-Gm-Features: AUfX_mzkA0hD7asNtCMsqlVotbVc-A8PQP0w85ziBMNVAOzmXkB_qMwVa23CiHg
Message-ID: <CAHS8izN635zULNXH1UOejjjG7ZygwPD7EuN1Z2LXAw5qUFAfaA@mail.gmail.com>
Subject: Re: [PATCH v2] idpf: disable PCIe PTM on probe failure and removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Milena Olech <milena.olech@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:44=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> =
wrote:
>
> idpf_probe() enables PCIe Precision Time Measurement with
> pci_enable_ptm(pdev, NULL), which programs the PTM control bits and sets
> pdev->ptm_enabled when the bus/controller supports it.
>
> If a later probe step fails, the error path releases the allocated
> workqueues and adapter memory without disabling PTM.  The remove path has
> the same imbalance when a successfully probed device is detached.  In
> both cases, the PCI core's software PTM state and the device's PTM contro=
l
> bits remain set with no bound driver.
>
> Add pci_disable_ptm() to the common probe unwind after the PTM enable and
> to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not enabled,
> so the non-fatal pci_enable_ptm() failure remains safe.
> pcim_enable_device() only arranges for pci_disable_device() and does not
> undo the PTM enable.
>
> Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina
