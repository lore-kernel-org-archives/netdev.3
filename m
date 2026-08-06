Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2236DA04
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036954; cv=none; b=enXkUtmGwffNhc3leb6F0ZbCthkqd5fBU4UlXD9X8S/rc/qgCgkoZjLRiE7U5g1uQszu+ManqmBwdu80hxDt13cAcFA1jGi8klV/sOaAsxwzz5X41lODevrYtkR0L0GsrQaotGMgSOylunXQMk8wjEqwq8cAwwjfOB8prKMjzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036954; c=relaxed/simple;
	bh=BnpdqNEUC/D9iCxeB45j6sHjT70Y9PrfHsmHsEPugcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Vmwu2/vIsUqvNHaMQkLSZg+knvlHvbAK+tKxLg6RgdMowyEGgqZqwTc7v5yZB91AWcosBDjPI3+9hcygHtCaYegDtcN+VwQelnZP2SHBt2Hzn916TXjEbW6KJDlKlxO4UaBG7/Tq1jv6f+f6u/wibOB7YVbxg1ECJN0SXDo2v0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRJ/AyOD; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRJ/AyOD"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-472365266f5so913930f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786036951; x=1786641751; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xibh2USspb2uQVdp3Y2UuRURhPWg8PcBBoTV8f9Gm0I=;
        b=qRJ/AyOD3M6nD8ZvpGUC0Uf4jlBK5xqsIV0X37SPlQKLkWG3AeAY5rrl/cKvdHAevU
         JHZVo/SMnSZi0HJIsK0uK8SXEZEjUmwX5brIAohj/V2LwwwZLiMuopRhlMMfqlfOT8zZ
         R9E66ZR/t/6o2u58ff5ZHa7FE2R/tfQg6A36uNy0isyFJndWRB4rPpKh4g2URdpSqNNI
         UvmVPKpC+VCNIKvlUaM6/SvTaEKugOdk0INftMZp1weEsP/65wMkEHEWqVZofp7V2bba
         1DMcJB9k+//qvCa/sXF5opNoNpS6mNcYyZZ3ekES+p5lyZjeV/bqY213fgGc8q0v/3Ii
         ej4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036951; x=1786641751;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xibh2USspb2uQVdp3Y2UuRURhPWg8PcBBoTV8f9Gm0I=;
        b=KynuokMQVOogsYGHGXScYzn4bUtQrdp1f/MPxmCYnlcE10sCFAOPK/DPMmGyCTwqKz
         W4oWPgxs/kYp0GrErA431ufLZoAb99z1FNcmLUZEqf9C4MBsYEZgHVLkpMq/88wpPCL5
         r2i7odHmZ1XIhDNl7RkB48SVvhZlArWpUiN6MBlXnkUdhCeO0eKEtaf/bE7XoeMGc5ve
         6QMUwZNhdrBLcq+ESgKxAHqBEOQZGKVFAkiaQODZ4DbA/puWXfiecAWlSkQ+QnZ9qk+Q
         +Wjz8NUO1apVhgCFpdETjBJY0upvhpyElPK/CQ2ypP9+EzaPnwe4W21Lt+Tr+smjBEOr
         ofKA==
X-Forwarded-Encrypted: i=1; AHgh+RrhrydhaAkkAMS8q5V3zV26hq1n9IIih8p/5LfJID8erbg0N7YUgh3VwSNETsUWOvD9/Ra7Cqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vyMjVP+naNai0HYFvfgp7wkv90CS+g8C3EKUnnsJPuVDeto3
	2tCJFeMxq7OG4OZ50x/USDzY8YOMbokWn+W9702CN6oIcF/aAwRch9fP
X-Gm-Gg: AR+sD10GUubwHpoKMKiuN4V2OCbJbkOAzc8ZWsXUbI78ACxA6Q3dQgT2nC123H/F/KR
	gnBHBKq1XhmkUF2NVGmDPPUUp087E79mm8JQ8KY7AoiehWYZLhcNvaA782PaZOWb9PPj8zckkIC
	5satXkGK1LT9lQ1I37HL2xcdhRhGBlf3Z24vu3FzUeDaJb6UQCMvakiRAxMs6zCHM14oLwRaKfP
	3RE31Di/5YRsFS0inw2Oi4GPSCVP2FQpJvqj8XyhaFzYtOE/kJkUgYpu2mCIZsFzai+k5mgHstp
	HXxvSe/5t9+LQEcn4/tjCzG1v6DISqTVhy0X+SL9darzRSn1J2YfzBWzO0PvkIWjef5WdwkDWbl
	DHRAW//ppUB+V9sT35/9GvYiMSXovzwC99qCxkin0mcm5Jsn05z9liefLxQgAY12bq71fLZjhMn
	Bkta6ylWDfmsknNzCDQDExLcThR9MOLewatRpUlVZxV3wMpbJMRPIYm8XAKysXexF2UqqAkrqIy
	/br120VdojCXQcvlI3UDqxtHIClGyPo2tVGUdMAZngp1aolg2O+tmlt2hj7q77mgGcCaBF1YuaX
	qzA38QAdRbcW0EAeRvMTmvN3v0lhQpabJKQ5Yg==
