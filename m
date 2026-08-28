Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656E37BE96
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903221; cv=pass; b=DfeBQjjQgeKuyfE9Rt9TFP2wCoUhVa8ylmMvgOmTJfdVcZfcWtXjhJDQ/6q72wgMneRy70dCIqiyKlPuBmMsxjMQT1Lkw+5R5J+rrLExwZJd4tP1buo/wJa5hCXnxvWn0uyByWgubifvrK+0YtOQDx0RWgujmSFHGjuKVMWXCgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903221; c=relaxed/simple;
	bh=3GG5nCWl7CWNpEuPnh5H8CvcMn1R+QCVr+rkkOznzJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrkb9uXBkenP3lVvSMNBpXhKl1+x3xEHfXNE/T43gi96QDLBtIsNDAA3PAMpu7jWcmdNKdO/Axiy+4egiD1aX3QMV5SveglV+Z68hn7Ly91Qbka3RljnOoB4ZvF2KfH9PoN09bWuAmtW2aCOfjLrGd9PwW9XK4oYYSIC4OJq8Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVkasdu/; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVkasdu/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so5183921cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787903218; cv=none;
        d=google.com; s=arc-20260327;
        b=QgLpQJLLuhPmmGxV+0qe86F9HlX6WdhrfZ5CNXebcFrb0xBLSvpFK66i9oozWmUYV5
         n+CcSsQE3Z5dTHeUwxNjQDNMJwxnC7WaW4gY5kS8xbHcE3zqMN1BcecF+xuWogjpP7EG
         kSCYyjyR0wYf/G/vlu5essHa8Oqjjfk+309wq9BaAyxBN6r2sqLn9hyJwwVJizJwCkhH
         NuGdNkOqr1WLpaRzAW51fF/1ZcJGnPKWHXp4g2tz1InffeH7LYDGw1SdySEEfoHI7sFU
         Hxkt8GlXGtfyJHhoqfysmgh/WkiH7ldkahXH/nkJC7O0sVOXamerhH/cX/0Ww2I5i27F
         ClvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AbXs5Y0cN9WnX4kVJwxocnUX7LwdYJ30DpFpjvFGAsA=;
        fh=TYlgY5N/5G5Y7msk07nJAt8t5ps5fkg9/6+FEC3y2Bk=;
        b=Sx5HnZTJA565SRddG75lhnCvepT8qw4Oe9scoLe2NWLU57T0VrIoBCskMihHM3j6oM
         nKsv25BVtwvmDeyklrsjkhuZdk2s0UNTYO0yhdIrxVrJhvxqeSNzd1WReiCy9SawzRN7
         NpEoYh+dXRKRirlWHFIvuYX2hqSKdtUpa4HBKSQlSwXZLqwpn5X94ZhCp73015Qt4x1L
         zUjFfCLKsalYmE5d14CKJ8K9iIIClL1LDkJ/uB2c0A4ahTrZyBkFVwiA50R9V/Rh/jXr
         9gwssmcQvsq95w5qZhshAC3Gvz7zp+HdYcJpwgGMd2Val5MDPNgKOZctizS7ruvfbK0z
         qFTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787903218; x=1788508018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AbXs5Y0cN9WnX4kVJwxocnUX7LwdYJ30DpFpjvFGAsA=;
        b=jVkasdu/PvIGpvmn3EQegG+aKoPXJGRvWh8ViJIKU3z1l8DEMiYbPNntZYWqO5vfRJ
         WuEZHwWEvvgPeGaKgLH7d/V4VFRbiovuprKJ+jn1Xe3FFP1asF7eTQFRsEM0WsQ+kdSL
         HcRCbnCEZtdTTLUjS03vbM6PJQgl9ff+K/JXhBAbLbMGplazYITSeZAchUTaxdexDix8
         a6Hqbi8iVCCgtUuL/Ytq6OtyPJ9gqdK/Ek21iPF5g41rxw4nHj9eohRG9toGg5jECWhi
         XMYbkBOBEnxQkNq/ZlFfDG51iaPwdUHDS+HRbQsKDw0d0N1470MsC5bkJrioG7gIHz3H
         THjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903218; x=1788508018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbXs5Y0cN9WnX4kVJwxocnUX7LwdYJ30DpFpjvFGAsA=;
        b=YrGfUpxjA1uRqEzsCtu///pdykUoh0gFurAoM4KPgNdvt3HwJeqpVF4NAIfGnEO1RR
         6vo5MVVcf9k2Mie/Po/zrhLnsKqgHzyghGOBjnoJ2rCOoM3nNBwN4b8L/yz+7rQShzqJ
         gOmNGMzwN+ThpQZnnZxQjCjp/jmQkZHDBaOIA/bfh+ZYQybA+Jvv5DrHMlQJeteiIVbL
         N/5E4iQRd+XsnfiLyZfSBY2EunK3Z+kU8IQqPyEhiBm6oiaGUSwO67krMuNShmFmpby8
         47pCzv6Vd/7/GlbHBd2nzXfSbSjodfSkRyNBozr7SJz4E+FdqiEUdAC7pe70xURStmwA
         3LaA==
