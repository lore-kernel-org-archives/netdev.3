Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188496;
	b=T3vnTI1ZkIDjgjZcJD2nXAFuxTZ5M6I5cYmG2Jk1b8+fZMMp4AaOPa1bTHO50mtnZBFF
	 NIW5bFf7+6esHGXhyZ58G6Yd5PIPhPELU9CCsOZpaiaXJalCzOpvfo3ihcue/ah+np1G1
	 TNSOt6rHULxQHPja/Wqc+SvbUjP709IGGp6C2ewPD/fwdwhPx39UTY/BvBPcm3PVCqXGc
	 ykLe8nWoDCUj3raMvEaEW84vDEMjkeoTchFTgCU/T8pHgyUdCwdPrhLqizS+exa+v1/2k
	 gDw+WKK5LOWhQo0KWK9wZDKgz2CSzLTJuhKwWEz/cWCGjOhQ9piJzuxm0rBuMZ9Ydjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
	b=vhH894HrWt2CbEvFozUi9gYMxg+VDZP8nPLeplPlmXhusNnbjml3vpzMo21sgQBKtgUh
	 S+rldqAXjMETx9epSu6dh70LDfI8pz+8Lpq0VqQVmAtX2/asiDt/z/r3sjjJSW7JHBu3v
	 DZwj9eNoN5zm7IiZPymCxTwNnitYtztqF+Gm+PTWUantq32wFcQ8RYlg51wK5uL0e1z5b
	 b2/mFQf2hE3C/jtgXK/eApwV7yBnjUGSwA46c2L7Js1KDNklLtIrx2bgffAbJaiSMJlj3
	 +Hf04CHPelf94mOfOU2EBGwhcVqw151NmML1mtTULt3x7YOa9Kmz/qZP1izZLcxo2yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GepBUTsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A13606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A13606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GepBUTsu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so449010b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188496; cv=none;
        d=google.com; s=arc-20260327;
        b=pBUmUMvWbtOm50xxPV06xwuQdaOoCujBd7C4QONWRJJtGF8QPpUgKbZtDBeXKAUPIQ
         B6p/cSu0vpIKGKYC62b1WuQ173XsJvkp4nqVqIYlY7BUqYuRExT83oTCWHHihoNU8wip
         J2X07+mYV6nHKewNg9uVrYt0alxpgrpPADTeAT3XTNpU6q9wfymN3mLYgYZKVdVAFA0Q
         39x7OIEB+Bz+0eiXyhwPyCp+tdkmJIL0NhzxOcM2jf6p+9NsNuZmg5Qvv0frkO2jSAxs
         y9tBDGu53TU7HM+ps0pCcF9K/y6PZ4F9F5W1W0DXMdSQSECec1D7hJtF9Lt1YwdQ5svG
         C8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        fh=K/Z+t3nK6ykvJCgucxGRh/1E5hJkpspq/o+AI6VWlLY=;
        b=sAESafI2qyPM7+B58Vu/GW0zVH2Y3oFNrv+bdo/OjyE8fix3kVy8bQEZkIm5SICVhq
         oxTTVsd5vZQJzysjTfMz36Pa1cWpudGjWj5b6qA77qHD2SQ+r9V5x7WrbpEs/+cwGF1H
         G3fO2m9DsSV6d9T+UoeLtEPKoUQba58U6s4+q9QrpCgS4FypYf30KOx1e9Arikb1h0SB
         JTqL93apqDCOeQhwF3OhpAufLylxDql3/IGeqkHnGBgbryg4F3duC5rRfYNu2FLue3De
         MRi5x04mdkHAlEQOYgKHKfBmIM2QYzu6NtnH6fhMadREPrV0yM4neM6bNz1i9tmSfOIm
         SY5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793188496; x=1793793296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        b=GepBUTsumw8B4jf7+5KsVIfO5khMkRoPJ6+MFUMalfeb4q/FoMETrLQTAanFOOmnMz
         Pqa8pZ4flYMTlyMDol2VB4cEXZ3yBtiPuZpBMkpM/MRee6V9hj6Vzn++AjQh7Yn9u5VU
         8B6nCqi2CkM96kUhqxa5KQ9foXclVftX4roG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188496; x=1793793296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        b=rhEweiAx8k3pfXgWxCIG9mqUV4rDpskxXORK9xdlHjgjtym+nH+785zYd8uwlxt517
         THlHGq3Tsak7K4ex4b0tEi9i5mrrI5UzpdkPuoBLFqs9+9QB1seCfPaqmrWW86Wp9rAz
         SSG9/EC9553BsNBPB0U7VFUb7a7EzssKTZiYCDCr4N5MO4otV9lqf0V3iesfnI9UN+Pv
         PsNshUzYpPFYwcHpjHg0DGJwDSkn826s/LY4LxTIoogwojn75UOCawX8p7I0NBCqhP0c
         8mBFXbD1x7axsRig3s4Il+6NJoVhnp/tARvxKRoQeTgjIeJVLs46VaI5ZimeeuTlXTpg
         g0pw==
