Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388236E492
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012142; cv=pass; b=o+oqYHbkB8f3/+r4M8s64sF7gYP8jF5OZ6MwRw4XCA+fxwR7GFynPiCo9tO1nHi4W0UUx0Mw3xdedp7Og1ElSqkWtvGNvdCHN978YvHJfxVIvQz1efq2p46FFp2brIev15sIgtmndTesi5F45k80iz68dpWRVBHWPx4Ty+TD/UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012142; c=relaxed/simple;
	bh=MHRMbhc1zWh9R3JfjZvIQaLDgMGBZjT0dVqmln39jVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJOeY4yFqbj0imhAGq4x3WhKdGN29qvkymn2j5KL89m+8CRqSfHAJVHnQi4xP7KY4f2fAdTC8L8hiKCn5G6bT3TihU27EtWDkPCOZxrT/HMNuohQYphWfmoi90o+xP1oyN5468a+vCiEFpjofzdyM5bTbFaTImSeNa0oDnNDnpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sosl4Z2F; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sosl4Z2F"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5029fb0b977so49379551cf.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:15:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012140; cv=none;
        d=google.com; s=arc-20240605;
        b=KpbpYxfB9iF8vDRY4ly/IZoCMho4gmBvWD/aRu5MJ6JUHkUSr5NBJBGHY30b+rJDM2
         JiUXRYaa1V0LJtaiUF2Rkh6FwyhG1q9l4c50DA1+Lu+gNLEpLLO23gFYf1pJt141p4kL
         jlx83wT/U+tN/OHj7AM+9NszzhAP5en9p69vIGxoSZ8STtuHTEdDjsYEtoCZpM0aq96u
         caTFPOiPT+q5E98rc1RBKEuaabBdNtIAmC/qD8/e7loD87sAmc2AaVJzn/sH1Gb+Vcz3
         U+gfi0fq6WNWUJlnFRIGzMkCyvqqoEvEH6VCTh/ZVcycvabRphcuxqODGCZ7p8CUPOp7
         +jIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nuHBRIXVGy/FeWJ5t4humP+oudRWf9bbxZQg3ni/nmo=;
        fh=IPAvFu7bmBd59IBE9ZPym+fJHZnrULi85wCGeenxvHI=;
        b=PkzxSo2AnpVBVdKI+KMcO5Q8LJB1qs34x1s264styo9H2zSlinb7BFZxVHfZxNn0QX
         oKM5UWkB4/T2RbcHPlOVXbzHdSW4gLCAj6m6jbSG+Be/fUzpqXMtZmo1TIxaNq76RrO8
         wHITCLWey1iqtQoJU5/tj6hku9NYOGPrPCo2WoHKmVYsBN6gTmGYep2TCetpmtaxbXE6
         stSSKYNYiGjSR1giAKdRVmxHEC3I+yycveqCyPVuL826UileiDKN1bn6j0zg7n+HFkjM
         DFDhmWDgmVeEWIIqlEpMWoVadUSJHXiZXxG1N9NTTE1CZ2gQYSlH+jRABCQv3JT08x+I
         BrJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012140; x=1769616940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuHBRIXVGy/FeWJ5t4humP+oudRWf9bbxZQg3ni/nmo=;
        b=sosl4Z2F3LEyKzp0gjbMWKM2G2x0lZWmBqoge1nqoJBqJzp90V0A4jU11TOH4HK7Qt
         pKcv1/zv8whaRT67YVOXd8NTKDHKza7jGXRMsAi8Tk0TcPV72zxk1cu1yP7UEShpZ31r
         /lhqiU99hASVWARGbfbHU1kBPE26o7JyzNjiMLXqmtHcnVy0A+6ZHHINtRVNRkh957lA
         IMLifqqis02c2tyBaycQrE1rlcjINX5qcCS+ohZiENuYszxYI9KKr2Z/NdO8JqnoIzIe
         5fOVdXZMlntD4AhDhvuX4NYxAqQ/dBaqMDGyZq8S+608DIYNHHZK37/5gUJVH222hV7d
         XGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012140; x=1769616940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuHBRIXVGy/FeWJ5t4humP+oudRWf9bbxZQg3ni/nmo=;
        b=PRV3xOr3qW+44u+RBeU5v5XqAGjzkiV1V9eu6tCvc9oKdhMDBrhqireKXnFXWpS0L2
         1PjrYGLfDLmkDZdD9i4DTWf8cAjne862Nsvo68GoJHfpJvNtiSIv0N+KhCamrk0Z+FlC
         JZOpeGAcXsA2XVIo6NQn30UhurazB742q2OB0sWFsi0/Yw2eCcV8GAQa/VFDplqk8OWL
         8i39SRfWy7NR7eUf9ovDIjcnOPhdNWYPKSGKAeMu5ZiU9xNCAqLeaM9Q+Mqf/S0hXqcI
         7d4W2r2ExOErCHwUKPnA3LlNhP2UOxkO04mcg9fnXP+jKfoDEXC7Dr8aOStAYSA55t9x
         5gzQ==
