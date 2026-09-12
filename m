Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C324BEE2A
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220679; cv=pass; b=iMgWml6r8cR9cp4TkEz9GwFk/97wYy4Ix/s837gjLQh5hR5Hv4yauhrGm0kN8C7wPM+nS02e+YPZKvgW2egaU65UiM0HoESP0tLxV/NmfhbuIIdgg8vDmx0mK+P2+mHiSL08zy3BZJViHs+B3jVGuVc4tZeOuLB//AoreyeswiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220679; c=relaxed/simple;
	bh=/5lD6Jd6NB0SSR+wwu0DK+A3eE+C1uN3trHJtG2etZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrPIgMvvwohvlgNVHe+5hVdbaXIyoBwb2iiqOPWwhKUhv9hVbHV7IvgHDdLeZ1e/IFhyPZXhwoZrbD61uCxiDgy1C1qsZd4N4CgYWl7nIZO//ZQZWQpMKY+h8eWX2enpt+aE1SYMbgQ+Kv0audo7LkcvVCrTmHNTfcpmE2NYg7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QURW5dmB; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QURW5dmB"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd6so81545185a.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789220677; cv=none;
        d=google.com; s=arc-20260327;
        b=CaJt44INSUecrLi5/fK0SfjXfBfJKUk3+x9CoEezgsw6Hpn+ZkAQ8fmOATStfk3N36
         zuqnIIZ78tPJ91fvMQhzH3sINmXvR6D7eCYGI336PYZrZwzVLaI8OioG0H4WIGRJxoQ1
         iP2aV93ep/2S740ICpD+Blsrk+su41PABRECHxpRFCGQfVX8B4Mdh6YMOn9z/EzlaQWV
         pOEsx3w2QDaJs8gRJzPzjj0/2mUPy8tgwDYKsnoLTAIAjvLtfwMSZJG2GkCfsRw3/vzk
         N1FALeRqLN4CBgY8H9ytb3Q4LScXOlWnRlUt4JyaMh2DuamJaYg2pjHNmYRJEfSbRIPw
         bQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/5lD6Jd6NB0SSR+wwu0DK+A3eE+C1uN3trHJtG2etZI=;
        fh=pQYPGE9fPMqg++sbeceFWEZ7WgK4fIl4eebL5fBPQNM=;
        b=nb+4meih9o+D7O/GeGy++1QLBTSlXUgiaPMuY1zCSA8gTY4yyITDEcKQAw5WUeURDn
         EFczRuPzNIz4P8RMOZWN4G13lkvFuZ09OUUsLHF3XgRFcuuLYVTu0tAxPao04KGwaZJ0
         Lsk6PV6+t2u27SOaeYtxzK2AWBkGEyMnNc3DgTEnilsUJSemqbC7Qkt/+rZzfH4VdN7a
         0ygf3Rsa3kZoJOy8rrC6ZhIrN5xAnDukcPz9JcYO0NflIhaJtvD/ga3463k1HTAQ1J/P
         PN1RCMVLaDEE0aHkrWq+KiNT0du8D+yh1tz6ZAzfJE5eUU1gApALD7guuDEJb9wOgwj4
         ofRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789220677; x=1789825477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/5lD6Jd6NB0SSR+wwu0DK+A3eE+C1uN3trHJtG2etZI=;
        b=QURW5dmB+/pGq90rwJpLj/JseHkWiZVAYQXn+l9TwGP22ufhwBoQWCr1pxHsS0Jvwk
         tBYWmvFI2Exk8FBcEpz/NYrAGna5Qukdi3i9+bizhGk8pyvzvx0ns96acPQfymjqUlpu
         JsOLnIfpZLVIN7weJA45zem4pP4zNM+Kv+97zrjFG8LJX3l/5uJtlxkaqidWaNJ4Y2nk
         Mni7eNAA3GYasryHT+TphwuDeafvdL+eKCsB41Cr7/JppR0UH8wKhSFgYoFNZgMYBdVy
         OzLDMVp+66BV6KLxUKabfBozdloPg8YEhZj2IoPAZS567VJfq+9AdAOnyDJUEFwPKwTW
         UOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789220677; x=1789825477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5lD6Jd6NB0SSR+wwu0DK+A3eE+C1uN3trHJtG2etZI=;
        b=Wor2ga25VCqp5gq4WjsCxDc0OpYXipRuiWBaZvuRiK7aKsQHbLzFTLTQqcvI96M6fK
         fAAZ6elcYRJbNylHJQ9c1jdvJ+NpAUEY7BGHOERyAJ+b8gtyosAGJgbuzSjIusZ9ePXa
         ddXA0eFFD5VeiluWHA+Yq8qAUD6zTxTQlUaPLfFjlIx8/6HFvJ5y1dtuyJDuDimJ3Nfn
         iwXzlgZ8pDOLDoTfcXoUL06+BEOwE1BjLiedEP5hACIZ0eXYXODJDlsyDTHuDoiDv3mR
         4g1YYkC1i+tX2/OdbmRBTYh0P/0MyRAa6kHs0ffk8tb/T1UHBkzkhLnA5pK2jRrytasv
         0Bgg==
