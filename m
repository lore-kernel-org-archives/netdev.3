Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792433987;
	b=FiRc+JD1J7EXeg+akbTixJiWpw8jXQx2peh1ktwI6iYwLcu4Cyi1qETCsYwXb1MJ8RqF
	 rbgpZC7/1NZlXv3vgq377Zxd44VIiztUGfh5H7N/DXPOfzlx9ZJABONhaiDD66diWDde3
	 BYHQlz/48wPrbMPjaPg+7+69TYgV49YKg1fBzqrKe+Iw6SQvcw/w0OL0szyTb4Km/UR8g
	 or43dT5GTyPpuodjXmtK4//TApCtU/6wd7nOjvHwrt16lzCpcbLKzyuhxEALiRXcDgPTf
	 kKQhWyy5ELWPDW3OV+5s15xvKAbRyODZ6mkxKHOoBjb3u3okIYkJA6nPHCqK8w4yMEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QIrE79vm5rJ95OFORudqvsCFoAgEHH/fkLFWkOBtscs=;
	b=ID4Yra5b82wYPKGDIVoy9GwIEZyuNp7f5Gf04FEgWQSFXkOgY3yw+iWcy8aT5Twfp/2a
	 Nt34/00WL7ecKzM9kTja//m5O6IPEyBWqYqrhyKexbcLCx6tAQFBIosazNARLcoiYFSzq
	 OpGQskTyoxX4egLDTCIe57Pdrmu5HoPqrZW7x38Pa+IVr27s0YbW4+fYP/DaUR6nG1Xx1
	 1g2NBL6mXN+gq+KcJd/7CmLoNgS6qkdgvkkmgfaL0W7AuD9Pb9IflvutMHASpr/lXenWJ
	 dAl+OXK2IaBn+CLbLBFd8n6n6fZ11VHSaZhuGftbmEuBuz3bTO7DClohDoUo3A3rapA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="d/Ogn3Ca";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE1606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8FE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d/Ogn3Ca
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0e21048f8so17582537b3.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792433986; cv=none;
        d=google.com; s=arc-20260327;
        b=FNID9M6+hjmB8Vvz1G5h5kBVHXVcUKQyC7q/5K/xxLueQTPwMAeP+UxaDthnC3dwS/
         h7BZD405Sh36uDsVgGPUKzHCSxAVQxb/xW+KT3Acqxycm3AbGBKIqpyjYq7TzQohso/D
         /ZTfi4XfXDECVKCsQLMCNqrEP/wihgnXnFwrWFEHb0Kcuxy4kNLNfwUG16BUoZ3ownhw
         O/zVSa4GwHy0IBoxzAnESn1owrh8Bcw+0Z6q1gFu57k0/36RBbur6HVxu/DO61+xKDRZ
         oRWtu7Dp75kipUe84PeV/juG8ePLsd9SOHpHWSyzpfyV2NNrlvuioLZpMBN9KUyaDzHi
         FuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QIrE79vm5rJ95OFORudqvsCFoAgEHH/fkLFWkOBtscs=;
        fh=ad9RcFEn2xmHdkDOz319bZAjIXoEtqWMA4sTknwo/DU=;
        b=oHKL2QGuUmvrx28bSdsqrFs5Vlh/qo43F9fGJf7iKIUBnqaRiOx86oDdooi4d9wLEu
         t7HX/BP241FEAWmC5cQZy2my/87oiknVx2THxp5jfGND5rFOsrZcNyKipG8Af4dWOlKH
         AyH2sGL7cpMxvrqxJEv8KWPRqlxxM2MF2chzj2TQ0V/av+MYYXzFDEVG/OHSblRft6yg
         8uqZLegA/58iPcfBtevWd18X0daEuV6CR47n6idzju2ATKnKUVgNDvEEvy4VqzJCueen
         zAQLp+G0t8ZqdF8IXIhkEJXJ50VwnlTpZhc0IA+4AD+aIj8j5ZEfqhVIIreAY9E86z5i
         e/0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792433986; x=1793038786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QIrE79vm5rJ95OFORudqvsCFoAgEHH/fkLFWkOBtscs=;
        b=d/Ogn3CaB8xDzPK+AM6nKJ56zb/MrgGIpwEvvNvNehVtYIF/SjL8yT2wRBgPPa66K3
         U6G1s0thXYAMQENJL43wyBnGFX2QLNXhwH8e302qUJqQcdxv0LbdH/eRKmMzJEezIgeI
         6ZYGRuaAzkqhLTPe9Cmn+UhvH3CsWqTmmx783erQvwm7Zd/mKDAPMeXGPl7HfCeU9q1X
         7FthYumlk0ql5usVkzbvhJ5R+l8mgIZx6vxwOsd5NOXV9I2YQsATBPiWBA3z7v3FAG6j
         KNywaAEkK1WdSVghWceMyktfRe30wZYpxQ1ucAKDAhmK6ABf9jQY9QtXA6eIHmgeugGS
         +rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433986; x=1793038786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIrE79vm5rJ95OFORudqvsCFoAgEHH/fkLFWkOBtscs=;
        b=Obnvk8U2wpReJekB2sngQMJie+o/6FA8qmBM2kouBosdk+hPvWUccqjRq1ZkWo3OPq
         fzb4wMuy3RVe8d4jt1stQuuTSH7NHvjBffBavQvYEHc55/hHqt8SNY98ZlNJJxbfFGSZ
         Fu2MvC7Meziiyh/uCWFi0GefPJEQSymrbsvJT6qI/svAheYGiqKokkyC/KFENEyYqf6J
         0dL+tMfjJicJWZR0fBCdBLFYeHNBwlJJjc1jLF0VvrR2sowU2hBvWJIOj2414cXAbwRQ
         97saShqltr4lA8kGAk+cjvwEV6kndPva1iN+qinp3vrP+T0BJPYpDpTPHvMQ3xDNIR9A
         W9QA==
