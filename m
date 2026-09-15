Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581773451CC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480875; cv=pass; b=ZhdkGm0u8pFEztzd1RX2EsaMAHAxB10oIYfprzznLi95i4KLu79t8zy3ARZwtYm5KUspSqW+uV5gr2l0nSZWKkHU9BfPN7XCwWdSrO4fYI+9+qNkI6S/wfpo6HmprZvmY2iEUANiBeFWkPc+eNcV+R2ssLosf+LaUzdiLdmyc3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480875; c=relaxed/simple;
	bh=2NAUNgidQSi9/Ny6AX+R2NgK0jl15Ql6k403oGeK+f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjNQAgLgdMDDXBVoXyB+0lNpIT3NwNt4vcss9+5WcNv3y3xdYOdYZmaLWRREPiUuQaKODF6TTdPiIG6y9So/Sj6C6Y12enkToQZebM0h80jyECWEsvE46AzRUgA3lnQemr9hBJoaK/bp75nYqT/QoMyJsKTSXSfmVzCs07Sl7Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BaQzD9BQ; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BaQzD9BQ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2386378a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789480873; cv=none;
        d=google.com; s=arc-20260327;
        b=oxaoR8qnz+6gGMTAwnN528m8mBbTmNjGZDBBSVBVkPG5gdArUxSozKm2Yod3Na+FwE
         axi2FGuwzF+h6QzSDqTWtR8rOFd/6fpxKHLfdS33/o+v4/7SjTQRlve2I/xQGtW4/chn
         xp5LsjJQfOmm2xCOr6b7mktIuT9EbrW8hHSRvDwrPZne9ZOGHZ1wTr6FolW/ectTi1wN
         JW6DE1dDJ2FtwUR8EX5e5RvZptDg13F8AKddmmkJaTXG1SR8u2bvnk8RkDDXH5Is4XDs
         jKtes7LXFczngMgb707pgSMkXW1ZyJtbZBq7VkqzQ55GVp2+aJxwJlZdptE0YtswKuc6
         Mj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HWEG56T0hCCLawyisL7XQGFOuFmLzEuCnYcRjJEU+8s=;
        fh=vKIV8J8HjoO2xATNTINbNG/WX/BOVynlde8xquD0Hco=;
        b=WC1UyyUfjGPXXzBUZwBHXj8SNzy/rKVUnyuLrrmC/0BIvQrb3thWPeMMUGMWFlw5he
         yt3MmaD1AEAZGEDU9UvJ24+94A0tF1IA88lFtKCz/xv4qcCR0s1aCxJ8fVAhzSwxbxgF
         n71i2ZFf4ut3/4Wv6v/VG80AMv6SB1g7Kor/HnUPQEwjqwj7pQU4SJu481Ev/JffUdEw
         SUlx45xzNYpcZE+IQyJq3O0IXH5rw7jqykHTjw2RppVDVdsr4URLr/0dkO05SPfPZfT5
         hYM+3bwXpiVE1UpX4takPExVk85si/wzS70skYeFNWOOtdgHYoA1quQ/BGtecRtIrqy8
         n1Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789480873; x=1790085673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HWEG56T0hCCLawyisL7XQGFOuFmLzEuCnYcRjJEU+8s=;
        b=BaQzD9BQHNlRZizZgmy3alxCON5V48nhTyJGmWGM448gpRu7MitsNiyNWKw0z2+O6Z
         VeTy0VFOeGtHinmyYQKBlNTPHA98uxeFIAA1DkcbWeMO9dzWu5ZTU4iySUuksGlzR4ne
         1Eq8/YW2infgZdTH3Qp/Bpho4PkNeRG9Asz0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480873; x=1790085673;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWEG56T0hCCLawyisL7XQGFOuFmLzEuCnYcRjJEU+8s=;
        b=WZIvMOPNLytbrbLbmeDCQdknadoXOMdrmheCE3pZdinsuW35xb0WOuYCAWMM29/jOv
         auozQPlTDFd/4YvV/1R0uogoqGo84d5hg7Uu1Q3K3o5TeL8a8S26FiNpove6223Wa8G2
         u7GedHLdYrLlia+iEIW8HbZrMO2tvtb8dSmzSvw0MyyWrMMftuCNbHK0N0KF4RTbkJ4U
         gWmzSv4IMf1MtClcOiNvklf9DSTEyTWrJtF7xKA251Uv/IdapnGuRiNln98HQiOxmoMg
         Dxi6t/EElS/MzoF7SJ+NOCyfBVgawThSCYh+5dRvE6kt+jnsIfU5fgELqxpA1sOZmii7
         qsHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJSXch3EbM8Y4bQ6wMnV8TEsvCpB7AVOYLlf0coq6Z16lEWArMbEsE02BX1g0krFvcbAGLlFw=@vger.kernel.org
