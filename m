Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858138;
	b=br6322yG4FEBJqr3+n5Fke1u9txiD8GKE/y6w8a1EffacnGDnrmeM0aP8/mFiV19Ez7T
	 y8VtsOfohjR13invJ0+LRErpMfJEFeGef8YUxcRqJ2OXFqpLAwIJ0RcA/wQQ9XPfRA6lY
	 w9Y12zK7Vr+/HNGWGOdGzoS/ptA17tLpVIwtb5vBWugeY3hgCmQdmVzGIaXRUwhFZJ3OD
	 0KhpweZMo/uui5xM/KEEnmRoc//CyCi0fMvB8YTHcqiqhVPnhTurEzlwb9lp5fStfmF+k
	 esDAb+gGKjsnc+/Y+JzeerARAdXJeYrzxg2Mcrb3YVaxka8PomOHZpRZBtzJjFsLrdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jqgo1XywgsdgGPVlo0B4zN6yPIeNTL0VXgREkra6lSU=;
	b=qjBd9DvKlGyN6JSG0mTzaIhJrdqMJkPih21sUVTiQtuEB1GmCrPStUXXtmIfKoxFzrgT
	 rjQpUVn/J8FxkMmBiJCdCem6DSlupkq25kW8HF2+gxcgyVXaa00W3BkaNBABXbR5jCefb
	 UAbp+VdKOIM5HHIc7n9FidMW2RqIPtZmJ2F0hrMPD1LYhB4Z7KeiJUzw64dqd7n3l/0Pj
	 FrnghLapzx6AfcwbxK4hTu06GCQnhJZem05VB77RVHIAyuYRE7p/UaKJFaVFm+rIGki8E
	 hzDRDeiVitXOL80XQcX2g2v+YLv3r8hiLHURiajEStdf+20IhC2CkPQp5PLXfTPux+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VN4LNyDR;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90E606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 16:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED90E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VN4LNyDR
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so1360655e0c.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858137; x=1793462937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jqgo1XywgsdgGPVlo0B4zN6yPIeNTL0VXgREkra6lSU=;
        b=VN4LNyDRn0nF8VT5iTrawyuNKTNtSTLtnLK1Tp9Gir/5VxAldXkG4dm/WbYUgwbCTM
         7Z6/f1LYMDuxLtL7FEl0DkLpaKMqz7heaNTd6yfTAvuTyv97pzNT7Z/dAdD9eJiXB6iN
         2BbyOb3OM5AVgjoZkSPaqr+AEl/Us1oAtshkVkZLhX6U3UnkyivyDDzcheXp2qGNM6UO
         PNK9iUzL9DRTniSiLaSvpOvK5MD5TZ2QyhefdJCb/qiW5aE5QmlA2fWCv2iD5K0C6pQe
         cTiU45HAFCxhM2aKjWBOHJzS6UCrVys7+25yHI9MJvMjokmPavoheC+5Glq81WrPGGmA
         PG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858137; x=1793462937;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqgo1XywgsdgGPVlo0B4zN6yPIeNTL0VXgREkra6lSU=;
        b=YfIJBRhkdeOqebJwYbshMRKnGyadUIm00oJLJisVAQToyFhnn76ZnSrzILaP3uTZWY
         A5HGVoAFtOJ+EIuJZEyQuMthjWIoME3uNFoVde7egWAb51XFlpdJdYUWz79o+3y+WV4x
         mqcbb1XbC0kRcXqtG5rarPyYD34R8NWD/aR3v6bYJzxxcdenD8rcEItLFgbaryJWM6OJ
         IKG0bIcGx2NI4YVy2dKYs7ZALdVddEwVIh7b1ua3kjozcWQAMhXnH8hzTP+btEnRXxb2
         p4g5OjNoHSWjZhU+/kUvl84Ja+grtqwJwClZKbQYxrvtjsh98i8uy1FHMBMw5RzsXKLI
         Qorg==
