Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE446F4A3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667113; cv=pass; b=qInQaJHWJcF3W/DVd1hK0WqfR2t+WWLNMdNcq5F24fS40W+pyOTvONL9bxtrgGZzilLBfBx2kVmdAKo1D0mQqjsDlQMN7tPObc6sFuQW/aBCNL/Cfa9Q2lIeMdYUXpHISFbhF/ZoiNWSXM+g47K/ovWN8C36R6B7shGtXIrAexE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667113; c=relaxed/simple;
	bh=3Z/yzBWtstPRLJO40mKZ6V5oaG2SASFbljdHtXwUd38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN5GObj7YMNAGFkuKf9+KL15GZrXwOt7J4wy7qPnHwJsqMb1ppwDG3y1N1nnj8gQpNEIj7VXc8rmovc+ZkEO9onlBfMf/KeZUYvixnR/AIRHWeBpv2QiT+UO/lyZ0CxHULxjbFqnM5jltzj2QPNR33QvWufFL7ucUL3d4/ohCOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwRgIZBo; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwRgIZBo"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a449c57so27868521cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787667110; cv=none;
        d=google.com; s=arc-20260327;
        b=fpFZYu0VsyvwGEb8CPP9Iy9UIncumpjRIdfKv8u+bMVaEFwXIbW/mBnXKpPUoMuf2h
         jm/hqFhU5NxAplASuPSm6AD6J+YVStL6qD5f7VnKrJ6RwqccO/wTTSABDt3iTcOuYlHK
         r02Sjrx3aDolPKDhvH0SAYd+3UgIrpW+RFncbp3vHubtjkTtunKIK5eIHEgPg3l0ft1g
         HIQ0E0mUxLMVSFlNaaDBFrVW6BSTbJIFMbrQE+qwfAIRt+N9vOU062Al555DvJuGxq+V
         dVB1nDZ11t6U84gZY3ems/jlwjWI5EQjllKNLUc2yq5B0PztLUHdtZhcK2YbkAgJw2OW
         bFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULhN7nsmgxsANINLEXw4Vib8jeuO/6uX1klgT/bXp8U=;
        fh=65seovlyhQbuLTiwTpM1Nb770CV2DW+bYlRxhO1RCL0=;
        b=T/CIDOL+N0Hd1FXLsCoMIN3vBuX4ul4mwbG9iXIZvbzWAQv3PMELrJuOWx1R4DFs8B
         /OmfWwqxNFGlGIRlnHXBc0rSGX6e+2Ojm3Ium8X3kqdgzpJtyjtqRGuXegQoUdFqoPhJ
         pYSy6c6eyNgMnVUD3ONHZvcV6Bb5xrgbgGF1DJgozY81viHAgAcgZ8HFBlXAyGtRbUTX
         /NRjyetFdbnpqEh51Aj98QMdFf8xL1PjimLXnud3ZBRhG+DCzWtWiFX3eafJwPxYh/4e
         N+k3W1/ImJy073nUkL9N08XYqdpyU8cfgqBldNDMAJMWpSe9CfEHDYE7Nul0Rgrzvvr9
         GVhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787667110; x=1788271910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ULhN7nsmgxsANINLEXw4Vib8jeuO/6uX1klgT/bXp8U=;
        b=GwRgIZBoNmsAhNFZ8FR7LsdKRG0P3RG0RaDzkEuwRsnj/k7jUCn3C3h75TD8V9syVd
         tbNTgUGgognudofhDktmgxswm2ci1wYBUnm5gvmyfMJ7RGdSAbaNLa14QKgIhyAmDYSV
         EPLd+TCV5Eh1X0BNrwlEhE9sMNY5a/dyV7Ec0ISw9aKZwzD7/G2agLWK1NROSSy0/XQo
         ZcfwO7XuN0l8XPRclf5nJzjoHcCvBUgLLg/XLc1r+8smQ5V7vDBiBFc7POeI47UY9Gzj
         JbVnCTUPP20l4CZ9q+GS1fTwA8YAkPYSxjmIeNwZv68xKi+HmNNhUA8y1LsGqNCMAECQ
         NOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667110; x=1788271910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULhN7nsmgxsANINLEXw4Vib8jeuO/6uX1klgT/bXp8U=;
        b=YwTGrpbOl+giB3okuCVfKyG7iUVkfGMKZP1J0/jVKmdKYxbEiIq1RE3jonmM0EWZpM
         FJLPSAYrw4kW5C/2wAx1e8ea/iP22UvbcU4R7PC7dI2/DOPxVJH2t4BHnqYeVe8whvss
         xPBRR+1LCQhEw2ehnWIxlGoubPxvO3gVykffHAroqKuIaNMrt3CdNHyY/XRwFs9LpKbm
         yL1gdMknaLULhTSfTZe3G6T2J2i8UY02+ETgHbv0fHqVKqv53oJvScXwPoSQy7U2rnd9
         AToKjyr0702dW6Hrw4WhmBF5xv7QccfqD0rO2tD5d9/Qa+uSj52f4iR7h23RiyGhwP9G
         bHBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPKaH1ZPVGs2PJlD0vUPBsx5TdH5Q1HTlbbTR1mEYd/F9tRvObGmn//dIFM5Cz2eu0fYEqW2g=@vger.kernel.org
