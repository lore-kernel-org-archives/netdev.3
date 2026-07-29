Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C624EED8
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292247; cv=pass; b=pAPk2Bu8M0dDs3B8StwkPfsgEl8Tzq3P2+dNq0edqBNB+lCvfuz9IKEUnetimBPxmC9M17kxFdnd/aoLGjKkzqQxvwj93kMMPmg2vdWzbF86dZzwg7kotWeXzOTroivBN0Spguz4MNCRXSz4bfWvHj5n2cj6CHeE2DrgrwJGabQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292247; c=relaxed/simple;
	bh=fjmeDSFBaxICN1Mdf/QwOr3QjNA7gTxVSUsHrdBoxjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucx7cUWvsaTk0DkiD/RrPQ3CArnEI3wFThAFAy0UZB9WnKSAJrZnlADRjhZ9cgP7bFcWh8gNBIwVjsYFh7435hUjx0GnEGAzh9dypwOOmD9A52YUl6olecq1W6GtoS5bw4Zv0QnqzUvg/Y+kN8dn4Chn5fkrSRYmm52kHGqxjmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABZX4qLx; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABZX4qLx"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fdcb13fdbso1036450a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785292244; cv=none;
        d=google.com; s=arc-20260327;
        b=ipEMOvPRLdoiv+IKJG+hqNcTjq5wlck/6jLfFEry40hGYouuGVt42yMrouXRAYDmEF
         Hy2KJ/0fSA/95e73AORwIi3dNVn2GgHurP0IsQAr9cW9dfAfdiMAv9oD71W++1N/Cize
         +1LmFGmE9geJkoxDQ4Mt+qAb0Gl1q96dc9nfSLVlZmnAXqDTB4jsNJWClAyM6a+NJB9/
         ZafB+11K+wMxsXeDBXEpW3OHEWlFMoGFuorPgBAKItzC56INWTn7MxO/wizzcG064Qh1
         N5seknHmGTQmJbwljmq5hKEFS4wnqMXTw+TEJNcM93xcjNf8Uim4UitAVT6UGEyKtg6J
         aMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xO+zbVyPD4T3qE/wL11BePM0cGCMKSslJVdpCYIe0q8=;
        fh=/sXa+4678HeBISqt2jhOraSjkeEsr1UryMd1yEh0nKo=;
        b=g/T5zX/Xcd8TXEt1EmB0W7+Dpqmh7i4cUdtuNYh+ejSPiaj5uGv4KNJ0J0Pm4XZiqd
         3VQstssy7A8NssJDWDMC8pXd5nWMuJDnhg8JvrFGkCQNmiy+T3/ZkqBghant592cZqeG
         cFWYX0dOwl6dsLMn4kvP7/RGJ4wuMCxc89srIu+W/3z3AvjTBd+qQbqoN2gAruRV1mMK
         YxbfnBXn8FMMWhZzU8yOwZi8wJlBCJXq0xrSTths2BDB27pfnqzs8kC7kPrZgCSNsC24
         oVvIpW6hyDAQqW1LGI1je9h+crqjFaGoFuc9f+HpDF+tKcfINtFPGMZ8YgiUwE6hAHdi
         qdcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785292244; x=1785897044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xO+zbVyPD4T3qE/wL11BePM0cGCMKSslJVdpCYIe0q8=;
        b=ABZX4qLxkYX25vb65AMxVLsJ1pXnrBS6E8Kc/4ASpQdsTta3TcMbp4AtAzpJPlBYf/
         7IudCz1EEwNi9bxUHdwN+FBTUJrflHo48S00Xl73dPmfMUX362E6Cs4kW9W7989wNzbC
         6Qe4VyWbYzNiJsMwR9WhtBs7qwXtWOkH2M5Y+xB2d6BuuusPjedf+89OF4fiP1BswUcK
         /HlN7V4eVevwH8fMbEF1YbfE5ksbH2YsXswCbCzgqUzssbg3AoJ+D4JaO/gHGkDVdGnI
         eoMzjO3BSFwdGyDQeSj6oyACmQWZ6sWzyHpg4dVoDa5MdqzjK8Ds1YT6+emez1y+OJD7
         JTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785292244; x=1785897044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xO+zbVyPD4T3qE/wL11BePM0cGCMKSslJVdpCYIe0q8=;
        b=focWYr23eM73ExddkrV6yH+ovMPI9b7HfUxR6/BFu45rYrYyv7lDbCAk5z3S1O8Dv1
         1tidnky5OYsotQRHUP0UlZwZX1Do9EY9B3eWka9nCBNvn8ISumE8da6He4PFuAJn+pWh
         FnKcvKkKTKjC6KrlkVggGTagCoN+NYKejyMRQW036QNr9BG/Acpg8F8loQ+OCkPw4GGB
         tnGMVR1rKe2aNWvJ3spJo20QM4xyc53hpUGxIMWYdHR3Z0TWRvDN8+ZeqQPeeT0Qgckl
         pbFM9iRfZHXdVllg+Dl6GhOeW3d0s+p5tvgj0RJpEvldE26hEFcmJzaozcsmKIxCs9J9
         P/gg==
