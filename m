Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D5349CC1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818751; cv=pass; b=p0Vwn1YqsHP4h20MN7NTtHYT9HYaXfPh/JzJwp8LKL1BYgoYvOmNbcEH+SyGrjRjY1vgIxrKRLzBqhC6ZVgWlwJGPu5GE1HMbUCiKZg6L/isQn1EFjeeFARogC5y1ztOAWP5cugLra7ygGR8/3sjEzM6Aq194w3bDvt7CNYqFdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818751; c=relaxed/simple;
	bh=s4uh/gNbpaY1xwR/EMAvi6OUprbAp7HHnPGYKuWDVIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvwezQegy8Bl74SG9E0NrAs1Cj2QHqZeZntAEwKnswN5CJMN/B+v7fFjiSmrEv9/ayIMMm3M8zJi/tH6MgHsJRR4eB1nsXwB9EDt7lU4wln921/wv7W1BM2QACxsF2SzChZslJWhoiRTWwXOC3KuZ0UGcZxRXtj2TZZC5FRkZrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBBwJtcL; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBBwJtcL"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-8867466563eso357354b3a.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790818749; cv=none;
        d=google.com; s=arc-20260327;
        b=Z47J/1hHBWJVwzJ//CJqRtW+jYnTffWj2L9qQPGeZdUS35MRRUE1gVV+/8BXIxv2iG
         Qyzpg9AunL7d/uFwwglaTbCHJRSDuxp5SmAL6mfHvuAOzfWMlDUbKN21hLLKAwJRNDul
         fLiwhyvCNybzi0DutiFkK+3RIti4Vnv2UomIZhczrjbHuSjhxTQbT1E2uZJn+VUW93gS
         mTICaVVmo7phs0m8Rb+QgjR5K5Ahc+thMo72CGtOhp58tJKzp6cixxm2N69Emjc9jiwf
         YvBkpfm4CNbJUQX1MjywiCWsX00ecCdoWrxqUakg0JmRqVoRR5xbWkbGpS3DaZFpW5e6
         dTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COtjRv2U/Chi0BEOZyecEHUtcNDqgHXnui5nuMUUDpo=;
        fh=APnD8n8woj62+M2KPxhRRmjRNTgd7khgE6A0Xl+0MVs=;
        b=IxGkbeyilsuchqe8NskUXYdcFdsgatFFw7l4X3bH2r+9KRH2/rBYfHacdINCnxHdxx
         nG4mY3xD8dSUKYErwLMOlCHtxX5UsFmojU+CBSakkcIB8lqkDbNZSXp1e1yg4X7nAFHx
         7FyNZ9Sg2u3CuPXWbUHvvcgL6ijg4a7Xmt6z9zU7J2WZe+bpql66poO6oJWGUKv+d9Va
         yibQWAhg/6kilmGc2IA+HwNzvkPnWFUkZzIquHMCiE5ObFZ7zbiZpog0vqtM7s8/bgGg
         2mnG+0amylFJB3BGp3CFEo0TVAvprCkRe3miyZ3DHhPGeSonIJ/wja91HCbeBS4KppeK
         digA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790818749; x=1791423549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COtjRv2U/Chi0BEOZyecEHUtcNDqgHXnui5nuMUUDpo=;
        b=hBBwJtcL2v4ct99hNSth1kgHpIu2ZYP25MBUuBMhLhXybX/NbA+mgHX7MbaTu6FwLy
         uhWXERAyMyuBgf0cEiSJTRc8TnRgsIrdef/ABKJ2k/CELEDFHOqPk4nPypjbRs1Uzlsn
         YmVUJLXDwiBe6IbwRnY/DyFMSK3XzqBjZa9Mle5KY+rzc8K925yXDb7XTYnzZI+9btpI
         bT07DeJSPwp1IL2DFlgcB6QnPcAtnOX40kSuVnDxY4u2GprbtMaYFs7/mSDWj1p73Aav
         qWdT9deitLQvi8hL5pHkYvO/qQy2eQR6WCx0Fdx/OLuVt0s5MsWp0vcNF9O/p0GcO3WZ
         BIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790818749; x=1791423549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COtjRv2U/Chi0BEOZyecEHUtcNDqgHXnui5nuMUUDpo=;
        b=nqt22KNxHTMNryGuZXA4rg30PT8MiXFbiaZDS7H3OYMV61ljgZUsnAkfHzEP0HSsy5
         9GhiRmzDcAjusR5vR+GqMaw4MyZAHMbxDqW2y1iYsDztzuO/0jl3ib8klwekGFzEFrZM
         9cHrFyNUr2gjCVcxUvFO7YnnHtpsZM/2A0C+okejzX38LY3/vG1znJ+EI2ICSIsG+afr
         qxrw3GNgIsWaT2FM5tMYS/8CdK55nSbYNL+XwY9Rd92hU+/OCMuxLDwH8NlPDwvTKGqR
         WKP9h6lhU7ExbJgfvg7lt0uEX7JmBXzF7tgQKXVu3PxE5zY9gVtKeRrGUESPqBRmc2qq
         R8/w==
