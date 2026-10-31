Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793470802;
	b=IdRzAvtjIu+xc2/ElA6ipnPyH+sYM6OoTa3a+kGhmcXsCa1k+HUKv6tvofs7+qIiV5/J
	 R6is/UcjGl3MeDZGdLEL4tNPY/ruA7KuoQ5dYPz+iiBf6nhtOskB0qyYqLjnhHZggdEPj
	 C+T1SqxZHP+tPaHbpNtuTS7dHpzOSuSw8u01q8VcXVVOD/EqtPCpXQEIxpCczJDzUhKNr
	 EZoML0Q3jP5HiCUMF9YQCFjF7ZpQAKxMfXLipNPn9mj+DtnqK85R8+gOYTOHstTe46sMb
	 aAvS1O1cE2BEG1+1fpRZp7gdeIuAqoAOfdvwziz0Eb0PfUDRFrs2O/r7UA8wlGOVUWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
	b=CddqiZ+yF/+DXB9bMZlDoTsHqW4cfaCiR7D2AJ/+xDMc5hlEmtJG79fuujSJVmsJYoT+
	 PkkmrLZ+RDMJdjgWnsJm+m8p1aO8zgVBXZ/77mWeKl4mtSR4YwFNqDUJywE7q/rNHPx6R
	 431cqfz49tcL0jlmUVm2yeyZm/xYpLbFAl3NIOh+3gRENnppNlWcGtDH+33PSfM2OBrlB
	 YQgjeBsoeHWFGiULh9XCrDRLxn6r5o2uKGOmAWtWfgi8lZuzSgfKbhxDB05Ejh5vx9emk
	 zrj3iZCnKMiBRlCmsMT1/eWztv02Wiysj7SDYn2zgae1SMpHw+euFMmN/9JbfOZapNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QUt55f4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19835606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 18:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19835606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QUt55f4L
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a089dfee18so1581476b3a.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793470801; cv=none;
        d=google.com; s=arc-20260327;
        b=BVaHhWHQAFhEmhnIDe4KvCp9yhvLYuYjq7IJDLbJpGGjC/UILrYgiO0KYz5M7IlNti
         Vr3L6/U3Y94p1VWIx7DoZfr3xfqRKS+UG0cgvQ/GVk1a2AUEla0howQPQAfbSM+c0WxD
         bOjDvHtuALKm3qLL/qFakBjwkf9SHqQdYy9SExq5zyN1Y1VQLpscPEs0wFyGpNnTModJ
         t+dUvTScd8h90qi6s2x3TGEtHIs2gvvGXMneS9bv0O0dHftKSGOQv9aukeKbXW6Mx2p3
         ikVCFJD8Ao29gtHo8HeQ3ctd7+n0DKxIqNSuGwVwQmt/mJv2fSCjHT0s9E4dmOvV4UQD
         Qi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
        fh=f0NkUrm/ETlKKXK7F+ESTf7d0R8lMZYZv4UwTn3UuGw=;
        b=pMEmtiSjmjMNwPCv4Xv32esx8mwqp/e+Bp31MiHmDCSIdZ91KUq0/hxG8Mq6KI5Est
         2jtmYippgvmfJ/SxBtfVNcQl4bx1Zgodakqs6KiPTiM+uxJ21rsJTRxKkb9QHiEGcQbE
         c4h/4tghp0Zn5YLwxl04DQujoA9lTa35emW4I5QdQG6IPF7TYjKvI0OcHB/tcGIF6anh
         /yBZiOihTb5ilMKazU9bBjrOi5PUcMzEq5yoitdrHD7tgFX41kaeaP/xeQ+j2eHkk2Cm
         faxyuI3zcZxF8B84b8ndpiEWHPatsT9x1bPxbj1WBGXy41PS/WCpsFtZIA9n6aYZ2Ues
         BJcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793470801; x=1794075601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
        b=QUt55f4Luw2qqAGSZIH4Gu8Aqn3QAekTwR5YXlOoJezua35S0nwd8e1FlH29OazNZW
         MDAHLxE0kTikZM6rR+giL2QRi9bdWJh4JLhmaxhaaXDPPXBDVQj43ViV8exyExacKv9c
         2+LaMcQyiJHRqyNm7JS0DhNEu/4tdK5bu6XEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470801; x=1794075601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
        b=NjgeVZRYszHe5JphJwekHLncSS1YCFguOwFFVTVb4Ohq7H1BGWI3KVZ7eDEmO8ODBq
         HBJ/cBrI8U439ud7GeP0Hl6bEzNbuBvh4FghHc3ZgJprmz0hok3Z2gMbMA0TiE/EMT1c
         s70sriL9sjq4F3wce0D2RBu0QGuji6Xc4tAaHaYK+8cQPXDbIQD29df0Ex3/czfGxWXx
         0H39ZChPiarLWdDXNVdr1vJQ+dXxLT1EKJjCVsodZTYXoXnQU2D/zNFBehA993eJ/Yeo
         HKAwcOD8AR30KcpGszXLF9gfKDwwOKevEyF9la/eZ8ze3gIOPGRpsKlDWySDh25cPvZ6
         HQ9A==
