Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781A255F28
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355430; cv=pass; b=SgR9/m2dKK4Jykg2v5M3IAFI7rSZHehX1oBKKh49Su+Y0/zfYdGVXZ8id8dKdNxMXMkhX9p4lWi9fNPslSjcPg0pxCOuNvXuW542XyceqTn/JXHR2L9dOLQYcAdkiUC5XkkiQu/k+TaYSdvstG1D8tjJuN8ZUJE47TBek6nGL8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355430; c=relaxed/simple;
	bh=uRyKGo+5k437biWqflvIHrjulTS/Obu8ZJjaI6DBRJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzdFEDCFy9a2//YE4Wzndo7Qd4KUkA5QcuHG8/7h8o28w1UPXPeeRlsHq8g8KWXR74r6KWMdrvsrlCZmsw5cXKfZW2ERTyCEBqg04+15cWEsiVfTNKpMnw8uZhq2MyCHoM3uw5x+jO29u5EAGmp4UF+hVIB4Byi/nK5Y86JOKaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNdiC+OQ; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNdiC+OQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1668236a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355428; cv=none;
        d=google.com; s=arc-20260327;
        b=CiFs3ieTw3ug1Ku8Ox6wSVT4veecRHV4gU7a43rGHQswuZDkUdqqA6bRC3bbcijA0a
         /f7tzJie6pD0qwXiJA2d7Mla5zynSSbL3chMMRMzybhshGqBsqRRflkBELvVLmRteiF1
         HA7WAYAe0fp3tVRtRIV0W7P2HuEYn13AEx0FBsVQ5bk7Yjn3rQzw1WlvBh9tNH+7KxL5
         Slm3j4mrHBrtnD+kEE7vtXmN4X0XtIW9fx1sFkX6ACIBZfqABHme1Nbbf1GD3FK3Swuf
         s97L1AYjPcwpX7661F/NRSKHpA0eNpiaJa6QVFREbBaUcLuEGywdXH3nFHIcTc2ZZu5Q
         tLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8xNru+eEgdeJYIFxdnCN5gPNC4NZvZ+zrdgq5rjOVV4=;
        fh=FVrx6nm4oIXqPTuc3b0OjK0CrF2axJ53uHcuKSit3oU=;
        b=iDemjjQxC1HEHAKE83VTfDk/6IPZ9RwBPCDfNAlwwgQPA7jkgy7pKEW6pqDHfu9ksH
         N9m0AcqJs8nVGvLrLQqHaLaqXwPspNhh7wESDAolfBYbTBScKdfDb63LKGbINPTb/X83
         7hac2USLIl3cVSP8XzGWQ1x6EHQt5iBdKm3BhXg/4obNstGZOIfTtIUh6GPVVQKUOlnM
         HrvuyxjrC16J6O5Cas8GbZOCMxEfplXkQgKC3FOQr6I3otR72CcbCVjU5r8Lbvj0/D3F
         kFzluCz6GwHtb4UjVvgb93mIMASOxb17lDwYJm9+XBo8Nd5bj2yiIF6ND2ixvugFopAj
         LTnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355428; x=1783960228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xNru+eEgdeJYIFxdnCN5gPNC4NZvZ+zrdgq5rjOVV4=;
        b=XNdiC+OQSWV+fodWmugLdzD6YXe6egcAVU00HwzZAQkWjff+RWYu08KAc5wQeKxTro
         TVauLKeCPJRKfz3ChH5ntts86WrYsudTaAh/FHB01oqg2LzzZDsCQFkYjatPlDsTMkPw
         A1rDAwbZlVzLTdKIH1m1dqhTt8oNhcE7Fcnw008V6w6s7sqd9TU2VUhOxxY+Q3KMUQJZ
         aBPDhA+IGc9rcexCyXUzPtWdE1NE8PhBDSxHkTyFSdoSSeo5cBrDClUWB1ZmxPZUUqN+
         zlHQsvoCfvyrdcPUvZgLXpFzq7avU4WM4n/hDXHrvdwXDNtWEqwz8svQpK97G4NUjZKD
         fJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355428; x=1783960228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xNru+eEgdeJYIFxdnCN5gPNC4NZvZ+zrdgq5rjOVV4=;
        b=rn0N77VTPapDjtrrKclR24FptTbrA3wn47h9azM+wkPlXT7V56S8Q37+waVfjJQnT2
         0Ev4gqpsiapa11QGd6r7Jzp0rQbiMji9ruk2EYsxuC9uEEup/Y0A3yhB/rxMBpo6YcBu
         pDmBGak1OQ0r4ZKz06paW9EW/xeev9166ClY471cs3Xjczzz56MVYGUVrfn0h+VbScHz
         ifXy0WeEXQ3HLGHGooq5GIZJD2a5R8VhMFpHVc74XbzOTjZ/6dhAzv/Y5ik9sEFZqefo
         5CA3ODYypCHamUL3k9cn8UAgHHa1nh6X84aey6AAFbKhgfVtHYBhEmnRLj7gt4h+JeGA
         1+UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1j/0P6XHhRt0ZF2aEf1f28xtRIVAbI8uNGxUKwJBDnxtu4wHJatfbBoIlGeMcNzOL47Yr+e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34hiG/x6fUVyRJOWd5bYcNSv2KnCuQM5Siaa6LVD2Tzak2uYP
	kcz4t3N3fq2u2G0KZGPTrTEeBhZ96lr9QIw+hQvaLIzcnDf6p70YPJ0d1NED9eDKp6DX9Eu+pBA
	mjlc90KSOvALKw1Xa8/hW+1qwovKHpHyznSSO8Cak
