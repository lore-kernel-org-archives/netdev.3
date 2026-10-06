Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C80280331
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280732; cv=pass; b=Nj8lggd+8YXXTq52D0E080TOHN37R8/jZCGznTsJRJ8w8lAYMJzylxKhPCk6rh8lmWRxIw5EeYN4L3cIirkDGhh9vuVFT+1v8w/704NP8je0FsLHCRLJNsxLkTy0P5qnOnMlQk2W3phBK1j+XgG/xWXVUUwJFXwS/ZQwudOmLek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280732; c=relaxed/simple;
	bh=TfgIkUJeKpRApK4VOrWPIGRugIiFcyG1Fg1a7IGEwM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpheINs7iCynnqOQIBGCai29ck1hCqBWMukyCMaOGwWo2B7j4X29uKzh3TECIzE3VjQNuV/5mCMU8Wo/fKXAOYVdolE7X9J8qnt+5ZxdbI3ybfylYJeAiOnWD7dJpTgqDbCFSgVRwTZYxMFKm+4qCFwyI4zUP2jIrnC0o3Y1Frw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=ONudnpbK; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="ONudnpbK"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6aa5d092211so4357680a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 02:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791280729; cv=none;
        d=google.com; s=arc-20260327;
        b=GXu6bw1T53Mzrv6F61E6IrTZnzHAQWb3I49whsE4mSHpCP4yMi4y6pUCugsbzPgvY5
         HNQFvoYkXTqmUEYU4uyfOhItrQNi/tGIzUOdH9p2ZsI8cRCs8Mf34meSGnC6Wx0azwd0
         LrjD+9nf1nvnH0OVL+YAZzLSMwvf9X+efuUFFwony2bWyELuoMwIyoutRVb2VPNpRt/E
         hSSqLDHGA1nCI92Ul+1K+vO1MFpD6/QSPu1tRUVOIpDHTHVMnToypmayvb+RcYjkGuIT
         e2ZYpIa9vIZejr4FtqO4Lpv4VUG//DAAJ7Ms91KKKVq0uCfvbr7A4qUeiGGGGyUIgBqC
         5wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfgIkUJeKpRApK4VOrWPIGRugIiFcyG1Fg1a7IGEwM8=;
        fh=CvCSsd5d2VMhhWGA5b1h776+y2SxXZC/+Cn3jSRzaHI=;
        b=oVhraZj7+h4BcwpFn/3MPAwuUNIMR2dXqM+LUxkPUTs/FAjGfdhCwTYfBbmD7s+4eQ
         /j5jWPSQyUwBTGrupUKptqTwH54XxadHHHDcCuWm7MBxaXD6M+wAxxFf5H0UQXNkG/sz
         eu8lIfPLD4A1m6WhGECpRPhMZVExAdQlIByjmcI5t8t1T/XwdZjJj5DrP0qfkcjAH/6c
         eivNB6C/1wKTNfckW4d+KgbLnyx1NEY36uiXryRuUSgycyUPueWylXog9v6VyVncby/8
         S+i3sUtyUYwVgqkxu9DcsRLNY9VWyL+JuUBal0H38znQRlmYBZunCDoN07oQiJoaTmUU
         qugA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1791280729; x=1791885529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TfgIkUJeKpRApK4VOrWPIGRugIiFcyG1Fg1a7IGEwM8=;
        b=ONudnpbK1Wyc/dClYap/PNdxYSDb83qMycBufPqBIdWAC47/+mDXpZzmFvm/mcVkXq
         4XsMfOIkCWLd+OCCAS3161iW+E+XNlBUFOt0Xk+Mhkf0l3ywtA9lzQoTCxyRLqNQ58II
         45ivC5C9Dn/03OKQwzg9mxDac4pvj/zotzBPfBauW+dskY10aOe5MQstIU3Yb5LaVBfy
         8tSjEd6+JI4o8Jn510IM9dZh74wMJa9+oNrjfGuF0iowey1ev0TjE8hz8gTRvtKNGaKF
         NsPCjSAmzztx9PFrFFzBqEPtgJXDA7Lbf0uwhzToGrCdrY7TLQHt/H39GizLOpTHiFQd
         cYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280729; x=1791885529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TfgIkUJeKpRApK4VOrWPIGRugIiFcyG1Fg1a7IGEwM8=;
        b=wS/NkuQP/L/XgUAMkTPLmytm8+NyXs6zs8FPMosa1lxnrYeJIDmXhSR4QHEdNxrc95
         d4r9/1hCSMqS8YHPY702Qqk2oGor+U6oZfkC6/6cGNa8TAMiDorXPNSYsiTdhPuXrQ+5
         Q4uuDIG4HruG8flPpIfrFGUrmhU1GuvggBLgRwRRzwQGYBxBqBRmuT7JQMwRSprVWOnF
         BumztgutsQv9nbCm23UwikQV/EUxlN38tENUM5/2g+oi6eJBS5CCJ3jtO73xGfFjb6Za
         u/zsk+e7+FB2nDoMVNNc7OHZeVip/oTxk9R7XXYpGBdWjbvyy1Vq0mL5J5+VXezRTxl5
         G9VQ==