X-Forwarded-Encrypted: i=1; AKwUvBxCzqg+IHGJg09LnWpqhB5LrG4Fdz2kw1RLH3sWOVHAgQfeNXV7bpapTD8DdB6+c+xWKQO1NDM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAvg8eVLK4BJKUEbzVkPdOKoXTMgAdDLiTtzR8Rj4w4Nhqkx9j
	9LcH1crsHtVG/7CkXPk3MXPfvFvmnps6KL2Fr2B9in5IVN+0UtVz8v4esiCiPABlaLxutqtjn9d
	Ypj1QkpdzcnnsguPA+x4CVJJFSeotvUBHXDb/E2Nl
X-Gm-Gg: AYBFou2Axjt8Xuvrb2CyoiS9rmZ4nuxTW/Syhgv+u67os5LV6CVFt6MAQaiCjpsCIzr
	+w+Ec/AdMXbUXMviXmdXctSaU+f0efmS4s3f23ZKaRXLe1O50gHjuBETqddhHGVZxw4wR0zAgyz
	XOil/kKwKUVkXqIBcFhuZwSxmPTEcuguPFXKk7fW3KT9KKcOV6A9edmK2kJbkBbPcVMaHqQa+6n
	ZDI1hposcYrClX5yl0fudm4kr0BboxiUEs/zkZyAEhtXmX7NrFzLLDHdgw/YotsqzL9iFNM1qrs
	Vq2X7M4VllmAVX5rsdCEFXfQKv+Y6wkQZu47zqa/HAHNfxLd6YhxMONbnq4+GWCE++RckgxJ3JM
	tfuBhrBL9zYYdpS12OubThJflbMGlQD5jPotERDsk4KQukzsN35hoXwIiaNseFPgLpZ93Mu8vLR
	FsI2qMqDEmYmEdpzaKqR/rNMwu5leCNn0281co
X-Received: by 2002:a05:6a20:7348:b0:3e2:2b76:bf37 with SMTP id
 adf61e73a8af0-3e9288c7ae3mr3751337637.9.1793470801396; Sat, 31 Oct 2026
 11:20:01 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <20261029165943.41fc74c0@kernel.org>
 <CAM0EoM=WYGMNxc=n3j+nwyXA41SHq8o+bVvTR6uYp6HUeEa5aA@mail.gmail.com> <20261031180149.GU257209@horms.kernel.org>
In-Reply-To: <20261031180149.GU257209@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 14:19:49 -0400
X-Gm-Features: AclHuK-mIz4j-feH-N2bwZ5m92RWDfoh4LoIWUMhaR3znmD1qLdXroDo_03SCv0
Message-ID: <CAM0EoMmfjXExhtLkYk2QznPJtQ1wjxwXdfwC7iaY5K4qrwei6g@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	shaos <shawnq1@163.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 2:01=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Oct 29, 2026 at 08:07:18PM -0400, Jamal Hadi Salim wrote:
> > On Thu, Oct 29, 2026 at 7:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 29 Oct 2026 19:27:36 -0400 Jamal Hadi Salim wrote:
> > > > Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and name=
space boundaries
> > >
> > > Please fix your setup, Jamal, all your recent postings have patches
> > > posted in reply to the previous patch:
> > >
> > > Patch 2 is in-reply-to patch 1, patch 3 replying to patch 2.
> > > They should all be in-reply-to the cover letter.
> >
> > I know this is what you asked for before - but then Sashiko started
> > getting weird and i went backwards and saw it accepted this format. I
> > will resend this in 24 hours and stick to having it reply to patch 0.
> > Maybe the sashiko issue is not even related to this but it was getting
> > a little frustrating. In any case , sorry ;->
>
> Hi Jamal,
>
> Please also be sure to rebase.
> It looks like this series does not apply cleanly to current net.

Will do.

cheers,
jamal

> --
> pw-bot: cr
