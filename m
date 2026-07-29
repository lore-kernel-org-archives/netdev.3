Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C0443AB5
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334053; cv=pass; b=X6q/a0nDhUkWp506DopM/FW2SCxC+X7kPrxKypBaAofp2vwmPZGfzXU3j7i5RSFHoLgmijGjzYWouB30bZq/zZpAWl+6Y1S+oTR8c0wBK/0PCxVPC6gOWoAojmcJdgjZMfOGJmSJZxJIbJ+JNYj786Iw6poLU0kVUIRVWgvJtzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334053; c=relaxed/simple;
	bh=z36fzPRQvwwrqCTsE2mjlEMcWDRiWdBBgDLIRsrVKCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXLv3/fqe2MJs4RqmGX2XwQA83gkAYtTqlMDZL+orJ5/BfFere4XoiFcxh2hfoiX9lAKJBUll1v0fPEsoFDKR9y2Uv0hlUP2J1xQktzmLXudIGRt5BSFqt7w+ExF3X7tnoDM5WNdO3ubDdlD4ZxZb/0WtzCLhJo7Va0hGuli3Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMSw2i/w; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMSw2i/w"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4961446bee6so32153b6e.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334050; cv=none;
        d=google.com; s=arc-20260327;
        b=LDoVcMvdCFq0d6le78TqYZPowOtb7DuvrMA0oa5jKIkjNHkvC8DZazEyGLQVm0xUBz
         ZeVw+wHZnzAKPoME+p7qn5NcrSjldq1WTNlfqCBF4ZPTfkiPXfBStN4SGM1gN/np0gHP
         LcmNujbkyJ7zo7BqGWuJIOtgSXjHysGY0b7flvjrQrg9nhuTnhKsn3g25pW1CDH4P/1f
         HJv8H3nvfIAEmwQA1J2OaSbnpDU/U9+y8YFDgKgdwELzhuWyzJOnBeukn+A5oFTyRvAc
         l2OqSdB3FNbXL7awf9VS/6s8nSwJKXo/Yg/Cx390TqDActcUCP8S4XthMu5bNvVeG0tM
         RLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z36fzPRQvwwrqCTsE2mjlEMcWDRiWdBBgDLIRsrVKCU=;
        fh=qzj8aHtFxGD8VymCwGEbpjuQ/8tdyavBTZV1P2d+0N0=;
        b=bGQusDzUJPI/Cm0GzO6kcgoc7YdQ9fNDz6u1kRDdhAEHFpC6fGoezgndomzxnrWiqI
         jbILMJ+ZqTQY5dYmWCwxX91vC1Ad+a0GU7dhEEwYoYZ5icSs4CIZ68CKx8c7QZozLd1g
         hOuof8wRRHyP67DgDe9syhPPB5MaMQl3jdiUyklMxyZVuKqWfXiDUHS7PEgoonH5UER+
         izwoIZ/IaqPvplmQQtwktdGWwZ0CEWIbjw9DDATglCDKQJEwbuAV3fHQxkMwwgt+jpz/
         DJB9qfIbePCeN/se/R4KqzAFsvFCIbjqBdNJViG3HCGnkOnUvbdUyPcQRRAslHylwmh0
         QBwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334050; x=1785938850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z36fzPRQvwwrqCTsE2mjlEMcWDRiWdBBgDLIRsrVKCU=;
        b=gMSw2i/w3PeIZPetzK8oUJoFgbnW/lPeD8ooZXG18ULy0v50obH/92ul0q9NNNn/m2
         PFZLjlUijifn3Ueg6v6lu03YViIfRADnXT12lKgFTeDHRvwC+LUk17kU02GTd9q47Tp5
         pL/9WrdDV5QauoFrmV/M7xgmPhyv/GidJg1RptJlzntW8nlisaAsjFMQ78vMH0NoaW2V
         izqpCHclYf4H4lL2oxhBudqjP1TONX7G0e15dasso8jp9NTComFnFBCPd+JGrVIenBLy
         yNlvaYhnuSkl8OrrLKOsHqNffM/SKGqDKEn66hFu9AvbieDjMJpq4EY76jQhhfEZZWkH
         QvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334050; x=1785938850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z36fzPRQvwwrqCTsE2mjlEMcWDRiWdBBgDLIRsrVKCU=;
        b=nFkYiAuXB1Mqb3rNddsBqL58Ug1A2v2148yZS/PWT9lHEeialGuJuhtm/Tfac5j5lK
         fz8BmgKK9KCWCzZTrN6Th/PWD1Nx/nrYwMehfvLi0p6gwGWbhfiCCUF8Pf/XebFkDwi7
         VyivZF/v4gHQ7gQ1s61OS2oxOcEmaG9tokMnMXI3GMvSX8yrMYr2/gskcLA+3BRTEWzg
         oWr+BZyy8s3joNKJx/RpBNH6UaZakUgKfv1XtN+0N+nI0imHMTe6cZTf8mdn6HUPHQa/
         rlxsJdYnow6vQrfqziYGeXLYuBiceMN21GTcNwvycxkgBTEFXVVAc4Vm7ToZ33I9D3je
         wGpg==
X-Forwarded-Encrypted: i=1; AHgh+RpL1VWgCCzaraY4ECRVg41TzU1O0URH863GVWf4ONqe1ILoQKs6EuMxrEK5QRV/Y7sNejQWvVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5bVsw1UpefuIHwLIVNY/54cFdvPpr0J7v4koyeqnEIwKQ5db
	lf288fWpyH97aYo5uIPW8SW7UEPzoQvMXBs+UKlPjZmsQDbRcN+bJjMkGcHRH1W/1Q/yuX/NTLR
	x7GyRGb9OuuA8nZxkvCmop6cCoJp4RYc=
X-Gm-Gg: AR+sD11cR/HN4zbSxB2L+9+MdhM+PJc3/2zbSRblOdzTykxuHn1MsUH3MpaDjlq6uwb
	VpXfeFfR2w2aXnAEICNHn79/QU2NFP3UZPeAiNc0k0CSaKoVBvNohp62rhrfu/ufInT9FpUv7hz
	L7YD1+EZ3Xyyi3JON6LpEEt0ltTuRhIScrGvW0HRNVbQrVeQHBSfqZARShJXLfwrGwUDALoV3r7
	x1GihfiISx4JQ6rVFG/XGg/AlgUsoqsMgY0fK2BqTCWfjvc95kRyrEcwDcayeIx7dkwAr0BXWlB
	4i+ny9/go76DoLpRFZCXfWQFCiel9Nwf2il7CvTqNrCgPVjs4rjc/NmSqea6
X-Received: by 2002:a05:6808:14d4:b0:485:7c46:b870 with SMTP id
 5614622812f47-4ad5b792004mr2883769b6e.2.1785334050482; Wed, 29 Jul 2026
 07:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-6-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-6-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Jul 2026 15:07:18 +0100
X-Gm-Features: AUfX_myU7vn5K_bLLyImRk4xfWmpcmMLlvJHLZRp9EFZ7WwmyHfizrLXJVKjFEY
Message-ID: <CAGSyskW0ehrBO06ohKzx7aqZw1_g_7JnyHc=dW1y+c4YgJ=oSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] netconsole: move netpoll_take_ipv6() as netcons_take_ipv6()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Move netpoll_take_ipv6() to netconsole, and add netcons_ prefix.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
