Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087643B9931
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879221; cv=none; b=Lz2McPD/x7ngcs25KVR54eB6APcyoywQvCDda8elfMNPMBh5+LMzJJPfb9gAo/SIoFGfUlsBRN5EdVxHwgZds+8xuxevN+PBdDty3AUScJY1n0ITL9eV8MBa5nohEU85SlMmXrZgka+N/kv4eg86cKvhfhRrB++zK+dRz18I1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879221; c=relaxed/simple;
	bh=Zt2Y76i5f7DVHh3hD/LBdSAr/rgaAUvYvJ+DEvdchQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rUP5bP9H3zqB7RIcOyitG6JmaDFnpxTgFFNZivVyiw9doqKLEtOVeQB++e8aRsH+nWfjq3ThckajOpmfcelL/Skk8hAAmFa9cRTof4kPQVmUco/Jp0EqolxiiLYB8sN40AmN2RoR1EkN0kfEYA/Flhj+RftOXK4OnFBDc83WYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlLPjkex; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlLPjkex"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so63574946d6.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879217; x=1791484017; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X+ldw/xw2D7//WUb0EpwZLJD16MWM3/WSr84Iqew6+w=;
        b=UlLPjkex1VCQFNZkjR20z92fGXnrlDHwMwXuSQLrUnyFqFeIJTbbIxax2wYXom0obF
         BLMHsS5F8B5MW6vaiKs9rKRNKC0UBRZh2ed3hSLMpDhyURHVKixAtumcJ+pz0un2ji6T
         wt1vpI5VgXMKzDQYcKRL2g9pWBFcfFdgy0RM4ybR2dVPW6MP4Ukv5kIsh4mxj6J/VmP3
         mXc/PPbPz5TaCHQ0S+DS7IUuDOqUAFQDbpK3K8ZfQDmQNp0g6RaokF1Th8zNeBTaJ5oq
         EITnk0zSFjONB85kqFa1AeKpYDrv0iprFPevUq1BFNFTjlYmbeN8cvqf5k45aGEXIKVR
         qNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879217; x=1791484017;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+ldw/xw2D7//WUb0EpwZLJD16MWM3/WSr84Iqew6+w=;
        b=pfuPZLjycTgrO2btEola0QaVJGeFCvhVisyDOA551hKKfSuZ5MsnQTSqrcafFB89ib
         bp+kT/eDfy8oWhnMx0TIfQpP/GuGdeB7ICh9UG7cew6P0xBWu3Vm/gt59ltwAqLp8fO4
         BWutRBs6Gwju7lPoC7+v5ANUfi+0OfDUSotIOCaqhj/h+i8D1DhKKIGkQVW8/h1VC8uf
         hVN3Q0VVdnLFcfYwxlKBjjjMbbu4OvEGqjCog1+1DlOYtzhwgtBzcuTdQyogXvtHDDsV
         n3fs/m1SJNUfAExrCf5+ocEU30tbXaSih9lg1Ke/XZ77rTAv4y2uN6g19klpxk4ZCDa/
         u1DA==
X-Forwarded-Encrypted: i=1; AKwUvBx82dZynwJEMGxn29RngitZCi9cn+FTk3QnCBlAwRfmJ7hkx4pvrhABGG0DQ0C/zSsK6Rpu/II=@vger.kernel.org
X-Gm-Message-State: AFuF++kW79XnnKw/c8XTB+nYmQzJkudAx8F3WowZEWCS/sHq02w7OAdP
	jChpkeOV9m4QI/GJ/cTVPvg+twBbnb0ffgxt75iq/EK8ibby1S+51yY3
X-Gm-Gg: AYBFou2PzCn3bsThx0hFFs+8uPRSRDd3rMYntdcTA7zbgyX8jJNgB7KkRi84DMevNRJ
	l/CX55JHIn0TH4qsfLttch0HSCezMdui/vObNaSV4fxTAHW+n2KWKFmixnh5SkNNh3eMVc7yDjX
	j6brT3ibNz5uHRXv34hx2+eAGV0eBv7NEvNnMPjO3gP4D/rj9gVFvY6zT7a1JgJmyyv7qXFRF/q
	zOTd/AkZuIBAgnuqAd8Oj2swh4Yr/6AjYxumeITP2WMeXeSOePTWNT+wi/jMGi2jfKEInt7c1J0
	beBFzTK01uel96lm04aO443aL4WUwZATCX7ZUr1egc3j5Ea5HcSa9jWee7HocaN6uxrB8lagitj
	dRO0rIZk6EP2Tt/qdpHRcrmM2wqhcF6rgw6fr5imoKeziNcq9yLyMTgCav2akE8MDHKZYl2OnSC
	agIvIyqc4fiydfjksMv2Zkz1WgGmPfeEtNHnYHSAu5jNpNi5+iAaJ7J6YthsXqnDyPFUE5
X-Received: by 2002:a05:620a:2592:b0:93c:6e1d:96af with SMTP id af79cd13be357-93cac1f5137mr982723185a.49.1790879216815;
        Thu, 01 Oct 2026 11:26:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::5:557b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca21d61asm13512285a.23.2026.10.01.11.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 11:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 14:26:55 -0400
Message-Id: <DLTPP5XXTJPL.2IOZ3GVZQR4VE@gmail.com>
Cc: "Alexander Duyck" <alexanderduyck@fb.com>, "Jakub Kicinski"
 <kuba@kernel.org>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] mpnic: add NAPI buffer depletion check
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sinfo@kernel.org>, "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
 <179087312824.1402591.13891424496391739284@kernel.org>
In-Reply-To: <179087312824.1402591.13891424496391739284@kernel.org>

On Thu Oct 1, 2026 at 12:45 PM EDT, netdev-bot+sinfo wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

This is not a fix. See:
https://lore.kernel.org/netdev/20260928190326.59784ee9@kernel.org/
