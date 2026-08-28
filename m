Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0693391E58
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936048; cv=none; b=An7TnkMOJVsbX8qHCg6brMadn4Y5kCdTwC8p+rFZyHyrPKQJTE9QrJ2UVP6V6/IbzglSdP/Fcm6qNQ1zSLl1V43P8kN5RYvcBzu0sd0bgjcrLA4R5vEpNQJpRLF27Vl+PwPUNGOHbhrw8nUNHeyvhgRGM1gis1XTnqHht4YiwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936048; c=relaxed/simple;
	bh=xV58Vw1wCq2qg8UpHCbXJ07X+09OeIqQniW9rzZXcOA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fp2iMLjeylSaqlDrspKDkcrHQDrqVfZ4t6HPUaYUtZO+l7xjQzmsS8O6hEhQ5RxnYNXdu4ek8T+RSBe7HZsbpWWvfuWDk3SXKDhwgKWap/gO5iH95e6Oi/ZICLjG6jWyC0zZ+OkAmam5EtBV4qXQaLkH9B8nMgY3t71K5ewKotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQRVBVUU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQRVBVUU"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f18c0e03e3so726903a34.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787936043; x=1788540843; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xV58Vw1wCq2qg8UpHCbXJ07X+09OeIqQniW9rzZXcOA=;
        b=eQRVBVUUAsgpXwzA5UNrPGLyTJK+ESsEsK+XvgKAlzSNWslSH3+1RSA7r6HJRuhG2d
         L6j1MnX7oPKxxznbZg3EQqYA1xuI5paqWMygsslG68MVEwouRrjCAKOumopp1VpRPlzm
         XnfFg96mjI358FBKeAt2L+ys3YcDFqEefHejNa6olAU1zJdryssH95zeRF1BZy1CVQHY
         XUoGcT3E0AhZ7JzlTfUXudx32slWk3JREpFpWVIpsWiV53dqlL0J1fYZIc0jUbQ9WtS/
         kzc9PRG1hEcziTingtKQ2nIF+hW68rrYI8RX0vKCJCwSCg2J1yLBsg8gdKmJEbEaD8Wx
         AgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787936043; x=1788540843;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xV58Vw1wCq2qg8UpHCbXJ07X+09OeIqQniW9rzZXcOA=;
        b=RVdPRt1GwSUoOUuKfYwJJ2rVLcSjIpyOdKhh1q2SS/4faOwaeDy9x0w7TmUMDgVGr1
         AmPNOJVUWNJ+90C+bvi6QLoZmqcl3uiPhvJtYg37rcejfJK2xizmL7u8eXPGphnpdzSP
         LoKzSHfWbN31KY+YPr1UlLkIgRQfxQ3gFL675o7Im9zzDf621dQiL+FhsMGu4HglbBKF
         qyHlDShu1qUuqVu3eEVXbKeHzaDkBKDq5cSvQWd4Jbyd5huQ0s1haX8uNaSFJQ1IZKLn
         X/evL2d6QuiO/cmWQyJQ3BhzVIE+hhOQWT6Nb+gkSUbjJEuGsQNed2n3cuIW3EnrEhxe
         sPDA==
X-Forwarded-Encrypted: i=1; AHgh+RpG0+GRbXMpwGrriFWX6oqa5nA3Ke6BLRFVXYIFAlk/wHIJBBuhQIg8Uc8gXO/b4QBN5fSWoBE=@vger.kernel.org
X-Gm-Message-State: AFuF++lwm8kt+HIIJ9V8InTgjlP8CghNTpFLdswZ+kkmre5k/ozyrV1t
	yKC5vW0Mtbi7BG4O3GZNePA+SWyIWlmvemOdBzrJoAPkKqA+e+zGqGqwpGMMN6BF
