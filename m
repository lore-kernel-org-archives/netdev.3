Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6C43B4A3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717894; cv=pass; b=ANZcEUOuUWCbTNWTNvVzqe1fMljLBle+3/kp1GUxsx1nqBDQfO/N7TQl4uIj2uxeIInKPG0mo0tnWxM7mddFrY0w8l4Jigeb7sbZ7yBDIsEV+X8ymKdOs5ICq2yRZoBfJiIcW7RUg27EKEwbTO2PpfySnWSbq108+A3Q7R1K83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717894; c=relaxed/simple;
	bh=D3vtVbOW97GxARqejfEIEllwykjo/GFefVRQz15DR0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDi0raKcN7lLJqHOxmopjjK0mz4+eyakZV/ECbXySe3thcf5Ls/swSLRQ5A1AVtjoPhjxPoPNhDzCxNFJP6E9A4jbDPonKAyJaAOJA20FYW3kUj9JG4wd8X8m3uSbSHnOZqPMbhLIvcLmtHX7c8BZLZKUkL4X22K616tg1IkIqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUStqTPq; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUStqTPq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2a449c57so124372361cf.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784717889; cv=none;
        d=google.com; s=arc-20260327;
        b=PiD/zyJqihnglZk8APtyQ42IPx/UUbp0IUxg7rQthPhjihgUctQFrdkhT08sFKwvIG
         Vg1TxIunc2h0PBGAa0+QuQDgLC0xbrRFFx5t7ucVslD6V5SWBf3YQ/KRDfhVP6S2qswG
         glXre1uPw5hG5OFztXQ+5e71SAIJqefAdYSHeHrWN/0nAe7VxhBk52tLqvlEIxAV2+b7
         u2vjaiUT4TpcggZ8Zyud6MSD5vXNGnmtRNKJE1NgHglijX96xukwZ4syTmnu8i/CavVO
         H7L0dIeMSLXJTP+9o8DsmxlmqOAHRlnE8c1AX5QUmDE6dfy/UHd1Id1uM0v4N1f8KjB9
         aNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3R0b4dj3GEZj+FGD9/ujxQs7LkFeOS+hpAH1YpL/Pw=;
        fh=MwUDnIvhugjV9SyrEv7jr9IZi969jA10i6xiqOV/cO4=;
        b=ju3VXMQzqE2OLP/SFqA8YgOxAVUtEeLOHxxDTvzqLcjZCRjX01VC7/Ona5m78LCt6e
         FWq87lCklMos4FtZrQswMd2RHBRLqxLN7ytUd2nhBJBgDiKBrvH5INsNeUgtjoSA6BFP
         iB0/eRW4RYxx719rkg92sYhk8OON4pZ6iNS876vUYfPcB/IzMJQPuNY3LyQr+D5cWWBK
         i7TB1B8nY9wqkt3nPy20Plj0tsTDBmEzdbkXl9tQ+yhif6NJSax1AoSk8RIUknf0kBuz
         2/dpIeP+GBmxxJzjCCesln9qrazdGC8WSgioeQvt2nSUacExElIlTF2JwSAgWv/HlcCc
         +G6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784717889; x=1785322689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l3R0b4dj3GEZj+FGD9/ujxQs7LkFeOS+hpAH1YpL/Pw=;
        b=gUStqTPq2qx6hQ9IxnSgm7qhmyNIhuoP230UGXe1N3sjS1UYvm63AE04/WkspTdUds
         eH4fP0qPlfocHWHxtCF7Y9WiDccXKVyzH7a1Aq3wW5ua0zMofHvbeGcpcrw7AnJc5Kdt
         MiEhykLbCserN8G6rG/IfDs+HGirermxCUMiA1sbwRar6eWX6WFmYUP2oLEgIr9Vv0/j
         jrsLTZ1NPZehDEE9Xy/3qOiZfqUpH9bn2QR5P83C6At3wOkLdwnOh5McFMpTsEtNwbvH
         P4NRtpsj4qGMYYXVvEtT0YIxbwGhwDDKF9ROaoIkKo3l6zPyxZiHHDA/qjQO5TQ0dT4S
         +rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717889; x=1785322689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3R0b4dj3GEZj+FGD9/ujxQs7LkFeOS+hpAH1YpL/Pw=;
        b=k6L6wHjwGg2QS/1KDJH9X3arJJq+8Kk3zvnd74K2Fx8ztSNQzgO7kfZ6eC8ljABsU3
         T1ZqmYGHoP+WFegN7MFy+3mKjzmyFDir0Hmbu+Z5x5zq2NZgBlHTHD62Ml7gDAnZNyIR
         AELJKyNm5TDMYuwOZFQ87+kQcSdDY4dE72IJEVQz4ys35HMS44IP9cAsdY5oV5oaMl41
         jXjFumJllD05e5Z5SSrx/TAiNMar+HoLMCIUn0CZwe4S8k4iwWg26SYGk0n6k+srkGAl
         2P3UPLg2Ks12jgymnpB5IIXS56Yvho3Vvj1EUJwTalKh6j1PKemE8nOjbRX318Fh9AZk
         N9Bw==
X-Forwarded-Encrypted: i=1; AHgh+RpVW51IRVZ03DyZdp8xQ8jF0u8crEop5zH1vLgYecfFqve8ulZr3C55VrEQYS0ZOh6pQ8A2AT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1bzKl94kLh+0rn32n3R3D/cgoCHL26N8RjdqDsh/avBN1qgL
	4M8UxAU98HFBKQQDsQMUL6eFuhyo97DB7yR+9wIfzcRCgmkQcElkVPZ7KsRt+j1yXC7tdcbxRTE
	kcL/KUotgZfnImHEg10ICpTcGlomRIQjbe9C7rDk2
