Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F64D37B6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166797; cv=pass; b=rbafC7j17uBZC/rrJH1T6iptCJeOYG9hcFb6W45KjcNj9DRDQflrNvezuzihYWrKLXpWIp2KLTglIsjX1LfBFt1RMozcOAeHTqY/LgKFHAwjo7YNY+PX9+Y1CVKH53iHXg4ybT991MvZv9NPwtJG3wjLKr12iqlu+n3LcwdZ+zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166797; c=relaxed/simple;
	bh=mH5kL7A+dwz7Th0/axEXPDRla48Msc+IsIMQqB5yWQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCpKH34wnEjuNxTtSpoBbVasrtzH6drTyvKdhgvvVHDcqp/VufdZNy1aQDFdyGck29fopMsGt2+FPCa/Cru8tc8W1+xICiBXNE5IYgC2mRPLm9DP9MX4ZaaBzV2UPpYuFlmU3EwhDB8kc6X8Bz+rcyY1MIxy5qfOurfwWo3KVmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O68LlMeZ; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O68LlMeZ"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530301ff353so12349911cf.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790166787; cv=none;
        d=google.com; s=arc-20260327;
        b=pKPQa8Az8pj5Kl4ccY1PZ6p5G0UeS0BqqeavDX/vxqJG8CNaQUtDQacBc6XsaifBLN
         k5w5mG+MbtTI7I4gZ2Qh+WT3HOnsNO7mgO+wRchkMvtuhuW29odN2UhcExE+Soqo3mWv
         bMO45tllUMilNuiklyB7Ew8kzu5e96TT6bPMmnjXnKewbblbsvJx1Bt/ZUwktolq6lwF
         R3T0yd8WDZXPNkCzKH2eM4tzjWa+7lt1LxCs+PhQ/YDKn4Z4mNMyT3278y+25V37LaXt
         EYMqlhctYhO14dbhqOtNBgedgMoI0Q/1JfXSTDtQatxD8wr+4SRdwfPYhvqj6ye35RmQ
         mgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=utaHROpEPtGFOORmuN/Q/t8vZBvSe2pvgc6a4w+MOAY=;
        fh=upBlXsLeOzGktURyNCu01lS2a+tdf8M7dGU1qhLYZnA=;
        b=c0P6z320C7rTAh8H8nG/O5ojFqsCbGez7Ynu5+u46zdwcXcYvhME7nqwGzONGXmAEl
         3k3R2BTZEAqzNJwmEpyImirX6G1DAeleM2UnSMEFpL5qpFn9UcWI9ykku873ZjhvAGZs
         N6toYkXQnXdjeoUSXGFdgAP9viNBDTpT+ktUlwgenSafSisp9RRqC3kfBB6MC++NSt4j
         ikpzLSwvdbXATBPlrIN6uoBvl5zANFGkkuV1d2qswa/zcsajlF9ahZgLHi0BRpytodBE
         mcSbmfHbT+wwIiFnTsrYDfeQEA59Lu+RhOPeRiANEEqcgEQNdtMhN9rNtmaGvtU+IIwG
         WPyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790166787; x=1790771587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utaHROpEPtGFOORmuN/Q/t8vZBvSe2pvgc6a4w+MOAY=;
        b=O68LlMeZBo5w/PcWSFf4a0r5N9x0F21yVVUQzSHoE7TkDoCQrAtXXfNOxdExpi0lWY
         BzqzVL2JY6ynZOx6r+ZRjpODHJFdFy1ot64nqVK+8uRjrYKiWXGc7++cMfNe36N8UB80
         4O/1grKp4aGYDEfyxzG7wYgrBL55j9UGJQWojX5rbwBFPIMao7mnvG03SZfrKMrzK1j3
         zQdruQ9yuJ9EwIbcKffcLpsF14KkmcuFauj/r1qNSYXgoNRSVSOLH+vlxa/4LOBSsKUQ
         JZ283ZAzIcYleAJX665fd591ZNAI6Jlna4UcT0nvrsyujKPjYjYeY0/tuzlSjO0D5xRK
         t/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166787; x=1790771587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utaHROpEPtGFOORmuN/Q/t8vZBvSe2pvgc6a4w+MOAY=;
        b=rRyHJAOTg/Z1DLcePmu5G3M+Zu6dv3rgH6S/gc074KJarscr1xiDJcvqbsmSIiExvp
         fMgnGEBur7j8w3gxRfDpOWkZCgI72RchQ5Yp/B3ISb2LP5pI2WdzjWRGibbuI1i0YEn5
         tYcmK5QZ7llm61TcBd1kNTjYqvZ5EAZivaJGamarq3dz9qN8uI8SF+cAxvQSNyF9b3CE
         /djfDFLNXo01z0HsEnIhGtpduXHR//8LllAjjY7szmGEKFBcDiyySfBjt4Am7mp0h9U0
         vrRfs2/QLmEaMsv9KorF9oGlzbOrxzHOmYBEJGuBhEKdqFtBVOo3XRMY0cke4BYk5vAP
         jB/w==
