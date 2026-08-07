Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968C3BE16E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087395; cv=pass; b=gF3zySYUtceNlVDENynWLdqgl6hmwN/2bYU75AisX2kd52DLpnEiO51WkRvraZ4fg9lH8n6GxekzRIb9cdJrAj3/CzeXBizgNdbDBA+vyXR6ICRizZxbujGib/xnHf1bptG9zlHGZXrrRtRl7OEeWf7AcyPbOXaWPWnno4on2bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087395; c=relaxed/simple;
	bh=HImDacCtxNZ8rpm/SzQRPi0GQevYQMrg2N3EOKNrz60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3fcXBGS0DiptL3pZ8YVUops9dTEpdAhAkUNdEIFlwBrXC8pNhgsfPYHo+pJ+PrKJjpsovTBqdGdWYzFkvJE0qXs47f/+XV1fgXTVA2VNJUivf8uFdLuJbupd+X0TIvirET7qMmoBast7/LdMkIvW7RChjv5A1FvBiteVHy2lFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDdaCi5D; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDdaCi5D"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso2829654e87.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 00:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786087392; cv=none;
        d=google.com; s=arc-20260327;
        b=BLoWM9nv2rp7lthELowGuVtExeN7EeHka107DaMRQmCBX9C0KQl4+v9Eoj/0aemyRa
         LlIvFYkvJurGt74D91Vlr0kheDwQjq7sn5AHhj0P0MUsZogmKQnz/Sojw0MNM1Cdwd0K
         zQ+5o0NxrFlDMkz4Gya6h+5AC1WjSYs49xvhDcvT0ED9iaM0u2nQRmDRptZVB0Rg3MIo
         cN2a75y8BADvm5YcdBTbLlqHI1BXwHnN9Cx5mZ1PIKNtm4aQHJj8U2gobuz1Ai0WNbWW
         BLiJ1qZspjRDgN3jALvbsmAIbTRPcrn7cqdz6I+YY6DQ+jmycLGh+smkCdRjAGqhJPnn
         FWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qBOOqYrbKKpUPxiZI3pfK/IOXxHN0YvtcrwzcuOE5q8=;
        fh=PfziFQKZGHFQoyAhTjBHsFZJeKCzWCKPUWFh3ud1yfM=;
        b=l1frsTrXbkxMSZs1FwvyEHLijqaQkFy1Ln6FHhD8x2prVw5rOodd+XsjyDM3hewtyX
         ykDTCCznayWk+aomHourJcOWa3XaPz0COGcUZ1uUWc+vbeSJC/mKgil/wZGFeamLpfjr
         KgLa3O3OQtOdvPd+/rcfWuKLNmXoMWJMB+ddnMtcyUP0G2fMp2PiVXYGYfdru8vqNyIG
         9+Z4pGUfdyT1FIxGGHJhlHhB2s5N0OswfMTQmyibTI08KI/AMJ9QrtBwoDVXFSUuGD97
         LVC0cym0mG9DdHWSfR5SYbV/w++uetIxUROZOdRBtbFjOVjnjuGs/jMb2JvuiSE1ob2y
         PkeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786087392; x=1786692192; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBOOqYrbKKpUPxiZI3pfK/IOXxHN0YvtcrwzcuOE5q8=;
        b=hDdaCi5DFrN4qg8BZK0lcSfWf4ZgIGmsiNAWOACKcF6FMrrcBA5cATSlE6X7pL5f1j
         68xMLFjH4SBUKE/tDw7WUnc2qxWnc1/cqBys+3La5jsPdzfS/JGhnflhEdoqv6KfBfXo
         4seW7k8W0HporM4/8vkFyGHene5sRzamep9E3qmWGEKMYCRB2Pp6LAa26BfVBB3g6Elm
         carSzMmiu++nYTp+ePU4galqzEJJeQkfC9g8L+Fbb96SAGnxZl75c60VJJYfUdfb/nSQ
         gfiOF61TBN0NIvC70csddPz6RcZoAPxaKDCqtUYFKI8FTWpofKRlPdEgM6lS5UfOSUVT
         cewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087392; x=1786692192;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qBOOqYrbKKpUPxiZI3pfK/IOXxHN0YvtcrwzcuOE5q8=;
        b=NBiBPwx355+pvguM0yYxaThnJgyZQ4YBJ9H8lDHhMMQq+KdstaqIBbWLk2G46ZSiDG
         VoEAP2nPm8I0xFw3n92cg+izHqbWM7Ilp9dlkqpPGm4PQMxEb6ueXV1JNuHecFsQJQPu
         kDAjO1W9RKYZ4IjNTgaY5KC1Shi5azZRHYZZb3x8Z55dX79YIbjf0FjFnISnzunDez6Z
         1wgbuoIZVc5SP1V8aBCAt6Gf1oKKuQUvsVRcTEpCKq033FR1WVSQXoel/d7XxD8gIt/i
         oQa31utaLrX6vLqeOZMUbj1o4pgzl/DL6yFj87Amajq4GBJlEceWSN4YkqlB3DsPzM1a
         LzWg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9BjsopJo1L8Y4XFtjr+UJkFgJeV1wEr5Vsn+TWFZaURD/T9ug78hr7nTOhAI4qr358hg/4ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhx8D/pvomb4qpP9Hg1cDjc+RCqa7Vkh44j0fRtm19dshie84Z
	cY36COaR9hhQ2shJmRjIKUWowIpO/0XN2ZtnubKA61dRjDc0hGocgZn0jrmeBPUutx8krT4DBdn
	Fcf43XQJcT7PoBr5UhPMpCCtYiAKsF1I=