X-Gm-Gg: AR+sD11kc9yHmSKTrWMqZpI05tWe/01NMsLYOfAtX9iFEhnegbkHkMAmj05UKjIjIsH
	0TYsYqZ43EvrVAtKYlYlnV7NN5EOFVbttAOuwIaZq5IUuf1WbkPpuxoqPdqDjFB3XdGsPAurfHD
	gfdRfGAg3w7JzidhJgF1xvBGF28WdFlDk8j7QKmx81DEL5i4vbkvyr5qdxoTeqG00hOgIoFXJ3V
	U3K6cMBsY78+jI4VLY8ebtYHSkFIIcGNCbmVVFanSEPUo/cgXwbkFU4vOe/f4Mv7E/rcJuwDPxr
	VXehHAzXfozvZ1Sf0eauzH9Yh1LKqEJmf4xf4yn3IVmkEBTcOZBtLdogChQJd1xtLU1fHdnWdGp
	nXkEPwpvhqoTt6CLdaw9Mcaj7EeIlYFSrM6AC4ni1JJdOJZYpzUEcRV5b/U99sipsVCfcNNCSrs
	QOkHotESK/hYJeL5AhCWk3L9MqSvQiKyTJoTCWv0fSRDS5/ORINoD5VnY=
X-Received: by 2002:a05:6820:180d:b0:6b0:589e:42f4 with SMTP id 006d021491bc7-6b1c66b745cmr7372417eaf.20.1787936043165;
        Fri, 28 Aug 2026 09:54:03 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce122df5sm2041447eaf.5.2026.08.28.09.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 09:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 16:54:00 +0000
Message-Id: <DL0QFI20UBL6.3BM3CZWLDS1K3@gmail.com>
Cc: "David Ahern" <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Arun Ajith S" <aajith@arista.com>, "Roopa
 Prabhu" <roopa@nvidia.com>, "Jaehee Park" <jhpark1013@gmail.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next] ipv6: update NUD_FAILED neighbors from NA
 messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: "Ido Schimmel" <idosch@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20260813233344.445265-1-lfqlee314@gmail.com>
 <20260825115226.GA1338930@shredder> <DKY84BEFKL1S.1BZWGQTGRZLMU@gmail.com>
 <20260827090516.GA2014023@shredder>
In-Reply-To: <20260827090516.GA2014023@shredder>

On Thu Aug 27, 2026 at 9:05 AM UTC, Ido Schimmel wrote:
> On Tue, Aug 25, 2026 at 06:07:44PM +0000, Lawrence Lee wrote:
> > Sorry I should have been more specific before. Maybe a better way to=20
> > phrase it is that this would be analogous to IPv4 in the sense that it=
=20
> > allows NUD_FAILED neighbors to change states upon receipt of a NA, but=
=20
> > by using NUD_STALE it remains consistent with RFC9131 Section 6.1.1.
>
> I think that your setup is quite unique and I don't necessarily agree
> with the statements regarding the CPU load, but it doesn't change my
> conclusion: IMO it makes sense to transition from FAILED to STALE when
> receiving NAs (most likely unsolicited given FAILED state).
>
> Mention in the commit message that trying to resolve FAILED neighbours
> by periodically probing them (e.g., using NTF_EXT_MANAGED) adds extra
> work compared to having the kernel stop ignoring the information that
> it's getting via NAs. Also mention that the approach taken here is more
> conservative than IPv4, which by default transitions FAILED neighbours
> to STALE upon receiving GARPs.

I will be sure to mention these points in the message. Is it appropriate=20
to credit you with a 'Suggested-By' tag in the commit messages as well? =20
I'm not sure what the proper attribution convention is here for commit=20
message content.

> Note that you also need to update the RFC 9131 comment in
> ndisc_recv_na() and the description of accept_untracked_na in
> Documentation/networking/ip-sysctl.rst. In addition, please add a test
> case in tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
>
> Before submitting, please read:
> https://docs.kernel.org/next/process/maintainer-netdev.html
>
> Run the CI checks locally:
> https://github.com/linux-netdev/nipa#running-locally
>
> And LLM review:
> https://github.com/sashiko-dev/sashiko#1-local-review-recommended
>
> Thanks

Will do, thanks for the suggestions. I will submit a patch once the tree=20
re-opens.
