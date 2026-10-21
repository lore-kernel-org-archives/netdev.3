Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792546613;
	b=iU3KDO9EWHC5o2chnbKdlaWGOouzIL8j+fzR/a9UjTNrZjACAQjGzxWFf3VwZKnFo8nH
	 3hmKC6u8IHL0j+QYXBfqxubB/oBTECQl6DK2LTCYOW7FNncfH/QP6f/xBYvc75use4uST
	 CRx6Aa3DfEA/iA4cNZOCj6yAgKtgX0K4BS5y7hCKI5SXBRI7hSzJ8aaaisCqEiVjpiNiI
	 Eq265CuyfMu1YmP7nG0YoCuNwyiPxoXQ0Pb86wdrRSEr/IgNTdmCWNU0OBHksNqjaZe93
	 qmhtp1MTYYxgQymK8iSBwXLB/53m0PviqZkKAn147onVhx4u2Aht9ydi2/XEbAoPSWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5OiGzEJ/rC5y6SpPA+wKkOBW4YgT6eZO19/dli43l6Y=;
	b=xWtiY/ZvCGkfPs8RsJAiJRfCoTP5ua8zDNf8DEOr0NtjuVMLhmiLuAq9xGoPHm6qE3Yd
	 XgH1oTmGmfjV5gfpX88YAiBEQBaozxjq//h17gDqBC7KK6xfU8XiexQds4U2rzDgxHsN9
	 o3dGAfCsPrswz6xcSK4cmQXYAnyCDOURPMvlPKN0o1XAI+lK5A8ed89ZEmzXGBht1UeHl
	 w16qSZoDHQ1GKX7TxNnZJee0igLZrbDzoakJOCnTK/BozBK4cz1WA4H1HgR1aSaZbAJLJ
	 WpU+s29YscIyXeeHt5ECh6OzLOww2r++CL6MFUopLsQqGGMWmyLYZMRNa+n7yLKZBMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lKh9mCuK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2F606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A2F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lKh9mCuK
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be3b2f17c1so2265e87.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792546611; cv=none;
        d=google.com; s=arc-20260327;
        b=n4L0KY/YNyhB1num4OM5TNvLoUXvRFKvZT4xBSA1sz1U/YI9Y/4MlPLE8K8fVZWNZw
         1HtIqTuC002H3xN32oFdLDt9Ap02d9oiACQilNCA6HWO/vfrTSK8oVK06ZsY6+o6rp2N
         2arHF6mU9GnVdd8IEJmLE75ZFVvg6JvFqgc30m5I8+otvrzIBerksp6Wb4i4aJYznZn/
         vlqpR4ZOV028khp4jMQ1dTmSSHd+VlJijfh5lcz8K4sbrS7i2FFZXrP+2uEztZ8ESDsz
         YqY+7tDkMltvmtFIVa+b/JpA6Fz4+J4OcAwjXcQtKVM6kqzEBmfpqfkV9HDbN53St0Qm
         xD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5OiGzEJ/rC5y6SpPA+wKkOBW4YgT6eZO19/dli43l6Y=;
        fh=e4YPJZoQ3QfG1UzRrCt0zg0COv8tmvctkj2+zTd14VU=;
        b=NGSZBdAmwIEIuQJJXAsX44NzUZ4zudvAbP87MiQJIRsI0p4QdFcZ8g/KjHurypqnXK
         a6RuwqXcFAUBn+vDXmuj95UDP2MAHWBUrZRlRKw0XVqllGLurVFx9/TNdRylXu7Egtlh
         DGckY5HVRul3i7AS+3ailC796lMyaxdhWXCcChe61YbHn45j9RJU2J0jDjRTsI4/Phau
         xm1bbsth6jPHLps9IgrHz552cQWkYDJpSjN5syMyRApFgRaFlObFO+NX+Ajf4Uia90z5
         VwtZ5CJDWsBX2egRtk7LQK4gAf4cY6Q1RpRREGjB+lDiKLO0+SuvHkf9tVeA2keqqP/L
         KrOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792546611; x=1793151411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5OiGzEJ/rC5y6SpPA+wKkOBW4YgT6eZO19/dli43l6Y=;
        b=lKh9mCuK+yM1+mHy5aDnG1mnthsSsEiaXHI9F3l2kXjK5510ES0M53VNV1GIhCC3Za
         LJT1Ym7uNexFUMc4EYhqpof6+YgTUZ/0+yCwe3R8Oq2SCTB8UYQh60vczUkhE0mHmFUq
         wZMei9N16ZlWXvanOVfuEzedBz5rniSDGVDcoFFB3KIhzDRxZ+h/jA5K5eW1lAk7KUR0
         h3Lq1dYDFCIGITpgtSbFzSPUwEBSTHnV9EsfPN3GLRZSYPLFp/Gd2KhK/XWkbGqlHfUy
         PGx2zBrTeQ64dQBVjud7Bc7gCZ02arLKcmYkX1HyuwLQgcmuLiB9BvLIqWL51+LYaYJE
         fLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792546611; x=1793151411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OiGzEJ/rC5y6SpPA+wKkOBW4YgT6eZO19/dli43l6Y=;
        b=F71EehBhCrbXlvhdDCQcamIv38EpewUhqXnCBdhgTCn0Gv1wLgAW6GyjTNSGKwBS5C
         aKLxHwhHRawgPsBl55rXMOPlDlFh6K4tkKMWwOvXk85HjlLcKKw7myVyTIK6J0hQT942
         ma018WkyY3ncWmiojqiGQgW5/TqDbdUCLT+2GtRgAwTKDYwLJpTrozMzkCJRozwzSDjd
         b9JNV6b0roN9H8pAk5Zby3frsqT82F2vuXR5kuyh0wSTWefIBjb4LMPaQXKroWS9orst
         nYhTXv1XaGSx/msu6yrGVuKWGnmjjgNeKg3d0ovMrwxZ/7Pt9qlGRU6kUywAlUsJ1uBj
         Xx4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwAI7j71RJzqYk3wuynG/kdBEmWEOUI4nyZ/6ooh+2FXgEeUQ6g+iWoVx+jlkTNDdHDiBtQkBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEbtAQScj6I7e9y4ekItpRDLCyi9oIZJK+P7m3iX5y9dvjUf57
	IogO2JA7c7sQsmkwVGjeHMnW6PRIXFYip3XfxKheELWJSjRDJ9dgiX0SzPAUYYtvRN990q0GZCI
	1ReyUDgEzx9BjABQs1qJ8loGo1g+7tKZ1z80awtwH
