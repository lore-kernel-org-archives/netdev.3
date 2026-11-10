Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332956;
	b=YWxbAbk7xHuyhpsb2j+H6f0ELPtNUyTiKUZvneyP8O0rGbk3slauiYsapaeCrGX/NVpA
	 1wL/mm3Ge2TtkfhlKgFTInndHkllylXfqo7Hp++AaA/uFGjQ3M4594pr1UOv+atSKcpZ3
	 Zthsd2Rv6cZkImKWCvzz/3tPOzidlETCWcBrRW1rez9u27zjTSZ49ey5BquE4Yr8wls4Y
	 nX1VLHQ5FP5Eew5aNuDbu/HLWpieG120Q/T+loHQI5wFI7tGZaEI6+dI4IAmPB6oA1UkF
	 VqkDD7+v5/8KQN0JKqJP/DWD3Vu12rBb2jL7U57ZZ+E7e/phcysaoNoswHV8/K4vU/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j6/vIY1+KYQxBreFtYkfvG0gVjy/kF+drhNwxzom6y4=;
	b=AuSDxcoYuhyijnSZfJao61+9SU5jTuqwIFFhArUWxO7OExvc7OCCUQW5hZQdvozg6mHl
	 iw/72END38R+tQlrjCJMwN6aAPLbhxYn4GVBCbFx5sok2LBWKY+CUhnsLzy5zXGVtr7Tg
	 FRydf9V+OZBTD7TRSYLoKK5cbechJa98HuvpVujr+3EFgs1xOZse6SdH7j8jndp4l4RvI
	 90rlBqJkIGp7mbEQh9d7JrH2tJ+bF7U/R3rvdGz3nHwvbXAgXSbzgAL8y6NVZJWDZxm+P
	 z1REQnkdyeGZrv7IiXxvL+qcp/VJaFgU6SaCbXe2/+nc3WIhHusEoWsloFQmtw83ZZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=KQdIGxie;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A2606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E38A2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=KQdIGxie
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c43373ae89aso179943066b.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794332953; cv=none;
        d=google.com; s=arc-20260327;
        b=Vd/wCXWE5LdS6XVWKfvdIfxHe6c+iERrSTMzEKFxeUHndxiOP6IcPbK9d+Xnl+gm0c
         yon1hHIxINgdF/h4F3w+TaLu6muV1d02vmmDCOMORWztqCK7tUL9rI3GWRlpkJoAp85w
         VZT3ItTdoHLoAsBFnSLUgWu7PzjOy5vvaS/pkAp9FTMOLodmhHeHTlE07U2vwZF2RghO
         sfWoRRNnkqq0wHjG7EUwXjwwHKMjpvRWMEaR7CF0Va8mi2Wb1xvhs6h2VaSdC1Xg1Ga1
         wv78y6fs07xP/yhwrG4ndjEXPkVRp8xAc2QzDpQIYX2vxit8Pt44RM4dDANg4xQn5ywM
         yJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j6/vIY1+KYQxBreFtYkfvG0gVjy/kF+drhNwxzom6y4=;
        fh=bAMSgjrNuKaTc3i+umrQ+K3rcUXdLbZ4cpQizlVKG90=;
        b=KUMxol5P8ecMNDtnddz71+MvCuvNJpwd+ZN2s9y3euTOX8cFaVzizMEEWhY7AQ5KH4
         jZ1VbvZPYcTGfECUA8VFReIf5JRGjO70cBvYxOj4xLxDGf7kCnnEz35pWwLDBUQ+HmVM
         MWAvbqoNKkj19s+cWm48GofOoN/b+MDn+upohFKR3Ae+RU93PWgmVvuT+wv1oJED5Txv
         Q5j2nBJryf/KCtzV3mwped9+NmUeVLx5GozWF9KXBHq/M7eHotlPXSVtMHj9Pr4/muxC
         b9yD9JYQGo1683acX8RfBWwQ7ggf6uIivJ7tD37DnV0jZBnVhy8oQZ2US1aeOxSjdzRl
         lnMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zx2c4.com; s=20261015.g; t=1794332953; x=1794937753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j6/vIY1+KYQxBreFtYkfvG0gVjy/kF+drhNwxzom6y4=;
        b=KQdIGxiez/gh4C0E6pwgI2SDKl5qCYpQCokfBgOCm+1FT6nN+zOKmSs8m+dOSc9xlc
         JkzSM1BNct73WsvEKF2Na83AcWOVJphPdv+9gZoy+6Jnj8BT5v986paa+U7sfAr7q529
         BEVxT32EbblRsl0AG7o2CAWTgTz9NGWtQH8A/z81Nz9eFWsI8/NK5Pkz9lSfkuoMw0H3
         oiIKdDMCW6W6RJixhz5/mO8OvLGCc1TIDJK1/UeORyHjFeJFVEYLMSeIEfikqIxJJwmF
         n2IZ4GV6VJ8n3ASxVCmuM6+N5XPi8RE0DHIXY5uhWJTs48pxoYknrMm1lfLWlKqO7dfs
         Epbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332953; x=1794937753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6/vIY1+KYQxBreFtYkfvG0gVjy/kF+drhNwxzom6y4=;
        b=WKqJ1q0uFdrvaSDRn4Fd0NPTYeSktyhzbl06pTVRpmzu0xCImWShuPG/NWk1lU8jED
         z3qTWGwIIzJrlUtQKuD86+M68UdCaLbmd/9KcnDJDT5ryJ2nOA0+4ZJVEqMHAAn2BAhI
         f4vfVUWCktmchP7SojbX0q/UK9MQ4VXPTn/faEUvZr58MRofNNMIao21S4cWhxK67DwU
         XSI7cJSlEsEqaEqdGuHJX+kN2mDp1QpbaQneXURlxlBGWxYyXmFgLp2aCl6obMPBESfA
         I8ZmqMTyR7ng3vw0JhTPj/k/LStex8yGG7xGaN9SvufUQy4zDCYxz0PNXsRalz5YmtGn
         NVsQ==
