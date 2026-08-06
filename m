Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D73BB57
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024672; cv=pass; b=kSy7ypc0iyrW3z9t0T9B1x4RtCnUzp/iAI7MkGwLzyH5DNAb0Hbgl1JaX2IMguBffuNaHe4apf4efyTUN3dKxuvJkQ8NcG8oGjk8Ux46rOwSeOdkej7b60Ax9RMV0TRVTaWduvImIFnqIZ0UiVYHZ0HfNxubtWSVcZvo+TvnxnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024672; c=relaxed/simple;
	bh=2ya3i8zIbAEPcq2JCgLNEDHfkI8cLCbfbam0EgFIsxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axnlu1A83LVKjXQoRKXBhAYUb9QKZQkrqC8lVkjAIUGpMRzSr5RgW16A0lKbvzh0K7NrLBwF4KF9+4h08FKXzZ4nF4IvvWFvZp+uP2Inygc6iW5ZILB2uza1nX4UteY1Vjwoj4WlOcep+BcLGwtHlGhOGxl8igUhwHyfANwwThs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvQ+wrFo; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvQ+wrFo"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-526f963372aso14308551cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786024665; cv=none;
        d=google.com; s=arc-20260327;
        b=FTrJAkxHP9YtLW/FI8uvYImS1v/CnkmcaWcbCkIMCU5zRWeCvUaCv22lLcNWzA+NVP
         NybDKHMaWLUC1CJYxGYXiHwyMAWSExJp7PORHb/t7kOcZ2BtcRlH6wrgXhowkUNPj0Y5
         A2Csxa3cUoEdeEqDMOHT22I7mGpvqlUjMAzy0JymFholrq5twV8pf+7EUQNfR/JJ7Wmi
         zyGX3q+WP0n1Vr+HT6qAeTfozjC9ARmvfAY0+jQDCmlJCRpsL7xCOEY0vXZAWEmKIilM
         bMWJB6D6GCGVp8pIhe1R4ZOHeqhLzJVBmGacsISwOyDHMwIrLAdj3MUYUp0TDAAU3n21
         McuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mr25bz4WYD908xln+GZjqSa00KUjLVD7uMNNkWz1EX8=;
        fh=Lts30M8VImbvDvH0Vy98D6L9eyHhXhhDH1Tj6VtdDJY=;
        b=fb+0ddmNPJJ4bqBwaaXHDQ6kTtuMkBDfCqortS9PQK1lvgi1sGJ+7AtKlelh31SwUV
         LyN0DoSWwGk9uYevwbF7lp+0pxerJX+f1KpBPhhXGsNNdc2dGTzBakwu+CF26+oYl5gE
         dOKJsGUEATTe7vUQ/zVY0ygvmRp2Beou8PlOOCdAtnRtsEArq7da+4AfX9WeJn0MYsgQ
         jXgJWXQ0LN2Zono1iP/Zu8h1460NoeUvvQpjuT6tWE9JQTJvLq0Tni3UoiINuQDPkux9
         1BzNFXonlnexBTWfNzCetTfRP84Jj/mEWbOu1lDrl5m9rB1cA7ngzi5Wg68fYzeSFw9O
         WDkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786024665; x=1786629465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mr25bz4WYD908xln+GZjqSa00KUjLVD7uMNNkWz1EX8=;
        b=VvQ+wrFofl6lK3aqzlRQLMso7TMqtlcoNhlkbgnC5Yeti22mDCRncbsYtQofrC58/L
         7P6FJGBgPZb2nuSH8qgR/D+KT7/tnCnvxpkvRwS/XJtRpe28Y1i46FAaeDlPB0IiZCtc
         Vxm5EnyJf3E6JPPDOq60N1M/nJjqMTlC2njKtQbXfVuovz4B7R8X9HaIy4MblaYIspUO
         X5oXTiVndMizwc7F4FWg1Ryu2v3r58NidvyWOMjbxhYKY7Xqi6qy6XJi53atiWaOQA70
         RdYucKJEGxJWt/vcIRwgBk9yzhYG02IyOJhjpTfdkhvv2bslwyjtQ9OZfE2egrVms8S1
         +V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024665; x=1786629465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mr25bz4WYD908xln+GZjqSa00KUjLVD7uMNNkWz1EX8=;
        b=rZI78j4gVc3Z2JosYw1Agzsdbkg8GTEjOLUNhyvJL+mFAuikilreCl1jQqG2Ns2Xdi
         DFodr8po+wG9NNlsURW4rRvIsAkoGLBFqnKW6571lb/D1F7ZMh5wP5H0T0rXno3Qz/7C
         IrC+gPnFK27SBiAppRMIv4Ras/I4O+rC65HPp0ZMffSoau05hvxvDrItQduiJADjY/T5
         pULsAytcpk2SZse5Mts7JQk65GFR2aLZVic13w5QtdYQlnsjw/n6SgoFUXpyqmRuif6U
         +YyhY+i1mizp0pNrLRPhQSUruWkGmMk7bbV+yIAFCIse5CwwLAtWPexH6ZfFNwt8FB+G
         oLYg==
