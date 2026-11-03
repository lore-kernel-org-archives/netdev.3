Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683747;
	b=Xe5SceSOyaUw7qdIXG4zXj1sAXeHpsuR7xBUMRvPeJ+Pdz3nG6yFsYHoY2OBw3mp33BQ
	 rnQQyeSrn6Km6J4W8WaXwk5r2YovJUNNQ3VC7d282ksK1l6748GvqghYeKZwTgbfjILo4
	 dL0a6uvk5SMdMfSBkaswDm+pR9i919AKoCbavm+t/Ejx+One1n+FjcR8+pLJ/itgQ0v7b
	 Wneb3sgLMs1zd2qy02Ok+LdS8Y7xu6FtLbFBQcnJRQrVjtN5kFMT5wgGtbRTa4QRTRiz8
	 f07NnlkAEtPcuXAZbN66/djYHCJjAa3YjPGC2pGYCLvBml1HR2R3s1IIcEFcobFcLTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kyA6YgN8qGDEZTh7erLhMR/RU8AaJWhDA/nGGj59ABQ=;
	b=Ndp0rXfFYg2Sp4pL5cP/WPTXUmX/tl+eksZBDMgyLBkgJmKtT3dEpCOlkMgK7jwtPEZb
	 V25xlBP3pX+hNkY7Kc1AzZLOCEG2caockKu+xoBB6VPCDqj5dZyp0vZG0VnMFK4jrMszU
	 5ocwiV6RIH8GmmCgDWglhNOYWlhDBSEYz6JqkgWfgi/IkSgw+/PZTAPzZHk46wq/7ZKHi
	 gLbPolDLGQsevJ4vxuLRv2tVFmkGoVElCiE7EWK66s4Js6hkLxNTvEV1X6M3V9uL02Uoj
	 NRlhqdESIj8mLLTmghHkjyLyKviLDb2ohSlWT9XfnCHoB0IgPAbVmypkKPcXFbAYJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1uMkMF;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E8606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9E8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1uMkMF
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9d52f684fso37931605ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793683746; x=1794288546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kyA6YgN8qGDEZTh7erLhMR/RU8AaJWhDA/nGGj59ABQ=;
        b=AV1uMkMFV8Qiumc6keDPr+j6sMXlonF9LIML0A2w/wRFHDsaQN4MpgQR0Q2qOLVcCA
         qtUaKNdOXSx6ADJiCXYU402DFtzPKLGJCIBeJXIWIPfzAxNJt7YNWZukuDllBR0d2SRn
         Cs5KTulkk3aj1OMwcBeQIWlaNS5qlwzVCurABOd+UHwq4i1mCwaq4h/KB/qm0hwuVWks
         m8Mes/yRkuWrqcPi2wyCD8loycNPtsY/vPD6yqXIORZMRQIjG7oWTaZGvapPzC0BWIIV
         E/Nqm4aAchACgSvjhIgFGzoHMZgoSHBeALckhDrrcAGZvITmAQcpt/oWOPUaBZrpWBsm
         mLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683746; x=1794288546;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kyA6YgN8qGDEZTh7erLhMR/RU8AaJWhDA/nGGj59ABQ=;
        b=EYBiiiXhLPq1C6uUyrrkjK3Tavqg6X1JUzYSeRJT3k0Qaq2K9jNyKMbw+fti7zDG0L
         sU1kqRPiGw/kSPlWbCw7j/9iQBq7vz8wDKfk9B5H1od/DiGqZIYYzQ5YLp4ORv8Aqxzo
         lzPkNzc4ScHSmMRJ0TEvuLYWwWC+MXGkW3GeKAx7KHbt4MCw5LI806obKApC8wUzN9IS
         KIP10v2TrsM3gtj/nit7EnFc3rZV9OKi5E/AUlJ6nsnH5FTY4DgVFSMzAf1bPycT2vBY
         lqVgmgbmFR5byaCoqwHqIiO8Vl6hfcBZ2TQXYkD0O8IIX0Wbo1rET4OF5KaiNK5Ce8Pa
         YfPw==
X-Gm-Message-State: APuU4Z/lVXEuScK0TMEOR/e6JvoI6LbNgAx9clkNS0T3+Gv3mL7iWq7V
	/604qB1TbJ8GKSH33Y/+zzELcPuDE5MbG+drIS4qJl1TCoIiqTHX+skE/b1QNxEYoBIman+NR1C
	0mfva7A==
X-Received: from plhq17.prod.google.com ([2002:a17:903:11d1:b0:2e9:64c:38da])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:245:b0:2eb:a1b:e9e5
 with SMTP id d9443c01a7336-2eb364e7bfdmr113562095ad.52.1793683745906; Mon, 02
 Nov 2026 21:29:05 -0800 (PST)
Date: Tue, 3 Nov 2026 05:29:05 +0000
In-Reply-To: <20261101061331.286404-4-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101061331.286404-1-jiayuan.chen@linux.dev> <20261101061331.286404-4-jiayuan.chen@linux.dev>
Message-ID: <aulxGkfJ-7V8RUZp@google.com>
Subject: Re: [PATCH net v3 3/5] ipv6: restrict mld_qrv to 255
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Thomas Gleixner <tglx@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>, 
	Gerd Rausch <gerd.rausch@oracle.com>, Oleg Nesterov <oleg@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 14:12:01 +0800, Jiayuan Chen wrote:
> net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
> into the u8 inet6_dev::mc_qrv, so 256 wraps to 0 and the first MLDv2
> Query received on the interface trips the WARN_ON() in mld_update_qrv():
> 
> 	WARN_ON(idev->mc_qrv == 0);
> 
>   WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
>   Workqueue: mld mld_query_work
>   RIP: 0010:mld_query_work+0x1fd2/0x2cb0
>   Call Trace:
>    <TASK>
>    process_one_work+0x93a/0x1b20
>    worker_thread+0x6d0/0x11d0
>    kthread+0x358/0x470
>    ret_from_fork+0x5b3/0x820
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Make the sysctl a u8 like mc_qrv and switch to proc_dou8vec_minmax(),
> which rejects anything above 255, and document it.
> 
> Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
