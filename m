Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD214C040E
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322089; cv=none; b=LqGPA34lrPvnFGeTRZWdxzJCZ2TuZRAkSADVEquE8y7OOyXKNbCWiLixAALA/fzHO1nmu+nk2p22UQQHg9cQ62w1ZaM2j48tHkU20dczoMacECQSkcyIErSwXdq2h2wDY079JDZ6Ku91rcgcJTA+OeZDRWN1tXTBmrI2OL2cr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322089; c=relaxed/simple;
	bh=swPCRg0mE4H3SHLdPEqXkupOTDy1ncDa3bxxkpac4lU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aQToDclO+8XtKhRorxgc4SpBvP32zEYWPdMj62iMnLQD1PnwSbcAuNPU08L4Tn/AjqjWGpF/W4VL4bRjb600hSHLfTwrF7XbhhIIC0bMfx3e2ck7PM7xm6lIgKkHZ1D8brvvG31GYr8rkf8WFVsarLQqwHxaJ4exp9KWRE64mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPFAiFQd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPFAiFQd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0cea8883so8348351cf.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322087; x=1787926887; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lTuRd4xQT37Jqul00lElcHcBakjw1tAhFp/7eCwHpYw=;
        b=XPFAiFQd99uMdQknB2CVJw2yp4/nAF8cP5gszkNJ+DfUuHIBWngfPhNfjRf3TT7Flt
         6egvr1WUg0udrJx7bpmw3hHD9Q20cPT3EpfQ29IANYLyQSkZ3yEimKNQCZIhguGvbhb6
         5n+24NL1OqWYALh7wXyv3PllOhwoCi4YXEq44Mz314zrLWk/hvZ7/uoSAc2WzVxdL57g
         IxLcDo1iRBC8hE2KKzRQBlv6nLi1lR1ZhPeZdxOjHiKbo91yt6+A1d24X3AZz0Waxva9
         tZ5JvUE45dxUsqVNWkgwnRYMZcKdp7M7QQZSJgbmBxqs6TV+qLApSnayUKH0qBcwniCB
         MeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322087; x=1787926887;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTuRd4xQT37Jqul00lElcHcBakjw1tAhFp/7eCwHpYw=;
        b=jZjVf5F+Bffto1DTvik0PxcTXgJ5eaAyYEYWyRi+y/zp6Uejpo3qwEAJQxTM9juxPY
         6Qe/A+EMVf7Tdf04IChX0pUnrKEg4f7cgwUNtEEMc+pHuvTgsxVqn3Y3dXRIuSiAsXVn
         ArUvVV7B7CZ3Y4dBWNGnr8r7IGrUQE2/mobUOiYZpND2zdYeQxV94UmciZAyGLo7qtRc
         M43BsD3AkykEGknUcrOM6Tr2vaIF46BjB1CVmS3iNEvPYHsMjv0wZ2qAyS8+Bri8niTA
         Y+zc9DLVIFBjh//rYGuJoKmBVWyptw84F3M3jCPI0mPkDM4Ve9y1zLPz+OqkE+dKpxoC
         Couw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0ijF1ty1AlRl2nyiRcsCdplSNbmlBfLQjNyCjLgLmpx0ZIMN8nvkmSu++9ot73bUFVWyW/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSnmnmDCxncHMWmUeCO4OcpmyuRWd79G9T2aLhbqSRrlhTEI2
	dSoukj8FE17jlV4qjl5Zb652RMKXtoFsw8JK9p5UjtoddScPmovbvDF1
