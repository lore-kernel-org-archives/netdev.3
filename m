Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C333CF688
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705023; cv=pass; b=RSyCvizmB8ioHRbCnEtScOQ9CZcSDfz0XE7MZcmo4MD3ohv9s25rCULktYhreYtOgtJ2EXlIiqfo7EpENOHREJ+JP90KhF36nlE5e9fU1HhJg/DA2E+E4XbUNTbnxajyt7q8yplx1MDsCX4MPH8XUlX8IpSDm9QtXeFQ04zL/Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705023; c=relaxed/simple;
	bh=66NPz0C8eG0KHGSWeidBwsifxHr9iMvd7btjXL3I6t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4lzNHNgPQiFC+jYV/50c85zFgSi0kC5SRJn95dPa50NvBk53Y+ZABT0N2mWkJTNnWvhtR3PgtwlDycnzSBQVGrpdIqk5oAcUCKb3wl9q3RDfQHdIK0e4JoaZtqHzU3HGCTtR7ilUMsrmnkcfzTQ6MpqnbYUoDtbrKFqOszuMHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZ3eNak/; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZ3eNak/"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbbf409b8so18735866b.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790705019; cv=none;
        d=google.com; s=arc-20260327;
        b=I+ESszVXXbwmke79p11qYgcmT6ojbhSQdIcx4rV5wilNAUAiC/p54rTpwp7Z/fu3fr
         n9UAW7Rj+QBdJ90KK3fYEFrd925bZDiQ0tgbUu24+lWc+91PraAde438bnsilKPRv6TS
         aqhvkGFAQZMDVlaUhkLxfOH6RnIaEqEbBERP8wowLsCcPl9tpkyb3+6WCJAM0yKXVvox
         oeqW72yCxD79zIq9ETcCPnCaHHilQvGYRIwoDY6rQ/B9F+LKlXMLFqlR7KoIp1uEtSsX
         SkR6hffhTRH2ro56Gf52yUF17uig22XLzixPKujXYhXHz4EnvmJ2YsrRtGBmXY82XEwS
         3VAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cx+hvzKqglq+4E86uBoiNqYHk0FJfTWAwibQaEI3f9A=;
        fh=zHgAw/XzAodTK5aTT463X9QulTIQEofn25jjexSEJgE=;
        b=JGhEfyW8M0aD++xPacftEuLU6eFQYjOEIXgEI9JZ7fNiawvKKvtAwcHDvnyj1DhMBJ
         ztR7vd4+lbpiZYBucBco1sYDuGWSKvGE1tdmjIaZk5vRWZIDISS2bwszcX5+Gh41gtDa
         ZIXgag8yzL5aOEVtThMVXO6e0+0/rP55HSSRiqMxwwuMOKTDISgg/nTCZtU+Eei9loGH
         sgs8eJpjNNsPbqVipZdlC6c65yGP7w6V84lLAEdCJQNBzC7kqF51Ziig/Gar9cJM0i/U
         z/OTx40t3moAqdg75os7ysdYsFnCZ8OIE8TWc+5TDAwOdwiF5lH/2eVrARJ4hiVJPP+I
         Ex+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790705019; x=1791309819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cx+hvzKqglq+4E86uBoiNqYHk0FJfTWAwibQaEI3f9A=;
        b=HZ3eNak/DKOJPows8YaJ8hUGPD74CpsdmBBhhS/pws2y7XTwxXcgim/XCd69/GDi2g
         aW0y6pNYCYkIn3YgUS9NrTISuyvJyOALivXZHU3NCmtFvI2lx5g+r7lPzmiSjghQXmkt
         yYLv9FqXEDRiW0ki0zT976ELXQP1A6c0eWD9bxTZ49f/MpXUBPL9I16Vlothp+nlRQKu
         5JWYeyuI89Q73YA5HJY9wyKI5VfqVutemcGQg7sq1QcX/uSlqTquZkMmgh79MGYtdD5S
         F4DZpcp1CyIaaqf2CobxZDrL5zLTYauYaUFUaXLRzH14TOawFXqnC6Uh8NGgwjsfODQ4
         OIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705019; x=1791309819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cx+hvzKqglq+4E86uBoiNqYHk0FJfTWAwibQaEI3f9A=;
        b=BYF/9DAc2KtEdlgfQg7TYmcZ2XRCHeo5KA923TzqlKCWv9J3qnJ+7BP1F44hXPZOKH
         b2R7dQ1iugfngb6h8O7UZ7hK2GFHgj5wbr/c9Y98inVndvpRpVb4Gb7/nJ9YzYmvWRyV
         pT8bf8c9hV7yx/A4A9fNmdTeOtY5HJR1WDfA786CnoYKSyMbLdY9tCcf55/p0TOOU39L
         m4c0S5JGejYZTc4K2rAJ57aCUCESdcJOrcC56XdOof/eX4cnj/s4AT3CFBt9XDQZHFcJ
         fuvx1B32w3D555eX8NNz8ovCkwihxBctfCQxur/JgpUHAHGlT/h8rDiLKw0p354nw0xR
         yVpg==
