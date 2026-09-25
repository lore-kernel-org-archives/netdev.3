Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E65480DCF
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328690; cv=pass; b=KAYv9qwgEbPdazXK2I+2tapS9pqZkBrTZt8F3Lt2Bt3+zqJ6YjWfbTNEzcwUfIfSs0fWREjgovIFQEkkZA9dipOD/MM7WeHoi0PjO69Sb3hxDcUlym4htP3oWO6PMX+d0bWXiA7aNCbMlScBfE/WqkyjnkHoACopi43n7z7wsbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328690; c=relaxed/simple;
	bh=P2vkUeynyQ8bhkteIxfSfU8kk6dsNYQMwky9R7uQxfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdF4jisKWOXKNfv84mK7OYdFfrk3r9xQ6mf5QyRVcQgsgaC4EbhxKiJ+4U6nQY8CvKs1hgKiqw/HTZWjHkYAajqrhdGtLlPS/HkFaTdgYxG0tj2FbDo/1XmzpFH/ZJFANdytLAsiDAMOzQAirCjxZSANbXm3rdAQhW938h7FzS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF3LukoS; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lF3LukoS"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76543e1so3765701cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328685; cv=none;
        d=google.com; s=arc-20260327;
        b=KUZkEkTJ0PvA3I6+JsIJcBSjkeNSm0wd0pA5Wy72B5HaYV58dG4mK/PtE9S1VVwhB1
         lZSY+SBq7hKmcErGIiMtWxIVrMSoAg66xnz6ma0idN9oXwVp4QT6gLsSjyuTxuE/iTEc
         WfBeYraFOou6a646HTvWDrgBSYTg3r1jp4ZX2OlgE/4mdPI2smi4XQ0LOfLFWub+oKb9
         ZRAkb8qfE/w/gFAmJupEeOrPlmFHNlQkzNdR/Qqfn6s+wK9eEKWdavZQJysjyXafLX/2
         MDcrZHYv/DYhTRM2543Q3yHLANAQQxrck8Gnt+YIPLzfttErGiklkxkQ97r8+58K7MJL
         wqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BoEGz32kOhSBAI1jaGQ8WLuGcooDte4aXDht8opxmTI=;
        fh=dFoiIt+OyyxoZGiMFOn5PaLJh8deeAT5vWpH+iltR8Q=;
        b=pY8T2dKWZVO8uvWxeXN1UTLYjjb2vHrCyRQq28O91dAcfOqTG36kMENnlLohrRdXOC
         dRFyQIPopExiKaWW+b9jhKRGMM6GWRV1WmMAYuMLZRUmKbz2YH1K7Cas+drUUb3gELxF
         zt1gAfc9y2/cmGJDxFoHD1X1UG54i5T8Sj4SGtRnejybUXkEUP42lgKUuwwKlKejcVPd
         7YLY18mMQB7CorXIsRXRdNh8Lt7OrkswJcpyNBZMhNzf+XeYJtQw8p/dGHjSYxts+2O1
         BltkkMd4AC1ez2YLc99e8+0XQCwyir2zaRl8uU7EugAaj5CJfBaCvwLBwj2FKhnjPuRg
         D3ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790328685; x=1790933485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BoEGz32kOhSBAI1jaGQ8WLuGcooDte4aXDht8opxmTI=;
        b=lF3LukoSxv/RWL3NE08owNg55ranb5BFsj3nkl6hMS7SLSGCRFkLK+fgBjBJZosJ/w
         /GttFcN4+lWQ8ioQOsCpzh93h7YnokXwds/N3Zu/MdQ4PKml9cAQcwX93pytcXVWxuu2
         6ZaCffvJ4p9P3b4LFHAutl22RBKfBQXlGeBLCzjfoZPp1cAKzKNpOUr2uUwjmsansZ1Y
         XU5ntC3epqVbjNVzC6HLasrMo23+pPMAkt/qv6i43n4Cftz8fT5pLWjfCVnGETYwZyZd
         7SY4u6f1c7ZFhSkQAd8SUk7nBWVD/FGSGOKzOab07Xit5RF12P0ULVz33/q0NeopKeBy
         524g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328685; x=1790933485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoEGz32kOhSBAI1jaGQ8WLuGcooDte4aXDht8opxmTI=;
        b=UYsmxYXHRXlVRnfjepOiOuh7C6UQ3DuYAmcyNfEvxUER99elOuTJpeTaAYr6y+f3Ms
         f2cAtke9V3SDGBegXWj77sSeFSWbpT7zI7KSLQ/Xmh0G/nhI4fT1kvoteT02RWWrIce8
         6UC2QM9UVgVdKuPpZaum55P2C9JZJ9FZQbLq7Nl5jj1f1BkYrL0qCbsssesXY65qg0MA
         Wk5fdoQGeZa1jEm5+Rz1vmS0t9/fNT7Tv3yJqgbSRHx6fD7mEDO0i4R8HrsKa/AXpjLV
         obPH2i8vc+SuYxKP25fPfuAPEui8OqxNLnXHuqeS0VnFIf7BcnrKCSDUPQTRX2ZKsjL1
         T7yg==
