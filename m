Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF134FD7B5
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744667; cv=pass; b=HI4hAaVsRixtUIJtworZGbbSdkaHDHTkMPaoh1UWfWEvqKTs2ooOIOO7FXLh36hwa7gSQFlHeSD/3Pxw4qZfNtypOFRbsWtvOOkC40nOV2IPmWpNXMlckrrlI6K2TOV4cLKseX/Tnpe5+KrehZxzAP1YcEvNrrm7OCbPGd+97KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744667; c=relaxed/simple;
	bh=iGYNwJUPmcx1Hz50XBiDUkDETULCL8cN7cZj2G+psWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHvamhhvljqA0q226qSKc82tzMuVTavzK/n6YNxyAQH4AXHEwfwSb9gJn3UboktVR2MT/wOEf/kQxNse3mvg66Tcoc380KNru3UxSciNjPn33db348JrxAIwd4+TSR8wG4QNQo4Gg2LzKrbWF2QckyMyfkLyvWGkTtm2pSsdXMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLbh1444; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLbh1444"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so469273f8f.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789744663; cv=none;
        d=google.com; s=arc-20260327;
        b=jkvAec5R4IstJvvd4WZTI9v45Q+N/Sw4wyrcJhugpAyUO/ZW9BWY3Llj2bKLVzL0wL
         nN1n+mMPhDFjclpob9TDE4KkplnXUClXhYCLpRRodkb0Oz4kxrVplKFivfxc9Fz1CxS1
         /iO+8lexJhPWRfwscH4dFcih3cdH6oXZ+19ugjsq2fyZ86pcL+GdhkIUCwreWDKRhPRz
         Fai1SsEPB9qk+ldq0JIIWCM3utz4ibFTpbOGLWIbBw2K5e+ckELuVbyGInqE/QH9oP0j
         ue2iCAwUmaYe+7ktTjoqhYLlJds+ga9d2leo5OM5cQ+eTnCekJQ+gjTXaswU2/xzNopg
         gVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gRByL8RFLB+WknNpJm2Ipy80IzPzlbzp7esp8aa/gnU=;
        fh=iV6JIq2XCdEGzMbsv/k6Vz5yMtQ5WvkueSO8IP3csDg=;
        b=i8huBxqCwt+jGk/hQ74E76UHdeQm9S9KUC5bSyddNH44QvYlPNBYyq5f+D0l721nWI
         2znm0b3BefmaNv/Nz6g0CLUcP68WVvhyaaq95IGZ1KiDSm2T1D8XIk57y0m/5cVyj8o7
         6G3y4brwg8gbsE0S+qE3Z/QOj5hF6NFs8iz6owPoXWIMPps6yjZplhXGn8uDd0Uv5hdI
         UDHb2FquDNLdhxILtnaDLmm+OnY/lb61Mmke4XgauUSrXXJvat/P9bK9YfX1GsU8uqwd
         KraRwXiWkjMRbhuA8YX2DhZxm9pCE/V0K+uFskWwm8RtD+zbTR96rMG+ytgYd+TMNkmA
         y5kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789744663; x=1790349463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gRByL8RFLB+WknNpJm2Ipy80IzPzlbzp7esp8aa/gnU=;
        b=BLbh1444+eNx0hGXZZkrzTP7k9je5h8Zu7cthFP8a7uITnknXDJwz1ZSNA8MNW24BR
         eJya3q/taOmKYUYGaRKjhW4v0logZTIMVJJbmGhQS5DIzV+XMifwej3P3YWaGLSXbVRC
         m4zQ9VWFHNbVDjKvDwJEwX1UkZIxZ+A9re6C8f61Y18O7PMamOAb+JdZ+jVe8xXvLyhI
         fogvWSgfYTByma42xtUJ6bjlKuIzD4/D39aZUH8vrM2O5sdLWyffRfCrglt26rlf7fRy
         zm7BFdfgGFPVpHl/4uFCHtaVkbKRYrYyhGuOWsuMK/dy7hNjt17k496NLafVZNlTNgmV
         UoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744663; x=1790349463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRByL8RFLB+WknNpJm2Ipy80IzPzlbzp7esp8aa/gnU=;
        b=UwxQp+ci94uEwnybueNnjQe/fcOjZAaTR0MjWXalDZdXxeatGHXLrlR19s33MJPCVW
         Y77nxDBSAUr+idBqws/spwbpmiWOLOeoC5cw+uv4aTom8N8ZzQLHCuL95FxuQCagHWaT
         Zc0gV5WjjmfbIIWGCTgIPszv6RL7bRX4Y2ijE7UoMF8lJmiJEV16P8emoOLynsiODX4+
         MIL0m1qLXIsqjVHaYZxWwzB4DrhDdv0lzxCpp0CYABEzMzOiH25jZpYis/ke1yuIHqhL
         DgNAii5rDTRAvYFjzcksuEpq9uMEkODnaKAVWMaroN4R4KrAKNf+i7zbh0Xg2dUJ/ZUy
         v6kQ==
