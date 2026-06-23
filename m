Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C791E832A
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206061; cv=pass; b=nrr2CXfZPr8vd/qHzilC5r90NK/2obUipMFQM+K+9lJzZTJtZxub2r4bVlhpp7dCsJjlsMEUB+1fRQX/lNpJVQW0Kl3yAk1JcSUTFOwEL/ffFTVaCuE2FyMtUXOy98IvA/CM4/+fe3yLPZrzqGCIIDdO87rgbPB2OT5YZ+YISFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206061; c=relaxed/simple;
	bh=EqrXdIBWaYUNTFvEZ3cgKka8p/hM1w0g8WUM2+DGnbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1ODJJsDmSeHO3pYPp3IF7C+Pa7Xckhissd1HvH35CEVB5X+ZZq7g2z/C4SzK/yCHKm/lB+RnNVfJDRVYaXl3FUhxSX5LA3+3g/jmHNd655yQf+pRm7sSFff+9+zxqpbz2UGn5CBJpxyPClKQ5+ADz9G4/3zCIZUzDfNRmwzXr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=J0nLQsCZ; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="J0nLQsCZ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec49f7e35eso773991866b.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782206058; cv=none;
        d=google.com; s=arc-20240605;
        b=hJRC8Tku6G80CCMWZYDV9GpEb3yj87cRFH0Jm+OYiX4tofrSZLRicTaV6ahexo08cg
         k4hdq2bWNPrOqFN4YxWAXSxrRui9AzBLB69UGMMKOKtAkbhSjxTLwY0yzJSTJu6Bomn6
         wvY5QiedTSiHM6VOKSvR2/sSniauFTjmUnB+QG1FZCff+85jirUb7/qt6pJ/KvT5lMLC
         p8EseNCnbsL3uq2ZHJ2NLVwYmvA1TlfsXSFHKBciCglSs8w+hcDayGue32fAmYLC2j2r
         WNiiMaugXeOktKvLYwJvo1szjB6UOWKKKGgWEFYp0mIi1pu+M78JS96MlvYkGmELfSvX
         ClZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EqrXdIBWaYUNTFvEZ3cgKka8p/hM1w0g8WUM2+DGnbg=;
        fh=ZiPGZhRuSsf8uQp8hwX09K6i4HZZRiwgKbmwpg3gvpk=;
        b=Cg5uOHK7PHMKe451zhjWSLzvoUZ+rjd9manCZT2amrviGSpiVJnRI6V0gKHJXo4Mp8
         TXGgzKojzzTIpvewWwy8wqgD0Qp7tkMpAMJROTzaGUhgrN3dhrbSDqMtDyszVw0RleuK
         KjNlzKNl6XsS1T8odeBepaFpZvHR0R0R1qSjRJuJ5LF7LJz0luo0xffyQ1ESdrgpkZDN
         ikNGQIxY5lY3wDkCkH2Iav68L65S6Sm4T9LLKJ19UMzlzcCEEvBECy0Bws35gSj2oJ0r
         DM1jeHeb5uDqKPxPS+wk6kfWl8CMGCMRNCcL1IarmBhARqaifQuW/VBN3gKBWzTEvciJ
         3Z6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1782206058; x=1782810858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqrXdIBWaYUNTFvEZ3cgKka8p/hM1w0g8WUM2+DGnbg=;
        b=J0nLQsCZ/S2NrpEndwUoEjSJtfIhc2qtXn2tASmm/LwhCvUsoefQj1mEGNlsCu2AVV
         KWeoYNBtf6heDxct23fOn+pVBeMQFuPxtJ6FQPAlFoSmFDThsOt8JBTnNJvGMp8/k/LA
         NZzvL6QYvEOzkOKTmskuxlX/hI+mLuwiwAv2Q1vR9jlN2aBOiIQiqlTbQhyWyeXTEWL7
         9sQmphM3iPQF1n8zKXgn6Mf0sEeyxvxwDfjxpqMLn/jmNoIYhvCSiyMphEpGI+35FRyM
         DCqUfQPIZaLi0yLmNyi9h6DbnrO3mIcP2Op3vwIjlRrDUyVa5EpCHAZoBvJkasf3PuLM
         CCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782206058; x=1782810858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqrXdIBWaYUNTFvEZ3cgKka8p/hM1w0g8WUM2+DGnbg=;
        b=A9FRmooUHThDfsMAw9a/V+4BH9g70SriJSbXkHsUgLgmrBD3lG3h+7GnGwlX30Vrz/
         N75D0aEqAqQZUfMzf66CTu4Lr11XfHR5C13xMWfI3szkhtMjW7vfjbUXmH0DQmBh44ap
         u/F6SQT804bhGDQ4ILWackKbg23Nm0Vwxh8MPAEMuTJtiu3ove2T1+cn+NIq6QrjqRUz
         l1UVtMID3H6cNGeI/9ibPLFF2Z0M4gVT1kqMtPHaiOZxGYudb1lyIn/TukmGL5HjfIzL
         9HS5xtzOQapfre/j+pLIqG7ebpJRIw6yZDVtNnk814bH6dZjtqoEyAGUJIBHod6D9jG3
         3OMA==
