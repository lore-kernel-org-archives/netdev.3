Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65A48662E
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045196; cv=pass; b=hdJ35F/AWqCzBuV1kdyHKJ9oGzxHmAkNivBKH0gxPMKXr3jrG/laztmcH2QrzCb1Lj6OsStbEdYLdU38MFBOgguk0XifteVI3gdMGyZcXdSlHyE8w5h6PWNU6h21h++uLCpmG7MrhEdzWBwDvPaXeaXSKv/hlXXtsi0+SKLE/yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045196; c=relaxed/simple;
	bh=/3iOSJNKWHuZ4Zsob+TOBLdiLU4IHFzl6ggjUyDmceU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdG4TfVzY98jY1/SI69OkdqUATRolhHVnahlR0Y3acNvC9GLoIgxIBAFq5MkvBnkI0iBknVoncpQwTlyiyLvDyGfYG/zF5UcGkiWbnwZQce76RODvII5rIY4kukZ7MYUbglEK18Y/VhgDHW+XucBVOqAQ4QR8yWOTkWP77b/yo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=S1l8DwVf; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="S1l8DwVf"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66f883abfdcso7256733d50.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 05:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789045194; cv=none;
        d=google.com; s=arc-20260327;
        b=DabvprqOtyQoJqGhixVUTCmXpKc0W6pxxrLJgF+RU/aYTPdP8KRx/SxQGixVkZFG6c
         Cf7ZmvbDB2pLVeNcZ5yfTL9o0eG5ydh3GhAnMR2okwGeN8QaR3CnY5LMdy1pAXdC9IqH
         Hj/AEGPaw2y7F65fO+m9mQVCNUfBuK5LrgMqYUmiuusXuFU/g1kLSrkcuu5KXvhfDBFT
         npcCHwqdVCYMeynclvKKf1Lkk96gHmlMuABeIjrkIASa7aYXDERuzGhmJVrbI/FYE2RD
         Ve9xzheTcfYBeuctq8hQHgjwW7l5EAhnJ12pIHpd+ocdytgoJfCirTRYqsd8nXYu6UZv
         BDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e089dMdhkO2kAB8invwvXsct0rsZ5UdntATNSQBcPko=;
        fh=ocTyRrtX2hzU3/eixharcmpkaOVs6ed0J2DMgSX0WV0=;
        b=jrfXFOL85I0mZiwG4PFV6NdN22mQd6PmEhRI5L1UfLya9/W1Vmvnox40QjzGUi2Aat
         IYJY3l+BDT6A4/Rv8Pji8PY5OebWXOROjv4GKDEfme+OgRIYO0kH1ytm2BJx8nEzRk+j
         1IXc0iZfeFNkL1Oia31yyuh1EgxFCFIjKSEAjdVwoZG+aKaZtFl05EccC4li+J91gV2o
         mm+aqoaHrl5zmur+l3tcbh2Ul3MW4mL8VFnhcxgLhqSf7STCtSQwRN82nBI8Jqd+50bb
         bstpA1QlCykbqwHRk9jdLjD6ZK30HYsiGejbog5N2a1aI1yIfQFdG55r7a338n0IXClw
         IAig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789045194; x=1789649994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e089dMdhkO2kAB8invwvXsct0rsZ5UdntATNSQBcPko=;
        b=S1l8DwVfUkWpxE5EWoPzA42a5zQd/jP7ix6RU/KHb3Fdhu/9dbfORFBxwscSR5+pHf
         XDQY6lXxoVtzbDa31UdMOC3+NKn7sMoVTiZQVZmM+HpvBXZygIzsQuRkxU+cnRVQ7MDv
         Ck4agq1i/JcHA+0qr31MJYXiYyMKOTIpCkti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045194; x=1789649994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e089dMdhkO2kAB8invwvXsct0rsZ5UdntATNSQBcPko=;
        b=A4KoUnjTp5hVBOvlBQHwqiu2zzXNJ5yuFz02cFh9bhqS8GMBz+ITgC8QH+GUL8168S
         EX0978WeNVgYDJuFFbVidnGfrIdLpRCVhcO/iFcofhKR/gEbe4tyiNEbU2xAXiaiyWYr
         OX6Zty7erAXo9qVAfVJ3zEwhGeIv91B06YO1DSwYFHfi2ktX2BtrWHc5JvUmi6fY87Ms
         HSOq7w6xwK8f65xZ3ZCbgVEjC+JzT6dohEKuqwcOJyvO8wjzoAISjY1gpwXBHNKiiVGO
         8z034/3lPABPEEm7OTjYZPi1dJoxjg5bmweoHQZqNRTRJ8B8uDcGH+tV9CiF94ulk5mC
         lxLA==
