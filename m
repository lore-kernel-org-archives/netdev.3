Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363200;
	b=PZXRGD+ZV7UyihtOD7j3InIEm0FCN1aBmwGUnPYN52HCi7XNb6Jgl9JypcGV+mMSuhvC
	 NZI9udVC7kqQ9NlflxBiQign0oPpGi2/qWsMk0mZgUlYMmeBLWaZlIPMkU479YuNRYkAR
	 CMzg4IdupySeE5/qbJHCnc6d8LfUGfMD7sYtgobm8Z00XrDC3/xauZJNdqbC77pv8xs3B
	 sJgRz9essZFiX9gdy4i5j7oTS4d6FfehYWKKQ6xlogjdBfNu8oNqY7hKEX1K/CtS8fJg4
	 Mu5JOg/tv7glId0Xu9g9g6498YiUBIs33dr4hTpkLQtrTkcovQFSxe+ZWLqEU0RvC9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ib0ZIb2YOYQ7w34USWape/G8EkDxIb1fCiEOQLBLNlA=;
	b=imwh27orIx85qKjJysp5LNdjg7YFtT9G64D4eTdshqQ15kz9NIOiBq9+f+FZFmglwBjY
	 9xOv1QhuYU1mgNRDuqLqEJ+cWfcOe5c83o3cR0RZTKBo//6ztaAxGnj+VOTyeq/+tUbqn
	 Yo93285uvNZcbfbM+3gu7lPvXqS1yzGoEb1jc0pt9Wv0Yboua9w8cB29tHKVPFEMvTrPI
	 JhZqy4KpSNd/PhNGCKBNNy65WqB5j5yhKRimsbcU1vt/7LOhb5deU7CdQ12edFnxwjNfL
	 0VRyObuUOL4Kc86e9IFPcVbK5ljo5F+JKFPzCpSR5L6poOFp7pUYa8YOIAfvP6vY2Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fhXFza+Y;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB0606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69EB0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fhXFza+Y
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso858601a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793363199; x=1793967999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ib0ZIb2YOYQ7w34USWape/G8EkDxIb1fCiEOQLBLNlA=;
        b=fhXFza+Yzy3VG+9OGHMOcR47ihiPebAoAFmsMUY2P6j1pr41QmigtuRDAv5TPC+uDE
         0J3nvWYLFmutTaTKdFz30ALFGAiiWg7cTyjr82gecO8pWjzBrrlyLSTp8j3jYXv3pL43
         xFkN4qEcHAjm2DJwQl7q5XooRBhI0bAl0tueGBxYCb0WgpV8Ybtpi4mCobTc/mvoUD5+
         sZmdzO9P3Ja8qlIWOVILGj0XA2BiBzcjS4Vj+W/j4ZnusyI8UcB9l0j6YLD/mCxJCQzZ
         tj2PheJ8/nEusRkl5R9YusrHcvJUoURwDOSSceCnHGjKE2frWjKllo14yQ/XiJ8aZEKi
         JfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363199; x=1793967999;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ib0ZIb2YOYQ7w34USWape/G8EkDxIb1fCiEOQLBLNlA=;
        b=EggQ3QXz8RRtqYqWCb+ZDgMJS2FhWP80uN0qTISCiLJwaKQNFIin8VPVBtjRAyjv0B
         XLMiuNISUZP7H/VxOI2OjfpstR/1mkfEjH4k4KcrW8Lzmf2bVukC+Tl0zKsNHWqA7cLo
         FX37XzzhQpq65ZtNzRtPkGTUn6iQXshs8bK5kthlXCcW+aAQ8+BWV2qd1QawhMQPp+3f
         WsLvgLI8qi2C1RJLmsQVFmQjGpzwO5qf7oic2xnbFPkD8n679YetVpBYGqBWrAKYgfg8
         APkyJj/u1yo1s3DWgVFLHaGCx8/bBSOQKi1Hid5JuVVp1b3ikdrCfuCNTm3eYhIIVDj0
         W3jw==
