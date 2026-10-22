Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792637632;
	b=h10YT4u8MXfLQt7A1WVyGmoXXTGqJfiux13ybOuGGZs1jBazd2sc/kbFhxhcGU/03mVC
	 znn9nBeyVFd2wzIsCFW9bL2nBAfF6SaN3Tfo+kuAy+442UPeo5WXYDg64GQUoPWvX1hSc
	 oTTJMSX5Kn+2PiLcxAUIvXJ0Ex1OF07LuCfoJFT6CuxaKvtSNDEQRIZcJ/YZg1Mjv0vgQ
	 6SGudGnjjCTJL4//fhmyD7+OWS9uOMnEie305FhVpZKLgVPF0mAyPo/bI/+qsqmjJvP9R
	 SezVS5qhVsjz12DtfuWm97UMXSUPsik1IWOy6cXSiEJOfjXTawIsgyn+fODOUldNaPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
	b=OOW87EXuiLDVQSrBnXHs16P/dvbsytZJfbxagiLf4rrwMbcZW6AvLyfbaiflcIs9scU8
	 jLtVuhjuoGlsud2Zj4y4kWB0ynjlRIjGVQaxq/dDDgvIMAA/z0yZasLfSjPw9n9QEpuAQ
	 5E8b5/K906WK8IIrcp+YzXEoBn2LCOG8p/8R373rvC+wP4RH/I1fxJLxEGuVVFhBtM9Sw
	 uXwlWBG6dYwU1qoqm5Ng5tbuLa2/ivwm/dHf1I1rDY8SqfVn128jQ0D0ifI3mIeMOw3Fn
	 lQND9lDie+7GemmN8mG9gFOOxtsywExzdvptbWmJ+n+7ntQ0Nes8OLP2GRcM6bxq3pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DTOI/Pek";
	arc=fail smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8C606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B8C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTOI/Pek
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso178646866b.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792637631; cv=none;
        d=google.com; s=arc-20260327;
        b=Xpa6IfO/T5sr04kRN3zA5Ny0L9zCq/bWTz2kHS0/lqwnvnTeSbzA47vgh2GohpYi/e
         JWNi+O1V/YxfR8fk0R4fFcX3IrYRyrTIJ7VtVeMIIasuUGzabwmnoAHTpL26UcJjMvBu
         hpjDWBOmw2+jyD2m5yx+Qmoh3TGfWSqnDfmsbMxZELXfVgA5AEGaaDeWMahudywe/UTl
         NnJSoTQZz86CpHRvMH5a0eOJJx69yfUxxhlPmqvFJajpZfemRHGr1uYHtZozXPB/2cg9
         yl5kHcaIWm2Wb4RwUMA+JO5MiOrIH9E4jE9l5hvG2Qm+Y1jltrSpyLwPSGa2oRG3Ysna
         EZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        fh=mqaWikxOzz/NiKt4svzlfNDf7kL1yKtQ0coE3whyTpE=;
        b=CQbjJZiOPeZri97tbRHP6ZEK3HcV+kkUnJIzCb9QdKoVSlC9hkkseyOmQsCzEKVhC/
         AOmeuAAM5zEVHboAyTmjM6pApje5jL8UQ7iKM7pxj0qoUQH1G36kCNNFSkXu38qBpNXZ
         yeJpHm2KrVoc0yUhvH3ClrUnbZP8MQOGwabA+711Dw+r0A1+CY+veXYzM+qEfUYOlMc3
         kIboI1yGm0jbrkprILCdUTaqekAXkHKUBgt5g6JT7oPsOBFhAnApoXbvynb/huLDRIN2
         Ro0hv/rYp4ONtsftF5+Q4Ij1Sss7OWBMkgrABPD3xgfq3dZpA5lsjX4FVzba1g61udL1
         Va/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637631; x=1793242431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=DTOI/PekpHCFwbCxS6btLnjWQNCiYVc9jJXCEYwAmPekEK8t/PxBNEKZNgCm5yMo5O
         ZHRqWqq6Sa4prnp5961iu97eKvO2fCe1P/oDhQUuXQyhe3en4gFePLH+ndAycKrOkdLY
         ZBtVPzCtW837QZIUsvIlXqXaajHAOKuqlnaym36x90uyaZGBsQGk0lDoH47TKDdTDSv/
         +bNghojo2jLNQuKI4CGPrg7pLnnWdQfj43K8C91aQyr5qb1zEo8L/J/KSRypGRSRs42E
         gu3hUif099K3NIyvd05k0+GuTWcbFOAPWaSRNh9N1gfC8G9MuampVJBqQHApn7d+PZp0
         CiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637631; x=1793242431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=mhIBAwGGI7ZKd4s15RBXIUznd4Imu8C7SAOdMuY38UgJJUUct/Iqjmo50MYjSes8UW
         Z8uGvwZnp/ox2I3XTgtMQoUGDftCcQPyHtd98rO/IFYcJ9uY5pl447F5sZZfvaFGs/Rz
         tBsbsimuJB/mcIOehrBZC7zVqutJo/px8a/cOQ+zybLwD2LcQhEi/jsjESktxC707fZ1
         QR4lXUIO7Hh+tEuVX3UnTGAnVatHb1iOsNIPntc/D6rSmakHPgGdNuKHohe1/3Bs8HBw
         lfmgIfh0t7WOVGnzGKdo4ytCkjHSf2MwrdsuhRoA217e2CsET7OWrb45seLwILyNAFRc
         zUTQ==
