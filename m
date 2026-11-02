Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603501;
	b=rC1A1EOdN/tkcoad/D5JcuyXGxhmm9D43SzHWoSYU9WJSZ+Sr+rF6gwU+IegBn0BE7oP
	 yhxjJP6hfMvZDM6R36qqkqO0K97KcdSc5vMQe3N2RyQOMDbwzob2jraleA55Tsix5UUFb
	 GDfnZB2QTyReAywkdU2DpTb4ADXrHZIjSkcEyF/2Vc1v69lNJSsM1F0Kk37b2Ikjy3kUi
	 v9b8Kd8NwB0oLZ4ioQI28cbNd1k4C7UaD1vP4y7mwE0nlZp9SzrsRGCc079WFPKEh9LJc
	 tglnGVedA/qCIqzWZ32ESLNYNqaMY3QNJiHwCKr6VoGPHcegstxTcRYIaIKxWK6Wfzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cjMrlf73d/dR/H5YIZ+t5tvJwic85OyZY/jSmLYQsrw=;
	b=D+eJHlhHtlsf/qDZfdLrg7eZfVfDXeQgu164A3rJ029K2P/5nom7fgQr/cI2mTr/3MjE
	 gzRem+Y5AnK0sIsb+/3adF5ySDtqn8IW4D9H+PnsS4jdy4a065tjylSloluHNVLHZxRib
	 8/Cj5XW7ov3E6xOJk0/Twj1xCEjVgJLKwnL/jrSvbboV2plW8Txv9k22dmvSH82mYfM5s
	 qtPrrXcjzJRMiW1IJifihNlf3W6aho+Id14HjTMtHtov97CSR16KafOXnn+VuGa4pw0GF
	 aBnidFLzCIyWJF54oZfveomQ5H1oqqmnFpH2DFWlnzggtkP6lXadhppzjzNZHA2Yl1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWzOTL7v;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D9606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926D9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWzOTL7v
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-89d6bd67045so1230936b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793603500; x=1794208300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjMrlf73d/dR/H5YIZ+t5tvJwic85OyZY/jSmLYQsrw=;
        b=hWzOTL7vworSJYm4WD+vsFzEKX6ZeHfXWzTOPU0GloELBoLtRif46ODKrye77naSMt
         DUujgg9udXIvhMynOvlSu37TWaGRSYZMaA9Zr7H6FK7gHaln+512j22VOgfztKadEyDj
         3YSAaOuAFs1snDBj/1IQL5bQR3qx36kPvVm3PGUpzXAnenc2ppUvaaMSLo7StnDrVdSa
         xkIVehYfmCAnpbA5yo9L/bTS5cQBc7QmZpEk4bh5l13sLqYi1va8T9vQ97N5heEqfQ5+
         Zu0sPiZefFK+fV/2Io3noHM5mkeEWdLpOPANjghXUZjqFpiLpT2vk2FHjIpRgzM3rZa/
         qPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793603500; x=1794208300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjMrlf73d/dR/H5YIZ+t5tvJwic85OyZY/jSmLYQsrw=;
        b=UOQv04qvc/rjCDH6Q2aDeVnZFJ8yr4cPRZFEAxM11JYQ1i9nzKMLMp0YOlQ8Bs4IFN
         1cCXu3ZAYsMh/1mxRnDvjEA6GNhSNkavl55o1jY74xuF0hnDG3GlvQreWCLCfSE/byjA
         Ta9UpI1R12q8bDO4Q56eNOCy6fFwr0CAz3inZ/xI9sQU9MZogFLOLiiXao35mlcZpmcx
         s0zLnR2JjqSDgpjc8VNQMax5RmoP2M9bKICmCOvOtrlWAW8aJySw9yfM9coHiW+DF+Zu
         dUMWiyoN/tgMPGyqvzSDWhYZhEThM8HhlQFCA2SeYPRouDHuxgGRSvDmQJbCrWDBIXjT
         t9CA==
X-Gm-Message-State: AFq9FYLg8PkWcRQ+JpXFiiSr/IU9McDUT7dSs2E/1Cy8N8uJazo/1h57
	F6c0uQ7lqkUQFy0HkEun0E+5Up7KyJgWMBprwlAmJpQQmJWxp/yxMdlKWE2xWkSY
X-Gm-Gg: AYBFou0rnP5pJhqJ/7C4BZg7k9S4mjCVliN98wpVw99cl6aPhe1gE17OfyYM/2PIqzE
	v7FiaJ9Q8uQAlmbve+wM/WFPcZa+qio2e+PhmP3+sKCFjYSogqW8l+M70PUXeoE3pMV0W1SeXKV
	AT4KCIOHt6hENGvTwY+4O5hsqRTv2wyO64ns/PUfMQ1YeilqQ85jSwiRoA2fBXajNDkntJFYIK4
	qZZeQPmxUW/a0DdquRSdZjkMSAK3qFPY154ooW3LWHxpKUYTfixoBXr/XbIFilXAiyUszzkoF8k
	qTwnKzke5UtZ/H/tfabmYmZyVo1rUWzbpvs3O5e13lg9ZCJTvkZv21mcLqO7n4TbF4FuAjq+Aok
	rXJArBPMEMDvZ0I2AfBWL3PFeFvXaE4CxleHP78laorDiZBlztLqNxEHEPSrjgzBckd3TVQdvuB
	ZenO+U44l0Ox/Vr/5mHC6KHkZ2l9vr6ROm4xCq4N/n6rs1awU6aLOjpzRjpGRXCgOtn8EIl5SjJ
	FcibQo8vESUl1xfn9rlLpNzM6kg1yE8d4TqM/tC3RvaXTlWI+9CGMgiMDNpz8adR8a6DESRRgUk
	8vYeP4f6DCYq05rXVri5c9lg6atpnS8m7gs6uMv7Hpsgbs5aOOaM
X-Received: by 2002:a05:6a00:3988:b0:8a0:582c:5c09 with SMTP id d2e1a72fcca58-8a8322ac827mr8145182b3a.25.1793603499839;
        Sun, 01 Nov 2026 23:11:39 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8abab0c6c6esm1140566b3a.48.2026.11.01.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:11:39 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] net: dsa: motorcomm: ACL fixup
Date: Mon,  2 Nov 2026 15:11:12 +0800
Message-ID: <20261102071119.3435180-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Various ACL defects. Found by LLM and manually verified (on YT9215).

David Yang (4):
  net: dsa: motorcomm: Fix extack message on unsupported TC actions
  net: dsa: motorcomm: Fix IPv4/IPv6 address key dispatch in flower
  net: dsa: motorcomm: Stop at the first terminal flower action
  net: dsa: motorcomm: Delete the ACL rule of the port being unbound

 drivers/net/dsa/motorcomm/tc.c | 87 ++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 42 deletions(-)

-- 
2.53.0