X-Gm-Gg: AR+sD116lD4zLrlLt62HZMgqahFmHcE23lD9YLYYzJazewto6K/EYEAO9oWizD5PbCX
	+WaeEV1RG94NPasWL8Y88KuMBuYW1732HMPlFCEjRl5pA2I6+L2bB2EwnSZIfPj/vdV9CyGIpBz
	u3hxwPZrvyzeJ3PYqjpSnSaCfY6Ah0qTnyIr7vdmakc6bj918q/BcIpbsMa1QgQqXbyvInNCBuM
	OGFTBI1cDeSjfSCjLNYQvOTA8SlMks/GEA7/Mmt/AlMTpsEGPFsne/o+ihj2JSR7uLFQVZrmUNb
	4x2DG8bC3BHUn+of7vtpcocA/kFvwXyl+It7Kg0miZiNAE6UI6cAh8yblzBj1jucDJs1B1gLii1
	m7VlDKTKY5xAyFqrMBvWgSQ4tzEbXGz9Vf+hWOk7TA30MqFhSjx7zEWTWwn1tx+w/EUcGym2bVe
	Nu57VRoYcaOzHyQYU+7CN4b9rPR5MgRHGpRSY=
X-Received: by 2002:a05:622a:1904:b0:50e:635b:5562 with SMTP id d75a77b69052e-52df676e1a9mr48704461cf.22.1787322087254;
        Fri, 21 Aug 2026 07:21:27 -0700 (PDT)
Received: from smtpclient.apple ([165.85.199.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd857b6b1sm51365781cf.3.2026.08.21.07.21.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:21:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net] nfc: llcp: fix UAF on socket in nfc_llcp_tx_work()
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <20260821141358.3546366-1-edumazet@google.com>
Date: Fri, 21 Aug 2026 10:20:53 -0400
Cc: "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 David Heidelberg <david@ixit.cz>,
 oe-linux-nfc@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBC379D4-4F31-422D-A81A-0E88EED9CC23@gmail.com>
References: <20260821141358.3546366-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Thanks for your patch!

Tested-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

On Aug 21, 2026, at 10:13, Eric Dumazet <edumazet@google.com> wrote:
>=20
> Shuangpeng Bai reported a slab-use-after-free in nfc_llcp_tx_work():
>=20
>  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
>  Write of size 4 at addr ffff88811da9cb94 by task kworker/0:0/9
>  Call Trace:
>   _raw_spin_lock_irqsave (kernel/locking/spinlock.c:166)
>   skb_queue_tail (net/core/skbuff.c:4114)
>   nfc_llcp_tx_work (net/nfc/llcp_core.c:848)
>=20
> When transmitting an I-frame, nfc_llcp_tx_work() creates a copy via
> skb_copy() to keep in tx_pending_queue. If the socket is closed
> concurrently, freeing the original skb during nfc_data_exchange()
> drops sk_wmem_alloc to 0 and destroys the socket before copy_skb is
> queued to llcp_sock->tx_pending_queue.
>=20
> Call skb_set_owner_w(copy_skb, sk) to keep the socket alive while
> copy_skb is queued.
>=20
> Fixes: be02b6b62400 ("NFC: Queue a copy of the transmitted LLCP skb")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: =
https://lore.kernel.org/netdev/20260819050031.2725592-1-shuangpeng.kernel@=
gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: David Heidelberg <david@ixit.cz>
> Cc: oe-linux-nfc@lists.linux.dev
> ---
> net/nfc/llcp_core.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index =
cac1b5487064d0c5b4966bb6a75aa26e67131049..49cb632268c0c2841e3b44dde124c796=
6267b709 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -786,8 +786,11 @@ static void nfc_llcp_tx_work(struct work_struct =
*work)
> print_hex_dump_debug("LLCP Tx: ", DUMP_PREFIX_OFFSET,
>     16, 1, skb->data, skb->len, true);
>=20
> - if (ptype =3D=3D LLCP_PDU_I)
> + if (ptype =3D=3D LLCP_PDU_I) {
> copy_skb =3D skb_copy(skb, GFP_ATOMIC);
> + if (copy_skb)
> + skb_set_owner_w(copy_skb, sk);
> + }
>=20
> __net_timestamp(skb);
>=20
> --=20
> 2.55.0.766.g2966f0265a-goog
>=20

