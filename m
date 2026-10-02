Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6C38DC5A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950053; cv=pass; b=J+8iEAP5St5ThQUVExIL4xYK5FPZPOtwwrGNEDRFKOjD9WFQ1Nj0p7kBA8m8cnpSClwjZE8KuSq7TFidmbx44lk5eaYSro5HyEzCg142zFdld/RLnhcGlR2FeiE3EiIID5ucUmvOB1MgpgSy1e+/nOvoKm2EojBtj5rTC1jXk4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950053; c=relaxed/simple;
	bh=yfDvPO4H/mIRlRzgF1ehHxShRFO4ABWe5fq0yL3+cMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMvPmECHMYZgo3hvYK9PSaHk7QsGFwQ3hpgpJd2TqmFXIDVDZJnV8JH13bVZfaIpz6FWxSyxa5mib/vCpDha6Lj9ES01URCNlqMHUpeLN+8DT6yd5paeF7O8Q1KaH2tvCadTLstHaCLDEXTpH1v2lef4kkA1DMuhPiZ/uVlRY64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWF9kkfh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGWOl5js; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWF9kkfh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGWOl5js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790950049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
	b=LWF9kkfhGqJuNmvEnJaY2RoYZdME9eFipEhx6uXE71/QXkbjO7r/WHm7U8e3c9jg6R6vmt
	qQCTnr5KQbekEqNB+CLU4KiKDWawwEmRUnTxtq44MnWsLpdjtDYkwusnAmALt89KpvzyHd
	4Wi/WtnrUOEJsyhio19OvV7dXA3GgW4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-3r9xQmiDNjOtjeHnWM-ItQ-1; Fri, 02 Oct 2026 10:07:21 -0400
X-MC-Unique: 3r9xQmiDNjOtjeHnWM-ItQ-1
X-Mimecast-MFC-AGG-ID: 3r9xQmiDNjOtjeHnWM-ItQ_1790950034
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39b1a8b8bb1so693601fa.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950034; cv=none;
        d=google.com; s=arc-20260327;
        b=q3FWjyf97HV/X/SjsvLmtbd2dpIlIa4cxKJPb7ksd1tyTfAUuvU+noYtee5fwFuMeT
         mSJL9PfzSbi65HUXbKGNY1UXn78LdDkc8l9sHwHW6xxFQKcNj+So/trlBeQ+ZCWCIm82
         LnAzRgGG3eulxXdYsPqMkWzFh+OoYXjR5tkQsJyNuEtaJ0IKFzMIa4EW7l2RiLGgMMri
         UJ5/WP36BSpmwjsNjldSHYGEGUWvMNG2yCMnZfBlankfUicdBSGg4JOTTZ4J/xClLxDo
         c2SP7fOOD+w+AChR8S5YNGaNxr9XsgfV7vZQYK+mIEHUBC8WqIMRmKAyDkxqTwkpv4Z9
         b9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        fh=sZ2clQy1/2vVl67hD5PIu1Tdo2qIYRmA58C7miEVO5M=;
        b=rHLLIcelajbyzGBplZBx2aMUtVfTVR01ZjuLECgoSXMJB/1tYQaR9WBskaGeXICExL
         PPw2Z1n8bH0x4IWFbx8+Q1VmXw2Wrib+LDijKhLVzz7FLkGwXAJ06VhmLh7Z7tQ1RGmF
         lFiRo4o+5tzJmWQzEobiqvkfcpKP9BhphcAnkkNI8T7pih9XkQirNZjAnVsw+CPN1LJY
         u3q10WOb1kUtFFT/8Q2+TYiWeiuTwqNhdpd05Rj0/wHVCm3KrlLB79otfMZ3zxL6kfCi
         gcVUu2+vs8LTMtS50I8fZZ48WheXwsiiJ4vAU5L01HQ522V95J+5CBD3hqL1RE2o/Wtt
         0fkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790950034; x=1791554834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=KGWOl5jsE8QQb4D8FZHcRRf3lRLbD4irayVANcnlm/qIwAMXnpXYCr5QJieryHqkoR
         v8CifHXoKNYHPgb8wwYE8PE3JvUUxGLoJGMuIuuXimaP+vSCt4DZvhTkRoE0aPZ36cOg
         cDvxMLqNnDpny0iv0KhmN6FkPKmYAgCTQjwzbJG4/S+UhFW3/QiJViXFXpN/aqhmuQiD
         RIT/SSGL1YkAbAxc3Sj3C7IXPjBH+SUjKGKT46M7E92U0iYhOY3jNO/djKP63ET9H2N+
         ucb667glPv00LkhYIybgLn34YJt3hzpP9MyqdZQrg97ckmkkBIsmhxEoSZUaCSmbaTBz
         KEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950034; x=1791554834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=j9MepEapzIxJ3VzZJvg031UV3Ab1A915HdcjsSj+JoJy1egCFLZn2YKl5HlIykDSCl
         zWq3vrb3tjp54DB+DFJF26EW8iz2Svk7e4MU5nPr+LtSPhQAkSxsBTFca6sbpudbjU0u
         QIAnxa50Uh7G10yRvBJlT+HxEit/eFQ4/AHAM1DxetLow+YlKHc6HvOhdcUXUzr5JS72
         xWthyQFKM5mphW79LxNv7cSOQYVEZK2HvNND+0vQQyoFFS2KZa3L4DCOHjox3NxDVRdc
         qQytIn78bVIbFCxK9+Ln4RxN5AUs9ZOlyd73rg/dffhbksB37dQLpz/0E/+gUwsa4HDb
         L8Sw==
