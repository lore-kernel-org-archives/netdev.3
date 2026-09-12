Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E91F1534
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789201500; cv=none; b=pe8131Ii7OSp5Q2DJ7afuiW9KeipM6XqTxIh3ckHsaCdced5jGpr3DGz4EWKIMpKCsp2O1rvEDWBn1r5jibAQ9cVY2WD4NP3kca7/NEhNjSkQufr/2WEdijyh9ouJl9i9THk4B1RSyElhyp/lksVZyFQulcFT+bs0McWexGIXco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789201500; c=relaxed/simple;
	bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJa6Oh282aoN7aba1MWtT97pa9HcQCFxN7NjT5QKyMDzy+eArOHSvdfosFaCLaT0gSWbHvk4LQIQF2AKSkWy+npME9wUTNXDAhJps4tUv16XZKxAmxM4PP/yiBFXu+lVSu3/mhrhea/L91NbF36EzQEM6CCgo03BswINJRDazFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egV/G6vZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioVs3Y+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egV/G6vZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioVs3Y+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789201497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
	b=egV/G6vZriH0rntLcguVEdldCUmFynshyyBqPkB4HjVe4/NfLJNwDHE/qeNSwynArQjpi9
	i+46UuzcsgY5aWLo6BgBPnWxJi7OfWItDBsfNJSpj4aihBrKcCqBIEy6dkKLdGH9tRfn9Z
	crnFsMZln1ltKSvOGQu+a9154ZahjnM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-i20bTeq-Nae7pPJQz8coNQ-1; Sat, 12 Sep 2026 04:24:54 -0400
X-MC-Unique: i20bTeq-Nae7pPJQz8coNQ-1
X-Mimecast-MFC-AGG-ID: i20bTeq-Nae7pPJQz8coNQ_1789201493
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so22168405e9.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789201493; x=1789806293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
        b=ioVs3Y+XCC+Byvzir4hoXBWUBihBXvhWzkkUAy8y1n980pODPmdq7HkiLdkjfJXuZp
         5Dw3SXA5IiJK+l/g0piqVITaRv3bRC4EbROcDfpiv5Sq8GN5NNJhFjhYqAsKBMm06yJj
         8jsHWZyPZWYSVUdFMZFJ4bSyHOywF7iyaaJnLcp961EEk4ZI8i7A99f4FaC6/J2aXoir
         dt0APTKMFiaNNNML8Qw5zdi79j0QgEY3d6wxvgA6tFeQmVOBpVmDcXyCTyvFl3HLp+U4
         4IK7iULa8qFHYwcq1gkAYL8fak1YuFW7255WEsQDrpdDWDcXBWH8C/uf2q09bB0zkZSe
         9tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789201493; x=1789806293;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
        b=V4MYAsSR70+MWC1/BIo6CgO0yTQmVvytzrhvdRvvUFP/rK3j7qTcNko55fbrtFxrMh
         2PXGhaDgUH4RATyJroDGOdlxIfYSamULqDC9+pXbbzpUTylKjknS88ZC6g8XxKHBwTDN
         6Co1PvmGng5m6nBMIlrtGTX7720Ev4qAPuDwfbrdxNWzCcU29jicrRmyIw/Usd8pwPSd
         KfPGuonfFa3HwxUGzdW/j5h3BV93xk+iLCXa0hk5MS/OkHmjDVSFxStwMY/x2WnHW6IX
         KODqbqD0Qf7ItLwsuDSktGcTErrY+GyuUbJnw40pidj82vtLOSBfSO4uAQO+LdxSnN1y
         3VJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjOCvtoCAjQqaM0smCYy0TL/SBLXXVOm55xo4LX64qm9umrCEMMTqWldLo8NWQNQwI35qMIho=@vger.kernel.org
X-Gm-Message-State: AFuF++mMJ5njaUW9oCc5j3Q9/wggO6gyjmxvBrB6gG25dA6qTlBY+QNy
	by2qAT0IgGZ5Yrjw2k2PHkLk/bWdpymowgmsD8ZjUdV3R5PqHZOsZj7bPhOG72LN1kuZf37cS4l
	WvQls9Aen7dktUhYVwiEJBTTTJ+Ch7IJh/1MfG2kqDTjHZGqle+oF0L2gBA==
X-Gm-Gg: AYBFou0EpzdEIvMWfX0gm70dVJAAOpZVLLdrztGImdSZakkzPP1Z8zN17j6j0Rqsn2a
	T9WXTStlPo4SdgkXTnq9+S4S8cBiu76tvR6oUxGNHXMNjYfn+F0KRN+pJIscOqbSnipaDMM5NRg
	3ErDXCsrNch+GJXQro2Zeb00fcASS0TPvSFDVqzwgm31OVtazl9JkZ0nynCmQN9Wtlyx8d/73Mu
	zEFXSOo43bofJFpjzi6LPLnq3jU1LW7iJpNS7JaktxO/DYYxq63piMnpRUDgPmvW/M4t7B2wQae
	ObzChwzgYs/Jxk0nhhk1mVjNKvICjFYvKsI+3L/7w3cDaoemTuFUONfk//6FppBiFy1B+f/tzFF
	aVC7t/yV2RgBSIVgwFETwqGa4
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49e619bbccfmr86068015e9.20.1789201493210;
        Sat, 12 Sep 2026 01:24:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49e619bbccfmr86067825e9.20.1789201492882;
        Sat, 12 Sep 2026 01:24:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm201614725e9.14.2026.09.12.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:24:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 596029B9A94; Sat, 12 Sep 2026 10:24:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah
 Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt
 bpf_program__add_flags() helper
In-Reply-To: <CAEf4BzbToKWpKwkYNovhOrB-ZvXXyMr71BBaTQN9DsM7KrFzPQ@mail.gmail.com>
References: <20260910183222.307208-1-toke@redhat.com>
 <20260910183222.307208-3-toke@redhat.com>
 <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev> <871pb0dshe.fsf@toke.dk>
 <CAEf4BzbToKWpKwkYNovhOrB-ZvXXyMr71BBaTQN9DsM7KrFzPQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 12 Sep 2026 10:24:51 +0200
Message-ID: <87bja2dgh8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Sep 11, 2026 at 2:53=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Jiayuan Chen <jiayuan.chen@linux.dev> writes:
>>
>> > On 9/11/26 2:32 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Adopt the newly added bpf_program__add_flags() helper everywhere the
>> >> selftests non-destructively modifies program flags (which turns out to
>> >> be every use of bpf_program__set_flags() in the tests).
>> >>
>> >> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >
>> >
>> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> >
>> >
>> > =E2=80=8CAI pays excessive attention to wording.
>> >
>> > maybe just delete whole parenthetical notes=E2=80=8C "(which turns out=
 ...)"
>>
>> Well, the two instances the bot is complaining about turns out to have
>> been added after I wrote that commit message; I didn't re-run the 'git
>> grep' after rebasing for v2, so I didn't notice this.
>>
>> I'm not sure if those two are candidates for conversion as well, TBH. I
>> can respin with your suggested change to the commit message, or just
>> convert those two as well. Or just leave it as-is, I suppose. What do
>> the maintainers think? :)
>>
>
> let's replace, you'll need another revision anyways, thanks!

ACK, will do :)

-Toke

