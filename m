Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44C3A4F26
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378796; cv=none; b=kgVKbv5kPL3Zb09EfHnfuHe4KpekL1WRiZlc8af2VjtB3bIEUKm4bj/eEupRr9PF+BgO4TX6MkHpUHYvH8nMUPgHMwK6MD54KuyfIWmAr066EwE0RjhVfhW5dYUwYI746Q7q5/TOqG7Ov0JMf9w/swkhhma8QXhM2uffw0K/fgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378796; c=relaxed/simple;
	bh=vr6W5zFpVz8w0VHMme/yDcx9OPftCRNIo4AFcnhZPtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar7HJIYzqipojzM3tdwB5ze9iU0TIkN/1JnybkTaQa1u7GkxmLXxJ5yz3yDG87W23l68KB6Ksq9wss8r+dofVSYTDyXjnzT1w1V0j+IlZtbs0QexhqpTOebCm8fAWmZXZRy1BOMQg+LVXpiVMum6JIjpu/vVKOBt5V0y+VZ8Zlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpD1KkVR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpD1KkVR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe89fb333so1001469f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788378786; x=1788983586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uw/w31b9K+Bo5B9bJ2pBdij1/BOB3D6uwkiUGcYBOoc=;
        b=FpD1KkVRQ6ip1P1cfhHQc+TUFKZorOz2rEkEJiN9sxbO9abeWr+Az0MR3bKe5yvYhK
         /EE/ylsBdQQNYDD1Gzc0jGRixN6E1DGHSETBJrJDRbtuVrfMiMDAkXv4WHiB8wYNuksq
         i8SlVEHcxoaB5oLHpSgTCVPLlnaVQyUZOZTF2t3hN3riC+VrcxUpeNq5zQ5i2pXf8n95
         /brTAPQtOCJyQQzoYUcpvTRMjCLzusxniEzvBg2Mlw5Fp87X8v77I8AeDBmiiLz2blUo
         Tq46VgPNvyPVrg5yJjcE+GEyPSNeZ/Cxs2wTevFXD2s/0YZWZ9PjIDvlHkuXA6xjLVVC
         +O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378786; x=1788983586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uw/w31b9K+Bo5B9bJ2pBdij1/BOB3D6uwkiUGcYBOoc=;
        b=MER4EGXAJ5oZH1RD7vBBF5K8M7QbVWhEiC4cTUQKg2YPZAohTivrY8LtnZbY128M9e
         9PlpUpXEtdS108JuhwtABm3JgZGJ4Xc1hpkFnAv8jeuVLHL8flg1gjIhtyT4TYjYNqal
         nfer+AoqjKKhAimd9S6vuL/HarRQMusDazN0CUECQNZFQUF0Ehmpi/8lMvuE1Sf+6x1k
         tdZzKS724s/u0ZGfkPhVODzlsrEbQU+2WT46I2iaytXuPlsfM4n6ULdXEIgp/efOqfdW
         Kr0zc2dqa20TfmXVzVHul9WMKlWD01VNgHPzOIzAafy2qgc07dgjAGfbGm1uYlSoBnXH
         9lww==
X-Gm-Message-State: AFuF++lk1NGKbx3Ffbyn825fE4Dof76gE9O3w5Z3DU4CLG1ywE3LM+Js
	iWajhLt70mKJbN7/1WstpjfB1IJLJ64sENgaUaQc0NPmPvBH8CSU9zgd
X-Gm-Gg: AYBFou3b4AfWhNsRMODnOY3fPNvxvZ+XIrNfimGxMh1QQz00HtA//7VV6AX+FPCZlOg
	Wv+e10K3FP3bekeGhm4lUgM6WB2AkOSFdrz1jXQqU7aK6M2lqCEf0WRrvQk5iI+vodJ2j00xzRq
	S5eJGCbA/GKeUhpFl34IoqnokxEooiya6pMiZkR0KE1eSRjjDUdEkSEl1zqFGbuDIWTSi8Hs4B8
	BLrJtIwuE4ZgePo/gRkIvLJzTRwy+Y/INOt6mb10Q1gr2tt0fKDlaoYnsdyk+yFgpSZHseS1NZk
	3K+OXfa1WBfDYmwErv5M2yiJgDvsNilKkDhGYQP2wTv0n5SKBgM7GPtz3blm8Wvv7XNmWaxqV83
	FPCd8dkTqtLZ0UBiCOjyOrtuWEyXwkpE6aDVe7T0KCQO9hPiEzLzTbTv/hCx8EB0vuyKo+vpL9e
	FjvF7r+vBE2D2CFvzL4P0MOG8hdeuGgaskMCRwbeW2Q8TDeZHsT4KRQxrd/ZvlkpQ=
X-Received: by 2002:a05:6000:701:b0:484:3600:35b2 with SMTP id ffacd0b85a97d-48488f00a25mr11965360f8f.5.1788378785721;
        Wed, 02 Sep 2026 12:53:05 -0700 (PDT)
Received: from gentoo ([45.150.111.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed30c0sm8552779f8f.24.2026.09.02.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:53:04 -0700 (PDT)
From: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	aconole@redhat.com,
	sbrivio@redhat.com,
	gnault@redhat.com,
	laikabcprice@gmail.com,
	rough.rock3059@datachamp.fr,
	stable@vger.kernel.org,
	Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error for PMTUD
Date: Wed,  2 Sep 2026 19:50:10 +0000
Message-ID: <20260902195012.265628-1-aroslavdudkov622@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>
References: <20260902190112.4126199-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 02, 2026 at 07:01:12PM +0000, Ido Schimmel wrote:
> Fix this by making sure that the ICMP error packet does not have a valid
> dst entry, thereby forcing the IP layer to perform a route lookup.

Tested on net with this patch applied:

- pmtu.sh: all 16 bridged and all 16 OVS subtests pass, both with and
  without br_netfilter loaded. Without the patch, loading br_netfilter
  makes all 16 bridged subtests fail (the reply gets delivered and exits
  with the old -w 1 failure).

- The forwarded-sender reproducer from my earlier mail goes from
  10 tx / 0 rx / no errors to 10 tx / 8 rx / +1 error, the error being
  "From 192.168.4.1 icmp_seq=1 Frag needed and DF set (mtu = 3950)" --
  the tunnel's PTB reaching the sender.

Tested-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
