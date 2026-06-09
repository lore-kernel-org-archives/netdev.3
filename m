Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD929BD95
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966805; cv=pass; b=GW89sJ4T9snXFrQ7uiU2GGQF+2C0u4PyiZCnHrve0+UmSNgqfmcZ82m2D0nw7oVv9PAC+WOfpw1aCqF4bHT9Hfrf78ClGim9QAQHNmpSozMvyPsWpE1gc3Jx3Kngblk6mhhKcaFVC48hNIsEbeWwEX77lwFIDcXoYVfm2F2YCsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966805; c=relaxed/simple;
	bh=FEm6JJLE9dncwvPjjiSJaNwmsb3xDIEOSOpMpXBw3Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtJ4elMFI5zmsmRQwsMjaGQawyPyAcYqJTH5E8r4epM0KSho25prNOgUFaA+ZEC9tKbUw1AQVMd4RKY4GeQ36ugf3h7lxAb8S/gPGrezBF+Ji88Ubw8Sm90Qf9lve6gOkOs822rpe+DH3MryemaqEwwExs7E0yhP02om4HGXhCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idBnAmSF; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idBnAmSF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51790c0a692so49939121cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780966803; cv=none;
        d=google.com; s=arc-20240605;
        b=at4Ognfpvbedw6avWl5NJD015mOc6pgP9A4o3qiqnQ1h3vBEnvK8tSLsvb2oSn87/4
         Op3X/92rcx0wLEvSXAE8SFC5YIbwzQ2po52beV+CvhZn+sjjfaNQrQPRcNboI7m8LxId
         ylySNMImEcsTiJ+6YwsgPJKe7cguf2Wq24NCf00hrawkFwFkXalnL9EGOke+gbP0/TE5
         im5WuKf8+ujQfQ60QJql4OfHrntz6EoB8XqfCkSCIYhZ/QcKEHqrc1uA+w1ixkvVuTm4
         4E+XpcTd6jObA0Am24UYxbIh2r6zyfchws75z06s8+spaGZhsK7KxrOR88vFzHf5WD94
         lcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5hmELBnhV20CHyrCuL/uAak3dYmLTS1Sev8TtF4igg=;
        fh=sRQpBXmj2Ky/OWPTPsgGujOLvn6t1v0vURS6pPtkRJ0=;
        b=B+DSCORL347rP9CX6MGr/LIWZBQ6vXoU+1xHLYe7ynuz8FX6JzsG1U1diO/5u1wuRF
         HNfMUzWBpR00BekyM3fmPBiOEIl9xG17vwVLyfMplW/wGZaq5kV6ePSGcJMbzyIg7rxK
         x/4ZusFv5HpYHONgPIrXB3BVNGlVqfz6OAd2ytTJgbO1OYj9IwZk3osqMbyB+EW5cthb
         F2odfBSm9q7x5dRwp5aHSLkgM927fP+P6W5OWKjw8JpoFMUHOqAu8Ewt69yieebQFftX
         VnWkdE7PjOveetXWlkHSPeFDF7wBKbCOu0+bcayXaK60r4z4pQMxanVR2M+DJV360GSE
         /4bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966803; x=1781571603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5hmELBnhV20CHyrCuL/uAak3dYmLTS1Sev8TtF4igg=;
        b=idBnAmSF1octpJrZeyoaDm527ce+Ed5h6DtjiSq/w4ZDdKNgxLac1578xYZzNEAtdV
         OtKFSm1cpi965w9/cqM76a5rnnri++V+TpcdVwG4bVoJMYXrftVqZJ2iEh/jhYm18i07
         xZddIqmR5TFfavdd7VJSghiTrIuQHXIA9o4MBLlWnKGPpmt9DdeGGlnEvT0SIRlL4rL8
         SBSaCkZKVzC3iUBvg+DA4lYHwxqeZCkzBJEUgspM0p/3QYzTc8mmj01V9Hoid4CW+bXC
         MHfZqOqOOdW7GUD7qkoe0iYj93YkZMcgUMDdud+iU+oknCQw2xsZatuwKlbluptUlMcJ
         m9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966803; x=1781571603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5hmELBnhV20CHyrCuL/uAak3dYmLTS1Sev8TtF4igg=;
        b=QXwMbjlZwEHExfcnJQgj0BwrBw7XwjjSeC5u8GxvKwUu8SkXi5pd3nHCe7Loc7ipDH
         DM9Z+OEtk40Ak6qa9vIuB49g8L75Rd5e5KxYWXvxvcAYqxXYYIMXbSbyGiH048KSvrcI
         GYGPaMI/wPe0/yG+X7te4vaQ5l9e+u1MntKNCR/aLzqTDiYPHybM+9JHrvZTB2CtLMgg
         1ErfQa6awvYgUyS33lnOdUeqoHwsXHiL8fbnZQzfJVqveUVqt8EVgcfCsRVZ/Y7P8muS
         fKmGODvP3OARLWAiAI3Tjfsva51DcbdKPTrd3pjVKJBYQ3eUjlgVPbTOzs6Dc9K7N8VI
         2sRw==