X-Gm-Gg: AR+sD10CRUc2M/mn1pYGt7jaN9BU2YIgi1qpz9qEri5sjLko3PBfcFIYSWIlY3D7Y2G
	CExC95dYuvHHX04AoVfh9nREWROsoChtlBau9hdMGKmYX5d9mhYxiFrQB0hHbn4uVaSV9WcTLTV
	sKiUbNh9qdvW/EkYZG27xjf6aVpz3o9eGXmcqwjLGM6hdRr6D7/cglAUo/ILj6K0Zuj34yE8H0K
	CTy5t7sRue2wD8OmFBe2bqKVSvAM9RfOqsCfQxMEqIK73SRTfiBg9h405tANJItFjNFTj2ZyW42
	JJLGHSPBpd97MCcnbSXH9Opv6M8Y0RrHxBDz5YXiGrn4bub2StE/T4bE3uAapigvt0pcxZc6
X-Received: by 2002:a05:622a:2596:b0:517:906b:c043 with SMTP id
 d75a77b69052e-5213cad912amr194834701cf.36.1784717888697; Wed, 22 Jul 2026
 03:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722104419.273358-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20260722104419.273358-1-yhlee@isslab.korea.ac.kr>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 12:57:55 +0200
X-Gm-Features: AUfX_mxbg1tgD8I2XjOL0H3YqNzpWRch1sBfJlqGNdJsEtjwxGHVzFmqHXcG9ys
Message-ID: <CANn89iJFKoz_Ym92ZeQC_9N88gQDWT2uSMbqnAkN=axOS7pBjw@mail.gmail.com>
Subject: Re: [PATCH net] net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:44=E2=80=AFPM Yehyeong Lee <yhlee@isslab.korea.a=
c.kr> wrote:
>
> net_dm_packet_report_fill() and net_dm_hw_packet_report_fill() open code
> the NET_DM_ATTR_PAYLOAD attribute to avoid zeroing the packet payload
> before overwriting it with skb_copy_bits():
>
>         attr =3D skb_put(msg, nla_total_size(payload_len));
>         attr->nla_type =3D NET_DM_ATTR_PAYLOAD;
>         attr->nla_len =3D nla_attr_size(payload_len);
>         if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
>                 goto nla_put_failure;
>
> skb_put() reserves nla_total_size(payload_len), i.e. the header plus the
> NLA_ALIGN() padding, but only payload_len bytes are copied in. When
> payload_len is not a multiple of 4 the 1-3 padding bytes are never
> initialized and are leaked to user space inside the netlink message.
>
> This is the same bug, and the same open-coded pattern, that commit
> aedd02af1f8b ("net: psample: fix info leak in PSAMPLE_ATTR_DATA") fixed
> in psample by reserving only nla_attr_size() and zeroing the pad with
> skb_put_zero(nla_padlen()).
>
> KMSAN confirms the leak for the software path when the packet payload
> length is not 4-byte aligned:
>
>   BUG: KMSAN: kernel-infoleak in _copy_to_iter
>    _copy_to_iter
>    __skb_datagram_iter
>    skb_copy_datagram_iter
>    netlink_recvmsg
>    sock_recvmsg
>    __sys_recvfrom
>   Uninit was created at:
>    kmem_cache_alloc_node_noprof
>    __alloc_skb
>    net_dm_packet_work
>   Bytes 173-175 of 176 are uninitialized
>
> Zero the attribute padding in both the software and hardware drop report
> paths, mirroring the psample fix.
>
> Fixes: ca30707dee2b ("drop_monitor: Add packet alert mode")
> Fixes: 5e58109b1ea4 ("drop_monitor: Add support for packet alert mode for=
 hardware drops")
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

What about using __nla_reserve() instead, and get rid of open-coding ?

Thanks.

 net/core/drop_monitor.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 2bf3cab5e557a15dd3fa7197098d6b0abcc01fab..b4d1ff2829b6182b86d13a0432b=
978de8b72325c
100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -671,9 +671,7 @@ static int net_dm_packet_report_fill(struct
sk_buff *msg, struct sk_buff *skb,
        if (nla_put_u16(msg, NET_DM_ATTR_PROTO, be16_to_cpu(skb->protocol))=
)
                goto nla_put_failure;

-       attr =3D skb_put(msg, nla_total_size(payload_len));
-       attr->nla_type =3D NET_DM_ATTR_PAYLOAD;
-       attr->nla_len =3D nla_attr_size(payload_len);
+       attr =3D __nla_reserve(msg, NET_DM_ATTR_PAYLOAD, payload_len);
        if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
                goto nla_put_failure;

@@ -831,9 +829,7 @@ static int net_dm_hw_packet_report_fill(struct sk_buff =
*msg,
        if (nla_put_u16(msg, NET_DM_ATTR_PROTO, be16_to_cpu(skb->protocol))=
)
                goto nla_put_failure;

-       attr =3D skb_put(msg, nla_total_size(payload_len));
-       attr->nla_type =3D NET_DM_ATTR_PAYLOAD;
-       attr->nla_len =3D nla_attr_size(payload_len);
+       attr =3D __nla_reserve(msg, NET_DM_ATTR_PAYLOAD, payload_len);
        if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
                goto nla_put_failure;



--
pw-bot: cr