X-Gm-Message-State: AOJu0YymfD0q1gk/RuUQdIpEvFjzSX2Y5j29WF83jJxFxUX47Las6ihB
	sYEs2mhUQtSf1sTAjx73l3wpiDXP5aH15Eeiqt47fOIyGeXlca499CvL932ZK8Uilq7Pwl1BU5v
	jGTN2ivAMn4J4xjOKqQKqa7EbfD9wD8+uPg7tOxuzn/l09catAT9hXfFgVLA=
X-Gm-Gg: AR+sD11KLF3QjZG+ARhoiqnPYYb9IBCxwL+KWkkVpzbqaG2HPEu2sYbeNNegvlkqjuI
	/1Ma3RpuwTkbDGkBBzc4O+GrBB0+liSzk+yxREjpBuG7CVwQm6X5bHlE4WFyeAzmYaV/IkimHAI
	eP6u5paIR9Ig0CdE2RYMlQnnCpm9XZU/8kH68Fz7hezt74dk1QXsakXtwfF3BW+hFRdKK7EaHsU
	fKN8eEW2XnBAKJFcbcrdujHTELb1h5c14dw66aPgIzKmRLnVzSghnizYKvGSnvFn0Wt0yMjfOYV
	SJ7Dg9t0bCAm5vWRzFX8MLbroM6eNHVBkNDcLssHrdCqsNG93byXTA3zQ01iA/iNRZhy8y9QZWu
	4qauFmoVX9NfphQhNyGxygGPL/FZcWp8E1rUqOyWYv1wxdV7kKPVe2CKJO05RPRdVrP0=
X-Received: by 2002:a05:622a:428c:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-52ce5ff10e7mr166286881cf.15.1786024664059; Thu, 06 Aug 2026
 06:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp> <2175f74b-00c7-4868-aea5-ed9c171c41ee@I-love.SAKURA.ne.jp>
In-Reply-To: <2175f74b-00c7-4868-aea5-ed9c171c41ee@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Aug 2026 15:57:33 +0200
X-Gm-Features: AUfX_myG8SCnGUBN5X8T9tgPA192vjaBFrk_7Cq04bhIr6BKnSomCuQHSJPzzVM
Message-ID: <CANn89iL-ghxRFqSGeqpOfxNnOdyBRO_Nik+6chu6-eLw-wdTOw@mail.gmail.com>
Subject: Re: [bug report] net: udp_tunnel_nic: reference count leak during
 network namespace migration
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:18=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Ping?
>

Is this a dup of
https://lore.kernel.org/netdev/6a632b15.dde6c935.cf6c8.0011.GAE@google.com/=
T/#u
?

If not, please send a patch.

> On 2026/07/18 21:03, Tetsuo Handa wrote:
> > Description:
> >
> >   syzbot is reporting a reference count leak when a netdevsim device co=
nfigured with
> >   UDP tunnel offloads is moved to another network namespace, and then t=
he target
> >   namespace is destroyed.
> >
> > Cause of the Leak:
> >
> >   The root cause is a structural mismatch between the namespace migrati=
on logic in
> >   __dev_change_net_namespace() and the unregistration path in udp_tunne=
l_nic_unregister().
> (...snipped...)
>