X-Gm-Gg: AR+sD12deNz8sdzX2FvRJtnyJn0VHVGyVKWuMAyPNFefFc/eSVOUJs3slmAVqn1ywnf
	AP4ERU1CJU2SFXa/RqAlAhg4fq5z9lJ1u01i/ZQhG47md1M9i7L5GhWeo1PRy/yx+H8ug7bGwxw
	8xxzRTVu8DhahpAvvTzaUnEdf2tWCqNcwPee2d0fJ79KsG/ev956rgIO8IftjYlr2Z1qSjQVkQr
	7aLrDmIuz6t4fN+Mv2HseOuux/e68k7nejcEvSD4y68rm0ALjFYKSL7aYtIh9M2SRaXMtUTXqnc
	7DGHC1L73MFjoIFoUN0I28Zx7OJxHGF+QZKvLeNvqSDI
X-Received: by 2002:a05:6512:12c4:b0:5b1:5457:a930 with SMTP id
 2adb3069b0e04-5b303b46bddmr1074351e87.16.1786087391115; Fri, 07 Aug 2026
 00:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805043643.194976-1-krishanmohan298@gmail.com> <4effcfad-50db-43e4-9e6a-7227525cc53f@lunn.ch>
In-Reply-To: <4effcfad-50db-43e4-9e6a-7227525cc53f@lunn.ch>
From: krishan mohan <krishanmohan298@gmail.com>
Date: Fri, 7 Aug 2026 12:52:58 +0530
X-Gm-Features: AUfX_mzP5OWtloMibtMUgRvWsWHSgnox17-iZNvXmyh4HLktlx7t4PvtYORbB4M
Message-ID: <CAAvqt3s1Tt9zM9vUO1-khbRPLX=fQbPaDsG_Xyd3t87reyWvNQ@mail.gmail.com>
Subject: Re: [PATCH] net: sfp: Fix memory leak of hwmon_name on hwmon
 registration failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007c6d6d06586fe06f"

--0000000000007c6d6d06586fe06f
Content-Type: multipart/alternative; boundary="0000000000007c6d6c06586fe06d"

--0000000000007c6d6c06586fe06d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Please find v2 of this patch.
Changes since v1: - Move hwmon_name cleanup to sfp_hwmon_remove(). - Free
hwmon_name independently of hwmon_dev.

