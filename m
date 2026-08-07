Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66904377EC3
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096271; cv=none; b=lxwMp3wCLjpcDMt7g6/60fVF77dcH8UmrYz2JmJhAZuBeGunCyLLf5q8jKLt63RLBBesHMQiff+nosFtDxKmOHed3cU/KRxPe2oiBW5BLiprF9d9vU5DfOjJkTITMlkW5U4s3gSO7jc1xGGU4NWIfTB6oG5RFb1Ubftm+4JO9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096271; c=relaxed/simple;
	bh=kLIJ7ESzSbgSa7C7U7LBT9Ad+YF0VtcMzSfWUdwBSsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcvIETMfta7VqUP05J/bbisjEFM33gdHoBJPFG+WSPC+0HwbJpqwhbk6aTjhktGeOYvVpFXzWGnZzK45N24TZO/WuyJyt0OsOJLAKsLZ5tU2GSslCWeZSjuL1EsmWsf/WXirKm3S5M0CLo8DAxL1ut+TAek/IES15Vyz4pb5/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r79zyM5J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r79zyM5J"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49553515a8bso47288385e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096268; x=1786701068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CK5aAlE2gXWUQMLhZXJtBxJFs/yXRK0ivXNCpOMa24I=;
        b=r79zyM5JQ2IYlFzg++2oapCcw694JrZSBpghxHSyd70xbL5LmQHxtvfAC+1bOUi3FJ
         9bNGYpvH1ViQiR4zYULRKXlSgtTwnpZTBtnaf5AkOLdyMDI6dCoKFE0MZHhssjt/n5ir
         Ja9AGChwbDtTYGxXNLtM/gxCdmatW17pejVM5EWqk6DaANuFLyTlfQBPqi+efs7+YzLv
         /3hnwz+CRK9ERucw3b23Uq+VsYXDuRAqL0Qub68eXSm8GDaYzkdmPEIF27XlyGw/sv7v
         JFThhCDX/ixs2Hapk6Rftk4/m1JdxBwEzN6CggyIRnRvwQqu7Pl2FMF+ufPVrfkXjyzT
         11pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096268; x=1786701068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CK5aAlE2gXWUQMLhZXJtBxJFs/yXRK0ivXNCpOMa24I=;
        b=b+I+acc/IYLqX3ltKZfznl2SCyu9t+EKnP6YrAskxMchlLm8p7Vq+iQAOad3ahSxqe
         31J6/mCNCw6jjerJl4JfLb8mDDunXx9/cqOJXk+JZwckxn1WeJXAhQfoPknbJ23pESsA
         xinp8pmdN3rDqQuZy/8WX6twENK5czuzClAb9TDDaGMeBAqpDr9mo1XT8iCQgN6v7pfD
         CSldURkHTzgko1hkesqHAdQCCdht3CG+uSKyTCD0CPwQm0o4PHYdwJRB/P/6yBExqHF0
         DaQOeRaIJohxhnrtQSnX+AyEQf7NGbi8p22xsms1UxaA7TAdxmIbUPzSJDWfkUWim5YV
         pIew==
X-Forwarded-Encrypted: i=1; AHgh+RoRM9f8SUKmwqW7DUMCoUqhZf248xz1VMhndiOm5fZO1k/tEYIvPYwXni6pJx5y4hkPrnLLwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCeen5AI2CVbxM/eRPFMb2AJi7G5edkAcMwQapmZEinSVcdug
	7qBNQZBQ/IIa8C6j2axP2SBR5mF9wxWLAOmeNtkALWKwkz9IVuVSeFc+
X-Gm-Gg: AR+sD10ryS7ZPp08u2gTBVrG+0pKiKpBOTbLufp4n1fJisyRiXXtMf/Zu/gSub2l7u4
	SOYnryGpd7jfSco33gWjrMXwODI2J9mWvWuUfSzRUV91IBsldgl6tv+pTTR97FF9dz/8InFzVed
	kEKmkdZGXMpYmFOy9b94AVuH/YQ9YJgyO8Ec05hap0U9+gj2aUDGha4v4V88PJsNO2DtkdUWP0+
	qC416rGXvBxxruRvnVZPzstF4NhqoVHDIu/RzhZDHnedOp6pGM3AC6RiWbRkSzJOxuG0GX5EJHa
	aKHIrPobS+65ghpWX1KV2KBXzy1VXBR1zYCsZjFOnPrtLosQP23i4nu3umxnbz7Yla1BiojxlXl
	OJNLhDdLlYI84D273IQN6Jf8UMwL6ZaPBQn4g2LKCW5sOYMYcSpi3e0e+JSOW7MQja9QzIJK1IA
	3HliCtwhyyVhCYRywB7kkypAhpvWoT0NYeGaW3OUX03INhAEM4rx20Gd33zZTGvtEICXBHoOjch
	K+1pYH4jOK8+JR9WguQ
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr98245435e9.9.1786096268249;
        Fri, 07 Aug 2026 02:51:08 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27b29sm31138585e9.11.2026.08.07.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:51:07 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:51:05 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 1/5] net: Add connect_socket() helper
Message-ID: <anWqiWgSNWARKBRi@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-2-mahe.tardy@gmail.com>
 <05084a53-a1a4-4e60-bdd7-6fd16ef6a029@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05084a53-a1a4-4e60-bdd7-6fd16ef6a029@linux.dev>

On Fri, Aug 07, 2026 at 09:53:51AM +0800, Jiayuan Chen wrote:
> 
> On 8/7/26 2:22 AM, Mahe Tardy wrote:
> > Add a helper that connects an existing socket while invoking the LSM
> > hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> > logic. Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.
> > 
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >   include/linux/socket.h |  2 ++
> >   net/socket.c           | 32 ++++++++++++++++++--------------
> >   2 files changed, 20 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index 2a8d7b14f1d1..8964528e3823 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
> >   extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
> >   extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
> >   			     int addrlen);
> > +extern int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> > +				int addrlen, int flags);
> >   extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
> >   			      int addrlen, int file_flags);
> >   extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> > diff --git a/net/socket.c b/net/socket.c
> > index 63c69a0fa74e..126a674f534d 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
> >   	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
> >   }
> > 
> > +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> > +			 int addrlen, int flags)
> > +{
> 
> 
> Please fix the checkpatch warning if revise
> 
> CHECK: extern prototypes should be avoided in .h files
> #27: FILE: include/linux/socket.h:464:
> +extern int connect_socket(struct socket *sock, struct sockaddr_storage
> *addr,
> 
> CHECK: Alignment should match open parenthesis
> #28: FILE: include/linux/socket.h:465:
> +extern int connect_socket(struct socket *sock, struct sockaddr_storage
> *addr,
> +                int addrlen, int flags);
> 
> CHECK: Alignment should match open parenthesis
> #41: FILE: net/socket.c:2107:
> +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> +             int addrlen, int flags)
> 

Yep fixed for next revision, thanks.