X-Forwarded-Encrypted: i=1; AKwUvByQ16+wrMu8vIuB7Qb07n18LVw0QCcwr7ddfFX4YE0just+3nu1Qh64Ss1I5TF3Xw+fORsIBuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSmKLOc7ZTzRQp+bBcBDe+i2cIfSIQT2c0j+lZ4cQPZ1O6+Hl5
	byRnvjTSY8DB+VxCKPmfYOmdQtyND/xfSPxgOUlWC8H48d5fImLbMvPhSeyHJYGr0lgAEXUNovn
	n8ignqnm41qmX2BEtF2gKluj5JOe8gvA=
X-Gm-Gg: AYBFou0U8rg6k6CLUJQiNdTejMv6wCTLSfVx7USEhAE2R5jK6C2DcE9JUCKp1MFVSac
	q01mUFgFBS409jXoSWSqZTPPrHfq0wCIwUgw3ICvK1XUjgSyQNuvMesQTD/e16Wv4Jr8Q8OtrRS
	0WaFWkFci+gd3P6UcLFuJUEMyWkFj1bnAPCPnc1dS4YrPx4njiw5naSw6cvFhlcj1BrMEbKzoth
	PRT1iGe9e9ML5Gqvo53yaZPfgKTWjYPCtOZL71Auk93Ok6jd8m0oMI/quD1OWXvamizlKPxNA+X
	ppvVgKtl85bp4SNawV2i5wyIcxv2ZAgX3M7uiBcIs7AKZcYQGkraM8wn0WLgF8aiR+QlSTqwyCn
	EaI1jfShoAbYOxb3gM2L7CuHcWROJbDdyEiX+utFtoEHUN7buHbXlQtvVIA==
X-Received: by 2002:a17:906:ba84:b0:c41:8e21:4d60 with SMTP id
 a640c23a62f3a-c46791326c1mr341731966b.1.1792637630664; Wed, 21 Oct 2026
 19:53:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de> <f444dffc8e6bf98bf44c02456adc2de40e4ecd95.1792552161.git.jan.koester@tuxist.de>
 <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
In-Reply-To: <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 22 Oct 2026 04:52:00 +0200
X-Gm-Features: AclHuK8zMCY_XzKvgZWVeEW29rK2WIKSmZA1a7YbTdfyZ3EtSnPZJ1CNUxd7pQ8
Message-ID: <CALWcw=FYKcDNXeArpsabHiQOAL+cWkF=L3stL6MB0OvVaHei1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 40/41] nfsd, nfs: carry UUID and GUID owners as
 their text form
To: Chuck Lever <cel@kernel.org>
Cc: Jan Koester <jan.koester@tuxist.de>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 10/20/26 11:16 PM, Jan Koester wrote:
> > Encode such an id as its text form -- "xxxxxxxx-xxxx-xxxx-xxxx-
> > xxxxxxxxxxxx" for a UUID, the same in braces for a GUID -- in both
> > directions on the server and the client, and take such a string (it
> > has no '@', so it can't be a user@domain name) as that id again.
>
> A bare UUID in an owner, owner_group, or ACE 'who' string is a new
> owner-string syntax for NFSv4, one that only Linux would recognize.
> Thus it isn't interoperable with other NFSv4 stacks as proposed
> here.
>
> RFC 8881 Section 5.9 says a string without an '@' that is not a
> decimal number means no translation was available and the receiver
> "should not use that string as a basis for translation into its
> own internal format." RFC 8000 Section 6.1 forbids bare numeric
> ids in multi-domain deployments because they collide; the same
> applies to bare UUIDs, and more so to GUIDs.
>
> If you are serious about pursuing this, you'll have to start by
> raising the proposed wire format on nfsv4@ietf.org before the
> Linux kernel's NFS stack commits to it.

I recall rumors of MS wanting to stick Windows SID in text form into
the NFSv4 protocol.

THIS proposal is even worse, in every imaginable way:
Stuff an unreadable 128bit blob everywhere. I am sure people having to
debug that in the kernel will LOVE the idea (compare blob a with blob
b as human,YAY!), and admins facing the 128bit hexdump will send
marriage proposals to the author, for making their lives even more
heartless and miserable.

NAK, -1, for the whole patch series.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
