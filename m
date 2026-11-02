Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793636442;
	b=ba9kwv4SALSOLz2q2yNvdQAU5YB4aAZ5rJkQmFJCGOxzwo8+1QRyP1vRGUcoYA8XNpHe
	 Dl3Ee2nf08Y2RhPnw+dLyYPFV5UPkjblQUhTwQ5MofpI6dI4Meu8sQhBVGnhSmrAuaCGL
	 YvAWRjsz+ggUN97FMPN+XE5VrTLKnfnbdRlsyW120iXQodIeMb1NuuFehYDo8lCXZZ2cs
	 mcrgqaQQt/E8A9Frn28k9VQHrBLSjmI/bFMEKPeavK1WQz/iIFWJQkqKdNyX7Rs+uLFbR
	 I1ZrLC3awl2jNafjHhUivgIj+rNTAkb/H+YcAuUr6Ckkwe7xIyw6ItLWgz9mKLOxIhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C5fLOFbduAbmdBEPQjwACRSj3gb+mlxlDl/Xq3fcc6E=;
	b=Qq/Z9TH8fA/vqn8ArGEI7EaGbrhKhCsuHU7GgACK3Eaxsx+QvT3z+IFjb36QFhEQDwgx
	 drE1zacK686igMbqqouAyIK4ZugyoDKqqO00/t+dHb+zvj6faWoKQw5f+UGKHNxdFnE8L
	 FKM+QRfmbs7PH4GJF4LDX+Rmj0gGFVsfAXyvji6/sGctAC36MGInqihN90cJwoUJHblF2
	 mBCwzaokwQHIb7MrI88XZjlo74E8xcBke2b0CsVpc3nL5gS8p4AWm1Yv2NOAvxaKTY5dK
	 6F/ufCUY2Bh/M0D2U7oZ4+UwzjOhrfNfv0lUbh8l3oAAztk0eLFce2ROp7ltq50ym9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hQKZoxS0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF920606AB9A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF920606AB9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hQKZoxS0
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso2888379f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636440; cv=none;
        d=google.com; s=arc-20260327;
        b=QlHuF7EME3zIJMlXU5xmTfzPzLY6s7P69xkfLbt2AV9Te2xu0Doh+Hrey6ZjveXrNK
         Ep1Dj3ogt8C3RzTUjAhDj8Uo5B3yQgxukgCOV0t08uKvn2GvHasjbuYUHJNeWZr/0dZC
         jCLiWBWeQVzVypQkkoAsv6GsacoNfchSrvrXJP3JvQoBvG/AeSiT1kN60xaSlIN7js0i
         1fAjmStCJxsSEiJyW0BHj4AChDl6LNJMGpnHbQOO43WmHTVXacCD7JyXsuZswbGn0Yrz
         REGXXSFXkCp2rIzK10DP5vSgFX+n+sL23Gj43HP/TI1+EcdIU7qFuTFLKlAy0GZOuEL7
         uZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5fLOFbduAbmdBEPQjwACRSj3gb+mlxlDl/Xq3fcc6E=;
        fh=sgMlnpPIkoatpKB1xJDHQICPZqesERPploa6LoXqXLk=;
        b=R8xsca2rf0MRN3yfpnjR1Vw9HJ+6CeNGUUwl3L7SeznM87P8YmzrI9Q19TsRfyZObb
         InSRcrbhvvkux1tx+NH1Gcqk4zwndf0eI6uOW7YyoNU7YcTUD3FtPxlAm7dRhSATkp5d
         UX8lDe0I57APWJBBlMGZAp6GG9LD0+Mv10DSY3lD7nXwivusSqvzFFg7wQhOem9pNdfl
         ULW/urK4tk0GdMJEne/b6WL1qA6WwnF1AQhQszJjhvjfezCtZKhuiSPaop69wAxSNJOK
         cGrSp3vS11aVcd63LFmSpZbin4dyTBbnh/5mtEMQVyc6M1v+jCrrA13iXBnB2o0cguIu
         BspA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636440; x=1794241240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5fLOFbduAbmdBEPQjwACRSj3gb+mlxlDl/Xq3fcc6E=;
        b=hQKZoxS0RcyLHyFHeIu1oih90A0L2WLvR+NtHO6Gsju1b8dFV4407DcqDtL4gjxdYK
         /Pi1/6Q/RkT7raxiGMHYxpWyYB/QG1mYnLpYSHgtVImE8IgtFI4lTMYMVivOKdSQLTbO
         ovlXae7rKz8/kFmPatE55gOEhtq0YZHhQshu9X2GYuQI79IK+MUzqFpfQYO/McAcgw1f
         buUmfSHQ9v0UH+TUpmpwMFedek5cTomXXmv2Xp/WTz1M142iMorctiJgX2A9X9aYthzW
         r0VxfLy3RH484xSQAfU4KFonqqVGRCYswfgIUB+1PELOsAfklmz26lkYgLqvV4DxNG1k
         bg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636440; x=1794241240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5fLOFbduAbmdBEPQjwACRSj3gb+mlxlDl/Xq3fcc6E=;
        b=gwyoW0/wNLtOLrY7uEXGz/1NOwXrYQ9JcYtfFst7HCxLq8wQIQKJQ9qS8osQBWbXtC
         w6aKDYXoT7IzsxdLEZFWHUBLyuvQeblAeysw+oUCqhUMv37gQLounwyT5ZTZT//m7zis
         6I8sG1RJBFntMUYDvZ5MLYHIDzoHuoIyYs74TmKeClJU+MZEXI0k+PqkF3ifpDMa/mRh
         1TTVPze4iy0S9S9P9F4ZTcKZIL/r3EkNBNY02q04SzEwDB28yQCJZSWoB8WL+Co1rsNT
         FV5DQniIKcqVeSl3CxFoJNi8W8mrIOn+0kpydq6U1wHbwpyPGFGr06uK6Ibptwj04Fe7
         YNog==