X-Gm-Message-State: AFq9FYKP6To74y+Nro/NcNHRQKuayoxdBzOouqwogQleVSoIB+vpBlCW
	p+4JMe3vBCA92jhkBDu5RRjrSz2OeHGhqjPIRoxgdzlLF8dLgAlIop82yv9Y+J0tTdno0fVFpja
	3Rkoe4dZU0WiqA1ZW7WFpSDWsD3b8zO8q4+QkQ99voQ==
X-Gm-Gg: AYBFou1Bq+iCtyEsE9RaXEdz+vEEts+v1k4x1FeP/n4cD52rvsFFv9eZySkyzlW16bY
	Q654XGj1IyUEFyKyItltdV9uyKBxULHNrS6yxzYnVoFinjFXUTAQLRuqmoRIpTEGGbQP7fhDMKf
	fuPfX8CaKuypvS1ucnY3Xcf4hf+qPfWskU8Tdh7Dh+xvvreYRCv9dqz0o4ALcJsO0PoKsndP+lU
	7Z1YPP38KLmpgGiEHh1+114W56SQBhP1qU8c8+O3RfcLbsklkMV2CHTlqCIPHF6N+nRL71j+bU2
	gUgL5h7wW99TjN+h+/n94QYx1r+GajXJycAjYMSlUbxG2UtGEHxseEgEL9zebwr5G123VYWM
X-Received: by 2002:a05:6402:3549:b0:6aa:f02c:dd96 with SMTP id
 4fb4d7f45d1cf-6afad8d08e4mr8967181a12.11.1791280729128; Tue, 06 Oct 2026
 02:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002143529.3217189-5-koen.vandeputte@citymesh.com> <20261002204825.29726-1-sean.tranchetti@oss.qualcomm.com>
In-Reply-To: <20261002204825.29726-1-sean.tranchetti@oss.qualcomm.com>
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
Date: Tue, 6 Oct 2026 11:58:37 +0200
X-Gm-Features: AclHuK8_i_YLch736XQN-K-YuwwwRZKZlCpaSoG3oZTOfBCg2fSHBzTivHWJVdY
Message-ID: <CAPh3n81CHtXXozrkLwubTkSuZm6Qk-PDWG-=07JHcacCDDNQQg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: rmnet: optimize rx handler by replacing
 skb_linearize with pskb_may_pull
To: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com, 
	linux-kernel@vger.kernel.org, subash.a.kasiviswanathan@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 10:48=E2=80=AFPM Sean Tranchetti
<sean.tranchetti@oss.qualcomm.com> wrote:
>
> Hi Koen,
>
> Unfortunately this patch only works in MAP v1 configuration.
> In either MAPv4 or MAPv5 with checksum offload support, the driver needs
> to read more than just the standard 4 byte MAP header.

Hi Sean,

Thanks a lot for checking this.
You are right .. I did test it on V5 also, but got lucky here that
data was already aligned by nature.

I'll check if this can be fixed and submit a v2

Appreciated!

Koen
