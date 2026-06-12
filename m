Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B53A9002
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295463; cv=none; b=qN1Zwuto1f8Wj1EJe1jg/SinHLX7MaVm4I7nR5tU4nKIXOEUTbP1BgLibiTh7tqbg1n/dDwhkRZNB/VPpLzLaHM/Mfg0Wxg0dahtJ2A/kJPSIW84NoSrcdCE1RuukYe3p3dt2vZdsfbjeG9Wr07Bs3h/YYNKKA5pwWetpHMHmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295463; c=relaxed/simple;
	bh=DQkH0EqHo/U4CmrPE9183vaCEEACVGKox23KO3cOE84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncxn2XBrBsvCs2R+ALBnIWSHyNKMdHHawOhSSaYYHYf5cz+N5odL9/wS81RIUvrgj2x8hUM8yv1OPqyE/gpnL7dF6Z5y9iq5ikVJcPCBix3ip1UNHUM/ner0LxDx9MYJ+io61AYsGLkykzLEhNvnmYVAIzrisTzzv0/DIS6mCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=Wy+fXVLS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="Wy+fXVLS"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1518239eec.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781295461; x=1781900261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gla2bioFzKzfVEt6gQK/GdOcOBavArs9BChjcX+MDZQ=;
        b=Wy+fXVLSVvoV7unMbS1ZOxt6TAixaic/fhUt5z7X7uhbBcgKgooitvOktdBo1h3gp3
         3tKMr7yKAZfNOmXaSZIyE0O0FN5NKrsCI5fJTJLTtv3YxgWrcqVsXF8j6KCGQgbRBoT8
         W03FLOCmajjh+2pUgtvSGWYrESj9/0dCCWed/WCpoQPwv2S3g+TneCVpvHip09Uwj5xD
         nJEBgxb512uCzPZ+AjmQgD42g/629PJTROOS/M8hvwQx8OyC5iTLXvJRQuxnur39qV27
         xfB9YBgx5qxq3o2BS4/AnBriU6ohs1/y252U0Mhxl73eiV56bgJAhgcnyhsJ51UVBFJ5
         A/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295461; x=1781900261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gla2bioFzKzfVEt6gQK/GdOcOBavArs9BChjcX+MDZQ=;
        b=Jzr70GDOwURWx+VY+C2TDFtvMnuM3XUGB7l0ERHJopBCtwiwev2bFA83ErVz9nJhM8
         JydNK/WLAIpLAkh4IElBHrifbiqztlcDFyKKE1FVQJQKqqcnmvsdrCvNSaeSTe9pvdJl
         rehoWvx0Dh40dKC6qpH8+FAY2bx/wlQ4qa+jxd3VG0aDM5ivzGf743UKgIfJd1IGQPA6
         x7r1FV/h/wWiAppKAmDq7U8H4qkabuw5QyLTPutUfMKafMBXGhmbusCgZMqx9N/rVtqD
         B26qzs6nCZzRmdYcuHrwRIZq18ZsajzzM4VMVtAVDv3NF3bnBs3ABspoXHsOBwwOPQet
         aZqA==
X-Forwarded-Encrypted: i=1; AFNElJ9hdvlojZjP0kcDTKB87oi2s4xEJGVlPViF+T6YSixqo1L12BAe2oNYEO48Z+Mq1CqV4IaNaEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTDrKKzXhqk90SjIaF4TFYu5h23iTfFwcFXlLJpRESM0rTfhs
	/BzMi3lnqAnRmgXD19+jbZkL891AexcFROUZA3+9vesf0J+/J0zoT/ls2yiG7ObefVI=
X-Gm-Gg: Acq92OGhIsuZ+jwWY+JqyWh0gYXECMwG/nNUQ+J+x7lu9y81OocdU8gZxb2T1GPPHFj
	Ta0BHvUg0V4mXToFtTRRivDVNG/TPYL6e5rjVD/zJqMxDgNgmnn5ym9NHIaHlO6wNlX5zevBhyE
	I8U56Am9ByW1qg985cTrmyXe9vqL4QFlUyLgkxzaXer7EBlIaqpEV8xYrFsaQMGVeJy+DgmfdLn
	3zYnW6k7bC+sRAWELEakbidLBJrZsiBIMXtyVClq0iLWCYle+77FoOUT3x6Ck5/ZOEjObAO4kys
	5fSx7Q/PrzoQIKUQBKcBkEJVfrQWkhLuMZxyo2GDK3dL1D4DfO/sfMKQy/l5gITFx8ggEmwp1uY
	cJL7jbP3YGkwKBNfHkrbntPgvY86taULWOuYiaUk506Tlbe6GyRI9tR39ERdwxeBVvXfhh7mS9c
	dwTMb55592g4Vmxceuq+th53Kqd/Da1XR3A6w+NAWVLb+SY4exGVpnTA==