---
v2:
- Move hwmon_name cleanup to sfp_hwmon_remove().
- Free hwmon_name independently of hwmon_dev.
---
 drivers/net/phy/sfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f52020673..bfa2b821f 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1916,7 +1916,11 @@ static void sfp_hwmon_remove(struct sfp *sfp)
  if (!IS_ERR_OR_NULL(sfp->hwmon_dev)) {
  hwmon_device_unregister(sfp->hwmon_dev);
  sfp->hwmon_dev =3D NULL;
+ }
+
+ if (!IS_ERR_OR_NULL(sfp->hwmon_name)) {
  kfree(sfp->hwmon_name);
+ sfp->hwmon_name =3D NULL;
  }
 }

--=20


Thanks&Regards
Krishan Mohan Singh


On Wed, Aug 5, 2026 at 5:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Aug 05, 2026 at 10:06:43AM +0530, Krishan Singh wrote:
> >     hwmon_sanitize_name() allocates sfp->hwmon_name before
> >     hwmon_device_register_with_info() is called. If the registration
> >     fails, sfp->hwmon_dev is left as an error pointer while
> >     sfp->hwmon_name remains allocated.
> >
> >     Later, when the SFP module is removed, sfp_hwmon_remove() is still
> >     called. However, it frees sfp->hwmon_name only when
> >     !IS_ERR_OR_NULL(sfp->hwmon_dev) is true. Since sfp->hwmon_dev is an
> >     error pointer in the failure case, the cleanup block is skipped and
> >     hwmon_name is leaked.
> >
> >     Fix this by cleaning up hwmon_name independently of hwmon_dev.
> >     Continue to unregister the hwmon device only when hwmon_dev is vali=
d,
> >     but free hwmon_name whenever it is a valid allocated pointer.
> >
> >     Fixes: 3f118c449c8e ("net: sfp: use hwmon_sanitize_name()")
> >     Suggested-by: Andrew Lunn <andrew@lunn.ch>
> >     Signed-off-by: Krishan Singh <krishanmohan298@gmail.com>
> > ---
>
> Please read
>
> https://docs.kernel.org/process/submitting-patches.html
>
> There should be a version number in the Subject: line, and under the
> --- a version history.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> For netdev, we want the tree to be indicated in the Subject: line. For
> this patch i would suggest net-next.
>
>     Andrew
>
> ---
> pw-bot: cr
>

--0000000000007c6d6c06586fe06d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All,</div><div><br></div><div>Please find v2 of th=
is patch.=C2=A0</div><div>Changes since v1:
- Move hwmon_name cleanup to sfp_hwmon_remove().
- Free hwmon_name independently of hwmon_dev.</div><div><br></div><div>---<=
br>v2:<br>- Move hwmon_name cleanup to sfp_hwmon_remove().<br>- Free hwmon_=
name independently of hwmon_dev.<br>---<br>=C2=A0drivers/net/phy/sfp.c | 4 =
++++<br>=C2=A01 file changed, 4 insertions(+)<br><br>diff --git a/drivers/n=
et/phy/sfp.c b/drivers/net/phy/sfp.c<br>index f52020673..bfa2b821f 100644<b=
r>--- a/drivers/net/phy/sfp.c<br>+++ b/drivers/net/phy/sfp.c<br>@@ -1916,7 =
+1916,11 @@ static void sfp_hwmon_remove(struct sfp *sfp)<br>=C2=A0	if (!IS=
_ERR_OR_NULL(sfp-&gt;hwmon_dev)) {<br>=C2=A0		hwmon_device_unregister(sfp-&=
gt;hwmon_dev);<br>=C2=A0		sfp-&gt;hwmon_dev =3D NULL;<br>+	}<br>+<br>+	if (=
!IS_ERR_OR_NULL(sfp-&gt;hwmon_name)) {<br>=C2=A0		kfree(sfp-&gt;hwmon_name)=
;<br>+		sfp-&gt;hwmon_name =3D NULL;<br>=C2=A0	}<br>=C2=A0}<br>=C2=A0<br>--=
 <br><br></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Thanks&amp;Regards<d=
