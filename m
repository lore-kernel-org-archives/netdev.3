Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794451098;
	b=y4T6oYkGaaTRwPsCez7zvw6EoIxLFKrWScyODlzSnBYwFf2m4dmmchBUjNnjL1MgEH5o
	 ZRiDsc5e2ppZO810ITXIVOnX4lHtDq31QqJ6ZCDMKV5G1behbjhSnQwZ1PCwEVsr3T3MC
	 M0F+cT0jNr6ZR+WLdA1hSmo0xN8I0PbD2HhJ89FU/nOwoCXhLqidxNhaqTm3xxB76c0KB
	 GHoefNTA5AUPGrxraUDiSWiIaEilxQ5IDiVeyBepeos9dCJne4jU98xcin5kqq2Os620X
	 vOd+COA3YTlhhkJ6IDleyD6Y5sNPqRagGPW90hpMvCMtQS3Rzyt1UoFzsnDPXeIcFbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pqLudJhoiPVgD2EoEahVlHAVCEoKHq8SKN8B7L0dVhY=;
	b=Gy1MpsJy264suqXDHndNdcM8+qgwgcdNgKte2InbxnEiM3CB45CXE52E+G/j4q2pU6pG
	 2DNXhZ9vYTtmRz11YpgqQbBsUI1JazT310ZoZa/slBH8FBv6qFz4qXStco4wsfssQ6jGr
	 dvj54LUclQWcnA0QPXgthpsHzH1pp/ylHWgJxPECIu28QeASMCZJcxn3SLcQT9L15uBN7
	 s8WiFwdzB2fthFGEDNayAESL6WRovXcmkRKVc3IbRuTp659L0rwVwDRu1rBE1z4ocA+qD
	 Cv2+xxlSc+VahbhtfDJAAcbrZI43L9xnyuc/LyHhiXWhgZ43AArPN1VpFS00cIYJW7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rto3X2gT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F46606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F46606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rto3X2gT
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ebf4cd218so34240236d6.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:38:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794451097; cv=none;
        d=google.com; s=arc-20260327;
        b=MutE2zUwpd6A/HjLWwcOEhu95H5zQhqjmQtVBv405munjqkpbk2D9HZJmSpyfN/oN7
         NyGnv4p83Z+71rxh2CXYPlPLLemP6qTXlYJCns34EktPegl5fCm+x0MCGUchJxZ2VUqZ
         1yZKpZxrX6FYLZP1E8kxfRByjgLCdNY/U+uKs/P6AzOKuHHlEG+4+vXWLYPtt8+uoi7b
         ZTrhK4ncdwwNvP7RKxGa8K8oxIxOU5zrXLTiFf6zCTpCFFpiIdRRzNuGFOHgWEUfTMHv
         Wl6FbbZnw90IQDlDb3SHDi3D6v1bIo5P9wmSIK+6RdK6hae0bn2c73XOs1j5+t5W1dW9
         mZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pqLudJhoiPVgD2EoEahVlHAVCEoKHq8SKN8B7L0dVhY=;
        fh=wxIP4BEgsqajkwRGgLkPNY5mwRypdc2isUaPo+Og67w=;
        b=KBOF7h69SwFGTrVF/5J0bGR7Hw6x8ge9hitiM8nO3iJyovRCu7Bd2qS8EGScILlb9U
         sPiWlryd6gbZoIJDLN04vDPKJr4yMDDDIhhaUBexpSWutPFinhj93yZbLX6xl3AsU79C
         xwfD7vEv0o8NTkeI0AhR/cK3eOJHVG5GClP31LfEsSpqYygrws8gTGgpqjIXdquSK8Ao
         sykT1FckAU8J8GaEW1sd7DRu2GQaQ/SMZPrESmlc+AlRALVSHYZFoFSFg8QSJUUufTQk
         s06YeCOGVDHVytZHZinpVuCXn0u22NKyd9SMUerCfdBBkRRJv64zKgcDbibkZig49WH5
         jlnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451097; x=1795055897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pqLudJhoiPVgD2EoEahVlHAVCEoKHq8SKN8B7L0dVhY=;
        b=rto3X2gTCkafPRmA8ayjxjWvp5+G9QHC6JN0pCIQ6BNz+03sEbRXUWEjuBxLxOfEML
         QuqoMtj06TE3JJhsHqEmGYhxpno8/0dBZn+sw5YaIttt2z0j7zAfBHLZU58SGI+noElv
         CM2NRM7NPgXKX1yrrJkljUnJ0deKjxah8snqq3yFvi+859V6ctsMZXsUYfAP3ndYNDsy
         O7o+4h0fQ5Ftyik2omW02NagBgZyI0CI7dkNqQdKErcNCDKWlZB0Pu2YjM8mvjIEVq+/
         aDW9dD/PHad3wMoObZCRJTEL48EF+ydmDii5wLF32kqfJQEjqTveApaJFZGVN/UpK17Q
         I5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451097; x=1795055897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pqLudJhoiPVgD2EoEahVlHAVCEoKHq8SKN8B7L0dVhY=;
        b=Khn8RlpeVOwwLFE9C2NtuoLTqT8spYheziDzp4WqMTUNu/UzAZr7iQMt/V11SZ2RPZ
         ZMqjAdrsF9imsjuxqjVofRs0MDTsJxrjQyQDHkiiUzfNTXmHpAe98ib1/lmY7I2J+XI2
         v+EpADoVb792KbDYRBsLyifawgWMQx8E/NyBVSG7E8tkVtPIbRUpA5N62pX7brYmV+PK
         5PNG6iaUkLtzs8j7sd3lEiJHtOMR+Rf6DyoJdPJn3l8peuKhU2yYiEeiaqx/8CbBdRDx
         2Vh1Z1FZGkUkfpY/yPzwx4qejDEoZBEp7Rz6wiDkrGNsPgI5QDi2QA+3HWce1U69PbrU
         BxUA==
