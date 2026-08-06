Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361331E83D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007181; cv=pass; b=gOqv63pvFMjJUDZDBVQAEJw8E83WbneXBh66uP0/pYqsiimmLBvq+M6uIxTEkXs4zVfFUQBNRelsKbie71goO2RfueKwSNCsYIWMkVYoR4s5zpYNk65MsI2W6Fk73r6bgzOrMR5C2p43gZQe6rsrhdICB26FxIymlrzulL08GGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007181; c=relaxed/simple;
	bh=v9MYtyzjFW9TQ/cxwE4xtix0OTDYFMtTjQUhK50brqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awTmC0ad6s9rQnVcg8z9OZjB6oQrdxQhkBa8Kg7mVTbE8Gc9ubTKkgwYZm3u9bNnKUHqza2/mCQfDyvFEyIuw7KT5WRhWggGlUVDakZsVwjcy4qFYLtid5h7t/ZBC/VXqYK2NZ8TUMz6E5VqQlZJqdnhGv36syVFoFjHomtUdiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=fuVEv+je; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="fuVEv+je"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39f91ba1ef7so12939541fa.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786007177; cv=none;
        d=google.com; s=arc-20260327;
        b=GU+P3179RYlE0KIhBQSFQ5S0tOM9Jq8oOzVN36w/cKySu2x+78+7vMblD+aClN3C7x
         C06iZevqqgGpkRcQUfEjNRFW4oJVicnhc9ruwL7CHZdoYe7ZY1ND5CKbsGQaEcDuVUpq
         NThz/cuqetW2m95pnvlnHqYaqECmQzwlu5TK6m21zN+Sy+S5grdBt2vrnnSPhYTO7aYp
         NnztWTPkLnqZzh2JuxZP48N6crW8ic5T+3XS//S33LAf2juFHPmXZv3szWJ+akD/PfSC
         UTEHssRAytotVJHcbdF1+kIfXcGpxc/Wchs6/M7LwzYCJEonQv7FKFFPh2cCxB3uRFIr
         jhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9MYtyzjFW9TQ/cxwE4xtix0OTDYFMtTjQUhK50brqg=;
        fh=ArFHMkB31hdX0JlorIuoga/MAoFChJFy2pjj3fouyo0=;
        b=Bgba4C93yB2NBroRImZReSDxJTin57Inlc1M9pVWnpkNFccyF1UULr1A1gMlaMsZf+
         GSjuV1XT/mPOAtQL83mh/5jv7UfUU2kr5HM1l70stYJZLlAykIINmqwqKVMuGz0jgCyW
         gOvrWqGnDxvqKXXJ7aX4srehrjX/OURXiOE88V7A9LIP0YPtcm5/DfEcHH9v/GrzwyQl
         0XdCQqfa9k25seu2zE3wywUNV7lLUOm54QMXrA4iTZTY3fmF+C0wW/3LcFKEJBgBMGp5
         7UObrbCPnoqkPp3Nt1RPERZUSOG/CrNlnjafA/zPrt6RR3d+DlC7QIw6Ifl/KLhXgdJD
         ELVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786007177; x=1786611977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9MYtyzjFW9TQ/cxwE4xtix0OTDYFMtTjQUhK50brqg=;
        b=fuVEv+jeww6QlC7krIXZ+f303Vd4gCYKpCdtND0HCPrHbHLgcnVzg68zBtw/VKAPqH
         EYlW5k/WQOy9KNbeXt74cx3emkfjMpxAXXkJFT44s6eszieVmy1zEbtX3Jhu24LQ9ud5
         cF7HgtfrJsK8f+DU0f0/IPBe1Eou074QZYL0Aq4jqtLwvuMi2my0IJdrEWL+WyNcXASB
         /vCbk4xXodpgpKZc10uh/6ogoQhhg1JepKUvF6vTlcOfk/ENDt9ToI6wzOYZ11nAktBh
         oG6Bt9gzfZWCKbeGlPRZR1vX1aQC78PYGcWHntkT5rFEfu2z3SqCASOkyjn09TZPhPkS
         Cs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007177; x=1786611977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9MYtyzjFW9TQ/cxwE4xtix0OTDYFMtTjQUhK50brqg=;
        b=bsIW1VrUQsdTp5Pyuj9TdSJerUEfPk+KVozlrewe/qGf7j0Jbedis6KI/z6Sl4Rc0g
         A73FtY1hZwyyq/H1Y6HaoLAvASpITUJbVblVEYry7oQ/8wAkhPaI1wu7GJDph9dRLknp
         IBvOZeSvLp6b88lsNDaIGBUi419YIuOoOVqOu99xdIfyA5X/lKpfsyE9VhOBGI4ClaNj
         mSZvf+PaugafmKydRDaIygZoAw429S0hCoAV8A8EK0gFIJZya1AC6bxPiTYZgWmbcf4i
         jpGbLfbxr1NuiNPwnEZLsA1QV6JtbDm0US4zoeeEbJt8dn8Nt07rWD5W87E0SPicIa87
         mFXA==