X-Forwarded-Encrypted: i=1; AFNElJ9jDU1Yo+kw3JTjDdc7nhZIdlx9iUflrFhxl0DLTL2voet+xThgq2FiAE5PlWDS/5fU7zfrSMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzS73WNY2GPYX7mqrE5gqqRxCfrNrnItMhFsppdy11U8wiTA/w
	U1tGM4lLtpKcuITNc4FghA+wa1otK2dCzXinZDC5StK/oJq5TmC9Ul3wwQ5aLceAkvu+4LEejD6
	r8imRsTen3m+LwCDZq3i/2PS0925/6nLyCU3+C1Xz
X-Gm-Gg: Acq92OGx2HgJ3Tyz/0SC0K9O4v5g8uUr30FLw5JEq0Y+7LHvDPUiWwmIsnjeLP28Kfh
	Cl3003wrwI9xuMl6zLAfXPPTVd8VQBW/d8guwSlK2QtBXJkxO+bq2ypCP0dgwqhIrgsSxkKam/y
	jNd271OdmW4EoiUVIESUgUXO+C2T/z2oBGK+AbRtdY6uEy2kI1wZr5IIp9GIkV2GYIUFnP5QNZO
	jsec6YKAJ+4D2OK6P5CLimxXc0Fpj0TNIZ0EoPE6g9bNqGJmFEoP866r6D+kcYlNbwnNA7mocVN
	8z2iFY5JhARKdx41JvMElx7Sy0/RNdkDgTxOUkXkrPLLRuNaDoX62oXD5fEOVlxlfA04qGODBCn
	p7wTDeh9Tdem8EzOOxHZvlru8R+7iVN2Wvr6KEQw=
X-Received: by 2002:a05:622a:2a06:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-51795afe9edmr243349301cf.39.1780966802662; Mon, 08 Jun 2026
 18:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609000850.1234569.a788bb380be5.choke-limit-shrink@trailofbits.com>
In-Reply-To: <20260609000850.1234569.a788bb380be5.choke-limit-shrink@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 17:59:49 -0700
X-Gm-Features: AVVi8CcrGwdN3aKcH7wqYsAYfZ0yH3uVraBig3OYX5VPu46Zrn9u071JShA3qZM
Message-ID: <CANn89i+b2Wn6Udz+fUpsmAQgd2RKV6BOPhPHaLjaNpsSTtSyeQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: choke: trim backlog when the limit shrinks
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:10=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> CHOKE accepts a new packet limit that is smaller than the current queue
> length without trimming the existing backlog.  The queue can remain
> above its hard limit until later enqueue and dequeue activity eventually
> brings it down.
>
> Userspace expects a reduced limit to take effect immediately.
>
> Drop excess packets when a configured CHOKE limit is reduced below the
> current queue length.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

I think it is time you stop sending patches with questionable value.
