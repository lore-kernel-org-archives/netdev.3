Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29193603E9
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896335; cv=pass; b=hYL/+oREEc6d84A5FUdSksb/Sv8g9KVUWe0X9eIFVvQPbnxxNH9QF51JXVhJ37WO0y81EZoV4jqnM7uVTfq91iRhXm29OwVBXwu1n5poX3xSWbLZgmp8rpRSTMk6Y3pGt3NjXyJkcqbrp1WHdWl3P8rkZAsYSPh9SjTi5+t2+tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896335; c=relaxed/simple;
	bh=sqKBSuTZ+7jhHsloBIo37CW++VR7xfCKmMq1YQyy6A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r17DYjrHivInLrSt1s71Am562WDCdyAnbvTHyYR7FtI8tMyQKMkP4hfRQGJYOtbP4HDxi5/mNhYkMk9xTRmI1YAZ2vdaqsbE9Gdcl3VIfDu3OzyZMFvBMr1R6wx7lw7WRhkZJHfalmnpSef8zxAeiKeD3lCn0M7wfb3Xi30TXsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5p+6Lt+; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5p+6Lt+"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10e86e52so159161cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782896333; cv=none;
        d=google.com; s=arc-20260327;
        b=DJHCRRQsCfiPPwV5weBjmAB4tWNIGHHNxdlR7+wV3D3dxiH09qgmz6QqsAHouVRl6L
         sY5oGCij2xz0smdG5mN+EcyrG94p/B/L+tIvghVhNpM9a0sTaf0sDglyhc3SDrZEewOl
         kiMZKQ0boAdL6XKwnp3aFNdODOYv/lncLDIlEuT8nSwuG/QCVAXvi7bkuQzpqJ2AS4Rb
         WJOI8ruCPAu3vmH71rOXfbkfpZb0tuINrrZd6dzlswMeiPKKeSB+SwdkL6B/asXqxqEv
         ii5bUScp+z8k2Bczjf/qLZbjxEoRPgmn9WApwzMz6EMvW+81VjJNBsyd+XgSCIbHxhYs
         33gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sqKBSuTZ+7jhHsloBIo37CW++VR7xfCKmMq1YQyy6A0=;
        fh=7LjqgKv/3WKR1wwxkZfgLnMRZNSCLQEqK4TLqbbwaWg=;
        b=bYIbHj3VWhqEpbWwMrwlBB4qmMxso2IgsNTEyYoGoFgpWqsiZxO/ps16c4/O5et2B7
         XyvbC5vcavBSQMztF3Y/MWg2dZXQWV5Fs9BVURxRK8i1PTDrJQ9q1HGENWnMgYtXojg5
         r6IRfAD4aqbR1Ql/xWuy0tA3dU4jSF2QfWMuxhuLrx4o730lr7ctF+yv0OYJS9c2Hyyx
         uN5LJWdxtVaVLK61fsHnZaashPqcSsq8UL6F/jZfE+MFGvOBvs98RAHhn57XeZN9kP+p
         dnTEfF9er27mncNceFoU1Z90MHP3vRA1IROUMkvvaF1IuXLP7x2MsoMwG3ksfP6JnPld
         Lb6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782896333; x=1783501133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sqKBSuTZ+7jhHsloBIo37CW++VR7xfCKmMq1YQyy6A0=;
        b=a5p+6Lt+hoMv9LkRbad299jZW2WuKre4zcaaJL4Vnp5wDc5L18twLyTXlt5gMko5wT
         ILm4ELEVvtffyLvZmFyHVuHZ2sOmF6ULm1eIhkW4MEshfmMZif6glwUwVgRsHn3K1xVZ
         CGacqc6MBo0PKMs2t2lMfcWKkGltpHqrhqMdPfXC0WEwlQgCOJTKOtiAn/J1lw/MYh/2
         XzDYIgZmRj7yUSODj1Iq3W4mv6UApug9x3O2sdC9Q+vHrtbqUlGzzQ0cddneRqVGMLMk
         Z1mvrjU8LqCFKLliFz3pm8ftbxkrEz03Xnv/4Lhprx0LBtIMxNv/FL2VPMX8SSDe1bMX
         UCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782896333; x=1783501133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqKBSuTZ+7jhHsloBIo37CW++VR7xfCKmMq1YQyy6A0=;
        b=EabzVRfBDyNjO5DbqKfsA0/RNIDs787r1X6+v0VYQdCp3MPxtqjBDpaEjoaSYAp8CX
         SDcQ8o24jesWzF+MYoHwvk7c5dqjRI2tJFQz80GNGj84THya+hoFxMz4PEzZdHN63fA1
         ESamUMuhshw3E1h7ZN/cIe9gXr5SrmtlwVoCC6PLl+lbtNcmGE+k/BPGZ9Mz3eGtKIe4
         3H9yTgKZafC1suFBQddlbpmGInDf3kwvMOIehyAE3Gyzg0//Ib6ZKq3F82rW9o6jX5py
         SfXSfkUDsHIgfL0nFR0G5jQ7d2zAJxHSJ8wEiZ0bNWg3dLgk3o7scTnO21MfPMygffw9
         WEuA==
