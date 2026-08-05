Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307244AB99
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935811; cv=pass; b=Zp3Hl2CZgmm0uUYk0CvAvmvyZRdbneVicUDgDRqF69HY2kj5OFM8mXQAw5gr5bzm+smBj5hOXd7/t0IoUyiu6brOHYxk+d5xlbmqpcvdkokJZLaSeVDNMy5eVMFVObp6nsvlxBUCl0Bexppy9C3FHOlH3LdbzkHNA8AH6ZrumOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935811; c=relaxed/simple;
	bh=aBpkMAErz9xLWm+5C4b5hw1uGikMUr8SJCzx/zsbNIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8Ng11sdUBgDEqYUeTNNP1OxL4a2S2mx/Dywd2mUoHjgbhLoVuBrMdcLxP9zDYLQ1WsddoyGtY54wYebzU7s/hXmECFzQzs2c6Ylh6tfFrvHzDQ0Hq32ZMGWtrrSMKc+H2JS/wAsXLKFgno2M7kobKNKPbcBEJ9nVxHGZcCyquo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvB+8fzV; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvB+8fzV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e67555e24so49262185a.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785935809; cv=none;
        d=google.com; s=arc-20260327;
        b=G/pYT6xtM1YWtLhTrj4v/yPCF7RKyk21clXh0I6wPmXWHIpJtqX8SgxCiRC+lV0ryf
         h6OETkHJybjAJ6W74Ptz9omx3EBjTmcfA2aDJg3WVlB7GVS2VKm+uYH4/IyWndRD/gPE
         LPCB/mzeIoz+tPmqAet9XjEfISx+0UjNwisdf2prGVFzNqTADU/bBJauLo9bkOhxFPoF
         WBFLrSFOi1THxvZD51WNll4fKe2poeHoU3HFbfBgiPtEYEQZdso/9ucQm5w0JLxMkrsw
         XsEqS0zid/eK77qWrnNbLU4HpkAw2U8+1rXb4EvXpUe0o/NitxfTG5yUVuKvB2hH6m8R
         KrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3VW3rtpjVbYzcXhdZM1ja34KN5txqmfzxnSGbOqfdhM=;
        fh=77lHxESPn+gg6TZbOkK1oXEeN/UnyhwOUl+ukBJdkA4=;
        b=Zr6jomK5N/Va87+90yZJSN2KqgP3u/np4JBh5OmCfUL8Am6jYeNI7/oLXFh1IpxHcN
         nnjhTHkSMpDwGoxgAnguzS/fgpIM2VNmhx+Ns95/PA33eOiixc7QCEc8u0dt0Wf0QMeX
         3JnG+7EAwQ/M+KOzE2sMVaAgRwyfbWXaGetq78IvE+SRCOn/l1o6SsMIAqxicbXyxq7K
         XsjcNp6EJojL+UAJcBvEQuTNDeG2PUveHAt/CMqOYVU9uZ0B2wKQxaDNgsajWoFDe1eN
         yrPbjOzdTC3bLWbzpYhrYngKptgPfTHIytBIBgtthFJwCnA/uf75svUFUTWCMhoyrndX
         VfXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785935809; x=1786540609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VW3rtpjVbYzcXhdZM1ja34KN5txqmfzxnSGbOqfdhM=;
        b=qvB+8fzVNLnGXfkWol12B/9ytYK+XNNBmcnb375NbIdbW9TmAmSrnoimKSjfgaB3J6
         H4AWmERFYckw2RlbNxT3YkhuAyhrpsZWliygY+mgAiHq4lA6Ijq7dBYq+ueGSnETn3Gk
         jQ3yZIsVzDo8h+FadZGJL0099R2mG27RngNFNUfzIoQXW1AEKeewhRAP7bOtAKtbzZDb
         g9kE9HsSDJrtUOG0o+nUQ5B3YuLulh8ePFH8tt9R9ZstTCMCUaqmopf/4RjpBx6PyzyG
         4AEzCZKYmtXbvnoMJhdjAWGNmx5+AdCyVvLXwAaL9iKcP3EXjSc7Mt2m8felrVDs+ATp
         7ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935809; x=1786540609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VW3rtpjVbYzcXhdZM1ja34KN5txqmfzxnSGbOqfdhM=;
        b=Nqz7OGdCRg/cc5gQgBrHEJX3g/2enfb4lDkj+GN/D7Exep/ZEjFFT8351YXBlvTa0Z
         fg0lvyXK8j5AxkwShaRSlXTVWjfBrevW998h1NqyVsKbhRAMCzdH1OB8swMhHsyIwMQT
         cuHEqSiXmShTMf+nD1Ual6JXNXIA/5nu8ecZ/nkTLhLcUNvd3mNVaYWeJRDCCHE2zW63
         EYB+1nhJkBssIFERRiJtMv03T0+9wZosBay6rh7rzjsn6Px6WEhoES1dMX8eqn1xv7dO
         5wlZZ2fLW6XLDDwxW4OAy6RsdrBD6sA4y7+RALcdcTk9NIf7/gR9T5oRlDWCel2uUU++
         jDKw==
