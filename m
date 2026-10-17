Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCE38239C
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216433; cv=pass; b=AzgLR6TU2Isxyvw/xk3I1XZwAVRMrGcYCgQrl7qjvnbJx7bjYsrBdqTlQMY+RDOxLdIAPPOQwEC0S8cjZbgNR7UNr/9NUjP0H9G57YglimDrZPSzNJvx5NCQgDlwQYM6nQT1ApSnN/h3zDWAKy690Nz6MDc5AEClWx/xKmEtLKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216433; c=relaxed/simple;
	bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQTsYZESnJv8H/00+8rvA78munQoLztkO2evS86BYgUYEPUu1c4kKLXtXb/gTpn01IRtlJeWY+XTxOtBNZmG8DdjjMjTqZED/x7RV2jMs+VRZ4MA8OUhvCWnLOPYYC04NQqDQbTSnS+/lSaKJ1GDGamw3o9XXbGZRD6F6Emz6rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNNQwdeO; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNNQwdeO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2493c28bso53846885a.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792216431; cv=none;
        d=google.com; s=arc-20260327;
        b=bcoDq+MCv54VhvdXPCtJ1Z3CezgCj2oTU68lcV1BzOmKhoRCOUHjWk1FqyzZFo4nT6
         ohK+Mmmoo7y67Dq3p//H2TlVOolsgr7n16i/YDrWftQrOieqXzn4VeO/2yeZHLxxLHB3
         popmM5AA86Zcmetvq9Wi9iqqJgO6n25GiudAeKf3y97ndXxsMDrI2h3L6mOAcIBTy+u0
         6FsTleBJ6VJGKRJRD9j63oVS6ZeU7SqndphZMPkVfJt8zYFrwRD/V4WiwFIW2u4Tn+fz
         Quivb8xbyBFGa2Bhx9lBVO5XXD3EkeL5d+oGBQbYUVur9r8hP9yu/zY2k3lkM90ndmMT
         cIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
        fh=GyHbN2FbYqJ8neNRkfGW9Q83Zs1IllCIZPtZ22cSk0E=;
        b=XMUSXy8JZGW7h6cFvosSXrKqUrkIfDEDZFGp4BzlkONoBY+6un1wfnjMDtE/rMd2RK
         TPU/AJB0edtP0Xeh8/BJSRGVnFMMAEtN2TC1EUzOc1lLCHYlFw4VMF3fYliIXdN9vQr/
         Fz/54MpfoKfmax3x2v/JGicfdYssCgUsgRjO15mmWoOv7KgMh25auN+bTe4k46qwxpmt
         BqdXAyVl5bEGs2iLlcMwA4AJrHiP4HGfkqhePzFdlHWkiwfUi25Q8UytSi7JNI7plQIH
         vDqQKnNDAaWDDyxM/9lNyNpKiomn3oYo4E1hQEph80UfOfIrygEZgI6eAKd4Ih5eo/GS
         ykZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216431; x=1792821231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
        b=HNNQwdeOAPPOEx38KwQJTr/ZjC/OcmmHdf7vXEcZN6XBLwMgC7kVcRMb6nIKssHKcK
         gco+1zmfJQn35DtiOqisx4ni05Aw4ii+HALScjm/tPEAh2ExPwUTIjHf9KuWry2AITqu
         88qj+zGR40yUIMINvbCdOQZ1CIeQYfwy6LBqm8UwgGLuH1ksteh8C5iOFthnWL37Gcwj
         PMAt+fq9uvCJ8ERBuqcF90uwNem1RJCnJuNAulYc/Yoxe614y253EQzTtL+vrPs3PWLL
         YCKAU2kLVKBnkB7lx3ksopMIlJqgM6VQQ9+eb4Nb898a3PlLqbIyxIXB3vCI7/RR0UfP
         fELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216431; x=1792821231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
        b=mCB71Is/6N7P2VKIPS/I6J+uFLaL5Qq2P3Z2v5auEr+HDr+ytyLSJVo+BhGB1h80vE
         dVduHsYFRltBELMmbQywRPtgdNW7AguKtPdP+f1SUW/LxP1DaZZuh2/WtkOqHhhm//6D
         76OI2XKkEELQkRFe0bNl4mW7ZsvUzk5vMB5tQdivRI7V2k+UZSMNAr4UEi+WODmpmOh8
         GI+O0GojXnr/3OncuO77NWM74f4+CShFMkmZdJPvot3HoDjFhK46Ljvu8GwRXN2FNWAO
         LlYaT7krKXkUVawTP1Ewv8Fqt6PQ+x6bfweU2Nz0KY6Ews74Vk+pZzQV1gpy6/kCRVFt
         elmg==
