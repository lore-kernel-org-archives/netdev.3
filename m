Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D32C21EE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821543; cv=none; b=HQsWNowpQgpcKVmENTUe5/UmmAgzeccXkEugwAdykQG5FAv0hpGK01FrGcvTqlcYY9n8xQqYJ1Zzj5XNuFAuMDzaBO8l7hwrJjCvOpqP/rXKcgS8Roa6ki8a9o8ruxJAlNgzudGYIOA1M37lVlUsONGc5x08RyYrc2T2MBiJiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821543; c=relaxed/simple;
	bh=ZzypL1q8lSVXQIXJHhjCOdlbLRfFG0HNAWS3QVyzFGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ygjp+vkFxcm0J/8gU3uHSpTc0xOsX0KmNHhlp7WMwC4S+1z3slfOLqTvkrml7KkpeE8rTjEfUQuiuevJQI9M51q3GfVQZLVdilDCBAMyspL/+usyXz4hWqXvjvpinJlOvFRBxylLwHeavAOtbUtiDBEm0iCk7mns6+RCdxzx4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NPskrpnd; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NPskrpnd"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so9127325ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821538; x=1785426338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nILG2pU5HaalZ15dHHxRx5Zald9lpX5DsCBEt7W2PBE=;
        b=esCJ7mi6czOzA7AZ90O/Z1Ef3HXYSSxFTH7ufMS6Xi6Wo4GgbmdEdin6k9UCafKb4x
         rOvnm7RkQaDw+oVJpn8wsawPW8LfmPId5YHPSkWsCfuzwLR4vOfoJrFodfBuPkDGUaSU
         tc7bGIdTt+bcscI3UnZ56sKCGfzOhlrKdzyWTbZNf3ovnzplRoPJLdhk7F+7bmFM/iZ2
         qrzSBzPl3IG21NSc1x87u1r30B4pA6egP7tt17pnMoBGBSfA3CHJnkMgVDX4fb8z2sj1
         KfPVMPhH84RRchaZ8dVKDQ1WCB4vxNn8NoCI39vgHnnVqe+1WKeRYw5kQvK3ElR9D8j7
         ls0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYJprV+goUeUuiiuiWlHGnQvVNrjvZ5mOObmE4eibDifTu0pOSGKCRcQp3tTxxRmNby8JAqQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD55j9q2IQbzBDknNoinRt42J0gG+mRNO5C+m9eeXZYQov9NOR
	8c6vmqBQL8YDhm2TuKrkH6cmELYXRwgDUBYunqvVwN697IG3EG/iAy06GCVOVPga2Dr8w9VjIkS
	OUlyyTOkIb5oni7bJftm5cVs6ugfeAEnfJhPC75rB2k7IejcwhhmLjf8xB/KkkWlcPCI7SeZOle
	TlNt2F62unywVLYGfTokMsRB+MXPlRuxFHxUI7wGbD8v+M576oLTpcnAxTN9J2paKF1uPsRikcF
	j3ve7D1HQ==
X-Gm-Gg: AR+sD133UmeuwNR2BPvBi9KOeM6Stqyjfsx2ttfFi7JfmQR4t/ycovX9shjZZOsGfNu
	JYtlKr0lg2jVixnf+C4RW+/jRLQgqynmiwb2GXeVJYklSEwcGnTdCo2nNi+ES4lKViNx4qa2/f3
	jjSOCKR6XP/+v3YyYa/9XG3o13Zhr2cnAgt/0ijTOWlwbv5c14PjI7YHF33nN2nPVzTHIdu/aSv
	hebJRs2WzBM0+cHwKxFhEFw1OAoO6DiEeNirAlvYg/XthD7WaBYVRz+YbSfkbL6ljA37oATx8YH
	fFFrPMZ1CJc6ozCnu8aJUVo6i8l5ltf/C2YnfC3YU5+zURC9jqJE3yJjcZ8yw7OV9jfnN6utOFu
	3CPkvyvjXzbEf2lrHU+8Mo9oCFreZOILQWRCrkp51h/OHWn7HH09NzTxhkBRf/HqpDNTKjTHHEx
	vu7tgf6BdyRnQa7It/Wx72NZ8/FSqNmZoMqQ==
X-Received: by 2002:a17:902:d482:b0:2cf:b23d:79c with SMTP id d9443c01a7336-2cfb23d09d5mr19297825ad.43.1784821538244;
        Thu, 23 Jul 2026 08:45:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf8f2b10besm5302765ad.28.2026.07.23.08.45.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2026 08:45:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848d21bbb55so1336149b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784821536; x=1785426336; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nILG2pU5HaalZ15dHHxRx5Zald9lpX5DsCBEt7W2PBE=;
        b=NPskrpndW+w2UsgK/CQ0PODCpFDQUmFoVZ9i2m2sG71R+LQMsFvs6w0njHuRrR8YaQ
         Qrjt/b4POuQChfU25e7LE2Xjd3dXLtzL4qIw2iBWfZfw4zKy+gjkkkbnWxcWLK7K5URj
         48ZzHYOSUjt7e2D3qhiC+6TTztSg+aLtok2p4=
