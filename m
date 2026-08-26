Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21388333439
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787717135; cv=pass; b=c2iEtFFNeokIpao82g8ECfDQ5kU4wakoi5tjLJhP9yPfGBzpVo8Wka5MQ3d4KJ+L9Tnv7pz82W+CRX5J6amjA1VQa2yt1bc6xtDFTKVzNCSZrmYtLg2RKFu0ShTP4ZRgewgcaTKFau4+BFU+9LsbzZtkKFTc3pdIJuyBjGFJ+dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787717135; c=relaxed/simple;
	bh=E1pWPxVu9n8DGB0kROP1MQOt+Oq0bthBHWIhkFmi8TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W85TanQpmHeecEJAHa/gYanl7CeOTinvRhi9iGcsPyEKk8R0MkcShNv/U/lQiU1BbgUOmLIfh30IDxUymT2NoxgcdlbKs9V6p+q0GCX+eY2pki3PwcLq18b8qsFqhIZYMMTl3RDPzplo8yCra8pMtFY2IQOok7hh/1UwwNLKh0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C59kdt7L; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C59kdt7L"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52de50e77ffso4857781cf.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 21:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787717133; cv=none;
        d=google.com; s=arc-20260327;
        b=nWtLekLjuyxZsfE5CFMqXb1wYQSSXLcbzPBYNVAliv2SRgKutDHD5uJZ93LxthajTr
         XMddOpopoIxGm83nQ5vOmGitHzXvokbI+A+M5ZfyRVbsHn+UyG7Fs9mKEpiihbDtxCZ+
         xEXrAzP+eH9NyJWuvfjw6TkMS9IMbJTomuGC2WUQgaNm1FqIIc60h0mGqu1LWNhos7Ep
         jqJqP7mADUr+d6Kdk7ofgGym3KAMiGI+f+kMIajhdOozBtMPRksVX0zy+kL1x3DJ2KPh
         sLtlCOAOFXMRDhxWpwi57ePgMDwssfim7Mnjoo5QiyskusVHO5MO4mzeF9aHzSC5pYCd
         04CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1pWPxVu9n8DGB0kROP1MQOt+Oq0bthBHWIhkFmi8TY=;
        fh=lhUm9mCb2UW8hzHdT7wWXW91y0azO5XJU82sZzZCgW0=;
        b=Qevcg0/TuRnbL/xlbsuOTC1SRFJdUoGR6uk0xR66sy5jYFTBibn242qiOtKdcdZOvJ
         OaIu6r2O4ED2N2AIcfVnSMEn34DSi97W3/Q/niChT3VJSNlYXsOjH60x2KktJrpyb3wV
         FGe/me9lmaPyXn4SjNoHS5XOPj2+W5nlu8AHQ7MWouITsDerF+sQmKoYphVm+V9kBkCO
         +tEqhZC7hQ9ec79zPWioYYxsE8eCFCw1M+QUmth2HdgmF8MFbdi6e8KDVgYVl3NwgGQB
         QiLZTFxDPsUezCU0f8ReUyIfc67Vda/5EwgS7gGr/MKjQwMhhIBBB9m82ZXe7ebusFlx
         vohQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787717133; x=1788321933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1pWPxVu9n8DGB0kROP1MQOt+Oq0bthBHWIhkFmi8TY=;
        b=C59kdt7LF0Akj9GP+Xnz5g5S0MPbhfRBU8SJr/JkznWPtm2cCVR1MbmpzgzRRVOlK+
         4KuWq0vES1cGGRfFbQxPTUVAoqFA8aSr80C2jBjDM70Fe7s3CeMb8zq+5P3iofuWdokk
         2k19pOQy20RiTMmxzC6dk3DSYTOvEUH7LTC0QZne/ZcVVbTymjGYXaoYzctEgy4kNhQQ
         PjJPkJjcBMLrb1Bgmy7eCMqi4gyORySV2qEZECYq1EtT72wQiPFjBIX+bsKf0bvSqsMa
         cAobMEHhjS6+01FLPzWX2FxG4tp+KEHzSuiJpZe7l6FoVk3Felxaqqga2wR8VDccpd48
         YJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787717133; x=1788321933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1pWPxVu9n8DGB0kROP1MQOt+Oq0bthBHWIhkFmi8TY=;
        b=mjIphltv33JIFKBNHyi4sIf+XWhP0P7PIhXoMkg3TM9CffkM03WNV3ZmpjCFNxkP0O
         ccX7pf541S+bZd+D70mwRiSVx2U6xanhJ4fgFX+/BGHUCFHgW03xOa9uX/OzvW5f0BUy
         WHFKsIHTUJhAvEDR3P5qOY12kVepnQc7GBgHfqovdT0rJX8eizu67K37+e3pvcsYg/Lk
         rhZ/J9L2y7giytIJ98zHRi+IV0I9lHTgZQxJND/Dm9laZaU0Z8fkJrI3VVnz8KyOXepK
         NAEEaRq4cD0THlTvOuSC3d4P3WiVZ6v0AbcleVZS/2WdVr0B3zu0JCO8B7CuXOoC++9h
         xbUg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2LaLX35aYSy7c9Jnv3jgLvi3clNBF0vlLsYahJmm87cOEc8ONqwSQLDDj2HUnNcocNOHp+XE=@vger.kernel.org
