Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33C381AFF
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333815; cv=none; b=mgbCMoK+xvrEdCDokGQeeF2t/h+uaCkO8RVlYT1RmWUahOIHQvwbwbPFZlnG+32tTSfTiOGByejnEOI7JPQICXqB/Aq1CRR1CXyChRht1EUrNwjBSh3ft1zpaF4mzXC+MgphRXbvqDCe0rJpir8+eznVQ73XA5Y4Kvkn+FT8+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333815; c=relaxed/simple;
	bh=7SDC/MTTU8hRFq3X/I2Gt6RG8V7YNckjVfDN0wPB6zQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tPBnrEJeQlZnbRLa1vkTu6i7sbCC1sinKmaCq+yl98aHzDhVHPtguEsxEPW+xkuXl820Y3hTgIp9RbWVP5m71nAZNb4KEhHfPrkPkojcpXNab2+6yY12B1JiyagFB2xkob9pGWF4EofwL+dooY059ho7WpzS+zUbo+FWyYh0OTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIMkmUOG; arc=none smtp.client-ip=74.125.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIMkmUOG"
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c213511f779so72904466b.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333808; x=1787938608; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O2PTPfQYtKztKWOfpp7tANhwQtfUstakuw3wFNvmzQ0=;
        b=MIMkmUOG79hUAMs4RZtLfcYCZoCMDBHowwBJtu6K7SBTfQJ7oibQfpDAR9+jRCsbxA
         EKRLexxKhGUTL8Tg0+YXI9nmnQ3sa9nqR/opUWFS5heqfAqfbK0G/t1pCWSL7jfomHik
         htB9lMWt8oHwy7sMzGhlqLkQZsSkhY5aVG6MPF9zLR1QWF6qm8cT7fGw+4gm96mcUxRP
         P7JE8oZVN0ey76dfw9YDNwVBCbnk8RTM66cH/sHsif74tyQHZko37ue07zwLo2mnTNMv
         VKyK8PISp7U7H4zJilCxz72mI1ygUiRlCQswo80c9L2q5ASrxpLRVEqr2g+U0MelLNE7
         VM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333808; x=1787938608;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2PTPfQYtKztKWOfpp7tANhwQtfUstakuw3wFNvmzQ0=;
        b=SHkNV6fUOLtfYgMjyYQql6IjAl4g02hDNDZDC8MYuBgYqP4CqYY356x2vVpmB8Wiuy
         3oDDj53NBot/h/8x+9T59J/0SPtr688LlZE6GKThon4LMqS/kBDpdh8d/bBDW1raUkz7
         ylGPc7ylEBwVlMYLdzt1LMChFkFkGR8/VTwOdYobTnoGQOWpKad7L3S68elMDUv0MFwO
         aUDnJsYX7p1vKpUD85sFjYPB/IwfqpoSYfHw0amKMjN397EHi3FzuWiM4JVRwpUi4oiP
         NkszPdUTptK4+8+Z3vLEGeZvCBWjG69RdnhlY3/KDciqlv7zPeoU2g/sK0khDmkQxoiC
         drLg==
X-Forwarded-Encrypted: i=1; AHgh+RoZ4ikzJkKjQ9I3yhQJjzTayoWzbrpGfHtrJld/PCf6LdimQBu7G4nubrXuqQ9Bv91gzlBMl48=@vger.kernel.org
X-Gm-Message-State: AFuF++k5mrQOOKpw/0kcfrLXfqjmglUxKz0iIgGIvXo9Sfe9Z7sSdSk7
	vvAVxzRAQFRww6DFERn/k/hWd8TgMVa9DoP9wLhyK/rMiMjz+CYouF9L
