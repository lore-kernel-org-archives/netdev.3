Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963947B425
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157268; cv=pass; b=WPYs1vRUFlCaOgENAEw1mxbQGxZ7nQoucYOT5IEETS++//8s6q5KlPZ/6/4zv3dL3IJuRhvW8uh28Ftm7awCJ/ocG0GTJcpES7TlhjM8lZkcBx0rlfFKhrah9jm8bLFsv0a2/N4G/t2SsBqJ0Hbwo3918FPUoowB3onu0e1gd3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157268; c=relaxed/simple;
	bh=wc1O2F0z8lWFsiTPyh9kT5N/lWUMx7/OaI5hiMgsRKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkRhABkpqxvcz9dPB/XYl1jJ5RLGmVQY6hvXAIKwX5wiQ26lePnqZJvf1ch8U+VASuiQlDtSG73YtP5M3+lnIsN5J2Y8b3fXNJyQgWFN788bPumaEhnrK8rHAPRvsgbfb9Ly8oyq3PRlSgWyjptbOuyot7CYWrnOszkzg1VVpQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7d/IAAU; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7d/IAAU"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59fa3112cso5851531fa.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790157264; cv=none;
        d=google.com; s=arc-20260327;
        b=P6x3+HnTN4BpyCS9+NgSaN/SRIqFPQRNdPTOAEoBGHU5chpgJDVhlL9gBfRIpmp/6F
         raue/Z2HmNRzkoD+n2JwSfPmS5Mjops0QhEKUgXK3PRLb+rVMS81IOfBT40XDruz0vL8
         VW/vFdvKXFk4bBfkXrS9kvaGDdhMJt076UQGnFg3eimwq2NfFqIZjLWrwbKn908Jfxyb
         /QAskU7NxpDSnF/uOlgiUp8IyY2nvrV9GEiyXRvGdSWdsmXLVlQYGc4dJgI+i3Q7053O
         MYM5JiFqGum0BRSdcqNU2sRlD/mF4eKw/mO+sAzj6M2lsMBCmb3/xWHDN2+9JF6lIkFc
         2bWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PMLWAGYLfAH1UCI65dGWtNIDbwQXSVYJuqwk1/3Gyyw=;
        fh=rYvsbcoMKWmf6lQD4TtjyMcyNKbzPNQ/3YnLBMtATms=;
        b=f1VKdWpiFSWDFpPWI07bSmdEmCgzTb6yRYk68iAF2Tb0HbEHRtzVvfv7jl4e1Odn1b
         aZAxuI9R/8cwpfvaPQu5Lv2o/CZXz1uRSzm9ANeZ+Go/IqDl1C1GMeLa4iHrkldu/poM
         K9Yv3mYhpZZIdotzfQfigBYYnXZWNoKYnR5Tj/lkl8rMGkU/+0w3VCM1E/pEmvpoW91Z
         8kHbj25s70Au4dB4Sj+W0HIrUEmHu8apOVeKOdoQosQUwqX3dtNXQlL9GIqNu4oWYEXT
         snJPgFsTszFoEbw0AHTCYayQ1qDU7B00HCu+XWzP4ZZYDrviFgM/4s+arl6eYKi/tsev
         XqLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790157264; x=1790762064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PMLWAGYLfAH1UCI65dGWtNIDbwQXSVYJuqwk1/3Gyyw=;
        b=W7d/IAAUcHJyhEitlEOOERs5jyBIYa7m+7nCsdAX329SoBY+vYVrY+6vHetXas8hZ4
         dWDf8s/ms1j4NCiDOfNuFDWfCgehATJML3M/PguvzSSwinoSGRzdNVVT6vWAHKkm5Rb7
         yFFWPTVfgj24GWEWn7nIY/K1SQXngBnTvDIi5TKYPmNqb0Nv0jXpuw55DPfe8cphoJkT
         7NDniU1eAsdDMLjXOMXwcJa5A2fv6Yj7mD7CHwxoQhFqCe+Dz82ny1OkCcYebYn4iuTq
         fmv+oemQCV4tWQZ29pKly0kGVlMo3PslIuhkkoz8ul4wdYfw6WTxXeRNYqxA4yjJouYz
         R1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157264; x=1790762064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PMLWAGYLfAH1UCI65dGWtNIDbwQXSVYJuqwk1/3Gyyw=;
        b=QdVupvM1cs/nhkZdK886n8vvdLBrPcQlyry7vFidFA2tG4SsbGM5+ptwfAP9FSTrb9
         hvqoqDXEN5j1nnRXotJ+eMFVeQm29eJdzaMdJQP8eTybWuSLEQOxjllt1dnr9Yd4Qvd6
         gr3B6WcDc5Yt4l9+ocEbwo+i0NyQhkLrEI0+7ex1/Ijjrf3+V+HCHI9V70gGV+QpeB8y
         K1kI7SEoD349mCdvLhySuQ1n1AFl1x+MYIuPYSE5BQrb3edfvbCiYnkTE7SKnuWwVStj
         mxrSvidibdIqrTSNDZeE3TBKV0XjGHEw2Niy6JJ2fvPQhlges28u2hqGy0xXnBWVbq9O
         A2JQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHh8e2OjiQNt/262z+RP4eDgmMUrmml6aQsgCuLSmqU+yuH9GZzNCbHLlIZnwox/zZKGQlL34=@vger.kernel.org
