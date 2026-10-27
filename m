Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793087068;
	b=ubgeU95x7Q88QssrvS/gfyvgxEZAsmU2wE43pkwAcwM4G7XM5UrYae1MEJMGlC5iL7KH
	 nvZhQQbom83LDJ8cOhC9qucYYBGh8ujGAw9vAbC+7ixRXxI2Ns5zY2eQQ3k1wTQj0TERF
	 SgNvKrrNt9Vhut88pvZLPr2wMdQVDBNMG+72s02gUSc7W/Zmu23jTsEl7SdnbRg13+bxg
	 KTx19FZFEGKy4dAUrv9q6kGY2P307AgbQP8Hq5xJ/1I/3gWbiGsq0TtzFKTx6C9GBqmRw
	 AObtcfbGjLZt3RwBtgtR7dV4BC7wClRnuEq+8OIBCRbTvY6UXdSKXyyxRYFhj9xmWLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
	b=Nutb+zzxqsPPDe3F+XhDTn6eBRIOdGSY4TWDMMT8cvKf6IiISkfVKcpBtbKnQmP1YlS0
	 Re9iq2OYmMuaROprmk5YcqyPMdz0phAsy+k1nj+Z2nwzTwguNKCQzju1xQsr2gTZbjXYb
	 w4lxvKjo1/+Svxej0xgLFXA9UNMDgE9Ky6hUyAIw26PUJKrMOEpTG0L6CIlBkswJqifCe
	 JtvvnO8Uz6bawNONqFKJAk4JOPy/0v/8Xy3m8Ty9twNBXXRX181NuZAkhWPWdmsz+M+mH
	 7Un9Bo191KwVq2v63qQMGTFtWcHB2ZSlAmZincHhVkhAJJcBzmurkZTbufcVW831s9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qJtaDY7u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E044606A324
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E044606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qJtaDY7u
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070781f63so1433721b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793087067; cv=none;
        d=google.com; s=arc-20260327;
        b=HwH76ZdOBqwSUISdTd6oQ7G2d7ttfaXm09jUZTNa4IAyvB3ffwhaHfQcAYeWMroaOi
         GRhfy7misl6pdP8Iv3sGQTA+MVNr11Tnh+rjCj08FITOvoYNOfe+X8lLwVcqRBMS+41L
         RQ7lD8YTWZv3pm3wiGCRUOxZ0D+H5cyG0rqFIQzN2UwfHhTwO4ZMFNdvAEJE9i/VXgsF
         baDr5YD4kK+WH6F7vzXlJSCvGU8PEj2vMzo1xz8mYfSqhR3fwqJ+HXluJ5sclffVV/4Z
         SdGeXRWqaM4t9+2NeIrP9ecRizTS3ZhcPowm4zJVviwOt/iL/M+sj2P6dI/3F+LlALyi
         23Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
        fh=YNBqP3tr8RhEQ8/+zQq/2zh5oR3tvYkFPYePmTCGyv0=;
        b=UsaTTg8cwELzXn0UdS5zN2518q5n8c4yHZAeXUtRFbuHtUc6RknwHi2xUg4qdEP700
         uu2EM6f6MX3Q0VLdA5byAwQLodBAJSZLjFiLH//hbW4++y1V3zEIeMPT4w5wfGkQmSO3
         iGGIAc4tyufkdgPxrWGmFsDZ6TMA/y036OwfIQxSIgPzS7lR0eOqyj2lnk/CZJ14ES6x
         xXgG1Fz4OihXvCm6NVoresboe/CtnkB8O9y/qZ4NKSX/j595HzxZd/q5nwFn9pXnA8VI
         qyr5nhV6NaMWLx+yG8T/qVWSpGjb2e71lFYy9WIzP/mExbNFpY857H4iQ8qcnUnlIjjc
         sfig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087067; x=1793691867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
        b=qJtaDY7uRC/Jp57961vqxucRI+RXzzW+zMjJumh4cdp7WfZ9iE+VyK9NW7VuxMGQSd
         61TLVdOaXpjCHo68NPRakgDUnx/tmIq4fAOItrVGC7kmj3loIie79w/o+vzW9cL06oJb
         h7W8hhdk/dd76WvA0ku8XY7QfLjH3XSpvrndw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087067; x=1793691867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
        b=ft9UprPKs40SSdQLLQbeVOprrzhgAyhtgVT3/2uvRmG4JrI2YApX6vLE3MLkzbXQkU
         AZXM0ZIzWmzHZxenLdBK0ss/otQcz555JGjQSd9QQ3nQ4EWn9C53w/om9sESAZRBYA2W
         f2haEDS61MJZX90jEFIlCbN7+3CKQh5G86oywxeUcrxm/anIc4WUF8PzzQc+3b4x9eBx
         VuR/AzHWzbkyUIweekrJYwjOTrngvc+kIaTuYG4cyEAtCdc1MAkYgDCG9BE4/gzeXg6L
         dIxCoKaZCAV+HA52AjjxQwtYNUtUeFmH1SjK6epxTalOd3IN8niiC2zOa2pT/l5iSpds
         ixYw==
