Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794001162;
	b=vQu7BNAq6D5hLLtAvkasdF4zMUeupXxupQgg5cHmJ8Ttgofoi0ty1F23iTgOATgNHiVz
	 Auc5s48NtBmm7+qsamaoB3WhE+eDgq4eVMivh71Ns8p1tvH05/sZsmrgFTHS0PMjZtNVx
	 K0/ST9tC0DVm7yIqwIG8yXQORRyjzDW4fdezveOcboSsqlZZl9YEaAgo99EgashnGWRSR
	 dRWRZ8dhOB11tkjwaRhwl367V88A3wEI9r6m2IR5cQAKOx6TSwNjTDNDmx/WhKyjN/Puj
	 47+aNbwNs0sjXoSW5sUhn/hAIxvDyjq/qhpmy02hnqVgSLw1z+ETP2CW10xzuNdM8QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Wt8gbQGTbNnq3hYN6fOy/7N/LuDdC2kyjmdw8cVFNDg=;
	b=SIKa/UbxPWSj6kkzomHq+KMcD6wqjdlEFYDnTUNJq71tNxXc0WZ/4e/dUOYHH1AAqfk8
	 wxdcOJOjMJ95DlN2RJF3+rDttE0Tik8nTUtQCOxZofIIIBrVP+g9ytWjPUnF2HzvpUcNj
	 iO6yv3UwZo97hR4lFETaJV1Nfa4c2kq8YRSFB06MsJ1oRkUMp/D8oM2sVgIhsMMa4g6lj
	 tZpSFm8pZadpGpVb0BVgCb8EYpkMDHQB/VB97ETX1vSrmkZ5gzzhu4i4cpKyyN3u9sxYQ
	 UvotKnJYLWEqhmG6MaTC5FKodPThEePJH+WEu0YqhmiprppT1fKTfIszbg2jZhq4N2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="R3DQS/dP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39F606A331
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 21:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E39F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R3DQS/dP
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so118922b3a.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 13:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794001161; cv=none;
        d=google.com; s=arc-20260327;
        b=MJ0CtRZOnRar0g0AksLhPPksjVtEMQaht9T47641ySB+ZWViBUKUbuiDCudoQKS9/j
         zDVzP8ubRtqeKztz8XGIkc+OWtZasBV86E0XNI2nNf0QZKlbfwsE7yjJepY8DXBCeUPu
         fxCIzxLc1NCuI4rbJrgjpFt6N3L6TiRtuEQkTOs2NTJ1v0vxaODh21kk0ela45SYjrXs
         lNvxdfKdMiGBxF4vFBbgvbb5LkUUo4DyJw4WNFE6SnkdwYiOdhfLk+CbJR7m4+GSdabR
         c3kYlLvkULAJYgVyZ+sYv1TUpskgdnfKjrwMFLDErm9KFhBGkRRy0QHl5IZkSe1/YxGn
         atbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wt8gbQGTbNnq3hYN6fOy/7N/LuDdC2kyjmdw8cVFNDg=;
        fh=UVpnmcwY1JECPsX0kSk5JR/zp8Fa9JjBFo3/ny4a5l4=;
        b=M0Xn0ByB7iDYkSSzOsT/yoqv/qU4PTeg5L3SGypVep0InlN0w2Rbd9j8zlgJrglbyq
         iziLfV/QbnsbnE+kYRMzq9pLRZa/GacxsSZr/MjW/xRVrNK2SHYBvVvoy7JF+f4wv9hD
         3BpHsjJ+y0pBuRUruB8ABE1b7CP6v/b6d/0uuXzDO4mfKKF2ws7HIVgR8pztcqCZ6SkM
         TnUbINOpm6IQ6JtStJDQWRa96K4IzrGlPIk2F3bchCdI3zGRB1uQNAii8QMJm/N6xs8Y
         CL2J8INtK9XyjSv2Db28FIUi/dRu9qwNg+qJCs33GMI0vzIixQ+3UUBX5nyE5SrP8AdT
         AazA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794001161; x=1794605961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wt8gbQGTbNnq3hYN6fOy/7N/LuDdC2kyjmdw8cVFNDg=;
        b=R3DQS/dPRTaPvXKNmpBePkOcA9Q8fjm8DKz8G14+7B3Ya314VyoeL7Orr+RLnQQRRe
         hzzTZPPRPoDuMaEk8QW11s22HZkl30gP/FoYwvlPcBLFz3fznzS2SOJFMs31ofU2c5tX
         r6hbo0xOfpY4z4S1iYFW6fWxXvtPG2uvWizc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794001161; x=1794605961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wt8gbQGTbNnq3hYN6fOy/7N/LuDdC2kyjmdw8cVFNDg=;
        b=wRBzBQUfNd3QLY4i7/OxHaNssqpX0+T0MyHdTXmjlkaMFMB0YH/svOr96gAzhll6PX
         ECB4/PNNomgvmMffGSDSbeP60lCZwyCl90k7BQbqcl/LgWLPCDs1KJ98qjylWOdQcWVz
         zFBlwq+RN/csJioYLADKoVPIDjdPuafEBeycA6FnNj0uVWjK/mWxlpT7btC0xPIgIDdo
         lL48t7HmOf1/VX0LAOs8GoQbfAJSAwBzkkGJUpL58p3wf0PlMAxC1nQ50wWq9RUuw19f
         z0a5U5EanLrPSDHPqUQIOKTN1Jghe0y/rxt9Tcv5CNkD4zrxr9qhU+IBY4smveL82z7d
         FwRw==