X-Gm-Message-State: AFq9FYKkpT8XnMHSyMIMLSEXAnrrgG6vxZ55x1R6SfBTehLyY6lUDQZP
	JAmWhrj1w9hCbdQPORn1RBuKZGInbei9knjmSwlCLjBO1Fcyrjs4J9uu5rosuE86lMYBCzCylYV
	2iFbots1Q9g0IKiTLPH8OlX441Db3j+rexPDtiavDb6qgyRRzy1Y=
X-Gm-Gg: AYBFou1mXCmiurIDTXEieb4DubHkjw12Kag2JwF+vs30WFcksFTlhFQiTW1YljrocxF
	kFZpKqPhUGpta8vQGVJAe/FfPdIVG6VcDp+p+WYHV90K7Q5i2H71PAjiF0LAmKZI20x/tggQmwc
	kGUAT42Yf9KqQ/bueSEYjJEyy/JXG2TyMjB1uVJWF37v1teLIYfz1wiqx2WybhAqXTu/X/uRgfZ
	nJVp9PtV4df5I73Y8/o6LceHwi4JRIstykcT0fcv0xD+npPM1LbH/0jc5bk/k+EfKyZtP9OsvMw
	wVWuqQ41NrfXVJCcwa8bKfVbAQFVFkyVYhukYOBSJJwLnHEEWev3uRcfdDMLiAgYZfnMr8beNnR
	kWYrCbD8VmpbQfkwWSbqgje3EwO1RTchdieTS3byrVQ0kZi6AL2MKlJ2Js5zmKsAeDlp/VdyHgT
	Kuzn8aPeyIesm2m+s=
X-Received: by 2002:a05:6a00:298d:b0:8a0:4e73:7e1e with SMTP id
 d2e1a72fcca58-8a5a61d5a21mr3166982b3a.44.1793188495937; Wed, 28 Oct 2026
 04:54:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
In-Reply-To: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Oct 2026 07:54:42 -0400
X-Gm-Features: AclHuK8FFpZ2c_Jj5uxJu1FiuE7Oufyw0mcohrzYGLVHSyYoRc0o8GsFlrm80gs
Message-ID: <CAM0EoMnuCin5C_ZJa2Mx+VT9CFSEznG-9hWjkBz7=Ntwi-AUxA@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, David Ahern <dsahern@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:19=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The issue:
> This is a follow-up to the short link-layer header fixes[Link].  After
> vlan pop_eth, a privileged SCHED_ACT BPF program can call
> bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().
>
> __bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
> only that mac_header < network_header.  It does not check that the MAC
> header is long enough or that it is linear.
>
> A SCHED_ACT BPF program can do:
>
>     bpf_skb_change_head(skb, 1, 0);
>     bpf_redirect_neigh(lo, NULL, 0, 0);
>
> after vlan pop_eth.  The skb then has mac_len =3D=3D 1 and only one byte =
of
> linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
> __skb_pull():
>
>     kernel BUG at include/linux/skbuff.h:2839
>     RIP: skb_pull+0xc5/0x100
>     Call Trace: skb_do_redirect -> ...
>
> The Fix:
> Drop skbs whose MAC header is shorter than ETH_HLEN, and use
> pskb_may_pull() to ensure the Ethernet header is linear before reading or
> pulling it.  Re-read ethh after pskb_may_pull(), which may reallocate
> skb->head.
>

pw-bot: cr


cheers,
jamal

> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in"=
)
> Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@ke=
rnel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/core/filter.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2..4d344ec09736 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>                                 struct bpf_nh_params *nh)
>  {
> -       struct ethhdr *ethh =3D eth_hdr(skb);
> +       struct ethhdr *ethh;
>
>         if (unlikely(skb->mac_header >=3D skb->network_header))
>                 goto out;
> +       if (unlikely(skb->mac_len < ETH_HLEN ||
> +                    !pskb_may_pull(skb, ETH_HLEN)))
> +               goto out;
> +       ethh =3D eth_hdr(skb);
>         bpf_push_mac_rcsum(skb);
>         if (is_multicast_ether_addr(ethh->h_dest))
>                 goto out;
> --
> 2.43.0
>