X-Forwarded-Encrypted: i=1; AHgh+Rr22aBKXceU7n16E/lxtCkjxNucrJ6D0vp3F3HoskbPCciT97QKoGPmO09ixfc0907E8V9Z3OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1oBfl69hzfp71++NuGWuHV42pbqNvX1mJjGFL3HU3ug+3QeT
	LZOGYcRpbEQUpgtbNff0LNSARhhX2zJaZEPcXQKKZVQG6Yfg6TedUQ6bdsYl68cbVap2kH5pAdG
	H8Kz13Ln3T19SqXbnIkuxxW0bamoQWGumFEP1OLFCdJY=
X-Gm-Gg: AR+sD11iWXK3mIvbIGXHcN34czbSUnoVBDFlmbXfqEaEdtEBuhCG80TS28bp8mqeVLt
	bddZH8mOD0FA7ajScw/51rxxNQHfYRzVw3ot4efZC1bb6Ez2TQqOn12L0heRVqjqAubcflvuuoD
	qNcwoc3wS9txoOUJqr8eRn7hXanglVmq55QhtOKA47AgzkfgGht4cYlnPk2MuS/9u9ZL6ZEbtiI
	YIGDj74ekSK9db8Hx18MXyye2KylZHmYMrT0j+mJgS5/+Dfk6AsWsQ5H6Ejb4fdMwhSuRYZ0P+Q
	2rxzmiQbdftEgvYecps/S9mSGfPPm2OeB/NBj8yrVrRg+30P+QnOLwmi
X-Received: by 2002:a2e:9a0b:0:b0:39e:b3b2:e95f with SMTP id
 38308e7fff4ca-39fbb2646cbmr16353931fa.18.1786007177175; Thu, 06 Aug 2026
 02:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785734738.git.zhilinz@nebusec.ai> <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
 <20260805090721.GA1364862@shredder> <20260805172902.27c9bde0@kernel.org> <20260806085214.GA1748060@shredder>
In-Reply-To: <20260806085214.GA1748060@shredder>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Thu, 6 Aug 2026 17:06:03 +0800
X-Gm-Features: AUfX_myp3yj_rrWJgr9s5GBlHK_2Io6wcg-A0TryjUYb2SmwtVWpnRpCNmmloiY
Message-ID: <CANB6i5xN-rrcVe9foAJ+nUP-6VLrgXa90kwh5banCUVDOwG=1A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, dsahern@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	tom@herbertland.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:52=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Wed, Aug 05, 2026 at 05:29:02PM -0700, Jakub Kicinski wrote:
> > On Wed, 5 Aug 2026 12:07:21 +0300 Ido Schimmel wrote:
> > > __gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
> > > before calling ip6_tnl_xmit().
> >
> > Probably just me but can't they all be buggy?
> > PKTGEN likes to send shared skbs around in funny ways.
> > Can we get a good explanation in the commit msg or maybe let's
> > keep the check?
>
> ip6_tnl_xmit() is accessible via two Ethernet devices (pktgen doesn't
> support other types) and they both clear IFF_TX_SKB_SHARING, so if
> pktgen sends them shared skbs, I would say that it's a pktgen bug and
> not a reason to block this patch. Note that pktgen is not available to
> unprivileged users, so it's a less severe bug.
>
> The patch also makes ip6_tnl_xmit() consistent with its IPv4 counterpart
> (ip_tunnel_xmit()) which is already using skb_cow_head().
>
> Zhiling, please add a note in the commit message that ip6gretap and
> ip6erspan do not expect to be handed shared skbs given that they clear
> IFF_TX_SKB_SHARING.

Thanks, Ido. I'll add a note to the commit message explaining that
ip6gretap and ip6erspan clear IFF_TX_SKB_SHARING and therefore do not
expect shared skbs, and send a v2 with your Reviewed-by tag retained.
