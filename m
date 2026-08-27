Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F3377AA2
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837601; cv=pass; b=GurY6GoeaqBghQVn6Hr3Zq+bpB10A2pp2OiiDsm85e2/VyX3ej/Fnk1yJIEtmSAMxu3nNnpsy8eZcodeMfxGIAYbNzNuz+VqYqclWpphkRYkUlgk8DDVX9Q2qUDjk4rlOArb3AJ8yFRnc6CXhcXxvph+Pw/aDMxUAP7ot91pNAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837601; c=relaxed/simple;
	bh=Z0BUfO6J0/D9ZNvgHXAnJmtCzKc4H+18t73WEKcd6fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCoSTPXIzYgCqV/nXhYhV6L6KexUwAJX9wTiGe39wEGlmWYROxzvilZDkFxFepBsuVkb6+8wB/YadCB3iWOOJIWWQK/tbjsssSdSSFaFFw0pambFj73j5yxPwbA9XSD/THwCNcibeuRHTowwzerAeNv+17/6D605DXdJtgFxvnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3EaDUBH; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3EaDUBH"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52de178a66aso15270591cf.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787837587; cv=none;
        d=google.com; s=arc-20260327;
        b=SX5eAtHGLiGkiht/1M+0i2F09gZLe5X+WtpkL2anw4lo/XdGm5uAmP0Nf3V2iKRZQH
         B+D5uFwHakhUfPN+AOzhiXQgB5WJu/v6fFmWeRYeg9MhUp/Ce0Jr1CrgHFZT/Fsz7mKo
         uOWfmVxjV3jHzdcSV3XOviETp/C57ygELtrq+qlb6kNpq92Hn0p6sglfjKQkxWSrZ/tY
         SSR/aeZumAPwydSfBxeL4vp5pmvBs7wxhKTIiNbv+kQ1cKG7Aw/3p9JtiVERLCqHhzaO
         hLaItPfzAWDVy0Ho3ryzyPpnnKutsrAcirGVWUEvr+QkjQtTPILsOVnjFO70R6z2gkXw
         LOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TPXhT/cNmuvLcD38iQd3+f5EkAYP1aCkwHKjXM2QWsQ=;
        fh=8WsSXCTFUCIDTjqOOfYTKkFgr38V577P7qqUUg+tz90=;
        b=lBN3ISzVFKbnX53FztFXz5dAWdsB1NoR3m0Mae2pssDhu7kHzZr7pMnZGRXG1wJKq8
         PKIaC0hFA51WvIehN4jHAqPmLB9RTQsFlkJ6mNNDpN8OxxhLaGfApVhESbaYOX/uM3pC
         M25jtuN+4ErrokebWNlvLNG1kADwNw6lB7YGrBWgb/4YLSTlgToSXvROMpxfTfbnRBww
         p77xBRxBfB4nczywbksF1XNPxgU2LKXR098gWQMVkqQ6Npk1Gdme7vyQPwpnPelEyf+d
         J5xYooajHkAFhnpVRurjdvszg0L8CkWyiyVUKafdHyC6qzx/9QyK/2Dbzk030fWpjj72
         B3wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787837587; x=1788442387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TPXhT/cNmuvLcD38iQd3+f5EkAYP1aCkwHKjXM2QWsQ=;
        b=A3EaDUBHuaVjDfpQTzfxNZC7zU6v0NALBISylAsdklGHvfvxYuoYa71AFG1CIE+osw
         BJiLNFrhrU6mx6ygkvTSD1aYsxrox1XnoZYF28oJWHYNS9TzUZNg9gvEFycGFZAlFTvZ
         QVf/A0LhYvswyRsthy1W+smPF6TOT4MgFzMGv2kDS06LA69wWs0bR3h8Mt0YqApf6aNF
         0j6M4khl79uF62zuzYk62YDRbRSHGw5EDDD4L1KbhySBnD8fhRJf5dC2OmLM22wwfQDB
         6sKdhippEKeNK3R2JzsjrTEeOlZsyp0LNaBNJzBn1+6oUQT6d+ePtjEti84NswtR7VP4
         HlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837587; x=1788442387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPXhT/cNmuvLcD38iQd3+f5EkAYP1aCkwHKjXM2QWsQ=;
        b=WLQbxGxzDGakFV8c7IeqTzpyjsM4fRzjbehStj2E5tofOuBCjfPZ2E2l7F/8wlyUQ1
         PXv5Pl4UJGIgz2NY6tRnf9eRKtcaq6mOYZeJnChB8m/7eIpnM0dNM8vvlhTEpaXvFcdK
         RPk5dWknyH+2eZJbcxHC9Ld5EPlmoFbq6Ke1AFnD+yZXV+PZfRZd0VLklcTtD7j0jukS
         jH/5K1MzRyE9Utcvk94A5wATPdTFDjrkoHGbMLgb/ScKuml//fgy9t3KIcsPiJk56Xxp
         1NX8q8W7R9IwVgBJZaHHMgzDVBs77TR/DzzPadb4OcRlcYV+lc2wVCkvIzYLto9McZEr
         iJ6g==
