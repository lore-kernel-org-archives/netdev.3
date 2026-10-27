Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135043;
	b=dqLMN/j7yoXMiP9LmTeVRR7yDTJPbBOpjAwUR/2ThQTG9Efo1nOGGX2y5gqTXYtIUO/B
	 8Pe1bsJC64dSlphKpE6r4NJImXzahMTcyePqvtPJKR23kK8PFpf2HGPNgoOV1tP3ytqBE
	 8857j6wW8P4K5cYJ9x7nMA875pvB3j07pHLBiSWWR40QR8njGdbFd2UxKybuCbnC7siwR
	 KjZXQ0NpwfFxpc0jUevTX20WrbAnKBXM66iKlElKfy+yqJbOt8d7W4ncSCRJVrHlyEm4T
	 KyxMRRdogKUTZzYifsqYOCWdldbWouIeNU9i1eIdoWstB3B4i/moWngH3CFnwH8sjSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
	b=QBlNE9JCbaqjGhsirnW8xUarSaJqxRWGlJ6/RlDMM4ph0Jrx+hGP0bqM6uiDr19AaH0Y
	 TmSvRMAEdnd8JF/+RyLRitFstLznzUNJe7sOONSvxkX83k8fOEiI9wrqc17ojTYL/RX1d
	 uM511bvuprxhbtRCQ6PrfGcrsEmCdrKGajDomfyqyC0O5S71ZBi5SjhzlQXh3/D52JL0v
	 4EL3Ived3Wdcw3e6Fotw+KDBJk09Pr5xQnP5v1gfOh9vghYKFo/z4NlcGsoY2A2tp7bnq
	 KSPcLP3gehFlhIFDSeChMfRoJ60TkTjMfH/lR8oB9OyyJeh0ytjCmSxnXFgCzrnwnfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=vM069MxS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AE606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=vM069MxS
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so193763b3a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793135042; cv=none;
        d=google.com; s=arc-20260327;
        b=f8Jwf9PKu6/Dcw7gQHUIebHAw4vNiyFpJAEdcdh5WotCWr7LCJdC2y7l4DGrYizpSV
         Q+CnBvEazvBc9owKZAi3C7mwRFyvILLn7VLCCNpHtstPOOL0qDApZp/apDRbS1W/qrU0
         qgFlRNspp+8eJWoxVdpl7BAbTC3bzXdNUfoULLE9Ta0m3eOY1dl8+Z+nVJtnMUKMhw60
         G4yro4jcBJ+upRFT3LOHNNV41VFrZ9EARnce91+4IBXSZMF2UaIwqXt7PcjP9fDs+KGG
         YrsYJEwUNlxpYmrBcka0DiJNBRb+qZ5aO9Nksimshr6CBqrVLAa+Pwgxd/szmMn1Sp87
         t7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
        fh=ldQV6ef01Kr+k4bhEzDZOMvRuE1PWdHfndf7Yy0JHvk=;
        b=hZo0AmxP4uz/t5P9i2aQs/m05E80npkNlqNj3Uo23KMG293Kj+cqM81Utv2OC1E3sc
         OnIa5FnnHIH0lxK4KJCwd1Eazx7dCq29wttxM7S37SzgaxtkVYf6B+wASrHs0HBDqiFA
         5c+hSRvGKQZzMZb4w3Ytu2ns0VltvxHUSlRrfOCl3HHvUldK629++fv4n4i4c4BpUG62
         ZiHwPJBs5kB7EXy/gSInm3xdTdycQO46y3nKJSLv9BH778YxkVqGAYEIdEdnxg4pxgzf
         SThLBGOaL9oCBpDw5TnWVdLirgrT310RvXAkQk1nEIHm0r34WomEP9MItHadqQaJJzZx
         LcBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793135042; x=1793739842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
        b=vM069MxSM3jdj5X0BIYcB/sD/jnq7gSWYs+UECV3gLTfTKR3XywdrBrbbz9iI/ruDn
         KzKcXlNG2jvCwBtEmmBSKfMh9efBeEOOweCvT645hceEEALXnwmyoiuhVOuhf9Q6Zup8
         wHFktoce2QRLLZM+7zia2TF6OUGESgAOriaZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135042; x=1793739842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
        b=rpUntvihkKnklWhVqigL3aUj6YHDsVijmaCf+jZweJVBgkJTEmaj4e+yxfe7kE8BBO
         XGj6T4GBGbo4Lp9iQZo8zrub8sFuGG925eJYL9oASRKbWg0J/Sx6QRIjT28VlIg+Kcjs
         aZTto5QjgLOvqhrk3fEED4rpeSlzqXuwYpzLO69tarZnHqf5ChIGtyrgFCx5gcJKo7vF
         nj5IVbLfv8YFjrMLDiSQKKfJg6aQXJ0XmfX5oOhmmw2mnrqgRvvEwJIDDfWfhoBcmT7p
         hA9JJH01xsFUORpZrYlrIyIk6lu1M/by0HAZAs4fqeyyDLTQ30gvO/mGWq4K6xcfzrQ7
         EPLg==
