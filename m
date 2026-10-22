Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660652;
	b=k09Z5zX/w1DfM2wXzfBw/WmGO4LN58VhkeRhUqW0ajUroF9NbF6pgdd1k9dpzt9m0yZ1
	 YxeNN2sJ7s77Xk6LCxQ6uyYFOIsZn0DFqx77PEh3JFOgs9kJlUecqN+V11+IDYyJAXsVZ
	 edJ31Y3qbtPh87c+r+eGb10Nxlvx//hlTRrQGklm1FdNmwTytsG1x3RTiHzMisGFefHDu
	 yrMYChdM49MLx1IiLmP3XDp4Ea7BARxKcuiN8TDTIczhtlSPNz3bC0GOLG0ugKtcKAY5+
	 gCnqajk931Iaz9O3vKNtgUYZGVmzF46FedbVqQuBIHz98OyKCuh+odp13w9bioqW55Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YrU9NXkLhPc11UNj4ze98iYIGfoVOje0QPpEBEMUH0Q=;
	b=vYQf29ti6CYXFS7dpaCbXLkBKIr/i+u6+yYAknM0SmKgvlU37CvvRwlGMG+ajt2cH/Bt
	 r9XLEzXlBcligPXlknK5nHLH2H6Wh9RXjQSzWJ3EWAPFdLHC8QCYk8O/IfJM/4FsS9Zn4
	 crelfBVsAqTY8/AfyOudgZ6BQiPkrXgHIqseP+dRY5wUWj4BmhVLshrhJ8rmdBWe3mauG
	 2QeJwvHeroiB+kD5BX5XLekmszKCvUdxBL2Yf8H1ClJQs7P5x3hqQEbI3LJledpFXv8tT
	 jbUTdnqEegTZemuVIV6DsTs8Y3rZelzyCwH4aUwLPzIPls/9patlsQ2thvbe6KSJvHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YoqQ2qEo;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C1606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YoqQ2qEo
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1517bda04a0so1765301c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660651; x=1793265451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrU9NXkLhPc11UNj4ze98iYIGfoVOje0QPpEBEMUH0Q=;
        b=YoqQ2qEoUEfKXEqbta2HMACEfMy+lta0Cv6sAawZGIhlTO61tZUOyOPCCiiMxW7Cdg
         Ew9z2G5Ob7q5DTIGNmZcPFSgoWmBbGiihn91T/Oe1rKc51mtUQFvsM7c8uEgOZKGSfw+
         0VR8xm2hETmRmDJyP6b83Im8rpVOhKB7RxnbKvg3YWAjWzZrk44jbnUk5Rf2CW2PmTy0
         ChHcvJlJXNp21zKMK29jVvbCO6IHpx9+8QlNcCkOwzRRfs/Ppb57C+QMM649U2AqgMt/
         lsg+C0ZdnybAUSjrB9QIdOt/5GNWZKvQE2Mh6ndUGnCOyNaQjOX9oZTR+pt4Hoh8b4Dw
         MtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660651; x=1793265451;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YrU9NXkLhPc11UNj4ze98iYIGfoVOje0QPpEBEMUH0Q=;
        b=ylBWmh8zbA9qs0XpeeOi9r2zN5ZdgWB/mhQGL4qfGPFfHXHva59tqgqi7G74TaUDjD
         9a8X34OUgtlPIu0VPXrmlX5rij4Hl/YYTVEuoHwvt0lBaaFWtLTs1Edh2o1eLyEnNMAa
         /0ETBnDLYfVsfpm4rRR1DISM8Je308/CJNIENap18H+mz6xVgo/GoaF+QRtq+LkIghYG
         R1h4FIjQxCcN6jeePWvc/UdTtqjDIIAIluW6BGt/iQaLyp7AEmRRGvX8YTDvFK7Q+q1J
         71hyXUbiZVrvSEMsdR6B+zOnHnhe2FfD/OSj3rMoEfwpsxYsDXjlE9wYgce6xgVvy+no
         6fbg==
