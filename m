Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0873403F1
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159218; cv=none; b=Gk0iL10qkjiYJ7JxQAGeWdIX3c6ckx3Mq94oxES/7KiFR0CGaH9bxN/bD6tMBTIwOiuRD3eH6uwB43iz5EL+AdmUPWTT4YS+Y6mUyRvL2LBOk49segMiTt1mYvikLKPL/YX/6lhJQ8Wpux39IQ/oY+VFzTKuzNJp+IKSKuYIclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159218; c=relaxed/simple;
	bh=v2V5fnVsa5KLtIz1AyZRKlfVKI+s2yAGKM9+SZyiR6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo01cLB+7rTXYi43rHOGPuIkGefY1hH0GBJdI8hPoBPl8CgjGZeH1OB12oUJ2sJN4PfImbbiKaB+NkSTapAwM6UvIR2CZvHZxNEsneoA1rdoHteucykkrGTVqHx5E0ZDfvbro4/FgFDaDFN11LqhNLVtjsb5E2FJpQjsSAwIu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=NR/Q1CL9; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="NR/Q1CL9"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35f1f76ea84so3674365eec.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1792159215; x=1792764015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Z5Tjzw79dxuxAtPkKiR6MybscKYv3iH1kbV3jyfWto=;
        b=NR/Q1CL9Qa0Qc3V3DzWap3i8pkUCekX3fBBPqHNzB/idGNB/rq7k3zjM6/6V1/2SUT
         4n4OICp9Ih761z+VxntV1kZX5I6qB7w9yioGfGToQa2o8MAq9amDG0/YLRnLkK2g0OZU
         sHnt1v2hBZnebsX2C7PrpqwIlfBmKqU5/0sWJ/khop7JqqLfAdwU2KstI3eyMm1IE5NX
         TaRo5SF0PFMyOSpS2vRUNBFOMBYCtzIESYUWEKadoMe+XR7/ELMDv1+HDLVH2wNMevLK
         mF5p4XYmFLj6LHC541uenjUkYzn4TdJfI3fXyHRswVPYUiiGppzdG6IpOA/sFXHVxxQT
         hw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159215; x=1792764015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Z5Tjzw79dxuxAtPkKiR6MybscKYv3iH1kbV3jyfWto=;
        b=xjY+k5hbD8NDh2Yzp27/QANxIrkgJUiI3PvFDGbjFIL9NgV9tG7Vsasl+GTWXqg2Rs
         HBSyHp7LLKUwEPL3AMiGgpxHCcYpW9ZR/wVoz3L608Dns2rLCSAaAa1+beokLBcdaLbb
         BEv40u+7/pIHXhmXF3teumoEksVaIclLSGhDP5ZefKPzgJbNBbd95HOumv+iKc5fWh/m
         onjreTKC2A1YBQmWejj2Je9YzPU+u8rEHijOGM68nYzgWzPnZJNw9GxKFQQep+kNdD4t
         wpPbUwZhonjmdDYH9fkngpHjFK7etX8VQYCelqTtIkRCTlZMkEKYwgKTOH97bB9sKTPc
         kErA==
X-Gm-Message-State: AFq9FYIlj1fpDIi//iwKQH4DqAnf58+qEnJKMwxVuUE0yi73O1gtKovR
	s8V+hNwE5EhhXgXR7lmXwpGHxsM+vE1yCGa0/j8rFZfUIsRyiw6zyXTrzXTGYq0irPqLXOVVnLc
	6HUMQO0jw2GMg95EggTFrNelVSGaCiNhzQXIpsnVsCuMASSAz186ESk6pzMmHkzBev5uzn7PN
X-Gm-Gg: AYBFou1Qd74LlaHkhdd1QpJLN6mNSUr95oEkWtSmlHbNfK2C3cUDFclgWQQEUuOIwKM
	BlG+Wt1xADRwRjjwpN/IfsiKkvXHqoSQW4MWSx2p1pEU91GC8eI7Gt0Bc8Ramu3yqFkqEmTjcsf
	PmI8VPoO+S52V1n/yrb568/wL6LYXZXyHpwxAkEwljWP1g+zHz9bWNNhM+ipyc690+7Dam92TZZ
	vzvJOCmy7t1Hm4b6EW81UaiQmoYUe6ePr661pbWsgGXaBmmyrYU0DyfxlMGIe9VtvOven8xvbfd
	4qhm/57bslWPmZ3jFeY933Ce8i+Ey7bo8jXMm0Y5ne+8XTo2gB5/zdcVvj5k4prllviHhxEhC+f
	/fhJWKJsjUuVdRQPLkdjP6PlKF9+6xU+hUffVHnURI1qsnoD+T7TvHS8Id4iVIP5ckr42f1ahbV
	f5Lewl7cDtAEzDIV29GQmQ+VEz2u1jNFFQ9Sng3/XKPMOV6MoJD4L0G2u9ju0/H9fBsMd8ClrZG
	TmtHUuA+uU=
X-Received: by 2002:a05:693c:4146:10b0:35d:ddf2:e986 with SMTP id 5a478bee46e88-35dddf2eaf5mr12328335eec.11.1792159208802;
        Fri, 16 Oct 2026 07:00:08 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082b8573dsm7159141eec.25.2026.10.16.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:00:08 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Qiliang Yuan <odys.yuan@gmail.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] veth: set the real number of queues before registering the devices
Date: Fri, 16 Oct 2026 21:59:55 +0800
Message-ID: <20261016135955.714731-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com>
References: <20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 14:51:05 +0800 Qiliang Yuan wrote:
> Since commit 9d3684c24a52 ("veth: create by default nr_possible_cpus
> queues"), each veth device is allocated with one rx and one tx queue
> per possible CPU, and veth_newlink() reduces the real number of queues
> to one unless the user asked for a number.
>
> Both devices are already registered at that point, so
> netif_set_real_num_tx_queues() and netif_set_real_num_rx_queues()
> remove the sysfs objects of every extra queue that register_netdevice()
> has just created, each one emitting an add and a remove uevent, and the
> tx side also waits for an expedited RCU grace period. This happens with
> RTNL held, twice per pair, and grows with the number of possible CPUs:
> with 240 of them a veth pair emits about 1900 uevents, and udev
> processing them slows down later sysfs work such as deleting devices.
>
> Set the number of queues before registering each device. For a device
> that is not registered yet this only updates the counters, so the extra
> queues never appear in sysfs, and the error paths that undid a
> registration are no longer needed.
>
> Creating and then deleting 500 veth pairs, one ip -batch each, in a 16
> vCPU guest, median of 3 runs, per pair:
>
>                                    before      after
>   16 possible CPUs    create      1644 us     520 us
>                       delete     11822 us    9750 us
>   240 possible CPUs   create     17253 us    1339 us
>                       delete     17082 us    9941 us
>                       uevents        1918          6
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Looks fine to me. virtio-net uses this ordering too. I checked that
veth's ndo_init() leaves the real queue counts alone, and I don't see
any missing cleanup after the move.

I ran some basic veth tests under QEMU TCG; no regressions found.

Reviewed-by: Wang Zhan <wang.zhan@smartx.com>
Tested-by: Wang Zhan <wang.zhan@smartx.com>

BTW, Li RongQing also posted a net fix changing veth_init_queues(peer, tb)
to use tbp, so there may be a conflict.

https://lore.kernel.org/netdev/20261014013620.2497-1-lirongqing@baidu.com/