X-Forwarded-Encrypted: i=1; AKwUvByWCXQRJ+U8FiRztF1IxFMFE9sla5dBHrvfQWRovS3hM1c+Ut/ipnojX7uiW2YikntDLgHV4+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6vKUbXdTPtfgkm3pU9DaofsZSowJD0V1HPazgGFYbCn+EMYUb
	nn03Gu62Yk8l4HgL2MCh+OybHf+kLxtfdCnCxf8Nbhd2VRXKMlL7rvbb
X-Gm-Gg: AYBFou2Lh10nTe4Zp091yAqAn5kXvmdCtWsAdvVhNRi+S17hxr3/drywo5CvnXx4UMR
	IouanSPY2R+hIZNXuYBb8t8LreV73ac7zymLJb709qWH0FKKrzKkxP+kr/LWdz9hY9/j2jvOLDh
	cPeVCDd/cgXigUwjgbdkdr8xfi7faYKAjdRjFj8Ohef3piORDBhs+eExJpJ64Mcqr+7A1g4/0Gg
	m2vChcx/eFj1ADoITxKdNs6YLJ8ywEt+noQjkNflzzMbua14S6u7pN31IQ2zyv+8UDeKfr6wifV
	oNOUJ9ESBCzEnf/hwMKDhANaYzjapIPvOvo9ANYCBzQ86D+plKgo7mj+xG3FXQDSCs52MC8xyq9
	28KXsWV5TJYlnGGAB+jdhvgdm0cTRwhMNXTjvfb3Ot5PIS7duq/EaVbsGE0EtUGeoRqxPNgN4IH
	m+ZzjnKiAtUCBAp5mk7E2DLHwC5cDahyrMv/x4Audg1Oj6nm7PC3bhQ9ziAiWjl7B38TG1fTE30
	rm4dTWMs/ywmD8Fs4dMbk8EowxSiIogBTBj1QaSODRvU0cmuUmeiAM3sguOmfEYsQXYdPAcjtDF
	XbTYR9GRGDY680yI3UcPayvP42gXWT0C6EbxulkmTn95OUsyKtx6YwLQLp2cv+1LWDygQ7gemt2
	mNpTgK7bvaWIP8o81lCNOb6PI6jzyhNu06VroZKRc
X-Received: by 2002:a05:6122:1c07:b0:5ea:a1ad:6376 with SMTP id 71dfb90a1353d-5ec230a26b8mr706060e0c.1.1792858136874;
        Sat, 24 Oct 2026 09:08:56 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234277b8sm2521988e0c.8.2026.10.24.09.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:08:56 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:08:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>
Message-ID: <willemdebruijn.kernel.288f04be304a@gmail.com>
In-Reply-To: <20261024113809-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <20261024113809-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Fri, Oct 23, 2026 at 11:09:17AM -0400, Michael S. Tsirkin wrote:
> > 
> > Okay this seems to be converging.... But sashiko did find some issues I
> > thought are best fixed. Specifically I thought of a better way to handle
> > short gso in a tunnel - just clear tunnel gso! As a side effect we now
> > fix up the checksum for these dodgy packets like we did before, instead
> > of a drop. Good. And more false positives that prompted me to write a
> > bit more comments. So here goes.
> > 
> > Apologies for reposting so frequently, I know netdev bot will be unhappy
> > with that.  But Paulos's report made a lot of publicity, there is a lot
> > of people looking into this, so I feel there's value in defending
> > against all this class of issues sooner rather than later.
> > 
> > The issues were mostly found by code inspection, but all reproduced by
> > me in a VM.
> 
> Ugh. I found another wrinkle( Firewalls that shape the payload.
> They are currently seem to simply be hoping most traffic is CHECKSUM_PARTIAL and
> only looking at that, and that will break.
> 
> I am not sure what to do yet. Extending the sysctl knob to control what
> happens if validation fails: pass/drop/complete - is the best I could
> come up with. Or ignore the issue. Or just forget the complete at input hack
> and drop if we can't figure it out.

Sounds like such users will just have to disable the sysctl for now: pass.

And update their firewall, then reenable the sysctl?

Does adding a third drop option help in any way? The sysctl is the safety
valve to go back to old behavior.