X-Received: by 2002:a05:6000:290a:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-47fec478c10mr26653297f8f.0.1786036950638;
        Thu, 06 Aug 2026 10:22:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b32487sm7353025f8f.34.2026.08.06.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 19:22:29 +0200
Message-Id: <DKI19BJDCMA0.2MURYUXG6LTXD@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, "Song Liu" <song@kernel.org>
Cc: <bpf@vger.kernel.org>, <andrew+netdev@lunn.ch>, <andrii@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <eddyz87@gmail.com>, <edumazet@google.com>, <john.fastabend@gmail.com>,
 <kuba@kernel.org>, <liamwisehart@meta.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <sdf.kernel@gmail.com>,
 <ameryhung@gmail.com>, <kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add ksock kfuncs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
 <20260804164652.296919-3-mahe.tardy@gmail.com>
 <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com>
 <anTCmv1esr3CWfSf@gmail.com>
In-Reply-To: <anTCmv1esr3CWfSf@gmail.com>

On Thu Aug 6, 2026 at 7:21 PM CEST, Mahe Tardy wrote:
> On Tue, Aug 04, 2026 at 09:55:44PM -0700, Song Liu wrote:
>> On Tue, Aug 4, 2026 at 9:47=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com>=
 wrote:
>> [...]
>> > +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data=
,
>> > +                              u32 data__sz)
>> > +{
>> > +       struct msghdr msg =3D {
>> > +               .msg_flags =3D MSG_DONTWAIT,
>> > +       };
>> > +       struct kvec iov =3D {
>> > +               .iov_base =3D (void *)data,
>> > +               .iov_len =3D data__sz,
>> > +       };
>> > +       int ret;
>> > +
>> > +       if (!bpf_ksock_has_user_task_context())
>> > +               return -EOPNOTSUPP;
>> > +
>> > +       /* Early check for UDP. Exact limits enforced by kernel_sendms=
g(). */
>> > +       if (data__sz > IP_MAX_MTU)
>> > +               return -EMSGSIZE;
>> > +
>> > +       if (current->in_bpf_ksock_send)
>> > +               return -EBUSY;
>>
>> Returning EBUSY is not ideal. Can we avoid recursion by disallowing
>> calling bpf_ksock_send from certain hooks? You can find examples
>> check_kfunc_call() or check_special_kfunc(). This probably means
>> we need to grow special_kfunc_list, which is not ideal.
>
> This is actually a really nice feedback. I didn't know we could add a
> filter per attach BTF ID. This resolves the issue that the send kfunc
> calls security_socket_sendmsg so we can remove all the recursion
> protection and struggles, it's rejected at verifier time.
>
> The filter now looks like this, I'd send this in the next version:
>
> BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendms=
g)
>
> static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_=
id)
> {
> 	if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id))
> 		return 0;
>
> 	if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL)
> 		return 0;
>
> 	if (prog->type =3D=3D BPF_PROG_TYPE_LSM &&
> 	    prog->aux->attach_btf_id !=3D bpf_lsm_socket_sendmsg_id[0])
> 		return 0;
>
> 	return -EACCES;
> }
>
> I don't think I need to touch anything else. I'll adjust the tests
> according to this. Thanks Song.
>

Yep, using a kfunc filter should be enough.

>>
>> @Kumar, do you have strong objection that we grow special_kfunc_list
>> for this use case?
>>
>> Thanks,
>> Song
>>
>>
>> > +
>> > +       current->in_bpf_ksock_send =3D true;
>> > +       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
>> > +       current->in_bpf_ksock_send =3D false;
>> > +
>> > +       return ret;
>> > +}
>> > +
>> > +__bpf_kfunc_end_defs();