X-Forwarded-Encrypted: i=1; AKwUvBwDfjRrMP31/u4L08YGSYVWyMLyfdZGRWA09Cf9fZA/vN26JNrXBFuYDwOflH8KWhZJ5G5Ytk4=@vger.kernel.org
X-Gm-Message-State: AFuF++nXi29wDWVpfm5NOGmhoQ6Z14gQXRFZwlQKnOKMMuJ6+0KkknVK
	NBRgUXHGJ1QLu8sITf1W0EsL6G40FHEWOY+CPKnMCh98gqhFPycMVGJwoPpXSDOAmRURZ+3MGnD
	Cy3jKzaorydmczxsuFCXRJrRJAgtb4i4rZ4y7CWsc
X-Gm-Gg: AYBFou2q4ARM/mXa62uELZr8Tb3QhwNOmUgZM7pxI4DAx2RSNrVN+6LyfBHjfUm9qK8
	8c/z/T9tKi8174q5/CZqqoPEwp5ztdBa2VOdLGSlVRt5b/a317O4zy2mwGhYyQRRk2LGn/ogVbW
	OcYCc9KYu+deinyLyrjUtrNNN2g2bUxX0ybP4DEqklz9N/xawcSaO8fnqZdr06lD2SSWeTcIvG0
	02A8Yy3+PDdYtesWRg9hRDVVcuQO+o1nHDwtwyJq6MlfP6vCNv/JE8QMplhz6W+f7t8rGyYuUG9
	dxfjzx4fXKYXMzizdlPYWWTaLZu42mnfRL9ksJvBCujzvC0tC7rS6WiH8+Sdw9nSOqvacBA3i0D
	/jeeH+r4dxmbIq1OK3J7VZ/F0WUk44P38UsMFeCUfQUsZGqbBiHW1IWdN9Z3RsZlwYklP
X-Received: by 2002:a05:622a:181c:b0:531:172f:79e2 with SMTP id
 d75a77b69052e-532eacf6796mr37817181cf.33.1790166786436; Wed, 23 Sep 2026
 05:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921182700.1796214-1-edumazet@google.com> <179015573006.2160803.8476413815394184466@kernel.org>
In-Reply-To: <179015573006.2160803.8476413815394184466@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 14:32:54 +0200
X-Gm-Features: AclHuK9e5oV0tOBJPNqk-fkzZaGttmgP9btLvl1E2M9Hlv3Om8iEo9XeBO9uk_U
Message-ID: <CANn89iJ_Zgz5FsBo8TjoH5fL_uQcFre1OCFkTr=zw_soYLZnTA@mail.gmail.com>
Subject: Re: [PATCH net] net: flush skb_defer_nodes in dev_cpu_dead()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, kris.pan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:28=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (3) =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The new WRITE_ONCE(oldsd->defer_ipi_scheduled, 0) in
>   dev_cpu_dead() revokes CSD ownership that another task may still hold,=
=E2=80=A6
>

Right, I will fix this issue, and leave pre-existing issues for followups.

> Pre-existing issues:
> - [Medium] Residual page_pool_destroy() stall with all CPUs online: skbs
>   sitting in the skb_defer_node list of an *online* CPU below the=E2=80=
=A6
> - [Medium] __skb_defer_free_flush() returns early when the llist is empty
>   and therefore never executes atomic_long_set(&sdn->defer_count, 0) -=E2=
=80=A6
> - [Medium] dev_cpu_dead() is extended to drain
>   net_hotdata.skb_defer_nodes, but the neighbouring per-CPU skb queue=E2=
=80=A6
> - [Low] Documentation/admin-guide/sysctl/net.rst describes skb_defer_max
>   as the 'Max size (in skbs) of the per-cpu list of skbs being freed by=
=E2=80=A6

pw-bot: cr