X-Forwarded-Encrypted: i=1; AHgh+RqIBwTRNZNbxyoVEZtGBjq2+Y7xdYPS7FFPedAzQ3Rmhxi53zWVvELKVIO0HbRUCSTweXADRsk=@vger.kernel.org
X-Gm-Message-State: AFuF++mK/jtPSFgBDyfBN2ydiKuflHbB8N4Tpg7N881yb/HciACP3HOg
	7ywTxT0rarVf9iGTRl9vOrXOyBfJQjAVStAIgn80alOO1O9WRTbeTHcjp4hzUElyVnYiquFmyor
	yrjbmSvMEOLr53mRQge0YeAF/rHB6OzEI5N8Uk51f
X-Gm-Gg: AR+sD10QhMMGeQW3TFmX4Nza3nbxuoIjkqqvsp64SQ0E2LpQm/I1K+IOAP1IWdzHTL/
	k4XYKix3tA7Lx6bUL3KPHCYgDHiIsW/wmd8cPKYbPp1LL6+TJ+aJKdoG55KVKR1c6LNSKKfjR7t
	r+8aK2YMkToBmith99WyNFx4GS0PPTYiMjCrleMYFdGAhnIg70auR9zeaW5/ljoTJal7mXUJhQd
	mpZIensnUvcaOVXqPWmlxTSFU+tU/ELqdzmpHq97uDSPI66HOjMsd1rssVRBVRN9uE1+WkKO1RC
	aavgW+EV5g3iXXJNTbaeRed2yvQrWsv++TKotwkBuavtRDddrRXr8qByyCt9VVF9KvQSpKY4Ytk
	1LrPzaTSIGpMy8LBCQirs2ru08iKAD4LU8iZdjsd2FKyHuKjIyHt9q0yr70g=
X-Received: by 2002:a05:622a:22a4:b0:52f:b6cf:9143 with SMTP id
 d75a77b69052e-52fb972a984mr54680621cf.40.1787903217808; Fri, 28 Aug 2026
 00:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
In-Reply-To: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 09:46:45 +0200
X-Gm-Features: AcwNN1UOB9k5TEE0jJdEjzh_hJz5U_4kim7pOPWMRfNF5Q5U3YnZhx0WKEOSVbY
Message-ID: <CANn89i+rDqRXaOO2FNpX57rbgVERrBsj6=OAoMU00aeejYk27Q@mail.gmail.com>
Subject: Re: [BUG] WARNING in lowpan_compress_addr_64
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:22=E2=80=AFAM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> Hello,
>
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/182-warnin=
g-in-lowpan-compress-addr-64/
>
>   WARNING: net/6lowpan/iphc.c:937 at
> lowpan_iphc_compress_802154_lladdr net/6lowpan/iphc.c:937 [inline],
> CPU#0: syz.9.76/13660
>   WARNING: net/6lowpan/iphc.c:937 at
> lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952, CPU#0:
> syz.9.76/13660
>   RIP: 0010:lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
>   Call Trace:
>    lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
>    lowpan_header_compress+0xeef/0x1ef0 net/6lowpan/iphc.c:1242
>    lowpan_header net/ieee802154/6lowpan/tx.c:234 [inline]
>    lowpan_xmit+0x4c6/0x1420 net/ieee802154/6lowpan/tx.c:282
>    dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
>    __dev_queue_xmit+0x11e7/0x3250 net/core/dev.c:4870
>    packet_snd net/packet/af_packet.c:3082 [inline]
>    packet_sendmsg+0x3d9b/0x5150 net/packet/af_packet.c:3114
>   Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> Our reproducer.c is available upon request.
>
> Happy to test a patch if that would help.

Thanks for the report.

All these WARN_ON_ONCE() are bogus in modern days (panic_on_warn being
used by fuzzers)
Developers probably used them to catch unexpected packets.
Guess what, fuzzers do exactly that.

Also lowpan_header_create() seems to incorrectly return 0 instead of an err=
or.

Can you try:

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 37eaff3f7b6940b73924c38c360adf482d6cceab..dec04f63f1b2599a7291d020e66=
2f4d129333c14
100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -180,8 +180,6 @@ lowpan_iphc_uncompress_802154_lladdr(struct
in6_addr *ipaddr,
                                        &addr->short_addr);
                break;
        default:
-               /* should never handled and filtered by 802154 6lowpan */
-               WARN_ON_ONCE(1);
                break;
        }
 }
@@ -820,8 +818,6 @@ lowpan_iphc_compress_ctx_802154_lladdr(const
struct in6_addr *ipaddr,
                        lladdr_compress =3D true;
                break;
        default:
-               /* should never handled and filtered by 802154 6lowpan */
-               WARN_ON_ONCE(1);
                break;
        }

@@ -933,8 +929,6 @@ lowpan_iphc_compress_802154_lladdr(const struct
in6_addr *ipaddr,
                        lladdr_compress =3D true;
                break;
        default:
-               /* should never handled and filtered by 802154 6lowpan */
-               WARN_ON_ONCE(1);
                break;
        }

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 4df76ff50699ede5c187c9cca6f0cc10b19d2123..9bffe01cc448fcb993883748f35=
9cc71b879a729
100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -47,7 +47,7 @@ int lowpan_header_create(struct sk_buff *skb, struct
net_device *ldev,
         * if this package isn't ipv6 one, where should it be routed?
         */
        if (type !=3D ETH_P_IPV6)
-               return 0;
+               return -EINVAL;

        /* intra-pan communication */
        info->saddr.pan_id =3D wpan_dev->pan_id;