X-Forwarded-Encrypted: i=1; AHgh+RoRcRNMTwR82zdRcwq998qhjASMZNYLZXBUxrNsZvRhNUdIYAtaQEF4R5zuEEtLuA0WTwWXTrE=@vger.kernel.org
X-Received: by 2002:a05:6a00:b42:b0:848:2f84:736 with SMTP id d2e1a72fcca58-84e2c294d71mr4304758b3a.73.1784821536058;
        Thu, 23 Jul 2026 08:45:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:b42:b0:848:2f84:736 with SMTP id
 d2e1a72fcca58-84e2c294d71mr4304724b3a.73.1784821535534; Thu, 23 Jul 2026
 08:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707185937.3177211-1-kiran.kella@broadcom.com> <20260721075252.1d577783@kernel.org>
In-Reply-To: <20260721075252.1d577783@kernel.org>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Thu, 23 Jul 2026 21:14:58 +0530
X-Gm-Features: AUfX_mxpS9Ld_rn7Pxi77_m4iRyK_M36-t6Aqywi6kDobGj--Ydr9x2_GYD7zhQ
Message-ID: <CAPHeo3ffccTg=LajvOxMTuru0f3E64a8TVX+ZDN=6k_i9gWqPA@mail.gmail.com>
Subject: Re: [PATCH net v2] psp: fix NULL genl_sock deref race with concurrent
 netns teardown
To: Jakub Kicinski <kuba@kernel.org>
Cc: daniel.zahka@gmail.com, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	weibunny@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	akhilesh.samineni@broadcom.com, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>, Daniel Zahka <daniel.zahka@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac994a06574925a7"

--000000000000ac994a06574925a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 8:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  7 Jul 2026 11:59:37 -0700 Kiran Kella wrote:
> > The race occurs between network namespace removal and PSP device
> > unregistration.  When a netns is deleted while a PSP device associated
> > with that netns is concurrently being removed, psp_dev_unregister()
> > triggers psp_nl_notify_dev() to send a device change notification.
> > Concurrently, cleanup_net() running in the netns workqueue calls
> > genl_pernet_exit(), which sets net->genl_sock to NULL. If
> > genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns(=
)
> > then dereference the NULL socket and crash:
> >
> > CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > cleanup_net [workqueue]
> >   genl_pernet_exit()         psp_dev_unregister()
> >     net->genl_sock =3D NULL      psp_nl_notify_dev()
> >                                  psp_nl_multicast_per_ns()
> >                                    build_ntf()
> >                                      -> netlink_has_listeners(NULL)
> >                                      /* crash */
> >                                    genlmsg_multicast_netns()
> >                                      -> nlmsg_multicast_filtered(NULL)
> >                                      /* crash */
>
> Can you explain how you hit this, in reality? Seems like an extreme
> corner case to me.

The crash happened when the following commands are given in quick successio=
n:
- The namespace the VF is in, is removed (ip netns del <ns>)
- VFs are removed (echo 0 > /sys/class/net/<dev>/device/sriov_numvfs)
In the context of the psp_dev_unregister as part of VF dev removal ->
psp_nl_notify_dev(PSP_CMD_DEV_DEL_NTF) -> psp_nl_multicast_per_ns(),
saw NULL pointer dereference of net->genl_sock.

>
> > Both the main_net path (derived from psd->main_netdev) and each
> > assoc_net entry in psd->assoc_dev_list are affected.
>
> I don't see how assoc_dev_list is affected. Assoc dev list has
> a notifier which should serialize the netdev unreg on psd->lock.
> And netdev unreg must happen before the netns dismantle.

ACK.
Actually the crash was observed with the main_net only in
psp_nl_multicast_per_ns().
Agree the psp_netdev_event handling already ensures the dev is removed
from the assoc_dev_list before netns teardown.
Will narrow the fix to main_net only in v4.

> > @@ -62,7 +62,10 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigne=
d int group,
> >       struct net *main_net;
> >       struct sk_buff *ntf;
> >
> > -     main_net =3D dev_net(psd->main_netdev);
>
> comment like:
>
>         /* device may be changing netns in parallel */

ACK

>
> > +     main_net =3D maybe_get_net(dev_net(psd->main_netdev));
>
> not sure how the dev_net() is safe here if we're not holding any
> relevant lock. Do we need rcu?

ACK. Needs rcu.

