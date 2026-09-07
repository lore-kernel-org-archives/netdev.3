Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2640DB52
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765355; cv=pass; b=f1jSUpfv5ET46xPcBNlrTVUGJ4IIDajhZTvbTCcVu25DYMpQ4FawdbFn1OaOt8spUJu9m78g34Bz2gkWjokWwGgps45fSG4XTu/D7z89fRkzkaul6tERjC1jjHRrqOAKZQWwxKuuoV8KrbB7wCqROs0aSzvntj1kHd5ml0bKEmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765355; c=relaxed/simple;
	bh=leHVZXld9eH9iZDPZ6fIXvSuhv4Lo3E5ocYgQ1ebU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg/1Wi9Kc3SvSGgOF3bEgvuN0JuXYGd6OBjZChQGpVuXzD5b+gcYdmHpQEegArXDqFmO27k/mRKRLp9a+FOE4HAW0evMTQ7KR3n1ZOjVX1nM98eOvCBvxnAE/8Gezd64yVcAbhJVtYKajxQKI30BCSX9j4XbrZ8RPeAhmy7eMjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Lq1YwZgP; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Lq1YwZgP"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39f20d19895so22417261fa.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765350; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/NdXKwVE7LhUSedEwd/Cujgx7JyM7QMrBRu55AmXQUlWgbAhtHqn4i5Py5hspZrJM
         jX5N/6cwA4/De9aSt03XZSjg4wjvkuluw60vhx+PCd2CMNuvRW/kK3VEfAFEpkYPq8bU
         +E2Pv9qOEAUTibNWSsKGKCNuLxM4/KkHzagMqG6vjVV8r/A6eM4aju8PrJL+pecQg9QC
         132o+gb2OJT2SN9Nc5LoSbm2ZBGJhUcTrbBknUZstDqZZx00FdniUNVZgYr6HRNn9Lwx
         W6DtH54m4lXRowA2mHXar4+nHSmrahW8f6tfKzOzHgEbXevgDh/mSJOxpKnxZlN1P8rS
         7kvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        fh=YF8Z5OoqUuN+8xajeZOw1D+81LATu+L+ckxDTkjvcYY=;
        b=LmyQSbSv1E49v3CyFBmdELsBT1hBDvsXlBNbCe8VRSbhsdk/0kMXsvVFkVbMipc0na
         Q/xvgDKJO0Mh+XpPK45YtSO3RR1rnPjxpeP8sLN3nnoH3mQDaFOuASSx7dtRS1yYusZt
         +iZmCjpsLCJ9CYEHfVEQbe1l7wVo31xgMZm5idcIvJ6KD74AKjWMw+kp0MMr1FRb+BJF
         GJwoO8t9ezprq4ehwRFVoS/vjCyXr41EE+cQe4b/jnRIQveAnanrdoekrfXj+lAeb+Nz
         eEuUfDcqR03Z+n5JF2c9aSKta9O3ZqBOv79zfzUE6FoQieLcQ9dO+IGTBAciQhIisTAP
         G+nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788765350; x=1789370150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        b=Lq1YwZgPqRf+7Pxl9disFZ14dqGl/QPk4Q92znevy1bB4ggHV+vi6ltGVKpRmbXSeY
         Fz6I/psXx6S5j5exsaDwFrnRr65fPKk2efBueXG2RcEiQT4NZtQdhs/RsuTa3m70o1bw
         H6vnT+hB1BCqedp6kAOjo4jEVz3PzJKynHawAZ6gCaqVnyUeX7DxbFseqFq2vkXH2NHm
         avTL/6+q3Icf03UjmNMx6EIPZn/XmdoW+ysI1bpzh3l5PgWUKDvbBdDoTuJpImd2TxrX
         JIexykIu2edhMbyLxJzM3O27zDY6wBqYCTbi76dRReRRMy2mvfsIvB+5IPgUwHLmGhtV
         O28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765350; x=1789370150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        b=qCQd/5MKarE6pEA+Ehy2sNaa7pTIdLFlxxuytNOhCwjUozzYmL9lg+h3C4Or0cJRd5
         yB5Dhk/NLLzGGChfvhv1lgzKgXhBBoBhy2uaq5Xl5jYvacncw3JCClLbVhVtvHcMjTXu
         Y5fhJHDTppvsvHDNJaYqKeErn+owAaAEVNLGjbxFOcYsfAhCxmfcbZ4l61a5niclyGVT
         q9ST6JZyxAWDuMFsEWpXz7d0jA8VhyUtzY0Mqdj+7jy6zB71Zu1cX8/NiQabbay6ol9r
         VCWRwsuNOtP+/v2nk2cNtGNsR+5h5Sx2TjPWu98lyeEhP0GzfmFC5P8i7Lk36q3BVghe
         iInw==