X-Forwarded-Encrypted: i=1; AFNElJ8XA5rVclAnFD2EaBzRO8nQCHJx+QyPImzZFaO4ijKwF6XYB6z2aE5mmuDqM6McPoD6dKhnjdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZsRnpNppUVRokqvfn2UurcOs2uRP+Tpw92AoZRoVYDRhezGA
	ob/YqPKkMbCGgPGIL/t9AFEobzv5s+aDDLKfNYqn/q8NhfBa8IeUHB/nOo8fC/eHtwZxGIGHVyz
	T5bShECnoA72zALIdRpBKb1BtF8NjkVRs/CZh9XlVcA==
X-Gm-Gg: AfdE7clN7Iz5NBl5skllQ6ulGR/t8r2RqdzuU7ah2zVlKB4JFjsx4FmDpuSGD/uKR2S
	GKTB8PTxCYKRfGR8xel6sWuA7XlVl614J2wLpepAkuSUZDHfGOTrZcr1eA8oCQ3th/EIHNBTqjR
	mY41pZgl2JeVNE6Vf4PD6rRGEtTelNjFgq9GaIeMhWaDMFhnMgbY7EA9xdT20NChpk1OJWItjTv
	VE7SUPu+K+6W+WlmfW3AdG+5pYIRTaIEm5nh9wlHhEo3LYPLf3OMMNmBdRwSHkElDSmZWRtTBRb
	abjdfHdMiUrIYM4KM2HG14TGQMCHSg6X7eRDMhEFuN2StcwTfcj1z1B94oPb82po
X-Received: by 2002:a17:907:c247:b0:bf4:6aca:7010 with SMTP id
 a640c23a62f3a-c108f0f4785mr83260766b.45.1782206058319; Tue, 23 Jun 2026
 02:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611101151.426050-1-robert.marko@sartura.hr> <20260613112940.05bba5ff@kernel.org>
In-Reply-To: <20260613112940.05bba5ff@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 23 Jun 2026 11:14:07 +0200
X-Gm-Features: AVVi8Cck-vTeZobR-VkfMvm6BRpNAQv8kjjU388CklAJNNSpClj-lw0YEXhcwgk
Message-ID: <CA+HBbNFNCpGSMkEjFOhDcLW68G8aqubsNb-gZ2BRYd_m9z3E8w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sparx5: change ndo_set_rx_mode_async return
 type to int
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, sdf.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 8:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 11 Jun 2026 12:11:13 +0200 Robert Marko wrote:
> > Commit ("net: add retry mechanism to ndo_set_rx_mode_async") changed th=
e
> > ndo_set_rx_mode_async return type to int, however it did not update the
> > SparX-5 driver.
> >
> > So, simply update the sparx5_set_rx_mode return type to int, propagate
> > return from __hw_addr_sync_dev or simply return 0.
> >
> > Fixes: d90b85c23b3d ("net: add retry mechanism to ndo_set_rx_mode_async=
")
>
> This commit does not exist, as I said in:
> https://lore.kernel.org/all/20260507091012.7eeb17f5@kernel.org/
> the first two patches of that series were _not_ applied.

Ahh, sorry for this then, I had those patches applied locally.

Regards,
Robert
> --
> pw-bot: reject



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