X-Gm-Message-State: APuU4Z+Hz3jmsPL4Z6b2oXd9N6XimLob1T6Tb7Quyx2QsDaMEiQDdLQm
	zgxVNgxBP+D11n3Wi/4g71ct2wCTaUQndjDsK+Q2SqXAirNCzYPY+GNJetcJnxK1jlZ0Cn6ogGT
	6Om5JGNTxgvK4X7hIVUkiwDEtAJ2w5Ks=
X-Gm-Gg: AYBFou3JQ/uMKt8luieCQ3HuKGUNFfZ8Xqaljw22LGyUpUnsf0Dgw6TuHYMIaOVVNfa
	sZVEh8MGXZB/53ZjazeObsfxPfcIrVTqXHvFhnvKv0hVhvHW94f+8pbPMNXkkkTHvW4OADApvsA
	+EO0DbdPUTHz7s+dPdoetyOmLfDkRSRKocztjKngkJ9vbKGXff8aFNN/Wfejvn15kRpoqYsSfR5
	3vMgD8hAcsyyvD/wi2V3BtSc3upXL+OqTvEFxTZyG4mCWYi7K+qNIMiBJ3kOZIoF/0yxf0TMCSF
	sTHi+rJT2gZZbDU+ng3CRXDHSuBgHTEeOjefVGeqDfKT8kJVp60VJLnrCT8H0ur7S0PW0J2p+jz
	d8XZZs4jHixnnBI/TSVqQ3EoxO9y3ii8CrlRJ6191HevmbBgOOjelhlkLPzT08H6qQAL7DBkFIM
	9MbGBEzWolz+hDynzh2LKNpe0DOvKXHuiLE6oKoKm5lcEcBGvdqlzZXQ==
X-Received: by 2002:a05:6000:26c5:b0:48b:e50:714e with SMTP id
 ffacd0b85a97d-48e6e50d8a5mr21982003f8f.36.1793636440075; Mon, 02 Nov 2026
 08:20:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179322344904.40667.15350816992837956463.stgit@ahduyck-xeon-server.home.arpa>
 <179357240198.3131.13031185806045724220@kernel.org>
