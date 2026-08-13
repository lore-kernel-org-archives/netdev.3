Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7043F4AD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609163; cv=pass; b=qdH9Yx/kkoOpWIyaAsETSd7RMh0YkeYF7Ok4ol66FxUzpnr6mCoiqnj14w6HhMDqvnB/xWx6LAXCHkrG+aTFZfsB2nqF/ctv5X1WRBCcSWHzNSibQowONxddPQCfluevhXy+G3SGGlhKZlm9K6mGvyv2LTV9+dsifLnQcsxLAWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609163; c=relaxed/simple;
	bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+HibVZ5zdOaxSnDuQRaz2adc29nAwIAj7Vx9zkdfkt6EnqXEbsnNQMCJQixnNxbzb9Ykm0+jNYOM7QPsY0zTZjJrY0V1fLN4wsXUmuX7tzspzKwkgNNhGCWTIR4RH1NQxcLWHcBjannqrGeM4ZQlnijR0+jWaP2E/gVdwOcm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiKXJg03; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiKXJg03"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-392af6bda98so354689a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786609160; cv=none;
        d=google.com; s=arc-20260327;
        b=HDBOh7vaaZq2KcOVfPJuPqmcRwQycfXRheECqdb0rYQDBqJ4L3kIr5xffgam/C+G8f
         IA5PkMQRJkkYNG7LR9d70wBoQMo+tGO0r3w+rNwPmk8PqVCc+u4h8B9rmog85H279y1r
         cyvrxmnCMiFcKrQiSrgU2ofI7dFJCVz8A7N2+nm2ppT/EPK8a6ITn0V24JOz2j5oT9aW
         D5LNMKOLFkBFeYWHrj9Zr5WGh1GC99zMRTHsBNM8301Gi4eopuI7r+0JQS4Jhc6U5FG4
         Ga8k+zvy+XcfhfoGRYg/3TEc50zSMz7QiCl0OFs61JTyokIURtAZj6UCZfbP6aTBYsvW
         t2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        fh=/67wTBXLN34qN0Md/W27j4otZJorL4AmLQ4dmlMbp4g=;
        b=LxLvr9flpERfm4m68XVtLtUaOLJFhwjW4YjF4K2sW9ip3/Vu0zzejD0WCoIzenVxow
         d620pFd5qT4i9y/HBcN4G+Z2A7z3lqsHMfoMPXtPyVa1sNYX+dCZlxQTcRbzp9A1KUrR
         x7iDMWC7HVdKRIh/F1NJKficqIUPsUnlTqZROm7IAKQAHmii6QC5hXoyWbZZAc98brsH
         yIsOfytcxs3FX0SL1FGsA3nk6qvAtdDZZCH7uNvofHRQrUVnrrIG0FmnOMb0akYoitpJ
         jErTLwxhzZ7591lT75E5pK8cy/j44HjUguca3rm+se4gSGYwl3sf7HZEt+DVjfTppmDK
         7eEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786609160; x=1787213960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=jiKXJg03ISCWp4I5Y7ccPMu321Ea6AemOZfQWlLgVESV0Vh7f3GfggkE0tt+xWkPpi
         3ACJjmUZFwOHd4xdX45veGxbDPNmBHmWplhxbEmy/YKTVnkRGV5Zm9dXtlcLWuYbBACn
         M3WXqdZUW47hmbmp3YHhFoRMGh3/FL8SbUiZfcchHI4i43vXfNupNOt0MQTPWpD74ajA
         JptqLcLrvVjxvvALg1i53eNw8PTMq7AS0IgAzYWk1XBV0I7Hygmf7Me67r8NWsjqbyY8
         7GNl2JTiQ+PfCLX7//mzkJspyqK6oK7NOLXJfN5pSltReyQsGmRqKK9Er43gYXiqaEdn
         Bp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609160; x=1787213960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=CHeJldOdCB22SthRvBeXGZ6qm7dLOLuPAUJZizh3QgeLi6BLu0REv3u2SiCy6W21Of
         pyzV+Mqb3P/E5EHojfP8GGdTUCPYdF5Fi9peoQ2dlsjreaYWZAUyI3BdheOU+2Ew7z4b
         iQbl5jBp0rIBx2t+WdfZ2kUJIrOuBZgYZmsDcZ39aKU5an7Y+IWz7LHv2My2HqJMmxOo
         HBCv0TIy00FrKYkVThTJ1NX5iBKFfGk4hzLeIbxl7Cn/ndNIxdHlYz5UDL3RW1N2nuaz
         7MYbUk5VN6shR0ERL8FJ97SpXpTTEV6JeqnyTO5VKvivdeFAzZLeP4bjW9WhP+IMJMdY
         VHrg==
X-Forwarded-Encrypted: i=1; AHgh+RrRpsZqar61iG+7JZWVkjeu+fNyYtwWyz2tH7q30ffW3Uavd8VmP7sBViv3FMUmzlYwFAQV4SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyxvXRj5hDBQ3x+ft9pl7Hu9gWzzgwF8R8Ooleo7KqCpz15LC
	3TtuLuRZJgI3tQ2vM5BSorZRx5uNj7TpX+I8R9zZ95LamPWMk4qNpCuPyWA4ho3rVEF9F9kRBV+
	EDTIuIOesHDpDG6FIo36iG/4jIpSljZs=
X-Gm-Gg: AR+sD10cepGjTD907AtWzCVTzZupPGSbvm0hHl11Sf0q57K/JBmhQl8uIclt4TXr0v4
	AqZxaHx25T4RXxoH8oxJC4wY1zxDReYm1BihrqgZhLp8I8l5NoyblO/M/DxDQ0Gi6EyDuuLvRN3
	BopNGoy17uCbKtJUAd1Q14D9sd6NaRLtlnNnR4g2H4E7oYtXWtvvJ6H0/mf4YHbMVDotF9rIE8i
	QvJwGu3d7vrytXoAF/HC9Y2q5B9Velnp/I/89kOYvgO9tPv8EqEsmq9sgeTOV7qHoboDKSNifjb
	8tIn2EkjZtM4+rgerw6Bm8ymWlUVucgPiM2RCP+Eol4+nzKR1dsMS6u5/VR/5cCGqJ6nT8GaAfk
	HVSqtT6Q/JGzRUh90hxGRBaksSMIWx8uOx+LTzoVN0EwQ76lOn0KFRpB/L3fW8i/WF4aXJME=
X-Received: by 2002:a17:90b:5807:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3931e2aa828mr3336244a91.3.1786609159836; Thu, 13 Aug 2026
 01:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
In-Reply-To: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 10:19:07 +0200
X-Gm-Features: AUfX_mwh5p3w0RKVhg92eH8jsf5k7VluJKRFIvAAaH6tiIul7a7G8q8L9_4Mlig
Message-ID: <CANiq72mcFp-MODPkNGPcufxb0YhPDO_eN8J-ZFVzkd2-W6VK6A@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:15=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Thanks for applying the series and catching the stray Acked-by.
> It was a v5 series-tag, from before the MAINTAINERS patch existed,
> so no need to re-add it. I'll be more careful with tags in future
> submissions.

Thanks for confirming! :)

Cheers,
Miguel
