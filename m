Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC663DDAFD
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124758; cv=pass; b=u7RdxlfTzg8Pk43gtt74RAsdTSnsMW7Wehi5+3gUsjNvkO/esL6Bx8stYq3VWw8Wlc6aCLs+CZB44T/7iiNIU0nN/l40Iqu31lxYaBNJaV3YDqipjkYZracwd8chrZodWiVoQ4sSwPKGFlCCmMkVtJUdoWzrZnmtbJ5PTT2uiV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124758; c=relaxed/simple;
	bh=1LhlVc0dwOktw7FcU5KUy4x5+ciiBEKs+bfj7ahAw6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=julF92/eY4FH3Qzw7MdyCvZFM7cgD4wYqaGok9T44PLnSh6V5gi4ZSuoIUdyQop2ZOX1QYgN6Xis3jZfoCqW3aadURrlrY52R23XpGaldHt78eA0qWPjOf1bCQFuCXrCu1+FB/B4VN+ATnfwzUo3RwD1Q/5UtcwE3JyIBEurHBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsXOwvEA; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsXOwvEA"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9309d4ea213so67211685a.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787124755; cv=none;
        d=google.com; s=arc-20260327;
        b=N2cuuJpZXa5RFjMPyO5H6265hInmuUf8bw1uWSJ4+IDACAkC2LZBsmkoSqdtQM6uP9
         YOTUkbPJZhg39OWHiZrdYeflpL6F9FuiYWWdOOsSiss++mn2ls2oC9QOQvRgrQYtkVJ6
         5KMjyKCS0W8fP8Ny8rZq1rDIMvxWCPr9qxZQwwrPhTn5uUCLI2bM2mVuGZGW0kUj0pnw
         VuuMNjU+6iSXWTkG8EpBP7QHDcV13PENWJ7wJo4AFDiw88MKh2decgowL9s8v2blVurM
         wSC0VVprEgrAh74rMAvx6G60JeeAkWfFSERrrqY+kLPsGB2kzi02/ShsyPrfNLpzoOit
         Kipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bo8ts2uxNx+gAjtIBYXiurmZxvzqaLcfg3nJ69Wa0c=;
        fh=41oZSbWxywZaOx6xo0T3KXJZERkD8y7N7spZ0k/xt74=;
        b=R88tRIPmNLsr5yZI7MrO/pY0x++zbC4609ONn60loQJOorKV2/fh1M5k5o5yjh6R9/
         TLePdVWl/9RgS/NZjVpsanh0eOsZXhHLkpHQ+DIRSQZ66E7kA+NgmldZU3hUPr9RyKTl
         1qhe7C745eCBi1u6pBCizDa75gH5mbUKj9yhcccqmU9bFdT21ThhMlL/7fEYjlTI0kx9
         aVck7hFQq4n7TUdxfwblaoQk4JcWLMCTfF17+BotIosp2P4Ed9fVdCywGF/YrxtQocUy
         N8uBMHJ2y0yf7iQ5PsF/qG0qJKLHNkNLRGxWsvz3r2qzHTWt00xUFaZLX1WEZc5Apmo5
         UFUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787124755; x=1787729555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6bo8ts2uxNx+gAjtIBYXiurmZxvzqaLcfg3nJ69Wa0c=;
        b=VsXOwvEAVfuYwtSIFdWTb+WRAFYjV4Bmh6WN8iE13VA6Vxuppb+HFy9rXTSK7AszdH
         dfxHiuMej6ZgQvtm7uajZclMtGXlsCTKb5x77YIwPmke7mppSaQ5znf5nql3VgsaOkcz
         tw1TEd9f50O/y5+1uf3/Sh5rHQyjuEYizuY7PoT36X8VHY+lmW4utxgFixfVp6C2osKj
         bcPOt2fIrS/3QcruxtzTZKM31O8X0tMpD456wCBe0unFlTjqBjilOBFd/QaZPd1G+q+P
         cba1hoFSegmaL23x4K1neFOZpH0bnzqXQrUIKDhB+R8B8UpdOKp0cMyj+xf+tRNEBvML
         EW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124755; x=1787729555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bo8ts2uxNx+gAjtIBYXiurmZxvzqaLcfg3nJ69Wa0c=;
        b=G+93cGz9BPlUJh7NbUojmQgDxi+qtKx/4YB+JlYUKGy2lcbcolMGNEJ2WS+dcygrDG
         cwHHeljgbt7SF9Zf5NLr8zzDbLyQHgY4fF1pdc8Yljq+ZaRaBn0rh4XwVhN3r6O3O3eF
         Bkd2uGqAPPXusmswOh/zF6jhHtT1awEDmrtz9IZLFhMvGL1E7iXDWKwtrnSptVSLEu0y
         IdUfT8vs/CB75YYKO7N+x0ByAJnlmH2ocri4jly9Gyb3NO4ntFHDJCUisCig1C/ItSBd
         k8sdmMTHBY+q3Hi2n4nA81b22ZkOm58XXgnw+Uc01rkDhQ2sq3QGINkkZpZtel/e2rMk
         fIpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGSVSbUUj4xu/9SO17Jhx4yVI+pVkx0aDmrqt2/pBd1zgk0O+hhxdA9sZxDW9j+7woPV6wYLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPpxIYHTnqskxOeQAtkH+PLFOMA2FiVxw/v3XUE2P5P0jc7/n
	dXqCRDKBcZ51XKRi5x9fmHFKj3zc1h7Ium08B/JcTJtaarGH6QAnuuEyqLsspu/Cn0yRcF4XrN2
	Z//TkhErGW+g7K51IlgbYKQPwcWbh//1TbbPBB5It
