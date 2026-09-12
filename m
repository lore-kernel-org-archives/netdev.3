Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E823BD06
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789224397; cv=pass; b=hJM3QVQRfpmw8Zy5/UsoguNykf8MlhLyA3PyPFBoiYEpsj/mjM/M1KErJXrbyHL6Ntimy+jTIVUxp+HLi2fZBWjPwWImuliD69u0zC+Ra5PnRhm5RaZsJPJw8Ry2dQKn9k+gxClIwFXIZTXHODEC46leATYHu4DjsmXtoUrvixI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789224397; c=relaxed/simple;
	bh=mM6CMQtxHOJ2ZVazZmmC3ICHQaR5iINKYtOLFHq1P24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLXdQakLfJ6xz4mbQbZD0PQc+l6sOTc3XC4zOwvI1hkXvToRARUdZr7jq34m+Tb/xrIlo6Hhn1oPDNHUQQzHNQcvBmOMYn47glN9Mk/Z0bXDiMZ6+4ZTbBYTHjOw/5aaD7T6h6JF0rxANsYuGe1wGdIA3gSTq/hkWk1G0k/UE+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roM59Nj6; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roM59Nj6"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e03so3259276d6.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 07:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789224395; cv=none;
        d=google.com; s=arc-20260327;
        b=kBRNjpBy6a5GxYwCr+qmLvINljmMDBbklxdjrhTFucjZroL8rdv0Vg05ne5QWSiaYC
         L+Mb4IbpsFXNBLs3xG24ezk/DwnRzcj3ktko0ZBTfKzgejS7ZndbwUA2t6U8rQUPEZ/l
         G50s1afTubFDKHPEMZ8jaVpBvjZf8QWwP2ln396X4Z0S9MTgEdsK7PZ9TxCQsHcsug3g
         N6vPumGnNk8qsT/KwI0iOAC0WMxGR56LhUOKPVYaQAgR7z1Zzb/+AzbC2JcRYa7hpWfk
         CRqMOBjbb+TLTnd9dhuXzXkYLd/Kg5GuO+N5Q2acl+lWFRe5iksQGpLFIws9b8GdJ+1X
         qfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OuQuBFcX3yZNdDUR7lLCDHWseHQkWB2TV3A4fJ0TYSk=;
        fh=FcuxPN7HkJwEG4Wi7IHJdeooa4FnN5YJjfSm1icawBM=;
        b=VzsL21a5SJAi1b4o5PIBAo/+5mjBKr6Nm5xn/cjdcE4pieXbSizzbxZ5dr8RoxQW6F
         wEJ2aa1Gz6+608YV+m1qRKuUYhE7Mzm0QXN+EzeQhN0r98FsRpR6wsNM/uCcDIkBOAVd
         c/t+X2Nc4uHaOGQ3rDH7pvXEHy6y3SHFpuFB9TqsdcgQ3ji9ZrXbq0/BYajegd8xrYQB
         0DsNeQrTL7utQSDEcO1iI10pdEdZnkJZFXr4wUrblBBGDsEWFtVsavT/outScJsKMQD4
         o8Nxhezf1+Z5RqlIIzZmRJUv53tVapYmWKtCznup+XbtjN7bRTmPbZkix2nAiZQjYwJq
         vhow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789224395; x=1789829195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OuQuBFcX3yZNdDUR7lLCDHWseHQkWB2TV3A4fJ0TYSk=;
        b=roM59Nj6Pr+eBocXZcn2wo79gUoyiSPhy4cLTm8DTlrSXzUAkIXyXOVlwB1Ds+dQ6S
         I1UdqzCEWNKYE4FM9UOp192fjZgZr+iGmGYmFo4yXsyc8hxfgaGGh0cQfoUYmAcYC3KR
         Ym40zYimrGa2U9LQ5Jr8iqxBJJjrHD6/dSULPFhv/UbVGiVaCSlvlORp4gAuZUaZwhDa
         HtWqhwLjvNChkijrAqNjbXLrk73lvIJ2KLLHH+4VyqDYnkWND8vE0IsulS7vWKso4I8V
         HrsSrjPY/ZNiXskyAfwLixl0ZzckV3irrZtMhbGtTIkekHlWET2hpN6NVEloGe09KLdJ
         JYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789224395; x=1789829195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuQuBFcX3yZNdDUR7lLCDHWseHQkWB2TV3A4fJ0TYSk=;
        b=o6ap64ixeYru6cfBqKU+3rsMohd1kaXZoGdLkphlBXvFhvBh5ENNqUHskmcccPGCEl
         CT8EBSz8/bkYebsggOstjYr1ycF1i8AQlGBzZz289ITujjeLWT/2u6DHuFb7pNdSn3UF
         f7yrb6xTwMS/KDhQF7stCNPQ+7QB612WXN7anbMYq8zoLaN1mbq6xLYFcXllUoxp2y4q
         DITETe9KT20kHSwzSV/0YpSri9ndPnX2iDRfJKeew4bgGygrkcez3ZNeT0hkqBE6AQCV
         1YgelF0m1rwsy6Ggym1/jhtFsQN+A+afbAndcagx/QyVYjxXf4QS0QRLlSH7M6npcJdR
         txkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSh+yqug7EZ6mHkohxHLe8+RV+DkPeFw2UUDDqMpclOwAF70fq5XzqjmaeAWlkw0ufnR56NsM=@vger.kernel.org
