Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793879658;
	b=K4O6qMoEheYziHEvcloyu0S/g8h69aqxRq+NEiBl3E0lE4Sbg+05oWCNoiMBrsfQY/sH
	 4YmOOuPoTDQdX5gm5M0rzqksXmwXxj7IOQDU/YhCMDzsBgcMmvaFm2ve37GIKJD3D0mjh
	 U+ChymbJGbqTt56GT0cxjH1lmdSSm/OuqrfjTZ/C1uVjlgRC9cWZK0T5V57AXZD5GAlT5
	 LOcLmtAL6L22KnmJnSCnOoXUik5PyzK28kwiLJBBPl1g2h2Fs7a0xce4a1CJ/sId7RM8K
	 VGtkfKLaDt+bZcWqnwUZYC2uI52bOyJEwMx9xFH+S+8qp3TADbYmPBA1vTLTD8JKjAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:In-Reply-To:
	 References:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=N+3m3vZOzUEGlHuUM9OVDnQH8LQ3Rban+sBZHH4tE00=;
	b=RvJ0+Oc7b5PcS3X7ujpQOlLA2c2MPZIpYvEh4sJjk1Qa0p8Xssf23MwPfoSbKggtww11
	 eaxl/ZZ6rPSsSMrur8kRRLZ26TC85jXKfdcmmScAduuAaZenO7Cf9jLeWr96veo2jL5hx
	 e1Z7EWPZqZSTtVNv7e/4ke68VpTjjCl1cKH9CxgCG7ai6VlC6xX4dm1b4bz9Os+6+eCuk
	 Cwndr6Dey9yJXMxWc4Ke/SDx/o5449HmLfzKz/Nd4j+BiUzVO6wrKvtE5A3WrpzGAITBs
	 npEtuo16csrQsoWcOnNZKMGJjpsCzhcqMs4vKFEjBE8h1A+48lYvuTEm34wlTsnzx3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DCdUCa5x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879B606A900
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D879B606A900
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DCdUCa5x
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ac99992373so14988191fa.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793879656; cv=none;
        d=google.com; s=arc-20260327;
        b=JX0kLuWoLTJq8pLCVqEHpzGjis0bJYZVgpcXEek9ocpTNdBjx6dXCLAclRjL8Zs/8d
         aluEa9DIPDGBHx2C9jhoJBCpwhAdPSeBcByqzjXaxuFnGSVwK/I9NJPqrG1dzcRm0/mX
         r9oqBSMw0WD59HRmqR4Q2XlHOpF20jVn2lBpd6YdRPZQ8ck6IdTUmW90oDMDbKY9b+yr
         bXJy4Y93u99p+HrOo+fM4LkYyYDztc2ELDylkjkOs0635zTVEj9oBT3gbZLW3wIlEpdg
         IrD4V6GwVSty5+ncZF2N95aOxGXQMrOqCfezGYj4hRdothKCeXDV2U3CwLCIyIyF+77N
         T2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=N+3m3vZOzUEGlHuUM9OVDnQH8LQ3Rban+sBZHH4tE00=;
        fh=p4H8V/H/uxIefnKjtAGdgFVIvte+I7obBdsLpOSyMOg=;
        b=nJn6j+JIpikycVBa3U1Olg1BzccHPBEubDr/jPWUj21xTWGm8emLndA1WbhAzJ6Yja
         uXkxBGelJrlT/LdL4STsX4egCbANr4hKrKY1Wkgl03GJENE45pdBMYV1CjUmHEZ6ECil
         0LUxWxS/oAlpm1fSqU2/xHp+q9mb+rrOYpQGbcLbhMA4phWT2nfd5qgT8CBkzlvEuPPv
         qbvqo7GYJh8zASIGlfbuhbAF69XYeWxyA7AT9bDohfId8gJt3ZW7ZyY4Wc26zl1sByCs
         xOnuLaU8Z1LemnvpSu6mQHdaN6KlyLb+NPP3oyRL5DwtdhDrvptumN8+c5037cLlgG/g
         q29w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793879656; x=1794484456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+3m3vZOzUEGlHuUM9OVDnQH8LQ3Rban+sBZHH4tE00=;
        b=DCdUCa5x+yRyAT31lbAmXtahG9EYq+8GeSZ2wi+IICNAOBf8dX1U6ipm+s/3EOWK6U
         5QJpiGFoERvOY9EG8R2CO91TqBTxi2u9/LDA2LvEbZMW8Ghx2TN9MZO08C2KSZ2Z2ROE
         Wsp7/FjKDIojzbRGUXD2Q+waYDYnIzUzDCf8uJsINq8cy6gM+n0IKGgqVBQXxp6k6voT
         OyWTC1xUYlfTvXUv5yGFRx5JQ3dUuuCoxSuepwClZSKVki4+nRPrLcR4oSc8Vp1XXAaU
         Pk8jPE0c0hBm3oVXvLGO9Z8ssVKs1D4rljEjFvjpeqIux5npT2Yy7OuB2IwG/mWDQ8BR
         hRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879656; x=1794484456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+3m3vZOzUEGlHuUM9OVDnQH8LQ3Rban+sBZHH4tE00=;
        b=ncV1km8jxpu2+aY4bmn2EibX0xL1zul9UvqsuoNmud9+njVWT/YYvhUEYrF5ZMqB9+
         b/GuFMEQpnCojWHKODfA4Sq0ST2BWB15uEoeNydSKjJ6Bnl5lh+gFEhKrJDB3BQUZPPn
         irWFYjx5mAUWWA5cCd88Y0O5+sADXeYmoqOvAyKtSn04yTOl01S8rUjflJjn6G1CzNbm
         RlzufNEj+yy/8NzDyxU4CoVK7aUXTThNSlnaHKun5XEHZqJOAhuObOekClcN7BT5gDcD
         4Lt7qXngS5q8MIc5Ull9KHiRFjOoqr116zj6Qn8faH58kuNWix9iqd2OYQVNomPKiows
         oa9Q==