X-Gm-Message-State: AFuF++mPSPqU3Sa5Fc4xVa0i0wso7xrZgggticKN0Jbo5aVeR2zVjTIb
	zJRzZRkF0lJUUPi5sIh1yPnGMiMQ2Byd5hlxKUYiB83BkRihT43VEYfCMkgyPUumsbP1OgRg7Ok
	tdkA5pEm2hCcnYCAvRjIhkdjIwWWp9Ho=
X-Gm-Gg: AYBFou0/Imx2RMhW1DyYrIIYAWETBcJFaMe5sUELlqIysYASVTDTkEUj7R9x2DQgo6S
	EEO79avHH9bRCpe5kESTr75QOMU3MW9uugyPRaKdWHxmyND+kL75j9htU8jZomAXo2HsXqBl4Co
	nbX/PXKnZSRYglsEnKs8xrT9kw4gQQpBzH9voL7xxTiSvC5HSSwObKnACC4/JbMWM4RowL4WCTq
	H36CYivF1JZ38hwZx69rYZKWCT5Ux27jupHfYOWY8dMoB5zmhIvmpFjyhs7kSvkcbydI/6q7vOD
	nlrnsDhO8XklK8EgKpo57QnOoja1gGXvA4fvTGOktPG+eupgJmT39SuEvcviSuufJNa8kUNAfUQ
	aqOr8wMq9PTAy5PQ1KSyOGBR6+9gieSNSp42fNU8ANcpIOcSHGOgBAf0HR8AMTYkQswRehw==
X-Received: by 2002:a2e:a989:0:b0:3a4:9b64:9811 with SMTP id
 38308e7fff4ca-3a63063da73mr5351541fa.15.1790157263556; Wed, 23 Sep 2026
 02:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921231856.1798630-1-kuba@kernel.org>
In-Reply-To: <20260921231856.1798630-1-kuba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 23 Sep 2026 17:53:46 +0800
X-Gm-Features: AclHuK8bcr7MKMhnRt06wezWtpBHnYB-y9fprM2zA6fZhUPl-p38Q6W5sP5Ui6I
Message-ID: <CAL+tcoC7Q69JAn5Nk3cL7KwD_vmXvjv-VhYBW0kw+_bw=4G6XA@mail.gmail.com>
Subject: Re: [PATCH net v2] veth: manage XDP program pointers during channel resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().
> A later channel increase can re-enable NAPI and run the freed program.
>
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op"=
)
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
