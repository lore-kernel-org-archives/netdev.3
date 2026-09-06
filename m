Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1663C109E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667886; cv=pass; b=dTXPgCeNfHZqTg/8oVtbMfKBayP3NfmzJ68SpGh9xOwHjKQqHpUkFdFYnkCyVxtE4enlV7zzMBpWhD33sMyNCt+XNaRoDVRe2JOyl5bIEdw/OxvMXcuHd9x2SuFxqcCLiiAnK3F4nNw8o2Hb0y/vJ9PfGKz/vDpUESqdva+5PiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667886; c=relaxed/simple;
	bh=o8RRhMmOJZ4Q8Ws8xLNr8N1jORKBteyJlETpeYJ1kRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+DMiMD5jbT5KfEBFhEMOc6iJdgoS0K/v1R8Dnsk3JQl7Koo9bDOq0i/Ys0WCfAsYuraCLe5SwUV5EgWzXj+QSPSwghnQEbMBCe9W/Wyh3byNl22L2AqzKdVgF4EpYkDCYbEKX/sfd0GO8YD8HuGCmIAZrGOpFLwPkv13ZCaCRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=gsWl0xQl; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="gsWl0xQl"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a1eb6fa0f4so22730761fa.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 21:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788667882; cv=none;
        d=google.com; s=arc-20260327;
        b=syVjQRKDTZVTH78U2F0RbwWgWPrpW4x7QU5XncfJhPlVWCrtPHBInh5aHGOeAtV8lj
         q36UqihLF3xw+/h6eQzUmqdMwTBHtnnetuDx3+XV9tKwjT/+JPIh6VjYk8eMZ8rrYgtG
         JjKm3ZUAaqeF37SztqVhrNQkhsHCvuIaVOG7TXBQniHQdogNImo0MiYdf0QNegbbSdPC
         fcJq6e9ry9/pM8rN3gm4odVroLHU/ZX/S/XJ0eKoF52UeRpFUfHd7L31F1p1kPbhDhdN
         AQCWOFCfBicvPr20r4b9fss8hJ7ud264iGsZUvfo76H5nZ8MN1GsTPiaAI7onpiiQ3IT
         +CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8ob/HIduIdO4mxeAjoBbDAMkNrzJkir8KFEywokfoU=;
        fh=0Ts8pT01yAOz0Ss45W1mmIl+/zCG/3zE6RcLbi34w7E=;
        b=hky8fGWYsBJmVKej0Qg5gmu8pM4uNuT1L6k4VNyGMmv6CIWpBQE/+sSgSlLGKL+VIF
         Gu4H9NtqPSRquovoYXyHktcRrUbzh032ejYTGpCO6rK/tGnzLywV1eo+65E22UXPTVp/
         Sr4u3wehTjd8FHd5pQx/n3ZYS8mjoAJe1somBWJ7iCkXiJqUFgguBiZyNOnf81HWQu+h
         yc4bz7I8uoqkGT6WlVOe1eBO2D8jMCcODZ4O9dxE3bCitNP3rUEtBN/oULwxI6GszERn
         0k36uWAO6h93Q0Uibmxm2D5hM7WX2grKIBNiTZFwWm55Dm2PqD9A7O2kqSs+wFg+cqds
         ilNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788667882; x=1789272682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A8ob/HIduIdO4mxeAjoBbDAMkNrzJkir8KFEywokfoU=;
        b=gsWl0xQlYcx8XUNBl1rvfDlda8jv6dU2v/34V0RWMl0w8WWAUN99iynCISfQA1Wpa6
         eXuyk38fDHSd424wVQK1Ak4PlfEdkwmD5mCfD/B7Jbfbbs5RZG0DqCG5nmRR9+anc+wr
         C8e8+l1rf7mW4LAAI0rI/0oskDPGpZC0wjEBctRuich12FzON7mxCHVSEVPV4o26IrdC
         KEBCnB7CS3pPPmZudziSGxh9CUrXOHWHp5Pe+SqV4mrgmMm5//cmK8pyP6PMWPBb52eO
         SIr8vS0KTGh8rWiKzpumBYDXKC1ABbs2oKDXTAeO4pZfQqgz9BeTPDK0d5GBaggfpzUA
         iOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788667882; x=1789272682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8ob/HIduIdO4mxeAjoBbDAMkNrzJkir8KFEywokfoU=;
        b=fZTG8gJtf6T0ARwiPDKIarqwD6Ms9imwVCNe+MYmrtlpQJB1Yn8uOLuWOtYjxhxtNb
         0JxnZTDE/5HLh/B41aDqjKk195w4gyc64EMiUggqkCrO9eXlQZxsGpsaDNMOZiPpQ376
         Iln35q49Stk9S9XO0YECMXWHlsNkSTr7PBXLrq3AVOua5s4a+v1w2ri0PLX3XdMt6Hud
         exIxV250X8qe5Gq5+jjs06dfQaOCQD3lSO6WNRcFav8QysJvS+I14YyE5lYAsnK8Vt8j
         54UQYRVr1y8s1Vp9scHHvoWC7YzDMfhNxivxOVj4dlHnHTuE7/5hVJq7zCgSkplCJcRd
         VFlg==
