Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607352F6562
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401518; cv=pass; b=nDktc4ORRt8NQNqNJSJBG3oEGFE8FJa34tyWpLmPlN5NWzz/Qu4YUhhJyITptTE3jqIIjzSpXR2/G7rgWFFpLC3aY249S2OATaAnvhfgqBAvkSfPdJ8B8BGsSZtIqqD6srINpBWgvMd1wsaZjLR//H9aQmN/fvsQA62yjCsrIms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401518; c=relaxed/simple;
	bh=6rSFxtUBaWG74aDAzotnkSg5siJL9vuaUhUFkXqPytk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tocap5Yj/XIDe4/vxQ2aSvdTK3oiZKjei7MKwFobPdZrkOtx7UF/t6BSTiDYdDosInlLSyasSKUmbvv0NvlSSquVC7lq7PH9RfpsTomiq73elWYpnEjvc98M6ieDDvPQ1LaznJ4w/eQUIJRIH4T9U9EiJ/2xNFTt7h3FuEpId9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0XlLgtR; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0XlLgtR"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso1010826241.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791401515; cv=none;
        d=google.com; s=arc-20260327;
        b=PntzYNSP3gRBAW711f+7J2joS/AT6dT2vrjsi//dja/3TQZHMEJjqYbLU7hmXrGcu6
         Np0M3AVS7pqOmVIaXeERavK9MqH3qzR5l93F+6NRCzLDnSTZr43Ab9cjcf97wq/0jA+r
         aEiiHLlaraKMU3M/TntLSB6X7QCgjxtw42KLdZox8F8La7dSBMTTqi4WHl2Vj8yNdqq/
         gc/1tjS4bDeX2c8eUK71OhGuPGfien4yK75cPtfrJlnlqo8SeMOfnootMEw1CMIOaMuK
         Onk/TBWMYB/WFupH+L0KdQ+QFDNHPLcI9n0ni5hoZoOWd2zZvIwpQw8+Y0QP+ktM9vbL
         Lp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UmazQOFb88cZY29BLbashgs+FNWCLfkAyMKJs7RtEhE=;
        fh=4ne03WYel7SwPok4oq2RoIM92syc/60skdFfqFaodlM=;
        b=ddKkhtp0kW3o9TsFM/u4g05m5jr4PmApVR9X/30Z+17WnisgpGTel70fFjggQc0iQV
         AtpZeKBVqqk4LgOFsyev5zr7WJjntGB/+BuKb7aPJrVei91bpWZFk5U+aFhcH83ruXx/
         XaDkbC0vCRhcqpoiC6GdwojhG0m+hKvbD/Fn1QZAooahWja9YjR87Dzns01Ou34clUJX
         5qweBfivakHEtsTgZ3kryzYABsUTM8bOTuJRtWbDvHMBlTbTbSBM7kDpRDxNhohdLaCI
         0VzmOofKWFR0A3PfJVkMKPeMls79/2rpNHZWaPxkPCR7YUh4yUN2WJDPzPcD4sfbQJoL
         lbNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791401515; x=1792006315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UmazQOFb88cZY29BLbashgs+FNWCLfkAyMKJs7RtEhE=;
        b=Q0XlLgtRaHW1LeIn/EQ3F+pfiumTeMRQz8VsKL6pnBtreBq95UTNYVq6c9EuMqgvGA
         bi/1KSRycpY30jFGdM4NmxFbUsqpjElnarRqiyivWnvKh9slwS7X29OmQp9foIPkRxje
         NlhBm7hNO1wr4hmKuS6MMujab/mCuWRETru9osNQH9kivomf9PQ4wcJHpJSqb++EQnr6
         0GiDBIg6CWZzhJY/fACiMRn+UyZiklD/PdM4HWS3aDt+umxquL+iVdXiukgW+lrgsNd3
         4YSJ+EFtfa4PrIzCw8ZArtSaXi6CZ3aYmzyw20+JqJYob3oFXpZpqAjJrkMZiEaAzjPd
         Sapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401515; x=1792006315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmazQOFb88cZY29BLbashgs+FNWCLfkAyMKJs7RtEhE=;
        b=ysUXqicgxyLrEJeSEtlyoYnzN/Ycy3e2BMCbDAqb4N1Fiiz+rTBaJ0paO8QZxrDi6l
         uLgRNiqhbImDZJYOypV2TA1AhAlYigEDzBiGL7/w4pgY6wFrOkfivg8z0QyRYAq3Ymyi
         7G7th00x98sIYFd1iwPZPHu1MxOH5y9k6lDr39vHZBzMJ528qkBgkX7NsOZy+UXVHpgz
         fJ3yGOXpUa7gmQbIJNbAOQuZkQpMIjzE2nMdg+fseRSG77quNrg1NUCunmJGuxdHOuos
         cGUfqpc+SoNqXx0U/OON+pL8KSxlwC/xw0GyoiAdmZD4w/2bzh836Up1fgs8291a+sUy
         zD9A==
