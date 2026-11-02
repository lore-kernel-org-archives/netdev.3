Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587695;
	b=otkJne1VT4suZRFTwrtHIyRC3kq45250vt1HmYmInSNZjKRISBu3CBgLRyM2GA1ooOke
	 T4uM6IpXsClwojqPzw1IYVfO9Z+8HC7A7cQKYhREwxmQnkEamXewrIO7nsHxYBo2j/gB6
	 vfk0+w/1NOhpIrO4oUerLKobeiMiysVPXSZERtlbIugwLcy3mklU09YJurs4FgPCAI4I+
	 f+ezimLdkh3z0iPx5s2d3WHo6zRwJ839SsHjbIFF56W3GcxAz1VNKQiqzUEZoqq5/Iaqs
	 WZ2F44hgRfC6L7Q6y51xTqwLxzQrOyFcvnhZZqvpINA153SfqK3a5z3DWv/ZYcyHrYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
	b=zKERwk/ks0JD0lHhRutOmJJ+nl3cXrqPvSSpdolAUb6vLSVIVVBMHZhr/tgh3E1eLvSS
	 f6JFYYB0ZFFM2Nc/Lo9IJ1b7IDvSCg1aCP+yYD5Vz1k6QhguEjqvh+g+q4KFGrBUa5gp0
	 3diWF/om/pffwt7Gk2myZX1YjbKN/ukcc6/bukX+qpM21VLFSzAIr4NImiDUtxF/qt4N4
	 c72ZxDs4FYO4qKCtgcG5qsz3Z/3HbA29NXmTMVbL5YWBMN31rBLNVHcv5c18Uzm54zvmS
	 4EYC3BxBnyYlcQv5ayEOhWkgi1LrDIHlfZlIxnv0mhlwfGg5IC58wo+P/2raQaIlyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRk3+SWj;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB52606A33A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 02:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB52606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRk3+SWj
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-170135e43c7so73325c88.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 18:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587694; x=1794192494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
        b=XRk3+SWjrmFi47T+BW8eqendwPWmdwpi9KgXy9BnV+dovb2ge7vNhFjLm16xv6o6ux
         vs8KDvC4qWMFoI4VY6oH1k/UK5kSFBNZ8kW0FCRmojleyATVsyt6brflCeE3BaU1JCRA
         eocl1/Qw1fsH5888Sty4t7EL3+OAaWhRKzGUjw4fJTb86AlmQnxXn4S0e1xqRjkKuTRg
         dWgSi767xghB4fE5WjDkgi88GJeS41ivbBGy9PHocuyHpkdgh2NKpK4zko41yfl0IcFP
         SMETV76yFrDufnc7iCLlADKB6DwJvqzOnYCQ78An/4Ev/l+ZU0KoKo+GdWmEsBvuqklf
         /LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587694; x=1794192494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
        b=DN9DqQN11i75dlYRYj56NPqEZiaHVLEZ9F7710HXIixa7a5QNETa4k7DqIW2kRQfLW
         CPjycg3IieOsvQdG8Edb2LSz9sbmfXuJgoSzwK6ZScPBf4r/MYXYjrmMHHVQMLrjKxoN
         IQ9Mf63F65/w+yi5H2GiiEnBCLBtJ6cDoAUoMVhvEQrg9FWDN5tndAFS17FDYYUctYpN
         SgAV21acTRcT35gluhSo+VxX1aDd2lLuJuPtuCsgRXWIt54VpuSLeZC4S4tbq+OBG1Di
         1pv3G2d11sGEdKNdaomYwi6TS8fKR1YfG+etvk3vHFDNtynKVivHvO7mFbM79fq+eLHJ
         SOdw==
X-Forwarded-Encrypted: i=1; AKwUvBwGCOIer9T5uuK8eHqQJFupVnIynrU+i8Nw4AHhmN9XpjmkF5xgJNSQRCs++CIgiyJI0tAw0Kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZB9MbI/w1NtVbfq9E/1OqLfFGPcKUcMyhIz04GZHvaDQIK+iL
	SgvL6AtIDfyOtDDmzta0e7fFlEUPjmFCG0FdnvQjwezTLGNgeGjiad9Vbgo3uCtxmi8=