X-Forwarded-Encrypted: i=1; AL+hErFc4ZShRPqxE3ePZUjfsL4aMDNttG2wwYeGLF1td+qyxF489QxlIGV1incgzI/CPvUgyW6ofzI=@vger.kernel.org
X-Gm-Message-State: APuU4Z82Gx0L0+BuvVw88m93xMqLlxuOLJKt9rhHgFHK5nmm1EJcKOVz
	91i8c3UZYcehj7P4zfgParTs8VRLmr5WxD7fO2OkJFqHgp9DUHCUG8RY6jzHB7mZ+wnkG82EBNJ
	YjoAa5UbU11iAqXGWICVoaIus7xJKtMo=
X-Gm-Gg: AYBFou2eK9zNz3agCZ4qYNuNurNNGdgJpJdS4fHTvPh+MMvyOZ1GI0QdBqqFt222vLz
	pqrlRSLUxhYJpAkOv4CNtz6K2yBeoL0hb7rjuWqdVUloPTUybGV5O2x6oFcub9JW9TgO04HyLJ5
	onQzkyhlBqxoe4WPFjMAc2mzJhUpVDJOHqooUZX2sCDiYqLlkt/OsCxNhteHzbe3qxup1Hw6UxA
	zqlhkeE4sxGWT/dcmSsqN92F0hzLiGFBgDkOHXLRASbILqbgwuyudLOJkqDb9czr7QC0hHtQR0I
	t4yiaGlzR6H3Ll4/DBLsm8G42MfOBdrt4k5nUOtgGM70tcaiuckIjEm+pbQ6kiRMM2WejhSPb/e
	Ys6VLkGk31/RWZoz21MdXGnGNWsaFDDK/zOjY
X-Received: by 2002:a05:6214:62f:b0:91f:1383:1bea with SMTP id
 6a1803df08f44-91f13832415mr25376006d6.2.1794451097094; Wed, 11 Nov 2026
 18:38:17 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109134506.2794160-1-zxyan0222@gmail.com> <179423231463.488859.16977464890948797360@kernel.org>
 <20261111152012.3506cf35@kernel.org> <CAP7veT+buHRMu6f3o5RaKFdv3fABkWKgkO6KFn5js4PEeB8b0w@mail.gmail.com>
 <20261111182822.580e871b@kernel.org>
In-Reply-To: <20261111182822.580e871b@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Thu, 12 Nov 2026 10:38:04 +0800
X-Gm-Features: AclHuK9rCxYPptofSIgt7EF7v4G1h1kXDVVe9np1u7jTLTpnwVCKysG5CejzHGI
Message-ID: <CAP7veTJpAMfEWQ7=Bm3iEiFC5L+WBj9PEnPQCEua6goKEP4VHA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com, 
	rohan.g.thomas@altera.com, rmk+kernel@armlinux.org.uk, 
	o.rempel@pengutronix.de, wojciech.drewek@intel.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 12 Nov 2026 10:18:41 +0800 zhu xin wrote:
> > On Thu, Nov 12, 2026 at 7:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 09 Nov 2026 13:51:54 +0000 netdev-bot+sinfo@kernel.org wrote:
> > > >  - What hardware the change was tested on. For driver fixes please
> > > >    mention the device (and if relevant firmware version) used for
> > > >    testing, or say that the change was not tested on real hardware.
> > > >
> > > > Please do not repost the series just to address the above. Instead,
> > > > reply to this email with the missing information, so that reviewers
> > > > can take it into account. If the series needs another revision for
> > > > other reasons, please include the information in the commit message=
s
> > > > then.
> > >
> > > You are at v10 and still getting these automated emails.
> > > What's going on?
> >
> > As for what is going on: I answered the bot's full questionnaire once,
> > in a direct reply at v7 [1], and since v10 the same facts are
> > described in the cover letter.  The bot, maybe, evaluates the
> > individual commit messages, where I never put the information,
> > assuming the reply and the cover letter would count.  They do not,
> > so the emails kept coming.  I will fold the tested-on and
> > found-by-inspection statements into the commit messages with the
> > next revision, which should settle it.
>
> Read what I quoted. It literally tells you to put it in the commit
> message on revision. How many times do you have to receive this?
> Please either pay attention or stop sending patches.

Understood, I misinterpreted the rule. I will put it in v11.
Sorry for the repeated noise.
