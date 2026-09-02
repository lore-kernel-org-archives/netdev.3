Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666233B2FC7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359219; cv=pass; b=DZDwKonyZslcWAXmZJnbCtdF8QIa+koa2xLgCb15cnN1G0f1ZzeV+AaX66GN6T0cjKxw0DpayCtvhEmp34LLPa6A/DvD9Yx0ZK/8RK39GveGoICWnG9WJZapXXn982Qlw3FsK8VueoG/FS4JoLM45aw9dVjaDfJNBiW2zQTLiDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359219; c=relaxed/simple;
	bh=F7cMAvRIjL0nUwsv9kBZ1UgXriSkdgwgovqaLz3rWdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3GXVkeRxfDCzKPmJcuVBIa6deinqGstudAJAni2V7qdzbtvuGOJ1zrouBpAkl7jlU6F+dN1QqQ96d0QTBxjxP8hHA0+Qf2a1Doi0sgxPjMPF0qYso0XqAbcACuBBduSHb+4kQI8QexIghnAV7nHEeEGMEoQo+bmQLoW2t2VOl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXKGfz79; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXKGfz79"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5218927884fso16946031cf.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 07:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788359216; cv=none;
        d=google.com; s=arc-20260327;
        b=oGCvh7OXyA3KE2nwl71RdW/95hdS5RM83zYuDMaflhQH4sY/2/fse91AVuW07DXjdO
         gl+zBz1k+NckOl774ajPAvdiAm0aS85Cic9s85u4rlUfp7AsC3BDB63RCOQ7095TUEpb
         EX5jKy9mKFWaaFOiLgcLpE2MyaI0CLvyTx4C+R+o6xLsLyuTfYCFn/jdp1lUmYf4Fre6
         Hz5vmlPgF+e5NT6ntXerqkpBDmazQL2AGF/OqkKcqtKrjEXGAyx/xiEGfn4DDOiRnLzz
         34g5KCDouzy40GxjzaUQGG1MpUsbGu3qV/H4vYbVX1RsAMAasVfNxHFhgBHJ7582lcul
         uLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l9gYycQMUu7NhAOY65WxyfsF7dFw87l8LexzeO9K2xg=;
        fh=AukeYB0QOsqywlJ4iWkAnO6L+/H3Jo4TSzBag9fEpZM=;
        b=XdoMwni60cCz6HkrxSsqsuWUAjeajVm2Lu54c3/17BLEAa8kfSasZyycgipvNTnJlm
         xLw6rzV+xJECfwYNLqZVHwjCxgPUQJqHY896Z6d0qFY9ZHhzz+t49+9wsaBmEc36j95j
         RsJGHJnE8ZZllc0DTOotBbCL1f9GYHyjVfsXE6bHWg7HU9FMVESv+uwHlYG23D9CcP9X
         lbJKx7g9ui2g6Czo5EnuhsJxEx2eAD4fFH3k+rb88plxhxqdJfzcEsJS55FwN3ZDDf4U
         i8EgnPIQHFZ/BR8hS587DLz3SMM4ZQCP5tChlJFqZ17wXGQk+h7s088J0rzlOo/rfnPd
         uM0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788359216; x=1788964016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l9gYycQMUu7NhAOY65WxyfsF7dFw87l8LexzeO9K2xg=;
        b=JXKGfz79mYhM8r0w8XlDcjF7dqHet5cHXRvGUi9Dpyc5X+CfS7kJ5haMBgjJDJ8MN3
         pKdjG6ViVXY+O1XQ4MKMiZpk7OXdQGBAWFfPagijOaDtWXr+0BhlKjS2pvqjuhNQQ/Gv
         hrdaVDDBrPCcHlerOgjkitf12b+zEyGIvl17+WLyhthvUv2GRlQUQk9V1Kzed1XmXMCi
         crsWPAlh2Go4lqNB+HT9h3AdWeRrYxX3JBGuWFeJ92pVFASTyz8ZBSbMOhXt83jGRFM7
         uGeMLF7ZmpE8GRJa+jIig4DcKjSE8bw5dYRGKvAGpZXUibGIWhkr/QOMZEYZ8hdX/aer
         u/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359216; x=1788964016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9gYycQMUu7NhAOY65WxyfsF7dFw87l8LexzeO9K2xg=;
        b=Ea9SA2dA54CFkFa5w/9Ri4/4xQRL+k4+DeArKJPpHumUS0DkUNI3dWCvFpR469aFjM
         hYmJUgIwRxWLyfzK4cWrMWeAj7lh8TJaJ48iLNnvb9PEN4q2Jdz/GFUqlIsVKg62vQ16
         u9DPM5HNtP27asm+JRnVfPpMRnftbspBm41y7hO8M8NmqqairGFb7a9u4XPsT099X9uZ
         VED7tSWN0/btHFs/1pP/Vovm5cFHJal1XOBz2YDa3PCXMziWCuAPuu3Y6tgSl4BWovlL
         wdMmvOGGEc08Bn/LX2ZBgtym+8QK1rPpX+ArXw5mczJmXYyomLZFLSIu2vcExwoNCbVN
         Thmg==