X-Gm-Message-State: APuU4Z9Of+/XitZy/Nw52XEDIaj7NIKkFlsuL6TbwhpZ8jlHC7KfwjiP
	aSoAtfeeN9qAOCXilyLAIGu5ScOsCJOSAuZ0zaWuqVnDIM3w8FNtUriwbAdeLxOjFy8Ob5OPsXb
	RYN+ZVV1a/2FUrTEJZCNK+erx0bTnLXjILXlF
X-Gm-Gg: AYBFou1mQsIeYX5ehlL3cNu6SUAvarv2ohstiJ+9IrX9VQHXgb3l0e16IPcA4TYqG4b
	5ivG88hvkZyRYqDmHpBXnGhdAT8saoedCs0MfVw/d4heOd5swDdJcOLl8OrCV47L3qugPItw0hA
	lqRxGvC3aTPPP/Pn/+wBU00MNKoYdP277ScrXaJN/MetfaFf2WAEx+6Hc7tPQvLnWgt4jq5GokB
	aoR8+mHEMTqda5ti9UtrjhRkza6gsulq9Mn9qsyKraoQKi48k41JdUX9t4nXnn2C72gqvZlGXQY
	e1dRGwzl5F38FLGxJR9RyLXTSoKzcMwLtSsQaPx60i1ffT3tUUGi46SgDOGrJugm0dRd0dIUKsq
	bK2FCMF8uJS3dAbJkmYRXS1QPk+AYTjmBOKM3aun0yt478zQNL4MC+HCt/MEydPdDCw==
X-Received: by 2002:a2e:a809:0:b0:3ab:4a7c:7a65 with SMTP id
 38308e7fff4ca-3acb7883d20mr40938051fa.0.1793879655702; Thu, 05 Nov 2026
 03:54:15 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 06:54:15 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 06:54:15 -0500
In-Reply-To: <179387271921.488856.11043838083216323158@kernel.org>
References: <179378590950.74297.14503648624087894519@gmail.com> <179387271921.488856.11043838083216323158@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: zhang san <shunsheng1218@gmail.com>
Date: Thu, 5 Nov 2026 06:54:15 -0500
X-Gm-Features: AclHuK_PjOfwrGU7V8tuY37Lm8UZo8c9leNmigz8_H-PCKcm9vybXrcGuzeOckY
Message-ID: <CAGTEBTZztQcrwJC0pECO=vmn5xZv-cY_OZnSLVBL_9Kt0OzfVQ@mail.gmail.com>
Subject: Re: [PATCH] nfc: rawsock: prevent TX work requeue after socket shutdown
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev-bot+sashiko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am resending my response in plain text because my earlier Gmail
reply contained an HTML part and was rejected by the netdev,
linux-kernel, and oe-linux-nfc mailing lists.

The issue was identified during AI-assisted source-code review and
investigated with a KASAN-enabled kernel and a deterministic
timing-injection harness using a virtual NFC device in QEMU. No
physical NFC hardware was used.

The High-severity finding on v1 is valid. rawsock_release() set
SEND_SHUTDOWN without holding sk_write_queue.lock, allowing a delayed
completion to requeue tx_work after cancel_work_sync() had returned.
In v2, release sets SEND_SHUTDOWN under the same lock used by
rawsock_data_exchange_complete() for the shutdown check and
schedule_work().

The Low-severity Fixes-tag finding is also valid. V2 uses Fixes:
d793458c45df ("nfc: rawsock: cancel tx_work before socket teardown").

The timing-injection test produced seven slab-use-after-free reports
with the v1 locking and none with the revised locking under the same
conditions. We do not claim that this patch eliminates all potential
data races involving sk_shutdown.

V2 was already sent as a separate thread:
https://lore.kernel.org/r/20261105113812.969651-1-shunsheng1218@gmail.com/

Best regards,
Yaohan Li

pw-bot: changes-requested