>
> > +     if (!main_net)
> > +             return;
> > +
> >       xa_init(&sent_nets);
> >
> >       list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> > @@ -77,21 +80,23 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsign=
ed int group,
> >               if (ret =3D=3D -EBUSY)
> >                       continue;
> >
> > -             ntf =3D build_ntf(psd, assoc_net, ctx);
> > -             if (!ntf)
> > +             if (!maybe_get_net(assoc_net))
> >                       continue;
>
> AFAICT we clear the psd on netns move for assoc dev so I don't think
> this is needed today.

ACK

>
> > -             genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0=
,
> > -                                     group, GFP_KERNEL);
> > +             ntf =3D build_ntf(psd, assoc_net, ctx);
> > +             if (ntf)
> > +                     genlmsg_multicast_netns(&psp_nl_family, assoc_net=
, ntf,
> > +                                             0, group, GFP_KERNEL);
> > +             put_net(assoc_net);
> >       }
> >       xa_destroy(&sent_nets);
> >
> >       /* Send to main device netns */
> >       ntf =3D build_ntf(psd, main_net, ctx);
> > -     if (!ntf)
> > -             return;
> > -     genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> > -                             GFP_KERNEL);
> > +     if (ntf)
> > +             genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0,=
 group,
> > +                                     GFP_KERNEL);
> > +     put_net(main_net);
> >  }
> >
> >  static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct ne=
t *net,
>

--000000000000ac994a06574925a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ksPFF8lRQaSHMJFFWI2usTUpS9gKxRAuJyHc0xlNKy4vK2ZEic8RWs34T6LcL98JR51RaKtE0Dw9
7F/uUf87z+/74aOyyxrTl58LlkxL/+1yMEHZhyn6z30LHQuA52TSp7uD3au8gu0YN+hKIsPBKVbs
dzf/bW6eDpGSwgwRzqF2BcDBOUA9U2mB2cxinBxOxCVbYRy//Q46OuAx0pXw8trIkPDdp8kHAoWD
7JxJ70nrdMy8VRmC02NQp185/6szeMFYLA0CAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYa2lyYW4ua2VsbGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBS/iTArBeV9hFyyktvkwzGbaKne3zAN
BgkqhkiG9w0BAQsFAAOCAgEAdavxLwcm6Kj3S7/bA/IO6B6MTHIndKyB630T3CTPeOeuHV7ZS4wr
rDZbrSjERD36308lnaXSESlcu8LX2SKJ0KqNM3VQNTawSKS4wMXlyTzOBfaslsjtFiT4jQW9Py6u
6nf1EVoQ6YTCGJ+htyKqFgIljJIdBBOvXY+gECh/DC+VbLUVK9CgZLKkFJ5udhYvw1tOc3zOXGOd
kwaK7AtwRSLgNt5RSAaikL6bvU1kUWgITNKKhBK5F3CNUbR0hD/i7yG6Afdh27V1T7FEdV07fBbu
3+AVnAdbZmHfnB2T8lHTaR9GbgkF6lG/a8I+eUG5NPrDEM+afXT7/+zOTjf799qoyhMdfgp90DEW
9ukfyqfUq37ctBG4TdnDlxtkwy9XYw0Avotf2lrYy+6MYjt3cZFF+AF/F6ANk+Gx9zH5gyeUlruJ
+aqmP1U1lX/n2YEXAfiLJulbb3Jfi8lvyYzHXpHLIFtLfyVOzUXdGdj3dVxxFSPJ4uXmpk2SLExM
W7+cvJ+PxSJyWK723U609whQmqbVRz5B49CjNt/exjWtBGGjCwLPMGNWbHbwtDVWcoZzE0KoL7EK
VPB0t6uom5ElZ+qieZghO80tR/MW2eL8i+EiVMwq5GF1Ni3D6uypwZYqgdicI0YGj7JCgrIzr1kC
xwtQkw5ij2CCUWXxadt/C9gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
AgxbhXTUwXZ3dIWSpigwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILVagmr4fdOe
35PSPDp010gW6rfoRTLhmA0Ywqs9Jx2lMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDcyMzE1NDUzNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEvwsWHidCNQX+ZLRdmW60HrfddoCkiZQszpsEZtkZhFtxsL
tOggWBLtnGCJJu/RKtcYI0ZcYZC5rOXOii2F/PHYe8PYgpCgZmDOFyfg4XTiRlStGRaF9mvRijpE
ZUTCs1mv9clm2parFH/DYdK/rJaqXFF4u2bPh5uB5++MBbnGpUZDezA7jlxB0R4QHbj9C8ZbZ2Cc
49GPOVx6yWQwM4aTZrXdtVbG7i6x7RB9hBXOHJpEjCC6WoRETowV6NWCvRIcSy9LbiB4aMX327vh
92NB92ygsxX3I/1wiOGikSXWzeK5A+p1ys92psNBKggcUpXYitM65w1N6K/qXpoimGI=
--000000000000ac994a06574925a7--
