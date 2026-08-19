Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937E3F2113
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125713; cv=pass; b=rej8OQDZqYviKmylm1ZYavqLZtAr4KXfr3KYp5/n6Rs5lVk2iAE2g78OY9KyDVe80O8/lNwT7E2TdWfux4efKX+36T2NSxmJY3su8LFnQBnnGdezPnHeoL7Sm705GFHGHPUlHjXj3TAmS9kg66hilgdtOGODysJo5Pef9ljr2TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125713; c=relaxed/simple;
	bh=2BAe7W6OpUvj4ptW1kz/B6OcD4IsQZBqUZaj8aMteWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtyvQEmuuFJKu9yvsoH8dCcXOvXoUGnUo4XwCwzXEdg2jIEaDy8KpwfZ8Iqdowv31Qnr6ou7QD7/fx/XcrKfx6QYeVII1JKSJoulFVW/TlpyN9ERNlQF+aVT1pnxGY2Lk0MAgjMLfxhMGxOwald9CErej5MoaooDHYYgpLBg0w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8kEILwF; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8kEILwF"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52cd38ddcdfso4341051cf.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787125711; cv=none;
        d=google.com; s=arc-20260327;
        b=Wt9Clph4r6BmOHHkT+5g9N1TYqOTGrAVWP9xiFr00Lki7oCvvQBb9Ia0b6LeAzbi2Q
         6/Uk7o+ygnHEIDk9ZNwN8cty5qEQCiDM9cll19WfDxYKSl4o74J7eEL1uVDXk2mZEiqR
         MWW9spn5Uw0Psks6qDTAl49z7Gn+TDmtf0PSp6xl2L1LqDvDnMYqH/7kbjq6V/TJ2Dp2
         fDWz7FEUAkr1yXnqie9SxpPIOvmP6nysYxemAYdJ23SEYOc3rIIwNEwsYh2K1LU7zDMI
         XpfMaBV3EuUI9cWq3ShEHnrCP3eqt0oRXktV1s4OhJXbYdnsxXjLBfZAjF7bvuU8JNoW
         LDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X0AAFuTc80Uwaikl2Snr7zZKN7yn52mjvtgyxxbS9MI=;
        fh=vrq8cyFJg3vmlaZI4RphmZqN+LkxzumKqddVmbn76Uc=;
        b=XPaMjWjMV5MNnLlTJyE0AZlDjJRnTC2jDnYF7ZjCiIAK0CO4+YK76l+dqZgFdDBaIB
         07lgRA3Z/F5U9BQNR5gFag/xCJOtlZtTS6YZWMQLJ716nXlbQw/G5OKVrv0QqtwwLSmV
         Bb4X/rLdNPvw/vRdNNppkr+licsugkwqDuNzlY97bb8AELh+KzHcVSL8HZqhDM8fSYAN
         8jBtCCyw/a0K7ovk2vTkI2C374kJmusDDXWsqXn/omm7hogWCA5o6ODtCOvP7dUqbaIb
         Nbz+BZ46PsIXjfTmL6DhOScaRhthqZjib9QYORt6pBjgGD0HjpfIGLcGFBGotqq1comF
         W9Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787125711; x=1787730511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X0AAFuTc80Uwaikl2Snr7zZKN7yn52mjvtgyxxbS9MI=;
        b=G8kEILwFCUHImG1O3u36u7FQXxTvIieEWqktQF6cfq7Ve2jpZrPGeDGV+4qfysdOBJ
         saTWaOB++1PmghW6qJdAUUe4MW+bEUl2CSDVFeSDjhNWlKwZEiSwQDbo7cPJ6RrgV/8g
         iqdwsf1CvEzeTXAXBx4CDCgb4GHI/mR20bbpt/gO0Ur8evVPUIyVciM044VnailIiuZW
         8KstE/WPmlFKewecPqqaJhbkaXxZb48ubjK75SeQHp4f4RF/yHPlroly4/Pvp3xhXegJ
         LIqIscJxdYTwCzXTaJu6S2tQMEjyRZ2OYZ4FR2NFGk6V9gJ3pTQN0zlo8O8uTamgI7kP
         oPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787125711; x=1787730511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0AAFuTc80Uwaikl2Snr7zZKN7yn52mjvtgyxxbS9MI=;
        b=Ax/5AqxZfxwzatbPsM25KbflkNRGtPEgUSeByXAzS4YcwLBIjeF4Gw2jmqSrS+U6Z6
         sOtEeC51zuYOwB4/qPB/glSsG7kJCzhHc6uM35O/We4J50g2Z+FZLQNoD9jKmwTwTZOM
         nHzRputKfmSBmgVmLpfANGQc8MtG+/YcSiLu43j3s2+FcCZLnvvjLsMId78mRM7EBLUy
         9y424FCuTXMRHADhMP+nPq6OGJQk90G18nUfTW+LoQ2zMGHqZo0/dWn7gqcUy/obBRdW
         pKfRsepao/UWwY75we6lHrgeKl3way5spqRep5XTUjPvkPx3wRpmTNDxucL0WSC60Uqk
         ARGw==
