Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822B3603DD
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336198; cv=pass; b=tATZCII+O5Bd37Vp1dXLvMxoEnJFng1+DNikrLvV2BY42qQ1zOtNBvSJvdAxfbvJkPmIY+qsf9rq9XBKZ4LsHmVhjpAwHfrx10ppxrXYHvyuQ0ae6/Nv4jNXZRXu6XWXvvBMoaofQVCJ6FpbNES+hv0F9AjxCK5bZ55cNe457/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336198; c=relaxed/simple;
	bh=4TCKxQNmmZNCPQWk8z02Sq3GLSDjEU9hvSXOmWplR/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdhRjP3F5Wk5KSmlebMaSQmMn7gygWHZqcOy73Bj2GYyrRnMaVtXAlTbjY49+N5UgpXYGHtGdRTnLwKJ/J6UdlSc83cktcjv9GtAjTP/bbXedTe8pKyaCEu7berK54bX31uVEVOVD3RNPo5HW9YzMZbtUXCMEgq+vGr0R4BvXk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NiSalNKt; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NiSalNKt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-86a25369f16so2008468b3a.3
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 14:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789336196; cv=none;
        d=google.com; s=arc-20260327;
        b=h/NIr9cvPyL0tTDjOGK02b1oNkQ6c5J/y/Yf9vPwJkxkTw+0Dnu8CGnpu1x/eVU3Ws
         axOavgrPqR6blt6YIAKvR61rk5bjySQgFYTU6dG0vXIfe+EOcDBd3p+IUmSEALy63fQ6
         CYMpdnBMvK16StPLGp8Kw+2dER1nBw6Cbd00bPlQ7070r9j8X7cAGWSUmESDTj/OHth1
         HMEkbRb3ah8ibNjhOgIDVpsW6/pA2HJkWQT3AdbeLOW5W0z19sldO0psKtam/9VtIiya
         j3uBO47/1zzq7RZT9Dx8n73WZJCp9MclJp8mhDSeXSJQW3Uz1ItcH78yIR2UWHUYgHOw
         qwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJ2qt54AEIinA8o14ZeCgmMSD5YlOndqJW46+FZ7rS8=;
        fh=St9LljtLn0+y3jvSy83ZMFXFsMi0kIjSGOr9g9LBUkY=;
        b=YtG5wlMdjWa+aqlC7wgu5JX/u5yZZWL30SgrKxTOmyF8IdUbjJNODlnoe8SuC5zwJh
         cQRbK36IZJO4agbaZwVAsb/YzVqPQZ8w0nY1kR4nkWR6EPhga5uW43n9/ED7+bMRUKjU
         LY9tZe/DQ5Wsvs0advnVNzwJcTU6X8FTG1sF0YcvnsjkRT3+0YGo5fpGgYw4iY3Z1hqd
         sQ6nkAIr+gkfA21mOUwbziuOZdQA7t+74fq9VWxbIaX7qYYyE+czeP6Z+uWipjaj+6ZX
         6QSd3/WX3cEXArZncP9JkCpsy+YrNj9WpBGuQYNCPpNqjr5TA3iojCezqRnwEJbXwpKt
         0HsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789336196; x=1789940996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJ2qt54AEIinA8o14ZeCgmMSD5YlOndqJW46+FZ7rS8=;
        b=NiSalNKtYLginKSxP8JFQn5Doxk1AZ4/W+63TytypDzw0ZEoeK8DQs9UB6cB3YczFL
         iYavtMaq8shfNfHKoONWFD0GOHT7Tg0moKO6xmM1BYORu4ki6ATROUXBJ9AfA3+GAQrw
         aGS1KSFITbf4an4KBoIJHtNZkvofQNuuO2Mpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789336196; x=1789940996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJ2qt54AEIinA8o14ZeCgmMSD5YlOndqJW46+FZ7rS8=;
        b=myO8Jm86AxHiA7OUQWnO6RJkpDXuASc32ObkfchStlSKHEPzE4zQ9CxmSMnfjb5NiL
         IXTzIhgyzMwQmkeaBzjCeZ7aExvlUPLCDMQlp1ep1F4FJ93cCaJjUpwB2pus6vxj26bP
         fpiZoeGvbG3q60nXqZdP+ayNaJ50TeomkmgDBHP6DGTC35I28rqo4vmFkbZ874xTokj0
         u/hCSWKybi4xSAuZflGXImNMA/0TVgfGe3sSJZoLOu2oyl0zZ3SxNh8CiheO7TYe+CmY
         Cv7h58HyE3jZGfkUynt0WnFbsgbZE2q3SKNK9hC4jkRmZqorfKbpF0N1Gr5aNTCj+NYm
         GxDw==
