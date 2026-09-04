Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE33AA19B
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490726; cv=pass; b=lcQksbEjo+9ozXPcZ21fv84i1syV0vj0LqpEmebDAkIz8Nx4O8VA3oc9NS+cU/0F2c97fysmqcUM5LNn/C7b3Flt/4KwmUlEteNM/MKmVp3rGKC+OQLpsFtsnIwfUGPxlMDizEAxwcCAKXuxre5031SgE7YKvTATP3pBBZ9FZRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490726; c=relaxed/simple;
	bh=ohcAoa2FqlAFpZfcLm/C+18VPqWSAZUo72wqSUYvF/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHIWK06PPS66oYXtfdfSrnJdRLockTHPjfNcBgJbJgHix8w8GNFJ06lxawPSIPCkzce9oxMDUKQzgtq1b56p4Q4CJakqsmftR2KUB6K/WraAS1+prE5xx5UQL9tyWjltYTwf1V/MpPWO4svCnEc0tdob/p/8AgYKEdPJNHy2Exk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGbR5e1s; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGbR5e1s"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso458209eaf.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 19:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788490724; cv=none;
        d=google.com; s=arc-20260327;
        b=DDbn3zdH+F0PrQxCnbQDr4Pd4ZGftcPrb97JQpOj1UXbnaN5NGa6pqYmLhDkqn1lwG
         a0CP7LcsaaU8vZd6XFWeCkTPX5kWP41t5PzEyvX/C9Ye2lZSa4IlybiWATYzdaAEjtqH
         FOP9divqA9brB0UH3K7xtsUeLax9FeXly8drgFI3oaU5T9wvVLHbsmcfq01qkRzIfB0w
         letHuLTzXKXukSUSFHF6STSjEbksgaMq2Y+c0x/eOQ4q5k41rmc0YQbRaQcwZLqj/imG
         nCvBkfc5kb8i+bEmNphNhsoHtJLYGS4D1oLLi5zMzOh21/B8a5R5PO+YalJRVdg+senp
         gSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/Pg1OYVasvFa7HwTUQsQp/KKEQyF3FXJpBXL7jnOXg=;
        fh=artBnBkVzPwm9iO1NNiH5QZwOcPl5xPqydNWWenpW/8=;
        b=WvgRe9bieQGQKFM0hO6wA3sw4YzdNKZbyM0RKkFmuS41fmCWNGXv1oJkjVOCkHQGJz
         vqjiW3f56BX910ZY0Gesqp5J3+tcmQkljoXXAjFgqq1fqTc0qWKiiDgP43rfp5uEoA/+
         +Zmx0NoMdjJTpoeFTvS8mfCxJQ+dEv74is25/393qGNePxnlNI4XtUWKrbd9hOUvb9bY
         BJjMJci0RzCqAtDHvPt+iuTe4bAW/y08PMJedCLEQAjD/PYIm2pBVeOKeFr2mAzBK9NC
         Sd8GXakBNZP3FtH0YkwTQbXcTMlS4n7k0FW1a240b9q61UWXgq2Sz37kAjd2kExye8a+
         OL7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788490724; x=1789095524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/Pg1OYVasvFa7HwTUQsQp/KKEQyF3FXJpBXL7jnOXg=;
        b=gGbR5e1sYpUAkBwjJzIGRAmjvl7nyjq8fKrhAsYeoGI+GLxx/sXleY5QkArJToArhn
         WsGVpfIDg8R+kmj2jrPwNbq14WWULLP+TyOTlvUGNjQgIUH3JC9qwP4+RCWKjYnRebcJ
         bqonujEjs77o/lHSqzOvN8zZQBgINTZkJo53mk8tyLvEyjxNrVME34MaqtvjYVRNAf91
         soiBlEvt9YZVqBTaNavekSNsms8kGgUsasC233HO0v+76X5Wve44xNU6u0/ds/BdEEES
         /vi2bd/cYB7DQCkHJY+YlBhZ/i2qGXip+UHBaoGJf/Ho7e2zQMSVx/koKGt9aT5l0FTa
         MNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490724; x=1789095524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/Pg1OYVasvFa7HwTUQsQp/KKEQyF3FXJpBXL7jnOXg=;
        b=HDjvT0QCRl9UXTIrVWOJIArUpjdAcvIqAM3ARNN6NujHzo2eV0WLb4R8Yqvf9A62ff
         JuxTn6QXRpfct1esyYoii9JcuncK1CqPnRCO60KbN4MRDdUqfi42Q9hTyf/8E0GbI91T
         TqPnWIsOxEh9ffguFCQiyfYY5AgHxpk0Qo/ng1TnPVa9GBJ+G25eL3VxTn0J0WYpdxve
         8Si7SOQFSayrGi+tt6FSUO7gOf+ne4han3y7erBjOLxKBScYhEl+MAEWewkke/mHnCoo
         xByO1ZqjYxWXfksIF4+dqCQ2vZ0EH/BC9XLJQOEytZYK5GvSCLezfpA/4Xr4ver4rNs2
         kHPA==
