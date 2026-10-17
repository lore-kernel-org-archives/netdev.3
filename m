Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C53B637E
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213452; cv=none; b=VlDpFxPLX/MJUAZ+U2PYtBKBV6JiwqNoTScfXZMjGTHsVOyuQTW9TdW/zEWei+Fo1yvr+dZiQ/rRFZe3o4xcQ7oJZNg+LAOql6IIDeVrqnOXd6M4QianLPhbRTV/flMLABVLCVljLlN+kSZfHO94k0Lf/hIq278wVf37oTr6FcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213452; c=relaxed/simple;
	bh=8BLUOuobsXVPK0Hk4WClUwg69wNv/LObwP6VEuCQQpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pdEsX8yrUGjTP3C5PI5Ry1qMEJQHSQg0cbFmiG8LbgS2tV2hpnxzgkbmRBBA+65Rqo0W/9+ijRofqyR+JhKJSquVG1tifp4qlpZFvHVdxTukZp47av9D1RwiZaNGyYZhzy4AIER0Ei5b8nxZ/icyRbsgaoHIoVGoiFPIwhv2Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIdttMsh; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIdttMsh"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e8ad8c5f80so7070745ad.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792213450; x=1792818250; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gV9/cHPnIlfRbaMaPitg64wMYECZnHJw7L0U4tqnfHE=;
        b=RIdttMshU4J4gmETRCghZabF/+9HEAGQzMJMrrKJSNAopaWrtovO8CnwU3Es0LSgpj
         Yczz/oHmEQ+AoTZqJ4fxFmNZc+tkmAnGzaUuOTwt+cEOfL/+6kAPfEc5tAmj5Mqd6nim
         uxP2OeHQBl6zDMc1bYOEEwztkobBBZcpc1XFpSo435wyqSvChnuO91zdBCHQ+aN+zS4Q
         UkgLq472hju2rMyXV/Cxx3YjafErKeOj6axNLkodedF+WrgyCDemjldnuAEe407xAfi5
         Vtuwr6t6oc0bUJ1E/YivlDTW8ESGqe2mD5fEts5CPRKsIqJOBhIXyRVjzCV9aPcbRH0W
         SZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213450; x=1792818250;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gV9/cHPnIlfRbaMaPitg64wMYECZnHJw7L0U4tqnfHE=;
        b=O1Id4iidl4SUuWrB5ruWGazUvZjNfenWDTcCEDJuJacUqsuBW6E0nX0txt4cPoembR
         uHYSlTz0JqJm2Dvv3ENophy5gopZBSeIiRUlS10L4A+kAEPOxf8ME/k/1DvrTUFqUkG/
         OFue6wHBE86oM/1njNWpcHjbmiiSFEy/MmFDZhHSqyLTCKRp2qSmG1jVDd47bAs0QZj7
         bSc1axhYM3EPCQ402jth8uU88FFkTILBSs1vKzZxk0EL8tNn56x4DIe6ylH2n7R264ba
         cRIKccb/rom8zftPDKKM/pUY6r/86oQtqBMS3VfILecB15xPR6tE3m5ISjJqOz3b0A4x
         GF+w==
X-Gm-Message-State: AFq9FYIEHIuRStelvd4s8f2YJDAxup7voUn8Hp763IehNR0zuEfTXFLR
	aKh2ab4DzZxv80sLZCGnhHIM1cGvI5l1EBGmjJhY3ndEqBSH+4SMbFYP/cH0zRBEi6WGRYirMIK
	j2iy2bw==
X-Received: from plbkm15.prod.google.com ([2002:a17:903:27cf:b0:2e9:5442:b91a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c1:b0:2e9:6788:9372
 with SMTP id d9443c01a7336-2e9a6d3668fmr18323965ad.62.1792213448706; Fri, 16
 Oct 2026 22:04:08 -0700 (PDT)
Date: Sat, 17 Oct 2026 05:04:08 +0000
In-Reply-To: <tencent_A643419B56079E9A448D97922763FF069F08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_A643419B56079E9A448D97922763FF069F08@qq.com>
Message-ID: <atMBc9DNAnFhsR9V@google.com>
Subject: Re: [PATCH net v3] net: unix: reject negative max_dgram_qlen values
From: kuniyu@google.com
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, stable@vger.kernel.org, skhan@linuxfoundation.org, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 16 Oct 2026 11:02:58 +0800, Yingjie Wang wrote:
> net.unix.max_dgram_qlen is parsed as a signed int and copied to the u32
> sock::sk_max_ack_backlog when an AF_UNIX socket is created.  Consequently,
> a negative value such as -1 is accepted and converted to UINT_MAX.  Since
> the receive queue length is also u32, its fullness check cannot become true
> for that limit.
> 
> max_dgram_qlen has no documented negative sentinel.  Its existing signed
> interface represents nonnegative values only through INT_MAX; negative bit
> patterns are not a supported encoding for the upper half of the u32
> consumer range.
> 
> Switch to proc_dointvec_minmax and make the established 0..INT_MAX input
> range explicit.  This rejects negative values without adding new accepted
> values or changing the default and zero-value behavior.  Very large valid
> values can still make the queue limit impractical to reach; this change
> corrects the input domain rather than imposing a new resource ceiling.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Yingjie Wang <1075151112@qq.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
