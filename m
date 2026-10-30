Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334178;
	b=UDHNMFaT+9aAFiGvfaZQI16Y7ijseTQIVaABOxERHFcbyhx5LkM5VbyU37kyWqJ9W/us
	 9orBnZ3r3jVMMpLHMMhPhlWqr0jOhuyvJYfPGDaQb8XKRp5uVmQNZEUbf6morziTUOulU
	 CYl2EN36e/ClDacwQOsqWe3xaNLFuXqRfRnuiLQmxdwCOmkTfzNWVmVV1BDx2QqTE81Cs
	 vnGbzs/65sSQ8JhDoYIK3F/GvxwnWAWKAr0v15zbafmszMvqoen/wpjcuby92Y5hJFm7x
	 SID6/LSprxOF0qy4a4ljDpCjMuLeUp4/qYokMRrHDjhDz3j4APoqv1B9aF+Gp64DXOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GJHR2hSEQjDA7JEPW4kRvNrUrFju1iQ8fE/qcrxDnx4=;
	b=nLpreuPvchkcSm0hq5dMxtMw6WwFve/e4y7Te/lJ5bXtd0GOp8XglX+08yBwj4t8FNg9
	 sSqZRREnFpBV9iCFskhvUsjBln0K19nHPOTVHk/9NGQRzQ0aOhnQE0aWjcEuS501OthAn
	 XTaGIlw8WBYgho8qshxRdclmDNPZzptiqP3xZDTJVATQZjGyuVdUoK3O6E/n/2JononAI
	 GdxQc78x/DcRiMWg25TgYjSPnaEcw2Lg0/Pa/v9BNKlNiuEywzT9qBm/KYOYmYXwR3I5I
	 3rqyeOSJAJNzTrK++adhuyx6156gWSQ7GZfhNQ3Fs2rA3vQ4uoo8forVrRhNkoNDicQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=bbdaf1Oz;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85300606A324
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85300606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=bbdaf1Oz
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aa9606ddadso224949eaf.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334177; x=1793938977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJHR2hSEQjDA7JEPW4kRvNrUrFju1iQ8fE/qcrxDnx4=;
        b=bbdaf1OzyfVIjziEcBKDEx0mtzA7kv0ty2w3AElpjlhAtv9H+B8D9hvQ5IpEb03FUF
         vENlSRLccwoAnqBpQ0ladWXi1X9pUyWpAKXru2rUskhWdMqnF6ZYogH+3x5BYmpH1G9A
         F9tPV/yJyNkbbToD+sX18Gtl/KplDDFziD7/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334177; x=1793938977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJHR2hSEQjDA7JEPW4kRvNrUrFju1iQ8fE/qcrxDnx4=;
        b=u8FsU/mkJlwbXhrSGhwr0Oy1zuIu+bsb709Xam3BLNVmco85w7NCbPKCMgRW731bbS
         Ys3uHyiMKYmL3b1l3TLIf0LScv/wn2h3vk3mEG0t2bNOVm+PY3zGuzffgR6prHbgrff5
         8DYqTTloR5/hMn07o8kOFpqkTdY0wOkKm6wUddF8JffnuxqtlH+2FO4Tz7v8qOxgE2mb
         lvVKcgQqVePt19ikQtr/bX2dZhw6VaWQZHULhWRfp4aYXMTHSZTEi6+OF6vh7LDoTch9
         tWy/WAqci0Yxf0KnwMna2gaII8dsI363UFIx7/1dDGBT2oCyhGc5hF/jvQMfG4y9uoUL
         9tzg==
X-Forwarded-Encrypted: i=1; AKwUvBzsTSc2Skpw4OI0wTNKK3OaFfWDWX3RCUO+/bdW6REFhQGRIgP+FASZ+RsJvpndC0WP0DCC+A8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLL73t5JVz1516q+wMox8v8H3dF1J1VuQ8ZDRyuvTC1E2a6J293
	Kq4oxa/qprp5kk9li2r6zyQSpmwPBQFkLZV3Wu4EUyaprtIEcTkkoqPBf6W1u4ZtzvU=
X-Gm-Gg: AYBFou2S/auMvn5ILGnfNZxWOgN9NiHm6IzWI/DbNF0VnAXnau6J6iSEEgpMsGmXTYm
	XJDJfjfupaN36deOnXZAFQNUH81QYTrzzIyB2UYOztOG1MuwkirTYA16t99TUp0uyyX3V75TLEB
	Dlv6+sQruvsaNkpQ/PbnEj/VHhXGobAzNKBsxhRScd5MHpaHJBWihZfYt+VHE/fOcqKLoxabFjz
	u/vO19CAtu9YbxMIZB+cm3sCSGkh7kcpCHXZ4b3joPsGRSgJmthZS+TfA18jUALv/zgFy1AylMx
	IytX2FuZ+q8VC1Fsn5i/gEM7MAsMUpknqlXXr58DzpQpR1zPIz8IbcwE5zFtBP61lD08H/Cewp2
	owkgq6z277ub9PLtm7dX8zXLXBDQk21iXxFOAGW8gyRgvHUENYhoAYe5126sSlnb3XrAaC2OpSQ
	dumezh9YBbhvi2t5LCy2TAjNYomJIOpiRGAE9wXaincjrKhn0IQZVhjSBgR/XpTO2UbHfhORQ8d
	fbSc80ccicqPmVuiDb2Ph6pin/VPEMjjodcydSzH17UICjAHhbJCfFmwP5/wKeeZPBM001W6eKu
	sJvN+duVevSb5eUGHw17TyjBAdtZfzFJw8luEmp50MrZDVCYqH4Qks7uEUERSx9/ngwYFZKzljz
	DOOCugUzPo47NZpemt2KBwfsAX1zjDw==
X-Received: by 2002:a05:6820:55d7:10b0:70a:598b:127c with SMTP id 006d021491bc7-714f29e7222mr536195eaf.45.1793334177541;
        Thu, 29 Oct 2026 21:22:57 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm1094944eaf.1.2026.10.29.21.22.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:57 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Thu, 29 Oct 2026 21:22:55 -0700
Message-ID: <20261030042255.74216-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

mptcp_pm_nl_create_listen_socket() starts the TCP listener directly
instead of going through mptcp_listen(). It consequently misses setting
SOCK_RCU_FREE on the parent MPTCP socket.

tcp_child_process() can invoke the listener's subflow_data_ready()
callback without holding the MPTCP parent lock or a reference to the
parent. An authenticated MP_JOIN racing with endpoint teardown can
therefore access the parent after its last reference has been dropped.
The ADD_ADDR error path can also close an already published listener.

Set SOCK_RCU_FREE before __inet_listen_sk() publishes the TCP listener,
matching mptcp_listen(). This protects the parent on every subsequent
close path, including a failed endpoint addition.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813235..f7396628490e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -906,6 +906,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * old status is known (TCP_CLOSE).
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	sock_set_flag(newsk, SOCK_RCU_FREE);
 	lock_sock(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
 	err = __inet_listen_sk(ssk, backlog);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