X-Forwarded-Encrypted: i=1; AKwUvBwjOSLLHzGpyAED5w9OzZDElKBJ9SERLkP8AIUdVMq/36V8xCbW87JL9cuNfeN9MdmBRGDiFAI=@vger.kernel.org
X-Gm-Message-State: AFuF++m3PkuBkYdafKF4h2yrA8woY4yczNsfAq98MtQ4D0CNnA0SLM2g
	J84xO6xx98meRLNkV2jJREiiVkjx8gB9DLBPIa7ybIY4XXQ7GvWYnz8xNmvvHr4WZZpCd2Crh3n
	yTHK/aiqJC9hmTRvqsW1e/p4qWr4lHnVbFA/OLOPC
X-Gm-Gg: AYBFou0Gh8BkMenf/Z22QW5yJl03FrZtlsCCMzFvV68SLTl6wulQ4asr1kMyIdtzxZl
	rvhnAVtaaqJMoPviAbZjungfPX4ARhxiKsYEitHLHwdCMs206XO0LtGXn3ymjAD/qxyDjy2BQa6
	He58igcN3++DRMCVUnlWwLCQIQA6YrasdZ8BzLzJPidiBer6EsH7qbkQ3pmzw/BeGOFi8MOmeav
	SOmQnuOenJEtWXLS2nZDLppo+IxbKQ9KQPEwnowtLUSsttW0pGWPDmHckDHE/5t8yADc2DwTbwa
	raGlFBqMA7BJ66/wsUsNfiQ2+CpqjfaMAhYaO7X1+AQXRmOjIES6CWcisA==
X-Received: by 2002:a17:907:c408:b0:c26:2eee:ffc7 with SMTP id
 a640c23a62f3a-c2e1588b329mr24041666b.35.1790705018647; Tue, 29 Sep 2026
 11:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924185316.2831077-7-hramamurthy@google.com>
 <179036256202.2160803.12978678207911420221@kernel.org> <286547c9-9f4a-4202-a615-b51d42850951@redhat.com>
In-Reply-To: <286547c9-9f4a-4202-a615-b51d42850951@redhat.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 29 Sep 2026 11:03:27 -0700
X-Gm-Features: AclHuK8gnKhB4zG1JHYYcGdrp3cm0c0-oSpP2e81va5MA8TRCBQ1L_AaXhWMhjM
Message-ID: <CALuQH+Um-hzm3UTsG35+c5AX6RuW2x=OLYq=GOpgK8fR4P7FMg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 06/12] gve: simplify reset logic
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, hramamurthy@google.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/25/26 20:56, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 7 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 2 (2) =C2=B7 Low: 3 (1)
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] After a failed recovery, an unprivileged user can crash the
> >    kernel with an ethtool query.
> > - [High] When gve_recover() fails during a reset while the interface is
> >    up (service-task reset, ethtool reset, flow-rule timeout, or=E2=80=
=A6
> > - [Medium] gve_teardown_control_plane_resources() (gve_main.c) now call=
s
> >    gve_teardown_clock().
> > - [Medium] The commit message does not mention several user-visible
> >    changes to error handling, and one of its design statements is not=
=E2=80=A6
> > - [Low] This patch removed gve_queues_mem_remove() from
> >    gve_queues_start()'s error path.
> > - [Low] The commit fixes a real unbounded recursive reset but has no
> >    Fixes: tag.
> > - [Low] Item 2 of the commit message describes the old bug this way:
> >    gve_close() during gve_shutdown triggers a hardware reset and then=
=E2=80=A6
> Low prio remarks could be ignored and we prefer no fixes tag in net-next
> patches, but the first 3 ones in the list look relevant and should be
> addressed.
>
> Also please note you are supposed to address clashiko comments proactivel=
y.
>
> /P
>

My apologies for not replying directly. Harshitha ultimately replied
to the cover letter stating that we would be sending a v9 to address
high/medium issues, so I thought that was sufficient.

In any case, I will add a response here for the planned fixes for v9:

> - [High] After a failed recovery, an unprivileged user can crash the
>    kernel with an ethtool query.
> - [High] When gve_recover() fails during a reset while the interface is
>    up (service-task reset, ethtool reset, flow-rule timeout, or=E2=80=A6

These first two are a result of the change to teardown when recover
fails. For that, we will avoid tearing down when only queue creation
fails, and call device_detach when the control plane itself cannot be
set up. This should prevent any ethtool IOCTLs from going through.

> - [Medium] gve_teardown_control_plane_resources() (gve_main.c) now calls
>    gve_teardown_clock().

gve_teardown_clock() will be called as part of
gve_free_control_plane_resources() instead. Since it is only freeing
memory, and is idempotent, this should be a safe change.

For the commit message issue, the commit message will be updated to
reflect the latest changes. This code has changed quite a lot since
v1, but the commit messages has not seen many of those updates.

-- Josh
