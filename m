Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712E4229BA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788954; cv=pass; b=TKu2FZuRwqdNA47HHguhp5QagZyLVgNztl+fnB+EoubVjxU4+owJxNsj7BF+K/zofCg9tbmZuOMpunviC3FjY0ZOLKLGf3TJt4aLQogx8RAob4JCHh2CqEgTvd5PIIrevO0n/Y6yt/ONtKavUCv1clcRhzOkqQorAD87KSo9uug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788954; c=relaxed/simple;
	bh=1ALzC3xZSOEV+3EsOPfm97YzZD8J2isZfusepBjqMgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzzTellFrBZDAR5NyE2Y0u5x/VPcywDwpHAgXrWYFFuZAsOMpYuRGrly6NoSsFT42TdPmp/hVPAA+vDWJvwab7jqAKH+9dx8jWUu3OIYZgLjmg+L+0+YTM2j9teiiUADPzrZT4knqTaBjF4fZ3U7ydR2jJyDBnydmi74WI6V1uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZA6Yoyyl; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZA6Yoyyl"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52ff7e275e0so36661431cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788788948; cv=none;
        d=google.com; s=arc-20260327;
        b=NOOa56v44C9s9URnUhUInd9q7FyyeVfT+HJy5iM7Mc/Sb4p0pC7s8Dn9AEhWWjSe3V
         YtyY46cUcBEmsKCrD9lpQ2HrpyE9CPyU08GmemPEnPhm7E93EgfRD1n24fFFqSWTGQHY
         yOxOJhMvezWhFBQA6nAWcuKSgAAElFtdlA/M06G7hLBQkoAoWReonvWa0mC1XvaaWVTt
         kgkxO99KdsUcyJxS6Gwc+4qWf11pLnDHOB59nN9Bib704laIajE633G/EgqsVy5Rocvz
         84OajrXMGpw5bXvHYM7bNv1lPj03VE9NInRakEiO/+nZF3NHh1frASg2CRcCDMSlLvir
         7DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uILcdrU0SoAdAkKVjvs26CkBhU+qBLq7W4x25xRCFg4=;
        fh=1NnR6EbEjOCgTMTYr76v6SSTNxQ/crTKCsNneP4kQ4A=;
        b=FYxParzSYoJY8d9rA28fBw7BA+NNPRlCAP63miTHT5HpLoEF90vjX6ug/hA98kyjUs
         dSOZ49TteG57X3u+9wwRI8GBwK/kibqZQ1S02mbAEX7D8cbT9DlgKRTOoOc6JU+Z7vsf
         Fn+6qHO+ZBN9nIbmvBs4q8bucZlN3/aM+4X8r1yMSXXlCIYdTAje0HWWqi/GU4OgEaia
         uTPlZ6/D3lxpvwlqom62yCdA6pnqRRpz7RAeFukM1qkyVtXamQ3AhUlwLiUZD282fO50
         LCJJ9ek146kL59YYCGggT9X00MYVhGL54nKbGsY4omf3zyqnKGV1BEZ3cDPheRpOX9Ni
         nZSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788788948; x=1789393748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uILcdrU0SoAdAkKVjvs26CkBhU+qBLq7W4x25xRCFg4=;
        b=ZA6YoyylaajM1QpG/1PnzCYVFhIOJcdXJcT4cV4jRhVjmnfpJ90R+1TqJuWU+5acUU
         kZU3Omz2ZMMFXEsCUalejkP5S/noqRTXucuuMbhB0jL6v3nNR2OmfkY+geARkJQ54hAz
         LBIrJUhRc3gVjyGvbUsGdC3F8140Oev4vFjC70dsLjDadYBN68/dSS8SlLBUln1TM3Kp
         KF8OM/VJd2fD/zNmd4x2l+S9nHZjZBVdu2KRopNjz9i0Ihb77+jM8VRJFhOqvHzk48V5
         47WJ1XOQKjGq3UwrqpOKS6g+j2hbvVTB7M7OmTtm6Kr5nQ3EwVmNBRGt5h3OECIHQ04W
         qIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788948; x=1789393748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uILcdrU0SoAdAkKVjvs26CkBhU+qBLq7W4x25xRCFg4=;
        b=S+ETGAHVMdbXkld3QGS3tERSTZiED4s+aM6r3hX/bKOVPrNxHYn6Y8J7dL5XSyjLvF
         ukFJViuPCEkfODS4qrPxIJFhKHJpiOntvqohd/2Xhsz7PzAojWmU9Vgo9KSstmGs4QEG
         EKMRKGJEbvjPRctJ9i+1dwJc6qxxBQA1ndmInOGm706zPrymUdFfszYyYo9vcJ53seAt
         gkfVaQlvs2CYmZljqT6tR79Lg7pD+dS/ZxkzjkrEG9pEg98DggNihoPLWv5SsBEEFsJC
         wgExoxRW37B5yRpmkXzOfKWzIqDbOknooPSQm8niVB2fe3ZfIXeTkPLCkxnYs6MFUsnt
         xXRg==
