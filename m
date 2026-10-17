Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D537BE98
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200536; cv=none; b=n7vGJiAOqsAAdllylrGLeeicIr3XyJFw6CtSHav/iaUiXHpWoYtLxPzOEdjYvW6dv1Gec4XimEcz62gXJ/WEONQfy+TLr6LtY915wbamf54PZ96k2rO5ey0jrOw08mt2t4Rx8N16Z/5IflfCRSbfrteh6x1Usbq1e/PKsZUT3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200536; c=relaxed/simple;
	bh=nyPIuzYY4HX7cCgGgV60+lH4n+Qs1hMhO1xZzcbNp6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZIAsc6lzNV5d1QQ9WJoGksTgTXOkpqIfmkSF7B9cfueSia1bQK3YOv5OrtWSaoD4TV3FJrWPND3JvIsBz/6Ne1BW0k59LiyRNQYlUnErlapsqemb9s4AGw9zZcsezd/fFi31TrEF6iA8q1HNxGQb3pyn8hgoFU2/fuSpkJ5zAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4VCzRNE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4VCzRNE"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso271448a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200533; x=1792805333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kD74tsJicQZulq5fwatX78W1q/HZeNsaDprLwtjhhBo=;
        b=X4VCzRNE9M7D+8TJOV6Ehxcb3uCNuMXfAl+PtC899BislIcOKrTFw6CWta9PC+3TM0
         5aJrUHXJp6g15a0c7MFAueLCiShpwUKrX7nFnEPeYaSzVQkVTuf/nfK0p+4ED+xEz6wb
         89rxcGVRRye0vOcjdbvSu7NoyhJYngCIHbgBAVS5CQLWd8WJH2wgMlLI8Pzkj/43jkzo
         fp0h0HXXDoa91D8ZC81c/4Kmf/R22k9RDzAyPgtNaKlZhG2rU/B2cGSAmfeoHO2HKTfs
         1MvjjhCTDWuuGn3J2P1MYxzftlu4nakLk3+8Zg4HsjtAXfTw7wiZA9jpCx5cEv583fwa
         D5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200533; x=1792805333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kD74tsJicQZulq5fwatX78W1q/HZeNsaDprLwtjhhBo=;
        b=Fu4AWcIf5qGd8NpRTzuYHa35FqyzdHHNyXFisp4scxMfDvX/2OV816KGXDMC5H2PnQ
         cZ2b2ZUyh2WPI1r+jDPLTr0gZPvnArqjku2RbP5Hoy6aGzsSEaUaOnjFQg+dXusd3b8e
         BAEHisVVfz8dKDlXxXTH9+pJrhE6VtwJL+jD6+s7gBspgkWCKK5J4KB4SoZRnhmqxrkf
         xNpDmLEc56UHfaR3IgE/cUj8gNJbnpvWpWtV4YGnFUDdkIsg4qcsFTG6gxlRns/UucXW
         rkXJn/Wy8DRPrCa//GGj1E+R/vimrjofaHICruLQeZHmMRqwFUIqdV5LK7Duepr4EdPg
         o2nA==
X-Forwarded-Encrypted: i=1; AKwUvBxxomuVe1NJQGI6PUclIUypbOIBPBH0ZRa9Mw7mT99nyR6EVS9PBwRqXW387iTZL6B5e7bu1yo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7vo/17MwDQ4QQcM9cRkFyXtulWK3C22HjUA/7EO84AWoOsdlJ
	2ZVw82KLCDHIUll2qwWBL/UJ8qoHlUtZN3wVuwKT0+/FVoGH3Y3OjvjI
X-Gm-Gg: AYBFou3Y6jJLtZCnN52RqbyPtTxUAUyc34T38oZHH8RAQ+2dljTR7ViG2XJpWRX4EJI
	BnVIQGxTOSRi4wsItUCwdt5uGTRnWVszpoG53bErPw5JjUl6sAfXcWWI6UnDAwBU2nNy5z5ZnQH
	ltBXhcyXR1nNNF3ihbFvn5UTbu0Dn9/5aon7Yvq7af2Cfi5Tpk8wD2vQqNFc/10VNTOsMSbCLoq
	sCyeYR8ISNA7L1ZivnJClzKwRR5ow81qsTkYhZKGc8UyWLBfjY+vG+dkusFJuYbd2K3ekgJTleg
	jJydvb+yaMgqBMuho0mkm8hCD3pbIgQRT/niOt6ynn22k1NWElTj1QORbSzFn4iYyevRr5/+EGH
	Lt1UsqtjuINotJwW5hUFj/40A1BeuWf+eO3M1w37GgPJoYWUYscd63gyPPw6kJwi+n4DAAYMa7N
	GG9WpmJ6XCW7buJuRcWMQVk6Kd9Ph7T/11EkzPSVyHBcd2oo5Azz1n2l9XJPpwJHDyMbO9Bp+h/
	d3B9jqWQlgaWRymtArfqy5nKwgG97YX26+6jPe/FTHGEc2I6gv9Gp5zP/8fSpMevz3GQ4UtgxOS
	rSDD2MdeKV/xtpDd2Ey07tALEOEVG9CBuBm40evrakKDtKQhGL2R1w==
X-Received: by 2002:a17:90b:28cb:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3acee28021bmr1271220a91.9.1792200533028;
        Fri, 16 Oct 2026 18:28:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1981sm6233805a91.2.2026.10.16.18.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:28:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 20/38] bpf: Don't bind a program to a netdev that goes away
Date: Sat, 17 Oct 2026 01:24:33 +0000
Message-ID: <20261017012451.364800-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_prog_dev_bound_init() looks the device up, takes bpf_devs_lock and
registers the device for the program.  The reference it holds does not
keep the device registered.  If bpf_dev_bound_netdev_unregister() has run
by the time the lock is taken, nobody takes the program off the device any
more: the bpf_offload_netdev and offload->netdev point to a net_device
that is freed as soon as the reference is dropped.
bpf_dev_bound_resolve_kfunc() dereferences it while the program is
verified, and a new device at the same address finds the old entry.

unregister_netdevice_many_notify() leaves NETREG_REGISTERED before it
calls bpf_dev_bound_netdev_unregister(), which takes bpf_devs_lock.  Look
at reg_state under that lock, and treat a device that goes like one that
is not there.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index d855399812ee..c615ed46f629 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -250,7 +250,14 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);
 
 	down_write(&bpf_devs_lock);
-	err = __bpf_prog_dev_bound_init(prog, netdev);
+	/*
+	 * Behind bpf_dev_bound_netdev_unregister() nobody would take the
+	 * program off the device, which goes once the reference is dropped.
+	 */
+	if (READ_ONCE(netdev->reg_state) == NETREG_REGISTERED)
+		err = __bpf_prog_dev_bound_init(prog, netdev);
+	else
+		err = -EINVAL;
 	up_write(&bpf_devs_lock);
 
 out:
-- 
2.55.0

