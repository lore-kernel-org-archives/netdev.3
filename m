Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23434D382
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422039; cv=none; b=br8rTYJxBeTevMvZCNCm0mZIkbZWHux3tXE1eU75ijG0KBPpT4+UA8Fsc+aFf2YPWwcNWcEPeA82KDVKZjXZzWkwCRZz5nwbMuxIn51Y8QpKup7j4ZWkc7xeNlt7W7TscCg+KnKGSvv7F3VHHeThsdr/D9cILZPk2WA2yNNc2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422039; c=relaxed/simple;
	bh=i6MdDSx3lDn2jpaaFa4GgsUevyMmmy5o9ai1CrRISb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OR3RonH8JlHK4Ew/8rEgRX8vpGIuYQLkzxzF7yswdhZgYi2oP0MW7YABxlmuO8LsjTegEY1hixOqNnbqq2F7k35kDial7qUaAjyRIYRhTzoUcrGRcl+3yH3pVWxc8XfO57s9ycNCTeADUUMpfwBP6HBMoCzF7ifRBdyXo+H2zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGuA49yF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsDEdXQp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGuA49yF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsDEdXQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788422036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1c3/qiiNicrr5D/2Rt/GDUWYd3VZjVY2MpTQTP3gXcs=;
	b=LGuA49yFTtZUQ0/TpePL9n8nYXLin8Gt7zpVE97vpFJNqDrz8WbxEMjinznLbnAFOkHPLG
	kkd9Fe48WVhRR0hJz7CdhYbQ47Jme5n9vFIut5iJm2RSjnI3Y68JqjM15/R+/LF00n7K/n
	A5L2/tFHcrG8PVMNmciQ8mdQyfkB7gE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-1WbNRBL8M7CsSRCQA_ydhQ-1; Thu, 03 Sep 2026 03:53:55 -0400
X-MC-Unique: 1WbNRBL8M7CsSRCQA_ydhQ-1
X-Mimecast-MFC-AGG-ID: 1WbNRBL8M7CsSRCQA_ydhQ_1788422034
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499b99a8a10so5080325e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788422034; x=1789026834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1c3/qiiNicrr5D/2Rt/GDUWYd3VZjVY2MpTQTP3gXcs=;
        b=XsDEdXQprA+8QgGmXkkHQl13GHVoy3Ysa8DKxsPMFzBfI2fQjx95Msdd1yvoq/okPO
         R9Qwpl3++JKSjtm1Qu8qrY8K1q1n7F87pIvhArqMopT9af3NiDVnWTEizQKcMzoszOar
         OPM7IPVMyqYEKp4AK50d5EeO1ROF3UiDxA8yhLg+oQGZKK6OM1CZjsJ+bSrsK4TJ97Ty
         zuVczu3HnePKWDNiswT1reUZMHwDnslaBViwfzXTj5dJosb4EZDVi/fJ/boqV4bqXnKU
         sKqhGLFOSE0948n6OvJPdeolIabYhcLrZ/CrskVkVKIWcnaDiOJNzXXpQbGgV1jL4Lkl
         LLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422034; x=1789026834;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1c3/qiiNicrr5D/2Rt/GDUWYd3VZjVY2MpTQTP3gXcs=;
        b=U75TXBY//Lo1TMucWx0amvTRBRIlLl3MwE7d7EY5t/nAKVoPC6SgcKgq0uy3QKzymU
         ZoxRJnoYiXX8QUMQFGqB6/pm4+BVTz1Yhwrmp6akaZAPdQic/wWu8i2p3blTCTd+YFh9
         SHvTTAnqm06t/wpxx8hcRTpBG5fIUY8JCSHR6Rt3lTw48Lob32PIKOTlF8sCqJqh+zDm
         4d9RsLjNSLggC0BoUbcT9gcrrJzoes/oc/kkecii109KtM7D+g7K6tNvjteXT3ygTEcV
         +HU7qlNv/0PWd0VgONYhU//XTiPsh8RhgJtPSt3/UW+qeS+ohLtnsjhoaoLIy2H5kURr
         bPXw==