X-Forwarded-Encrypted: i=1; AKwUvBwb2qmgb+Hli17E6/Yltzf+9rv6L0KawK1xaLb74fqfQGBLnt0IUB9JVvG8Iui2Vrp8KZfhy9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPpfhL2B/qycC2+n87GADKmG1zT9or0evf2FNJiQ7YlX7+rNDo
	XB6QkgmaiC/PuS0VzZ2Hb91inZdWhfRNLA1yPch8rQ2vY5gbjA9QTjE9bLEcoCOUN+o=
X-Gm-Gg: AYBFou1HRqqWk+8pyAhTv562X+64RxrRpS0o6HKZiWMVJxhGgIJJkYTAFiB9urlXRYo
	VzmSoa+WlxuDH7aicJpG+/iHmbvPzqj/hStgyDRAM+0+qMLjy3n84ctd54jHo5/GJh5RNYZuLuB
	PEA59j62Ea2J4v0v5pUycO/A4wwaAovJRD73C4l7Tlx7wVHQB5A0jFnoTsTRG5mIzO70MasWpTY
	8OW/5pjYBSO3H6GHa1zLsdre5ThZpBmZWEIMCY9QxVrHsUoJ4gtrKn7ztW7FUvCqVVZEXaQGmrg
	qxj/gGK068CtvYLkKtdrDiOBHo8mpdwTXl+nzCpz2DIsMwx0aXZ5yRuZJP4Ys+poz7vbPe4zZI3
	5nXfLolilkBPK5dMWHRcnLUQLz3z/Sz43FlfnXQ1UE/MBXUwZp9OgKbxVFMVEngryCOdKhYI9e+
	t6Ojhltk8vi3x2Cs1SNDIfTgXAPs8HnKKQDWtzbGpmEuH3P+WCiLLktC7ORr69diLYicpDbm/Jz
	9UD9MMidXaedyBFFf4rM44JGd3K/T3l0WwnTAIMA8fYhkWY4dglsZ5W8IH6ml0W97UcN65W52/J
	jaXWPDlVqYrnBwyaq/6CwyRPN+ja6cM5j0KNrvRC6Q==
X-Received: by 2002:a05:6402:c516:20b0:6a9:a3df:e4f1 with SMTP id 4fb4d7f45d1cf-6b4d4c714a4mr1147063a12.25.1793363198834;
        Fri, 30 Oct 2026 05:26:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:295f::41f:54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b3fc5csm540597a12.33.2026.10.30.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:26:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "phx" <phx0fer@gmail.com>,  "John Fastabend" <john.fastabend@gmail.com>,
  "Jiayuan Chen" <jiayuan.chen@linux.dev>,  "Network Development"
 <netdev@vger.kernel.org>,  "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com> (Alexei Starovoitov's
	message of "Tue, 27 Oct 2026 16:46:11 +0000")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	<87v76o63qv.fsf@cloudflare.com>
	<CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
	<87pkwv5cj8.fsf@cloudflare.com> <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 30 Oct 2026 13:26:36 +0100
Message-ID: <87pkwrtlvn.fsf@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 04:46 PM GMT, Alexei Starovoitov wrote:
> On Tue Oct 27, 2026 at 4:33 PM UTC, Jakub Sitnicki wrote:
>> On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
>>> Sorry for the long silence =E2=80=94 my laptop died right after v2 and =
took the
>>> local mail and the working tree with it. Agreed that the ordering fix is
>>> the right one; please go ahead with the commandeer, Jakub.
>>>
>>> I do still have the reproducer (a KCSAN selftest for this race, verified
>>> in QEMU). Say the word and I will post it, or send it to you to fold in=
to
>>> your respin.
>>
>> Feel free to iterate on the patch once you get your dev env restored.
>
> I very much prefer if you Jakub will take it over.
> 'phx' is a clueless bot that sends spam across all subsystem.

Fix now posted:

https://patch.msgid.link/20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com