X-Forwarded-Encrypted: i=1; AHgh+RqlLRLTMxSa5CElkbDl8IVR0C/3ygtyhtnfi6x5ONDlDN2EFqeAzEvfMk7v8BXKCdWYAszmBYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9McMZj/rboQ4XzQF0/EwCQyR+0MZgP1NAIVb3Uq9NLh5XxRP
	S0HBbra1avkeFft6yxoVUwjorT2A7f+G7VswMQG15otrFVz3qsI3P94m2K09LqaM80dNuEz5Drd
	lzLo91rCvLSVWyEly+z0iMdPsNtfqKtw=
X-Gm-Gg: AR+sD13rcXM7Tw2EUQ4Z8DKqg3hilq8DiTX32xahbg6gdBKZKzR5UElt8dkPyrPZ0vW
	jLBNaNWAUg+0Uez0OfgGX7F/YuM+ER4kXytq25gGgwKMWVi4IXnREYH3nrcWmih9gShPzs7q+YS
	ooPuwzABlzyKgiyKHzvJ/bSFqn+KJccha9TmMH0GUQ714yvt1gPIir45gfi4nLemIIlDqJOawV/
	pdeD+iSIQ9GKP/vvCCivgmD6VSsZaL8phGHesgdHANN9VtU4HNJLVotcczmMjwFuCXHBh01Q3Zm
	1Gn+IGU2CbBxLHomxoMpUzwbMKWHWvU21eeJNhFmv5xUHmbGQpobsw==
X-Received: by 2002:a05:6402:1469:b0:698:3b7c:3b2e with SMTP id
 4fb4d7f45d1cf-6a052fcd957mr173743a12.16.1785292243802; Tue, 28 Jul 2026
 19:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com> <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
 <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com> <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
In-Reply-To: <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
From: Santosh Kalluri <santosh.kalluri129@gmail.com>
Date: Tue, 28 Jul 2026 19:30:32 -0700
X-Gm-Features: AUfX_mxVpg2ZriGy5QdqN1sNbku_hPFXDN8lM15zfP0uq9nPhGP4krYEF-iunX4
Message-ID: <CAFUOXOmP_bF+JL6gKsz5usmT+K=O4zFtw0MrCwi5CMxbmKRDxw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jiri@resnulli.us, zdi-disclosures@trendmicro.com, 
	victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

I tested the patch-paolo-mod after correcting the hunk count locally,
and did not find any issues.

The attached patch does not apply as sent: hunk 5's declared line
count does not match its body (16 vs 11). Could you resend a
regenerated patch?

Thanks,
Santosh Kalluri


On Tue, Jul 28, 2026 at 9:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jul 28, 2026 at 10:03=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On 7/28/26 3:12 PM, Jamal Hadi Salim wrote:
> > > On Tue, Jul 28, 2026 at 9:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > >> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> > >>> On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > >>>> Since there is already a
> > >>>> synchronization point for both reader and write while acquiring th=
e
> > >>>> fastmap_lock, I'm wondering if something alike the following could=
 work ?!?
> > >>>> (completely untested!!!):
> > >>>
> > >>> Your approach has some holes, example misses the most dangerous par=
t -
> > >>> destroy(), etc
> > >>> I will mull over it and see if it can be fixed to handle all the
> > >>> issues. I think it's possible i just need to put time to
> > >>> validate/test.
> > >> I would appreciate that, thanks!
> > >
> > > See attached. Untested (compiles) -  addresses my destroy() concern
> > > eaerlier _i think_ (unless something pops up in testing)
> >
> > FWIW, the changes LGTM, thanks!
>
> Tests on all PoCs worked.
> I will give Santosh and Victor a chance to test and will post the
> patch tomorrow.
>
> cheers,
> jamal
>
> > Paolo
> >