X-Gm-Gg: AfdE7cnqQN7tqLEMpWDsHFb9c+4g1iHXnwbTztMz0C1U9TkWFkvgZeoymBr7Hp3s01L
	FuCpPPSh1pRtNJOlN4X50N3MOmT+X+ZLWVoBWt+7Vvyqz9IZrK6j9gGytKqCCbn79qC7BeGXsYl
	IFfspYT1DfPN4vpbbh07eWs7e8YfYVCqUYZkKZWweT9mVuVK+PhWuopUh+ME1cBQJjeQNwoN7Qp
	ZV/TpDI0RgZ6EkUlIKFb3HrwSPPU2RDcUCLkeePt4H/S9ZMl18laGLwAuGsnLXeep87kE3dgu4p
	YqVO1C5gwXm3NlSjOS5PWVxnRQQDRAV/N1zzhE7/ERSvMOCsR6eV8q0tU5g7ZC9HSVe/oKJkDdc
	1IVHbQXvEaDF5YryTUg6Bo7uP0NRq7rAjQ7oa6Sk=
X-Received: by 2002:a05:6a20:748d:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3c08ecc4cfbmr1691690637.14.1783355427949; Mon, 06 Jul 2026
 09:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-6-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-6-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 09:30:16 -0700
X-Gm-Features: AVVi8CdZNSiKzLi_2vOhlbue71SshAu6Xm36ETjE6rtPSkQOTNPwKp7gqa_HydU
Message-ID: <CAAVpQUCA8v+vaV-TdjdEvh=4CqbavO_=WzDm3EHJwrrdz=-JJg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 05/14] net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Replying to Sashiko review,

On Thu, Jul 2, 2026 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c477c4f84ed9..48818a194fa5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11608,8 +11608,13 @@ static struct net_device *netdev_wait_allrefs_an=
y(struct list_head *list)
>                         rtnl_lock();
>
>                         /* Rebroadcast unregister notification */
> -                       list_for_each_entry(dev, list, todo_list)
> +                       list_for_each_entry(dev, list, todo_list) {
> +                               struct net *net =3D dev_net(dev);
> +
> +                               __rtnl_net_lock(net);

---8<---
This is a pre-existing issue, but can this cause a use-after-free on the ne=
t
namespace memory?
---8<---

No, netdev_wait_allrefs_any() must be done for all netdev in
dying netns.


>                                 call_netdevice_notifiers(NETDEV_UNREGISTE=
R, dev);
> +                               __rtnl_net_unlock(net);
> +                       }
>
>                         __rtnl_unlock();

---8<---
Can __rtnl_net_unlock() leave items on net_todo_list and trigger the
WARN_ON in __rtnl_unlock()?

If a concurrent thread queues unregistrations to net->dev_unreg_head,
---8<---

Once RTNL is removed, yes, but before that, we need to revisit here
as mentioned in the commit message.
