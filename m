Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A041441B
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324118; cv=pass; b=NT1SgaZxG8scDNrwpOpCWi+lo1LDHn7/GfFw/4A687xCI+2EQ+S8O7Ap4RrLAjIVds1DRMqrKNxKD/09ycV2364qna61ST6PkDVaiTHM82iQ6qel5SrGGEh6jkbcKaX9sM/FGbFgF+BqgV0vvzk6DFBuDHzr/HrT2qIbqX3/ZIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324118; c=relaxed/simple;
	bh=e9bwDVgToGQxRvIMHPqC+Mb7m3W1s8vvgzUSnuek99M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osgevoySYXpdb3Yan28ttL8WhAdKGysECao3Ya8NWdJCzbxy9FeQOkFa+1uhy1vPrQ00hT6b/T19EJqwDV8oGcTA7YZR96frKWl6YZw8yDI1yMC6sltWk9nfzU64oUmL/t1iR92m5RX3J/C1/xwx9GPGlMX9i2QRCqP9EUPk5Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WwrvloEK; arc=pass smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WwrvloEK"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so497043c88.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 01:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790324116; cv=none;
        d=google.com; s=arc-20260327;
        b=ZPocoBmY1znEZ17tTOygwXySFqKf+w8h9u1H7smV/JSrT1SreN7wN4hblyDImtvLEh
         cJ+AX2kzSq816XRcC39n3Z7LfUAPNs3h4nLhgDZOiTagjfjgShjVwjSxHj9Ku0ZvauFp
         Jhsb60HdYEEzEKGIA2DJcqKhlB6cG9ph/vbqJNDM/HMXX/V6APJYm3OKSTo9o1Z3c/Mb
         tqjyZJDzHb0C6NoNphZg2El1LUA3GyAz51NXdtidEaz7Ae/ZHLjz6sMIwclDHlfsc12q
         pUK/43IVMLOu1zEZAhGCfqP/gGj/KnEzuzYb+82Y9d7KPZDojSyecTjIMgK52/2BYwOS
         vSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e9bwDVgToGQxRvIMHPqC+Mb7m3W1s8vvgzUSnuek99M=;
        fh=PFOHknWtuG9UWd7ymAnDa6kcXvtBYsRtutfM1eBnqiM=;
        b=qLANMqHYnwYUTcL6Fftn73cqHLQ+KT3qOWdzqpJodLo3paKz1KsOmo5xyfCRe74N9t
         L9SJjSpANDx0lnutfqldpbV5/QMKLLrnCbn6D7jhqsXCTtbUwYNIDiPejgKCyAWEh99/
         zvTQB7ax9wPwSthxA4fdOyB9FRBHys2ZMLloJpgblEn5aCCcMGurzOEsHhWCHZ9s/LM/
         XYBXEmjQZvTcRJ0DKh3GMlF6poOR2NmbANqFno1BrsYJBjNqjifeiiMHenlN9CO+XBuO
         Cy+ELH6GoYny4rmsu6I58QUIxdwfClxoXVeGjBnQ54A/VlQD65neHpT3Ne0zoEX+ijab
         PTFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790324116; x=1790928916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e9bwDVgToGQxRvIMHPqC+Mb7m3W1s8vvgzUSnuek99M=;
        b=WwrvloEKQRmJxz96JeAxaDBTI9uyFacekm86owd0bajAuSQK8Ft0XdImVuwmlS/o4d
         ojg0wEXkvJEg4Y42VkD1b2YGlSyHH7Ihi/OKczxbRkEs6zvnTxG34E2MeS4AbHgeKV3I
         lQkB6XHEDgzW8d8ktvU8Z02gAyyGAvPtGwqrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324116; x=1790928916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9bwDVgToGQxRvIMHPqC+Mb7m3W1s8vvgzUSnuek99M=;
        b=koXtQ7mXe0MRXmx/vMzJQoScw7YAmzAaTVDXoLx60/OYjTQUeOP+OLkh2nGN7MtSu3
         XW9hpKQiWztTI0I9SWq/zD9Q3lg6alU8x0rWzFtuiSMWfcqGDVBvRw4AXcJBUC2k3nyO
         41P4QbgHxNnu/gMiA09PRzzq8m9WrQjigZorTtvcFCZXCO4iEL7n0U4KhHt0jRchS6wi
         RenaryOa5P3iRMw41YckF8PDdT1qjH3WsD84b6krPdBF/OpFrQjuGltuOsw0MW1rHqE9
         LZDyed6ahvfMqwon06tskYtoTYw3EJcip0Ah6R5Ep797ovNZUATQea1EpNvVOj9f3/R9
         EYAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwq1/kc5kZwiO6ezcylOgLcWe4CczczUJ+KqSbKnR4kuCddFc5xjjPLIQJlnStalx/FodZTB58=@vger.kernel.org