X-Forwarded-Encrypted: i=1; AKwUvBxoeQ1fsbIbAsoIt3Lm9KfzHBpGTR8GbczG6J1WffULVKjxXQQtMLU7RQlYUd6/C6wsgvsHSm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z95IGEBR3S4pBsd/st7L7ckzNH9prfCgJG8FoAwUTfx9GdtdEtU
	1Sprw9cGNdJsv9p/WuVvzqtsNXMd2rSxKErt9nMZtNw+epZ53SeIgzhR5vfgHO5CAzsUCAT0/SH
	cxvRLuPHk9Qwl2Pu7NFPe42bd8wPEzPAzRQFFv4qxIPCEJj/3D+rQ8w==
X-Gm-Gg: AYBFou3jKAULELmzwKOcL399hGbP65/ZhWcEwIqCmAUM6hc5PLVCx9HyD9uNBekRKDP
	qpXrg2vcSQFGGh7isJoWSBtYizmUg5YcZCc/0hNmsuGGs36nsZ1kdZmKvThcgLjnNr7+lM4ALYC
	7qY+2W/9gyCfZYuC/51hXdkvmh1XPNsOmzozWuPrAfiwjYhr/tLXvSO7k5gvpkevzU/jlQV1TvS
	ktVPDzrCCo+94KVcqMlkImHNCRaUXfWWQX5I/SddPFqnC/YY5YcoN9FQ6zMP3xxOT+6U9VuccYG
	QmmXhF4O/t1uha2irJNhcfAlErQOV7YvRVhrTkuA2Glj5On4cVrvfIsthWyBR7M6V/xektQPKQ6
	m1Gqo0nPzjtefmVPqIafSOs39FKY6pkvj1KZjocR3QWYTYdXEI2407vlrSvb9Xhnd5bP4mfyQpq
	PVgSiRwpoQkea5vLY=
X-Received: by 2002:a05:6a00:2ea1:b0:880:5fe5:a81f with SMTP id
 d2e1a72fcca58-8b37b86871fmr3848342b3a.11.1794001160870; Fri, 06 Nov 2026
 13:39:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org> <20261106092441.00cf9765@kernel.org>
In-Reply-To: <20261106092441.00cf9765@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Nov 2026 16:39:09 -0500
X-Gm-Features: AclHuK-cPQQqk4CR-Qj3ziY-X1UplHOy_J62ZozKYgwXWBWt7e55SmA_qO26kkE
Message-ID: <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
Subject: Re: NIPA: TDC: delay the start
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

,

On Fri, Nov 6, 2026 at 12:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
> > Hi Pedro,
> >
> > I hope you are doing well.
> >
> > I'm helping the netdev maintainers with the CI (NIPA), and lately, I
> > noticed the 'tdc' runners were often marked as either "timeout" or
> > "pending". It looks like this is because it missed the creation of the
> > branch which can take more than 2 minutes for various reasons: PW acces=
s
> > is slow, git push needs to be retried in a few seconds, etc.
> >
> > I opened a PR to delay the start:
> >
> >   https://github.com/p4tc-dev/tc-executor/pull/2
> >
> > Another solution is to let the tdc* services running and doing the
> > monitoring themselves. In other words, you need to remove
> > "single_shot=3Dtrue" from the config file. It might require you to upda=
te
> > the NIPA repo you are using to get access to a bunch of fixes.
>
> Keeps happening, I dropped TDC from required runners for now.

This was an issue related to the indeterminate time it takes for the
branch to show up after creation.
Matthieu, Victor responded to you; the overall proposal you made looks
good. I don't know how we can fix this, but since Pedro is currently
away we saw this mention by pure luck: Can we change the contact email
address to hybris@mojatatu.ai? That way if you send an email there,
one of several people will see it and respond.

cheers,
jamal
