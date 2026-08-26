Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152363E49F6
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741402; cv=pass; b=pzVBnBtHPdVXK0wzB+r/hQtCgnRT8AVKaiNEgd7Im2rst83vDskkueNPLfRn4GJn2SM9rD7KkKW3cfVHTYwccbSBKrrM2SnTny00fjyolXhoCyJpCsPfGHoBt+PoiEiq8sOQnxlzUFEEkIIv/o6urvTFE5+FvZZVRqgRKK8nw1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741402; c=relaxed/simple;
	bh=OZg4U7BnVFDaScqmyvwpcLtjOZbPHS1ILvUCZF21iy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnbs11YaY6QfEM9qkKjh8TO8K9+DMP4b/bD3OcKb5UBerCHLexEXfwFDeDXbAZOOO61dl6edm1+SdD4pLJSWlv2T9W798soDv20flWbDaJ3so7QUd/JvmqQDnt0ec9PHBRgSg15O19h/2leBk69IxaEKvGesKNIgIF+H77P6B4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5cvXRIA; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5cvXRIA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c149c5722so6698401cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787741388; cv=none;
        d=google.com; s=arc-20260327;
        b=nXsqAqibC7NL+9WZWd6AEHIjEc2mBJT4WmVs/vvUDo8TwJMM0wkicV3E2ZTtSBKhI5
         DW+JbYAnpf8h9ZhF1MwIkfl6B002KAr2/e1Hd619dV8r09A4gXahZw3mUkv3LOIcAJ7X
         aKzZEAzFlhLeX9aAx9SxSnTOhwaMOzU12Q3KF4FfHo6S4UnvXYvSCPzj2672sZPhxi/l
         aLWy3QxA22EmKUhq4jGoUJsg/aDZNtwzWMHsmDOfx2A4s+xAXtgZzIFDCudhIWyf0BD+
         d0Ct8Hv1XpRyjMdO7mpv4dEPbwfWx4/JQ0lK25F+Kcp16qgUWIuzHrb53pLMVrJAOU2p
         Y3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZg4U7BnVFDaScqmyvwpcLtjOZbPHS1ILvUCZF21iy4=;
        fh=Pe4SGzHOuAl7Lx+MbS7JdHw9I8fV42hxrNIuHX+B8RE=;
        b=KH2wu+36tE4ESyY1M96sJSBzFrtj0JMHGiBIxgUmwIuz/1A/NMsxI+tCl34NJLJ1xv
         DxtH6eD9VZ5VioKXhjW5GjO1BLOBJT9C4QYlDlmYUHER4Gcjrcbs+IzamGUk4zzLRKj5
         VLM34P5i24z14/uNi0CwKxsipKe8UhAHzbAcZueiQ70O7TlS+RyY/g/qXMyfUyLLVCsz
         IcMaCIpY4NKV+7yqHY/05s85RKzVEWWqVUcnOWFPkypiY1sQiCtfs+L3SB5+5ZPDQEK5
         o7coxUv0BOOuxLivZUuuN6qCGpkf64Lsv0XizNF6m3yDVSWN1N3WGqH5simdNmuTWcS3
         7aWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787741388; x=1788346188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OZg4U7BnVFDaScqmyvwpcLtjOZbPHS1ILvUCZF21iy4=;
        b=p5cvXRIAuOg1kxPMjB6N9UKcHGUtP0MASVsnbLqgR0WpcJwZsgAJ9rNVcUSft3+KXH
         Yv+yRTIzekRMOC/eT1jfWmY/L5HdqFOFCQbs0EZK8OI2DPqIFDWTfUGnMRntJV4kDDG8
         PsWdQzT5Wl1u3mmIYiL2AkB75VTvCWS8iIOg2FX2b3VlcmVTr0xHByBhmaJUi0uctxjJ
         nTADQutvNSGsxFZNXKF/1vs8D1QOu+6ANv/g5MJm2x5qZNj3JvKM5zPicfcoSnp6Nt9s
         T+jHjTsq7aC3lzkzcNuaLP+nFA3TiwxY2y9MmHOBVoMKKcYcDocZpPfzbv+nhb2qSGsA
         /1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741388; x=1788346188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZg4U7BnVFDaScqmyvwpcLtjOZbPHS1ILvUCZF21iy4=;
        b=XmfBllooTLZBBOHz9KzymYuza5usHF8TqPwoI65z+ELfnZQY+9gV1fUtWbVNI0KHY1
         qd5I/72GOtLqLt8U3FoEzrzgBs8ewWGo4naFtHe+4L7xm6P7Ma0FVQ5SoPXlPlKU5WT9
         P8p4WXie6yLbxGb1udHuaBcUaBKXq4DdcxRYvkcjQov66KQChDiMUlSB7qEQV0JeObEj
         TYVYJEDoczGHntbjZ9ltxIT9U0dfs654SEl8VCdA90ZQa3SpoipD5oQw5BE070/JkG2x
         vxXVKpU3JmXZtRUIAE3gaeLT0bIxmKh4vgjfZWSTqX1xawWEGR1CJUSdep/Tx6Awr/Mt
         Kcbw==