X-Gm-Message-State: AOJu0YyrpD6c0LnHUD5K7zW+CywVFUaTFS58lV90nl1xtaZ8Tvun2tDI
	WNEMKwVSrkLHKKG/DtTgm8Je/zmKhFDMWiUdBhs4jPN98l4KHCwQjfjCOM6XSQjb1PEXzAo0DNB
	5GLW8mc8EHyNGyglP9EBzgQZm8ZoLYQPaIualZbRi
X-Gm-Gg: AZuq6aJvEbXz/mUrn1rh+zwnxZ0IRHybfsZiDTFfXJAYQq2pwXBu5fW31pxZW4cvZFX
	w0ViAHqNLajuYTGqsauadNYUfn47WOIjlbIyibC3mcH2GA4uU7ZIiKNhXTOkufgsYyDjYWdNBOB
	Z4hGeyLbbr4xFQyHa2nWTR5dqpBilIyD08O20x9Klj90k+mUvPEkJvVgK+saVWYS876N0ivLOky
	gVrwFdR8L3zMzkRgALuTAMTpjNrcx/kS2rvWaYhmNxXztbB3sAQyINyd+keK7BsyZ+5HO0=
X-Received: by 2002:a05:622a:1829:b0:4f1:b93e:d4d8 with SMTP id
 d75a77b69052e-502a17b8a51mr246324131cf.71.1769012139253; Wed, 21 Jan 2026
 08:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769011015.git.pabeni@redhat.com> <5a7cdaeea40b0a29b88e525b6c942d73ed3b8ce7.1769011015.git.pabeni@redhat.com>
In-Reply-To: <5a7cdaeea40b0a29b88e525b6c942d73ed3b8ce7.1769011015.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 17:15:28 +0100
X-Gm-Features: AZwV_QiHSEetRkS6fExFUzojqaPq5QvkKh-GrSKh3dSV8n4wQT_9v6V5_76k9O8
Message-ID: <CANn89iKUDbV6U6d3hN3eZ91YkEC=vuGrOG63zTzLJ3Nfg5RVeA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 01/10] net: introduce mangleid_features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me, 
	petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 5:12=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Some/most devices implementing gso_partial need to disable the GSO partia=
l
> features when the IP ID can't be mangled; to that extend each of them
> implements something alike the following[1]:
>
>         if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
>                 features &=3D ~NETIF_F_TSO;
>
> in the ndo_features_check() op, which leads to a bit of duplicate code.
>
> Later patch in the series will implement GSO partial support for virtual
> devices, and the current status quo will require more duplicate code and
> a new indirect call in the TX path for them.
>
> Introduce the mangleid_features mask, allowing the core to disable NIC
> features based on/requiring MANGLEID, without any further intervention
> from the driver.
>
> The same functionality could be alternatively implemented adding a single
> boolean flag to the struct net_device, but would require an additional
> checks in ndo_features_check().
>
> Also note that [1] is incorrect if the NIC additionally implements
> NETIF_F_GSO_UDP_L4, mangleid_features transparently handle even such a
> case.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
