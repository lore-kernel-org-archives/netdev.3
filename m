Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DB515982
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778272; cv=none; b=RxRoOoOobDSmln6nEl6VZUY5VsXbscWEm/LvVj2Y1EEgvu02rbh8jxNqqbSFfD81VpTOgdwvabXrIno91sZad73gF/gj4vXqy0swe8bApcofMkGWOT0pH6nIk/0agByGuIJRi1OccH02GD8Mp+V8YpYIeQ2rq+AQp+wapY5GNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778272; c=relaxed/simple;
	bh=IYJIMNtdJcCr4u6cOiHPBOmN0vaj7VFV7Qc18iDIhTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sBxbAb3H/BqunjEDZtRCgCaws0e9cSMXIpW6tc9tcXEMK/ARwFvU6GzwnSp23RqdMvixa81AX9WjuTsza1WloevBq1I/rvBSWSwkgBxsmiqZ7TFRi2gmvrYz1/L4h7MyGuI5439nn312aU3m1u4O8CEOM7iaHqkwou/wlOMeb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gctlW0aB; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gctlW0aB"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ecso5055463d50.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778253; x=1791383053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VSBcqx9koa8CG47lz1u32c2OePWRmcPOrAz/9TDxhs4=;
        b=gctlW0aBm4DLTLgSxnEHcWgiUl429uuP6GkZ1zsXBUrorWGOk3IvMZLNoWLUCTmPe5
         EHoxCT7Gri9p/hMd2O2WXit4LgM3E+bUJ3JiYNvuuZFKqG7DK6FwGLDP7kYhfGt85E4k
         R7Fifqx9zWevLeyGv63jc6PR399/An8qleoVSrkdWAbaLwvsGjkiQaJG7i8V11GCzBED
         9+LYHmDQEa3gbrg7mOohtHu+GgvzP1h6flB/0DTxyi4lVT9Ya0EETjTac7XbE7wjf/QV
         zWds7vuSOafFahbeolJxAJMChIvxkMayHd8RJ2l6X7YyGY8p9WArV03uZy648Kr73aev
         jiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778253; x=1791383053;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSBcqx9koa8CG47lz1u32c2OePWRmcPOrAz/9TDxhs4=;
        b=IVSFSlgMKEN3dKhrbynt3EGrZmp2AucoaeQD5HnvD9aFCawcUoNBCu8Hs4+oaDRROX
         YSokl0awywnI5BtmdtvLBMWY0j9nsldnd/DBBV2+c8LkxOdSrDwmbvlvDtXPTkPSIg7h
         1H9u+wztRdkJhGm3MHO4OhLyHoLiqjriot4WH5Oxs8nj/geEILQ2sLHZVbuK5qTuvyFj
         lhhHlgcx5bsX4x1Hze03d7ia7V0hjLi6dmzc4yKfPy1YtlBVPlG3/oxgQiwDhHQUKj+E
         BT80ZAtQFoglbhFbQwaEzVm5lyX6MfXySeyQEC/i8xZo0XUu/AgfiMEAMA2hztPi1xro
         x+7g==
X-Forwarded-Encrypted: i=1; AKwUvByyKxuJfm98UEOeFwg3cRVBfOeCaQcB/KpoGXZAOREwGYin+9sipIXHUNQmPtze9QNMIUtvufo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn1ybtTGktQF5nCHSAHHfyKAs1EQRR4snGy3AIdsaSWeivlp3c
	G5bTRq4orpvVApw0bxq7roUXwCIKQY7dLpyromBc8eo1sJ9wpm90W1At
X-Gm-Gg: AYBFou3UdpBwEjRVTlPeb6r+I1almgPiAb8eF+V2UXk/d/ApAGzsxw/StGtEheIHM+0
	6h0nsJeBlJ034osUwSs4T5q5m2KVYDS0uYTP+nqbtoJmwNwtf4SJpYGYt7M8/GCEeIAnaA7DF+i
	GQpcAujaBWE793NND13tqVuHxcuuqcGIsjgLjLSOWea/FCd5R3xifXSQDvYA/r++SMtJ8DFVeNY
	rZU8LH8F7LApFZCHefX9hx1Xp+9BfnTQ8EfnK+Z4gRlEPM6ZqjFiyflT6uGo9EgDfyJX42N2K18
	K4l1UV/b0Zc+K46p67jqIZZ5N/iWqXOAvR48E7DiCj+ANn2jIPhmXlJhrEzcaLF2i4sbvRarzo4
	k7hVa4NW36UT2iQCely9y4JYy0LwOQKtdU+GOk5/O8w87k0CFgGwguFFGj7QJgFtfEUPaNColkG
	mhU6UijiMFpb0jp2PvCnB4y6zi11oAC9s1cWhwR/PY1mmPWj9QD2FvXc7cUkvwIGZBFXH6s5Hjv
	IoVmhlSBUSFQD4S/94wBYLk2iFwGgBEFBtplK48iZCBbfThDgZj
X-Received: by 2002:a53:d014:0:b0:66f:c1bc:880c with SMTP id 956f58d0204a3-6768349e783mr477179d50.101.1790778253013;
        Wed, 30 Sep 2026 07:24:13 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6768152d0a8sm719338d50.14.2026.09.30.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:24:12 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:24:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: lollipopkit <a@lolli.tech>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.276ffa719c8ac@gmail.com>
In-Reply-To: <20260929153426.90278d054c98-a@lolli.tech>
References: <20260929045433.59435-1-a@lolli.tech>
 <willemdebruijn.kernel.570e0a646f4@gmail.com>
 <20260929153426.90278d054c98-a@lolli.tech>
Subject: Re: [PATCH] io_uring/cmd_net: drop unextractable TX_TIMESTAMP skbs
 instead of requeueing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

lollipopkit wrote:
> On Tue, 29 Sep 2026 11:06:26 -0400, Willem de Bruijn wrote:
> > lollipopkit wrote:
> >> Assisted-by: Claude:claude-opus-5-5
> >> Signed-off-by: lollipopkit <a@lolli.tech>
> >
> > Is this a real name?
> >
> > https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> >
> > "a known identity (sorry, no anonymous contributions.)"
> 
> It is not my legal name. It is the handle I have used publicly for
> years, including on GitHub (https://github.com/lollipopkit), and it is
> the identity I sign all my kernel work with. My understanding is that
> this is what d4563201f33a ("Documentation: simplify and clarify DCO
> contribution example language") intended by "known identity".
> The earlier CQ-full fix (3a3d93070c5e) went in under the same name.
> 
> If that is not sufficient for this tree, let me know what you need.

The commit you mention did remove the explicit reference to pseudonyms.

I don't know whether a github handle counts as "something we could check
back with" or where exactly the line gets drawn.

If anything, this does seem an outlier compared to other sign offs.