X-Forwarded-Encrypted: i=1; AKwUvBxAQmmWv4FqXyLYo7394b9kfIVAJtU+4Sxffi1fcLq0vs7/B8H42gZTcPb5wbi6462B3Zhte8s=@vger.kernel.org
X-Gm-Message-State: AFuF++k5dNRTYm9cc1uhED5ofF6JRs+yO+SPuBPHIJCYyVLZpO8Xbrmv
	tTZvm9cXoUmN5IwzrPI0GMrNs06m4eVCn4irR7/4gQXwHTSDAJfZ6BpD/vYr7WKk2Edb3ys05B2
	SrABhPFHXrH+2/lgKA0CmdR9qd48qSZ1Wmn8hCmcH
X-Gm-Gg: AYBFou2Wx/9cZO8SFtCAZ6z9FuzaUMmCHkdIsK3oO/B/QK1K2dHZ2ju0RsX69NdXjyE
	OxaX/T+nPW2ChCy0kIATqw4zutLIyMfFdEQph+oBN+FJllhouF7VlU3s6HemNwksW0fsjPYuzk0
	Y+E/ql49eBtbakmdaVo3oEdySWYcoi8e6V2giFnZ9LPgHsc3VaAZCbJ0p7RQd0Y/IflF642bs/+
	md7xkH9bAPJL3/iqNj/i/l2HoaWUbwjqLBnhtGbizIGnNlcmh4pSTxhj3Fr8SylCIFGfEprj8Rp
	PMmrZNUZMYmBuGYVjpPqxQOOWUUlj2RtAT9kyBvmVdPqDtG1RMo7VMXTsInmbbFvWZhXjycvFDu
	j25sywqsU8e0WSMYrQ95+63mwo5oGchpp1bMrLXbEjcZ88a4BkVwJPGN5dVne0L1rb/Y=
X-Received: by 2002:a05:620a:1b97:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-939ea17e36dmr1200221885a.27.1789220676530; Sat, 12 Sep 2026
 06:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911114922.621937-1-edumazet@google.com> <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
 <CANn89iJw5P-wARumRgxdPaHXBJ3qF0zu6FNaNOFKonyww9AJpg@mail.gmail.com> <d9cb00fe-85fe-466f-b6ee-c5694d134ed4@linux.dev>
In-Reply-To: <d9cb00fe-85fe-466f-b6ee-c5694d134ed4@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 06:44:24 -0700
X-Gm-Features: AcwNN1WF6brfpM-4hnQEBfNiinBMuYw3FFkVmaCqPDXdDCWaxZnd5YcDoO6S668
Message-ID: <CANn89iJYEGDBcFxC3kh1KPbvxs3Qh0aU8YrgH=h6xdHMJm0iyQ@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after pskb_carve()
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 6:39=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> =E5=9C=A8 2026/9/12 16:57, Eric Dumazet =E5=86=99=E9=81=93:
> > On Fri, Sep 11, 2026 at 11:38=E2=80=AFPM luoxuanqiang <xuanqiang.luo@li=
nux.dev> wrote:
> >>
> >> =E5=9C=A8 2026/9/11 19:49, Eric Dumazet =E5=86=99=E9=81=93:
> >>> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> >>> the first bytes of a packet and reallocate skb->head.
> >>>
> >>> All the headers that were present before the operation are gone,
> >>> but both functions call skb_headers_offset_update(skb, 0), which
> >>> is a no-op : skb->mac_header, skb->network_header,
> >>> skb->transport_header and skb->csum_start are left with their old
> >>> values, now pointing into the freshly allocated (and possibly much
> >>> smaller) skb->head.
> >>>
> >>> For pskb_carve_inside_nonlinear() the result is a zombie skb with
> >>> an empty linear part (skb->data =3D=3D skb_tail_pointer(skb),
> >>> skb_headlen(skb) =3D=3D 0) but skb_mac_header_was_set() still true an=
d
> >>> skb->mac_header pointing far beyond skb_end_pointer(skb).
> >>>
> >> Could you please clarify how the MAC pointer ends up beyond
> >> skb_end_pointer() here? The carve helpers allocate based on the old
> >> skb_end_offset(), and kmalloc_reserve() adds room for skb_shared_info,
> >> so the new capacity shouldn't be smaller.
> >>
> >> The dump shows mac=3D234 and end=3D384. I understand how the stale off=
set
> >> causes skb_pull() on an empty linear area and triggers the BUG, but I
> >> don't see how it ends up beyond the new end. Am I missing another
> >> condition?
> >
> > skb_headers_offset_update(skb, 0) is a no-op, so mac=3D234, net=3D248,
> > trans=3D288 and csum_start=3D288 survive and now describe bytes that ar=
e not
> > there anymore. skb_mac_header_was_set() still returns true, so drop_mon=
itor
> > does skb_pull(skb, 234) on an empty linear part and hits the BUG in
> > __skb_pull().
> >
> > pskb_carve_inside_header() has the same issue, the remaining linear dat=
a is
> > shifted by off bytes while the offsets are left untouched.
> >
> Thanks for the explanation. The fix itself looks correct to me, and I
> understand why the stale MAC offset causes the BUG.
>
> Could I check my understanding of "far beyond skb_end_pointer()"?
> The dump shows headroom=3D0 and headlen=3D0, so head=3Ddata=3Dtail. With
> end-tail=3D384 and mac=3D234, the MAC pointer is head+234, still before
> end at head+384. For this nonlinear skb, did you mean beyond
> skb_tail_pointer() rather than skb_end_pointer()?

Is it an LLM which triggers your replies?

Do you have an issue with the code?