X-Gm-Message-State: AFuF++keAQ6H77EFBCOvCWebESjd2wsFsIvh+CtnvfE+/jD8sXDNmRB+
	Dk9YTeDHeixAds0BebWGvgo3Us2vtK0N76yzE/PcJ2h1y0DgV1FjqIroXAAsOh8weqIyGg/lXWo
	GrOcTLmboLnVH2r41IOAF2WdHunPO1tQ=
X-Gm-Gg: AYBFou1TSMSK05XUCNYEjJkKCDd798qXAOE2JvXrVTMsqa12Uj23d3dKFadQBUrNXvm
	pBGeJ46GVcRcGvcGOisZ5qjfRymYMN5RpJdHGrRuyALTuv99LIBGvQ+lusx6F1JaQzgKnHt7Pt0
	DMoMVsw11DFo77nvX+myWlxmmZTrcsd/lKxfEqqbp4E/NdC/wDK+dUpy/OH1I7A44R6NmuzLEAj
	YWP5DVx+SDsDYB3S6QJlmJqv6kF4rt6pzUn06jmufE/N4aBAQZoD4bY2TMYM4S9ElMgB4qmYro6
	jPi6ALXr2AuxrHQNLMZECDFV6CFkpJ1X7EzFSORv4aQ+uLGdgVdkyK71fOLBIzzeQkHuJDNV+ut
	avA==
X-Received: by 2002:a05:6820:4d09:b0:6b1:a667:f0f5 with SMTP id
 006d021491bc7-6b6fcedc374mr2662257eaf.20.1788490723613; Thu, 03 Sep 2026
 19:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903143514.532023-1-mmyangfl@gmail.com> <20260903143514.532023-4-mmyangfl@gmail.com>
 <ff900ceb-82eb-4356-97f2-4af75480a8c4@lunn.ch>
In-Reply-To: <ff900ceb-82eb-4356-97f2-4af75480a8c4@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 4 Sep 2026 10:58:06 +0800
X-Gm-Features: AcwNN1Vpfq1P5xyA5NbGbzAdYSjcZdkfGeFIvs9EXqucGAsB1VfYDEYnrSQoIgA
Message-ID: <CAAXyoMNd1mR_EvCLhjvmKjCzDDXCqWdka-Gn1e8_atnnvGvw1w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: motorcomm: Use u64_stats_t for MIB stats
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 12:25=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Sep 03, 2026 at 10:35:08PM +0800, David Yang wrote:
> > 64-bit variables might not be atomic on 32-bit architectures, and could
> > lead to load/store tearing. Use u64_stats_t to ensure consistency.
>
> Can this patch also be broken up. It should be possible to use
> u64_stats_read() without changing the locking? So one patch which only
> does u64_stats_read(). You should then be able to add the syncp
> code. And lastly the mutex changes. That then allows you to explain
> why the mutex changes are safe in the commit message.
>
>     Andrew

u64_stats_read are meant to be used with syncp. This sounds like an
incorrect partial patch, works only because of the internal
implementation of u64_stats_t.
