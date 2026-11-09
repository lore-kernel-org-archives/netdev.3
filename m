Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794242598;
	b=r9rtJYm+B/tacwuB13Yi1/PRU13bKHB0c5Q+sLWkYnheXTkxP/GZPOA97oFQe6s++XjL
	 /0y7TQmuVF0wqO3sVI1lLH/L7wVUkMxbe38iKL+Iw5zRb+8kGI6ZzH6No/TFlyF+/K5nE
	 EqEFXdLYuVPAvaU/VmaeXG2g4+lwU4OQnJ4Sfw+rGiDgEZDmt6ULv/NllSYtNp7o0VIrC
	 7ryGB2bLVOVjJUVSfPoOLMjuXPjAbGK0GpmtGGsfE9nZJTraEX2BAnQG3ymmiGzuJFuUn
	 BbfTvUonCtaYDNWtM13qAeanBJdhZxc8KV3KeVBNT6s+1yq6G6x1rCRSteSjogIUubA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=W7nDPEMSIA3pdPYzsqIj+oxUyRpuyBiq8RDt38T0UiA=;
	b=Q28AesOuK9VOzuSYjKsEgcCFMRm4KUhRog9jHD4ksuFFkQkg3Aqf3a9xOblkRv4QQhwi
	 XGqzjIADEr5gZtUcl7MhPBN3S+GwutfsqHZlz/2bitIZJw5597/2jELyp63SAFqPTwZkb
	 PGrkreuQ0608oWUhD1x9VP2h2mlWjIwDksyBujO36tquTxEM7MSB5xlDYujtNMZipuBNx
	 trK+w4q6phXLQqquef/6rwvh0ISa6uKjCrG8UQGnnRpcOT5m35ZEHG01hhLWwIiPGp34N
	 M9eFLEirsd1K4q++LqWkrGK/qzxB/NjT52Z3F2O43T6efZmu3uOHP2uScTXwy+u+4iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8Re0Fxu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97E606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE97E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8Re0Fxu
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so940415e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794242596; cv=none;
        d=google.com; s=arc-20260327;
        b=PwQfAYkTp2P+XiS8kzqaGfycM0gIwKrpq1GfVKCFfC+3LWIPIITUdf4bPK6+YNKMCV
         0ZYNS39Pc8q40DLLFE+aa+oZXp09MPHXmKG0AQWWOY4wC7nDCdnIvAV3MApzSr5QUvRH
         +/muKf5Rlp7ooQLS2fLTF5lIcL27Dw9Z63x7TOcvMez/JIDXu75/uYkVbnuSlnddw6sm
         5PnHU9Ee0D95fjlKFTCBqGt8Wb88VaT8hVHbkBqgXoGWciNisGFQo7/CxnJ9ZlJB9JY7
         uYe+VdnVhymzd+T16aQhJ0JJ5jd1IQTejtU/q3y6e96pnpoLMs02chxawgL97q+6jnzQ
         2eQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W7nDPEMSIA3pdPYzsqIj+oxUyRpuyBiq8RDt38T0UiA=;
        fh=sgMlnpPIkoatpKB1xJDHQICPZqesERPploa6LoXqXLk=;
        b=CRVVp6+pH1XBocUGBG/EuipA7G6CqnG9Sdws5K/2yeGXSTCYwO1CUP7MDA5mIkADXl
         Cv5ACfxGC7HYDSk2Ym003ljnFG7j6sMRW0X/OHE8+8XDlpjANnr4/Q/0cCet6PGa6hcs
         KBijfOQic2SDmtrDKucngupX1DsgVE9FzDqLUYXEAOtwnWyMyX1ASXRS4R90U/iBR8pj
         mKUYivCXvsSasdQYwPnRkQPUsDA5k2xY4UU7jDbKmSTGcgdK5anwIiDqbhtLoqIdSYYn
         936VwQyV/t+wa+KQy6mZhdFrL01YNugbw7e+J8RQXfcl2VKsbBiMSJ8rD3nd243VVDff
         Pv9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242596; x=1794847396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7nDPEMSIA3pdPYzsqIj+oxUyRpuyBiq8RDt38T0UiA=;
        b=L8Re0FxufeIq1mBW662gpgJIoiZfIWwqs1K72N1nZo3t0KWfpfnD2g7dkmRDpTMuE7
         ExBnaGTpUM4MHYNkUAk/qUNtyoyOWl/0HLNwLelUcvSGLeitBB7G89TTAueKfQO7k4gI
         EiFK3b023sxx0uCXihwk7BqQVEw5gBgM3jOjhhrpjT64l7dOz56fxax5nTxjS2/rJHjQ
         SxUj29UjJMiqEXXytGoDsrqZZ7SVAq1lPfnDkVvRct6wHEa5Ixgl2xoz9liY3fdVKXaz
         7C32mZTXfiERoRCAUa2cqKLPM7yGB80KmHN5FeC2sVESYSSytftNgYaBGMDNLMNPEjF4
         l9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242596; x=1794847396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7nDPEMSIA3pdPYzsqIj+oxUyRpuyBiq8RDt38T0UiA=;
        b=Afiz6U1Fq1DwzKB+tF3LWsCNnQ6JXR1s4+62xCSGudZp9Agl+ZJahnZZ8d4Xvb4Ncp
         5dcuxanOXwe/3BeJRdtuS1Lcxdmv81+ptOtLEFaD3r7XDD4Jhn4zSQ4J0cvvZgICC7CR
         fiij780M4tcYt9K5YKVGi3+hdeDzOyyeuUtDSqeUWGjXx7YGPoSwDRlnvtQNEExls7jA
         1duzk2FWsSftNm3ZZgMJ0q3Ouc0rBwp6aEtbf+14/LgZ7hW2DYP31I0IshKXR8NjRej9
         lb64cwxOunCeY7WNu5JorL5cK37NdHA2EsuJhLsQIHaxGdAfWNz6xiJ+ieXlPPOl/YHC
         3uRw==