X-Received: by 2002:a05:7301:d80c:b0:2df:498e:811b with SMTP id 5a478bee46e88-3081de628c8mr1733511eec.7.1781295461301;
        Fri, 12 Jun 2026 13:17:41 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm4756671eec.17.2026.06.12.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:17:40 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:17:39 -0700
From: Cong Wang <cwang@multikernel.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Hemanth Malla <hemanthmalla@gmail.com>, zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <aixpY3DHpukx6bix@pop-os.localdomain>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
 <aixMETjhANSYBZP_@pop-os.localdomain>
 <CAADnVQLzEopmoR7vdTnno25gCqT99ja3jPaMGUnW+edg9P9Sew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLzEopmoR7vdTnno25gCqT99ja3jPaMGUnW+edg9P9Sew@mail.gmail.com>

On Fri, Jun 12, 2026 at 11:34:25AM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 12, 2026 at 11:12 AM Cong Wang <cwang@multikernel.io> wrote:
> >
> > On Fri, Jun 12, 2026 at 09:01:43AM -0700, Alexei Starovoitov wrote:
> > > Just saying that the code is free nowadays, so whether it's 1k lines
> > > or 10 lines is irrelevant for the discussion.
> > >
> > > As far as the idea goes, I think, it would be interesting in pre-AI era,
> > > but today splice and friends are a prime target for bugs and more bugs.
> > > skmsg and tcp_bpf are reeling from unfixed bugs too,
> > > so my take is that we should not add any new features to skmsg
> > > and instead deprecate what is already there.
> >
> > I guess maybe the name misleads you, it has nothing related to splice()
> > syscall. Its ring buffer was developed on top of include/linux/circ_buf.h
> > which again has nothing related to splice()/vmsplice()/pipe().
> >
> > In case it is not obvious, this patchset does not add any new user-space
> > interface, only a kfunc which is visible to only sockmap eBPF programs
> > which already require CAP_BPF privilege.
> 
> Not the name, but the concept. Taking from one socket and feeding
> into another already caused a ton of issues for the networking stack.
> If you can convince Kuba we can entertain it.

If you could be specific and provide examples, I could provide better
answer and take better actions.

Until that, all I can say is Copy Fail leverages page *references*,
bpf_sock_splice_pair() shares no pages, it is a private kernel allocation,
with no pipe_buffer or page-cache involvement at all. Probably the most
common thing between these 2 is the name "splice".

In fact, it has 2 copies (not 0, not 1) by design, see details here:
https://multikernel.io/2026/06/11/bpf-sock-splice-pair-two-copies/

Or if you mean skmsg or sockmap has a lot of bugs, this is true but it
is mostly due to TLS (which codebase is already a mess) and the
complication of skmsg itself, none of them is related to
bpf_sock_splice_pair().

For your reference, this is the data sheet I collected with AI:

  ┌─────────────────────┬─────────┬──────────┬
  │ Code path the fixes │  ~Fix   │ Splice   │
  │       live in       │ commits │  ring    │
  │                     │         │ uses it? │
  ├─────────────────────┼─────────┼──────────┼
  │ sk_msg / verdict /  │         │          │
  │ strparser / skb     │     ~59 │    No    │
  │ redirect            │         │          │
  ├─────────────────────┼─────────┼──────────┼
  │ TLS / ULP layering  │       8 │    No    │
  ├─────────────────────┼─────────┼──────────┼
  │ psock / sock_map    │         │          │
  │ teardown (close,    │     ~10 │   Yes    │
  │ unhash, destroy,    │         │          │
  │ replace, free)      │         │          │
  └─────────────────────┴─────────┴──────────┴

Thanks for your comments!
Cong