X-Gm-Message-State: AFuF++l/p0auRrKhuhMSR4SYrKzS+LYCC/i4TvBNF/0y2cQFSDATMCQG
	FTZTeUo8g+RZChSMHB2iUA0T4DnCH3GocmnBPBuGv+5bhoRW+Ihzs9hTscHxHiJxJTFNmoDYiFd
	MQXzNCxRVNzGJVj23tiiCATHp0oTw5/aSVSqCH3IP
X-Gm-Gg: AYBFou17uKhx5vhiyX7NZGU3AfvYETukfGyp2l3vgwtaBFZqqvJenHNYcgVaJ4N4e0C
	aQsL8U6ddfjAWFMfrzcEI42CKzPK/nOWGIdYdJPCN8SgUBkQJIxc+vZks90AUfViS+lux8B/YxI
	21BazIzOl/njMLV7bEUqpR/xAT/uWNkH0+rrfwp9AD3C8xYCtxE51rKsinL/aklAAIfS++uannK
	DxNOVVZD47rbweQc9147hnpiFipzzVsKmKHeWc7xndjY6BXkkHN/r+aGEHqprimIvM/Zg4Yyg6N
	1NzCptEPzM81+yUce3f5fI60KtqhM5XZbfXqKRQ3gK0JM/SBJisGCzbukNlPftrM4UQGVkKb5+9
	TDvUP+fBH9ZTJ4stbkcPavGK+jpoV2mAO/w==
X-Received: by 2002:a05:6a20:1609:b0:3d3:afd9:6040 with SMTP id
 adf61e73a8af0-3db40746ea8mr17275071637.27.1789480873361; Tue, 15 Sep 2026
 07:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911133146.3440982-1-victor@mojatatu.com> <20260914191108.55a1a4f1@kernel.org>
 <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com> <CANn89i+pkwNwyQF4tRM+Hb1a7YA1qUqdk2tHonUMEycY23j0rQ@mail.gmail.com>
In-Reply-To: <CANn89i+pkwNwyQF4tRM+Hb1a7YA1qUqdk2tHonUMEycY23j0rQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 15 Sep 2026 10:01:01 -0400
X-Gm-Features: AcwNN1UHzxHf6t3mZh8c3sGOc9BYhCflv8qYadGp1lb3dsFLGyvR-vnAHHJkQNs
Message-ID: <CAM0EoMnibuY3=JE7+sTnwiAj8_vSKJ9Wx-rZStXrQmZ2EWXMoA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Sep 15, 2026 at 4:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Sep 14, 2026 at 10:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Fri, 11 Sep 2026 10:31:46 -0300 Victor Nogueira wrote:
> > > > This is a less intrusive fix meant for backporting; a cleaner appro=
ach that
> > > > uses a per-device IDA over all qdisc handles is planned for net-nex=
t.
> > >
> > > I don't think this is net-worthy in the first place.
> > > We have a ton of code under rtnl_lock.
> > > We cannot provide any protection from malicious netns admin from
> > > overloading the machine.
> >
> > That is the one million dollar question.  We labelled this as net for
> > this exact reason. i.e malicious container could overload the whole
> > machine.
> > But it borders on "hardening" (improves performance), so net-next as a
> > target sounds reasonable. It was a coin toss.
> >
> > Since we have a few similar "grey" issues in our pending queue - so
> > where's the line for net/net-next?
> >
> > > Nothing against the patch itself, but if you plan to do something
> > > else in net-next let's just go with that from the start..
> >
> > We could resend the same patch for net-next, the alternative "proper
> > fix" is more intrusive. See attached.
> > Another option: Is this worth fixing?
>
> A really useful fix would be to get away from RTNL :)

Indeed ;-> Right now the AI kiddies are trnding to targetting rtnl as
you can see from this one ;->

cheers,
jamal