X-Forwarded-Encrypted: i=1; AHgh+RqmAlwkKzB9So86UJ1rytQFsqlo9BLV1vDyf2fabPnyuMasBj9qa6EsBHslyruE4udSbhyqQEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIWud/oeG7jJEHT4nsvunnRsZdZsI7FmYq4lHtcxLv+49H6yH
	Bg9WKvm+i7+ec1/t0jS1gezy5o6HGg28huDvJWgQTiuGEyDhygCTORSxOVyj5/fEpaUfIQiIlnb
	NLQrx/fFhWzrg0DkoyJye2HIWu3saMMQxiIfjp9OM
X-Gm-Gg: AR+sD11dBwjtlMjFPaHUVtijSqOd0Jif/MAZYVJH5flDlI2VfXMgAs0fjq7yMf5sZ0g
	8/MKmuRWCTuMjLAotEvke1/OTGz6+QjqpbRbc1D7801D74R9q6O2H8lqdq7Pr0yaPGzGEUgx0L3
	oYUwjg2ZuLbCRp8YgUg4WNNZSsI3tWwMXrLb2dCBxB/5ontNsXR5s7qtlZJWb4vXM81hMbZ/Gi/
	YqWb1C1BMgb2NV1Ekz1AvkTpXGNX/HV5zNItH3ut0+TfpUjijezEPyP9tYyrwT6XpO3XsrOwjep
	Yurtd2DfPSV5iR3yN0WKid0+33yscKcfHF/t7M+9haWfKsxYefIZsw/ig1oovoviuihTx77aM5T
	Dl6Jrt9lBNQ1szGtP/YICK4KUEwxDs4yihNdaMTz3EQmwWr/5quWwKiw=
X-Received: by 2002:a05:620a:a408:20b0:92e:57ae:3a53 with SMTP id
 af79cd13be357-9364909fbdfmr468584085a.9.1785935808512; Wed, 05 Aug 2026
 06:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803061739.134737-1-jiayuan.chen@linux.dev> <CAAVpQUD4X+TpL+tTc3Gn4Uz8Yc7qbtXHA=u=UHjbhbXyt7dxdA@mail.gmail.com>
In-Reply-To: <CAAVpQUD4X+TpL+tTc3Gn4Uz8Yc7qbtXHA=u=UHjbhbXyt7dxdA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Aug 2026 15:16:37 +0200
X-Gm-Features: AUfX_mw2YQ1PSAvuhk25ZciGhmGu0RWkiDGL6V3Ba9Q9c4M7RyL6bijDGfMfvAs
Message-ID: <CANn89iL_NQq02FUfS6rT9+VRZ--UprWdBp-bG39T4BND+XcS7w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix TFO max_qlen accounting across reuseport migration
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Sun, Aug 2, 2026 at 11:18=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
> >
> > A listener's TCP_FASTOPEN max_qlen stops being accurate and lets throug=
h
> > far more pending Fast Open requests than it was configured for.
> >
> > This only shows up with SO_REUSEPORT listener migration, where closing =
a
> > listener hands its still-pending TFO children over to a surviving one.
> >
> > fastopenq.qlen is charged in tcp_fastopen_create_child() when the child
> > is created and uncharged in reqsk_fastopen_remove() when the handshake
> > completes.  The uncharge follows rsk_listener of the request the child
> > points at, and inet_reqsk_clone() has repointed the child at a new
> > request owned by the new listener, so the ++ and the -- land on two
> > different sockets.  The new listener's qlen drifts negative and its
> > limit no longer binds.
> >
> > Charge the new listener during migration, like reqsk_queue_migrated()
> > already does for queue->young and queue->qlen.
> >
> > Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets=
 in accept queues.")
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