X-Forwarded-Encrypted: i=1; AL+hErEAzlJ3qCSgb79Mfz+Kmm9Bh69uY9/TflE7oBhCO/5ucWhKeBKZGV3i0zMbgA5Mf+wwEtfPM+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x7L0Q0l3xeTyn/BW47OqcYDpFAAa3nFXtuynheZMEOYouUmwh
	ktbRXcfmP1H9gkfybs0lWDcgDabC2+YgJcQvaiG4Kaogy5SpD20zKaGz6jKswTgiWcDZPsLM22E
	+Rs8s5tPic0iTrRA87C7uNxFsHsbOtF2tEWOrdCx3r88=
X-Gm-Gg: AYBFou1oBsbTPTqDGYvJy8wyCWsTQSP32hKHYW8sg7Uaf3PFE5OdLETeZvoCvCX5OjH
	5tZBpAVQncNXYPxjmF98tu5wLvUdrM0RRa9HV3s6N4mIZ1c2fMd2zl2IfdrXacXFlY/9X6ul1bj
	jqTN3ZZPZw3A1F4w+cxVZgtKgKhABeGSqerKWoX/2rAa6EZ+hsGCT7OE6GQtObONWqqt3kqcdnK
	L+FyyIl7fFedRP+CQfQqpzsxxsE9xMD2XLbfxReKga3XZMh4o/w8QaxmwDxzZZtQa3P3higxpgu
	+giSdtv3LeeCKMNJYsQH0YUJejr3Imtt4XQ0cn0xn+Z1dHr5AyY0RrtlHTWkjuUI7of/ASIS81W
	/Iq5Izo2pY4mSeO66s9hJe/XSBg3rBOVd8W0P6wwP2Y2ukS2/uTlRWK859/jhhWtYeVaHgUC644
	x961KAAYpJT/tSFdVRdAcBvzElgqvSyBNf9qvz+eLcVldTItiTdGbvqAj96BfieWl2uRNHC8VQV
	2lp
X-Received: by 2002:a17:907:3fa2:b0:c40:38b5:d784 with SMTP id
 a640c23a62f3a-c5049609f4fmr264194266b.22.1794332952982; Tue, 10 Nov 2026
 09:49:12 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <116cec552f58748d434d4825c6c74f39266b265f.camel@infradead.org>
 <avNCdbpjxM752XSw@zx2c4.com> <89b5e08e2a48c33be4cf2d495266d04a2dcf406e.camel@infradead.org>
In-Reply-To: <89b5e08e2a48c33be4cf2d495266d04a2dcf406e.camel@infradead.org>
From: "Jason A. Donenfeld" <jason@zx2c4.com>
Date: Tue, 10 Nov 2026 18:49:00 +0100
X-Gm-Features: AclHuK_fmNqGYrX8aoD5zj-ji2pF_XvdH1TFaa_HSiH96TwcOL_EUaS0rm5SADg
Message-ID: <CAHmME9pWbftSmnJgLawNmWxNHMEqC5evxWPW8TruYkBD18Q8nQ@mail.gmail.com>
Subject: Re: [PATCH] wireguard: socket: fix sticky source address on p2p
To: David Woodhouse <dwmw2@infradead.org>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S.Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Antonio Quartulli <antonio@openvpn.net>, Ralf Lici <ralf@mandelbit.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 5:47=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Tue, 2026-11-10 at 17:12 +0100, Jason A. Donenfeld wrote:
> >
> > Hmm... How did you choose __ip_dev_find() over, say,
> > inet_lookup_ifaddr_rcu(), which is structurally more similar to
> > ipv6_chk_addr()?
>
> __ip_dev_find() is what's exported to modules. It internally takes the
> RCU lock and calls inet_lookup_ifaddr_rcu(). It also falls back to a
> RT_TABLE_LOCAL lookup, which I think is the right thing here too.

Okay, makes sense.

This simple patch reproduces the issue in the test suite (and confirms
your fix):

diff --git a/tools/testing/selftests/wireguard/netns.sh
b/tools/testing/selftests/wireguard/netns.sh
index a8f550aecb35..5dfecb4c6ef1 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -474,7 +474,7 @@ n2 ping -W 1 -c 1 192.168.241.1

 # What happens if the inbound destination address belongs to a
different interface as the default route?
 ip1 link add dummy0 type dummy
-ip1 addr add 10.50.0.1/24 dev dummy0
+ip1 addr add 10.50.0.1 peer 10.50.0.2/32 dev dummy0
 ip1 link set dummy0 up
 ip2 route add 10.50.0.0/24 dev veth2
 n2 wg set wg0 peer "$pub1" endpoint 10.50.0.1:1


So I'll add a followup commit adding this to netns.sh.

Thanks for fixing this! Applied to the wireguard repo.


Jason