X-Gm-Message-State: AFuF++lq1fUwbx556OJ+pjZVZAHaC5G/Wp8IAMOXCm58m6k65hxn3cVg
	umGvtQdMTD/hXyuhqxIkOXyDlm1OSSBVcFbr+lcpuFj+IGjuEuwipPnry833+5LajrZB07Ob4SC
	VksiuuQOVhDF+sjFxkepBii7CmJb14NQ=
X-Gm-Gg: AYBFou2h6b3ncLKpCRnSWHx6uq7fFlHKN5aQhq0coyYNELj7p3e7+7H+PPZ7eed9RH5
	2roa/BJG5/cu6VBe/CyQsgS08aTLV3V6IPt6OHIOm7Mq90erZlPhbHbxk26gukI8gJ5VFa8ggFG
	FsPqyx//NfPDSFio7+rTu+SgMWAzRqOB+Qm2GYaxnlBELtlhuG2a3nUnlKzZju+x2tMwMdgeNPY
	bzVGhS73h0p6ufLe59RzfcCm4cxPQpfkbdlGMKDeM6eumb5Z+5SboFhPjzHSji/2oGnObmxbwUF
	lwvBbxpkhX593atVpGgYt8O/0tQ0DB0TuwY8Tnelq+i7R2H0HDUZPOl9WNNOKcBqxNFPqHuCyRc
	VnKUbxGXbO2SazlOLM42Sh1jICxKBNwu98ANQccDQIBBgJY4XDeWdrLeWEZeZd1n9iJtrr30Msg
	==
X-Received: by 2002:a5d:64e4:0:b0:487:172:6293 with SMTP id
 ffacd0b85a97d-4871e21319cmr4476824f8f.3.1789744663401; Fri, 18 Sep 2026
 08:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178942023343.7700.9423398932961964439.stgit@ahduyck-xeon-server.home.arpa>
 <178967953049.22033.7278929297475041564@kernel.org>