X-Gm-Message-State: AFq9FYJVDDsk/1c2wtRrLH2v5bH4eZycM/1ieu07aAGfhDlDaJUCxRXb
	4yIZz+KQX2ogPVVB5pgmgGOywuVAMxrCgIt9Zp4rgf3oVekd/y4Fo9Vd+mO+DUf98W5OvWOGrHo
	3VdSBof3SeONSO5sAlKKle1wNgpUwLyk=
X-Gm-Gg: AYBFou1+o2pUE08QTMD+7KdHtu0dUdrwqPi293dUk47O3QRSr94uR6Hxr+p8j7ci7DN
	C8WNocXIowgauD4dyW3lTYt2yOfNG3ZYUWNpi0oW+g96lMRnhxL09s5in8X0WJBTqnQpL4ebIgZ
	SiqCttzk2KK1G/MVQdGENIJ81Y+++34s/Vi5NEIDRqjxpqX8F7/kU0ylmLAJnwr091wcaAxjAbS
	9SYMx1llFDyfMvluAwF372+zcGDbkcb8yG8NuADk9ZaOpZhx2ZjpwjbTtGNf2l96I+nKSkl6xi2
	F3MyoH4e04Zv3GCXwl+LMm7GESo6PALVAfxJ4hT1xVlEfJ5yYt4JkhXWkA1WGNRWTsm073Njm4S
	Ocnw7Zs1eidjpYkLTEl2tmV//lsySSCVuqvFaESMLQ1zh/yqq3cLyH5Mqld7OnL0rQdEEg2nLUN
	qd4VgtGeOmPNn4OC1NIoo3Jwf+EkNF9fIrAx4vKKmychv6vn3MIqDUqhEscJ4RSGGuz5agSm8kw
	b+ObX6lZRDjMYEGi68L9iWhzDrG7c1sxeLtc0Q=
X-Received: by 2002:a05:620a:172c:b0:93e:4c1b:a06d with SMTP id
 af79cd13be357-93f29ceeee8mr338896485a.20.1792216430650; Fri, 16 Oct 2026
 22:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
 <20261016195543-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261016195543-mutt-send-email-mst@kernel.org>
From: Megane Hebo <hebomegane@gmail.com>
Date: Sat, 17 Oct 2026 14:53:39 +0900
X-Gm-Features: AclHuK9NL3_LmZEX0uf5XgY1amfOyPlOtQf6woeYIGrlG47Kw2f7yV0Y8I__kFU
Message-ID: <CAJPVW+kRtMJVtgd2r_1mX_ih5EDruNfYgY5U2j7eXAsrHkJj2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: validate csum_start before
 installing partial state
To: mst@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	willemdebruijn.kernel@gmail.com, habte.yibelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Your objection to my previous patch was right: since the packet was
dropped, the reorder had no observable benefit. I dropped that
approach.

Reading your v2 series, I think the stronger invariant is simpler:
make packet semantics stable at ingress before later protocol
processing can observe two meanings. I wrote a small kselftest
follow-up for the three outcomes and will send it separately.

My broader side idea is just to make repeated reuse of an observed
attack capability progressively more expensive. One speculative
mechanism is a minimal ancestry "scar" that transformations cannot
silently erase. I assume that is too stateful and out of scope here,
so I am not proposing it for your series.

I have also shared that broader defensive idea with a few relevant
organizations because it may be useful beyond this bug; I do not claim
to know the final architecture.Your objection to my previous patch was
right: since the packet was dropped, the reorder had no observable
benefit. I dropped that approach.

Reading your v2 series, I think the stronger invariant is simpler:
make packet semantics stable at ingress before later protocol
processing can observe two meanings. I wrote a small kselftest
follow-up for the three outcomes and will send it separately.

My broader side idea is just to make repeated reuse of an observed
attack capability progressively more expensive. One speculative
mechanism is a minimal ancestry =E2=80=9Cscar=E2=80=9D that transformations=
 cannot
silently erase. I assume that is too stateful and out of scope here,
so I am not proposing it for your series.

I have also shared that broader defensive idea with a few relevant
organizations because it may be useful beyond this bug; I do not claim
to know the final architecture.