X-Forwarded-Encrypted: i=1; AKwUvBz4M7TPv1SDWRxhET/6+kqJi9SFpC0MTEKtJQKMTfZKXtOc/kD82hN0rXoIUuwrZ8NWTXFTGaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0LaCeDAjLUqZ+64PvD3Rlui9eLQGolttqmoDV77xeLOPKJ7Lu
	lKBfKOsV71rwz8LGcZ+98cyDAqH8EqaLzo+tLksFWtA1RKWlpdDldIgpnGy+GhZWiTGUIyVHs7Q
	Y2hcci5Jz2c/9PKjkAr05YQpGZffvLSofWqcWRN5s
X-Gm-Gg: AYBFou2icMxFGzhCf+vEOsiJI24r6WEROtHfZVE+TYZFeRVU9++dyOBhk7RLpd+5g0d
	tXJVezDDZISBYcC7QfoGrxWaq67ch4Gu0OJhuGPJ8Trx/ooIzNTDZsdl8JBXJY0O7O2CuhzwMKd
	zYn584nV56oLXZjaonFbJMI/Ia0IPRh3z0xtokTmtx4h40tvWZrDr8QKmvdu4xAdnCQkapFeAnP
	7IlglIc4JKDd9PY2UzlCUWn9+x/X+BNnXORVJLj6mJpW2rSpxU2pV7KbIareMcR5zjxgXypN2rf
	aSR1x7GRD6v1pvM1x8N1LFMDHYpwObIKKvPxBGMp5q88lXDvX/qLT7yQ83l+2bzqPVHmJ1q5g2I
	uAXmupoOrUNbPqx/qIhnWZQl10EJgjErCpAKhV1Je8ncHRQUC39cWlAfTXvkxcYKphMGkqtxSLO
	5ziBQ51kEorrBR438=
X-Received: by 2002:a05:6a00:1c9f:b0:8a0:2344:c44b with SMTP id
 d2e1a72fcca58-8a369072aa0mr6446296b3a.40.1793087067623; Tue, 27 Oct 2026
 00:44:27 -0700 (PDT)
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
In-Reply-To: <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 03:44:16 -0400
X-Gm-Features: AclHuK-XU17g_8FeeLG5wHtsmEQGCourlsQaD87psYPdRxXdqk4bS7ynbQ1_6E0
Message-ID: <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > This is an AI-generated review of your patch. The human sending thi=
s
> > > > email says "Hi Jamal, passing this on for your consideration as it
> > > > seems to have got stuck somewhere."
> > >
> > > There was nothing wrong with the headers this time - so not sure what
> > > is going on. A bit frustrating.
> >
> > It is frustrating, you are the only one with these issues.
> > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> >
>
> Let me send a repost3 - will take the opportunity to pedantically fix
> the commit message (no code change).

BTW, checking i see the threading was:
     0/2 cover  (root)
       1/2      (reply to 0/2)
         2/2    (reply to 1/2)

I checked other postings that didnt have issues and it was fine. I
also found the approach
   0/2 cover  (root)
       1/2      (reply to 0/2)
        2/2    (reply to 0/2)

was fine. So not sure if it is the threading. Likely I have to make a
change to not confuse it. I am making a commit text change this time.
If you can please just apply that instead of waiting for sashiko, in
posting 1 it didnt have issues with 1/2 commit phrasing. In repost 2
it did. And i am sure if we wait for it to review again it will find
something about a code comment or who knows even code.
The pre-existing issues it complains about are what a parallel teql
patch resolves.

cheers,
jamal

cheers,
jamal