On Thu, 05 Nov 2026 09:58:39 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is still racy, so the use-after-free it claims to close
> remains reachable.
> - [Low] The patch only works on top of commit d793458c45df2a ("nfc:
> rawsock: cancel tx_work before socket teardown", 2026-03-03), and the=E2=
=80=A6
>
> --
>
> nfc: rawsock: prevent TX work requeue after socket shutdown
>
> The patch makes rawsock_data_exchange_complete() check SEND_SHUTDOWN
> under sk_write_queue.lock before it reschedules tx_work. The goal is to
> stop a delayed data-exchange completion from requeueing the work after
> rawsock_release() has started tearing the socket down.
>
> > diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
> > index f7d7a599fade7..efdbd512d4600 100644
> > --- a/net/nfc/rawsock.c
> > +++ b/net/nfc/rawsock.c
> > @@ -168,7 +168,13 @@ static void rawsock_data_exchange_complete(void *c=
ontext, struct sk_buff *skb,
> > goto error_skb;
> >
> > spin_lock_bh(&sk->sk_write_queue.lock);
> > - if (!skb_queue_empty(&sk->sk_write_queue))
> > + /*
> > + * The release path sets SEND_SHUTDOWN before cancel_work_sync():
> > + * once it is set, do not requeue tx_work - the socket may be freed
> > + * right after the cancel returns.
> > + */
>
> [Severity: Low]
> This comment relies on the SEND_SHUTDOWN / cancel_work_sync() block in
> rawsock_release(). That block was added by commit d793458c45df2a ("nfc:
> rawsock: cancel tx_work before socket teardown"). Before that commit,
> rawsock_release() did not set SEND_SHUTDOWN and did not cancel tx_work.
>
> The patch only carries:
>
> Fixes: 23b7869c0fd08 ("NFC: add the NFC socket raw protocol")
>
> The lines it changes date back to 2011. It would apply cleanly to a
> stable tree that lacks d793458c45df2a, and there the new check would do
> nothing during release.
>
> Should this have a Fixes: tag for d793458c45df ("nfc: rawsock: cancel
> tx_work before socket teardown"), or at least name it as a prerequisite?
>
> > + if (!skb_queue_empty(&sk->sk_write_queue) &&
> > + !(sk->sk_shutdown & SEND_SHUTDOWN))
> > schedule_work(&nfc_rawsock(sk)->tx_work);
>
> [Severity: High]
> Is this check actually serialized with the release path? Only the
> completion side takes sk_write_queue.lock here. rawsock_release() sets
> the flag and cancels the work without holding that lock:
>
> net/nfc/rawsock.c:rawsock_release() {
> ...
> if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
> ...
> sk->sk_shutdown |=3D SEND_SHUTDOWN;
> cancel_work_sync(&nfc_rawsock(sk)->tx_work);
> rawsock_write_queue_purge(sk);
> }
>
> sock_orphan(sk);
> sock_put(sk);
> ...
> }
>
> Release only takes the lock later, inside rawsock_write_queue_purge().
>
> Can the following interleaving still happen? CPU0 holds the reference
> taken by sock_hold() in rawsock_tx_work():
>
> CPU0 (rawsock_data_exchange_complete) CPU1 (rawsock_release)
> spin_lock_bh(&sk->sk_write_queue.lock)
> queue non-empty, sk_shutdown =3D=3D 0
> sk->sk_shutdown |=3D SEND_SHUTDOWN
> cancel_work_sync(&tx_work)
> tx_work idle, returns at once
> schedule_work(&tx_work) succeeds
> spin_unlock_bh()
> sock_put(sk)
> rawsock_write_queue_purge(sk)
> sock_orphan(sk)
> sock_put(sk)
> last ref, socket freed
>
> If tx_work is neither pending nor running, cancel_work_sync() returns
> right away. __cancel_work_sync() also calls enable_work() before it
> returns, so the later schedule_work() can still queue the work.
>
> rawsock_destruct() does not cancel tx_work, and the queued work holds no
> socket reference. When the worker runs, rawsock_tx_work() would read
> freed memory:
>
> struct sock *sk =3D to_rawsock_sk(work);
> struct nfc_dev *dev =3D nfc_rawsock(sk)->dev;
> u32 target_idx =3D nfc_rawsock(sk)->target_idx;
> ...
> if (sk->sk_shutdown & SEND_SHUTDOWN) {
>
> Would it close this window to set SEND_SHUTDOWN under sk_write_queue.lock
> in rawsock_release(), before cancel_work_sync()? Then either the
> completion sees the flag, or its schedule_work() ran before release took
> the lock, and cancel_work_sync() will cancel or wait for that work.
>
> Separately, the unlocked read-modify-write of sk->sk_shutdown in
> rawsock_release() races with the plain read here. It also races with the
> plain store in rawsock_report_error():
>
> sk->sk_shutdown =3D SHUTDOWN_MASK;
>
> KCSAN would likely report this as a data race. The rest of the
> networking stack accesses sk_shutdown with READ_ONCE()/WRITE_ONCE().
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/179378590950.74297.14503648624087894519%40gmail.com