X-Forwarded-Encrypted: i=1; AKwUvByOVmCkavcVWekbYW08jGI/bBEdcufJx4ZtVNBDy8D5vN0y2TLbYRBnNww5+wl/MGdlv8yPVPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdqUwwYKm1FCg5twS1fh5H2y/YEykBGyoPlPWrDxhVdXI0bvYL
	Mvu0AkO0efTf1NlsMPfK2ZSFszvQSEbHp5aT9WILdlzO79wixqr8MBMC
X-Gm-Gg: AYBFou3id/vaCzVPzZmHpeFs3CdaHYEhboe9Gr/rxGQap45tFC0rD440ESODEFnXE1i
	NvF4hLZofFnhlu81M16xk6xjtK15kjCG9hQPCV5PwKl/7EktHzQUjbenLh49EGfYlNhwjbnEKWK
	HdJhFB+hAKqjRbIVNrmGop7HkaLRbw35EyYY336p1OFIXr97vRZFgkFSmVrqyEpy9gr3EhFbd1Y
	S7acXRDYhElQ8hB+ufbO4FTAwi2Lc+kkgfEBuR00c5sOvtSPPWnz4zWFv5eckEO+B02NP4OXe1m
	3KMCJMuLGQjK/gMbMUpnrvM/HvgY1BOXLaeVKgitUuuiEZVHMbqahVHjwsrhLyV0QWMHClQhmzp
	1UsZ5sRxbm8uFu4CctwXpUOfP+q2uiw6892hovyWl1Al9NlZ85G6aIvuI3Vbkzbs4aASlDNcsGG
	n2Xp14YJSRPHw8a7j8lsrhkvQgBl8Bqzg9HEyoKRW6q4WvwOlOIYZ6imRwSXYbXTFvNI85pn4+e
	L5ntkVfU8WO1kARE0cerv/z19FrLeGQZk2kCQqLUviXC93Md6WohycWXvQo2sPKZELX0jTxfy1r
	H2OdHl43TPzuH8IMMDU=
X-Received: by 2002:a05:7023:a82:b0:149:1b5b:1f25 with SMTP id a92af1059eb24-190a4c1fa39mr5950603c88.15.1792660651419;
        Thu, 22 Oct 2026 02:17:31 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm12227509c88.23.2026.10.22.02.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:17:30 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: ipvlan: down-slave deletion leaks parent allmulti state
Date: Thu, 22 Oct 2026 02:17:25 -0700
Message-Id: <20261022091725.3652834-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

ipvlan_change_rx_flags() increments the parent netdevice's allmulti
reference for an ipvlan slave with IFF_ALLMULTI.  Unlike macvlan,
ipvlan_stop() does not release that reference and ipvlan_open() does not
reacquire it as an ownership pair.

If the slave is brought down while IFF_ALLMULTI remains set and is then
deleted, netif_close_many() skips the already-down device, so
ipvlan_stop() is never run.  ipvlan_uninit(), __ipvlan_link_delete() and
ipvlan_port_destroy() also contain no decrement.  The parent therefore
stays in all-multicast mode after every such cycle.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  Three
create/allmulti-on/down/delete cycles changed the parent's
IFLA_ALLMULTI count from 0 to 1, 2, and 3.  A later live-slave
allmulti-on/off test changed it 3 -> 4 -> 3, showing that only an
explicit off transition releases one reference.  The leaked reference
survived deletion.

The 2019 review of ipvlan multicast propagation already noted that a
dev_set_allmulti(1/-1) open/stop pair was missing.  Current source still
has the asymmetry.

A fix should pair acquisition/release in open/stop, as macvlan does, or
provide one release path that runs for deletion in both up and down
states.

Candidate BR-014 is the broader deletion-path description of the same
root cause.

The self-checking reproducer and serial log are available on request.

This was found with a multi-agent workflow; the
refcount growth was reproduced in QEMU.

Thanks,
Cheng Yongkang