X-Gm-Message-State: AFuF++mj2aoHWTrFQH0vnQ9B6I72DaoCqfrRXnCHnjJBSxlfD3uoGEPN
	nDzZMSXAtqNKIcpNsOcrThixyZq4tUBwoAqgyrT1l4Kg/OxkGkmnmB3N2YwfHpOIhsaFLciyvYQ
	V5Y8HKXbKHrixQsc3/hHH4EC5K2m9gR9g8TDRTcyL
X-Gm-Gg: AYBFou2pVB9VCi8MYFkmSEOZSUohj0eEhwd71VfYiJXf/pBnnIWCUH56UJKqx+12Q2p
	2xpnMVPdsqcLPB9V/Ru4RNKObBMhYO7jE6rgqNFAUZxl7XzmQ4ONYYvazS3N5mOzlhZd/hfyqpE
	kYDo0OsZDWYq9YsXXE46+XXgBfWjxJdE+Np9UDiZ9ZApBDXvVYMFVSPfYkr/fupMmz0wYdZFvcD
	Pb4w1TaDuQYK9ZMaWh7mfuDLqNuJ0qGpjfmafFqSYHbtfFbWyzfX12T4r9UYRatA9MDRkP3CgXu
	Fwkh/lg5lXuCQFd8seHMEMGDjtrq8wFX7XThzdig935u0fMEX2EPsytNom000zweZKuM3wRCyv+
	BebQjFGAXZm5FKlvG0cmqlLb0LSG9pR/PJQ==
X-Received: by 2002:a05:6a00:4b13:b0:857:4dea:e1dd with SMTP id
 d2e1a72fcca58-86b3160ab32mr22270977b3a.14.1789336195828; Sun, 13 Sep 2026
 14:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
In-Reply-To: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 13 Sep 2026 17:49:44 -0400
X-Gm-Features: AcwNN1W0S9AfQD3LjaFTQIRdu0jjkwPUtRvoc8TYNfsyZwghNlnKu2MNTtqSaXk
Message-ID: <CAM0EoM=LzaD8wQ-FuMteGTgBiq15RHX9-pE9H2-ihvjeTpW_iA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: loopback: ensure Ethernet header is linear
 before eth_type_trans
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, vega@nebusec.ai, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 11:45=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wro=
te:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> loopback_xmit() passes skbs to eth_type_trans(), which expects a
> complete Ethernet header in linear data before consuming ETH_HLEN
> bytes.
>
> If an earlier path stripped or shortened the Ethernet header, a
> non-linear skb can reach loopback with skb->len >=3D ETH_HLEN but fewer
> than ETH_HLEN bytes in the linear area. eth_type_trans() then triggers
> a BUG in __skb_pull(), causing a short-packet handling crash.
>
> Check pskb_may_pull(skb, ETH_HLEN) before calling
> eth_type_trans(). This also rejects packets whose total length is
> shorter than ETH_HLEN. Account rejected packets as tx drops instead of
> crashing.
>
> The analogous VRF path is already protected because its IPv4 and IPv6
> callers pull the Ethernet and network headers before calling
> vrf_local_xmit().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Closes: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3=
b.1782548651.git.bronzed_45_vested@icloud.com
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
> Changes since v2:
> v2: https://lore.kernel.org/r/cover.1784709375.git.bronzed_45_vested@iclo=
ud.com
>
> - Moved the root-cause fix from the tc actions to loopback_xmit().
> - Dropped the VRF change because both callers of vrf_local_xmit()
>   already validate a full Ethernet and IP header.
> - Left any additional act_vlan and act_skbmod hardening for a separate
>   follow-up.
>
>  drivers/net/loopback.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> index 1fb6ce6843ad..54b83a988f0b 100644
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -72,6 +72,12 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
>  {
>         int len;
>
> +       if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
> +               kfree_skb(skb);
> +               dev_core_stats_tx_dropped_inc(dev);
> +               return NETDEV_TX_OK;
> +       }
> +
>         skb_tx_timestamp(skb);
>

For reasons specified earlier:
pw-bot:cr

I have a few "hardening" patches for vlan and ife which i will follow
up with once the patch makes it to net-next.

cheers,
jamal
>         /* do not fool net_timestamp_check() with various clock bases */
> --
> 2.47.3
>
