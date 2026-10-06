Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241A3C454F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308002; cv=none; b=CPAcNS5yJeQSKleHoVo9doXWEI3JzP9siT4V1c8f8CYebaiZDM+/5Xq7ypfGG3Ja/5fJHJ6Dh8yxbf2wMa5qvf4ckbIcJibgJVYxZrEjeCgj+TvZD4+otntBWpOalpCcpv4cDtctDiYdFVZ4NcoUsqIT/QOD8JQSvwWegWXBEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308002; c=relaxed/simple;
	bh=MmiFFcc/hGmmgsNmyCPIss+w1bmZuW3CzLVIRHyO9FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF264KIleD77b4VX5nM08neMoGlJsumnqh6HfnRLag85TsWPEW2H5wS1aAsnqJC0NB6y8+dUuYYBEJujtC/ESt8vyPoSIvPwFzl6A15BBdrzjc8oPxo8X18DzL5wQL5Cl1mhldMjYuwHEo5x7jiaqtWhJH+txM1kNM4A6fOCUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jkuvi/jN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jkuvi/jN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c02782159so694504f8f.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791307998; x=1791912798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uIWNtJTcNRJBABKoF5KtLQn3lLgfq4yyjFDpVkGxoNg=;
        b=Jkuvi/jNN3/khjCpR0qYSBMsKV+M7WTlvA+vgFThdq6hebQN6ymHO/lW94gUGJj40h
         KKPBf5axg0/rUwffLteegTPTx5T7JQawQKaQzmBPm6xdm26c92I55NgnNsh6rI9b4gI+
         Dc0M2eTWTQhfliHV+I8d9v1zFQd/Aos57FRsbs/LpqnugxlnH4J4awFQielstpOjKWlJ
         cqojJu0ApNt9SAmRKBRilS8t1tZ9hGPdNghw3QeJCga2E7Cq1YBU8jL/4D9VlLFW6nOE
         LT/rqIxV9smJd3e5As1O4OC7WIvnlO0ozpIqg2OuiM2Jr1Bm7L+lRrSss4wzL0wB+GkV
         jSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791307998; x=1791912798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uIWNtJTcNRJBABKoF5KtLQn3lLgfq4yyjFDpVkGxoNg=;
        b=eoTY8oOaHW2jFEdogwhXdUHQbLLa3UBgQRDfe4AGBZ3bczzeR0d5BrQhDGBC421jRM
         se3w5J5L0qj6SovJgYl+yyY9/m5Xn/wnEkiIudni8yVB40wy6O5CDz+ugPDgUgdKPsNH
         egVGq6lpZSgCYCBYduyLdpcy9Lx67cxA5vtOtDkGCaldjEFJtETqo+aM1w+n2VI5+X7X
         Oykbf6BgJmCOU72jwcj9RG74eAYC6d31Gf+zSZ4cz3dlOMnjcpHw7GPDvlPimdbpsFG8
         lcjkaj6nqN+AB7Cb5VR8eRnsD5H2Wbe19gna5vsINMvtRMzJS31jyc6mlj3MRYd0CFeO
         2xPQ==
X-Gm-Message-State: AFq9FYIJDtb1fsk+aVRWnH6gA0RvFbe/w3hbiJn2FKU1RMPSntMwU5fC
	76n8hhf4NYm1+3rw/JMXWopLX7W9e31KgaGft13a5nqoVRZrGum9ReYV9FaxcdBFfPFEF74UF6A
	uLy5j8Xp8Eg==
X-Gm-Gg: AYBFou3WFayEalmgDX5fV2//YayO6od2ASyMTozTHebVfnbETsAOPU9vyoEM62Kkdzm
	8kzgxhfdVXF3RYDN+YlDJQj1OE2EcqH9TqUEyCnoENKuVw25/7/FFloYYF5oR0R6qDvg1FV1yBJ
	EJToA/KQ1UaOPe9nzHqokEtUhGsazoaQ1y5eAFf24pyOM4YahMDdN3yL0oIGaVWyjhNiD8cQblR
	stmTessPDcTG8BJMdK+Bd/ZZFc7KBnWNPZ2Ftt2opxt+AxrxCtgfpoECN5N1O6XQ+b3dfqTXXuP
	1o8xcb6Fl790yUyjczX8hPTgpmZLLDd0AQExa9pRiy2ZE1vCPfwKiYzmLiCX70CF6w/SjbqfKHz
	d5eGaUBGoR1qvFqIeKPBoGwWlQsV5sMx+5xtEj+YUKe6iXu8NW2IsIg/Xi5b+yESGpGP1Pkn7V+
	OiQqrz5gyHMs3T0pwvMvZwF5jqq0+C5QcfZGGQ0gfiJvv/Opl3TbMXXI5uRmhgAwpROXx4z0N5L
	cuKz3NY9Zjy1kE=
X-Received: by 2002:a05:6000:410e:b0:48b:ef1:3101 with SMTP id ffacd0b85a97d-48c72774be0mr211419f8f.19.1791307998349;
        Tue, 06 Oct 2026 10:33:18 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:d2::15:413])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1272esm714121f8f.27.2026.10.06.10.33.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 10:33:17 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 1/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
Date: Tue,  6 Oct 2026 18:32:36 +0100
Message-ID: <20261006173241.65945-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006173241.65945-1-tianyi@cloudflare.com>
References: <20261006173241.65945-1-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A veth device advertises NETDEV_XDP_ACT_NDO_XMIT only if its peer has an
XDP program attached or GRO enabled, that is, only if the peer will have
NAPI to receive the frames.

veth_set_features() updates the peer's flag when GRO is toggled, but
returns early if the device is down, and veth_open() only refreshes the
flags of the device being opened. Toggling GRO while the device is down
therefore leaves the peer's flag stale after the device comes up.

If GRO was enabled while down, the device comes up with NAPI but the
peer does not advertise NDO_XMIT, and devmap rejects redirects to the
peer with -EOPNOTSUPP. If GRO was disabled while down, the device comes
up without NAPI but the peer still advertises NDO_XMIT, so redirects are
accepted and then dropped in veth_xdp_xmit() with -ENXIO.

Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
device") made veth_open() refresh the device's own flags. Refresh the
peer's flags there too. The peer's flag depends on this device's XDP
program and GRO setting, not on whether the peer is up, so it is
correct to set it even if the peer is down.

Fixes: 8267fc71abb2 ("veth: take into account peer device for NETDEV_XDP_ACT_NDO_XMIT xdp_features flag")
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 71227d0389aa..643b97dc5245 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1415,6 +1415,7 @@ static int veth_open(struct net_device *dev)
 	}
 
 	veth_set_xdp_features(dev);
+	veth_set_xdp_features(peer);
 
 	return 0;
 }
-- 
2.55.0