X-Gm-Message-State: APuU4Z8hDrUExBJ18psPv+b51dEQQaRphalyDen3hFpr3Wb9Cf6mdYUG
	fUhVZ6uLDfDfsUhc3/TVhcd7sy83x0GUmcWPeyCaV9NQ1wVzIvK5RHx90uhIjEs/7pj50a/gEox
	SCSPgAnKxp1H+IdQp/ll9wDcmTG0lN0E=
X-Gm-Gg: AYBFou1HMdLvmf9brGfQyYcjbT14sied6u2wxoHVbNj+tpQywwEcIfzWFHSeUAKnE71
	XdSauzobDJPOPRXJkCIDmBh/5Qi9Fn8ZeCchn0edmEcBoZx8l9BChqUAetF9h1sqKgvMLZDAT72
	Ri6g5h2UmK2q60UX2B0SaXI9EoCU+SD2hcAlo9UXwraeDGEgoE2S7dTx/6L/k/nO4ArHNZi0n9c
	L6ROj+QOwu8QF6JuRp6vPy1qXYlJW3+5DbOUdCFMQZLv7AKDVI4UzOlBEjeLbRJQXJ9UQhDoiTc
	BUVBxHpOc+iE+1wxHsR4mKxU1lRrhi6wCmB16k1UO2flY3UMxARf1RarZj+9vggdeCVuSYbH+AB
	hDNDBqXYR2yWPHrESnt8yr3ZuhtkIlUkX6QHgKcxh/F6Rv2CN8ki9lnOoScu1DnCgX0tzsUdldu
	ERrsXkPraVEfoQKU2q3pE1lIxNjw9Jv+tGJmQujiQACjpJIoicn0eQWA==
X-Received: by 2002:a05:600c:3f0e:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4b963c74baemr92408265e9.12.1794242596026; Mon, 09 Nov 2026
 08:43:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179381517319.9644.1165591016149104577.stgit@ahduyck-xeon-server.home.arpa>
 <179416277472.994134.4219031759590425185@kernel.org>