X-Forwarded-Encrypted: i=1; AKwUvBwPYMytdBd/kZwYG3gmxcGMvHmyNbP1sTkEDmPVrxrY1xcNwtn2zN6UMkyGsfgPIitijQ16c/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo5ZLEY4jw2+N3nrhwmA7+h41wsV4Ybz5boYIv61eryAcwijdy
	aO3Wt5FKh+7IrxwVAIJU4tMw2aB66mnXVnidLDRFYPrCKHgDWZRMUlMWrXftYyuMzTZg0ceUvcF
	1ottZl0QjWcd3NYgYs6tcTrQRowJVixrCtQBFh6AuSNcJRHqIQ7Wyasc65qaZ69PaTITpOeoxFw
	lV6+An2Qma1l5qyZCdxnjykXApAs6xaiXZ
X-Gm-Gg: AYBFou1ykey0stNKFoBc+YrDUZBr3ItYiCu67V3a/nCr9b8ABM4h788aFnvw0J3mz5P
	1w1Dmbda+0cV5ZcUqs2AS7SaDAT7AaG6iMF5JE9Sh2Y0om9Q3jZ/4hcI4eI53Yn4XWLaTSGPx9P
	uEyTHi8YU+HrT+mPzeVul15h9lcxecPZNHqeUohYhWwcJdyTd9W+IbYZ2G
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3a8877b72d8mr7514281fa.20.1790950033909;
        Fri, 02 Oct 2026 07:07:13 -0700 (PDT)
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3a8877b72d8mr7514081fa.20.1790950033516; Fri, 02 Oct 2026
 07:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
 <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
In-Reply-To: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Oct 2026 10:07:01 -0400
X-Gm-Features: AclHuK_sfowi4LPKpSWl8IXP3uRNzWbqORQfvYROS9BqQto16BFcN8kPZWF14yQ
Message-ID: <CAK-6q+ga-MNEXgENToB2hLB9jzpsGMrz-1sOo7WQP5M-scnAxg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	edumazet@google.com, netdev@vger.kernel.org, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 4:33=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] A TCP reset or TCP timeout while the connection is waiting for
> >   send space can stall the dlm connection permanently.
>
> I dunno if I want to spend time fixing all dlm bugs.
>
> It seems TCP changes are now stuck because ood pre-existing bugs in
> in-kernel-users.
>
> Sad.

I will take a look into it and cc netdev people.

Thanks.

- Alex

