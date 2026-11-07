Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064118;
	b=ep0Zy8bdf5/qttaIwxT73cdBk9Ad3lI6eJLZOSmeMVTnC5G/+qScgFzIRCOgJ5fZydxf
	 Vk+c2+DondKpWaHRquIPDiQXKnGXTXG12hFMnJGklZQ1QLWUfaOIgKCLGDDigUQpQknhX
	 D1eHaAodPQ01Z9MXTYXNYEF1e1LMSEPLxIXQkjRXdqE8ktTB3qK8gjz2SOyO1IbHxD9lm
	 AbSGlNlI7kLCHZ+l58v1uxDCf192wQx1wk9DyBRL1KmPLd3aXiE8564+MTehChAsa9gtY
	 QqYOGgGKVRD4AhOzJYF8LYxH0SHneoQvBHu7z/PgYw9PGUUHeUb/qx0R5TMLZJ7puAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ALGSenX0zs2BVHF/84nUUmepv/GDcgnI5RNZWHPQC+I=;
	b=nmP3NjcQU/6MXZQUvH4GnsA4eJfN2zmWmlsn7QBWT1ISAVsF4swxTKXJCzVeRpLIVKDA
	 nuEymJo9a8EI0z6kVr+OEy989jj85OwOV8X/Htk/kQV7lFaZrEWLMwnmqLUvk+WZniBIW
	 3I6WuKT1GGQJkd03w0W0C26WDMLnUZwLTCYZ21Msd/w57k1LM+SIMj6vMfpaazEolwsk1
	 MS7yivmXO6kGlL02Thkwe7wm7cq/7eFJ5owPt4ObIGgks4waHWJiW/lUIHh9XNdZ9Pj4e
	 XYf0F5I2GCIFqwwQBeUTsOTf7AGQ3z85JlxpkJoh8nrJUDi28Ekv6fAlblCvJHqRX3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JV1vknhq;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74461606E8C1
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74461606E8C1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JV1vknhq
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so658367e0c.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794064117; x=1794668917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ALGSenX0zs2BVHF/84nUUmepv/GDcgnI5RNZWHPQC+I=;
        b=JV1vknhqyz68CXblk7gJJEBC30Y31srYk2XDMjYnwMH9498cfA1iexxosTCnNbEZZy
         hzmlQi9mS5eh/uB/LIKf9M6obAQZdSM9XSCkm0rHeZQVfGcTtyCGtGEpK9ttqbUjLZUb
         /iFAZ8BTYWoDKxySIgPu744IUaOwOEU630Wl33rM+O6wO9sBanuUcjen+4gt5/FjsxB+
         E1Ag4O4IGPq6fLw8N+0LKwHXjl6mLo0CuSwBz5Gv7sEIWV6B7pTfMcr4E8ObuxucWql4
         B7dF6RojE7bezcandIg4VziQxbb47WzVHiAjAG+j0V+kVmSuTGsfwhdAXKwBNySOv3ZK
         hxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064117; x=1794668917;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALGSenX0zs2BVHF/84nUUmepv/GDcgnI5RNZWHPQC+I=;
        b=CBHE+F8TyxzRtzWWJLWfBZsjw7wJNMzT6rEaREe+KOuz4NidqW4S5afqOW24SZjGGu
         jZVRKVQ1umGl8Zl0cASMsJH8Bbl3rlvF+Oa0Zq4Vq3CI8+b/caVa5Z/U2YJYkfKeDfFm
         Bu2FPEb2Wlu6s9MYXHkC0A5oWF8rYn5PQh6w508DIoeiofIkbocfKTdPYSgP1gtKY52/
         dYm6lENlegDgqTlB1Z/nPsUhTsw9JWrge5kyWNad/OTANxyZBvVDEJgCoh8l7zQw66nA
         6XK07AluO17EEf9rvmN9OolaqjDK80hHSh9NXB2PasnLQHPhavH6RcM+lgsxCrrQ99OK
         1eEg==
X-Forwarded-Encrypted: i=1; AL+hErEDb3yIV/Z4s9Wtd+EYR4/+UDurn6lmikmhaQIsi55STupa7XrmFZjztEYbV29DaygklN45PHc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8RyE2ijUJ84RxWLopllAQhquWPUPPH4WdqYRkrcVrwd+zQ4QH
	qEhjSji9PB6zJYLf6APWoVGw6LD9E6hDFfn3JSi/FkkgSCXAqQxc5bzd