In-Reply-To: <179416277472.994134.4219031759590425185@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 9 Nov 2026 08:42:39 -0800
X-Gm-Features: AclHuK__Mx437XDXsM2M91K4V3kJ5LgUioptGCSVloSlp1bt9MSDuuJ26akw4Gs
Message-ID: <CAKgT0Uc83DgdG4WTQLTFJnF6Q-oLXzrf57a1Nzr8zu=E-V3N-g@mail.gmail.com>
Subject: Re: [net PATCH 5/5] fbnic: Wait for the outbound flush to complete on
 mailbox teardown
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 10:32=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] If the new poll times out, fbnic_mbx_clean_desc_ring()
>   (drivers/net/ethernet/meta/fbnic/fbnic_fw.c) still frees the mailbox=E2=
=80=A6
>
> --
>
> fbnic: Wait for the outbound flush to complete on mailbox teardown
>
> After fbnic_mbx_reset_desc_ring() arms the flush, this patch polls the AW
> or AR flush-done bit in FBNIC_PUL_USER_IP_LINK_RST_STATUS. The poll runs
> before the mailbox ring buffers are unmapped and freed, and it gives up
> after 1ms and warns.
>
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_fw.c
> > index 49b8813a35643..e00d626f64384 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
>
> [ ... ]
>
> > @@ -176,10 +177,25 @@ static void fbnic_mbx_unmap_and_free_msg(struct f=
bnic_dev *fbd, int mbx_idx,
> >
> >  static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_i=
dx)
> >  {
> > +     u32 flush_done, val;
> >       int i;
> >
> >       fbnic_mbx_reset_desc_ring(fbd, mbx_idx);
> >
> > +     /* Arming the flush only starts it. Wait for the outbound path to
> > +      * retire the requests it still holds before the buffers they may
> > +      * target are unmapped and freed. A lost link reads back as all o=
nes,
> > +      * which ends the poll on the first pass.
> > +      */
> > +     flush_done =3D mbx_idx =3D=3D FBNIC_IPC_MBX_RX_IDX ?
> > +                  FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE :
> > +                  FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE;
> > +     if (read_poll_timeout_atomic(fbnic_rd32, val, val & flush_done, 2=
,
> > +                                  1000, false, fbd,
> > +                                  FBNIC_PUL_USER_IP_LINK_RST_STATUS))
> > +             dev_warn(fbd->dev, "Outbound flush did not complete: %08x=
\n",
> > +                      val);
> > +
> >       for (i =3D FBNIC_IPC_MBX_DESC_LEN; i--;)
> >               fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
> >  }
>
> [Severity: Medium]
> If read_poll_timeout_atomic() returns -ETIMEDOUT, does the original
> DMA-after-free problem still happen?

Short answer. No.

> On timeout the code only calls dev_warn(). It then falls through to the
> same loop as before, and fbnic_mbx_unmap_and_free_msg() does this for
> every descriptor:
>
>     dma_unmap_single(fbd->dev, mbx->buf_info[desc_idx].addr,
>                      PAGE_SIZE, direction);
>
>     free_page((unsigned long)mbx->buf_info[desc_idx].msg);
>
> As the comment says, a lost link reads back as all ones, so that case
> exits on the first read. That leaves a timeout to mean a live device whos=
e
> outbound path has not drained, which is the wedged-device case named in
> the commit message.
>
> In that case the page can still be freed and reused, or its IOVA unmapped=
,
> while a Tx read or an Rx write is still pending against it. Both paths
> reach this branch:
>
>   fbnic_fw_disable_mbx()->fbnic_mbx_clean()->fbnic_mbx_clean_desc_ring()
>
>   fbnic_mbx_poll_tx_ready() clean_mbx error path->fbnic_mbx_clean()

You have already called out your fallacy. If the reads are returning
~0 that means the PCIe link is down. If the PCIe link is down the
device is unable to communicate over the bus until it is reset and
reconfigured.

> The Rx ring has one more case. fbnic_mbx_init_desc_ring() later sets BME
> and clears FLUSH and FLUSH_MODE, and nothing checks that the earlier AW
> flush finished:
>
>     wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
>          FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME |
>          ...
>
> Could writes still parked in the pipeline then land on freed or reused DM=
A
> addresses?

This is why we reset the flush bits as a part of the initialization
path in the first place. Setting the flush and flush mode bits cause
the DMA writes that are stuck in the pipeline waiting on BME to all be
cleared so that they don't write to the host when the BME bit is set.

> On timeout, would it be safer to skip the unmap and free and leak the
> mailbox pages, instead of giving them back to the page allocator?

On clearing the BME the writes are essentially all terminated. This is
clearing the path between the PCIe user logic and the AXI fabric. The
general idea is we want to clear this path before the PCIe link is
dropped in the case of a warm or hot reset.

> Also, the 1ms limit doesn't seem to be based on the PCIe completion
> timeout, and that timeout is allowed to be longer. Is 1ms enough for
> outstanding reads to complete?

This is more about synchronizing the PCIe user logic to the AXI bus,
not the PCIe to the Host path. The PCIe itself is normally reset as
part of a hot or cold reset. We just need to clear the data that is
internal to the NIC that is being routed to the PCIe interface before
the PCIe is reset.