X-Forwarded-Encrypted: i=1; AKwUvBxGgu3ZPQMJPvM+K89c2xliYRskN9eHUxt+5Y/wKbphSa0oyv5+49hJfKYhvoPEdGHyAUNleS4=@vger.kernel.org
X-Gm-Message-State: AFuF++nZiY42+G5nOX1oLHIsSw1M9G/zGUa9Ujohv1/gd/xxNVbnl5hE
	Q1lo1mVE9xUXDo/jdwMRjcl7hjp4adJ88S7OABi8j2INKLplKLUO/XZK490UcWyPRBd4mR8ugJ9
	esx5AV1GRqbFBhBAckXF91a7ij4m2U/sqIDgmrlwsoJSDATC0Ekc7ygwpfA==
X-Gm-Gg: AYBFou2U1XSK2rDVi6HyQR/KvML73RNpbceO0YUrquYTCEFZZzWK13SM/MwLLuRAAWK
	ou1LqtNIwqB6uYXtr3b/qdjtIPf8QAksiqnFeCI1XhKY2GQR9b7uCZyAG++7Zqv9bhBACCyQ++v
	dzGJLEvWu8qUZx3qQIZyIF/faWjLNv+CQaJo2h/F0SLLikBlkDKMd5IwuWRg9Ygg0B520sV2BnA
	aXeaCECZSETvSsNuGizWqvhIGDEn4PosCwtyDh25iziQST54xM6YsFDx4WVDnAtbH8iHld3/OpG
	kAE5tEexZ/XjkGk97Yfk2a3xySieRbsNRrNylulPzSb8QbiXmQVBwAk6mLubjyR9UDVcbOdw3tl
	gYlGETMj+EK6fKrUa/wr7ILTN
X-Received: by 2002:a05:600d:4445:20b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf1577d23mr13882455e9.1.1788422033899;
        Thu, 03 Sep 2026 00:53:53 -0700 (PDT)
X-Received: by 2002:a05:600d:4445:20b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf1577d23mr13882125e9.1.1788422033435;
        Thu, 03 Sep 2026 00:53:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm77325335e9.2.2026.09.03.00.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D59897C771; Thu, 03 Sep 2026 09:53:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Larysa Zaremba <larysa.zaremba@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Lorenzo
 Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY
 flag non-destructively
In-Reply-To: <CAEf4BzacBUMLREUObGo5544wyD+mm1=y8ZTnzd7OdDL-c==mMA@mail.gmail.com>
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
 <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
 <CAEf4BzacBUMLREUObGo5544wyD+mm1=y8ZTnzd7OdDL-c==mMA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 03 Sep 2026 09:53:50 +0200
Message-ID: <87bjaevkhd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Sep 1, 2026 at 1:47=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> When setting the XDP hints ifname, bpftool would set the
>> BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
>> overriding any other flag values. This was always a destructive action,
>> but after we change libbpf to carry the frags section flag in
>> prog_flags, this can impact bpftool loading of XDP frags programs.
>>
>> Change the flag setting to be non-destructive by OR'ing it with the
>> existing flags.
>>
>> Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading pro=
gram")
>> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/bpftool/prog.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index a9f730d407a9..8c2f9255b36d 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv=
, bool first_prog_only)
>>                 }
>>
>>                 if (prog_type =3D=3D BPF_PROG_TYPE_XDP && xdpmeta_ifinde=
x) {
>> -                       bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_=
ONLY);
>> +                       bpf_program__set_flags(pos, bpf_program__flags(p=
os) | BPF_F_XDP_DEV_BOUND_ONLY);
>
> maybe we should just add bpf_program__add_flags() and
> bpf_program__clear_flags() to make life a touch easier and code in
> selftests and bpftool a touch less verbose?

Sure, I can follow up with those. Also makes for a convenient feature
detection target for this change :)

-Toke