iv>Krishan Mohan Singh</div></div></div></div><br></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Wed, Aug 5, 2026 at 5:28=E2=80=AFPM Andrew Lunn &lt;<a href=3D"mailto:andre=
w@lunn.ch">andrew@lunn.ch</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Wed, Aug 05, 2026 at 10:06:43AM +0530, Krishan =
Singh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0hwmon_sanitize_name() allocates sfp-&gt;hwmon_name =
before<br>
&gt;=C2=A0 =C2=A0 =C2=A0hwmon_device_register_with_info() is called. If the=
 registration<br>
&gt;=C2=A0 =C2=A0 =C2=A0fails, sfp-&gt;hwmon_dev is left as an error pointe=
r while<br>
&gt;=C2=A0 =C2=A0 =C2=A0sfp-&gt;hwmon_name remains allocated.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Later, when the SFP module is removed, sfp_hwmon_re=
move() is still<br>
&gt;=C2=A0 =C2=A0 =C2=A0called. However, it frees sfp-&gt;hwmon_name only w=
hen<br>
&gt;=C2=A0 =C2=A0 =C2=A0!IS_ERR_OR_NULL(sfp-&gt;hwmon_dev) is true. Since s=
fp-&gt;hwmon_dev is an<br>
&gt;=C2=A0 =C2=A0 =C2=A0error pointer in the failure case, the cleanup bloc=
k is skipped and<br>
&gt;=C2=A0 =C2=A0 =C2=A0hwmon_name is leaked.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Fix this by cleaning up hwmon_name independently of=
 hwmon_dev.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Continue to unregister the hwmon device only when h=
