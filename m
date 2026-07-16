Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0D3FADED
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204963; cv=pass; b=mhx4WFCn2Puro4g6OV94xQjvSE9sgwolUw2zA2mx+slEsoJ62Kh6PX63lPk8ZQIMfCOtIwqzF34Y2y/XjInTHtsavsUv+WF83KTETbhyrX9X4+VKbb8dx3lS70Qa8vro4IalXZzA0r6T9S/AkSStn0S38HrdmFoanzJIODhYpgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204963; c=relaxed/simple;
	bh=EXECNm9Mw8lsggNrMQXKurUYCf7P/iHYm3LVZEOSsMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBYVTykSofhK/CnwnIHIm+mKsw9Ix8RLbHunYhZvIRF4xIHuYmz06F1seY19+egRT/qoz15zRTqRX1qqdLCF1WpVmh2WPwGhnguAympUq3Q9VLBhyJcKAFlRkoSICF5AOy3m6W6TJPCeCgRtgEG6YW/ezMh806oAPv0u4YoXFfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jp/pEUL1; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jp/pEUL1"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2cce930cso30998101cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204961; cv=none;
        d=google.com; s=arc-20260327;
        b=AmCQaYE2HhXpxCu5QAxFBj7ebmCNp78N/eMXNgl+ZRH100YOAnfDMyjiOv1Kyn99Qp
         5m8DVBtJUdfbuQA2MfWGW4W171y/NjzlLadEmKl9JHl97NuhPcXEnxWHd8ze6LhPaRZN
         hU8GUQUyxyRA2q+zIu7VwL6gWBp5jF65N2z9+8iR+PLRIV2aEaeLLh4hr0Pw9vNCZ52X
         LlknBIXYhgQrmAvwvRGvi/jHYlSvaWZPL7YLtOc8cWIQw11/RyIeI0YfD45Bsf2eUVvK
         nlvh5IZFrGOKVsiA7L6REKcZUAN0Th6/Pif5oZyv+54lyHyRzhtsKDOjNRzkmfaR+fWI
         LjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhXE6Y2bIse3KB0/CXnbBS+o0RjZlc9AQ6eXAPOohkU=;
        fh=urv/pz6bt+BMahSrX1HrZABFfnMLrtiWnWpJVr/WJ7Y=;
        b=dz9D/xZaBaWROoCYhE4B1FVAqHYuQh5WNfLhqyQJFFXwF2Qb6TVYTUxQvCiIipJFFA
         kIo1Cf/0N0NsAGs/mzo0s3IdZ58lg59Xz/xseHhjp8SPReZ+hOCL8haXyM3+R7dZRtXs
         ujUiLfZCE6lMCJ6YmrB2ZzKHGHPIjlH/vKv6ZrZdPFoggQpGWzlD6ocHHPh6KsrRCgwv
         R9u3wLiRtW7lt7+LKzJ9Zbg5NKOlxHDpUe7k7c8MyQ7GF884g9+Ny7lL/1uWwC4W/JDX
         BMgzm5UPdXCA2V0DvSlO2XmdMPqeQ9n6XPX63pLT2hh55lWDaNCNVuVJsvyHxcEFlV1T
         +ZnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784204961; x=1784809761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BhXE6Y2bIse3KB0/CXnbBS+o0RjZlc9AQ6eXAPOohkU=;
        b=Jp/pEUL1bUFMSgJ4jiv2Z8LjBbgPQeLrlaSRO20+tOkcc9aykgNH0NMJUsz8g3tF/V
         2A5LZXtQATj2a4QBXIqoLg7ok5Uh9rc1IC6NuB35LpeBttXA1LRuqTS3kU80+NwH+xpO
         ETPtmAC686V6ayx3A8JTRSSe3ZOeTw6FzVqku3v7OIF4pkuu+8kDs3HNCShodhtNzN2c
         GXVfshymCjr/nEPS+3hZ7GUMFm8TIxiyA68NUhZbb7wGDjrrCg8EnLES5581UwKchY18
         A4YonCjzFa64a97Aso7GVKytB1t+Fv4sPWGWhZ7e7sZ9osq5iEOMnS6vam/dC44YyQJa
         E5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204961; x=1784809761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhXE6Y2bIse3KB0/CXnbBS+o0RjZlc9AQ6eXAPOohkU=;
        b=CyiuxGTOO9IM0/RwB98b3DS1P+gABt3TXrWqxqiPs5okF/MtXhm44l94IVcjG8QHVC
         +/NfoLQQgOxNWlzCj67Btq6GzBYt2kznpr1sOjmbKOk2CCC0P6AzHjeqzZuxgdKfOcw1
         R62a0UZQ0KhZkM3ytgEx48JRRzCmnkHElBulqtgT3vvlPsGVC5pIO2QJcY3J5Z7f5wLK
         RAqUErOg5cuM/ldxkwsKbW+fRWJOrOvEdqSIwf2DZHYcPxoT+N6mPfpheynIWGRp0u5I
         XTt5uovzVCe+NICdxWDlAj9/89iUsrplCzB4Y6nnZMHZCM//0ikf3Hq3zzFewUBJ7FXp
         KFNw==