X-Forwarded-Encrypted: i=1; AFNElJ/NcqSBXCPYKGn2fhZ1MZWHCff/Rg4eVXJUv08KyVBCDU+so3kFto3b41QYIPZUooXLMipVp8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUr65AzYEStmsLJQ2nufrruFSf097JN/SB3uQ7pMW7wJOEsfX
	L+Hl4HeGM6ln+PefU9qsVUhiLsFtNqPUQzkkkxQSDZ86am+WOo2AWcRrsDB03LsCVvbIImT0hIX
	ktyUh/rCf6D4zO2TSJXwrv88mv7uIImarwscuArRt
X-Gm-Gg: AfdE7cmMRmVRSr7Rhfo0aYuO7p7N7aWPBifgYxD52MEikHDxfKFdBqYMqZjD1gXa+mV
	jCmfjoG12EZn/EyBTGPZm4g2zJnhiSgtylokL94g1f3CFdx9WllWCrOgpAiWq3QTz8AZLfpC8GN
	wJM7gSe48SI74MUtLLp4UFpNc2aWzg9Uobkmr1iCB3VuuVTkd/15OVHfJSTByrMM1xsa2aNyqTF
	M7a2Vy5sPFb6MM3zSwmMovBkQcCoPryLo5fsEDp2Fr2+b8F+uBPtXGYV08q2nRm0MmaqSK0vp7J
	lC0nLCDIMejqWdECoJyj280eyeHJuBfMvriq0/BarBERrZAgEk0HxUohFQ==
X-Received: by 2002:a05:622a:1489:b0:51c:289:6979 with SMTP id
 d75a77b69052e-51c24ad22dbmr4359061cf.21.1782896333014; Wed, 01 Jul 2026
 01:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630165934.GA1227354@shredder> <20260630211527.3365952-1-kuniyu@google.com>
 <20260701081105.GA1289614@shredder>
In-Reply-To: <20260701081105.GA1289614@shredder>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 1 Jul 2026 17:58:16 +0900
X-Gm-Features: AVVi8Cc1rAr25dd49A9JO9lvFPQG_n_mwEhSvbyWPb18EHHe4GPs2gGpkEnaGN8
Message-ID: <CADXeF1Hp8kJgDOKsR7bXA7ZW=r9spycEWmWsK_v3KTN_qo-KuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, jedrzej.jagielski@intel.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:11=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> I agree, but let's do it as a separate change in net-next. The current
> one line fix is correct and fixes the root cause. Clearing the pointer
> happens to fix the problem because it relies on mc_hash only being
> accessible via dev->in_dev (vs reaching in_dev via a different path).

Acked, I can send out a separate patch for fixing this part and keep
this change as it.