X-Forwarded-Encrypted: i=1; AKwUvBw7Ns5mUsc17vMk367cZc8RTme2PqPoey7z/l31nb+YeHYw38W6KkYyNNOlNtpovime8ohZwl8=@vger.kernel.org
X-Gm-Message-State: AFuF++mi8Tg5DZ17SFulEoKkXrIvbLk3gRgnQGuseR9RF+mmoELy+19Y
	C3yi584dN8nGRGlXNvpBQFcY2VsG72+5+dYYyBnbKhuylOl/U8DXQSxIGPdTU/grCQ5CMickcyT
	Q21n+AOU1Mbg73dctwqCzgE6s3YaMVNfK2m2ighF1aIA=
X-Gm-Gg: AYBFou2tlB9DTkSVwW9OmF7wDzL9nnWONihcvcwG92aXldiD1kZngZlqarpmqp2GElv
	FooBJ2tR5AV+YA0A5NvFgNaAlq7CTqLo9ucibGZamGU+HiPIfA/31bVPTvchQJomipy56J+Cc3Z
	AfngvIFQSWgivEnLjCDzvk/2xz7O/ZPBwnDXYDee3pxhBMdqgbbH3D9+GXvfm5wpPb3LkcEnwAU
	CWG4/CYdja20UN9q+VcEzn+l/sy4XuEmBnu7SgbhdABVt/35KNrqjTjFJDzPqOxzz44RZiwCLi1
	zhXY5GNSiaplgUbCnBLK7W2k5NFdLRM0+wVGspSCl08IgYfMAfbKfdDeq9Zg11iVfryxhUI4Hyc
	=
X-Received: by 2002:a2e:ae18:0:20b0:3a1:8510:cbab with SMTP id
 38308e7fff4ca-3a371f4a7e8mr21960751fa.12.1788667882373; Sat, 05 Sep 2026
 21:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org> <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
 <20260905122929.5bd1bd45@kernel.org>
In-Reply-To: <20260905122929.5bd1bd45@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 6 Sep 2026 12:11:09 +0800
X-Gm-Features: AcwNN1X4pr4fNZzhfVF2lKYxFSJa-AapKUR7vl8QhdvgCFTfBdfx9ZvtSLVLJBo
Message-ID: <CAANe3eRLauCoiYjxBWGqF0Wz7FxMkNxJcTUaqiD6ZygxcUfUcA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, xemul@parallels.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 5 Sep 2026 23:49:05 +0800 zihan xi wrote:
> > > When an active netlink dump for UDP sockets finishes, inet_diag_dump_=
done()
> > > invokes udp_diag_dump_done(). This function drops its module referenc=
e using
> > > module_put(THIS_MODULE) as its final step.
> > >
> > > If this was the last reference, a concurrent rmmod udp_diag operation=
 can
> > > proceed and unmap the module's text segment before the thread executi=
ng
> > > udp_diag_dump_done() executes its return instruction to return to ine=
t_diag.
> > >
> > > Could this result in a kernel panic due to the CPU attempting to exec=
ute
> > > unmapped memory?
> >
> > Yes.  If that module_put() drops the last reference, rmmod can unmap
> > udp_diag while dump_done() is still returning to inet_diag.
> >
> > I will keep the extra module_get() in udp_diag_dump(), and move the
> > matching module_put() into inet_diag_dump_done() so it runs after the
> > callback has returned.
> >
> > v2 incoming.
>
> FTR your patch also looks atrociously ugly.
> If you send v2 please make it better.

I'll rework it.  v2 will follow tcp_diag's batching and drop the
socket cursor, dump_done callback, and extra module reference.

Thanks,
Zihan