X-Forwarded-Encrypted: i=1; AKwUvBwM8TY4hEJo8HZjdYl9kzsgiBo5t30dimaSyDp5VkjSDO+9792vSLpbFXWgTjichGkFIXeYqXE=@vger.kernel.org
X-Gm-Message-State: AFuF++nXup3EaYmHJdDAp0YKe0CChlE30+hpnzSVRQM6u4yIxdk5/EA1
	qs0HqEIrdZrmQFeId2wF+Wabtt1PS8ekOAjCptDdSpEGLOkH5/DIMkOrl/d+ReFCTTNnNQYj7Ps
	dkWrSxNXTE83QZs496AC9fdEbFSuQS0Z4mj+rwcw0S9Y=
X-Gm-Gg: AYBFou3/eVkQWtRwxzS+2sNdfHHiiPFRJySgrynzUT/YJbgQi35YV6LyUe7A8nq14aU
	a4j4RbZfPfW1pKRLTLzSwHgY9i7ILAfyk0w4HbPkDOBV0FNyKc6hdoCIEmuxJrUI59WLPouji4L
	CF0KT+6GGy+TX9/r9yEsdL2VX2Xbb73UpA0InUk4CHY4xGjOOuL3sAKoaKpTGwm7cmMkxrVgDr6
	62HsFR0XhM9zT0kmYObYMQ8nv2BjMPZJy/ttN7GR7F3tmolmC8jPaX2O2ttNn4khpKMAyvOnRQk
	lJ59VyEWztVCXv3kLpGuPIGDsk/inrEh27lRVTHULAXpD0yyGPvyvlJyRwf/p2vFWctRzZHJxWw
	=
X-Received: by 2002:a2e:a98e:0:b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a371bdb9ecmr21466191fa.14.1788765349741; Mon, 07 Sep 2026
 00:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
 <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
In-Reply-To: <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:15:37 +0800
X-Gm-Features: AcwNN1VAmgJsxlkj9OvW4LjLVIy_57TEsN_AWLvPrdkLDxAVfSNlHuWjRZ_THxg
Message-ID: <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> > - bind cursor UAF / dangling tb2: valid
> > - unconditional sock_hold() on unpublished TIME_WAIT: valid
> > - clearing s_num on cursor mismatch: valid
> > - lockless cursor-membership checks: valid as a concern
> > - commit message overstating bind/ehash fill-under-lock: valid
> > - missing note that MPTCP needs the follow-up patch: valid as a
> >   backport note
> > - endless re-scan of the same bucket head: not valid as a
> >   guaranteed livelock; duplicate output after a rejected cursor
> >   is valid
>
> I just saw your patch today. This is absolutely insane.
>
> Please limit the complexity of a filter to something reasonable.
> Absolutely no sane user is using a very complex filter.
>
> Same for UDP.

Thanks for the feedback.

We will drop the dump-cursor rewrite.

A follow-up can cap inet_diag bytecode complexity in
inet_diag_bc_audit() so TCP, UDP and MPTCP dumps share the same limit.

Please let me know if that is the direction you want.