X-Forwarded-Encrypted: i=1; AKwUvBxW7kZ6amqY/qsVqpFDwMva5ZrgwTVizo5rVqHwSyqXYbVkxaf/WMYEnTQiONyLb1fZyVmGY7o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ62U/pjoUvoSxjR140EiXbjVku4GDv6uEsoJi7eAW+2LG3+eXU
	epxE355e6QlmVyobs/v4RPh6wFdz+59bY15Y6Cd+h74vbNROtlo+6G7uf8P9f8LxcyhX44CTzny
	0QKZ9l5dICUMz5nQ8lVKcU0AeyufNzDM=
X-Gm-Gg: AYBFou3Oahz4ydwqwR5rbISY2Q2qWffa1XORXCW8KVM2VdcfgGchzWeLGq4jTDFfSg0
	u3SglHCFvfD1jLe56EW9Wnbpy1v2M5Oh07PocYgtzoz1tR7coPFpk0i8u+SgJi7QzhBU3YoE0e8
	lGqxSW7MySaA3OaHLwzAul8gVV4Go0lCJVzcehCoVll+ahJUgBJTNzMEu5prsD70JkNuoP/SDBQ
	jGgtXsaRS5+pLhR7CubazN3pN8T0nrRw6b7FDwC965Nwywl7dJDkUyGZhlmV+tzrEj3vhdjOBjm
	BK9uarQZl+5TnVB++6LsUOrEj+jpm9pI4HyqeEWvoWUifoe2/Xh6OJXo94OZcV8XUslZfKTOa7t
	YnziP8YxHiJC7ByriHEB5wzyK/amsCemm3k7qA+fXd6echP9slqjlR0k4H8blPOJ4VPFWJKVprh
	lO7G2vWEcwgQ==
X-Received: by 2002:a05:690c:a192:b0:895:241d:6b2d with SMTP id
 00721157ae682-8b0f217d654mr20952207b3.33.1792433985778; Mon, 19 Oct 2026
 11:19:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
 <willemdebruijn.kernel.2f0d78527930f@gmail.com> <dc9eda55-2688-40f7-9b0a-7dfa0e5cbf3d@virtuozzo.com>
In-Reply-To: <dc9eda55-2688-40f7-9b0a-7dfa0e5cbf3d@virtuozzo.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 19 Oct 2026 14:19:08 -0400
X-Gm-Features: AclHuK-TO08q1YjNenH7D-aAu70P2Yt09HngPzn-Fp2PEJuLp9lMDbDWphvb2QI
Message-ID: <CAF=yD-LZSec9g_0bBgrcQvq2OO1BrxMSRHH=uU7eamCmWcTO_A@mail.gmail.com>
Subject: Re: [PATCH] udp: let rx-udp-gro-forwarding aggregate under encapsulation
To: "Eva Kurchatova (Virtuozzo)" <eva.kurchatova@virtuozzo.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Alexander Lobakin <alobakin@pm.me>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 12:54=E2=80=AFPM Eva Kurchatova (Virtuozzo)
<eva.kurchatova@virtuozzo.com> wrote:
>
>
> On Wed, 15 Oct 2026 02:56, Willem de Bruijn wrote:
>  > Uses encapsulation in the same network namespace as where the test
>  > runs? If different namespaces, the socket lookup should fail and
>  > thus the behavior be the same as on a host without a tunnel.
>
> Different one: the vxlan sat in the init namespace, the test in the
> ns it creates. The static key is global, though, so the tunnel turns
> the lookup on everywhere, and the lookup then runs in the test's
> receiving namespace, where it finds the test's own receiver: a plain
> socket bound to any address, without UDP_GRO. That is why the check
> goes from 1 to 10 the moment a tunnel exists anywhere on the host.

I also don't have a straightforward fix to the test. Maybe just make
this one optionally SKIP if it fails.

This is the following test in veth.sh, right?

"
chk_gro() {
        local msg=3D"$1"
        local expected=3D$2

        ip netns exec $BASE$SRC ping -qc 1 $BM_NET_V4$DST >/dev/null
        NSTAT_HISTORY=3D$STATS ip netns exec $NS_DST nstat -n

        printf "%-60s" "$msg"
        ip netns exec $BASE$DST ./udpgso_bench_rx -C 1000 -R 10 &
        local spid=3D$!
        sleep 0.1

        ip netns exec $NS_SRC ./udpgso_bench_tx -4 -s 13000 -S 1300 -M
1 -D $BM_NET_V4$DST
        local retc=3D$?
        wait $spid
        local rets=3D$?
"

which gets called both to verify coalsecing and no coalescing

"
ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
chk_gro "        - aggregation with TSO off" 10

...

ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
chk_gro "        - aggregation with TSO off" 1
"

The full solution would be to add a third true routing namespace in
between, which would not have that local socket without -G..