X-Forwarded-Encrypted: i=1; AKwUvBzjLRCKWfQdc5KysVIsldj6Faseh6h3zawI0H2LxCh3DfHnWDY8j+E1rK39MccLcEgN8S/Qn8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/Pq9U3tBYsyY2tG+A9e3BqonUgG3QFchihXlCV6dBZAGa+88+
	TgaKqDJ9KYyzHnROvl+MIzZfyYNm3tFH5Tpc5yPO6VzNtK7xgxYIaOJGCpoTJX5AaTyok1NgEOJ
	HnWpsfEi+E9ia0KW4YyL+I2ff+5dXvftbskMIAzYMo0GTnS4rc2OuJA==
X-Gm-Gg: AYBFou1UToTxNa49xcKoLR8zpletxRwCaf20NiqVc4GNssd7yrhwMOfkD4chl2Ez0y4
	32QbJwyTN9L865FMO91PG9y47pJbM9KkmrlpqAdF5GqV3sINOoVFEIm3C0SwBRLD+U33XLLwpbT
	XGTQnUYBZLKAtBntusa+ir2swRJyH3XSgbySRSJOzzX+E1wINjO3lz3sreZhiaVk/eP9NZtq6F6
	UyRuP3iBrqo72Qcut/Pv/Mnpw95UtvIdAsfUsEj62PMSRET+BRZiFACl1fO3f9ZVoqEvW9RunON
	ICuna7mOlU6ziLS8F0/otZdwYmTqYfNiGJGfzVIho+rEeBTp9LnFIA40DTUUtIA2uI/2y9xZmJt
	X7DbyIHTkec9zyECGl+mdFxE52406CxdPoabOHfXAdWtvACrUJ88+BCRFsPYSFdfpkCFy1v63qw
	/S+cbOU1W4aWyi504=
X-Received: by 2002:a05:6a00:b44:b0:880:973d:597a with SMTP id
 d2e1a72fcca58-8a6e7fbea5fmr385656b3a.53.1793135042355; Tue, 27 Oct 2026
 14:04:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
 <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com>
 <20261027182905.GQ257209@horms.kernel.org> <CAM0EoMkym=CiT5=ye72N4s_zat6GF-ihN-Mk3hpY4R0YgAqFGw@mail.gmail.com>
In-Reply-To: <CAM0EoMkym=CiT5=ye72N4s_zat6GF-ihN-Mk3hpY4R0YgAqFGw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 17:03:50 -0400
X-Gm-Features: AclHuK8WDz-9m21Tu6ynzCQN2XEQfhMrL7hiikqLic4FAAUgXHk123CAgRhBRy8
Message-ID: <CAM0EoMmXWO0BpKbngHNSUpdCBO1T9+2UQh27KD5H6aX1a+-DzA@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:45=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 2:29=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Tue, Oct 27, 2026 at 04:04:34AM -0400, Jamal Hadi Salim wrote:
> > > On Tue, Oct 27, 2026 at 3:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kern=
el.org> wrote:
> > > > > >
> > > > > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > > > > This is an AI-generated review of your patch. The human sen=
ding this
> > > > > > > > email says "Hi Jamal, passing this on for your consideratio=
n as it
> > > > > > > > seems to have got stuck somewhere."
> > > > > > >
> > > > > > > There was nothing wrong with the headers this time - so not s=
ure what
> > > > > > > is going on. A bit frustrating.
> > > > > >
> > > > > > It is frustrating, you are the only one with these issues.
> > > > > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > > > > >
> > > > >
> > > > > Let me send a repost3 - will take the opportunity to pedantically=
 fix
> > > > > the commit message (no code change).
> > > >
> > > > BTW, checking i see the threading was:
> > > >      0/2 cover  (root)
> > > >        1/2      (reply to 0/2)
> > > >          2/2    (reply to 1/2)
> > > >
> > > > I checked other postings that didnt have issues and it was fine. I
> > > > also found the approach
> > > >    0/2 cover  (root)
> > > >        1/2      (reply to 0/2)
> > > >         2/2    (reply to 0/2)
> > > >
> > >
> > > And for repost3:
> > > - 0/2 (root)
> > >      1/2  In-Reply-To/References: 0/2
> > >      2/2  In-Reply-To: 1/2; References: 0/2 + 1/2
> > >
> > > I am sticking to this approach going forward.
> >
> > Hi Jamal,
> >
> > It's unclear to me if the threading relates to why the NIPA-Sashiko rev=
iew
> > of this patch-set didn't propagate to the ML.  But I would suggest that
> > however b4 handles threading would be a good approach top copy.
>
> I looked at several patches that it didnt have any problems with (some
> merged already) and it doesnt seem to care which of the two approaches
> used. But i will look at what b4 format looks like for completion.
> I am begining to suspect it is not the threading, more the repost
> approach. The "repost" was not including any code or commit changes
> and it seems to be problematic even when i changed the message ids. So
> likely it is only paying attention to subject versioning i.e vX or the
> body text. I added modified commit text this time on all 3, so lets
> see if that fixes it (caveat: the Vx didnt change).

I dont want to claim "mystery solved" yet, but Simon's forwarding of
sashiko for "[PATCH net v2 2/2] net/sched: sch_teql: fix
use-after-free on lower qdisc" triggered me to look at the sashiko
site.
Sashiko has some "email_status" field that is a per-patch field.
Both patch 1 and 2 of that series have "email_status: Muted,
smtp_enabled: false." which means the email will never show up even
though the review has happened unless a human forwards it.
Likely a bug on sashiko or nipa - after the embargo was lifted it
never allowed the response to show up on the list.

cheers,
jamal
