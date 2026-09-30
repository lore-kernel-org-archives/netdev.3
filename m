Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893E3C197C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750172; cv=none; b=C82WiSmMKDuSvkMnCX5TZHZ8vx+LSeGxg20GFcKYxc5sNOXbSdfGzatYdKpl4vaNPBwdIwmhwP6sEkRlxPiC4qbNFrMDbMapicYQJGHV71Z0givr3pPXPc+8222kpl2mibolJCsv2M/x+vgKTQMcM+ATRNkkbFClg1IE2Q8bM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750172; c=relaxed/simple;
	bh=St98C9XOJF1MaiOhwSWUivKYehVh1/c/Kr60nqGkg9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKnyGgeKqXtuhxhGWWod9cVisn11VgMblv0kN2/lyveV8r+RkGM7CvSi6rU4fCnwWNjh8dGoJuQfXB6IsN/S/kq3yqQP98c1XaiEHD4apITrR6YEycnNTlGzPAZhErxmYPDwTCqmXyZXEQ/kJn6emze7s8Z3cAQ7pkq5mHzo4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1a4QGvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1a4QGvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B81F0089A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750167;
	bh=St98C9XOJF1MaiOhwSWUivKYehVh1/c/Kr60nqGkg9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T1a4QGvnVSPPMZBYrudmzikbUtYM1EDtyb1dyzRnZqV2CJhdJ9ZyazxUr2ZKqugeA
	 jRohcx9a9Z3gufMOVmm2sY1FRradhNqhrvoPs3ZytkqwFoQ3sckWLJYC6rHUrn26YV
	 vdP9wpJeqiZ+p8SOB8BoYSytCFqXPDm8rngGg/8WEviDiFlFH//Sadl9qoNxb1tcGO
	 YZt9QbqXPiyM4TSe4z1CKmKNHUo1aZQVhCpmm/9hZSNIYCaqFsAXTvNEJrunFeV4wc
	 ZcSjXxXbaXXntjDkdS48NY2u648gsrwlX9oAE7qDzi3Ifsuf+mwa3B219C8BcdQBFR
	 w31dMyhbmTZmQ==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47b5043f191so2474429fac.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:36:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwdp9mxDLeDG5e+Wm76bMB6ny7TzTlMNDaF6hbbORLN1sA/V1zRexP9I2gxodzjJed+W3bKHQI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYPTb2qG9QyKDxEQhuqDuy3nViaaZNPmQRmHFMHqGG5r1ueo0l
	DUJDF9o0kOLL4rr/vFE+YGPmJZG3bGJ9kghSZNKVxQyDP4K8xWQ//mEY1rS3KD7+SFW6d6PT8lg
	ZhCCrvCqeFfZVUhKzHiawn+/X62sIxqo=
X-Received: by 2002:a05:6870:8309:b0:485:d1ab:793f with SMTP id
 586e51a60fabf-49ddd52e96dmr525099fac.32.1790750166560; Tue, 29 Sep 2026
 23:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
 <20260929165318.6690d427@kernel.org> <20260929165425.53ee002c@kernel.org>
 <CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com> <20260929191931.303d82ee@kernel.org>
In-Reply-To: <20260929191931.303d82ee@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 30 Sep 2026 08:35:55 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiqgg3ace_Xxx09EPYxYzeVnEbMGDjqpU6GH91zRY1h-kw@mail.gmail.com>
X-Gm-Features: AclHuK-uKvms_X3u7sJHAZ7QtOG7mmF14eK0y3kwiir6f7a_qUl5BeDnT78jJy4
Message-ID: <CAL4Wiiqgg3ace_Xxx09EPYxYzeVnEbMGDjqpU6GH91zRY1h-kw@mail.gmail.com>
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue collapse
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 30 Sep 2026 09:53:11 +0800 Jason Xing wrote:
> > > I meant to also say - I'm leaning towards net-next on this one.
> > > Please LMK if you disagree
> >
> > I'm okay with net-next. Seems like I need to repost.
>
> No need to repost.

Sorry for missing this v2, LGTM, thanks!

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