X-Forwarded-Encrypted: i=1; AKwUvBzopsMhMRv37dkHNWqUITdJZY1ZYVFpr5ZidtZ7RXsZXFujcnhQCfyA5aTlB9I2vi6xqSuCGVw=@vger.kernel.org
X-Gm-Message-State: AFuF++loU6AWEVczfkn4e+myfi62wLJxJGAgxitLZG6Xg6P0NjgEEy1c
	Ut+eqdKGIFB7u0JWeXwRTPbk11y3vJKmlObjHv3a/YAhtzz9/Mkg4fBMTuXizNGc5d+tLoe4NK3
	HIt75l6n7wKIRIUN50QIzO3KJQi/4LVnBhiGu4DtB
X-Gm-Gg: AYBFou0T+t7PgfJGK75iQ5ypPq0eaNBPqGwPhfpSHFDPaWDEB4sRfkoALY5/2K+lbcr
	3246izrY35l044a87EhxZ0j/6TFHGRiQMV++1mOq5ZlxvXkhOH7tAJLsR1vMPIrudfuojT+koL/
	A178K9xAOYWrvpeJmEkwcqNo8LjweZLbwnjQ4oDrt0vRgu8lplqyWvOHlScP5yuDkFXkuT8SR+6
	/pn4r8syk55eO4nZ2gZNWwG7TGv5hT9U7hwEzkiqX6nRGOlURK63WpNOgre3AlaQLkzBU8nGqCr
	ganK+0cM/OgW8O1VS95VWSZ9qpCJt/LV3USYzr1vD/cIJk9Fo5yaSt/tuSvsm68n+Tw+wpM7YJD
	JpnjRZsiLehpZ3LrX1ZdKTY9IozvWVqRxTRN2A6Azx3yhAs3b9OR043Fcxl0JThj34Ew9
X-Received: by 2002:ac8:7f90:0:b0:531:1a2f:7eef with SMTP id
 d75a77b69052e-5330b6cda86mr29901551cf.24.1790328684829; Fri, 25 Sep 2026
 02:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923035217.179102-5-edumazet@google.com> <179031918219.2160803.6960367885486755444@kernel.org>
In-Reply-To: <179031918219.2160803.6960367885486755444@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:31:12 +0200
X-Gm-Features: AclHuK-wTGtFB7xxeHFdzo4ZSGkDq5PTwalJ6IvrEFs5zfSVV6J4DOaRlpmPogo
Message-ID: <CANn89iJyx5AWqjWaSe8ncpEeLjQ4VpG6kmU2qkyZjckXwSVbAA@mail.gmail.com>
Subject: Re: [PATCH net v3 4/5] ip_gre: recompute erspan header lengths after
 a change
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	u9012063@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:53=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says "There is no memory safety issue", but
>   the bug being fixed also sends 4 uninitialized bytes of skb headroom=E2=
=80=A6

Right, the v4 changelog documents both ways of sending 4 bytes of
uninitialized headroom, and the GRE_CSUM corruption on version 0.

> - [Medium] On an existing erspan_ver 0 tunnel, every changelink that
>   carries IFLA_INFO_DATA but omits IFLA_GRE_ERSPAN_VER (and=E2=80=A6
> - [Medium] In a Cc: stable fix, the patch rejects non-zero
>   IFLA_GRE_IFLAGS/IFLA_GRE_OFLAGS for erspan_ver 0 and for=E2=80=A6

Agreed, v4 drops the new validation. erspan_xmit() builds the GRE
flags from the version alone instead, so existing configurations keep
working.

> - [Medium] This patch makes tunnel->tun_hlen/hlen change at runtime on a
>   live erspan device (erspan_changelink() -> erspan_link_update() ->=E2=
=80=A6

erspan_xmit() racing with a changelink is not new. Before this patch,
such a changelink left tun_hlen and hlen out of sync with the version
for good, and a new encapsulation was not accounted for in
dev->needed_headroom and dev->mtu. Plain GRE has had the same o_flags
vs tun_hlen window since dd9d598c6657 ("ip_gre: add the support for
i/o_flags update via netlink"). v4 narrows the erspan case to the
duration of the changelink.

On the headroom side, the version change alone makes erspan_xmit()
push at most 12 bytes more than tunnel->hlen accounts for, which the
20 bytes reserved for the outer IP header in dev->needed_headroom
absorb. Going further needs a concurrent encapsulation change, whose
header ip_tunnel_encap() pushes before ip_tunnel_xmit() cows again:
that is the pre-existing race discussed in patch 1, common to all
ip_tunnel users.

Closing these windows needs a snapshot of the tunnel configuration in
the transmit paths of all GRE flavors, which is out of scope for this
series.

RCU conversion will be done in net-next.