X-Forwarded-Encrypted: i=1; AKwUvBwguZizsGoKWWR8Gj72IMuOz5a9uzp9+Cd8CpioY1WE/i0V++mA/77MnFUkRklCCoW49DDdjXI=@vger.kernel.org
X-Gm-Message-State: AFuF++mWUVyaW2+ghB0wkfiig0WJX/PjmYs+hT3qArN0d/0mSzZNgc6g
	cqZsLMCxSykCfX1UCk+A8LlvX81YBFhGUwQM+YH798QWcXUBX1IcgzacuAkZd5kmVDr+kXtSQmL
	WW3llcGr2kQbUTjixRfoyPlBAIgwwnsmXIUs0BZ0B
X-Gm-Gg: AYBFou041Pn4OFNGi4XL1QU43ZNET8+sSb+tPRuj8JhnRqOudSyHRaf6E0CQKjK8K/d
	Q10OoaGEbk8ojazMZ5lvaXVYaoW48eOb/YVTnLy7N7vcNYsmLPZbSwOznrabA7UdXQADfibvSC3
	dxGzt3rxt47ClxZDh5cbDWm+/gPGUBeKwhSqC8oLVQIDu6OSlpOnLg3hdixmGxeoXlqhOHnncR3
	VMBZMSopM9+hPLDqwQh/XIJre87F3dETLKdumMtWpcLn5lTOjj7lMMuzDtUlqRhgVaDAierEjUs
	H2lmHSQtEt0sYkRQFw0NYsorsQlv6e00YKtz0XbnCpdhaTlAc8nNrH/VNhQTvRktBYvh8XmgDFh
	myB2tr17JigaT1j3XYWtmGguv2TBQwrYi1DpJq4s1pgyUwjND+F2XpKT6CA==
X-Received: by 2002:ac8:690b:0:b0:530:430e:8126 with SMTP id
 d75a77b69052e-53054a4add9mr308890841cf.47.1788788947628; Mon, 07 Sep 2026
 06:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com> <20260907075846.2913645-8-edumazet@google.com>
 <20260907133452.5266-1-iprintercanon@gmail.com>
In-Reply-To: <20260907133452.5266-1-iprintercanon@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 15:48:56 +0200
X-Gm-Features: AcwNN1W2yYD_evs531Vjsk_UBK3lXGYc0y43m8iEGfZC3zIlO1l13YU3HBlsZ1w
Message-ID: <CANn89iJZYFSwxV0MdJOpLrTDj2pj660rxo1JwbFe7TVTP1k1LA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] sit: dynamically allocate struct ip_tunnel_parm_kern
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:35=E2=80=AFPM Artem Lytkin <iprintercanon@gmail.co=
m> wrote:
>
> On Mon, Sep 07, 2026 at 07:58:44AM +0000, Eric Dumazet wrote:
> >       ipip6_tunnel_unlink(sitn, t);
> >       synchronize_net();
> > -     t->parms.iph.saddr =3D p->iph.saddr;
> > -     t->parms.iph.daddr =3D p->iph.daddr;
> > +     t->sit_parms =3D new_p;
> [...]
> > +     kfree(old_p);
>
> At this point in the series old_p is freed with no grace period: the
> synchronize_net() runs before the pointer switch and only covers the
> hash readers. ipip6_tunnel_xmit() doesn't go through the hash and
> keeps tiph =3D &tunnel->sit_parms->iph across the route lookup, and
> ipip6_get_iflink() is reached from iflink_show() with no lock at all.
> 8/9 turns this into kfree_rcu(), so the end result is fine, but this
> commit on its own is a UAF and breaks bisection. Moving the rcu_head
> and kfree_rcu() here (or squashing 7 and 8) would keep each step safe.
>
> Smaller thing of the same kind in 5/9: check_6rd() gets
> rcu_dereference() but the rcu_read_lock() around the xmit path only
> arrives in 8/9.


Yeah, I had to split my original patch into three parts because our
sashiko 5,000,000 token limit was hit.