X-Gm-Message-State: AFuF++la5q5iI7VNgx9fS/53GdxdLTfWkG5hhx9aewtpQZUFAmjmU3ce
	V1Vb0cnQxJJOFY3y4Lf3ySdqt0xBNlecFx7rn1k6NfsNft5pwOvRzPq8KsVOjE2tT2lZJukdws1
	2O7S8qJdnFRR1CDPlKwiZEFTZdGcw3vw71mRf4B4b
X-Gm-Gg: AR+sD123zy6f1LZKp2oOcmkH1J8WIDYfsWZA1SNDDd5sxM4gtSqjY/UW2ilwDVkXZNR
	rpEV2DTjoGsnJDxgrfifcBNqLrX1U9BQDy1RDEKs8dBoCnlQfvQG0kDCdR78cwWFouQM529QlyG
	i01HP58Z27e7oRiV5xLMFlAJzaxagLMwsh5qFwJ/5Yo21baAZHco4EjXGQ+TwDQgZ5oiByKxq/V
	esGmWyY0/WVn5xYqYnxpWXLsZIV5RyIIjFxqmHLxW7Mn8fxRHeT6sAPwP3KtIwyEyhSnWsxmpix
	JMzVQB7x49m+R0lZiQFdy8WXaVJJLMa5u/PeoQVwyIpiXhxQAU6dqczDh4A2kG7grefl5SYrxXW
	hcYUJ6k1h5Ysb7JrFm5cmYYsixIDUk4EWIUlW81+c2P0MjL0b9FngmH+7oL5z6U1pCg2a8Q==
X-Received: by 2002:a05:622a:408c:b0:52e:3a51:6fd2 with SMTP id
 d75a77b69052e-52e424270c9mr43964931cf.31.1787717127506; Tue, 25 Aug 2026
 21:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ao2WptQpM2zSQHDt@shinhome> <20260826030619.1519-1-hdanton@sina.com>
In-Reply-To: <20260826030619.1519-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 06:05:15 +0200
X-Gm-Features: AcwNN1Wu1dkKOHcJ3he2-97M99qMfy45STm0-8t_nGRaC1etwNp7ddbMXRS3kNI
Message-ID: <CANn89iKEVEs5=K1Uhj_CHagbt+eV0QGernwz9EBFkLEZOB1FAw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
To: Hillf Danton <hdanton@sina.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, boqun@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 5:06=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Tue, 25 Aug 2026 22:26:25 +0900 Shin'ichiro Kawasaki wrote:
> >On Aug 25, 2026 / 14:45, Hillf Danton wrote:
> >> On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
> >> > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> >> > >
> >> > > I think 19bdb70c77d3 should be reverted.
> >> >
> >> > Just reverting the commit will reintroduce the other lockdep WARN th=
at the
> >> > commit addressed. I hope to have another fix to avoid the WARN.
> >> >
> >> I do not think you know the root cause of that lockdep warn, so revert=
ing
> >> 19bdb70c77d3 is the right thing to do because of [11, 12].
> >>
> >> [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up e=
arlier")
> >> [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy so=
cket lock
> >> https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
> >
> > I took a look in the commit [11] and the discussion [12], but couldn't =
follow
> > why the commit 19bdb70c77d3 should be reverted. Could you elaborate a b=
it more
> > about the reason you suggest the revert?
> >
> The Fixes tag in d532cddb6c60 proves Eric delivered a HBC, half baked cro=
issant,
> to lore. And the nvme-tcp tucked in the HBC hints Eric copied something f=
rom
> somewhere. Finally the absence of ffa1e7ada456 in 19bdb70c77d3 proves it =
is
> worse than a HBC. Clear dude? Or go to read [12] again?

linux development is iterative, we do not submit a single patch fixing
1000 bugs at once.

I decided to ignore your rants a long time ago, as many others did.

How many bugs did you fix last year?