X-Forwarded-Encrypted: i=1; AHgh+Rra7DufF3HAeG4Nmac6oYl8AXIh/jWldJOijLPYhmZMcmlXFG2O23kqsWX6H+u4J+tKr+N7HRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNYKOD8kRWJNDeF+y4Vln+oLEGmw2sYHNvq8U+RE8aHXqQQwU
	UVnT3r8PWdlAUc4RI8MYM4/4vBVKHxI0rcawWszLkRD77vbR2s0nZbnLdGEepc5wKQRcTYgZhV4
	yFroOxmoIBRr0W3eIB7C+IvAvb4aKZC9+6PO2eOOHiCi+FBpNz7juGyI6uPc=
X-Gm-Gg: AR+sD10Ks6fPp74f/U2HHHhSvHn14syft2SI0mKmdxlGfFQqb/sWSb5JsCp5qIB3JEQ
	oCoE+0oaD+x/bah2BTt7Jgs6WwP6QJNsPm54RD4G9KIFt8lSJI8Ha9FDR/xl/LvVo+ihQdW5vmF
	9pBvXkJ8hVavEBnVC9VE2m+UiXAih/FE+CWpe5fLWFeXhjaflPys09Dt10bTQX92siPTsNpjKxM
	7BC/au3pdcIFDz577H5enZqeYdCk1lUksLztv3BFProtyl+xBRyJLogM9Cyzc/UUcoNqg7awcpm
	J7/+1SEa9yxm8ZoGkcNuoPhNw5rhfvljJqprkFpC70tTKs/LhLUre5X7HVV9KU9w45BszRq9+mk
	wkW8ksl5KPBU2i8grXpKJ4SftA6dny6t5yH8XnhwcAVurYAH3wAspGxl5nLXB+Jy4s3BV+PQqvB
	JFt85HoUTQnKt4jds=
X-Received: by 2002:a05:622a:481a:b0:528:162e:29d3 with SMTP id
 d75a77b69052e-52dd5cdd931mr22514351cf.32.1787125710173; Wed, 19 Aug 2026
 00:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819050031.2725592-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260819050031.2725592-1-shuangpeng.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 09:48:19 +0200
X-Gm-Features: AcwNN1Vpw90qqb3J8EoBm6ha5_Or8qEMqxARLr7SDwaxYI9pi-np6kKRz7lTCFg
Message-ID: <CANn89iJbOs54esoGSukvMiYnXQkHadnC7NgQanbAXOeiHXOsjg@mail.gmail.com>
Subject: Re: [BUG] NFC: slab-use-after-free in _raw_spin_lock_irqsave
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:00=E2=80=AFAM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> Hi Kernel Maintainers,
>
> I hit the following report while testing current upstream kernel:
>
> KASAN: slab-use-after-free in _raw_spin_lock_irqsave
>
> on commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40 (2026-08-13)
>
> To help trigger the bug more reliably, we applied a minimal diagnostic pa=
tch
> that only adds delays and print statements.
>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/f7dab4725e2a2d57b1d302714c93c549
>
> I'm happy to test debug patches or provide additional information.

Thanks for the report, could you test adding one skb_set_owner_w()
after the skb_copy() in nfc_llcp_tx_work() ?

Something like this (untested, not compiled) patch.

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b5487064d0c5b4966bb6a75aa26e67131049..49cb632268c0c2841e3b44dde12=
4c7966267b709
100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -786,8 +786,11 @@ static void nfc_llcp_tx_work(struct work_struct *work)
                        print_hex_dump_debug("LLCP Tx: ", DUMP_PREFIX_OFFSE=
T,
                                             16, 1, skb->data, skb->len, tr=
ue);

-                       if (ptype =3D=3D LLCP_PDU_I)
+                       if (ptype =3D=3D LLCP_PDU_I) {
                                copy_skb =3D skb_copy(skb, GFP_ATOMIC);
+                               if (copy_skb)
+                                       skb_set_owner_w(copy_skb, sk);
+                       }

                        __net_timestamp(skb);
