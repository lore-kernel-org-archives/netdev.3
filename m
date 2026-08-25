Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE3EA97A
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648947; cv=none; b=YsNSTBeTeftDq4IWIVDyNf+nFfYSjENVBjplPfOibOVQ2yVpXodcIxtzrCHbXGcdhGAwo3yKJ5/iIhpGjZwayBI3sjMpJgiVJHSMRfgIfZ4sPQCuKvx17e6FgiRPvJYKaufplDBDx/TadLHSVcoHWqaFAyiqEERCyRuaviqxIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648947; c=relaxed/simple;
	bh=vPvnBIbcaVO5kDtCxP3XX7hjDZYuN/aVlUrCT8nq3xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myc0JKwazk687LPha78ZcU7q8mviJU9HEg6px38rMfAMZNn7ATVNSpvsltaM2NSTVFOJU7Fjzz5PYvyusb4XJxE4vL2X0rZv98g+cveNSRkS3j/JtBFbsh6aYnjHbWQ9zSgX0p7heVjdqnmnbcIgzLAFn15LPfhDgOl1V6QV8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvWunw6I; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvWunw6I"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so8627530a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648942; x=1788253742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knxMiTKLNCoBhCFluS6hziaaSnZ0bZj1pyN+wexD/R4=;
        b=CvWunw6IIgoYX9Ajn5aC+qMwUuTBO4Y2WdiOyoy2zI3O1ycND+GAjbnUTaCmDJzywu
         K+eiXeCZLRVwW8hDNNcZgS8pnomca3fOaAIaK+Ucp0ETzyHfRcxk56pyx4Um20DyIwlA
         4DtUVVe7iIaPm0Qk8Jqen9sQGuZkWoL2MVnofAs3yfewIadNzBYKYw+duSDRRQNhGyJv
         p0L7WZS/7MMPl80zUVzdVnf2htqtZwORFMLQSt6+xQi3kKwbjrAqFpiYIXXAlD+JKuIV
         nzxluJzN9csLwkV0kk4niFGrxoi9ZtVi0WhETEE1LEsEnGtXeYedvx4fCiF18NwZNEI7
         Sszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648942; x=1788253742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=knxMiTKLNCoBhCFluS6hziaaSnZ0bZj1pyN+wexD/R4=;
        b=gWsnygmPDxsZztPMbi1zvI1mBDQYSWr/nMmCLicTDU9WlPG3j1FYnqKUJ1oQPYcxoC
         +OlaxYiZbvHpYdYFapVw+GhArU1Jc0FhZ6/79IoZW3r1Z9r4Fb+hvV8RcGaPMxtTA50P
         X1qQhesJJIu65k9SaAS+FAu2a8CJdjoDxYlQfctD+8y7Hc9/bjzr9gJowhGIFK+1Lw3Z
         peKM5Lm7fdw3Pm2rLuBLhyruSIZZkjJT2vYHX9rotY//QlkKGB5OyxiwQplvbfjU18q8
         YwHtQi/vhfEiBDvVrO1jvJ2/h2i+KnA/M2Ppt4OeF1B7lnJJqrezeh0MSQ+l1qa8JcgA
         PzYA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1LxrWt2XeCxJRRr7zeurR4UQ5kLB5FkEdXBUhV+tSr+7iqPJIls/VORBhriYFjI9Kkh2EZyk=@vger.kernel.org
X-Gm-Message-State: AFuF++m4sJMJVMsj3D2lROfXHw3JfKbVen9Al4Uel4Yh/H7ZDMkNDF4h
	GSH8bknjxvPhK8LF2za/1Q7kuenU891asXgs+uhqdJVPqGtbvtZC6TMh
X-Gm-Gg: AR+sD11AmY/r4r6IjkP0+bboO/1RJbn1mGCad2ACyzAHVw+JRDTVkkNjKSIrGOKtFOo
	kuS6L1ezd4FaPzzC2pLioEjoioBAU+GhzV6J3wfxnPqlYFyoj2MegO6HsVamvuBKxOvMZJNAcQA
	RD5VutsgBftBxFyfGxt9gceqzisXM9waXdN17BKwUkxx1JqlhXXIBpNB9gEGaBky1eHLuIZ4xVf
	gCwaY9UNiqJQifAslu7lxdM+IpVjpzUrDFqrMX+aEzUlrRZHoMlt0HR81D5yk6+rIl/jn/H4kKu
	cjD3nVnA3qy+WJJjsK/nSMo06u48VpoMr5RSZGGLey+j2ofmScKEV5D/EQgrxVQjnavvArjgqNf
	W+CxaiQP/cyUPWkSs/Azxp3VqEqoLMdm3jvJnzVt83bmVZSKg3lvCeRuOejQ4MPNC3ey8jN5WzD
	Xjzs7QWuf5Cf/Do33KwgWkhjuLKcUPbblau9ZSReEvcl99bq/hAcLzoGA7hoOMpYBY8IgAuPkj7
	m0CyKSgtN8VTT0grFXh1jAMY9ssCZamMGTx2v5SaaBmfvFHmAQg
X-Received: by 2002:a05:6402:2109:b0:69e:8ad:5162 with SMTP id 4fb4d7f45d1cf-6a582af9528mr26632422a12.1.1787648942074;
        Tue, 25 Aug 2026 02:09:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-2.dynamic.spd-mgts.ru. [46.138.191.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e02a8fbsm18343304a12.13.2026.08.25.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:09:01 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Zixuan Chai <petalzu987@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Ren Wei <weir@nebusec.ai>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
Date: Tue, 25 Aug 2026 12:08:42 +0300
Message-ID: <20260825090843.64570-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADTzadL++bLiuYUrzDYmTbEf+bb=hkT-bxBQYCtxZscF5Z6oxA@mail.gmail.com>
References: <cover.1786088695.git.petalzu987@gmail.com> <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com> <20260808194001.853434-1-kuniyu@google.com> <20260809123335.GA2443083@shredder> <20260824194741.215979-1-iprintercanon@gmail.com> <CADTzadL++bLiuYUrzDYmTbEf+bb=hkT-bxBQYCtxZscF5Z6oxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 25, 2026 at 03:23:42PM +0800, Zixuan Chai wrote:
> 1. take this minimal fix through net for the crash, and do the RCU config
>    conversion separately in net-next; or
> 2. follow your proposed approach and address this as part of the RCU
>    config conversion.

1. The conversion is net-next only and can't be backported, and your
Fixes: points at a 2016 commit, so the crash needs its own fix in net
anyway. I'll rebase on v3 once it's in; that's a few lines in
ip6_tnl_xmit().

> Reported-by: Zixuan Chai <petalzu987@gmail.com>
> Reported-by: Vega <vega@nebusec.ai>

Sure, on the patch that handles the half-applied encap on a rejected
changelink, which v3 doesn't cover, with a Closes: to your report.

Artem