wmon_dev is valid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but free hwmon_name whenever it is a valid allocate=
d pointer.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Fixes: 3f118c449c8e (&quot;net: sfp: use hwmon_sani=
tize_name()&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0Suggested-by: Andrew Lunn &lt;<a href=3D"mailto:and=
rew@lunn.ch" target=3D"_blank">andrew@lunn.ch</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Krishan Singh &lt;<a href=3D"mailto:=
krishanmohan298@gmail.com" target=3D"_blank">krishanmohan298@gmail.com</a>&=
gt;<br>
&gt; ---<br>
<br>
Please read<br>
<br>
<a href=3D"https://docs.kernel.org/process/submitting-patches.html" rel=3D"=
noreferrer" target=3D"_blank">https://docs.kernel.org/process/submitting-pa=
tches.html</a><br>
<br>
There should be a version number in the Subject: line, and under the<br>
--- a version history.<br>
<br>
<a href=3D"https://www.kernel.org/doc/html/latest/process/maintainer-netdev=
.html" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/html=
/latest/process/maintainer-netdev.html</a><br>
<br>
For netdev, we want the tree to be indicated in the Subject: line. For<br>
this patch i would suggest net-next.<br>
<br>
=C2=A0 =C2=A0 Andrew<br>
<br>
---<br>
pw-bot: cr<br>
</blockquote></div>

--0000000000007c6d6c06586fe06d--
--0000000000007c6d6d06586fe06f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-net-sfp-fix-hwmon_name-memory-leak-on-hwmon-regis.patch"
Content-Disposition: attachment; 
	filename="v2-0001-net-sfp-fix-hwmon_name-memory-leak-on-hwmon-regis.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msim9srx0>
X-Attachment-Id: f_msim9srx0

RnJvbSA5YWFiN2Y3ZTg2MjI4ZjcwOGE5YTk2OGI3NTZjODM1MTZiMGNlODE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLcmlzaGFuIFNpbmdoIDxrcmlzaGFubW9oYW4yOThAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDUgQXVnIDIwMjYgMTA6MDQ6NDcgKzA1MzAKU3ViamVjdDogW1BBVENI
IG5ldC1uZXh0IHYyXSBuZXQ6IHNmcDogZml4IGh3bW9uX25hbWUgbWVtb3J5IGxlYWsgb24gaHdt
b24KIHJlZ2lzdHJhdGlvbiBmYWlsdXJlCgpod21vbl9zYW5pdGl6ZV9uYW1lKCkgYWxsb2NhdGVz
IHNmcC0+aHdtb25fbmFtZSBiZWZvcmUKaHdtb25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhfaW5mbygp
IGlzIGNhbGxlZC4gSWYgdGhlIHJlZ2lzdHJhdGlvbgpmYWlscywgc2ZwLT5od21vbl9kZXYgaXMg
bGVmdCBwb2ludGluZyB0byBhbiBlcnJvciB3aGlsZQpzZnAtPmh3bW9uX25hbWUgcmVtYWlucyBh
bGxvY2F0ZWQuCgpMYXRlciwgd2hlbiB0aGUgU0ZQIG1vZHVsZSBpcyByZW1vdmVkLCBzZnBfaHdt
b25fcmVtb3ZlKCkgb25seSBmcmVlcwpod21vbl9uYW1lIHdoZW4gaHdtb25fZGV2IGlzIHZhbGlk
LiBBcyBhIHJlc3VsdCwgaHdtb25fbmFtZSBpcyBsZWFrZWQKaWYgaHdtb25fZGV2aWNlX3JlZ2lz
dGVyX3dpdGhfaW5mbygpIGZhaWxzLgoKRnJlZSBod21vbl9uYW1lIGluZGVwZW5kZW50bHkgb2Yg
aHdtb25fZGV2LiBDb250aW51ZSB0byB1bnJlZ2lzdGVyIHRoZQpod21vbiBkZXZpY2Ugb25seSB3
aGVuIGh3bW9uX2RldiB3YXMgc3VjY2Vzc2Z1bGx5IHJlZ2lzdGVyZWQuCgpGaXhlczogM2YxMThj
NDQ5YzhlICgibmV0OiBzZnA6IHVzZSBod21vbl9zYW5pdGl6ZV9uYW1lKCkiKQpTdWdnZXN0ZWQt
Ynk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4KU2lnbmVkLW9mZi1ieTogS3Jpc2hhbiBT
aW5naCA8a3Jpc2hhbm1vaGFuMjk4QGdtYWlsLmNvbT4KCi0tLQp2MjoKLSBNb3ZlIGh3bW9uX25h
bWUgY2xlYW51cCB0byBzZnBfaHdtb25fcmVtb3ZlKCkuCi0gRnJlZSBod21vbl9uYW1lIGluZGVw
ZW5kZW50bHkgb2YgaHdtb25fZGV2LgotLS0KIGRyaXZlcnMvbmV0L3BoeS9zZnAuYyB8IDQgKysr
KwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3BoeS9zZnAuYyBiL2RyaXZlcnMvbmV0L3BoeS9zZnAuYwppbmRleCBmNTIwMjA2NzMuLmJm
YTJiODIxZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvcGh5L3NmcC5jCisrKyBiL2RyaXZlcnMv
bmV0L3BoeS9zZnAuYwpAQCAtMTkxNiw3ICsxOTE2LDExIEBAIHN0YXRpYyB2b2lkIHNmcF9od21v
bl9yZW1vdmUoc3RydWN0IHNmcCAqc2ZwKQogCWlmICghSVNfRVJSX09SX05VTEwoc2ZwLT5od21v
bl9kZXYpKSB7CiAJCWh3bW9uX2RldmljZV91bnJlZ2lzdGVyKHNmcC0+aHdtb25fZGV2KTsKIAkJ
c2ZwLT5od21vbl9kZXYgPSBOVUxMOworCX0KKworCWlmICghSVNfRVJSX09SX05VTEwoc2ZwLT5o
d21vbl9uYW1lKSkgewogCQlrZnJlZShzZnAtPmh3bW9uX25hbWUpOworCQlzZnAtPmh3bW9uX25h
bWUgPSBOVUxMOwogCX0KIH0KIAotLSAKMi4zNC4xCgo=
--0000000000007c6d6d06586fe06f--