X-Gm-Message-State: AFuF++lWWvRrxea1KxU+ZF9W6sCjYUufTrgLXGblRac6QjbKqKxhHgSs
	jcWPFkNltILlcBPRNb7Pyw+nAVwUzOU7VfU41QZD6jMGZFDdmKW1SYE9gX1bYHfIgt5Uzny7PGR
	AetxS3ocBpDSYUvugV963Et2BcWscqGOZ5uqlxyao
X-Gm-Gg: AYBFou0Ad6g8+fjgnk6u/Bn1r/PTCfCA6L7/V7iWAXX0XtN1i/zpkiIg63P/ajswlcV
	v3K9GNC1PdYAA5y0SLrof8ZNepWyEpO4msiKhcRgvYkeCwHGtRuMtMQm29LPvs5A0sVUByEgXuX
	3e1yT+w5EtPGFK1guOUQpEOF8BEAvRT3xOPMBIDWb1i3LIl6YExP4rAcNixxPe3rhMqlph8nob2
	vBe4SsBzuk1GsvtdHt7II35pWW1TXbpaD5YiUkoTQdYUAw9R7hFezIm8PgD/tbp/Mibv6aGDSuK
	Vik5KETeFEIFNzBeHoE0BnCs0h9IMBXGOV0dBrZ0bKMXfAzv4KWa0F+BV4E5b3qfKZpu2WDBoV6
	kmxaX7jHlGxjkiALqc8ULg5GHoDS3H7Luw04qC4ZWg6ppEUNbpyRW0poSyZ9euyaJZcs=
X-Received: by 2002:ac8:7f84:0:b0:51c:1ea:e290 with SMTP id
 d75a77b69052e-530c86f81camr110737751cf.17.1789224394322; Sat, 12 Sep 2026
 07:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910204612.3762015-5-edumazet@google.com> <178916088869.219967.8693161380477380266@kernel.org>
