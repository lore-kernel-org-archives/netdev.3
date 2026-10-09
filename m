Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F162E285C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508192; cv=pass; b=uJFWoGEHDMIvZHs4Yi4PpvZiP5Om1KC/m/WeX+CEi2/dyHGVdn94Ea1doOEZBd5ujODKASC47UCDrEE1VaA54bznj70Mhjq8Ad9UPgdePQiAyWf+WPuvGnJagfri3M8zD8A8oIxq3mhN6I6MCZgbuKqYinzq9tkrfmimAiUCOPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508192; c=relaxed/simple;
	bh=zfbHOYPpmgOxH/7SdLKAnBHBmgz7/uJSAeYRBHo1Y9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVJ5mdPh278pF9FXo4pwnDzyAGaL5yLmWtCkwgR+4a8VbFhqNZ+u0oWLwWNdcS5KPlRouSD78l3axKJT3+u2JE6uL483GcB5C/kvGtpl0Um7t5e9t1kFXe8FN/AxKO3dg84BOHF4GiGfCKeuH+wDBwiYT6NpSFP322Yt4fQqjYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VdtQHaAF; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VdtQHaAF"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ba3adf78f5so4513382e87.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 18:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791508189; cv=none;
        d=google.com; s=arc-20260327;
        b=pzMDltwezG1oXa5psz+Fwxiso2lpIS9+2xjCTZhcGcL+HmiL4rmrqT9x17J+LZV+Z3
         8+dYQeFshvXnDuRsKAZ8sUGIxNsnzkC2r5qkwwkKj/GjWf4LehrF9jVz9L/ebxxDzyMT
         6DdnJ/jTmUi4xTFK/t0+RT5gLCxQv5PAoCqvX8+y6WuxvvxcuwtNA438LwCgpD5+hAme
         MgF8gmT85zpL+A/E+xn7anoDaPdOvE2TNZjvawNa8QWnDdcFzpkA2YFll4kF7OL/sPhD
         vlj0d/yJ+GdRA5EwFbyeAOCsCcymFnjqI0TIG52Dnsrd//HfSFcXPzwRQJplkaHOG5Le
         KJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zfbHOYPpmgOxH/7SdLKAnBHBmgz7/uJSAeYRBHo1Y9E=;
        fh=M95i/8broDPojKv/podIhGe0VqagKRCaBotKImYtuHQ=;
        b=KRRpJxP6Ut3f59GCSbaJXR2cYwk6sJ6Prl+IE87TX2Twn5qP6/L4JLnSEbczaftSzK
         SFt0Xocr4VDYqLlm+UXegaA3dphQ0eyIbxsdjq8xaQN1R5rg6gYZWS/83IXdtwoanY5B
         PoIqoT0azVyhtTS4v8RJbfF2R6toQ+cO0f1Nxs32I8WW/uHPydf/krlNpv/hvo0PuS8v
         uRxXVV8/XanXcTewCDl9vtjmWLWsqWSNiFxSYmxIbiY+WrGO0uZSXF6OZ6Eq724Q7PEc
         iJFrirV/S+o3GWRdyOtkLRkhaTSwfd4I2/UfBft5KqMv23gDJcS75N1KHM4z4R7AaBVG
         qZow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791508189; x=1792112989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfbHOYPpmgOxH/7SdLKAnBHBmgz7/uJSAeYRBHo1Y9E=;
        b=VdtQHaAFWbaCLcI2lBQ4zcGk+rEru0nEXCPViade1MCjKs1JlyRoiwDs4yL/yRhb8D
         MVgwsLy6jyApwoLCCO6OvQbLtqtQVmqzOQ/M+7Z9o0q1/9Z5JwHDKA1QSaF4DNEp2uJ3
         4YtUIlwE5IoKsMtbkv5o0ZO0MmNeS7r2bv92bKmpMzUXmRX+OhQbjjY13AenyygB/lzI
         HiYAYRItyeyLN98Lw1/zcikdRhKoS/Qj43j3LUdhzWowkgxWhenCfWxsLJTNLq+pGBYi
         lXshJJtXM5GeSar2fjurnFJY14NVoevclALHeYaul05Os0Nm43KoC3skubw0icfp+npF
         Iw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791508189; x=1792112989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfbHOYPpmgOxH/7SdLKAnBHBmgz7/uJSAeYRBHo1Y9E=;
        b=DLPlS+wyl5oTAgKPTJ9blGK3LwBhbfsNxK3IXenHYxbviNpgWRB+1G9tqyWuTQnxkp
         OyIBiLccZgH3bVP8GZI63BBVp3YETb3oUEonfEGeWdJCS0VXtklL2O4ZW4l6XJbNK7SZ
         KZNh33bGVAjlSGnHI6UUH/KIdISDntCH0Sg6+5ggClrc5GERVaaye4cQAboz8iIaJWda
         ugpI0gF3BBF1nZI4u6/plYQBSD4xqJZIvwPUIESK9ON9140QGeesCd6Y1cP7EvtaMs5v
         /FOlLLDKUsFIh3ForR2M/3Q6TzoFe9zXeJuizxhdA+8YuGAHNab26lb5orZX7ZrhC7SX
         A5PA==