In-Reply-To: <178967953049.22033.7278929297475041564@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Sep 2026 08:17:06 -0700
X-Gm-Features: AcwNN1W4RPuzEdrcspXzteAuc-jBJwQV-7B_d-6bBpHEHD8def1K4AhumRaY30E
Message-ID: <CAKgT0Ud_RezDQC0PVav6OOX_ha8ErkVMs_SWqn8_Xk5dSUrTzA@mail.gmail.com>
Subject: Re: [net PATCH v2 6/6] eth: fbnic: Handle FW mailbox completions
 flagged with an error
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:12=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] FW_ERR handling does not release the outstanding-request
>   bookkeeping: when the firmware completes a Tx descriptor with=E2=80=A6
>
> --
>
> eth: fbnic: Handle FW mailbox completions flagged with an error
>
> The patch adds a check for FBNIC_IPC_MBX_DESC_FW_ERR on both the Tx and
> Rx firmware mailboxes, counts the occurrences per mailbox in
> fbnic_fw_mbx.resp_error (also exported via debugfs), emits a rate limited
> warning, and drops the Rx page instead of parsing it. It also re-issues
> the bring-up capabilities request in fbnic_mbx_poll_tx_ready() when
> either resp_error counter advances.
>
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/=
ethernet/meta/fbnic/fbnic_csr.h
> > index 14af30e189d6c..baba3471bf5a4 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > @@ -1216,6 +1216,10 @@ enum {
> >  #define FBNIC_IPC_MBX_DESC_LEN_MASK  DESC_GENMASK(63, 48)
> >  #define FBNIC_IPC_MBX_DESC_EOM               DESC_BIT(46)
> >  #define FBNIC_IPC_MBX_DESC_ADDR_MASK DESC_GENMASK(45, 3)
> > +/* Set with FW_CMPL when the FW completed a descriptor without success=
fully
> > + * processing it (e.g. a mailbox DMA error); the completion has no val=
id data.
> > + */
> > +#define FBNIC_IPC_MBX_DESC_FW_ERR    DESC_BIT(2)
> >  #define FBNIC_IPC_MBX_DESC_FW_CMPL   DESC_BIT(1)
> >  #define FBNIC_IPC_MBX_DESC_HOST_CMPL DESC_BIT(0)
> >
>
> [ ... ]
>

[...]

> but that is only reached from fbnic_mbx_evict_all_cmpl() in
> fbnic_mbx_flush_tx() during mailbox teardown, never from the new
> per-descriptor FW_ERR handling. Could the FW_ERR path look up the
> matching completion (the TLV, and therefore its msg type, is still in
> tx_mbx->buf_info[head].msg at this point) and complete it with an error?
>
> > @@ -1673,6 +1679,13 @@ static void fbnic_mbx_process_rx_msgs(struct fbn=
ic_dev *fbd)
> >               if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
> >                       break;
> >
> > +             if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
> > +                     rx_mbx->resp_error++;
> > +                     dev_warn_ratelimited(fbd->dev,
> > +                                          "FW reported an error on an =
Rx mailbox message; dropping\n");
> > +                     goto next_page;
> > +             }
> > +
> >               dma_sync_single_for_cpu(fbd->dev, rx_mbx->buf_info[head].=
addr,
> >                                       FBNIC_RX_PAGE_SIZE, DMA_FROM_DEVI=
CE);
> >
>
> [Severity: Medium]
> The same question applies on the Rx side: when the dropped descriptor was
> the response to a request with a completion installed, nothing wakes the
> waiter either, so callers such as fbnic_flash_start():
>
>         if (fbnic_mbx_wait_for_cmpl(cmpl))
>                 err =3D cmpl->result;
>         else
>                 err =3D -ETIMEDOUT;
>
> burn the full FBNIC_MBX_RX_TO_SEC wait and report -ETIMEDOUT rather than
> an error.
>
> The retry added in fbnic_mbx_poll_tx_ready() covers the bring-up
> capabilities exchange, but the QSFP EEPROM read, coredump info/read and
> the FW upgrade start/write/finish requests all run after bring-up and are
> not covered. Is that intentional for this patch, or should the completion
> bookkeeping be released for those too?

The modification this way was intentional. Basically the most likely
place for us to ever encounter an issue with  DMA is on mailbox
initialization. Doing it this way reduces the driver init time as
instead of waiting 10s for the mailbox polling to fail we just burn
through the DMA failures and get to the result quickly indicating that
the mailbox is dead.

Doing the same for the other paths adds extra complexity as they are
interrupt driver versus the mailbox init which is synchronous. In
addition at mailbox init we can only have one completion in flight,
whereas for the other calls we can actually have multiple so without
context we won't know which completion it is we need to release.