X-Gm-Gg: AYBFou386ccSdPd1je0QZXhm5aYEfcG96Ukiwu4qsUux2sM7U3rekzRskuRqCYkwMJd
	RZEyNkajr8OJJcQBW9BZC+soFekAJfnpYfD6CsN6I0/dcY3HN66oEqC/hKr4HCpgjD8VKEicuI8
	CfHwyW0BCKCzxOFrug617Lin/JX4OBmJwQ5ZCj0sUly2at6C3d2sWLh+5dGbBEijaIycQr2K3IS
	xQxDRU9jJweVty3xHhsJ9yljIMwpa+632FJPCbOYriMgY8GFTUIacO/4jXmj3vXfi7W1IQWBnC6
	DlNnQn7DDqi7D1B8Pt3lh4wZMbi03uywgL2oUMoKqOn6BnD1RNJW4Gi0fVfE8yfHaFhdVOw6LFV
	/JL8Yw58FxuuVdUdYOXmgjpk8Zx0nLf8/hVrEyin/GevhYp8Zo+No00g/+lOHumxQjSuf+a4Sl1
	QwkqzmlfXkvizZczE=
X-Received: by 2002:a05:6512:3044:b0:5be:4ed3:95b0 with SMTP id
 2adb3069b0e04-5be661e26cdmr259957e87.5.1792546610966; Tue, 20 Oct 2026
 18:36:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019230758.2960779-1-joshdon@google.com> <atbsxDZecXYSDBqH@google.com>
 <willemdebruijn.kernel.1d24f2bb46330@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1d24f2bb46330@gmail.com>
From: Josh Don <joshdon@google.com>
Date: Tue, 20 Oct 2026 18:36:39 -0700
X-Gm-Features: AclHuK9NwCZA2eIFwebashV2SoBmSppHm3CCgMhePHvU5eY9n009yihziA0P72U
Message-ID: <CABk29Nt-2mHiVfZekq3vb2=kOf0Vn8k2S37EqTLhLCJfEbpYFw@mail.gmail.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for udp{,_v6}_send_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:49=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Kuniyuki Iwashima wrote:
> > On Mon, 19 Oct 2026 23:07:58 +0000, Josh Don wrote:
> > > We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry program=
s
> > > to monitor UDP transmits. Both functions are static and have two
> > > callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
> > >
> > > After an FDO profile update, udp_v6_send_skb() is now inlined into
> > > udpv6_sendmsg(), while an out-of-line copy remains for
> > > udp_v6_push_pending_frames(). The fentry program still attaches
> > > successfully, but it is silently bypassed for all uncorked sends.
> > >
> > > To address this, make both functions noinline explicitly for tracing,
> > > as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> > > Add noinline_for_tracing annotation for tcp_drop_reason()").
> >
> > Unlike tcp_drop_reason(), udp_send_skb() is a hot function as
> > inlined by FDO.
> >
> > Did you see how this change affects to udp_rr performance ?
>
> Yes, maybe I was a bit too fast in assuming that this does not
> meaningfully affect performance. A tcp_rr is worthwhile.
>
> Or, since these functions call ip(6)_send_skb, which cannot be
> inlined, perhaps a robust obviously free path is to attach BPF
> hooks to that (and filter on sk_type and sk_protocol).

Thanks folks, I'm looking into Willem's suggestion as an alternative here.