X-Forwarded-Encrypted: i=1; AKwUvBy62THEd6LyLV2lacxgNtWVg+9wKLSeSeyB6JsqunCR3RiqnnG39u3b/cPmU+nfxuVrbzxH8Ks=@vger.kernel.org
X-Gm-Message-State: AFuF++nb/LHQYEDDJIQQeBHHAeE8OsPXNKiPowBa8XMBamUo/VZENYWM
	6MNHj78lBNDKyba7b1ZKcI/5optYcfq7+O1d4eyVGo4fkDDcr8VMrVcuh4speqiCVg3Nvbo37MQ
	ARQubbV270PPSY1nmny2t8JsQIpvH1Ns=
X-Gm-Gg: AYBFou35nQUKQvDKeYIXTb1LMAhuUz9jhWQDbVggmy2grpxG2/HU92UwTVPT8u5BZd6
	y3n1T42V5zfjnVcSUUKEkOArJnmqWoMfVMKkbpAxseRkZQeJuWPoJwrBp4eYTwrfUBtEKYJVSOW
	9mF9qvx6FbPhjW83ehfpHgZ0/qBACVP82lnZPp03f5U/6dI4UjMzd6ZrPK0G9X6UWYq9KsfejfC
	MyE1jRN25Iy3iEtyqZ9NhB10s5097kB/pUmMyjCFFJHH515z4ZuAWAQ7It4/hIykYYscuNXr6GJ
	67+6HLBDlWsGPVljvUxW1tMz/tVkKtYkgrYpd+UrBm3KnEQIN8DTLCNX6jpdYGXirx6BSYWd9vJ
	k08r8FCCZKozrLaSqVCM9e+MlnKuFn1xHeTbWm/vafQnPw0bCdsDN
X-Received: by 2002:a05:6a00:8f0a:b0:872:a4fa:381a with SMTP id
 d2e1a72fcca58-887fc19880fmr904286b3a.2.1790818749064; Wed, 30 Sep 2026
 18:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926100359.78731-2-juny24602@gmail.com> <179072681379.434549.16278864761662817865@kernel.org>
In-Reply-To: <179072681379.434549.16278864761662817865@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 30 Sep 2026 21:38:57 -0400
X-Gm-Features: AclHuK_efZJOdyuA_i8_5CE0jNPJyWD2XYVuhOmF_mYEVX21bU5_QCRlfQWvRK0
Message-ID: <CADvbK_d3uZKMbLTCbMC=S=M6Pmt0n+bt=Pdkq2vh21vzgg0VOw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] sctp: hold shkey across socket migration
To: netdev-bot+sashiko@kernel.org
Cc: juny24602@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, david.lee@trailofbits.com, 
	kylebot@openai.com, junvyyang@tencent.com, stable@kernel.org, 
	corvus@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:06=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit author, David Lee <david.lee@trailofbits.com>, has no
>   Signed-off-by line.
>
> --
>
> sctp: hold shkey across socket migration
>
> sctp_sock_migrate() orphans queued tx chunks before moving the associatio=
n
> to the new socket. skb_orphan() calls sctp_wfree(), which can drop the la=
st
> reference on chunk->shkey before sctp_set_owner_w() uses it again. This
> patch takes a temporary shkey reference in sctp_clear_owner_w() and drops
> it in a new sctp_set_owner_w_migrate() helper, after the new owner has
> taken its own reference.
>
> > Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
> > Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> [Severity: Low]
> This isn't a bug, but is there a Signed-off-by missing for the patch
> author?
>
> The Author: line is David Lee <david.lee@trailofbits.com>. The only
> Signed-off-by is from Kyle Zeng <kylebot@openai.com>, and there is no
> Co-developed-by tag.
>
> The original submission for this patch seems to have come from
> david.lee@trailofbits.com. That means the submitter has not signed off
> either.
>
> Documentation/process/submitting-patches.rst requires a DCO sign-off
> from the author. checkpatch.pl reports this case as "Missing
> Signed-off-by: line by nominal patch author".
>
> Which of these is the intended attribution?
>
>   - Kyle Zeng is the author. The patch would then need a From: Kyle Zeng
>     line and a sign-off from the submitter.
>
>   - David Lee is the author. He would then need to add his own
>     Signed-off-by, plus a Co-developed-by for Kyle Zeng if he co-wrote
>     the patch.
>
> The next patch in the series, "sctp: re-point retained control chunks
> on association migration", has the same trailers.
>
Please add Signed-off-by for the author as well:

Signed-off-by: David Lee <david.lee@trailofbits.com>

Thanks.