In-Reply-To: <178916088869.219967.8693161380477380266@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 07:46:23 -0700
X-Gm-Features: AcwNN1XZFa2sumrCSrS3InCmSg_M37YSMOACghqZ5BLavQt3jtK3a8PqrCHB694
Message-ID: <CANn89iJtmTQVaBsupEv55wvYLV2Q31eWcv9ZhBwZEm3P2Ai5Pw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 2:08=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] Commit message overstates the impact: the pre-patch memset()
>   in reset_per_cpu_data() (net/core/drop_monitor.c:165) is NOT an out-=E2=
=80=A6
>
> --
>
> drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
>
> The patch stops adding sizeof(struct nlattr) to al in
> reset_per_cpu_data(), and instead allocates the skb with
> genlmsg_new(nla_total_size(al), GFP_KERNEL) so that al describes only the
> attribute payload that is later zeroed via memset(msg, 0, al).
>
> > diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
> > index 795c15dd1771a..edc660778408e 100644
> > --- a/net/core/drop_monitor.c
> > +++ b/net/core/drop_monitor.c
> > @@ -141,9 +141,8 @@ static struct sk_buff *reset_per_cpu_data(struct pe=
r_cpu_dm_data *data)
> >
> >       al =3D sizeof(struct net_dm_alert_msg);
> >       al +=3D dm_hit_limit * sizeof(struct net_dm_drop_point);
> > -     al +=3D sizeof(struct nlattr);
> >
> > -     skb =3D genlmsg_new(al, GFP_KERNEL);
> > +     skb =3D genlmsg_new(nla_total_size(al), GFP_KERNEL);
>
> [Severity: Medium]
> Is the impact described in the changelog accurate?  The subject says "fix
> out-of-bounds write", and the body says the memset() is
>
>     exceeding the allocated buffer by sizeof(struct nlattr) (4 bytes) and
>     corrupting skb_shared_info.
>
> With the in-tree constants, dm_hit_limit is a fixed "static int
> dm_hit_limit =3D 64" with no module_param and no way for userspace to cha=
nge
> it, sizeof(struct net_dm_alert_msg) is 4 and sizeof(struct
> net_dm_drop_point) is 12, so the old al was 4 + 768 + 4 =3D 776.
>
> That gives genlmsg_new(776) -> nlmsg_new(780) -> alloc_skb(796), and with
> nlmsghdr [0,16), genlmsghdr [16,20) and the nlattr header [20,24), msg si=
ts
> at offset 24 and memset(msg, 0, 776) writes up to offset 800, i.e. 4 byte=
s
> past the 796 bytes that were requested.
>
> But the head buffer that gets allocated is larger than the request, and
> skb_shared_info is placed at the end of the rounded-up zone:
>
> net/core/skbuff.c:kmalloc_reserve() {
>         ...
>         obj_size =3D SKB_HEAD_ALIGN(*size);
>         ...
>         obj_size =3D kmalloc_size_roundup(obj_size);
>         *size =3D (unsigned int)obj_size;
> }
>
> net/core/skbuff.c:__alloc_skb() {
>         ...
>         /* kmalloc_size_roundup() might give us more room than requested.
>          * Put skb_shared_info exactly at the end of allocated zone,
>          * to allow max possible filling before reallocation.
>          */
>         __finalize_skb_around(skb, data, size);
> }
>
> For a 796-byte request SKB_HEAD_ALIGN(796) is 832 + 320 =3D 1152, which
> kmalloc_size_roundup() rounds to 2048, so skb->end lands near offset 1728
> and the 4 extra zeroed bytes fall in unused tailroom.  KASAN would also n=
ot
> report anything, since kmalloc is called with the already-rounded size.  =
The
> small-head-cache path gives *size =3D SKB_SMALL_HEAD_CACHE_SIZE, which is=
 also
> comfortably above 800.
>
> Also, nla_total_size(772) is 776, exactly the previous genlmsg_new()
> argument, so the allocation size is unchanged by this patch; only the mem=
set
> length shrinks from 776 to 772, which matches the usable payload (796 - 2=
4 =3D
> 772 =3D 4 + 64 * 12) and the fill limit enforced in trace_drop_common().
>
> The code change itself looks correct, but with the Fixes: 683703a26e46 ta=
g
> this will be picked up for stable and CVE triage as an out-of-bounds writ=
e.
> Could the changelog be reworded to describe it as a size-accounting clean=
up,
> and to drop the claim about corrupting skb_shared_info?

This feedback is quite shocking and annoying.

Do I need to double check everything and make precise computations?

No, I do not.
