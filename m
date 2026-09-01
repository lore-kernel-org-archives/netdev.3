Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB433BD642
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250327; cv=none; b=rQfL0cDD/XJUOwXSLmuPlSWIalDJA4fh7nI+D+ubXRPwVM4zfx0gRs+hCfp29JQKYgx2sdVSsY7NlgCfwPDNznFeNwcMpFM39t7VmtifiBjBN0jXz+Y347a1qunLe2CZuOoNQyzC6Usdu71nvQhZA1blpiXuLmHwZi0OlN4o/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250327; c=relaxed/simple;
	bh=1dh+aJ1CoN3cT6hGQVMDw1h+UM0jBg3T/yt3Q5vyv9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhtF88jY2saAGuBK5vgprvXerRKrUyIOBLIXclnT4a1BNvXJ9aSf5hDl61WbmC7zrY7pfeaReHpjuwrvXN24SyHl8hS7rbx6ESrja4tkwgAbYwfgbEGHKU1MgD4cVKgbNpgpIB18GgJHS7ottFTTUHxJ6YbzFNibEhd9fToLVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZltaNi5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8pxMk0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZltaNi5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8pxMk0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788250324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dh+aJ1CoN3cT6hGQVMDw1h+UM0jBg3T/yt3Q5vyv9E=;
	b=RZltaNi5R+Nh05vrqKJn4or6HQoaZ8zzO0qTYm1k6/4SdkYsVDpaBE04biS68Z83H36JZy
	6PNovb5FTvkP+biC1sQUkZnTseMQHr8EFrveS/zmbcwWQoFKFnsF71qGzRnnq0Yko7qaSu
	nsnhoSdSHzuItRtF6/Ne8e4q3BY90a4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AP_RmXpePw2G0wqCBsQiyw-1; Tue, 01 Sept 2026 04:12:03 -0400
X-MC-Unique: AP_RmXpePw2G0wqCBsQiyw-1
X-Mimecast-MFC-AGG-ID: AP_RmXpePw2G0wqCBsQiyw_1788250322
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so7946575e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788250322; x=1788855122; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1dh+aJ1CoN3cT6hGQVMDw1h+UM0jBg3T/yt3Q5vyv9E=;
        b=D8pxMk0wKU0PkrPBbkhjlzsjl7ru3tvxxEquTvmCMMo3iX0kCSchdVXZJfjncPr/GA
         u0aXEDGoSuKQBDK4oB61r48pBbPyoWEqeQzDusISBnILjirgHTBeArS/dXFt4aAjL/K0
         BgGSjqG9j1MoRUKMTCWq0Yhg1lBH9Hgroq7kGpOT6yT8cDiT7FW9r325oc0xqwZdIsoE
         Y2S4Cxgkl/TqKW1U9fseCuCVKJdVZwJA6MX4PfUe5Tn8S9sSyOYFCx34yyPeWK7kScbj
         2Xa7ShistFYLanAhUcs49ADM1xV3v8k9yXqoXbpDQfSMzSMlReCQkgllYp4fxafOXK1l
         FX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250322; x=1788855122;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1dh+aJ1CoN3cT6hGQVMDw1h+UM0jBg3T/yt3Q5vyv9E=;
        b=iQOa2E2LbYZrjMY5a+06akc4/5sFqC7WhbUJcnE9zBhUEt6OIBy2fcgVNA4HkuTijK
         cPy5fgbDxEFLsLU9ayOOB9fgdgDRjRDzK/ahQvtz8KLR6Y4UU3yYSjzACwgfwWYOMCjN
         1o+yAlCmPwB0N2G/OGTureikPK1FVMXCkZI/Or9UK/DUFBB9oSW5iItmRMphD8/2DbEj
         F1UrUKvQ8hvZcsUDarAHk1BCG/lry4nhbWjIgPID1QB+IiKozaFmGnHrouysu/K3WVa6
         sihxnCNuaAbDULuJ2jyJ2pTTYkHrNB5BT1l9jqVjvpsfA0fdSTdmUcEJmfdsXAGKZGU7
         nPrg==
X-Forwarded-Encrypted: i=1; AHgh+Rrqo4FHb0365rMx2VpbGyrxww6hamsMNGZSKxqKvgjAwGyniLKSajEAicF404h5ZJ9lC3eRI64=@vger.kernel.org
X-Gm-Message-State: AFuF++kMq0jEFTrxXy6yNlXBHM3El4AiCUcyPxf5hPaGJQju2LIBI4O3
	cwSEBTKr7zIjFXK0wSmcof+U+297tx4fzYrErmvH0l9UGH5bRc2w4jHlq9Sjbd0m9i6x9KkI6rt
	17Ho5qPWex9EkxikuvXNTaDUpOPIz5V5kfhLQNqkoUYgvHKlqqiTdcMFnGQ==
X-Gm-Gg: AR+sD11H3BvzPwaQl5+nvj6yvkQa1tP8QDSRkX/6Z2CEI1aoeAKY4M+rwoGRWkgP/Hk
	P2KFBkLtXPjA/JWDIOQOSlbAQ6PLdSxPUOMlrYnswYVyMI8hVujDurin8ixBlYM+dABQ02rAX/T
	OuEI84AAOvKIs/6kH1c4MAm/47wpUJquorofUg+QHfNd8e3GuPgH7jrF85sm9nIAKlSm20N7Ybz
	EU647cSH1UfKTRyawZuALj7igYMYvVGJ4cm2BP+jfjbPwycd8msnEtLmPasRL/JfYd1VJoU1wgJ
	msy6KGpZERPMb+LqNA6yw6yPJhhe4KHQPdjvFpVu6fAsslVcyUc9H3l4vzVnv0zM0giV8Q7IFC5
	Vwaam/HmF+A2OspGButNqqYwF
X-Received: by 2002:a05:600c:c0cf:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49b91c51e62mr449676385e9.14.1788250321886;
        Tue, 01 Sep 2026 01:12:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c0cf:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49b91c51e62mr449675545e9.14.1788250321506;
        Tue, 01 Sep 2026 01:12:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce4a804sm57396675e9.15.2026.09.01.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:12:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B56A597C4AF; Tue, 01 Sep 2026 10:11:59 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com
Cc: shuah@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Set BPF program flags
 non-destructively
In-Reply-To: <596f7d7b908b3cbb2dfba0ee0aa601d098d054930baecd485adcb5af5ce28a13@mail.kernel.org>
References: <20260831132648.65843-4-toke@redhat.com>
 <596f7d7b908b3cbb2dfba0ee0aa601d098d054930baecd485adcb5af5ce28a13@mail.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Sep 2026 10:11:59 +0200
Message-ID: <87pkyxv19s.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> Should the bpf_verif_scale.c site be converted as well, or does "all
> in-tree users" exclude it for some reason?

No, I missed this one - will add it and repost.

-Toke

