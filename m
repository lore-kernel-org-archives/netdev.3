Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437B38C2C0
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377248; cv=pass; b=m7m0EnUjVd14PJGKwhbJkJPZPs7FXjlvoKOxZNmsPVvNJI+wdLce286Vs9YfvPWiewlhSvy409gFrMatARSfGOGYfsv3M+NUPCADvlZyJPQ6PMiV9Nq0WEiCRseIGjbG/07amJg7YMOOFea7VWIVMch41XZncyNhoLXJXcfXixw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377248; c=relaxed/simple;
	bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTcY1qJEmvDpB2XLpm+9yBEb9OWLpNYXMe+jL4XjBk4EtDRE2glhxUmnS5Q0KMICcmBGYmafD+QhV/ojprB9E6QCtaBtJNVh22PkIgmgtsWu1YSKxAA/uhqvLPH6YczbHiDAy6/u7awYXvz6J2qsI4Wg4QO0uKrsCzi4T9ZUyFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK8tdRhB; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK8tdRhB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66825847b2cso2547319d50.3
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 05:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377245; cv=none;
        d=google.com; s=arc-20260327;
        b=CcZBYQ9AHeg1+2S0WIXPXxgH2IpELFQcjOHyhsHhIEbAa/BTjUKAPggty4jeI2pJoM
         zx5nBkAGm0WepmxvfRb5rLzHjTPd5EOT+a2rYmpH1zxGuduUruT1DxEfBnvGl/oQWCYI
         mmzv6Z7y2K6TnZ7q42ALW1LkW0k7qlQSi3SisGbMoEVmBM0BI08sGXz0/doNF1RHvAov
         HjIsNHYuujnyGdO1KVpM7bkr2qEgzxVYhONHa2jl0pf9Gsz2KNK2+kGtOQ9gJ3Bdcmpm
         A7FUntXlKT43ax8obF7NCSMBQ929wb5lTt5UDi3jBDrN+StjSfN3ncBdNhJKHgB/dVOo
         HLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        fh=OdfugPQPOe2LireUo5AnXS06/6juTB4HQrPvNoq7mKw=;
        b=dg0EdSkX+vn9Ahl65756MSqi/6nzrNmYZjJMj348vSMSdzw9Qgvx73krQAljl0+GnP
         VUHkMVL5OZ6pR69HrM4gM+RsP0KyWdEaCRkeFliLV5KHvcMDIivE6feIkS+HZmUfBk0o
         hFk9aZsyq6Rdt7kiaaPh3LCIamIYmnglaf+FWLYYiIo0DJ7zRNOOmcf4y/WG5IBvnDgA
         K7kbI4lIu8reEL8pQYLmuZtClzfPX3kQec6kau5hYqa119FNjS14Tkz6XE7ZAuLAQRkq
         WJOFqX8HvmPNQVNCO2J0SXH6ysh6dMTDaVb/UWmTvncwHtSo/p3Ei+3ily+Fk/Kg6b7u
         634g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377245; x=1784982045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        b=rK8tdRhBCZGmCjFwHJAZrSAy/R5CWqCNYAHdAaTwvkQP/6RcRYWBprl1VqbNVaUUsS
         jxqchWrCWLdDgbeqautYrKdufPK18YjfO8UYbtQZ4HcVlV8xF5hmCuCryfHh1UCPzCcg
         I1GvuhDz4SBh42AXie4UGRD/insCGoJSLeqfHGLKZk9UkaKgiKBL0BQTUEkl1+cDsfN5
         M61/XKoxywFgAS+dCRlN+namyLs5vQeqhIvGVC/N7Mt9iz8LdHUyS47HjBm+nkWt6M9K
         RRUY7VwpzgGIDXAFj40wJTJDwVLEX22hvA+QrCS5q3xSSxwNcnXQbJAOLV9fVgibWzqN
         Q7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377245; x=1784982045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        b=gDGfPkpEudfnljeL0GDLbwj4Vsrvs3lZtm2CIN0CD36cytmtLCWKam6yS99UrObXti
         ydlVNILGYTPo3wCbFk4zJho0YdxFfXR8/N5rPYTwZCucx12ayTDwSivdVc+HSLfk+lFw
         f75aXKkI3i0APWI7CVHGAcOBaadT5oKATl8sTdZJkXfNHoo1jKTPmpBdIbwqay1aJTbV
         RQh4wYYAp5iyYs3fywZo8UqtNvIVUv6rbggNvfUdEgE31jd36+ctFPyqSnVDwRiQA4f8
         oBHWmPjS+4wM1nfXeBNhjS6ocouXbRKGExUVZA1j9qRMzDaDbs8nEr6bRvawa8GVLocq
         bDwA==