X-Gm-Gg: AYBFou3dmaUrl4vil2I6ffA/PQi/CYVrLcIgV+Ffe7ZHZAS1xAOKQV6xRyn+i1s/ajB
	5oPBH0tscVvos7M/8TJ4slmS6pGEKLSUJ/Y+ZIoFzZzNvPMShaP4oViCYz/wpP7lUIajUoX/sZV
	z3hfpQjdtHlMHckjym0B30Q63bI2xXqjU4N0EQt7IMnNuoGVC68TdTsTRtQVXLc+q1EqnsmXeYN
	mU4Gn02dRrm2Tw4OTl2vRMvHZSiIUAO/eNwNz5QPI5ZKz+dSsJub9fMcuxMkMWC7T4eqaV4asAe
	WOzVtGcTbJCetMGyyCSdYugeeOxLZ96S1d+XpJh8KFnN4rFy2Yl05t4sgxRuLDwML1RAqrvUDMU
	9n6OHNw9d2LMbMsuzNHPkmlyrbvtYRRExkHT1ZigWMVeHASkGUfQ9zIGv+pGRr617DppaNnvBcX
	JW87LlKeXILBFupElKWjE+072OqO1TqPLTQp6+YX4IJpQnOxEAtpnaZy0S7MkZusGh+fcI+sBeN
	QlgrUktAIU48rhSYHyl4GdWUbbmsamzOm7stSUhD2jzX/6+XEeVznHhUK4z7BuU1V1FuWcgEC78
	hRkyFv/V4LGm5JjK+WtYY4LbbKF0jvVmAtY1dPLYn+tpMnxwvjysqPcMRogksNgpMJhMF+SX+oW
	/YVCVHE3I6mLK6Fr6Em2J8CbntCUB2/P8LKjeLEv1N9B8bjV91crligFETPF/GkG4qBILDX8=
X-Received: by 2002:a05:6122:6e0f:b0:5ea:cb6c:6513 with SMTP id 71dfb90a1353d-5ecd1af4864mr502091e0c.1.1794064117333;
        Sat, 07 Nov 2026 07:08:37 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ccb58sm3801606e0c.9.2026.11.07.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:08:36 -0800 (PST)
Date: Sat, 07 Nov 2026 10:08:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>, 
 willemb@google.com
Cc: Kalpesh Solanki <skalpesh942@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 alex.aring@gmail.com, 
 stefan@datenfreihafen.org, 
 miquel.raynal@bootlin.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.1e7cfcaee3e82@gmail.com>
In-Reply-To: <20261107062755.23145-1-skalpesh942@gmail.com>
References: <20261107062755.23145-1-skalpesh942@gmail.com>
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via
 TUNSETLINK
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kalpesh Solanki wrote:
> On Sat, Nov 07, 2026 at 01:51, Willem de Bruijn wrote:
> > One exception is if this has never worked. If this was a NULL ptr
> > exception from the start, then clearly no userspace can depend on it.
> 
> Right, this has never worked.

In that case, the fewer these weird exceptions, the better.
+1 on explicitly failing this, thanks.

> TUN devices only have tun_netdev_ops and never allocate dev->ieee802154_ptr
> or register with wpan_phy. Setting ARPHRD_IEEE802154 via TUNSETLINK was only
> handled in tun_get_addr_len() to set addr_len, but any actual use (like
> dumping interfaces, llsec keys, or opening an IEEE 802.15.4 socket) immediately
> triggers a NULL pointer dereference. Real virtual wpan devices are created
> with mac802154_hwsim. So blocking it won't break any working userspace setup.
> 
> > Apparently a similar issue affects ARPHRD_6LOWPAN.
> 
> Yes, good catch. Setting ARPHRD_6LOWPAN has the same issue: lowpan_dev(dev)
> assumes netdev_priv(dev) is struct lowpan_dev, but on TUN it's struct
> tun_struct. On events like NETDEV_DOWN, lowpan_device_event() writes to
> lowpan_dev(dev)->ctx.table flags, which corrupts tun's private memory.
> 
> Should I block ARPHRD_6LOWPAN in the same patch, or would you prefer that
> in a separate fix?

Depends on the complexity? If you could handle both, that would be
great. Sashiko would probably call out the same thing otherwise, too.
No preference on whether one patch or two from me.

> > If blocking this proves safe, prefer as little unrelated code churn as
> > possible.
> 
> Understood. I'll drop the USHRT_MAX check and avoid touching tun_get_addr_len
> or the include header in v3, keeping the patch strictly to checking the
> rejected types in TUNSETLINK.

Mostly, try to avoid changing the indentation of that otherwise untouched
basic block.

> Thanks,
> Kalpesh