X-Gm-Gg: AYBFou2+/5ioH4nlIlJXRSLTPXPtYc0e7d52GFs9/zbz58GVtoP9YuR5SYtJr1dtnFx
	H5SgPLlvNZWVbS5UriPLfUnOVAdnelKME5bEc8BUlVKQS4taSUWg9UFTWeBatKwYmewuIyXitVx
	jqPMntmftZwOBkzGaRBNgnsc8ZO6EJF1azR3iGUUbpraIVxiP3D4LoT9Su3dfbK6Y9ASFUGGRBa
	D7bsMVKJI11bUDtxmkshDkOOf3C4pcPsFlDxoNlacxMs0AAUql/uiAoJ541nZ1XJvDyykyPVyaw
	Ez1oD1J+IIDJjFLsP9zJ1GHn5P0WBb7q7vjfBsLXT/sv//9w8yoCBUvISIwMqIQXkqPYv3zWBpF
	BM08Teo+lrhknCZJOIKzjwJEtIvbOSJhb93jzvilcd37o23zbtZDqVpEw8DZwS4EUer+hDUb9I4
	a4DJnlQWvbUH8R82HjAHztg79KBM+a3H/cQK+7AtdcLqBdTwvw6FFULEsHFK1ydvhr8Gnwy8GY6
	oi66QjpdXwS+eHoFTZ2kTbWfshmJsSll3jlilorDduunpeqfGaJef2eau4Fn+u1Sa/eWOQIT+N5
	JDGsYOgr/Cve+B6R7B6sKsR5N/k8psdDfCwX
X-Received: by 2002:a05:701b:4281:20b0:158:1ed2:cb58 with SMTP id a92af1059eb24-1ac5e6f5362mr13936565c88.39.1793587693890;
        Sun, 01 Nov 2026 18:48:13 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm29930662c88.0.2026.11.01.18.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:48:11 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: andrew@lunn.ch
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Mon,  2 Nov 2026 08:17:21 +0530
Message-ID: <20261102024721.28129-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 02, 2026 at 01:13:xx +0100, Andrew Lunn wrote:
> Did you consider the other fix? Is there a use case for setting a TUN
> interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
> EINVAL?
> 
> Andrew

Hi Andrew,

Thanks for reviewing and raising this point!

Regarding whether there is a use case for setting a TUN interface to
ARPHRD_IEEE802154:
In real hardware/subsystem usage, virtual 802.15.4 interfaces are typically
handled via mac802154_hwsim or fakelb (which properly allocate wpan_phy and
dev->ieee802154_ptr), rather than raw TUN. However, tun.c explicitly recognizes
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR in tun_get_addr_len():

	case ARPHRD_IEEE802154:
	case ARPHRD_IEEE802154_MONITOR:
		return IEEE802154_EXTENDED_ADDR_LEN;

which sets the hardware address length to IEEE802154_EXTENDED_ADDR_LEN on
TUNSETLINK for userspace network stacks/simulators (such as IoT testbeds or
custom TAP-based emulators) that expect 802.15.4 addressing.

Regarding fixing this in drivers/net/tun.c vs net/ieee802154/nl-mac.c:
We considered returning -EOPNOTSUPP / -EINVAL in TUNSETLINK, but chose to
guard nl-mac.c for the following reasons:

1. Subsystem robustness / Defense-in-depth:
   ieee802154_llsec_dump_table(), ieee802154_dump_iface(), and
   ieee802154_nl_get_dev() assumed that any netdevice in the namespace
   with dev->type == ARPHRD_IEEE802154 has valid ieee802154_ptr and
   mlme_ops. When that assumption fails, it triggers a NULL dereference
   while holding genl_mutex, leaving the mutex permanently locked and
   deadlocking generic netlink system-wide for unprivileged users.

   Other parts of the ieee802154 subsystem already make this defensive check:
   - net/ieee802154/6lowpan/core.c (lowpan_newlink):
       if (wdev->type != ARPHRD_IEEE802154 || !wdev->ieee802154_ptr)
   - net/ieee802154/socket.c:
       if (dev->type == ARPHRD_IEEE802154 && dev->ieee802154_ptr && ...)

   Guarding nl-mac.c ensures the IEEE 802.15.4 netlink handlers are safe
   regardless of how an ARPHRD_IEEE802154 device was created or modified.

2. Userspace ABI compatibility:
   TUNSETLINK has historically permitted arbitrary link types on down
   interfaces, and explicitly supports ARPHRD_IEEE802154 address lengths.
   Disallowing it in TUNSETLINK might break existing user tools or test
   frameworks that use TAP/TUN with this link type.

That said, if the consensus is that TUNSETLINK should reject
ARPHRD_IEEE802154 (or arbitrary link types that lack driver backend support),
I would be more than happy to submit a follow-up patch for tun.c as well.

Do you think we should reject it in tun.c in addition to guarding nl-mac.c,
or do you prefer restricting TUNSETLINK instead?

Thanks,
Kalpesh