In-Reply-To: <179357240198.3131.13031185806045724220@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 2 Nov 2026 08:20:03 -0800
X-Gm-Features: AclHuK8_bIOYNC0-3X930ZkgACL0Jg6HMfqFEoFwZwmOtPhMaYeKFbYQ1V9oX2U
Message-ID: <CAKgT0Uc-SWCkdmwgKHtdGip+BjNrTzSn-W-_hSyxgBv7BDscDQ@mail.gmail.com>
Subject: Re: [net PATCH 12/13] fbnic: Wait for the outbound flush to complete
 on mailbox teardown
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 2:33=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit makes the new flush-done poll in fbnic_mbx_clean()
>   (drivers/net/ethernet/meta/fbnic/fbnic_fw.c:204-209) wait for the=E2=80=
=A6
> - [Low] The commit message says fbnic_mbx_reset_desc_ring 'drops bus
>   mastering and arms the outbound read and write flush in a single=E2=80=
=A6
>
> --
>
> fbnic: Wait for the outbound flush to complete on mailbox teardown
>
> This patch adds a poll on the PUL link reset status register at the end
> of fbnic_mbx_clean(). The poll waits for the outbound read and write
> flushes armed during mailbox teardown to report done before returning.
> It has a 1ms timeout and logs a warning if the flush does not complete.
>
> > The fbnic_mbx_reset_desc_ring function drops bus mastering and arms the
> > outbound read and write flush in a single register write, but nothing
> > waits for that flush to finish.
>
> [Severity: Low]
> Is this description accurate? In fbnic_mbx_reset_desc_ring(), two
> separate writes to two different registers arm the write flush and the
> read flush. mbx_idx selects which one runs:
>
>     case FBNIC_IPC_MBX_RX_IDX:
>         wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
>              FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH |
>              FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE);
>         break;
>     case FBNIC_IPC_MBX_TX_IDX:
>         wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
>              FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH);
>         break;
>
> fbnic_mbx_clean() calls it once per ring, and the RX buffers are freed
> in between. So the AW flush is armed before the AR flush, and no single
> write arms both directions.

I wasn't referring to both directions. The read is disabled in a
single write, and the write is disabled in the single write along with
the master bit.

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_fw.c
> > index 09d03274be08c..32a18cb8990cb 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
>
> [ ... ]
>
> > @@ -187,10 +188,25 @@ static void fbnic_mbx_clean_desc_ring(struct fbni=
c_dev *fbd, int mbx_idx)
> >
> >  void fbnic_mbx_clean(struct fbnic_dev *fbd)
> >  {
> > +     u32 flush_done =3D FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DON=
E |
> > +                      FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE;
> > +     u32 val;
> >       int i;
> >
> >       for (i =3D 0; i < FBNIC_IPC_MBX_INDICES; i++)
> >               fbnic_mbx_clean_desc_ring(fbd, i);
> > +
> > +     /* Arming the flush above only starts it. Wait for the outbound p=
ath
> > +      * to retire the requests it still owns so none of them can compl=
ete
> > +      * after the reset that follows. A lost link reads back as all on=
es,
> > +      * which ends the poll on the first pass.
> > +      */
> > +     if (read_poll_timeout_atomic(fbnic_rd32, val,
> > +                                  (val & flush_done) =3D=3D flush_done=
, 2, 1000,
> > +                                  false, fbd,
> > +                                  FBNIC_PUL_USER_IP_LINK_RST_STATUS))
> > +             dev_warn(fbd->dev, "Outbound flush did not complete: %08x=
\n",
> > +                      val);
> >  }
>
> [Severity: Medium]
> Does this wait come too late to protect the TX mailbox pages?
>
> By the time the poll runs, fbnic_mbx_clean_desc_ring() has already
> unmapped and freed every buffer on both rings:
>
> fbnic_mbx_clean()
>   fbnic_mbx_clean_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX)
>     fbnic_mbx_reset_desc_ring()
>       wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG, ..._AR_CFG_FLUSH);
>     fbnic_mbx_unmap_and_free_msg()
>       dma_unmap_single(...);
>       free_page(...);
>   read_poll_timeout_atomic(...)
>
> The new comment says arming the flush "only starts it" and that the
> outbound path still owns requests at that point. If so, could a device
> read of a TX page still be outstanding after dma_unmap_single() and
> free_page() have run? With an IOMMU, it could also target an IOVA that
> has already been unmapped or reused.
>
> TX pages can still be on the ring at clean time if firmware has not set
> FW_CMPL. One case is fbnic_mbx_flush_tx() timing out in
> fbnic_fw_disable_mbx(). Another is the clean_mbx error path in
> fbnic_mbx_poll_tx_ready() after the cap request has been posted.
>
> The RX side sets FLUSH_MODE so parked writes do not land on the host.
> The AR side has no equivalent before the pages are freed.
>
> Would it be better to poll for the flush to complete in
> fbnic_mbx_clean_desc_ring(), between fbnic_mbx_reset_desc_ring() and
> the unmap/free loop?

We have already polled for the writes to complete by the time we are
calling clean_desc_ring. With the BME cleared and the flush bits set
the writes will be terminated without completing. So there is no need
to worry about a DMA coming through that hasn't already been completed
as they are terminated at the fbnic.