X-Forwarded-Encrypted: i=1; AHgh+Rpo0TIArKl4ODPx+kiXHSgvhv+uV+bZCMwh9FY03kQmhGVPAp5ravebK+bCebNeBs8IG4s/r40=@vger.kernel.org
X-Gm-Message-State: AFuF++kibl3PYqIGHeuukjcw9PCMwTGpXOa+B/odE0uBkpjVKen98sCU
	N+KV1R46r8M7AvPoUAxq7JtpRIkleG7g6uY+1lQttXuHuk++GudUpgJwgqyr6yuMNh6/pm+5N1m
	8dneEjgWl0d35130ncEjROVZi4L9M/GkvI+HLo5NhewWXZM3ckUm+78xh3/I=
X-Gm-Gg: AR+sD11fmhZAwKtdVICkS8IZZgFBNtfPfI6VBkVSOqAzvy7+KQKFHAfmbrd8kst6nMD
	Qvu5NeTdkRCvZ6DoP+cbIL6ta2C+7KpWF9AiAHhB8ywWnIRe90rXNJTYYoVWbiegTNbn6JPZ9Ly
	DXQgHgaz4TkSj5kZo4C9IEH68ApOiuccROksYFc6/9Ei9++pUA5wKmQmRgW86gPBESTf1ifsKyX
	hEtrQ52gNJUBLSHUASanCdng7yD/W404kblbgLOBrsFCHJnuFUBFLQdmZe1SddbKIPwKngwrYJL
	8pR2CKsNMMQ/PRpSjJPP69y1qa7PXWAqDx4N6j0oWHPV4SQjwe0c0yjiki6p3tH35LYz0Y2p8g5
	6FA6wYs2hpE3iapUhBLJtiQ1xagnDY1LwXxqkyltpQoVu+PcBTW59/BU8j7k=
X-Received: by 2002:a05:622a:118d:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52e2ec1e5demr131525271cf.4.1787741387715; Wed, 26 Aug 2026
 03:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKEVEs5=K1Uhj_CHagbt+eV0QGernwz9EBFkLEZOB1FAw@mail.gmail.com>
 <20260826102718.1550-1-hdanton@sina.com>
In-Reply-To: <20260826102718.1550-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 12:49:36 +0200
X-Gm-Features: AcwNN1Uxe_6_kvBBH-Eu_qu1--WkAq-sDiv0UaNoiZsUfUmceeHFMBjdziA-s-Q
Message-ID: <CANn89iKFGKENq+cFHC7p6ekKXpYhpvZQdA1-TAoriFi09tPqrg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
To: Hillf Danton <hdanton@sina.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, boqun@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 12:27=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On Wed, 26 Aug 2026 06:05:15 +0200 Eric Dumazet wrote:

> > How many bugs did you fix last year?
>
> More than 150 [13].

Pure hallucination.

$ git log --author "Hillf Danton" --oneline --since 1year | wc -l
0

Lets compare to some real numbers.

$ git log --author "Eric Dumazet" --oneline --since 1year | wc -l
550

Harassing a maintainer is probably not a good thing, I wish you luck.