X-Forwarded-Encrypted: i=1; AHgh+RpHhu3ZFM21CcUe0U8N58KASP3jOV2wA4lMEc+yMvhXCk+pwcbojjkDLZSEuw+13btQw/E+2h8=@vger.kernel.org
X-Gm-Message-State: AFuF++lXNdN4f2F4K/BUONyj2RTFCXe3Z9aVrase8CXYde8gRZy0JFvu
	M0CyFGICjIcEAbkzAEQm06ePgOJg0Ol3WCCq6hvIHPC2bF/lvaWL3aSI/N8bzZouCVGnsFCUTWH
	w91eWDnoPRhYVAIRZtflRhXt+L/9Z2NsTpaJCLBk0
X-Gm-Gg: AR+sD11REwbHTWpQeSR/0TzqZT4obb/EYZL2xqtmyY4dvsKWl1o10q/xYAeiqqIILdj
	DgOx0xZualuJd5gKkMKdLUGFB/xvE0rC0lOAl+JqFEjKLzXBXKJmhmyNj9aGzXpejifhpbmJ2Z6
	drEOsZ0lcjOuUaFEyESf4EokULqDGBXnnPrw6T4U1YGMD7C6btIP9l/AyMXQG6C1NX3CPiBnKTD
	+oyicvMo0TQqnVif45N69yghW99EmKJhPemASdRpNgEYTwyZsoCiGks0IN1imrv4zjJFbo9oL/p
	efT4s+ro5eQFOnvAq8kyMzXdVsD1OeBf4LiTGZFzpY3zlDfDE5TcYPDMYzdoscfYAejkIKYPKtr
	bsi6k2VxEcpZIIn/bUt23oBkCh/0kw55mhc2bUdemzrlQaliOIylVjMK7PCc=
X-Received: by 2002:a05:622a:5593:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52e422cdf9fmr165432141cf.17.1787837586225; Thu, 27 Aug 2026
 06:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev> <87a4q74rrg.fsf@toke.dk>
In-Reply-To: <87a4q74rrg.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 15:32:52 +0200
X-Gm-Features: AcwNN1UFHwjzPa1MzfktU0Iree-PWZZeotNBaKEOr_oEpX7vLWfiqFmBagJlnXY
Message-ID: <CANn89i+-SigypyE=66gnwxgz3-T7mBkWb1+UNDQCYOuFPmN2Ng@mail.gmail.com>
Subject: Re: [PATCH net] wireguard: queueing: preserve tstamp_type in wg_reset_packet()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <kafai@fb.com>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ramses de Norre <ramses@well-founded.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:28=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Ramses de Norre via B4 Relay
> <devnull+ramses.well-founded.dev@kernel.org> writes:
>
> > From: Ramses de Norre <ramses@well-founded.dev>
> >
> > Sending traffic through a wireguard tunnel on a host using the fq
> > qdisc fills the log with:
> >
> >   fq: likely mono tstamp with tstamp_type 0
> >
> > An skb carries a timestamp in skb->tstamp and, separately, a
> > skb->tstamp_type field recording which clock that timestamp came from.
> > The two have to agree.
> >
> > When wireguard encapsulates a packet it calls wg_reset_packet(), which
> > clears the fields that must not leak from the inner packet into the
> > tunnel packet. It does so in two steps:
> >
> >   skb_scrub_packet(skb, true);
> >   memset(&skb->headers, 0, sizeof(skb->headers));
> >
> > skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
> > monotonic timestamp: that value is the time the packet is scheduled to
> > be sent, and the qdisc still needs it. The memset then zeroes
> > skb->tstamp_type, because that field sits inside the headers group
> > while skb->tstamp does not. The packet therefore leaves wireguard
> > carrying a monotonic timestamp labelled as a realtime one.
> >
> > Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
> > skb->tstamp if not monotonic"): fq used to assume every timestamp was
> > monotonic. It now consults tstamp_type, spots the mismatch, warns, and
> > falls back to treating the value as monotonic. Pacing still ends up
> > correct, so the log spam is the actual problem.
> >
> > Save tstamp_type before the memset and restore it when encapsulating,
> > next to the hash fields that are already carried over this way. When
> > decapsulating it stays zeroed, which is right: an incoming packet's
> > timestamp is a realtime receive timestamp.
> >
> > Fixes: de799101519a ("net: Add skb_clear_tstamp() to keep the mono deli=
very_time")
> > Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
>
> Seems reasonable:
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