X-Gm-Message-State: AOJu0Ywd6zYMfSYECwfbppuT+kev5MbTPN/zQWvME5JTpcRzk9EK4Mga
	ln14Iw7fLkECqGIp6K1cl03Kn7uCvGixXplbU6Z20A6HK1LM0ibqF47cUMQW0NwELz2TBhNIvtZ
	YpIKCcP8ZMr1E6fHcWo11ElbprzR3Xq2thOwGzy7j
X-Gm-Gg: AfdE7cnzqhG5qp6lVXc8mq2Qg1AEAuyEgxwSqMaa2f1xZqCCtfO0D4u4I+1z/vMBcmk
	WdepejSbUMRAmdhz2yKF9bLC+H8FGMspNsthePFz6g0Y8LF5bKmvfWS4DSRNG+r2mIWjFnzNG27
	ZSnTGk39g5Zt4WenXCFrcSuU3RWRFLMaUPzrnWKCJIdilSlrW3fZ6f3/045hkaIXbILSQmpTNam
	GfoFzPjVa0x24gc8+vvYBG1miWoj06vxZkAwbHGQriFjugnWM2TTfh0pEP/3zoJRryY0PK6mgax
	A3f8vaAdQIluS4ocUxGh937bzfcdhSdPlsb7KZfwqHQoijD6e5zf2TuveQ1ofP4ztdBSQqAdh+t
	w
X-Received: by 2002:a05:622a:4d09:b0:51c:2190:3b47 with SMTP id
 d75a77b69052e-51cbf0e00demr217286941cf.2.1784204960449; Thu, 16 Jul 2026
 05:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
 <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
 <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com>
 <CAOAwikBYp7AAxFAZgyLaOZEG6Eoomq3aqU9ViMS8nrO82PD2rw@mail.gmail.com> <CANn89iJ+M_r-c3iGK1o7_pLBTVF-s5_R-8MjL3=Q0Aj=1a4deQ@mail.gmail.com>
In-Reply-To: <CANn89iJ+M_r-c3iGK1o7_pLBTVF-s5_R-8MjL3=Q0Aj=1a4deQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jul 2026 14:29:09 +0200
X-Gm-Features: AUfX_mzSOUknsSH0kf_SpQzyRVqQ8_dOofQGFYVRnpSpwRw59OizJRvxLaRuxdc
Message-ID: <CANn89iLziS_XE8oz03VWU47NRzP-G8OexL=-C0mxcMMnOia=Rw@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Muhammad Ziad <muhzi100@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 16, 2026 at 12:40=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.co=
m> wrote:
> >
> > Thank you for the fix, Eric. Applying the other selectors from skb_in
> > makes sense to me, but I'm not sure if instead we should copy them
> > from fl4_dec?
> >
> > The mark param e.g. is gated by IP4_REPLY_MARK() on fwmark_reflect,
> > which could be different from skb_in->mark.
> >
>
> Yes, sashiko had some remarks.
>
> I have been playing with:
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 23e921d313b36b00d8ae5e14846527220c9db32b..b0eb4f8ff9867499dc3a96c92=
a414440b2d3a115
> 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -548,10 +548,12 @@ static struct rtable *icmp_route_lookup(struct
> net *net, struct flowi4 *fl4,
>                 if (IS_ERR(rt2))
>                         err =3D PTR_ERR(rt2);
>         } else {
> -               struct flowi4 fl4_2 =3D {};
> +               struct flowi4 fl4_2 =3D fl4_dec;
>                 unsigned long orefdst;
>
>                 fl4_2.daddr =3D fl4_dec.saddr;
> +               fl4_2.saddr =3D fl4_dec.daddr;
> +               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup_d=
ev);
>                 rt2 =3D ip_route_output_key(net, &fl4_2);
>                 if (IS_ERR(rt2)) {
>                         err =3D PTR_ERR(rt2);
>
>

Or even better:

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b36b00d8ae5e14846527220c9db32b..aaaa0e347702c4412ff515a9d05=
89c79c69c62d1
100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,10 +548,13 @@ static struct rtable *icmp_route_lookup(struct
net *net, struct flowi4 *fl4,
                if (IS_ERR(rt2))
                        err =3D PTR_ERR(rt2);
        } else {
-               struct flowi4 fl4_2 =3D {};
+               struct flowi4 fl4_2 =3D fl4_dec;
                unsigned long orefdst;

-               fl4_2.daddr =3D fl4_dec.saddr;
+               swap(fl4_2.daddr, fl4_2.saddr);
+               swap(fl4_2.fl4_sport, fl4_2.fl4_dport);
+
+               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup_dev=
);
                rt2 =3D ip_route_output_key(net, &fl4_2);
                if (IS_ERR(rt2)) {
                        err =3D PTR_ERR(rt2);