X-Gm-Gg: AR+sD13Z1YPxhfx5YGCUf0uOKsv2sB7XEvns10o4l3WCgMwUHkNPkzp4GaU+HT1pNre
	TNtrmkBw4sbDj0R0mozF18grTVpQ1WVywK3Jqmk0eEg4/VSZTg6ID7koT9o+ct+Z8Ohp/Q56sEJ
	YIg6oIv6FNczst5b5o0+onz9xnGMU8OK68KL2tYqd2ceudioMibF05OQROyT16SnhFHRsSedRIt
	ip2p+NhvI8UK59BJPa4WYDJtZQnf+3ncVKkS1rt87GNQ/W9MrvJDZy+AMdSlzIFTUua5XY/Bx1S
	oVNv1E38vF8H+aNXfHaFbMr/f+qGtBDHimvzpK2TzEb+Vr6tfwg825xuPgNAo84iHicWh5xdxu0
	Ff0p0jmXJOrFC1oQhMQR70lk60CIahQIjFrfxl//GtipnqQA2GFkWrTMKd17bgW9RV6I9DParDm
	kkey2O1F9R9puFiZouX54v5WLjMoqVJnuyicZXVyBi1Pe0xI0MewMeUC+rOg3wMREx4E71eJhmW
	cqOvfGo7ZTvow+2ijL9KbB/8PQY7kiDJO3LAzoDkvvPg1VNHsr56O4q+YRH7bRKF8TT99VzLkzn
	OgqQqeyqBxjqePKYWDLaQigvaKc=
X-Received: by 2002:a17:907:97c1:b0:c1c:64d4:5ba3 with SMTP id a640c23a62f3a-c246a651d39mr815803466b.20.1787333807866;
        Fri, 21 Aug 2026 10:36:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459197cd4sm580558666b.30.2026.08.21.10.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 10:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 19:36:46 +0200
Message-Id: <DKUSYFLEQ39S.2QP1DOZV5PZOP@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <netdev@vger.kernel.org>, <andrii@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_sock_from_file
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Syeda Mahnur Asif"
 <s.mahnur.a@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260820152532.621639-1-s.mahnur.a@gmail.com>
 <CAEf4BzZd7BDdJrNb+N3uktbwMJRHjUFzG1xfzmTDibEmAKX8gA@mail.gmail.com>
In-Reply-To: <CAEf4BzZd7BDdJrNb+N3uktbwMJRHjUFzG1xfzmTDibEmAKX8gA@mail.gmail.com>

On Fri Aug 21, 2026 at 7:30 PM CEST, Andrii Nakryiko wrote:
> On Thu, Aug 20, 2026 at 8:25=E2=80=AFAM Syeda Mahnur Asif <s.mahnur.a@gma=
il.com> wrote:
>>
>> bpf_sock_from_file should not dereference a NULL file pointer.
>> KASAN detects a null-ptr-deref when eBPF tracing
>> fentry/fexit programs are attached to points such as
>> __mmap_region and file_map_prot_check kernel functions. This can
>> result in a NULL file pointer flowing from context to the helper.
>>
>> A minimal check before dereferencing can fix this.
>>
>> Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_N=
ET")
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
>> ---
>> v2:
>> - Added Reviewed-by from Emil Tsalapatis
>> - Fixed name in Signed-off-by
>>
>>  net/core/filter.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 16845987b244..7c3caae4bafc 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_so=
ck_proto =3D {
>>
>>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>>  {
>> -       return (unsigned long)sock_from_file(file);
>> +       if (file)
>> +               return (unsigned long)sock_from_file(file);
>
> given this is a legacy ARG_PTR_TO_BTF_ID, it can be not just NULL, but
> also a) small value bogus "pointer" resulting from NULL + offset
> calculation and/or b) just random garbage casted to struct file
> pointer with bpf_core_cast() (maybe this hole we've closed with
> explicitly untrusted, not sure).
>
> Either way, this is not a sufficient fix at least.
>
> But I wonder if the proper fix is actually to mark this (and other
> similar) argument as explicitly requiring trusted PTR_TO_BTF_ID?
>
> Thoughts?
>

+1, should bite the bullet and accelerate deprecation of legacy PTR_TO_BTF_=
ID.
We can mark specific arguments / fields in structs as trusted where there i=
s a
legitimate use case and the kernel guarantees their lifetime appropriately.

>> +
>> +       return (unsigned long)NULL;
>>  }
>>
>>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)
>> --
>> 2.53.0
>>