X-Gm-Gg: AR+sD11C2Ej9DX1Wze5JGMu79N8L54urlu4sRcbxR1kbFx4savpQoI5Nx+XhHW781AI
	9XqxwewNuDfhAoGvMng5i9K9BEvJ99JGBemUzpoE2TmTGrVuF8+xQJhtIvg3e3i95qvXS+Vr1WU
	ka7GGyKJf2r9uojhH/lnhhhWd6KICRl/HTVieOQ73t5Cl5n6ahC0ieB8fUJZZPHbl39g0D4eIeb
	EBfCkhZ3z/GLlKr1Ms+coBfbCcEgj4CFe3O0xpFzLRMQhgQ9IvGZLYu5kcR9T4jm/Dlw0VHhhSA
	pu+Nm4A00P3oQMfvUQ1iipuNsVcW3e0j3FSEGSxgoKmPq9EYKTJfimsYmFF+32PvkRiXZUKx8A3
	osV11O/gywj5+acfKRnRATcqZW+nwIumA66yPX6I/2Hc7tgVftOFLVhTZjxk6RXnDxJCecc1VAo
	MWhKg3SV7Slagoc4U=
X-Received: by 2002:a05:622a:1247:b0:51c:e6a:1b5a with SMTP id
 d75a77b69052e-52dd578f0d2mr23424921cf.12.1787124755006; Wed, 19 Aug 2026
 00:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819062224.3197349-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260819062224.3197349-1-shuangpeng.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 09:32:23 +0200
X-Gm-Features: AcwNN1UgIaSp8yvbiP81Wa6WdXyRGospW79ercIDWGBnnoWkucb-lYgl8VMVu_s
Message-ID: <CANn89iLioNZ6cVBCpRDYaoHYixXrxbVt=P6DbUNoZPOgxmK60A@mail.gmail.com>
Subject: Re: [BUG] net: ipv6: KASAN: slab-use-after-free in ip6gre_tunnel_xmit
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 8:23=E2=80=AFAM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> Hi Kernel Maintainers,
>
> I hit the following report while testing current upstream kernel:
>
> KASAN: slab-use-after-free in ip6gre_tunnel_xmit
>
> on commit: bd5f485f3f026225b86573e559af0b7254ef4184 (2026-08-18)
>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/63aa087b3e843c7a4e98a42c0f130aeb
>
> I'm happy to test debug patches or provide additional information.
>

Hi Shuandpeng

Thanks for the report, could you test the following for me?

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 200d0ba1a40e71a4245f1b153dc30691e773f8c7..678678fcb5da395f8b1c8243562=
efe8addbda2ee
100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -878,6 +878,7 @@ static int ip6gre_xmit_other(struct sk_buff *skb,
struct net_device *dev)
 static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
        struct net_device *dev)
 {
+       struct ip_tunnel_info *tun_info =3D NULL;
        struct ip6_tnl *t =3D netdev_priv(dev);
        __be16 payload_protocol;
        int ret;
@@ -888,6 +889,9 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *s=
kb,
        if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
                goto tx_err;

+       if (t->parms.collect_md)
+               tun_info =3D skb_tunnel_info_txcheck(skb);
+
        payload_protocol =3D skb_protocol(skb, true);
        switch (payload_protocol) {
        case htons(ETH_P_IP):
@@ -907,7 +911,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *s=
kb,
        return NETDEV_TX_OK;

 tx_err:
-       if (!t->parms.collect_md || !IS_ERR(skb_tunnel_info_txcheck(skb)))
+       if (!IS_ERR(tun_info))
                DEV_STATS_INC(dev, tx_errors);
        DEV_STATS_INC(dev, tx_dropped);
        kfree_skb(skb);