X-Forwarded-Encrypted: i=1; AHgh+RoRhw/g5tQOUFwk3bWtucczBktKXhEVpa+WSfKXZ7aLVfpvFkjMU24zlcOUMiTOTiCNDzoB86U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhOmxiTvlc5DxIwb585fANHBHnLKOCb/r+wL5XLnbWx6S3qfX
	7AZRNzqH/MLvaYPyo6sqLZ8X8F6eDCmUHiMGaNCpT1CEKW5oxhReSGghXlQrN0WS2GfpMrav61E
	EioCrEknjLF6lQBTaPD1ugiYyGM8g45E=
X-Gm-Gg: AfdE7cnGjjg7htTrJPj299ExiGG9Y4e7rF6xEGYNAKJ5Q9gOm3ILAi9KMNzZ2n9+khf
	kUNXiRuLm1emo9ug4uQwWe6EJAcQ7xDipUpvhHjZp38/UIBa+VGZQ+EfnxKxFUwjruiJS1SKDbD
	+kxkWOPmEM66G/lpg7yBqYdW79/08BHlEE9Dtl8Zmi580ifqCOiNxCkUvV1oQaqHsGi+Rne7B/K
	SUYt1NSms7badkhRg+4TwQpUmOS8kr2rD3hhZH5bVQ37IcHpgNpF2ygMxEU6w==
X-Received: by 2002:a05:690e:43c2:b0:667:c01a:4ac5 with SMTP id
 956f58d0204a3-6683bb0c3b6mr1363452d50.38.1784377245608; Sat, 18 Jul 2026
 05:20:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:44 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:44 -0500
In-Reply-To: <87h5m2g70l.fsf@bootlin.com>
References: <20260709221858.158063-1-devnexen@gmail.com> <87h5m2g70l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 07:20:44 -0500
X-Gm-Features: AUfX_mx-LxGT1icCnBbh0h4QeQdJg-IRuavKQPCspOdeBSsqwocWMxKfeD5I5ro
Message-ID: <CAMuQ4bVWGV8Qz7LM1RCVhXJGRV0KVPFXvvhshDEijkv=+aq7Yg@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: serialize pib updates to fix double-free
To: miquel.raynal@bootlin.com, devnexen@gmail.com
Cc: alex.aring@gmail.com, stable@vger.kernel.org, 
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com, 
	stefan@datenfreihafen.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes. I'll send v2 of my teardown patch with rcu_access_pointer(). It
is separate from David's patch: mine moves the final PIB free after
unregister, while David's serializes concurrent runtime PIB
replacements. I don't think his patch is superseded by mine.

Thanks,
Yousef

On Mon, 13 Jul 2026 18:59:38 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello David,
>
> On 09/07/2026 at 23:18:58 +01, David Carlier <devnexen@gmail.com> wrote:
>
> > hwsim_update_pib() does an unserialized read-swap-free of phy->pib:
> >
> > pib_old =3D rtnl_dereference(phy->pib);
> > ...
> > rcu_assign_pointer(phy->pib, pib);
> > kfree_rcu(pib_old, rcu);
> >
> > It assumes the RTNL is held, but ->set_channel is not always called
> > under it: the mac802154 scan worker changes channels via
> > drv_set_channel() without the RTNL. Such an update can race an
> > RTNL-held one on the same phy; both read the same pib_old and both
> > kfree_rcu() it, double-freeing the object. With SLUB percpu sheaves
> > batching kfree_rcu(), this surfaces as a KASAN invalid-free in
> > rcu_free_sheaf().
> >
> > struct hwsim_phy has no lock for pib. Add one and make the swap atomic
> > with rcu_replace_pointer() under it, dropping the misleading
> > rtnl_dereference().
> >
> > Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D60332fd095f8bb2946ad
> > Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > Cc: <stable@vger.kernel.org>
>
> Thank you for the patch, but I think Yousef already provided a similar
> patch:
>
> https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.=
com/
>
> Yousef, can you confirm you will send v2 soon?
>
> Thanks,
> Miqu=C3=A8l
