Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495647D448
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036711; cv=none; b=gEwORPfRyajVBEloW4Fq3wfNeipaCnjwE2VmGZyzHbOxfv3BwX1OpNblZ4jrYUyn6m0wyhL3ARnCb/4kik8WJ1g25m1Ppa1xuOnHYIqQtf3Pcvsw87KI7kbuJsr8BFCqetZVtcJpUHBdqHED0uUH8IpOjcroWwmYW16ESlEdT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036711; c=relaxed/simple;
	bh=qvL3nCCpR5lk9Hk8P+wRnrAYaQeYlVNsbJ6hCuqZZy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmGy9S9I3QdKtjBXCt0lAJVmYFIrF05J6HAhVaI0/lJUKtVHvreuRxQIJL81UY5jQKVcWut9o6CSjULEsvjKpc21sQ/08Nmfu+E0LjzgOggpfP0WXWDEWWVQlA7c2Z2GrHwaaKAeN4/mV2grH2Yg3d5sZCB8uPrRgMagEzdXxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6e+eXgU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6e+eXgU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso24678915e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786036708; x=1786641508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qYLZD645akLQlKnPufmUkf56Es45Q9w4M4KndfohRRc=;
        b=E6e+eXgUyt2NvGqh9EdDDlz5ZS1wkeDFgCH+T5QzN2BuTVhgdoq7+njAHez+nlhGHd
         H4q8BdQXh6QV8nMm7nlVsI15ztmj9/tm9cTD8AmEu3+OQ6XvCu9ndG1U9RaUegZ1DktF
         ebx4wTO7CHVBc8HNd/5xEwxX+Ltn24fl089y5x2ZimboFpylkVGzSU2iVLre+vHzvvM8
         g067JLs+Sbd5Y1TD65jViwVmuaPbRrBI5b4wSzifS4kF+qsi2nquMY86WZjFH5IgQFCr
         URtYZ4XqtBAkKiQVr34bMrc5MLEv2GhwRB5ywTwkn4wA9bquHVLr64fXXeZN8IUSn7Ah
         c4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036708; x=1786641508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qYLZD645akLQlKnPufmUkf56Es45Q9w4M4KndfohRRc=;
        b=fhUnoVWH23W5hiNrUc8H6RHRl4jU6xm28RRBLQK3kK8OTAXBuUKGabmMVtETdUPIo8
         lW6kWPFOLoA7x8nTkHToVNzZ35b1OQxl7f/ZqnJ3GUv5R1hqdGqG81GBUKrTqebU6487
         jOP5LNqLhLZTSKZaSONhBe63/2MoxsGzSC/0DLLrD2gWVkLYXimPMKCE9dX/4iWWFWo4
         FQfAtfTGN00sZc1zgR9fuNsl4wWz5doNmKqeSLPx5cqknOdbVztQmKmcp/WycppK7cuu
         A92cb/veVlNNVheHwXZP0m68T8RlFvW19kc89C7E7pyeta6Gzno14lzeSa9piBPGaToR
         xBrA==
X-Forwarded-Encrypted: i=1; AHgh+RoE6TUWRNTmi2njOrAgHvv67qTQOn9oK6NbDZVwdkwniefcaHRYYWvcE4QfDxx2u21pdfN1dlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXK4F5eKvucg12yA70JMaF8ORhjX5nKYrXrOu1NSrSgRyXeEhU
	CPPE0ITHYMC+SREQP6dEuQZqwjPdC9idqMo74zsN138Hk2y4OCce7SOq
X-Gm-Gg: AR+sD12RW6EgwjvRhRJOOgwCdtWatfQWA7gICKXmuMohvfa3aKoI5esr0FCou1UdnGS
	3EHvVcfD3lO4S8HBNmU6TchCqBKSFDT+JqDNyrxmx/R5ahzwoXWvW7YVoCrbU62FYini6IQ+nCR
	KRPSYLufBqvJbU9fTrtvcvwm5pKsf342CvCTXZvdALctQMZ8snU/1v7Q1eq+T5xstgwNnvB1tbf
	9EH9a2kucNwRzsuN+tzzenfT1tto/qZRoftCO2bqCJRpmWtcRaNQ2hqUpxiFEZD6SXDTZ68OInh
	z2JoBiqthgFLWNTX+pefkWmE5TGJVtH31Lk1wx8rO2lJL+nIJlGwX8DDr+tiU78oc7Kpq4aWZC6
	2HtpfMDWSynmIl0PZIsyZgBk4J/7BwaTPt3FD6i5vCyHtVE7F8nLR9qU1QVa5nNs1fSgxk/DiAJ
	D2uXP6bVRbSk3Omy7shgJqVEA8CX4DhBnKodp+NTPVAV3DoBHMtIlgDrJPZ9iB5EcTwTLmPGBZV
	q+phRleI6R67g75PR4n7Q==
X-Received: by 2002:a05:600c:22ca:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-4994e7d2c19mr183148595e9.16.1786036707630;
        Thu, 06 Aug 2026 10:18:27 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b329cbsm7813135f8f.37.2026.08.06.10.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:18:27 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:18:25 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, netdev@vger.kernel.org, sdf.kernel@gmail.com,
	ameryhung@gmail.com, kuniyu@google.com
Subject: Re: [PATCH bpf-next v3 1/5] net: Add __sys_connect_socket() helper
Message-ID: <anTB4fYBFmmHcQpY@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
 <20260804164652.296919-2-mahe.tardy@gmail.com>
 <CAPhsuW5ZTqfzpxNf=S6JbmGxWf2m9qPZGberdzRdLuvv2-Xwgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5ZTqfzpxNf=S6JbmGxWf2m9qPZGberdzRdLuvv2-Xwgw@mail.gmail.com>

On Tue, Aug 04, 2026 at 09:05:28PM -0700, Song Liu wrote:
> On Tue, Aug 4, 2026 at 9:47 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > Add a helper that connects an existing socket while invoking the LSM
> > hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> > logic. Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.
> >
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >  include/linux/socket.h |  2 ++
> >  net/socket.c           | 32 ++++++++++++++++++--------------
> >  2 files changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index 2a8d7b14f1d1..48f1eb8193de 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
> >  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
> >  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
> >                              int addrlen);
> > +extern int __sys_connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> > +                               int addrlen, int flags);
> 
> IIUC, __sys_ prefix is for functions behind syscalls. Do we really want this
> prefix here?

Yeah let's remove it.

> 
> Thanks,
> Song
> 
> >  extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
> >                               int addrlen, int file_flags);
> >  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> > diff --git a/net/socket.c b/net/socket.c
> > index 63c69a0fa74e..c7427dd4dd52 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