X-Gm-Message-State: AFuF++n0vkMfOBGSJe3MpwbSqes7FbM6D4+HDuPg5hqwjZWBzyalRFU6
	Kuh4KNlAwnJcrRK0affhJLwPXz70SbWdKDwyZ8qnOfKDXXtfoYKh/E9tDQ7vDEwEx7dlZdFtNdh
	Y5cw7IQVjPfpi87iA/uKsHhAgIYc0wjTZEINBwkfW
X-Gm-Gg: AYBFou1WkWo6HDFpVw4RLcDBzwAyk/KgebGu9e4mXZ2J9o6s44X1nhbiZfGYpoV1q8o
	owUkraHjoXFNQ6g9VDcS9eSWeNsjDFv1owzp9Z3L3mwhBa+LRdEDFfLprGbttGmVOD1gyEX/Ivm
	nat++E/oa7JFvZGv6hqBGpwqYqdB/Xezn1j++B2RydNvCCJ1cVK7Ig6Im2hnCbeY9lFptUG+avj
	/kAJTxaRt3885H4tbD08TamA0ear5ynj1PAoHxNaq8M3u1sJKyUAmh0H1zf1xO6Uw/pCTWG26LM
	tLybR6bMxhbeeF9BZY6eMDhK+SsQ7zJ5y6IvP1NZ0Uk2szGJq+Tkh6Bvr5YhvWmiNqxaoks5pmR
	i6UyUzfdIBcs2YWvoUJLT0pfTQ53ZCcBxz7hvejTMES6yiHgIPpahd81vy6IutSVwQfgUNrSh+I
	u7miOFrukgn4F4wMRs8LJ/mCFd
X-Received: by 2002:a05:701b:4507:10b0:144:ff51:2d5f with SMTP id
 a92af1059eb24-14503fd76e3mr3874323c88.33.1790324113884; Fri, 25 Sep 2026
 01:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-K1TH.v1.20260922072206@mojatatu.com.2> <20260924103222.239e3d45@kernel.org>
 <CAAFAkD8goF-B2qP41roK8OipD7TRzZfVEdFDPxHddB5Tm6VhCQ@mail.gmail.com> <20260924134244.1824ed80@kernel.org>
In-Reply-To: <20260924134244.1824ed80@kernel.org>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Fri, 25 Sep 2026 04:15:00 -0400
X-Gm-Features: AclHuK_bO1J2wnqkg_eMZj4WzMEH7NJ1PnuSwFWouftz7ozod-Eh96ddHNl7pus
Message-ID: <CAAFAkD_S3EwTjGXX7YZRLSQZgwX5un0Td9ru8r9chnAMk3ni+g@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: tc-testing: add duplicate action
 delete batch test
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	hybris <hybris@mojatatu.ai>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 4:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 24 Sep 2026 16:09:16 -0400 Jamal Hadi Salim wrote:
> > On Thu, Sep 24, 2026 at 1:32=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yiel=
ding
> > Back-end Review & Insight System <hybris@mojatatu.com> wrote:
> > >
> > > On Tue, 22 Sep 2026 12:33:59 -0400 Jamal Hadi Salim wrote:
> > > > Subject: [PATCH net 2/2] selftests: tc-testing: add duplicate actio=
n delete batch test
> > >
> > > ah, here's the 2/2 patch. Patchwork did not figure it out either :(
> >
> > repost? (2/2 was stuck on some ether).
>
> Yes, please, repost

pw-bot: cr