X-Forwarded-Encrypted: i=1; AKwUvByBbf8dBvdnUbZD2KqT8HZAghCxblPkUuAqCZasNUe17Pga2yrqCOp/9l+1os84gtnbRjBVLX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQAFiFUB1UqJaI9o616SsUReLPqpqVd7fKKo+wyWMTWewum1/7
	2SpVgn5tu2NSCYhxpRrldGlcF1EHNgOWM86aSS7CtyTtYQdg1M9l19D1m3aAdCKx6549A9/c36m
	HEbxuZN3PE6Lx0RGK9tUSGHBortduSRhgnxQDcLmI8Pw=
X-Gm-Gg: AYBFou3n/Cg7FmW7NObdeXO+vk6JH5uHdBlpGBWHs3iTw3Q/kQ9q+0MKmkrQse/4Oia
	Zadj2q/BGZa/O9Y3Z59ARaSDFYWdTF6YsswzKM3vVcJ4FtgURwDrOuYdNwgfWO6qF2+3Fl8K2U9
	tn+rSlt9LLP0mXkODGDSkJVXAoOwn2Sz+VckTjmnLzZoATXU6rDGmiM/Y/yBUbv7Sg3r4wmMOLR
	frX+/NpjBHcHuA/nwHSFaGkKvLUpO9gyam/8NImweCLSnGd2YvlvXLUIp28fH1OStnpyao06mnk
	AFjf3kmpFzMgvPzMS7tnbly6zFBImZVcrTdESM4vN0gJH2bN9hI5k6OUGtVOv6PYf2j/aj8ueYC
	cYtYDDM2NBg==
X-Received: by 2002:a05:6512:3b24:b0:5bb:7829:741c with SMTP id
 2adb3069b0e04-5bcde35ea87mr133020e87.1.1791508188824; Thu, 08 Oct 2026
 18:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789885804.git.zihanx@nebusec.ai> <f88fc502b17b4022105a99eea407525807ee573e.1789885804.git.zihanx@nebusec.ai>
 <asgtQ3E2LVWqfV8D@chamomile> <asgwR9LsGCEMolQX@strlen.de> <asgx_COtYd1PifN2@chamomile>
In-Reply-To: <asgx_COtYd1PifN2@chamomile>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 9 Oct 2026 09:09:37 +0800
X-Gm-Features: AclHuK_SUmv4p6WRojnrW3e-mI4nWpBMifWbKSG3UER4l70SEe-UheyaXxZXzZc
Message-ID: <CAANe3eSnAF6wRVqopQkgtQLv2Kat2sGT0Fc6vGkCFk8cCovbuA@mail.gmail.com>
Subject: Re: [PATCH nf v3 1/1] netfilter: x_tables: avoid holding mutex over
 faultable user copies
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	phil@nwl.cc, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 8:14=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
>
> On Fri, Oct 09, 2026 at 02:07:35AM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > The ebtables GET paths use a separate ebt_mutex and are outside thi=
s
> > > > IPv4/IPv6/ARP series.
> > >
> > > I keep spinning on this, and I am not sure this fix is the right thin=
g
> > > to do. There is no single caller of this pagefault_disable/enable() m=
m
> > > subsystem function in the net folder.
> >
> > See:
> >
> > https://lore.kernel.org/all/CAL4Wiir+CBGE=3DhXxHEBkyk0Au9B6G3=3DAdHFd5b=
otrC-FF5BM5w@mail.gmail.com/raw
> >
> > Quote:
> > | We have many places where copy_{from,to}_user() runs while a mutex or
> > | a socket lock is held, and some of these locks are global.
>
> Indeed.
>
> > So I would not spend too much time on this, especially not for the
> > xtables get/setsockopt APIs.
>
> OK, I'll drop this patch in patchwork then.
>
> Thanks Florian.

Thanks Florian and Pablo for the discussion.

Understood. I'll drop this series and won't this approach further.

Best regards,
Zihan