X-Forwarded-Encrypted: i=1; AKwUvBwDb4KwNH/H18+jgyUgzS+AsRmCfjLxlB/LHV6RI1slQlrSLW8jjd/2MvSJghFl6Zz4fFslLp8=@vger.kernel.org
X-Gm-Message-State: AFuF++nO643Xpsx6wQbRTEAIYhZh7qSmB7PoHZI932JW5EIs2LOdPQ6Y
	Z7X6SOoBPuvDIsjmJU4MEh8I4O39vbpnQN5IDr/v8H5E8dprD5zIfDXibuPxIqSpwtghyhpPQh/
	MC5BRlnv2rRxed/1H/Y4uNkrUgOWoBBSyfXycseK86z787nclwsPvUw==
X-Gm-Gg: AYBFou3BgWKBPFNCq+iKw72FXQpaD2Gh6aZdGT3h1Uy7RksatQXlAS2kHx9Y5EfI9Fy
	8xZI+h4shbMXeFDNFoFwBrXxudE6tsoZd2HIL6i3Yr1ekhtOMRmxm/sA4iBxV82jXaBwWSgi5A7
	Hn1cP5thEhVvbf2ESx5JACf4CaMklkCPpkUP4xo6Pyc1/CxMjh/vO/1tPfRbpWlkzat9JWVFkkd
	/m4ml2XEvZMVOjgMqJaoIorlvd7wBBnZ3sCgJ0vaRzk1SiW9lVZpGV3oiwxprjZ1Vx+u9rT+Mhj
	P+2ItMmD+WN4YHGtYG3mCTm4dnplGZy6zVb7KAiUgOaEtgma6pRaD5JB
X-Received: by 2002:a05:690e:480b:b0:66c:c644:3938 with SMTP id
 956f58d0204a3-66fb58f2dc7mr10722000d50.7.1789045194067; Thu, 10 Sep 2026
 05:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192133.2639067-3-victor@mojatatu.com> <178894934962.219967.16944577524953312446@kernel.org>
 <fd286e60-73c0-4a6f-8861-7f6cbc197cb0@redhat.com>
In-Reply-To: <fd286e60-73c0-4a6f-8861-7f6cbc197cb0@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 10 Sep 2026 09:59:42 -0300
X-Gm-Features: AcwNN1W1fERDZVmF6Pb_kNBdUhLUPt1q633We5Nm-IFEOOIjCj5_zQfZeHER7r4
Message-ID: <CA+NMeC-puqKvNRA+SmLekgB98Hy2PhWOusogJcAjZbWwuqoz=Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/4] net/sched: cls_route: Reject handle aliasing
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 6:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/9/26 12:22 PM, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > - [Medium] net/sched/cls_route.c:route4_set_parms() =E2=80=94 the dupli=
cate-
> >   handle scan rewritten by this patch (line 463: `if (fp->handle =3D=3D=
=E2=80=A6
> > [...]
> > For what it is worth, both halves appear to be addressed later in the s=
ame
> > series by "net/sched: cls_route: Fix in-place replace"
> FTR: due to the above point, this whole wall of text is pure noise IMHO.
> Still there are a few comments referring pre-existing issues that could
> deserve some follow-up, please have a look at the full report.
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907192133.263906=
7-1-victor%40mojatatu.com

Got it, will take a closer look with Jamal.

cheers,
Victor