X-Gm-Message-State: AFuF++ncDO+swkRC76MUllyw180G13iGCnGny1HAMrlTLYLsbWTbl5ZX
	c33mZEecFgkLmhF9w9eJCnQMBOzZsaWJ43qbw61++7cIUICIwJ5jZweNFNvJ/p0HVHGhMK0iDyG
	TTevDRiszXjguDhs88T6PGaep8qhSZqO7qvJtw8qq
X-Gm-Gg: AR+sD13g40VvUMYJJ+daVdjCCd7h0btacSXTOv18u2PCYbrzcmsH6C6fu4Wdg+4dLeH
	C/0QIlzfgquR7+P3tYkdKR5oS0fy3lbzPLWFM/x6G4dweTPYo8L9kxXDN6CfMNkPz9wDoOaVDJK
	QmnYwW8eNFsdKjz19dZM3Y4GxP4Gz/5QpGkNN+IgtnDUwFmUi/HpJ6rMiPHzbTNMcBxj9yMMLrR
	soOCfDodXYwDiMr4bzQ5IREn6QF5RM7MgDuFXaPGvBBBihkiLITT9XAt+rS3kYOngIWAx8nJ9BK
	9BnPEbV4abAEJz+wrohEYOKfJueGbM830YFVgiWQdJ+92sKnceg9lwJekaIf0Kzv0GNyTyKB1bO
	TLiCnYGRBlFE5sls1T5MHc9glNYYKg04At3PalgT4YgLOvgsLOk8OBwp5
X-Received: by 2002:ac8:5f53:0:b0:52d:6afd:7db5 with SMTP id
 d75a77b69052e-52df59ec0d3mr366892101cf.25.1787667107848; Tue, 25 Aug 2026
 07:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825084551.1562967-1-edumazet@google.com> <20260825085052.72ce4878@gandalf.local.home>
In-Reply-To: <20260825085052.72ce4878@gandalf.local.home>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 16:11:35 +0200
X-Gm-Features: AcwNN1WyQs2jWOqEpcoOaTkGhs7YcGDysSJuZxhsoquKXmX21Q78qnM2Hhvnnmc
Message-ID: <CANn89iJ_no=fE=vjWZMWAqqLSyMZFD4NZ7BkeaB--M0d23syaw@mail.gmail.com>
Subject: Re: [PATCH net] net: icmp: avoid invalid transport header access in
 icmp_send tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+6d2762674103618994b0@syzkaller.appspotmail.com, 
	Peilin He <he.peilin@zte.com.cn>, xu xin <xu.xin16@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:50=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Aug 2026 08:45:51 +0000
> Eric Dumazet <edumazet@google.com> wrote:
>
> > diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> > index 09ae115099dfe25616b6c74d5b92be1af4acff55..6937b778ae54dbf4442b127=
957a017da3551aaff 100644
> > --- a/include/trace/events/icmp.h
> > +++ b/include/trace/events/icmp.h
> > @@ -27,17 +27,20 @@ TRACE_EVENT(icmp_send,
> >
> >               TP_fast_assign(
> >                       struct iphdr *iph =3D ip_hdr(skb);
> > -                     struct udphdr *uh =3D udp_hdr(skb);
> > -                     int proto_4 =3D iph->protocol;
> > +                     struct udphdr _uh, *uh =3D NULL;
> >                       __be32 *p32;
> >
> >                       __entry->skbaddr =3D skb;
> >                       __entry->type =3D type;
> >                       __entry->code =3D code;
> >
> > -                     if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->h=
ead ||
> > -                             (u8 *)uh + sizeof(struct udphdr)
> > -                             > skb_tail_pointer(skb)) {
> > +                     if (iph->protocol =3D=3D IPPROTO_UDP)
> > +                             uh =3D skb_header_pointer(skb,
> > +                                                     skb_network_offse=
t(skb) +
> > +                                                     (iph->ihl << 2),
> > +                                                     sizeof(_uh), &_uh=
);
>
> I don't know if networking has different rules about this, but we usually
> suggest using brackets around the if block for any multi line code. Not
> just multi commands. If the line needs to be broken due to length, we
> suggest brackets.

We do not have such rules in networking, and checkpatch is ok
(although I never use it)

scripts/checkpatch.pl -g HEAD
total: 0 errors, 0 warnings, 25 lines checked

Commit 27ce2cf2018e ("net: icmp: avoid invalid transport header access
in icmp_send tracepoint") has no obvious style problems and is ready
for submission.

Thanks.