X-Forwarded-Encrypted: i=1; AKwUvBwlTylr/wGhR5SM4nf2DZRnMVjkmFxBklcstPqWTaEiuP8HX5MyIw8V5ESLPCGyHrAit/XVkXY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPdq3wQEcYw9xFaQd+B1So6DKmKu4VYB+hf7aqjl/RoBgD4SmV
	ZUBh3nwgrGOjEIIU5UArXfXr5Paya1j6W7k0fMvzB4uadu8KOACJvFfKSjNEJcnioh/kuSHIQr3
	V8AswO3P/7j6SHRJ5CO0LQ5jzQnrqw6I=
X-Gm-Gg: AYBFou3MXGksHax9kMc4zSc4Ap1EB510XfPaY+t9FZb64J2CznwmMgUJQqcxnb6vvz3
	XJSNVbDpnMNrV0zc+2yUJ1M5NH8cKfY5r8Njvk7A+DhmhgyLwV5rZq+2m1ua9bz3E1GLuQrEaCL
	EE54JZlrbKvMTkV+ItYTU/qu4DzW0JTxOGLFJyXinT3s3yswdSZ4CGU6gZYiLcloKNkAFwoMyna
	+tUkt7BSb8aufTXF7yzR1reQr4i49P+CVvRAjXfWCnLT8BmwSe4VFKGZ+ua4D/mNwibOO69Y6Wh
	ASMkttlNmQ5fr2XuXCGUwUv66RplTB/Com0bMXut2f0x9qcg7Q/vCZakrwQmzvFT+moIE7ker42
	bNeS85v4OIogr0gjSIK9sHa5SnklH2NbJYNXZEVrQoQJ9QpekiRgN9u0g668ekCT4Dljxse5svz
	tN735gkxf6dDMVxSeY6amIbvOYt01AwpNZ07Csdb1ZMIJU
X-Received: by 2002:a05:6102:a4c:b0:7c8:3b8c:82b8 with SMTP id
 ada2fe7eead31-7ca38b6e963mr1119834137.17.1791401515148; Wed, 07 Oct 2026
 12:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
 <179127056620.2231598.8882282421523696709@kernel.org> <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org> <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
 <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch> <CADvTj4pm8fbgGDiyXVHubnM93qOey7o18O+MDU68MSisXVvHtw@mail.gmail.com>
 <f304ee6d-bbc2-4f76-964a-998c3febb8dc@lunn.ch> <CADvTj4pniuLUzsHP_kv03rFUkUD87PD9yVZ=HnW0CsZX78OxLQ@mail.gmail.com>
 <98a7f952-37cd-4886-acb2-e87743e51fba@lunn.ch>
In-Reply-To: <98a7f952-37cd-4886-acb2-e87743e51fba@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 7 Oct 2026 13:31:43 -0600
X-Gm-Features: AclHuK-r6Ggh8hcrYXS3hhyuBupmyUJCn-QYPzqWblWY-KLgPSt5UCA_gEavD14
Message-ID: <CADvTj4ozfxA3E13g5sV2tPogDk=S+VOyf_PAXZVQyaozoe3O0w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Nicolai Buchwitz <nb@tipi-net.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 12:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 07, 2026 at 11:00:50AM -0600, James Hilliard wrote:
> > On Wed, Oct 7, 2026 at 6:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Tue, Oct 06, 2026 at 07:27:05PM -0600, James Hilliard wrote:
> > > > On Tue, Oct 6, 2026 at 6:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch>=
 wrote:
> > > > >
> > > > > On Tue, Oct 06, 2026 at 05:17:20PM -0600, James Hilliard wrote:
> > > > > > On Tue, Oct 6, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@ker=
nel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > > > > > > > > Please do not repost the series just to address the above=
. Instead,
> > > > > > > > > reply to this email with the missing information, so that=
 reviewers
> > > > > > > > > can take it into account. If the series needs another rev=
ision for
> > > > > > > > > other reasons, please include the information in the comm=
it messages
> > > > > > > > > then.
> > > > > > >
> > > > > > > Please make sure you read this paragraph, to the end.
> > > > > >
> > > > > > How much detail should I be including?
> > > > >
> > > > > We want to decide should the patch go to net, because it is a rea=
l
> > > > > problem which bothers somebody. Or is it a theoretical problem wh=
ich
> > > > > will never happen, so we might want net-next, or maybe /dev/null.
> > > >
> > > > I mean, it's in an error handling pathway that could be hit if ther=
e's
> > > > an -ENOMEM error on an IRQ-action allocation.
> > >
> > > ENOMEM does not happen for small allocations.
> > >
> > > https://lwn.net/Articles/627419/
> > >
> > > So at first glance, this seems totally theoretical, it will never
> > > happen. So net-next, no need for a Fixes tag, etc.
> >
> > It looks like there might be a few other ways to hit this cleanup pathw=
ay,
> > not sure how plausible this is in practice however.
>
> So lets go for net-next. If anybody hits this for real, we can
> backport the change to stable.

Should I re-spin this on net-next with the fixes tag dropped? Or does
this apply as-is on net-next?

>
>          Andrew