X-Gm-Message-State: AFuF++my9GIKYyX4g+8GiXpn6ctwwfllg4TgKOoVBXOdmQXGDgnuF1y5
	hk+MX6Jp9S2E0Bxe+VAXFE8EWa0ON3Ll1om+tfb7tpUelxbXJTLAziNWWf/PH8btziEv42Tj2lL
	IcEGc+XSl3F304Dn/SNGmb01uJabQ9b/s+2bZdUZu
X-Gm-Gg: AR+sD12xB/AD3+GrBRnquVT7BMAaqvjscS9fhPWkEafHA2Sz3+oIMW5SxrJqPt/DFf+
	CitFtthYigygf8LlIGk127m9ZzgIK8vKHliZprxbP94BpRdUOjxN5cxZj98Skm/89oWGLIy3sTa
	RGJ8JlSm2OjVgM9JOteq4aA/JXMOvf9t2q2WNi3pLXGlie3fyR5JKRHP9TPTg7WykZ6434Bgsrb
	SMjp7mD21LzZ9yXIxSPELtY3f/NUG8uo56lg2UmlgeEzT+O/DG07oKycaFQAbtf7gwBUx42nUdt
	mvWuAj/Du00OotQLw3xMLi5s885fPe0VzBXVC5A22Vehi+gqcU5DHaFEbXSBUQwuiDGvwRpUieJ
	E3Bdpi/7Ix54Lc75p+NDESZF2fbLGeRSKpsJghD6QvswaYxlg5qhk4bo9DMPC5GCrldWk
X-Received: by 2002:ac8:5748:0:b0:52f:f59f:2b2a with SMTP id
 d75a77b69052e-53036d15de7mr55895081cf.32.1788359210665; Wed, 02 Sep 2026
 07:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
 <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
 <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
 <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com> <CAM0EoMmB+W6gkKpWD0JNXgxK8=9U9CiSrP-rEAE52KADvq-TQg@mail.gmail.com>
In-Reply-To: <CAM0EoMmB+W6gkKpWD0JNXgxK8=9U9CiSrP-rEAE52KADvq-TQg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 16:26:38 +0200
X-Gm-Features: AcwNN1W_C0hNxg6_USaPe8Ri3FrNNTga26i9iiUEzbv-KnCsWP0RQ7PQUcMGdoQ
Message-ID: <CANn89i+9M++rSRRVrNpgzXYCi+hNDBXjYKBEi1H5gEJ2oF2+GQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Wed, Sep 2, 2026 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Sep 2, 2026 at 2:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > >
> > > Trying to understand your concern: Are you arguing for
> > > stylistic/readability improvement or robustness?
> > > The only place i can see where the multiplies you describe could
> > > happen is what the 709f34f7c28d patch closed. i.e this part:
> > >
> > > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > >
> > > IIRC, you are suggesting restoring the original logic (x2 and x10) an=
d
> > > i am likely missing why that is a must do? Does it break anything?
> >
> > It does not break anything; it just causes a cascade of various clamps.
> >
> > After your patch we will have:
> >
> >        mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> >        q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
> >        q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> >
> > So @mtu is no longer the psched mtu anymore.
> >
> > This is fine.
>
> The u64 variant would read cleaner for sure.  If i didnt misread you
> though you are saying the current the mtu-no-longer-psched_mtu
> aliasing is fine. So would it be ok to see if any other comments
> spring up from says sashiko that are worth reviewing the patch before
> I proceed with this? Or do you want a v4 or a followup?

I think v3 is fine, thanks.
