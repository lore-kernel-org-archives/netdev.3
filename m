Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2F3DC4CE
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613257; cv=none; b=u0SsPLV0HmRaGmBnmloGDkiBaBbXg1kmPcaG1+zA/X/T+uyPpu1Zh4sbaV8VuKRfVjQnedkMmobPWyZ0C4lddsWYuZ7HBOyIJHnpImMYxFYry68vTI1za5J+7vTeymVh4avOaphKyOP+ZQFUkxgTQcxAAjXPzmPjWRQuS76bvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613257; c=relaxed/simple;
	bh=tF57zidWZwWz8hIOotoZx9jwOMzu5EtZU1vKiJE6pKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avuICXgdLIFgbhX85yuIvxmJPoYHv773Don2UcbBHbC1SYumuHwa9S4A5qAhuLitwpPMEdhj5kTNtVnhwsIcK03FQk9DZVn6kulQujuzhQ+yU/+ki68mJW3/2YJJcrfOkyHpDPPn3sTq0tY1Z38zczNAQ8tIkOtv3JQsIGczUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip0UGn9w; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip0UGn9w"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so114123a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791613256; x=1792218056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tF57zidWZwWz8hIOotoZx9jwOMzu5EtZU1vKiJE6pKY=;
        b=ip0UGn9wZfNJ0oel9b9UB18IJILq2ODa5gcehD9jE4ZEYAdW5Cf+HKemijYyuOjhuw
         wbf5T1snBXusb7qSdM4+jxAZgztX4vBVd6pRmLKFZzQMuN73p8cNN+NWAMGp9XNoH+2d
         oCkx6sG1yvVafLgl/eAbFFQWBl+lXDARS8rw3dSMlTESZjgXTghAru7q3ooXnVCkGv4l
         traJZMzH/BipOYHBSH2SNY7EX00e2dimvoLU7op4ejaRBPZoOalpxY6v0FUSiPxIAdT7
         f5FMr9Z9RRYKPJBQSaHWRyqO65zkqgszvNQdZKS6tdHvIfh8hmJJQwBi4z4MY5QWHycU
         pQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791613256; x=1792218056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tF57zidWZwWz8hIOotoZx9jwOMzu5EtZU1vKiJE6pKY=;
        b=vE9siXRA044sqK+IcV/37maI2HBIWPXNyCI5xdf5Z2FF65ANkb5R9VGSpZNnRO6Z0D
         J5si89I/KBdi/Sp368Fg2M89q19pcGsm57MmQGsGSOiKEhuUf57mTob0zKzPApBN7DWj
         mmsvx6u87Md3cbejzjxP1Vw1y16kk4y/IHNWnkRNsu8IiYz+g/uvKX+QPELRu7LnrNCJ
         JCizMZdIOJXVwuEesK/v5xyZz0oAy7Hupovo4D2pIh7Dq1wTTe1VGQRhWQOT9+yfnpqH
         E0yaqP9HAvdiMs863Tohbl6+CawxJ6LpP4v8UUTGsEF2gukWr9NUKeoOoxGNiY2ALoS2
         Nxdg==
X-Forwarded-Encrypted: i=1; AKwUvByf4dPkUIGExVu1alYyg/Z//R9L0g+aDR1iC29xQAOSMwKNiC8wD4VvX5r4Bp8rYF0XpO+MnQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkmGYDTUbd0sEg+UHDqRbTVnbyYrz58Jy5YfKOeNkImbX7DPvt
	QoXifjumA8XU3WUsCKZrxs3mF7jFWZMuQfH6UVz4hqKwObgXv9vyCrH/
X-Gm-Gg: AYBFou1iIwOUzKDrBF9+3qZa0X7Frw72tGUfZ317XFssy3Zkwom0l0J8WLK5maPsVmE
	5BFKbIPt71g7TBIaEiFggRr9g/3UsCKwkrGbGDHSLXzuZrHfRPCiF3eTssblIdr4ZvZmX9z8tkm
	+CBjfz09VO2IwgqV2ssVcVme/kQDfX9k7nFMIRRH+UiJ1jv5pxJNNSCwB1IAgKwYhYj8AMjhMBs
	Exz3dBeKWv08uBOWrJFeaaWhLfc7rsby5Hmt3V3KpzBbGsrrHtJivYMRcUuO8i0xEwa7xYaKNpd
	xN7OHvXHVQ7LzstCAoB6Vj8F4hNBYeI35bSekGiIUUBASfbIMCuz2WgfvsB29C7z2KZuwwyByce
	MqXqL19NvaEDabXr3dvzCfXmU3u20k8k1XA6B2cYN+f41yI8ArrE6k9eQBhup8k2U9lZaiRhdOk
	HnkLkueO1DwmdXybnJWszzVz01bTQStjkVQsjaDEjwhaH5RsVjiby4mDwmdmkl0yG/slb+JkXLp
	PdvX4pD9ZvjGfoEFbG3ug6rEcSYxw/5s0xoiTEkh6cpe/hG1BFtnxdy/9pQdun6os7cDIfl6esM
	hBybyfqNltRylxQvNd83C7g=
X-Received: by 2002:a17:90b:4a90:b0:3a0:d79d:b6bf with SMTP id 98e67ed59e1d1-3ab3a90e590mr2805853a91.20.1791613256121;
        Fri, 09 Oct 2026 23:20:56 -0700 (PDT)
Received: from Inspiron5409 (61-228-80-139.dynamic-ip.hinet.net. [61.228.80.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ddac6dsm6418243a91.7.2026.10.09.23.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:20:55 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	chenhuacai@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	hkallweit1@gmail.com,
	kernel@xen0n.name,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	loongarch@lists.linux.dev,
	nb@tipi-net.de,
	netdev@vger.kernel.org,
	neuromoments@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH v19 0/13] ax88179_178a: Add support for AX88179A-based chips
Date: Sat, 10 Oct 2026 14:20:47 +0800
Message-ID: <20261010062047.399148-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I tested the v19 series on my AX88179B adapter, rerunning all the
previously described tests.

The previously observed VLAN-filter failure did not reproduce, and no
carrier or RX failures were observed in the test. No confirmed driver
regressions were found in the tested scenarios.

Tested-by: Jianhui Xu <neuromoments@gmail.com>

Thanks,
Jianhui
